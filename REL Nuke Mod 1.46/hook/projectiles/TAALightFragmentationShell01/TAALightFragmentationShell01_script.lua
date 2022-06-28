#
# Terran Anti Air basic projectile
#
local TAALightFragmentationProjectile = import('/lua/terranprojectiles.lua').TAALightFragmentationProjectile

TAALightFragmentationShell01 = Class(TAALightFragmentationProjectile) {
	FxAirUnitHitScale = 5,
    FxNoneHitScale = 5,	
    FxUnitHitScale = 5,
}

TypeClass = TAALightFragmentationShell01