#****************************************************************************
#**
#**  File     :  /cdimage/units/UEB0302/UEB0302_script.lua
#**  Author(s):  John Comes, David Tomandl
#**
#**  Summary  :  UEF T3 Air Factory Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TAirFactoryUnit = import('/lua/terranunits.lua').TAirFactoryUnit
local Buff = import('/lua/sim/Buff.lua')

local UEB0302OLD = UEB0302

UEB0302 = Class(UEB0302OLD) {
    
	CreateEnhancement = function(self, enh)
        TAirFactoryUnit.CreateEnhancement(self, enh)
		local bp = self:GetBlueprint().Enhancements[enh]
		if enh =='EngineeringPod' then
            if not bp then return end
            if not Buffs['UEFFactoryBuildRate'] then
                BuffBlueprint {
                    Name = 'UEFFactoryBuildRate',
                    DisplayName = 'UEFFactoryBuildRate',
                    BuffType = 'FACTORYBUILDRATE',
                    Stacks = 'REPLACE',
                    Duration = -1,
                    Affects = {
                        BuildRate = {
                            Add =  bp.NewBuildRate - self:GetBlueprint().Economy.BuildRate,
                            Mult = 1,
                        },
                    },
                }
            end
            Buff.ApplyBuff(self, 'UEFFactoryBuildRate')
        elseif enh =='EngineeringPodRemove' then
            local bp = self:GetBlueprint().Economy.BuildRate
            if not bp then return end
            if Buff.HasBuff( self, 'UEFFactoryBuildRate' ) then
                Buff.RemoveBuff( self, 'UEFFactoryBuildRate' )
            end
		elseif enh == 'ShieldGeneratorField' then
            self:AddToggleCap('RULEUTC_ShieldToggle')
            self:CreateShield(bp)
            self:SetEnergyMaintenanceConsumptionOverride(bp.MaintenanceConsumptionPerSecondEnergy or 0)
            self:SetMaintenanceConsumptionActive()
        elseif enh == 'ShieldGeneratorFieldRemove' then
            self:DestroyShield()
            self:SetMaintenanceConsumptionInactive()
            self:RemoveToggleCap('RULEUTC_ShieldToggle')
		end
	end,
}

TypeClass = UEB0302
