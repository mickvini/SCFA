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
local ADFCannonOblivionWeapon = AWeapons.ADFCannonOblivionWeapon
local AAAZealotMissileWeapon = AWeapons.AAAZealotMissileWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TMEffectTemplate = import('/mods/TotalMayhem/lua/TMEffectTemplates.lua')
local AANChronoTorpedoWeapon = AWeapons.AANChronoTorpedoWeapon
local EffectUtils = import('/lua/effectutilities.lua')

BROT3HADES = Class(AWalkingLandUnit) {
    Weapons = {
        laserblue = Class(TMAnovacatbluelaserweapon) {
	},
        laserblue2 = Class(TMAnovacatbluelaserweapon) {
	},
        Torpedo2 = Class(AANChronoTorpedoWeapon) {},
        MainGun = Class(TDFGaussCannonWeapon) {  
            FxMuzzleFlashScale = 3.95,
            FxMuzzleFlash = EffectTemplate.ASDisruptorCannonChargeMuzzle01,
	}, 
        MainGun2 = Class(TDFGaussCannonWeapon) {  
            FxMuzzleFlashScale = 3.95,
            FxMuzzleFlash = EffectTemplate.ASDisruptorCannonChargeMuzzle01,
	}, 
        MainGun3 = Class(ADFCannonOblivionWeapon) {  
            FxMuzzleFlashScale = 2,
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


CreatTheEffectsDeath = function(self)
	local army =  self:GetArmy()
	for k, v in EffectTemplate['SZthuthaamArtilleryHit'] do
		CreateAttachedEmitter(self, 'BROT3HADES', army, v):ScaleEmitter(6.85)
	end
	for k, v in TMEffectTemplate['AeonUnitDeathRing03'] do
		CreateAttachedEmitter(self, 'Turret', army, v):ScaleEmitter(3.25)
	end
	for k, v in TMEffectTemplate['UEFDeath01'] do
		CreateAttachedEmitter(self, 'Turret', army, v):ScaleEmitter(1.85)
	end
end,
}
TypeClass = BROT3HADES