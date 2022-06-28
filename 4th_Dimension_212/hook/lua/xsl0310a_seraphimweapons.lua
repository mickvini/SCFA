#****************************************************************************
#**
#**  File     :  /lua/xsl0310a_seraphimweapons.lua
#**  Author(s):  Ebola_Soup, Resin Smoker 
#**
#**  Summary  :  Definition of xsl0301a weapons
#**
#**  Copyright © 2009 4th_Dimension.  All rights reserved.
#****************************************************************************

### Local Weapon Files ###
local WeaponFile = import('/lua/sim/defaultweapons.lua')
local BareBonesWeapon = WeaponFile.BareBonesWeapon
local CollisionBeamFile = import('/lua/defaultcollisionbeams.lua')
local DefaultProjectileWeapon = WeaponFile.DefaultProjectileWeapon
local DefaultBeamWeapon = WeaponFile.DefaultBeamWeapon
local Explosion = import('/lua/defaultexplosions.lua')
local KamikazeWeapon = WeaponFile.KamikazeWeapon

### Custom weapon info ###
local xsl0310a_CollisionBeamFile = import('/mods/4th_Dimension_212/hook/lua/xsl0310a_defaultcollisionbeams.lua')

### Local effect templates ###
local EffectTemplate = import('/lua/EffectTemplates.lua')

xsl0310a_LightningWeapon = Class(DefaultBeamWeapon) {
    BeamType = xsl0310a_CollisionBeamFile.xsl0310a_LightningBeam,
    FxMuzzleFlash = {},
    FxChargeMuzzleFlash = {}, 
    FxUpackingChargeEffects = EffectTemplate.CMicrowaveLaserCharge01,
    FxUpackingChargeEffectScale = 0.75,
}