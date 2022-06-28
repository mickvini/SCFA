#****************************************************************************
#**
#**  File     :  /cdimage/units/UEB2301/UEB2301_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  UEF Heavy Gun Tower Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit
local TDFGaussCannonWeapon = import('/lua/terranweapons.lua').TDFGaussCannonWeapon
local WeaponsFile = import('/lua/terranweapons.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtils = import('/lua/effectutilities.lua')
local TIFCommanderDeathWeapon = WeaponsFile.TIFCommanderDeathWeapon
local TSAMLauncher = WeaponsFile.TSAMLauncher
local TDFLightPlasmaCannonWeapon = WeaponsFile.TDFLightPlasmaCannonWeapon
local TMMMEffectTemplate = import('/mods/TotalMayhem/lua/TMavaEffectTemplates.lua')

BRNT3SHPD = Class(TStructureUnit) {
    Weapons = {
        Gauss01 = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlash = EffectTemplate.TPlasmaGatlingCannonMuzzleFlash,
			            FxMuzzleFlashScale = 3.75, 
        },     
        DeathWeapon = Class(TIFCommanderDeathWeapon) {
        },
        MissileRack01 = Class(TSAMLauncher) {
	},
        missile01 = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlash = EffectTemplate.TPlasmaGatlingCannonMuzzleFlash,
			            FxMuzzleFlashScale = 0.0, 
        },  
    },

OnKilled = function(self,builder,layer)
        TStructureUnit.OnKilled(self,builder,layer)
        self:CreatTheEffectsDeath()  
    end,

CreatTheEffectsDeath = function(self)
	local army =  self:GetArmy()
	for k, v in TMMMEffectTemplate['UEFmayhemRocketHit2A'] do
		CreateAttachedEmitter(self, 'Turret', army, v):ScaleEmitter(2.25)
	end
end,
}

TypeClass = BRNT3SHPD