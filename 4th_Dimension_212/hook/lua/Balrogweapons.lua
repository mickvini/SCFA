#****************************************************************************
#**
#**  File     :  /lua/Balrogweapons.lua
#**  Author(s):  Ebola Soup (aka Mike McGill)
#**
#**  Summary  :  Testing weapon definitions
#**
#**  Copyright © 2009   All rights reserved.
#****************************************************************************

local WeaponFile = import('/lua/sim/DefaultWeapons.lua')
local CollisionBeams = import('/lua/defaultcollisionbeams.lua')
local BareBonesWeapon = WeaponFile.BareBonesWeapon
local DefaultProjectileWeapon = WeaponFile.DefaultProjectileWeapon
local DefaultBeamWeapon = WeaponFile.DefaultBeamWeapon
local GinsuCollisionBeam = CollisionBeams.GinsuCollisionBeam
local OrbitalDeathLaserCollisionBeam = CollisionBeams.OrbitalDeathLaserCollisionBeam
local BalrogEffectTemplate = import('/mods/4th_Dimension_212/hook/lua/BalrogEffectTemplates.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
-- local EbolaCollisionBeamFile = import ('/mods/4th_Dimension_212/lua/Eboladefaultcollisionbeams.lua')
local BalrogProjectileFile = import ('/mods/4th_Dimension_212/hook/lua/Balrogprojectiles.lua')


-- EbolaDeathLaserBeamWeapon = Class(DefaultBeamWeapon) {
    -- BeamType = EbolaCollisionBeamFile.EbolaDeathLaserCollisionBeam,
    -- FxUpackingChargeEffects = {},
    -- FxUpackingChargeEffectScale = 1,

    -- PlayFxWeaponUnpackSequence = function( self )
        -- local army = self.unit:GetArmy()
        -- local bp = self:GetBlueprint()
        -- for k, v in self.FxUpackingChargeEffects do
            -- for ek, ev in bp.RackBones[self.CurrentRackSalvoNumber].MuzzleBones do
                -- CreateAttachedEmitter(self.unit, ev, army, v):ScaleEmitter(self.FxUpackingChargeEffectScale)
            -- end
        -- end
        -- DefaultBeamWeapon.PlayFxWeaponUnpackSequence(self)
    -- end,
-- }


BalrogMagmaCannonWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = BalrogEffectTemplate.TMagmaCannonMuzzleFlash,
	FxMuzzleFlashScale = 1.25,
}

-- EbolaMiniMagmaCannonWeapon = Class(DefaultProjectileWeapon) {
    -- FxMuzzleFlash = EbolaEffectTemplate.TMagmaCannonMuzzleFlash,
	-- FxMuzzleFlashScale = 0.5,
-- }

-- EbolaMagmaGatlingCannonWeapon = Class(DefaultProjectileWeapon) {
    -- FxMuzzleFlash = EbolaEffectTemplate.TMagmaGatlingCannonMuzzleFlash,
	-- FxMuzzleFlashScale = 0.25,
-- }
