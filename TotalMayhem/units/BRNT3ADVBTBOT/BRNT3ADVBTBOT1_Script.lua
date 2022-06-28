#****************************************************************************
#**
#**  File     :  /cdimage/units/UEL0201/UEL0201_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  BRN Scavenger Medium Tank
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local WeaponsFileAutoAttack = import('/lua/terranweapons.lua')
local TMEffectTemplate = import('/mods/TotalMayhem/lua/TMEffectTemplates.lua')
local AutoAttackWeapon = WeaponsFileAutoAttack.TDFLandGaussCannonWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtils = import('/lua/effectutilities.lua')
local TDFPlasmaCannonWeaponD = WeaponsFile.TDFPlasmaCannonWeapon
local TANTorpedoLandWeapon = WeaponsFile.TANTorpedoLandWeapon
local TSAMLauncher = WeaponsFile.TSAMLauncher


BRNT3ADVBTBOT = Class(CWalkingLandUnit) {

    Weapons = {
        MainGun = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 1.7,
	},
        Turret01 = Class(TANTorpedoLandWeapon) {},
        MainGun2 = Class(TDFGaussCannonWeapon) {
			            FxMuzzleFlashScale = 5.0, 
            FxMuzzleFlash = EffectTemplate.TFlakCannonMuzzleFlash01,
	},
        rocket1 = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 0.0,
	},
        autoattack = Class(TDFGaussCannonWeapon) {
			            FxMuzzleFlashScale = 0.0, 
	},





		Gatlingg = Class(TDFPlasmaCannonWeaponD) {
				IdleState = State (TDFPlasmaCannonWeaponD.IdleState) {
                Main = function(self)
                    TDFPlasmaCannonWeaponD.IdleState.Main(self)
                end,
                
                OnGotTarget = function(self)
						if not self.SpinManip01 then 
							self.SpinManip01 = CreateRotator(self.unit, 'Object18', 'z', nil, 250, 250, 250)
							self.unit.Trash:Add(self.SpinManip01)
							self.SpinManip01:SetTargetSpeed(850)
						end	
						if not self.SpinManip02 then 	
							self.SpinManip02 = CreateRotator(self.unit, 'Object17', 'z', nil, 250, 250, 250)
							self.unit.Trash:Add(self.SpinManip02)
							self.SpinManip02:SetTargetSpeed(-850)
						end	
						TDFPlasmaCannonWeaponD.OnGotTarget(self)
                end,
					OnFire = function(self)
						TDFPlasmaCannonWeaponD.IdleState.OnFire(self)
						if self.SpinManip01 then
						self.SpinManip01:SetTargetSpeed(850)
						end	
						if self.SpinManip02 then
							self.SpinManip02:SetTargetSpeed(-850)
						end
                end,                
            },
                  
            OnLostTarget = function(self)
                if self.SpinManip01 then
					self.SpinManip01:SetTargetSpeed(0)
				end	
				if self.SpinManip02 then
					self.SpinManip02:SetTargetSpeed(0)
				end

                TDFPlasmaCannonWeaponD.OnLostTarget(self)
            end,  
        },

        MissileRack01 = Class(TSAMLauncher) {},



    },

OnStopBeingBuilt = function(self,builder,layer)
        CWalkingLandUnit.OnStopBeingBuilt(self,builder,layer)
      
      if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
         self:SetWeaponEnabledByLabel('autoattack', false)
      else
         self:SetWeaponEnabledByLabel('autoattack', true)
      end      
    end,

OnKilled = function(self,builder,layer)
        CWalkingLandUnit.OnKilled(self,builder,layer)
        self:CreatTheEffectsDeath()  
    end,

CreatTheEffectsDeath = function(self)
	local army =  self:GetArmy()
	for k, v in TMEffectTemplate['UEFDeath03'] do
		CreateAttachedEmitter(self, 'Turret', army, v):ScaleEmitter(1.7)
	end
end,
}

TypeClass = BRNT3ADVBTBOT