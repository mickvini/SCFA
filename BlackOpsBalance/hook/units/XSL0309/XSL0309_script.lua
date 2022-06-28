#****************************************************************************
#**
#**  File     :  /units/XSL0309/XSL0309_script.lua
#**
#**  Summary  :  Seraphim T3 Engineer Unit Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
--Restrict T4 categories on T3 engineers for human players
local prevClass = XSL0309

XSL0309 = Class(prevClass) {
    OnCreate = function(self)
        prevClass.OnCreate(self)
        if self:GetAIBrain().BrainType == 'Human' then
            self:AddBuildRestriction(categories.SERAPHIM * categories.BUILTBYTIER4COMMANDER)
        end
    end,
}
TypeClass = XSL0309