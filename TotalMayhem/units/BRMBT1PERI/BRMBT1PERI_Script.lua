#****************************************************************************
#**
#**  File     :  /cdimage/units/UEL0201/UEL0201_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  BRN Scavenger Medium Tank
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtils = import('/lua/effectutilities.lua')
local TMEffectTemplate = import('/mods/TotalMayhem/lua/TMEffectTemplates.lua')
local TMMMEffectTemplate = import('/mods/TotalMayhem/lua/TMavaEffectTemplates.lua')


BRMBT1PERI = Class(TStructureUnit) {


OnStopBeingBuilt = function(self,builder,layer)
        TStructureUnit.OnStopBeingBuilt(self,builder,layer)
        self.Trash:Add(CreateRotator(self, 'B02', 'y', nil, -90, 0, 0))
     
        self:CreatTheEffects()    
    end,

CreatTheEffects = function(self)
	local army =  self:GetArmy()
	for k, v in EffectTemplate['SmokePlumeMedDensitySml01'] do
		CreateAttachedEmitter(self, 'Dummy01', army, v):ScaleEmitter(1.35)
	end
	for k, v in EffectTemplate['SmokePlumeMedDensitySml01'] do
		CreateAttachedEmitter(self, 'Dummy02', army, v):ScaleEmitter(1.35)
	end
	for k, v in EffectTemplate['CSoothSayerAmbient'] do
		CreateAttachedEmitter(self, 'Dummy02', army, v):ScaleEmitter(0.3)
	end
	for k, v in TMEffectTemplate['BRMT3EXBMPOWEREFFECT'] do
		CreateAttachedEmitter(self, 'Dummy03', army, v):ScaleEmitter(6.75)
	end
	for k, v in TMEffectTemplate['BRMT3EXBMPOWEREFFECT'] do
		CreateAttachedEmitter(self, 'Dummy04', army, v):ScaleEmitter(2.75)
	end
	for k, v in EffectTemplate['GenericTeleportCharge01'] do
		CreateAttachedEmitter(self, 'Dummy05', army, v):ScaleEmitter(0.35)
	end
	for k, v in EffectTemplate['GenericTeleportCharge01'] do
		CreateAttachedEmitter(self, 'Dummy06', army, v):ScaleEmitter(0.35)
	end
	for k, v in EffectTemplate['GenericTeleportCharge01'] do
		CreateAttachedEmitter(self, 'Dummy07', army, v):ScaleEmitter(0.35)
	end
	for k, v in EffectTemplate['GenericTeleportCharge01'] do
		CreateAttachedEmitter(self, 'Dummy08', army, v):ScaleEmitter(0.35)
	end
	for k, v in EffectTemplate['GenericTeleportCharge01'] do
		CreateAttachedEmitter(self, 'Dummy09', army, v):ScaleEmitter(0.35)
	end
	for k, v in EffectTemplate['GenericTeleportCharge01'] do
		CreateAttachedEmitter(self, 'Dummy10', army, v):ScaleEmitter(0.35)
	end
	for k, v in EffectTemplate['GenericTeleportCharge01'] do
		CreateAttachedEmitter(self, 'Dummy11', army, v):ScaleEmitter(0.35)
	end
	for k, v in EffectTemplate['GenericTeleportCharge01'] do
		CreateAttachedEmitter(self, 'Dummy12', army, v):ScaleEmitter(0.35)
	end
end,

OnKilled = function(self,builder,layer)
        TStructureUnit.OnKilled(self,builder,layer)
        self:CreatTheEffectsDeath()  
    end,

CreatTheEffectsDeath = function(self)
	local army =  self:GetArmy()
	for k, v in TMEffectTemplate['MadCatDeath01'] do
		CreateAttachedEmitter(self, 'BRMBT1PERI', army, v):ScaleEmitter(1.2)
	end
end,
}

TypeClass = BRMBT1PERI