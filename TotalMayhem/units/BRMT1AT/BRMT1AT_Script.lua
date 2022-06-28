#****************************************************************************
#**
#**  File     :  /cdimage/units/UEL0201/UEL0201_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  BRN Tiger Light Tank
#**
#**  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local CWeapons = import('/lua/cybranweapons.lua')
local WeaponsFile = import('/lua/terranweapons.lua')
local CDFHeavyDisintegratorWeapon = CWeapons.CDFHeavyDisintegratorWeapon
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local TDFMachineGunWeapon = WeaponsFile.TDFMachineGunWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TMEffectTemplate = import('/mods/TotalMayhem/lua/TMEffectTemplates.lua')
local EffectUtils = import('/lua/effectutilities.lua')
local WeaponsFileAutoAttack = import('/lua/terranweapons.lua')
local AutoAttackWeapon = WeaponsFileAutoAttack.TDFLandGaussCannonWeapon
local TIFCommanderDeathWeapon = WeaponsFile.TIFCommanderDeathWeapon

BRMT1AT = Class(TLandUnit) {
    Weapons = {
        MainGun = Class(CDFHeavyDisintegratorWeapon) {
			            FxMuzzleFlashScale = 0.4, 
        },
        Rocket = Class(TDFGaussCannonWeapon) {
			            FxMuzzleFlashScale = 0.0, 
        },
        autoattack = Class(TDFGaussCannonWeapon) {
			            FxMuzzleFlashScale = 0.0, 
	},
        DeathWeapon = Class(TIFCommanderDeathWeapon) {
	},
    },
OnStopBeingBuilt = function(self,builder,layer)
        TLandUnit.OnStopBeingBuilt(self,builder,layer)
      
      if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
         self:SetWeaponEnabledByLabel('autoattack', false)
      else
         self:SetWeaponEnabledByLabel('autoattack', true)
      end      
    end,

OnKilled = function(self,builder,layer)
        TLandUnit.OnKilled(self,builder,layer)
        self:CreatTheEffectsDeath()  
    end,

CreatTheEffectsDeath = function(self)
	local army =  self:GetArmy()
	for k, v in TMEffectTemplate['CybranT1BattleTankDeath'] do
		CreateAttachedEmitter(self, 'BRMT1AT', army, v):ScaleEmitter(2.0)
	end
end,
}

TypeClass = BRMT1AT