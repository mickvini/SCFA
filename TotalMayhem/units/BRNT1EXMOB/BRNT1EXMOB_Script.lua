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
local WeaponsFile = import('/lua/terranweapons.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local WeaponsFileAutoAttack = import('/lua/terranweapons.lua')
local AutoAttackWeapon = WeaponsFileAutoAttack.TDFLandGaussCannonWeapon
local TSAMLauncher = WeaponsFile.TSAMLauncher
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtils = import('/lua/effectutilities.lua')
local TMEffectTemplate = import('/mods/TotalMayhem/lua/TMEffectTemplates.lua')

BRNT1EXMOB = Class(TLandUnit) {
    Weapons = {
        MainGun = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 6.5,
            FxMuzzleFlash = EffectTemplate.TPlasmaGatlingCannonMuzzleFlash,
	},
        smallgun01 = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 1.0,
	},
        smallgun02 = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 1.0,
	},
        smallgun03 = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 1.0,
	},
        smallgun04 = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 1.0,
	},
        autoattack = Class(TDFGaussCannonWeapon) {
			            FxMuzzleFlashScale = 0.0, 
	},
        MissileRack01 = Class(TSAMLauncher) {
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
	for k, v in TMEffectTemplate['UEFDeath04'] do
		CreateAttachedEmitter(self, 'BRNT1EXMOB', army, v):ScaleEmitter(2.7)
	end
end,
}

TypeClass = BRNT1EXMOB