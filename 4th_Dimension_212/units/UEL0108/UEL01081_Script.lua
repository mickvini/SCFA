#****************************************************************************
#**
#**  File     :  /units/UEL0108/UEL0108_script.lua
#**  Author(s):  Optimus Prime
#**
#**  Summary  :  UEF medium Tank
#**
#****************************************************************************

local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local TDFGaussCannonWeapon = import('/lua/terranweapons.lua').TDFGaussCannonWeapon

UEL0108 = Class(TLandUnit) {
    Weapons = {
        MainGun = Class(TDFGaussCannonWeapon) {}
    },
}

TypeClass = UEL0108