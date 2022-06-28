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
local WeaponsFile2 = import('/lua/aeonweapons.lua')
local SWeapons = import ('/lua/seraphimweapons.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local TDFHeavyPlasmaCannonWeapon = WeaponsFile.TDFHeavyPlasmaGatlingCannonWeapon
local TMWeaponsFile = import('/mods/TotalMayhem/lua/TMAeonWeapons.lua')
local TMAnovacatbluelaserweapon = TMWeaponsFile.TMAnovacatbluelaserweapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TMEffectTemplate = import('/mods/TotalMayhem/lua/TMEffectTemplates.lua')
local TDFRiotWeapon = WeaponsFile.TDFRiotWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtils = import('/lua/effectutilities.lua')
local TIFCommanderDeathWeapon = WeaponsFile.TIFCommanderDeathWeapon
local ADFQuantumAutogunWeapon = WeaponsFile2.ADFQuantumAutogunWeapon
local ADFCannonOblivionWeapon = WeaponsFile2.ADFCannonOblivionWeapon
local SDFChronotronCannonWeapon = SWeapons.SDFChronotronCannonWeapon

BROT2EXBM = Class(CWalkingLandUnit) {

    Weapons = {
        rocket1 = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 0.1,
	},
        rocket2 = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 0.1,
	},
        DeathWeapon = Class(TIFCommanderDeathWeapon) {
	},
        robottalk = Class(ADFQuantumAutogunWeapon) {
            FxMuzzleFlashScale = 0,
	},
        MainGun2 = Class(SDFChronotronCannonWeapon) {
            FxMuzzleFlashScale = 3.55,
            FxMuzzleFlash = EffectTemplate.ASDisruptorCannonMuzzle01,
	},
        MainGun2a = Class(SDFChronotronCannonWeapon) {
            FxMuzzleFlashScale = 3.55,
            FxMuzzleFlash = EffectTemplate.ASDisruptorCannonMuzzle01,
	},
        MainGun3 = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 2.2,
            FxMuzzleFlash = EffectTemplate.ASerpFlash01,
	},  
        MainGun3a = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 2.2,
            FxMuzzleFlash = EffectTemplate.ASerpFlash01,
	},  
    },
OnStopBeingBuilt = function(self,builder,layer)
        CWalkingLandUnit.OnStopBeingBuilt(self,builder,layer)
      
      if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
         self:SetWeaponEnabledByLabel('robottalk', false)
      else
         self:SetWeaponEnabledByLabel('robottalk', true)
      end      
    end,
OnKilled = function(self,builder,layer)
        CWalkingLandUnit.OnKilled(self,builder,layer)
        self:CreatTheEffectsDeath()  
    end,

CreatTheEffectsDeath = function(self)
	local army =  self:GetArmy()
	for k, v in TMEffectTemplate['AeonUnitDeathRing02'] do
		CreateAttachedEmitter(self, 'BROT2EXBM', army, v):ScaleEmitter(1.00)
	end
end,
}

TypeClass = BROT2EXBM