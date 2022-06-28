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
local WeaponsFile = import('/lua/cybranweapons.lua')
local WeaponsFile2 = import('/lua/terranweapons.lua')
local TMWeaponsFile = import('/mods/TotalMayhem/lua/TMAeonWeapons.lua')
local WeaponsFileAutoAttack = import('/lua/terranweapons.lua')
local AutoAttackWeapon = WeaponsFileAutoAttack.TDFLandGaussCannonWeapon
local TMCSpiderLaserweapon = TMWeaponsFile.TMCSpiderLaserweapon
local CDFHeavyMicrowaveLaserGeneratorCom = WeaponsFile.CDFHeavyMicrowaveLaserGeneratorCom
local CDFHeavyDisintegratorWeapon = WeaponsFile.CDFHeavyDisintegratorWeapon
local TIFCommanderDeathWeapon = WeaponsFile2.TIFCommanderDeathWeapon
local TDFGaussCannonWeapon = WeaponsFile2.TDFLandGaussCannonWeapon
local utilities = import('/lua/Utilities.lua')
local Entity = import('/lua/sim/Entity.lua').Entity
local EffectUtils = import('/lua/effectutilities.lua')
local Effects = import('/lua/effecttemplates.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TMEffectTemplate = import('/mods/TotalMayhem/lua/TMEffectTemplates.lua')


BRMT3EXBM = Class(CWalkingLandUnit) {

    AirEffects = {'/effects/emitters/hydrocarbon_smoke_01_emit.bp',},
    AirEffectsBones = {'AttachPoint'},
    WaterEffects = {'/effects/emitters/underwater_idle_bubbles_01_emit.bp',},
    WaterEffectsBones = {'AttachPoint'},

    Weapons = {
        main = Class(TMCSpiderLaserweapon) {
    FxMuzzleFlash = EffectTemplate.SDFExperimentalPhasonProjChargeMuzzleFlash,
			            FxMuzzleFlashScale = 1.8, 
	},
        mainredlaser1 = Class(CDFHeavyMicrowaveLaserGeneratorCom) {
	},
        rocket = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 0.1,                 
	},
        laser1 = Class(CDFHeavyDisintegratorWeapon) {},
        laser2 = Class(CDFHeavyDisintegratorWeapon) {},
        laser3 = Class(CDFHeavyDisintegratorWeapon) {},
        laser4 = Class(CDFHeavyDisintegratorWeapon) {},
        autoattack = Class(TDFGaussCannonWeapon) {
			            FxMuzzleFlashScale = 0.0, 
	},
    },
OnStopBeingBuilt = function(self,builder,layer)
        CWalkingLandUnit.OnStopBeingBuilt(self,builder,layer)
        self.Trash:Add(CreateRotator(self, 'Object01', 'z', nil, 150, 0, 0))
        self.Trash:Add(CreateRotator(self, 'Object02', 'z', nil, -150, 0, 0))
        self:CreatTheEffects()
      if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
         self:SetWeaponEnabledByLabel('autoattack', false)
      else
         self:SetWeaponEnabledByLabel('autoattack', true)
      end    
    end,

CreatTheEffects = function(self)
	local army =  self:GetArmy()
	for k, v in EffectTemplate['CT2PowerAmbient'] do
		CreateAttachedEmitter(self, 'maineff01', army, v):ScaleEmitter(1.1)
	end
	for k, v in TMEffectTemplate['BRMT3EXBMPOWEREFFECT'] do
		CreateAttachedEmitter(self, 'effect02', army, v):ScaleEmitter(2.00)
	end
	for k, v in TMEffectTemplate['BRMT3EXBMPOWEREFFECT'] do
		CreateAttachedEmitter(self, 'effect01', army, v):ScaleEmitter(2.00)
	end
	for k, v in EffectTemplate['SmokePlumeLightDensityMed01'] do
		CreateAttachedEmitter(self, 'Object32', army, v):ScaleEmitter(0.65)
	end
	for k, v in EffectTemplate['SmokePlumeLightDensityMed01'] do
		CreateAttachedEmitter(self, 'Object44', army, v):ScaleEmitter(0.65)
	end
	for k, v in EffectTemplate['SmokePlumeMedDensitySml01'] do
		CreateAttachedEmitter(self, 'effect11', army, v):ScaleEmitter(0.35)
	end
	for k, v in EffectTemplate['SmokePlumeMedDensitySml01'] do
		CreateAttachedEmitter(self, 'effect10', army, v):ScaleEmitter(0.35)
	end
	for k, v in EffectTemplate['SmokePlumeMedDensitySml01'] do
		CreateAttachedEmitter(self, 'effect09', army, v):ScaleEmitter(0.35)
	end
	for k, v in EffectTemplate['SmokePlumeMedDensitySml01'] do
		CreateAttachedEmitter(self, 'effect08', army, v):ScaleEmitter(0.35)
	end
	for k, v in EffectTemplate['SmokePlumeMedDensitySml01'] do
		CreateAttachedEmitter(self, 'effect07', army, v):ScaleEmitter(0.35)
	end
	for k, v in EffectTemplate['SmokePlumeMedDensitySml01'] do
		CreateAttachedEmitter(self, 'effect06', army, v):ScaleEmitter(0.35)
	end
	for k, v in TMEffectTemplate['BRMT3EXBMPOWEREFFECT'] do
		CreateAttachedEmitter(self, 'effect03', army, v):ScaleEmitter(2.00)
	end
	for k, v in TMEffectTemplate['BRMT3EXBMPOWEREFFECT'] do
		CreateAttachedEmitter(self, 'effect04', army, v):ScaleEmitter(2.50)
	end
	for k, v in TMEffectTemplate['BRMT3EXBMPOWEREFFECT'] do
		CreateAttachedEmitter(self, 'effect05', army, v):ScaleEmitter(3.00)
	end
	for k, v in EffectTemplate['CT2PowerAmbient'] do
		CreateAttachedEmitter(self, 'Object02', army, v):ScaleEmitter(0.4)
	end
	for k, v in EffectTemplate['DamageSparks01'] do
		CreateAttachedEmitter(self, 'effect03', army, v):ScaleEmitter(1.7)
	end
	for k, v in EffectTemplate['DamageSparks01'] do
		CreateAttachedEmitter(self, 'effect04', army, v):ScaleEmitter(1.9)
	end
	for k, v in EffectTemplate['DamageSparks01'] do
		CreateAttachedEmitter(self, 'effect05', army, v):ScaleEmitter(2.1)
	end
	for k, v in EffectTemplate['GenericTeleportCharge01'] do
		CreateAttachedEmitter(self, 'effect11', army, v):ScaleEmitter(0.3)
	end
	for k, v in EffectTemplate['GenericTeleportCharge01'] do
		CreateAttachedEmitter(self, 'effect10', army, v):ScaleEmitter(0.3)
	end
	for k, v in EffectTemplate['GenericTeleportCharge01'] do
		CreateAttachedEmitter(self, 'effect08', army, v):ScaleEmitter(0.3)
	end
	for k, v in EffectTemplate['GenericTeleportCharge01'] do
		CreateAttachedEmitter(self, 'effect09', army, v):ScaleEmitter(0.3)
	end
	for k, v in EffectTemplate['GenericTeleportCharge01'] do
		CreateAttachedEmitter(self, 'effect07', army, v):ScaleEmitter(0.3)
	end
	for k, v in EffectTemplate['GenericTeleportCharge01'] do
		CreateAttachedEmitter(self, 'effect06', army, v):ScaleEmitter(0.3)
	end
end,

OnKilled = function(self,builder,layer)
        CWalkingLandUnit.OnKilled(self,builder,layer)
        self:CreatTheEffectsDeath()  
    end,

CreatTheEffectsDeath = function(self)
	local army =  self:GetArmy()
	for k, v in TMEffectTemplate['UEFHEAVYMISSILE01'] do
		CreateAttachedEmitter(self, 'BRMT3EXBM', army, v):ScaleEmitter(3.65)
	end
	for k, v in TMEffectTemplate['CYBRANHEAVYPROTONARTILLERYHIT01'] do
		CreateAttachedEmitter(self, 'maineff01', army, v):ScaleEmitter(6.65)
	end

end,
}

TypeClass = BRMT3EXBM