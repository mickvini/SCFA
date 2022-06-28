#
# Cybran Anti Air Projectile
#
local CAAElectronBurstCloudProjectile = import('/lua/cybranprojectiles.lua').CAAElectronBurstCloudProjectile

CAABurstCloud01 = Class(CAAElectronBurstCloudProjectile) { 
	FxAirUnitHitScale = 3,
    FxNoneHitScale = 3,	
    FxUnitHitScale = 3,
}

TypeClass = CAABurstCloud01
