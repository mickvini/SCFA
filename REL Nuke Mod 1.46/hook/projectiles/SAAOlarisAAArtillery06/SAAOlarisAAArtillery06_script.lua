#****************************************************************************
#**
#**  File     :  /data/projectiles/SAAOlarisAAArtillery06/SAAOlarisAAArtillery06_script.lua
#**  Author(s):  Gordon Duclos, Aaron Lundquist
#**
#**  Summary  :  Olaris AA Artillery Projectile script, XSB2204
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

SAAOlarisAAArtillery06 = Class(import('/lua/seraphimprojectiles.lua').SOlarisAAArtillery) {
	FxAirUnitHitScale = 4,
    FxNoneHitScale = 4,	
    FxUnitHitScale = 4,

}
TypeClass = SAAOlarisAAArtillery06