#****************************************************************************
#**
#**  File     :  /units/URL0204/URL0204_script.*
#**  Author(s):  Optimus Prime
#**
#**  Summary  :  Cybran Stealthed Insectoid
#**
#****************************************************************************

local CDFLaserHeavyWeapon = import('/lua/cybranweapons.lua').CDFLaserHeavyWeapon
local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit

URL0204 = Class(CWalkingLandUnit) {
    Weapons = {
        MainGun = Class(CDFLaserHeavyWeapon) {},
    },
}

TypeClass = URL0204