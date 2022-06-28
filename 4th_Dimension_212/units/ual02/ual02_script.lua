#**************************************************************************** 
#** 
#** File : /cdimage/units/URL0106/URL0106_script.lua 
#** Author(s): Ebola Soup, Resin_Smoker 
#** 
#** Summary : Aeon light assault unit 
#** 
#** Copyright © 2007, 4th Dimension 
#**************************************************************************** 

local AWalkingLandUnit = import('/lua/aeonunits.lua').AWalkingLandUnit 
local ADFLaserLightWeapon = import('/lua/aeonweapons.lua').ADFLaserLightWeapon
local AAAZealotMissileWeapon = import('/lua/aeonweapons.lua').AAAZealotMissileWeapon 

est0002 = Class(AWalkingLandUnit) { 
    Weapons = { 
        MainGun = Class(ADFLaserLightWeapon) {}, 
        RocketBackpack = Class(AAAZealotMissileWeapon) {},
    }, 
} 

TypeClass = est0002