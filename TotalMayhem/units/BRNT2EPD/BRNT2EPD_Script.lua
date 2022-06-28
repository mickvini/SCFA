#****************************************************************************
#**
#**  File     :  /cdimage/units/UEB2301/UEB2301_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  UEF Heavy Gun Tower Script
#**
#**  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit
local TDFGaussCannonWeapon = import('/lua/terranweapons.lua').TDFGaussCannonWeapon
local WeaponsFile = import('/lua/terranweapons.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtils = import('/lua/effectutilities.lua')
local TIFCommanderDeathWeapon = WeaponsFile.TIFCommanderDeathWeapon

BRNT2EPD = Class(TStructureUnit) {
    Weapons = {
        Gauss01 = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 1.5,
            FxMuzzleFlash = { 
            	'/effects/emitters/proton_artillery_muzzle_01_emit.bp',
            	'/effects/emitters/proton_artillery_muzzle_03_emit.bp',
                '/effects/emitters/cybran_artillery_muzzle_smoke_01_emit.bp',                                
            }, 
	    FxGroundEffect = EffectTemplate.ConcussionRingLrg01,
	        FxVentEffect3 = EffectTemplate.CDisruptorGroundEffect,
	        FxVentEffect = EffectTemplate.FireCloudMed01,
	        FxVentEffect4 = EffectTemplate.CDisruptorVentEffect,
	        FxVentEffect2 = EffectTemplate.WeaponSteam01,
	        FxMuzzleEffect = EffectTemplate.TPlasmaGatlingCannonMuzzleFlash,
	        FxCoolDownEffect = EffectTemplate.CDisruptorCoolDownEffect,     
	        PlayFxMuzzleSequence = function(self, muzzle)
		        local army = self.unit:GetArmy()
		        
	            for k, v in self.FxGroundEffect do
                    CreateAttachedEmitter(self.unit, 'BRNT2EPD', army, v):ScaleEmitter(2.90)
                end
	            for k, v in self.FxVentEffect3 do
                    CreateAttachedEmitter(self.unit, 'BRNT2EPD', army, v):ScaleEmitter(2.4)
                end
  	            for k, v in self.FxMuzzleEffect do
                    CreateAttachedEmitter(self.unit, 'Turret_Muzzle', army, v):ScaleEmitter(3.25)
                end
  	            for k, v in self.FxVentEffect4 do
                    CreateAttachedEmitter(self.unit, 'vent01', army, v):ScaleEmitter(1.45)
                end
  	            for k, v in self.FxVentEffect4 do
                    CreateAttachedEmitter(self.unit, 'vent02', army, v):ScaleEmitter(1.45)
                end
  	            for k, v in self.FxVentEffect2 do
                    CreateAttachedEmitter(self.unit, 'smoke01', army, v):ScaleEmitter(2.25)
                end
  	            for k, v in self.FxVentEffect2 do
                    CreateAttachedEmitter(self.unit, 'smoke02', army, v):ScaleEmitter(2.25)
                end
  	            for k, v in self.FxVentEffect2 do
                    CreateAttachedEmitter(self.unit, 'smoke03', army, v):ScaleEmitter(2.25)
                end
  	            for k, v in self.FxVentEffect2 do
                    CreateAttachedEmitter(self.unit, 'smoke04', army, v):ScaleEmitter(2.25)
                end
  	            for k, v in self.FxVentEffect2 do
                    CreateAttachedEmitter(self.unit, 'Turret_Muzzle', army, v):ScaleEmitter(2.25)
                end
            end, 
	},      
        DeathWeapon = Class(TIFCommanderDeathWeapon) {
        },
    },
}

TypeClass = BRNT2EPD