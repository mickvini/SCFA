#****************************************************************************
#**
#**  File     :  /cdimage/units/UEL0201/UEL0201_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  BRN Scavenger Medium Tank
#**
#**  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local WeaponsFile2 = import('/lua/aeonweapons.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local TDFHeavyPlasmaCannonWeapon = WeaponsFile.TDFHeavyPlasmaGatlingCannonWeapon
local TMWeaponsFile = import('/mods/TotalMayhem/lua/TMAeonWeapons.lua')
local TMAnovacatbluelaserweapon = TMWeaponsFile.TMAnovacatbluelaserweapon
local TDFRiotWeapon = WeaponsFile.TDFRiotWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtils = import('/lua/effectutilities.lua')
local TIFCommanderDeathWeapon = WeaponsFile.TIFCommanderDeathWeapon
local ADFQuantumAutogunWeapon = WeaponsFile2.ADFQuantumAutogunWeapon
local ADFCannonOblivionWeapon = WeaponsFile2.ADFCannonOblivionWeapon

BROT3COUG = Class(CWalkingLandUnit) {

    Weapons = {
        DeathWeapon = Class(TIFCommanderDeathWeapon) {
	},
        rightarmweapon = Class(TMAnovacatbluelaserweapon) {
	},  
        leftarmweapon = Class(TMAnovacatbluelaserweapon) {
	},  
        robottalk = Class(ADFQuantumAutogunWeapon) {
            FxMuzzleFlashScale = 0,
	},
        minilaser1 = Class(ADFQuantumAutogunWeapon) {
	},
        minilaser2 = Class(ADFQuantumAutogunWeapon) {
	},
        aalaser = Class(ADFQuantumAutogunWeapon) {
	},
        MainGun1 = Class(TDFGaussCannonWeapon) {
     
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
}

TypeClass = BROT3COUG