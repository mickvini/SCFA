#****************************************************************************
#**
#**  File     :  /cdimage/units/UAL0401/UAL0401_script.lua
#**  Author(s):  John Comes, Gordon Duclos
#**
#**  Summary  :  Aeon Galactic Colossus Script
#**
#**  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
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
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TMEffectTemplate = import('/mods/TotalMayhem/lua/TMEffectTemplates.lua')
local EffectUtils = import('/lua/effectutilities.lua')

BROT3NCM2 = Class(AWalkingLandUnit) {
    Weapons = {
        laserblue = Class(TMAnovacatbluelaserweapon) {
	},
        MainGun = Class(TDFGaussCannonWeapon) {  
            FxMuzzleFlashScale = 0.35,
            FxMuzzleFlash = EffectTemplate.SRifterArtilleryMuzzleFlash,
	}, 
        MainGun2 = Class(TDFGaussCannonWeapon) {  
            FxMuzzleFlashScale = 3.95,
            FxMuzzleFlash = EffectTemplate.ASDisruptorCannonChargeMuzzle01,
	}, 
        LongRangeMissiles = Class(TDFGaussCannonWeapon) {
	}, 
        AntiAirMissiles2 = Class(AAAZealotMissileWeapon) {
	},
        robottalk = Class(AAAZealotMissileWeapon) {
            FxMuzzleFlashScale = 0,
	},
        DeathWeapon = Class(TIFCommanderDeathWeapon) {
	},
    }, 
OnStopBeingBuilt = function(self,builder,layer)
        AWalkingLandUnit.OnStopBeingBuilt(self,builder,layer)
                    self:CreatTheEffects()   
      if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
         self:SetWeaponEnabledByLabel('robottalk', false)
      else

         self:SetWeaponEnabledByLabel('robottalk', true)
      end      
    end,

OnKilled = function(self,builder,layer)
        AWalkingLandUnit.OnKilled(self,builder,layer)
        self:CreatTheEffectsDeath()  
    end,

CreatTheEffects = function(self)
	local army =  self:GetArmy()
	for k, v in EffectTemplate['SDFSinnutheWeaponFXTrails01'] do
		CreateAttachedEmitter(self, 'muzzle01', army, v):ScaleEmitter(0.22)
	end
	for k, v in EffectTemplate['SDFSinnutheWeaponFXTrails01'] do
		CreateAttachedEmitter(self, 'eff02', army, v):ScaleEmitter(0.12)
	end
	for k, v in EffectTemplate['SDFSinnutheWeaponFXTrails01'] do
		CreateAttachedEmitter(self, 'eff03', army, v):ScaleEmitter(0.12)
	end
end,

CreatTheEffectsDeath = function(self)
	local army =  self:GetArmy()
	for k, v in EffectTemplate['SZthuthaamArtilleryHit'] do
		CreateAttachedEmitter(self, 'BROT3NCM2', army, v):ScaleEmitter(3.85)
	end
	for k, v in TMEffectTemplate['AeonUnitDeathRing03'] do
		CreateAttachedEmitter(self, 'Turret', army, v):ScaleEmitter(1.25)
	end
	for k, v in TMEffectTemplate['UEFDeath01'] do
		CreateAttachedEmitter(self, 'Object19', army, v):ScaleEmitter(0.85)
	end
end,
}
TypeClass = BROT3NCM2