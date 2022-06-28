local SWalkingLandUnit = import('/lua/seraphimunits.lua').SWalkingLandUnit
local SDFThauCannon = import('/lua/seraphimweapons.lua').SDFThauCannon

WSL03021 = Class(SWalkingLandUnit) {
    Weapons = {
        MainGun = Class(SDFThauCannon) {},
    },
   
}
TypeClass = WSL03021