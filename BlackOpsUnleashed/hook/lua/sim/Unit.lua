#****************************************************************************
#**
#**  File     :  /lua/unit.lua
#**  Author(s):  John Comes, David Tomandl, Gordon Duclos
#**
#**  Summary  : The Unit lua module
#**
#**  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local Entity = import('/lua/sim/Entity.lua').Entity
local explosion = import('/lua/defaultexplosions.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtilities = import('/lua/EffectUtilities.lua')
local Game = import('/lua/game.lua')
local utilities = import('/lua/utilities.lua')
local Shield = import('/lua/shield.lua').Shield
local UnitShield = import('/lua/shield.lua').UnitShield
local AntiArtilleryShield = import('/lua/shield.lua').AntiArtilleryShield
local Buff = import('/lua/sim/buff.lua')
local AIUtils = import('/lua/ai/aiutilities.lua')
local BlackOpsEffectTemplate = import('/mods/BlackOpsUnleashed/lua/BlackOpsEffectTemplates.lua')

local oldUnit = Unit
Unit = Class(oldUnit) {    

	OnCreate = function(self)
		oldUnit.OnCreate(self)
		self.StunEffectsBag = {}
	end,
	
	-- This thread runs constantly in the background for all units. It ensures that the cloak effect and cloak field are always in the correct state
	CloakEffectControlThread = function(self)
		if not self:IsDead() then
			local bp = self:GetBlueprint()
			if not bp.Intel.CustomCloak then
				local bpDisplay = bp.Display
				while not (self == nil or self:GetHealth() <= 0 or self:IsDead()) do
					WaitSeconds(0.2)
					self:UpdateCloakEffect()
					local CloakFieldIsActive = self:IsIntelEnabled('CloakField')
					if CloakFieldIsActive then
						local position = self:GetPosition(0)
						-- Range must be (radius - 2) because it seems GPG did that for the actual field for some reason.
						-- Anything beyond (radius - 2) is not cloaked by the cloak field
						local range = bp.Intel.CloakFieldRadius - 2
						local brain = self:GetAIBrain()
						local UnitsInRange = brain:GetUnitsAroundPoint( categories.ALLUNITS, position, range, 'Ally' )
						for num, unit in UnitsInRange do
							unit:MarkUnitAsInCloakField()
						end
					end
				end
			end
		end
	end,

	-- Fork the thread that will deactivate the cloak effect, killing any previous threads that may be running
	MarkUnitAsInCloakField = function(self)
		self.InCloakField = true
		if self.InCloakFieldThread then
			KillThread(self.InCloakFieldThread)
			self.InCloakFieldThread = nil
		end
		self.InCloakFieldThread = self:ForkThread(self.InCloakFieldWatchThread)
	end,

	-- Will deactive the cloak effect if it is not renewed by the cloak field
	InCloakFieldWatchThread = function(self)
		WaitSeconds(0.2)
		self.InCloakField = false
	end,

	-- This is the core of the entire mod. The effect is actually applied here.
	UpdateCloakEffect = function(self)
		if not self:IsDead() then
			local bp = self:GetBlueprint()
			local bpDisplay = bp.Display
			if not bp.Intel.CustomCloak then
				local cloaked = self:IsIntelEnabled('Cloak') or self.InCloakField
				if (not cloaked and self.CloakEffectEnabled) or self:GetHealth() <= 0 then
					self:SetMesh(bpDisplay.MeshBlueprint, true)
				elseif cloaked and not self.CloakEffectEnabled then
					self:SetMesh(bpDisplay.CloakMeshBlueprint , true)
					self.CloakEffectEnabled = true
				end
			end
		end
	end,

	OnStopBeingBuilt = function(self,builder,layer)
		oldUnit.OnStopBeingBuilt(self,builder,layer)
		self.EXPhaseShieldPercentage = 0
		self.EXPhaseEnabled = false
		self.EXTeleportCooldownCharge = false
		self.EXPhaseCharge = 0
		self:ForkThread(self.CloakEffectControlThread)
	end,

	-- Overridden Function:
	-- Overrode this so that there will be no doubt if the cloak effect is active or not
	SetMesh = function(self, meshBp, keepActor)
		oldUnit.SetMesh(self, meshBp, keepActor)
		self.CloakEffectEnabled = false;
	end,

	-- Overridden Function:
	-- While the CloakEffectControlThread will activate the cloak effect eventually,
	-- this method tries to provide faster a response time to intel changes
	OnIntelEnabled = function(self)
			oldUnit.OnIntelEnabled(self)
		if not self:IsDead() then
			self:UpdateCloakEffect()
		end
	end,

	-- Overridden Function:
	-- While the CloakEffectControlThread will deactivate the cloak effect eventually,
	-- this method tries to provide faster a response time to intel changes
	OnIntelDisabled = function(self)
			oldUnit.OnIntelDisabled(self)
		if not self:IsDead() then
			self:UpdateCloakEffect()
		end
	end,

    CleanupTeleportChargeEffects = function(self)
		self.TeleportCostPaid = false
		oldUnit.CleanupTeleportChargeEffects(self)
    end,

	OnTeleportUnit = function(self, teleporter, location, orientation)
		local id = self:GetEntityId()
		-- Teleport Cooldown Charge
		-- Range Check to location
		local maxRange = self:GetBlueprint().Defense.MaxTeleRange
		local myposition = self:GetPosition()
		local destRange = VDist2(location[1], location[3], myposition[1], myposition[3])
		if maxRange and destRange > maxRange then
			FloatingEntityText(id,'Destination Out Of Range')
			return
		end
		-- Teleport Interdiction Check
		for num, brain in ArmyBrains do
			local unitList = brain:GetListOfUnits(categories.ANTITELEPORT, false)
			for i, unit in unitList do
				--	if it's an ally, then we skip.
				if not IsEnemy(self:GetArmy(), unit:GetArmy()) then 
					continue
				end
				local noTeleDistance = unit:GetBlueprint().Defense.NoTeleDistance
				local atposition = unit:GetPosition()
				local selfpos = self:GetPosition()
				local targetdest = VDist2(location[1], location[3], atposition[1], atposition[3])
				local sourcecheck = VDist2(selfpos[1], selfpos[3], atposition[1], atposition[3])
				if noTeleDistance and noTeleDistance > targetdest then
					FloatingEntityText(id,'Teleport Destination Scrambled')
					return
				elseif noTeleDistance and noTeleDistance >= sourcecheck then
					FloatingEntityText(id,'Teleport Generator Scrambled')
					return
				end
			end
		end
        -- Economy Check and Drain
		local bp = self:GetBlueprint()
		local telecost = bp.Economy.TeleportBurstEnergyCost or 0
        local mybrain = self:GetAIBrain()
        local storedenergy = mybrain:GetEconomyStored('ENERGY')
		if telecost > 0 and not self.TeleportCostPaid then
			if storedenergy >= telecost then
				mybrain:TakeResource('ENERGY', telecost)
				self.TeleportCostPaid = true
			else
				FloatingEntityText(id,'Insufficient Energy For Teleportation')
				return
			end
		end
		oldUnit.OnTeleportUnit(self, teleporter, location, orientation) 
	end,

	PlayTeleportChargeEffects = function(self)
		oldUnit.PlayTeleportChargeEffects(self) 
        if not self:IsDead() and not self.EXPhaseEnabled == true then
			self.EXTeleportChargeEffects(self)
        end
	end,

	OnFailedTeleport = function(self)
		oldUnit.OnFailedTeleport(self) 
        if not self:IsDead() and not self.EXPhaseEnabled == false then   
			self.EXPhaseEnabled = false
			self.EXPhaseCharge = 0
			self.EXPhaseShieldPercentage = 0
			local bp = self:GetBlueprint()
			local bpDisplay = bp.Display
			if self.EXPhaseCharge == 0 then self:SetMesh(bpDisplay.MeshBlueprint, true) end
        end
	end,

	PlayTeleportInEffects = function(self)
		oldUnit.PlayTeleportInEffects(self) 
        if not self:IsDead() and not self.EXPhaseEnabled == false then   
			self.EXTeleportCooldownEffects(self)
        end
	end,
	
	EXTeleportChargeEffects = function(self)
        if not self:IsDead() then
			local bpe = self:GetBlueprint().Economy
			self.EXPhaseEnabled = true
			self.EXPhaseCharge = 1
			self.EXPhaseShieldPercentage = 0
			if bpe then
				local mass = bpe.BuildCostMass * (bpe.TeleportMassMod or 0.01)
				local energy = bpe.BuildCostEnergy * (bpe.TeleportEnergyMod or 0.01)
				energyCost = mass + energy
				EXTeleTime = energyCost * (bpe.TeleportTimeMod or 0.01)
				self.EXTeleTimeMod1 = (EXTeleTime * 10) * 0.2
				self.EXTeleTimeMod2 = self.EXTeleTimeMod1 * 2
				self.EXTeleTimeMod3 = (EXTeleTime * 10) - ((self.EXTeleTimeMod1 * 2) + self.EXTeleTimeMod2)
				self.EXTeleTimeMod4 = (self.EXTeleTimeMod3) - 7
				local bp = self:GetBlueprint()
				local bpDisplay = bp.Display
				if self.EXPhaseCharge == 1 then
					WaitTicks(self.EXTeleTimeMod1)
				end
				if self.EXPhaseCharge == 1 then
					self:SetMesh(bpDisplay.Phase1MeshBlueprint, true)
					self.EXPhaseShieldPercentage = 33
					WaitTicks(self.EXTeleTimeMod2)
				end
				if self.EXPhaseCharge == 1 then
					self.EXPhaseShieldPercentage = 66
					WaitTicks(self.EXTeleTimeMod1)
				end
				if self.EXPhaseCharge == 1 then
					self.EXPhaseShieldPercentage = 100
					if self.EXTeleTimeMod3 >= 7 then
						WaitTicks(self.EXTeleTimeMod4)
					end
				end
				if self.EXPhaseCharge == 1 then self:SetMesh(bpDisplay.Phase2MeshBlueprint, true) end
			end
        end
	end,

	EXTeleportCooldownEffects = function(self)
        if not self:IsDead() then
            local bp = self:GetBlueprint()
			local bpDisplay = bp.Display
			self.EXPhaseCharge = 0
			if self.EXPhaseCharge == 0 then
				self.EXPhaseShieldPercentage = 100
				WaitTicks(5)
			end
			if self.EXPhaseCharge == 0 then
				self.EXPhaseShieldPercentage = 100
				self:SetMesh(bpDisplay.Phase1MeshBlueprint, true)
				WaitTicks(8)
			end
			if self.EXPhaseCharge == 0 then
				self.EXPhaseShieldPercentage = 75
				self:SetMesh(bpDisplay.Phase1MeshBlueprint, true)
				WaitTicks(25)
			end
			if self.EXPhaseCharge == 0 then
				self.EXPhaseShieldPercentage = 50
				self:SetMesh(bpDisplay.MeshBlueprint, true)
				WaitTicks(10)
				self.EXPhaseShieldPercentage = 0
				self.EXPhaseEnabled = false
			end
        end
	end,

    OnCollisionCheck = function(self, other, firingWeapon)
		if self.DisallowCollisions then
			return false
		end
		--Run a modified CollideFriendly check first that allows for allied passthrough
		if EntityCategoryContains(categories.PROJECTILE, other) then
			if not self:GetShouldCollide( other:GetCollideFriendly(), self:GetArmy(), other:GetArmy() ) then
				return false
			end
		end
		if other.lastimpact and other.lastimpact == self:GetEntityId() then
			return false
		end 
        if not self:IsDead() and self.EXPhaseEnabled == true then
            if EntityCategoryContains(categories.PROJECTILE, other) then 
                local random = Random(1,100)
                -- Allows % of projectiles to pass
                if random <= self.EXPhaseShieldPercentage then   
                    -- Returning false allows the projectile to pass thru
                    return false       
                else
                    -- Projectile impacts normally
                    return true 
                end
            end
        end
		return oldUnit.OnCollisionCheck(self, other, firingWeapon) 
    end,  

	OnCollisionCheckWeapon = function(self, firingWeapon)
		if self.DisallowCollisions then
			return false
		end
		--Run a modified CollideFriendly check first that allows for allied passthrough
		if not self:GetShouldCollide( firingWeapon:GetBlueprint().CollideFriendly, self:GetArmy(), firingWeapon.unit:GetArmy() ) then
			return false
		end
		return oldUnit.OnCollisionCheckWeapon(self, firingWeapon)
	end,

	GetShouldCollide = function(self, collidefriendly, army1, army2)
		if not collidefriendly then
			if army1 == army2 or IsAlly(army1, army2) then
				return false
			end
		end
		return true
	end,
	--Partially working code to add an effect to the stun buff
	
	SetStunned = function(self, time)
		oldUnit.SetStunned(self, time)
		local totalBones = self:GetBoneCount() - 1
		local army = self:GetArmy()
		
		self:ForkThread(function()
		--for k, v in BlackOpsEffectTemplate.EMPEffect do
		--	for bone = 1, totalBones do
		--		CreateAttachedEmitter(self,bone,army, v):ScaleEmitter(0.1)
		--	end
		--end
		
		if self.StunEffectsBag then
            for k, v in self.StunEffectsBag do
                v:Destroy()
            end
		    self.StunEffectsBag = {}
		end
        for k, v in BlackOpsEffectTemplate.EMPEffect do
			for bone = 1, totalBones do
				table.insert( self.StunEffectsBag, CreateAttachedEmitter( self, bone, army, v ):ScaleEmitter(0.1) )
			end
        end
		
		self:DisableIntel('Radar')				--disable intel a unit has
		self:DisableIntel('Sonar')
		self:DisableIntel('Omni')
		self:DisableIntel('RadarStealth')
		self:DisableIntel('SonarStealth')
		self:DisableIntel('RadarStealthField')
		self:DisableIntel('SonarStealthField')
		self:DisableIntel('Cloak')
		self:DisableIntel('CloakField')
		self:DisableIntel('Spoof')
		self:DisableIntel('Jammer')
		
		self:SetUnitState('building', false)	--disable building
		self:SetProductionActive(false)			--disable production
		self:SetConsumptionActive(false)		--disable consumption
		self:DisableShield()					--disable shields
		--self:OnIntelDisabled()
		
		WaitSeconds(time)						--Stun time
		
		self:SetProductionActive(true)			--enable production
		self:SetConsumptionActive(true)			--enable consumption
		self:SetUnitState('building', true) 	--enable building
		self:EnableShield()						--enable shields
		--self:OnIntelEnabled()
		
		self:EnableIntel('Radar')				--enable intel a unit has
		self:EnableIntel('Sonar')
		self:EnableIntel('Omni')
		self:EnableIntel('RadarStealth')
		self:EnableIntel('SonarStealth')
		self:EnableIntel('RadarStealthField')
		self:EnableIntel('SonarStealthField')
		self:EnableIntel('Cloak')
		self:EnableIntel('CloakField')
		self:EnableIntel('Spoof')
		self:EnableIntel('Jammer')
		
		if self.StunEffectsBag then
            for k, v in self.StunEffectsBag do
                v:Destroy()
            end
		    self.StunEffectsBag = {}
		end
		
		end)
	end
	--[[
	AddBuff = function(self, buffTable, PosEntity)
		oldUnit.AddBuff(self, buffTable, PosEntity) 
        local bt = buffTable.BuffType
		local ecobp = self:GetBlueprint().Economy

        if not bt then
            error('*ERROR: Tried to add a unit buff in unit.lua but got no buff table.  Wierd.', 1)
            return
        end
        #When adding debuffs we have to make sure that we check for permissions
        local allow = categories.ALLUNITS
        if buffTable.TargetAllow then
            allow = ParseEntityCategory(buffTable.TargetAllow)
        end
        local disallow
        if buffTable.TargetDisallow then
            disallow = ParseEntityCategory(buffTable.TargetDisallow)
        end
		
        local totalBones = self:GetBoneCount() - 1
        local army = self:GetArmy()
        
        if bt == 'STUN' then
           if buffTable.Radius and buffTable.Radius > 0 then
                #if the radius is bigger than 0 then we will use the unit as the center of the stun blast
                #and collect all targets from that point
                local targets = {}
                if PosEntity then
                    targets = utilities.GetEnemyUnitsInSphere(self, PosEntity, buffTable.Radius)
                else
                    targets = utilities.GetEnemyUnitsInSphere(self, self:GetPosition(), buffTable.Radius)
                end
                if not targets then
                    #LOG('*DEBUG: No targets in radius to buff')
                    return
                end
                for k, v in targets do
                    if EntityCategoryContains(allow, v) and (not disallow or not EntityCategoryContains(disallow, v)) then
                        v:SetStunned(buffTable.Duration or 1)
						v:ForkThread(function()
						self:SetProductionActive(false)
						WaitSeconds(buffTable.Duration or 1)
						self:SetProductionActive(true)
						end)
						--self:ForkThread(self.CreateStunEffect)
						for k, v in BlackOpsEffectTemplate.EMPEffect do
							for bone = 1, totalBones do
								CreateAttachedEmitter(self,bone,army, v):ScaleEmitter(0.1)
							end
						end
                    end
                end
            else
                #The buff will be applied to the unit only
                if EntityCategoryContains(allow, self) and (not disallow or not EntityCategoryContains(disallow, self)) then
                    self:SetStunned(buffTable.Duration or 1)
					--turn off eco production
					self:ForkThread(function()
					self:SetProductionActive(false)
					WaitSeconds(buffTable.Duration or 1)
					self:SetProductionActive(true)
					end)
					--for k, v in BlackOpsEffectTemplate.EMPEffect do
					--	for bone = 1, totalBones do
					--		CreateAttachedEmitter(self,bone,army, v):ScaleEmitter(0.1)
					--	end
					--end
                end
            end
        end
		
    end,
	]]--
	
}