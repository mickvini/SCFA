#****************************************************************************
#**
#**  File     :  /data/projectiles/SAAOlarisAAArtillery02/SAAOlarisAAArtillery02_script.lua
#**  Author(s):  Gordon Duclos, Aaron Lundquist
#**
#**  Summary  :  Olaris AA Artillery Projectile script, XSL0205
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

SAAOlarisAAArtillery02 = Class(import('/lua/seraphimprojectiles.lua').SOlarisAAArtillery) {
	FxAirUnitHitScale = 4,
    FxNoneHitScale = 4,	
    FxUnitHitScale = 4,
}
TypeClass = SAAOlarisAAArtillery02