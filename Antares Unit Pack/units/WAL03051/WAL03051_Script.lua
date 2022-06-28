local AWalkingLandUnit = import('/lua/aeonunits.lua').AWalkingLandUnit
local ADFLaserHighIntensityWeapon = import('/lua/aeonweapons.lua').ADFLaserHighIntensityWeapon

WAL03051 = Class(AWalkingLandUnit) {
    Weapons = {
        MainGun = Class(ADFLaserHighIntensityWeapon) {}
    },

}


TypeClass = WAL03051