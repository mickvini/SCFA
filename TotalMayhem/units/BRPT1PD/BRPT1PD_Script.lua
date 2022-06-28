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
local SDFAireauBolterWeapon = import('/lua/seraphimweapons.lua').SDFAireauBolterWeapon02
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TMEffectTemplate = import('/mods/TotalMayhem/lua/TMEffectTemplates.lua')
local EffectUtils = import('/lua/effectutilities.lua')

BRPT1PD = Class(TStructureUnit) {
    Weapons = {
        MainGun = Class(SDFAireauBolterWeapon) {
			            FxMuzzleFlashScale = 2.4, 
	},
    },
OnStopBeingBuilt = function(self,builder,layer)
        TStructureUnit.OnStopBeingBuilt(self,builder,layer)
        self.Trash:Add(CreateRotator(self, 'Object107', 'y', nil, -650, 0, 0))
        self.Trash:Add(CreateRotator(self, 'Object105', 'y', nil, 450, 0, 0))
        self.Trash:Add(CreateRotator(self, 'Object42', 'y', nil, -250, 0, 0))
              self:CreatTheEffects()   
    end,

OnKilled = function(self,builder,layer)
        TStructureUnit.OnKilled(self,builder,layer)
        self:CreatTheEffectsDeath()  
    end,

CreatTheEffects = function(self)
	local army =  self:GetArmy()
	for k, v in EffectTemplate['SDFSinnutheWeaponFXTrails01'] do
		CreateAttachedEmitter(self, 'eff01', army, v):ScaleEmitter(0.28)
	end
	for k, v in EffectTemplate['SDFSinnutheWeaponFXTrails01'] do
		CreateAttachedEmitter(self, 'eff02', army, v):ScaleEmitter(0.23)
	end
	for k, v in EffectTemplate['SDFSinnutheWeaponFXTrails01'] do
		CreateAttachedEmitter(self, 'eff03', army, v):ScaleEmitter(0.18)
	end
end,

CreatTheEffectsDeath = function(self)
	local army =  self:GetArmy()
	for k, v in EffectTemplate['SZthuthaamArtilleryHit'] do
		CreateAttachedEmitter(self, 'BRPT1PD', army, v):ScaleEmitter(1.65)
	end
end,
}

TypeClass = BRPT1PD