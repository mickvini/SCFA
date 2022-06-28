#****************************************************************************
#**
#**  File     :  /cdimage/units/UEL0201/UEL0201_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  BRN Scavenger Medium Tank
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local AWeaponsFile = import('/lua/aeonweapons.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtils = import('/lua/effectutilities.lua')
local WeaponsFileAutoAttack = import('/lua/terranweapons.lua')
local AutoAttackWeapon = WeaponsFileAutoAttack.TDFLandGaussCannonWeapon
local TDFLightPlasmaCannonWeapon = WeaponsFile.TDFLightPlasmaCannonWeapon
local TSAMLauncher = WeaponsFile.TSAMLauncher
local TAMPhalanxWeapon = WeaponsFile.TAMPhalanxWeapon
local ACruiseMissileWeapon = AWeaponsFile.ACruiseMissileWeapon
local TIFCommanderDeathWeapon = WeaponsFile.TIFCommanderDeathWeapon
local TMEffectTemplate = import('/mods/TotalMayhem/lua/TMEffectTemplates.lua')

BRNT3DOOMSDAY = Class(TLandUnit) {

    Weapons = {
        rocket = Class(ACruiseMissileWeapon) {
            FxMuzzleFlash = EffectTemplate.CIFCruiseMissileLaunchSmoke,
            FxMuzzleFlashScale = 2.2,
	},
        MissileRack01 = Class(TSAMLauncher) {
	},
        DeathWeapon = Class(TIFCommanderDeathWeapon) {
        },
        trigun01 = Class(TDFGaussCannonWeapon) {
			            FxMuzzleFlashScale = 7.0, 
            FxMuzzleFlash = EffectTemplate.TFlakCannonMuzzleFlash01,
	},
        trigun02 = Class(TDFGaussCannonWeapon) {
			            FxMuzzleFlashScale = 7.0, 
            FxMuzzleFlash = EffectTemplate.TFlakCannonMuzzleFlash01,
	},
        trigun03 = Class(TDFGaussCannonWeapon) {
			            FxMuzzleFlashScale = 7.0, 
            FxMuzzleFlash = EffectTemplate.TFlakCannonMuzzleFlash01,
	},
        trigun04 = Class(TDFGaussCannonWeapon) {
			            FxMuzzleFlashScale = 7.0, 
            FxMuzzleFlash = EffectTemplate.TFlakCannonMuzzleFlash01,
	},
        sidegun01 = Class(TDFGaussCannonWeapon) {
			            FxMuzzleFlashScale = 4.0, 
            FxMuzzleFlash = EffectTemplate.TFlakCannonMuzzleFlash01,
	},
        sidegun02 = Class(TDFGaussCannonWeapon) {
			            FxMuzzleFlashScale = 4.0, 
            FxMuzzleFlash = EffectTemplate.TFlakCannonMuzzleFlash01,
	},
        sidegun03 = Class(TDFGaussCannonWeapon) {
			            FxMuzzleFlashScale = 4.0, 
            FxMuzzleFlash = EffectTemplate.TFlakCannonMuzzleFlash01,
	},
        sidegun04 = Class(TDFGaussCannonWeapon) {
			            FxMuzzleFlashScale = 4.0, 
            FxMuzzleFlash = EffectTemplate.TFlakCannonMuzzleFlash01,
	},
        sidegun05 = Class(TDFGaussCannonWeapon) {
			            FxMuzzleFlashScale = 4.0, 
            FxMuzzleFlash = EffectTemplate.TFlakCannonMuzzleFlash01,
	},
        sidegun06 = Class(TDFGaussCannonWeapon) {
			            FxMuzzleFlashScale = 4.0, 
            FxMuzzleFlash = EffectTemplate.TFlakCannonMuzzleFlash01,
	},
        sidegun07 = Class(TDFGaussCannonWeapon) {
			            FxMuzzleFlashScale = 4.0, 
            FxMuzzleFlash = EffectTemplate.TFlakCannonMuzzleFlash01,
	},
        sidegun08 = Class(TDFGaussCannonWeapon) {
			            FxMuzzleFlashScale = 4.0, 
            FxMuzzleFlash = EffectTemplate.TFlakCannonMuzzleFlash01,
	},
        autoattack = Class(TDFGaussCannonWeapon) {
			            FxMuzzleFlashScale = 0.0, 
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
	for k, v in TMEffectTemplate['UEFDeath02a'] do
		CreateAttachedEmitter(self, 'tracks01', army, v):ScaleEmitter(2.5)
	end
	for k, v in TMEffectTemplate['UEFDeath02a'] do
		CreateAttachedEmitter(self, 'tracks02', army, v):ScaleEmitter(2.5)
	end
	for k, v in TMEffectTemplate['UEFDeath02a'] do
		CreateAttachedEmitter(self, 'tracks03', army, v):ScaleEmitter(2.5)
	end
	for k, v in TMEffectTemplate['UEFDeath02a'] do
		CreateAttachedEmitter(self, 'tracks04', army, v):ScaleEmitter(2.5)
	end
	for k, v in TMEffectTemplate['UEFDeath02b'] do
		CreateAttachedEmitter(self, 'tracks05', army, v):ScaleEmitter(2.5)
	end
	for k, v in TMEffectTemplate['UEFDeath02a'] do
		CreateAttachedEmitter(self, 'tracks06', army, v):ScaleEmitter(2.5)
	end
	for k, v in TMEffectTemplate['UEFDeath02a'] do
		CreateAttachedEmitter(self, 'tracks07', army, v):ScaleEmitter(2.5)
	end
	for k, v in TMEffectTemplate['UEFDeath02a'] do
		CreateAttachedEmitter(self, 'tracks08', army, v):ScaleEmitter(2.5)
	end
	for k, v in TMEffectTemplate['UEFDeath02a'] do
		CreateAttachedEmitter(self, 'Object53', army, v):ScaleEmitter(2.5)
	end
end,
}

TypeClass = BRNT3DOOMSDAY