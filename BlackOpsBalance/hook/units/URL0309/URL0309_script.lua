#****************************************************************************
#**
#**  File     :  /cdimage/units/URL0309/URL0309_script.lua
#**  Author(s):  John Comes, David Tomandl
#**
#**  Summary  :  Cybran Tier 3 Engineer Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
--Restrict T4 categories on T3 engineers for human players
local prevClass = URL0309

URL0309 = Class(prevClass) {
    OnCreate = function(self)
        prevClass.OnCreate(self)
        if self:GetAIBrain().BrainType == 'Human' then
            self:AddBuildRestriction(categories.CYBRAN * categories.BUILTBYTIER4COMMANDER)
        end
    end,
}
TypeClass = URL0309