#
# Aeon DisruptorShellProjectile Projectile
#
local ADisruptorShellProjectile = import('/lua/aeonprojectiles.lua').ADisruptorShellProjectile
local EffectTemplate = import('/lua/EffectTemplates.lua')
local RandomFloat = import('/lua/utilities.lua').GetRandomFloat

AIFDisruptorShell02 = Class(ADisruptorShellProjectile) {
    
    FxTrails = EffectTemplate.ASonanceWeaponFXTrail02,
    
    FxImpactUnit =  EffectTemplate.ASonanceWeaponHit02,
    FxImpactProp =  EffectTemplate.ASonanceWeaponHit02,
    FxImpactLand =  EffectTemplate.ASonanceWeaponHit02,
    
    OnImpact = function(self, TargetType, targetEntity)
        local rotation = RandomFloat(0,2*math.pi)
        
        CreateDecal(self:GetPosition(), rotation, 'crater_radial01_normals', '', 'Alpha Normals', 5, 5, 300, 0, self:GetArmy())
        CreateDecal(self:GetPosition(), rotation, 'crater_radial01_albedo', '', 'Albedo', 6, 6, 300, 0, self:GetArmy())
 
        ADisruptorShellProjectile.OnImpact( self, TargetType, targetEntity )
    end,
}

TypeClass = AIFDisruptorShell02