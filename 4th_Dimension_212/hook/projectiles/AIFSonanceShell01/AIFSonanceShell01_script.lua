#
# Aeon Artillery Projectile
#
local AArtilleryProjectile = import('/lua/aeonprojectiles.lua').AArtilleryProjectile
local EffectTemplate = import('/lua/EffectTemplates.lua')
local SingleBeamProjectile = import('/lua/sim/defaultprojectiles.lua').SingleBeamProjectile
local DefaultExplosion = import('/lua/defaultexplosions.lua')

AIFSonanceShell01 = Class(AArtilleryProjectile) {
    PolyTrail = '/effects/emitters/aeon_sonicgun_trail_emit.bp',
    
    FxTrails = EffectTemplate.ASonanceWeaponFXTrail01,
    
    FxImpactUnit =  EffectTemplate.ASonanceWeaponHit02,
    FxImpactProp =  EffectTemplate.ASonanceWeaponHit02,
    FxImpactLand =  EffectTemplate.ASonanceWeaponHit02,

    OnImpact = function(self, targetType, targetEntity)
        local army = self:GetArmy()
        SingleBeamProjectile.OnImpact(self, targetType, targetEntity)
        DefaultExplosion.CreateScorchMarkSplat( self, 1.5 )
    end,    
}

TypeClass = AIFSonanceShell01