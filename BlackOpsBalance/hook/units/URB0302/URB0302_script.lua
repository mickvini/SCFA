#****************************************************************************
#**
#**  File     :  /cdimage/units/URB0302/URB0302_script.lua
#**  Author(s):  David Tomandl
#**
#**  Summary  :  Cybran Tier 3 Air Unit Factory Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local CAirFactoryUnit = import('/lua/cybranunits.lua').CAirFactoryUnit
local Buff = import('/lua/sim/Buff.lua')

local URB0302OLD = URB0302

URB0302 = Class(URB0302OLD) {

    CreateEnhancement = function(self, enh)
        CAirFactoryUnit.CreateEnhancement(self, enh)
		local bp = self:GetBlueprint().Enhancements[enh]
		if enh =='EngineeringPod' then
            if not bp then return end
            if not Buffs['CybranFactoryBuildRate'] then
                BuffBlueprint {
                    Name = 'CybranFactoryBuildRate',
                    DisplayName = 'CybranFactoryBuildRate',
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
            Buff.ApplyBuff(self, 'CybranFactoryBuildRate')
        elseif enh =='EngineeringPodRemove' then
            local bp = self:GetBlueprint().Economy.BuildRate
            if not bp then return end
            if Buff.HasBuff( self, 'CybranFactoryBuildRate' ) then
                Buff.RemoveBuff( self, 'CybranFactoryBuildRate' )
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

TypeClass = URB0302