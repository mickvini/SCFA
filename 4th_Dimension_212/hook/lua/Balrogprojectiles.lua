#****************************************************************************
#**
#**  Author(s): Exavier Macbeth
#**
#**  Summary  : This is a blank slate for creating projectiles.lua files
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local DefaultProjectileFile = import('/lua/sim/defaultprojectiles.lua')
local GetRandomFloat = import('/lua/utilities.lua').GetRandomFloat
local DefaultExplosion = import('/lua/defaultexplosions.lua')
local DepthCharge = import('/lua/defaultantiprojectile.lua').DepthCharge
local Projectile = import('/lua/sim/projectile.lua').Projectile
local Explosion = import('/lua/defaultexplosions.lua')
local BalrogEffectTemplate = import('/mods/4th_Dimension_212/hook/lua/BalrogEffectTemplates.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local util = import('/lua/utilities.lua')
local EmitterProjectile = DefaultProjectileFile.EmitterProjectile
local OnWaterEntryEmitterProjectile = DefaultProjectileFile.OnWaterEntryEmitterProjectile
local SingleBeamProjectile = DefaultProjectileFile.SingleBeamProjectile
local SinglePolyTrailProjectile = DefaultProjectileFile.SinglePolyTrailProjectile
local MultiPolyTrailProjectile = DefaultProjectileFile.MultiPolyTrailProjectile
local SingleCompositeEmitterProjectile = DefaultProjectileFile.SingleCompositeEmitterProjectile
local MultiCompositeEmitterProjectile = DefaultProjectileFile.MultiCompositeEmitterProjectile
local NullShell = DefaultProjectileFile.NullShell
local MultiBeamProjectile = DefaultProjectileFile.MultiBeamProjectile

#------------------------------------------------------------------------
#  Start Your Code Here
#------------------------------------------------------------------------

#------------------------------------------------------------------------
#  Ebola Soup's Magma Cannon Projectile. For use on UEF Experimental Quadruped Bot...Balrog.  Hacked from: UEF IONIZED PLASMA GATLING CANNON PROJECTILE
#------------------------------------------------------------------------

TBalrogMagmaCannon = Class(MultiPolyTrailProjectile) {
    FxImpactWater = BalrogEffectTemplate.TMagmaCannonHit,
    FxImpactLand = BalrogEffectTemplate.TMagmaCannonHit,
    FxImpactNone = BalrogEffectTemplate.TMagmaCannonHit,
    FxImpactProp = BalrogEffectTemplate.TMagmaCannonUnitHit,    
    FxImpactUnit = BalrogEffectTemplate.TMagmaCannonUnitHit,    
    FxTrails = BalrogEffectTemplate.TMagmaCannonFxTrails,

	# Using MultPolyTrail:
		PolyTrails = BalrogEffectTemplate.TMagmaCannonPolyTrails,
		PolyTrailOffset = {0,-1.55}, # original = {0,0}
    FxImpactProjectile = {},
    FxImpactUnderWater = {},
	
	# Adjusting scale for testing...remove and fix projectile if sizing desired
	FxTrailScale = 1.25,
}

#------------------------------------------------------------------------
#  Ebola Soup's Mini Magma Cannon Projectile. Use for smaller guns
#------------------------------------------------------------------------

-- TEbolaMiniMagmaCannon = Class(MultiPolyTrailProjectile) {

	-- # -------------------------------
	-- # From default weapon:
	-- FxImpactWater = EffectTemplate.TIonizedPlasmaGatlingCannonHit,
    -- FxImpactLand = EffectTemplate.TIonizedPlasmaGatlingCannonHit,
    -- FxImpactNone = EffectTemplate.TIonizedPlasmaGatlingCannonHit,
    -- FxImpactProp = EffectTemplate.TIonizedPlasmaGatlingCannonUnitHit,    
    -- FxImpactUnit = EffectTemplate.TIonizedPlasmaGatlingCannonUnitHit,    
	-- # From large Magma cannon:
    -- -- FxTrails = EbolaEffectTemplate.TMagmaCannonFxTrails,
	-- FxTrails = EbolaEffectTemplate.TMiniMagmaCannonFxTrails,
	
    -- # Scale down above FX:
	-- FxUnitHitScale = 0.4,
	-- FxLandHitScale = 0.4, 
    -- FxNoneHitScale = 0.4, 
    -- FxPropHitScale = 0.4, 
    -- FxWaterHitScale = 0.4,
	-- FxTrailScale = 0.4,
	

	-- # Using MultPolyTrail:
		-- PolyTrails = EbolaEffectTemplate.TEbolaMiniMagmaCannonPolyTrail,
		-- PolyTrailOffset = {0},

    -- FxImpactProjectile = {},
    -- FxImpactUnderWater = {},
-- }

#------------------------------------------------------------------------
#  Ebola Soup's Magma Gatling Cannon Projectile. Rapid-fire Magma Gun
#------------------------------------------------------------------------
-- TEbolaMagmaGatlingCannon = Class(SinglePolyTrailProjectile) {
    -- FxImpactWater = EbolaEffectTemplate.TMagmaGatlingCannonHit,
    -- FxImpactLand = EbolaEffectTemplate.TMagmaGatlingCannonHit,
    -- FxImpactNone = EbolaEffectTemplate.TMagmaGatlingCannonHit,
    -- FxImpactProp = EbolaEffectTemplate.TMagmaGatlingCannonUnitHit,    
    -- FxImpactUnit = EbolaEffectTemplate.TMagmaGatlingCannonUnitHit,    
    -- FxTrails = EbolaEffectTemplate.TMagmaGatlingCannonFxTrails,
    -- # Scale down above FX:
	-- FxUnitHitScale = 0.25,
	-- FxLandHitScale = 0.25, 
    -- FxNoneHitScale = 0.25, 
    -- FxPropHitScale = 0.25, 
    -- FxWaterHitScale = 0.25,
	-- FxTrailScale = 0.25,
	
	-- # If Using SinglePolyTrail:
	-- PolyTrail = EbolaEffectTemplate.TMagmaGatlingCannonPolyTrail,
	
	-- # If Using MultPolyTrail:
		-- -- PolyTrails = EbolaEffectTemplate.TMagmaGatlingCannonPolyTrails,
		-- -- PolyTrailOffset = {0,0},
    -- FxImpactProjectile = {},
    -- FxImpactUnderWater = {},
-- }

