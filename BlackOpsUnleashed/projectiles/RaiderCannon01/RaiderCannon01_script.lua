#****************************************************************************
#
#    File     :  /data/Projectiles/ADFReactonCannnon01/ADFReactonCannnon01_script.lua
#    Author(s): Jessica St.Croix, Gordon Duclos
#
#    Summary  : Aeon Reacton Cannon Area of Effect Projectile
#
#    Copyright © 2006 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

RaiderCannon01 = Class(import('/mods/BlackOpsUnleashed/lua/BlackOpsprojectiles.lua').RaiderCannonProjectile) {
	FxLandHitScale = 2,
    FxUnitHitScale = 2,
	}
TypeClass = RaiderCannon01