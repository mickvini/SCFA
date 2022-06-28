--#*************************************************************************************************
--#**
--#**  File     :  /lua/sim/unit.lua
--#**  Modded By:  Brandon007
--#**
--#**  Summary  : The Unit lua module
--#**
--#*************************************************************************************************

local PreviousUnitVersion = Unit
Unit = Class(PreviousUnitVersion) {

    ##########################################################################################
    ## VETERANCY
    ##########################################################################################

    #Set the veteran level to the level specified
    SetVeteranLevel = function(self, level)
        #LOG('*DEBUG: VETERAN UP! LEVEL ', repr(level))
        local old = self.VeteranLevel
        self.VeteranLevel = level

        # Apply default veterancy buffs
        for bType, v in self.BuffTypes do
            local vetBuffName =  'Veterancy' .. bType .. level
            if Buffs[vetBuffName] then
                Buff.ApplyBuff(self, vetBuffName)
            end
        end
        # Get any overriding buffs if they exist
        local bp = self:GetBlueprint().Buffs
        #Check for unit buffs
        if bp then
            for bType,bData in bp do
                for lName,lValue in bData do
                    if lName == 'Level'..level then
                        # Generate a buff based on the data paseed in
                        local buffName = self:CreateVeterancyBuff( lName, lValue, bType )
                        if buffName then
                            Buff.ApplyBuff( self, buffName )
                        end
                    end
                end
            end
        end
        self:GetAIBrain():OnBrainUnitVeterancyLevel(self, level)
        self:DoUnitCallbacks('OnVeteran')
    end,

    # Table housing data on what to use to generate buffs for a unit
    BuffTypes = {
        Regen = { BuffType = 'VETERANCYREGEN', BuffValFunction = 'Add', BuffDuration = -1, BuffStacks = 'REPLACE' },
        Damage = { BuffType = 'VETERANCYDAMAGE', BuffValFunction = 'Mult', BuffDuration = -1, BuffStacks = 'REPLACE' },
        RateOfFire = { BuffType = 'VETERANCYRATEOFFIRE', BuffValFunction = 'Mult', BuffDuration = -1, BuffStacks = 'REPLACE' },
        Health = { BuffType = 'VETERANCYHEALTH', BuffValFunction = 'Mult', BuffDuration = -1, BuffStacks = 'REPLACE' },
    },

    CreateVeterancyBuff = function(self, levelName, levelValue, buffType)
        # Make sure there is an appropriate buff type for this unit
        if not self.BuffTypes[buffType] then
            WARN('*WARNING: Tried to generate a buff of unknown type to units: ' .. buffType .. ' - UnitId: ' .. self:GetUnitId() )
            return nil
        end
        
        # Generate a buff based on the unitId
        local buffName = self:GetUnitId() .. levelName .. buffType
        
        # Figure out what we want the Add and Mult values to be based on the BuffTypes table
        local addVal = 0
        local multVal = 1
        if self.BuffTypes[buffType].BuffValFunction == 'Add' then 
            addVal = levelValue
        else
            multVal = levelValue
        end
        
        # Create the buff if needed
        if not Buffs[buffName] then
            BuffBlueprint {
                Name = buffName,
                DisplayName = buffName,
                BuffType = self.BuffTypes[buffType].BuffType,
                Stacks = self.BuffTypes[buffType].BuffStacks,
                Duration = self.BuffTypes[buffType].BuffDuration,
                Affects = {
                    [buffType] = {
                        Add = addVal,
                        Mult = multVal,
                    },
                },
            }
        end

	LOG("Blueprint for Buff "..buffName..":"..repr(Buffs[buffName]))

       
        # Return the buffname so the buff can be applied to the unit
        return buffName

    end,
    
}