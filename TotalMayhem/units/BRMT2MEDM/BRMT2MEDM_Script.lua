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
local CDFElectronBolterWeapon = WeaponsFile.CDFElectronBolterWeapon
local TDFMachineGunWeapon = WeaponsFile2.TDFMachineGunWeapon
local CCannonMolecularWeapon = WeaponsFile.CCannonMolecularWeapon
local TIFCommanderDeathWeapon = WeaponsFile2.TIFCommanderDeathWeapon
local CDFProtonCannonWeapon = WeaponsFile.CDFProtonCannonWeapon
local TDFGaussCannonWeapon = WeaponsFile2.TDFLandGaussCannonWeapon
local CDFParticleCannonWeapon = WeaponsFile.CDFParticleCannonWeapon
local WeaponsFileAutoAttack = import('/lua/terranweapons.lua')
local AutoAttackWeapon = WeaponsFileAutoAttack.TDFLandGaussCannonWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TMEffectTemplate = import('/mods/TotalMayhem/lua/TMEffectTemplates.lua')
local EffectUtils = import('/lua/effectutilities.lua')


BRMT2MEDM = Class(CWalkingLandUnit) {

    Weapons = {
        autoattack = Class(TDFGaussCannonWeapon) {
			            FxMuzzleFlashScale = 0.0, 
	},
        MainGun = Class(CDFParticleCannonWeapon) {
	},
        ParticleGun1 = Class(CDFProtonCannonWeapon) {
	},
        ParticleGun2 = Class(CDFProtonCannonWeapon) {
	},
        lefthandweapon = Class(CCannonMolecularWeapon) {
            FxMuzzleFlashScale = 1.4,
	},
        righthandweapon = Class(CCannonMolecularWeapon) {
            FxMuzzleFlashScale = 1.4,
	},
        rocket1 = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 0.7,
	},
        robottalk = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 0,
	},
        rocket2 = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 0.7,
	},
        DeathWeapon = Class(TIFCommanderDeathWeapon) {
	},
    },
OnStopBeingBuilt = function(self,builder,layer)
        CWalkingLandUnit.OnStopBeingBuilt(self,builder,layer)

        self.Trash:Add(CreateRotator(self, 'Object14', 'z', nil, 690, 0, 0))
        self.Trash:Add(CreateRotator(self, 'Object13', 'z', nil, -690, 0, 0))
                    self:CreatTheEffects()

      if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
         self:SetWeaponEnabledByLabel('autoattack', false)
      else
         self:SetWeaponEnabledByLabel('autoattack', true)
      end      
    end,

OnKilled = function(self,builder,layer)
        CWalkingLandUnit.OnKilled(self,builder,layer)
        self:CreatTheEffectsDeath()  
    end,

CreatTheEffects = function(self)
	local army =  self:GetArmy()
	for k, v in TMEffectTemplate['BRMT3EXBMPOWEREFFECT'] do
		CreateAttachedEmitter(self, 'eff01', army, v):ScaleEmitter(3.10)
	end
    end,

CreatTheEffectsDeath = function(self)
	local army =  self:GetArmy()
	for k, v in TMEffectTemplate['UEFDeath02'] do
		CreateAttachedEmitter(self, 'Turret', army, v):ScaleEmitter(0.8)
	end
end,
}

TypeClass = BRMT2MEDM