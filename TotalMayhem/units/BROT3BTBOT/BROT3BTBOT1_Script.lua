#****************************************************************************
#**
#**  File     :  /cdimage/units/UAL0401/UAL0401_script.lua
#**  Author(s):  John Comes, Gordon Duclos
#**
#**  Summary  :  Aeon Galactic Colossus Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local AWalkingLandUnit = import('/lua/aeonunits.lua').AWalkingLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local AWeapons = import('/lua/aeonweapons.lua')
local TMWeaponsFile = import('/mods/TotalMayhem/lua/TMAeonWeapons.lua')
local TMAnovacatbluelaserweapon = TMWeaponsFile.TMAnovacatbluelaserweapon
local TMAnovacatgreenlaserweapon = TMWeaponsFile.TMAnovacatgreenlaserweapon
local TIFCommanderDeathWeapon = WeaponsFile.TIFCommanderDeathWeapon
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local AAAZealotMissileWeapon = AWeapons.AAAZealotMissileWeapon
local TDFRiotWeapon = WeaponsFile.TDFRiotWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TMEffectTemplate = import('/mods/TotalMayhem/lua/TMEffectTemplates.lua')
local EffectUtils = import('/lua/effectutilities.lua')

BROT3BTBOT = Class(AWalkingLandUnit) {
    Weapons = {
        robottalk = Class(AAAZealotMissileWeapon) {
            FxMuzzleFlashScale = 0,
	},
        RightRiotgun = Class(TDFRiotWeapon) {
            FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank,
			            FxMuzzleFlashScale = 0.75, 
        },
        MainGun = Class(TDFRiotWeapon) {
            FxMuzzleFlash = EffectTemplate.AIFBallisticMortarFlash02,
			            FxMuzzleFlashScale = 2, 
        },
        Rockets = Class(TDFRiotWeapon) {
            FxMuzzleFlash = EffectTemplate.AIFBallisticMortarFlash02,
			            FxMuzzleFlashScale = 3, 
        },
        DeathWeapon = Class(TIFCommanderDeathWeapon) {
	},
    }, 
OnStopBeingBuilt = function(self,builder,layer)
        AWalkingLandUnit.OnStopBeingBuilt(self,builder,layer)
      
      if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
         self:SetWeaponEnabledByLabel('robottalk', false)
      else
         self:SetWeaponEnabledByLabel('robottalk', true)
      end      
    end,
}
TypeClass = BROT3BTBOT