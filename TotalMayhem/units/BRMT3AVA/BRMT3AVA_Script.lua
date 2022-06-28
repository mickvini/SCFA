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
local WeaponsFile2 = import('/lua/terranweapons.lua')
local CWeapons = import('/lua/cybranweapons.lua')
local CIFCommanderDeathWeapon = CWeapons.CIFCommanderDeathWeapon
local CDFParticleCannonWeapon = CWeapons.CDFParticleCannonWeapon
local TDFGaussCannonWeapon = WeaponsFile2.TDFLandGaussCannonWeapon
local TDFRiotWeapon = WeaponsFile2.TDFRiotWeapon
local CDFProtonCannonWeapon = CWeapons.CDFProtonCannonWeapon
local CAAMissileNaniteWeapon = CWeapons.CAAMissileNaniteWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtils = import('/lua/effectutilities.lua')
local VizMarker = import('/lua/sim/VizMarker.lua').VizMarker
local CSoothSayerAmbient = import('/lua/EffectTemplates.lua').CSoothSayerAmbient

BRMT3AVA = Class(CWalkingLandUnit) {
    SwitchAnims = true,
    IsWaiting = false,
    Weapons = {
        DeathWeapon = Class(CIFCommanderDeathWeapon) {
	},
        robottalk = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 0,
	},
        FrontCannon01 = Class(CDFProtonCannonWeapon) {
            FxMuzzleFlashScale = 0.7,
            FxMuzzleFlash = EffectTemplate.CArtilleryFlash01,
	},
        FrontCannon02 = Class(CDFProtonCannonWeapon) {
            FxMuzzleFlashScale = 0.7,
            FxMuzzleFlash = EffectTemplate.CArtilleryFlash01,
	},
        Laserww01 = Class(CDFProtonCannonWeapon) {
            FxMuzzleFlashScale = 2.1,
            FxMuzzleFlash = EffectTemplate.CElectronBolterMuzzleFlash01,
	},
        laser1w = Class(CDFParticleCannonWeapon) {
	},
        laser2w = Class(CDFParticleCannonWeapon) {
	},
        Laserwa1 = Class(CDFProtonCannonWeapon) {
	},
        Laserwa2 = Class(CDFProtonCannonWeapon) {
	},
        Laserwa3 = Class(CDFProtonCannonWeapon) {
	},
        Laserwa4 = Class(CDFProtonCannonWeapon) {
	},
        mgweapon = Class(TDFRiotWeapon) {
            FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank,
			            FxMuzzleFlashScale = 0.75, 
        },
        rocket1 = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 0,
	},
        rocket2 = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 0,
	},
        aarockets = Class(CAAMissileNaniteWeapon) {
	},
        missilebig = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 0,
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

TypeClass = BRMT3AVA