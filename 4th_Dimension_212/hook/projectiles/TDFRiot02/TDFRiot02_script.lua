#
# Terran Riot basic projectile
#
local EffectTemplate = import('/lua/EffectTemplates.lua')

TDFRiot02 = Class(import('/lua/terranprojectiles.lua').TShellRiotProjectile) { 
    PolyTrails = EffectTemplate.TRiotGunPolyTrailsTank,
    FxTrails = {},    
}

TypeClass = TDFRiot02

