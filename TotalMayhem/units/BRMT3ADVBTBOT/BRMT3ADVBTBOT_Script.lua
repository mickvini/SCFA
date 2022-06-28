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
local WeaponsFile = import('/lua/cybranweapons.lua')
local WeaponsFile2 = import('/lua/terranweapons.lua')
local TDFPlasmaCannonWeapon = WeaponsFile2.TDFPlasmaCannonWeapon
local TDFGaussCannonWeapon = WeaponsFile2.TDFLandGaussCannonWeapon
local EffectUtils = import('/lua/effectutilities.lua')
local Effects = import('/lua/effecttemplates.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TMEffectTemplate = import('/mods/TotalMayhem/lua/TMEffectTemplates.lua')
local WeaponsFileAutoAttack = import('/lua/terranweapons.lua')
local AutoAttackWeapon = WeaponsFileAutoAttack.TDFLandGaussCannonWeapon
local CDFParticleCannonWeapon = WeaponsFile.CDFParticleCannonWeapon

BRMT3ADVBTBOT = Class(CWalkingLandUnit) {

    Weapons = {
        MainGun = Class(CDFParticleCannonWeapon) {
	},
        gun = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 2.1,
            FxMuzzleFlash = { 
            	'/effects/emitters/proton_artillery_muzzle_01_emit.bp',
            	'/effects/emitters/proton_artillery_muzzle_03_emit.bp',
                '/effects/emitters/cybran_artillery_muzzle_smoke_01_emit.bp',                                
            }, 
	    FxGroundEffect = EffectTemplate.ConcussionRingLrg01,
	        FxVentEffect3 = EffectTemplate.CDisruptorGroundEffect,
	        FxVentEffect = EffectTemplate.CDisruptorVentEffect,
	        FxVentEffect2 = EffectTemplate.WeaponSteam01,
	        FxVentEffect4 = EffectTemplate.CHvyProtonCannonHitUnit01,
	        FxVentEffect5 = EffectTemplate.CElectronBolterMuzzleFlash01,
	        FxMuzzleEffect = EffectTemplate.TPlasmaCannonHeavyMuzzleFlash,
	        FxCoolDownEffect = EffectTemplate.CDisruptorCoolDownEffect,     
	        PlayFxMuzzleSequence = function(self, muzzle)
		        local army = self.unit:GetArmy()
		        
	            for k, v in self.FxVentEffect3 do
                    CreateAttachedEmitter(self.unit, 'BRMT3ADVBTBOT', army, v):ScaleEmitter(1.9)
                end
  	            for k, v in self.FxMuzzleEffect do
                    CreateAttachedEmitter(self.unit, 'eff04', army, v):ScaleEmitter(5.85)
                end
  	            for k, v in self.FxVentEffect2 do
                    CreateAttachedEmitter(self.unit, 'muzzle01', army, v):ScaleEmitter(1)
                end
            end, 
	},
        rocket2 = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 0.7,
	},
        autoattack = Class(TDFGaussCannonWeapon) {
			            FxMuzzleFlashScale = 0.0, 
	},
    },
OnStopBeingBuilt = function(self,builder,layer)
        CWalkingLandUnit.OnStopBeingBuilt(self,builder,layer)
        self:CreatTheEffects()
      if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
         self:SetWeaponEnabledByLabel('autoattack', false)
      else
         self:SetWeaponEnabledByLabel('autoattack', true)
      end      
    end,

CreatTheEffects = function(self)
	local army =  self:GetArmy()
	for k, v in EffectTemplate['GenericTeleportCharge01'] do
		CreateAttachedEmitter(self, 'eff01', army, v):ScaleEmitter(0.2)
	end
	for k, v in EffectTemplate['GenericTeleportCharge01'] do
		CreateAttachedEmitter(self, 'eff02', army, v):ScaleEmitter(0.25)
	end
	for k, v in EffectTemplate['GenericTeleportCharge01'] do
		CreateAttachedEmitter(self, 'eff03', army, v):ScaleEmitter(0.3)
	end
	for k, v in EffectTemplate['SDFSinnutheWeaponFXTrails01'] do
		CreateAttachedEmitter(self, 'eff04', army, v):ScaleEmitter(0.25)
	end
	for k, v in EffectTemplate['GenericTeleportCharge01'] do
		CreateAttachedEmitter(self, 'muzzle01', army, v):ScaleEmitter(0.2)
	end

	for k, v in EffectTemplate['GenericTeleportCharge01'] do
		CreateAttachedEmitter(self, 'Object42', army, v):ScaleEmitter(0.2)
	end
	for k, v in EffectTemplate['GenericTeleportCharge01'] do
		CreateAttachedEmitter(self, 'Object41', army, v):ScaleEmitter(0.2)
	end
	for k, v in EffectTemplate['GenericTeleportCharge01'] do
		CreateAttachedEmitter(self, 'Object18', army, v):ScaleEmitter(0.2)
	end
	for k, v in EffectTemplate['GenericTeleportCharge01'] do
		CreateAttachedEmitter(self, 'Object39', army, v):ScaleEmitter(0.2)
	end
	for k, v in EffectTemplate['GenericTeleportCharge01'] do
		CreateAttachedEmitter(self, 'Object28', army, v):ScaleEmitter(0.2)
	end
	for k, v in EffectTemplate['GenericTeleportCharge01'] do
		CreateAttachedEmitter(self, 'Object38', army, v):ScaleEmitter(0.2)
	end
end,

OnKilled = function(self,builder,layer)
        CWalkingLandUnit.OnKilled(self,builder,layer)
        self:CreatTheEffectsDeath()  
    end,

CreatTheEffectsDeath = function(self)
	local army =  self:GetArmy()
	for k, v in TMEffectTemplate['CybranT3AdvancedBattleBotDeath01'] do
		CreateAttachedEmitter(self, 'BRMT3ADVBTBOT', army, v):ScaleEmitter(2.3)
	end
end,
}

TypeClass = BRMT3ADVBTBOT