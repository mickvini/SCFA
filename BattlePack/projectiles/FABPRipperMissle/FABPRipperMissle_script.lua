#
# Terran Nuke Missile
#
local TIFSmallYieldNuclearBombProjectile = import('/lua/terranprojectiles.lua').TArtilleryAntiMatterProjectile
local EffectTemplate = import('/lua/EffectTemplates.lua')

FABPRipperMissle = Class(TIFSmallYieldNuclearBombProjectile) {

    FxTrails = EffectTemplate.TMissileExhaust01,
	FxLandHitScale = 1.30,
    FxUnitHitScale = 1.30,
}

TypeClass = FABPRipperMissle
