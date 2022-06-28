#****************************************************************************
#**
#**  File     :  /cdimage/units/UAL0309/UAL0309_script.lua
#**  Author(s):  John Comes, David Tomandl
#**
#**  Summary  :  Aeon Unit Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
--Restrict T4 categories on T3 engineers for human players
local prevClass = UAL0309

UAL0309 = Class(prevClass) {
    OnCreate = function(self)
        prevClass.OnCreate(self)
        if self:GetAIBrain().BrainType == 'Human' then
            self:AddBuildRestriction(categories.AEON * categories.BUILTBYTIER4COMMANDER)
        end
    end,
}
TypeClass = UAL0309