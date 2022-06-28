#****************************************************************************
#**
#**  File     :  /units/URL0204/URL0204_script.*
#**  Author(s):  Optimus Prime
#**
#**  Summary  :  
#**
#****************************************************************************

local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
local cWeapons = import('/lua/cybranweapons.lua')
local CDFLaserDisintegratorWeapon = cWeapons.CDFLaserDisintegratorWeapon01


URL0305 = Class(CWalkingLandUnit) {
    Weapons = {
        MainGun = Class(CDFLaserDisintegratorWeapon) {},
    },
}

TypeClass = URL0305