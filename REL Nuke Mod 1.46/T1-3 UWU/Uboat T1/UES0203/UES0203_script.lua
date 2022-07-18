#****************************************************************************
#**
#**  File     :  /cdimage/units/UES0203/UES0203_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  UEF Attack Sub Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TSubUnit = import('/lua/terranunits.lua').TSubUnit
local TANTorpedoAngler = import('/lua/terranweapons.lua').TANTorpedoAngler
local TDFLightPlasmaCannonWeapon = import('/lua/terranweapons.lua').TDFLightPlasmaCannonWeapon

UES0203 = Class(TSubUnit) {
    PlayDestructionEffects = true,
    DeathThreadDestructionWaitTime = 0,

    Weapons = {
        Torpedo01 = Class(TANTorpedoAngler) {},
        PlasmaGun = Class(TDFLightPlasmaCannonWeapon) {}
    },
    OnLayerChange = function( self, new, old )
        TSubUnit.OnLayerChange(self, new, old)
        if new == 'Water' then
            self:SetSpeedMult(1)
            self:SetIntelRadius('Vision', 40)		
        elseif new == 'Sub' then
            self:SetSpeedMult(0.5)
            self:SetIntelRadius('Vision', 10)			 
        end
    end,
    OnCreate = function(self)
        TSubUnit.OnCreate(self)
        self:SetMaintenanceConsumptionActive()
    end,		
}


TypeClass = UES0203