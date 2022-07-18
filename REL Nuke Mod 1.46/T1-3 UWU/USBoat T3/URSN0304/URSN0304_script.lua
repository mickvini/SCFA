#****************************************************************************
#**
#**  File     :  /cdimage/units/URS0304/URS0304_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Cybran Strategic Missile Submarine Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CSubUnit = import('/lua/cybranunits.lua').CSubUnit
local CybranWeapons = import('/lua/cybranweapons.lua')

local CIFMissileLoaWeapon = CybranWeapons.CIFMissileLoaWeapon
local CIFMissileStrategicWeapon = CybranWeapons.CIFMissileStrategicWeapon
local CANTorpedoLauncherWeapon = CybranWeapons.CANTorpedoLauncherWeapon

URS0304 = Class(CSubUnit) {
    DeathThreadDestructionWaitTime = 0,
	
    OnLayerChange = function( self, new, old )
        CSubUnit.OnLayerChange(self, new, old)
        if new == 'Water' then
            self:SetSpeedMult(1)
            self:SetIntelRadius('Vision', 50)		
        elseif new == 'Sub' then
            self:SetSpeedMult(0.5)
            self:SetIntelRadius('Vision', 20)			 
        end
    end,
    OnCreate = function(self)
        CSubUnit.OnCreate(self)
        self:SetMaintenanceConsumptionActive()
    end,		
	
    Weapons = {
        NukeMissile = Class(CIFMissileStrategicWeapon){},
        CruiseMissile = Class(CIFMissileLoaWeapon){},
        Torpedo01 = Class(CANTorpedoLauncherWeapon){},
        Torpedo02= Class(CANTorpedoLauncherWeapon){},
    },
}

TypeClass = URS0304

