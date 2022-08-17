#
# Fire Plume Test Projectile Script
#
local GenericDebris = import('/lua/genericdebris.lua').GenericDebris
local EffectTemplate = import('/lua/EffectTemplates.lua')

DestructionFirePlume01 = Class(GenericDebris) {
    FxImpactUnit = EffectTemplate.FireCloudSml01,
    FxImpactLand = EffectTemplate.Impact,
    FxImpactWater = EffectTemplate.ExplosionSmallWater,
    FxImpactUnderWater = {},
    FxImpactNone = {},
}

TypeClass = DestructionFirePlume01

