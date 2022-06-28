#
# Aeon Anti Air Missile
#
local ATemporalFizzAAProjectile = import('/lua/aeonprojectiles.lua').ATemporalFizzAAProjectile

AAAFizz01 = Class(ATemporalFizzAAProjectile) {
	FxAirUnitHitScale = 6,
    FxNoneHitScale = 6,	
    FxUnitHitScale = 6,
}

TypeClass = AAAFizz01

