#****************************************************************************
#**
#**  File     :  /cdimage/units/UAS0202/UAS0202_script.lua
#**  Author(s):  David Tomandl
#**
#**  Summary  :  Aeon Battleship Script
#**
#**  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local AeonWeapons = import('/lua/aeonweapons.lua')
local ASeaUnit = import('/lua/aeonunits.lua').ASeaUnit
local AAAZealotMissileWeapon = AeonWeapons.AAAZealotMissileWeapon
local ADFCannonQuantumWeapon = AeonWeapons.ADFCannonQuantumWeapon

WAS0332 = Class(ASeaUnit) {
    Weapons = {
        FrontTurret = Class(ADFCannonQuantumWeapon) {},
        FrontTurret2 = Class(ADFCannonQuantumWeapon) {},
        BackTurret = Class(ADFCannonQuantumWeapon) {},
        AntiAirMissiles01 = Class(AAAZealotMissileWeapon) {},
        AntiAirMissiles02 = Class(AAAZealotMissileWeapon) {},
        AntiAirMissiles03 = Class(AAAZealotMissileWeapon) {},
        AntiAirMissiles04 = Class(AAAZealotMissileWeapon) {},
    },

    BackWakeEffect = {},
}

TypeClass = WAS0332