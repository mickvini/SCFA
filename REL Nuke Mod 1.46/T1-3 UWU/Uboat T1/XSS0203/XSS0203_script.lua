#****************************************************************************
#**
#**  File     :  /units/XSS0203/XSS0203_script.lua
#**
#**  Summary  :  Seraphim Attack Sub Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local SSubUnit = import('/lua/seraphimunits.lua').SSubUnit
local SWeapons = import('/lua/seraphimweapons.lua')

local SANUallCavitationTorpedo = SWeapons.SANUallCavitationTorpedo
local SDFOhCannon = SWeapons.SDFOhCannon02
local SDFAjelluAntiTorpedoDefense = SWeapons.SDFAjelluAntiTorpedoDefense
local Buff = import('/lua/sim/Buff.lua')

local hasHEBI = false # Flag signalant Enhancement avec Heavy Electron Bolter
local hasHEBII = false
local hasHEBI = false
local hasHEBIV = false
local hasHEBV = false

XSS0203 = Class(SSubUnit) {
    DeathThreadDestructionWaitTime = 0,
    Weapons = {
        Torpedo01 = Class(SANUallCavitationTorpedo) {},
		Torpedo02 = Class(SANUallCavitationTorpedo) {},
        Cannon = Class(SDFOhCannon) {},
		Cannon02 = Class(SDFOhCannon) {},
        AntiTorpedo = Class(SDFAjelluAntiTorpedoDefense) {},
    },

    OnCreate = function(self)
		SSubUnit.OnCreate(self)
			self:HideBone('Turret01', true)  
			self.hasHEBI = false
			self.hasHEBII = false
			self.hasHEBIII = false
			self.hasHEBIV = false
			self.hasHEBV = false
    end,

    OnStopBeingBuilt = function(self,builder,layer)
        SSubUnit.OnStopBeingBuilt(self,builder,layer)
		self:SetWeaponEnabledByLabel('Torpedo01', true)
		self:SetWeaponEnabledByLabel('AntiTorpedo', true)
		self:SetWeaponEnabledByLabel('Cannon', true)
		self:SetWeaponEnabledByLabel('Torpedo02', false)
		self:SetWeaponEnabledByLabel('Cannon02', false)
		self.WeaponsEnabled = true
		self:AddUnitCallback(self.OnVeteran, 'OnVeteran') 
    end,	

	#Level#
	OnVeteran = function ( self )
        local bp = self:GetBlueprint()
		local enh = 'VeterancyI'
		local bpEnh = bp.ExpeWars_Enhancement[enh]
		--local bp = self:GetBlueprint().Enhancements[enh]
		if not bpEnh then return end
        local bpEnhEAVLevel = bpEnh.EnabledAtVeterancyLevel
		if bpEnhEAVLevel and bpEnhEAVLevel > 0 and ( self.VeteranLevel == bpEnhEAVLevel ) then
			if enh =='VeterancyI' then
				hasHEBI = true    # Signale HEB INSTALLÉ
				hasHEBII = false
				hasHEBIII = false
				hasHEBIV = false
				hasHEBV = false
                BuffBlueprint {
                    Name = 'UEFHEALTHBUFF',
                    DisplayName = 'UEFHEALTHBUFF',
                    BuffType = 'MAXHEALTH',
                    Stacks = 'REPLACE',
                    Duration = -1,
                    Affects = {
                        MaxHealth = {
                            Add = bp.NewHealth,
                            Mult = 1.10,
                        },
                        Regen = {
                            Add = bp.NewRegenRate,
                            Mult = 1,
                        },
                    },
                }
            end
			Buff.ApplyBuff(self, 'UEFHEALTHBUFF')
		end	
	##################################
        local bp = self:GetBlueprint()
		local enh = 'VeterancyII'
		local bpEnh = bp.ExpeWars_Enhancement[enh]
		if not bpEnh then return end
        local bpEnhEAVLevel = bpEnh.EnabledAtVeterancyLevel
		# ADDS MY CUSTOM ENHANCEMENT !
		if bpEnhEAVLevel and bpEnhEAVLevel > 0 and ( self.VeteranLevel == bpEnhEAVLevel ) then
			if enh =='VeterancyII' then
				local wep = self:GetWeaponByLabel('Torpedo01')  
				local wep2 = self:GetWeaponByLabel('Cannon')  
				local wep3 = self:GetWeaponByLabel('AntiTorpedo')  					
				wep:ChangeRateOfFire(bp.NewRateOfFire or 0.35)
				wep2:ChangeRateOfFire(bp.NewRateOfFireII or 1.8)
				wep3:ChangeRateOfFire(bp.NewRateOfFireIII or 0.1)
				hasHEBI = true
				hasHEBII = true    # Signale HEB INSTALLÉ
				hasHEBIII = false
				hasHEBIV = false
				hasHEBV = false
			end
		end
	##################################
        local bp = self:GetBlueprint()
		local enh = 'VeterancyIII'
		local bpEnh = bp.ExpeWars_Enhancement[enh]
		if not bpEnh then return end
        local bpEnhEAVLevel = bpEnh.EnabledAtVeterancyLevel
		# ADDS MY CUSTOM ENHANCEMENT !
		if bpEnhEAVLevel and bpEnhEAVLevel > 0 and ( self.VeteranLevel == bpEnhEAVLevel ) then
			if enh =='VeterancyIII' then
				local wep = self:GetWeaponByLabel('Torpedo02')  
				local wep2 = self:GetWeaponByLabel('Cannon02')  				
				wep:ChangeRateOfFire(bp.NewRateOfFire or 0.35)
				wep2:ChangeRateOfFire(bp.NewRateOfFireII or 1.8)
				self:SetWeaponEnabledByLabel('Torpedo02', true)
				self:SetWeaponEnabledByLabel('Cannon02', true)
				self:ShowBone('Turret01', true)
				hasHEBI = true
				hasHEBII = true    # Signale HEB INSTALLÉ
				hasHEBIII = true
				hasHEBIV = false
				hasHEBV = false
			end
		end
	##################################
        local bp = self:GetBlueprint()
		local enh = 'VeterancyIV'
		local bpEnh = bp.ExpeWars_Enhancement[enh]
		if not bpEnh then return end
        local bpEnhEAVLevel = bpEnh.EnabledAtVeterancyLevel
		# ADDS MY CUSTOM ENHANCEMENT !
		if bpEnhEAVLevel and bpEnhEAVLevel > 0 and ( self.VeteranLevel == bpEnhEAVLevel ) then
			if enh =='VeterancyIV' then
				hasHEBI = true
				hasHEBII = true    # Signale HEB INSTALLÉ
				hasHEBIII = true
				hasHEBIV = true
				hasHEBV = false
                BuffBlueprint {
                    Name = 'UEFHEALTHBUFF',
                    DisplayName = 'UEFHEALTHBUFF',
                    BuffType = 'MAXHEALTH',
                    Stacks = 'REPLACE',
                    Duration = -1,
                    Affects = {
                        MaxHealth = {
                            Add = bp.NewHealth,
                            Mult = 1.15,
                        },
                        Regen = {
                            Add = bp.NewRegenRate,
                            Mult = 1.2,
                        },
                    },
                }
            end
			Buff.ApplyBuff(self, 'UEFHEALTHBUFF')
		end	
	#####################################
        local bp = self:GetBlueprint()
		local enh = 'VeterancyV'
		local bpEnh = bp.ExpeWars_Enhancement[enh]
		if not bpEnh then return end
        local bpEnhEAVLevel = bpEnh.EnabledAtVeterancyLevel
		# ADDS MY CUSTOM ENHANCEMENT !
		if bpEnhEAVLevel and bpEnhEAVLevel > 0 and ( self.VeteranLevel == bpEnhEAVLevel ) then
			if enh =='VeterancyV' then
				local wep = self:GetWeaponByLabel('Torpedo01')
				local wep2 = self:GetWeaponByLabel('Torpedo02') 
				local wep3 = self:GetWeaponByLabel('Cannon')
				local wep4 = self:GetWeaponByLabel('Cannon02')
				local wep5 = self:GetWeaponByLabel('AntiTorpedo')
			
				wep:AddDamageMod(bpEnh.BolterIDamageMod)  
				wep:ChangeRateOfFire(bp.NewRateOfFireI or 0.45)
				
				wep2:AddDamageMod(bpEnh.BolterIIDamageMod) 
				wep2:ChangeRateOfFire(bp.NewRateOfFireII or 0.45)
				
				wep3:AddDamageMod(bpEnh.BolterIIIDamageMod) 
				wep3:ChangeRateOfFire(bp.NewRateOfFireIII or 2.0)

				wep4:AddDamageMod(bpEnh.BolterIVDamageMod) 
				wep4:ChangeRateOfFire(bp.NewRateOfFireIV or 2.0)				
				
				wep5:ChangeRateOfFire(bp.NewRateOfFireIV or 0.2)				
				
				hasHEBI = true
				hasHEBII = true    # Signale HEB INSTALLÉ
				hasHEBIII = true
				hasHEBIV = true
				hasHEBV = true
            end
		end
end,	

}
TypeClass = XSS0203