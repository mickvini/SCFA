#****************************************************************************
#**
#**  File     :  /units/XSLconcept/XSLconcept_script.lua
#**  Author(s):  Drew Staltman, Jessica St. Croix, Gordon Duclos
#**
#**  Summary  :  Seraphim Concept Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local SWalkingLandUnit = import('/lua/seraphimunits.lua').SWalkingLandUnit
local SeraphimWeapons = import('/lua/seraphimweapons.lua')
local WeaponsFileAutoAttack = import('/lua/terranweapons.lua')
local TMWeaponsFile = import('/mods/TotalMayhem/lua/TMAeonWeapons.lua')
local SAAOlarisCannonWeapon = SeraphimWeapons.SAAOlarisCannonWeapon
local SDFThauCannon = SeraphimWeapons.SDFThauCannon
local SDFAireauWeapon = SeraphimWeapons.SDFAireauWeapon
local SDFUltraChromaticBeamGenerator = SeraphimWeapons.SDFUltraChromaticBeamGenerator02
local TMCSpiderLaserweapon = TMWeaponsFile.TMCSpiderLaserweapon
local SDFSinnuntheWeapon = SeraphimWeapons.SDFSinnuntheWeapon
local AutoAttackWeapon = WeaponsFileAutoAttack.TDFLandGaussCannonWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TMEffectTemplate = import('/mods/TotalMayhem/lua/TMEffectTemplates.lua')
local EffectUtils = import('/lua/effectutilities.lua')

BRPT3SHBM = Class( SWalkingLandUnit ) {
    Weapons = {
            autoattack = Class(SAAOlarisCannonWeapon) {
			            FxMuzzleFlashScale = 0.0, 
	},
        frontmg1 = Class(SDFAireauWeapon) {
	},
        topgun = Class(SDFSinnuntheWeapon){
        },
        BackTurret = Class(TMCSpiderLaserweapon) {
			            FxMuzzleFlashScale = 1.4,
	},
        aa1 = Class(SDFUltraChromaticBeamGenerator) {
			            FxMuzzleFlashScale = 2.4,
	},
        aa2 = Class(SDFUltraChromaticBeamGenerator) {
			            FxMuzzleFlashScale = 2.4,
	},
    },
OnStopBeingBuilt = function(self,builder,layer)
        SWalkingLandUnit.OnStopBeingBuilt(self,builder,layer)
      
      if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
         self:SetWeaponEnabledByLabel('autoattack', false)
      else
         self:SetWeaponEnabledByLabel('autoattack', true)
      end      
    end,

OnKilled = function(self,builder,layer)
        SWalkingLandUnit.OnKilled(self,builder,layer)
        self:CreatTheEffectsDeath()  
    end,

CreatTheEffectsDeath = function(self)
	local army =  self:GetArmy()
	for k, v in TMEffectTemplate['SerT3SHBMDeath'] do
		CreateAttachedEmitter(self, 'Arm01', army, v):ScaleEmitter(2.8)
	end
end,
}

TypeClass = BRPT3SHBM