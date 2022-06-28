#****************************************************************************
#**
#**  File     :  /cdimage/units/UEL0309/UEL0309_script.lua
#**  Author(s):  John Comes, David Tomandl
#**
#**  Summary  :  Terran Tech 3 Engineer
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
--Restrict T4 categories on T3 engineers for human players
local prevClass = UEL0309

UEL0309 = Class(prevClass) {
    OnCreate = function(self)
        prevClass.OnCreate(self)
        if self:GetAIBrain().BrainType == 'Human' then
            self:AddBuildRestriction(categories.UEF * categories.BUILTBYTIER4COMMANDER)
        end
    end,
}
TypeClass = UEL0309