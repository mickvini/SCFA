#****************************************************************************
#**
#**  File     :  /cdimage/units/UAL0201/UAL0201_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Aeon Light Tank Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local AHoverLandUnit = import('/lua/aeonunits.lua').AHoverLandUnit
local ADFDisruptorCannonWeapon = import('/lua/aeonweapons.lua').ADFDisruptorCannonWeapon

UAL0201 = Class(AHoverLandUnit) {
    Weapons = {
        MainGun = Class(ADFDisruptorCannonWeapon) {}
    },
    
   OnLayerChange = function(self, new, old)
        AHoverLandUnit.OnLayerChange(self, new, old)
        if( old != 'None' ) then
            if( new == 'Land' ) then
           	self:SetSpeedMult(1)
            elseif( new == 'Water' ) then
                self:SetSpeedMult(.7)
            end
     	end
    end,
}
TypeClass = UAL0201

