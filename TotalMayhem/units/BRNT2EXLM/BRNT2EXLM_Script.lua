#****************************************************************************
#**
#**  File     :  /cdimage/units/UEL0201/UEL0201_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  BRN Scavenger Medium Tank
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TWalkingLandUnit = import('/lua/terranunits.lua').TWalkingLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local SWeapons = import ('/lua/seraphimweapons.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local TIFCommanderDeathWeapon = WeaponsFile.TIFCommanderDeathWeapon
local SDFSinnuntheWeapon = SWeapons.SDFSinnuntheWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtils = import('/lua/effectutilities.lua')
local TMEffectTemplate = import('/mods/TotalMayhem/lua/TMEffectTemplates.lua')

BRNT2EXLM = Class(TWalkingLandUnit) {

    Weapons = {
        autogauss3 = Class(TDFGaussCannonWeapon) {
			            FxMuzzleFlashScale = 1.05, 
	},
        autogauss2 = Class(TDFGaussCannonWeapon) {
			            FxMuzzleFlashScale = 1.05, 
	},
        autogauss1 = Class(TDFGaussCannonWeapon) {
			            FxMuzzleFlashScale = 1.05, 
	},
        biggun = Class(SDFSinnuntheWeapon) {
            FxMuzzleFlash = TMEffectTemplate.BRNT2EXLMmuzzle,
			            FxMuzzleFlashScale = 4.05, 
	},
        autoattack = Class(TDFGaussCannonWeapon) {
			            FxMuzzleFlashScale = 0.0, 
	},
        DeathWeapon = Class(TIFCommanderDeathWeapon) {
        },
        smallerguns = Class(TDFGaussCannonWeapon) {
			            FxMuzzleFlashScale = 2.2, 
            FxMuzzleFlash = EffectTemplate.OhCannonMuzzleFlash02,
	},
    },
OnStopBeingBuilt = function(self,builder,layer)
        TWalkingLandUnit.OnStopBeingBuilt(self,builder,layer)
      
      if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
         self:SetWeaponEnabledByLabel('autoattack', false)
      else
         self:SetWeaponEnabledByLabel('autoattack', true)
      end      
    end,
}

TypeClass = BRNT2EXLM