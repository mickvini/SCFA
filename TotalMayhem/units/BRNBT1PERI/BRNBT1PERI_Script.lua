#****************************************************************************
#**
#**  File     :  /cdimage/units/UEL0201/UEL0201_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  BRN Scavenger Medium Tank
#**
#**  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtils = import('/lua/effectutilities.lua')
local TMEffectTemplate = import('/mods/TotalMayhem/lua/TMEffectTemplates.lua')
local TMMMEffectTemplate = import('/mods/TotalMayhem/lua/TMavaEffectTemplates.lua')


BRNBT1PERI = Class(TStructureUnit) {


OnStopBeingBuilt = function(self,builder,layer)
        TStructureUnit.OnStopBeingBuilt(self,builder,layer)
        self.Trash:Add(CreateRotator(self, 'Object01', 'y', nil, -30, 0, 0))
     
        self:CreatTheEffects()    
    end,

CreatTheEffects = function(self)
	local army =  self:GetArmy()
	for k, v in EffectTemplate['CSoothSayerAmbient'] do
		CreateAttachedEmitter(self, 'perieffect', army, v):ScaleEmitter(0.3)
	end
	for k, v in TMEffectTemplate['BRMT3EXBMPOWEREFFECT'] do
		CreateAttachedEmitter(self, 'Dummy01', army, v):ScaleEmitter(1.50)
	end
	for k, v in TMEffectTemplate['BRMT3EXBMPOWEREFFECT'] do
		CreateAttachedEmitter(self, 'Dummy02', army, v):ScaleEmitter(1.50)
	end
end,

OnKilled = function(self,builder,layer)
        TStructureUnit.OnKilled(self,builder,layer)
        self:CreatTheEffectsDeath()  
    end,

CreatTheEffectsDeath = function(self)
	local army =  self:GetArmy()
	for k, v in TMEffectTemplate['UEFDeath01'] do
		CreateAttachedEmitter(self, 'BRNBT1PERI', army, v):ScaleEmitter(1.4)
	end

end,
}

TypeClass = BRNBT1PERI