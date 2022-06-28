#
# UEF Anti-Matter Shells
#
local TArtilleryAntiMatterProjectile = import('/lua/terranprojectiles.lua').TArtilleryAntiMatterSmallProjectile
local SingleBeamProjectile = import('/lua/sim/defaultprojectiles.lua').SingleBeamProjectile
local DefaultExplosion = import('/lua/defaultexplosions.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')

TIFAntiMatterShells02 = Class(TArtilleryAntiMatterProjectile) {
   
        
    OnImpact = function(self, targetType, targetEntity)
        local army = self:GetArmy()
        SingleBeamProjectile.OnImpact(self, targetType, targetEntity)
        DefaultExplosion.CreateScorchMarkSplat( self, 1.6 )
    end,    
}

TypeClass = TIFAntiMatterShells02