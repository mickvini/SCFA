#****************************************************************************
#**
#**  File     :  /cdimage/units/uas0203/uas0203_script.lua
#**  Author(s):  John Comes, Jessica St. Croix
#**
#**  Summary  :  Aeon Attack Sub Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local ASubUnit = import('/lua/aeonunits.lua').ASubUnit
local AANChronoTorpedoWeapon = import('/lua/aeonweapons.lua').AANChronoTorpedoWeapon

UAS0203 = Class(ASubUnit) {
    DeathThreadDestructionWaitTime = 0,
    Weapons = {
        Torpedo01 = Class(AANChronoTorpedoWeapon) {},
    },
    OnLayerChange = function( self, new, old )
        ASubUnit.OnLayerChange(self, new, old)
        if new == 'Water' then
            self:SetSpeedMult(1)
            self:SetIntelRadius('Vision', 60)		
        elseif new == 'Sub' then
            self:SetSpeedMult(0.5)
            self:SetIntelRadius('Vision', 15)			 
        end
    end,
}

TypeClass = UAS0203