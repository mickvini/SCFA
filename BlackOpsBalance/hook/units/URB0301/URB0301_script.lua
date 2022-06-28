#****************************************************************************
#**
#**  File     :  /cdimage/units/URB0301/URB0301_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Cybran T3 Land Factory Unit Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local CLandFactoryUnit = import('/lua/cybranunits.lua').CLandFactoryUnit
local Buff = import('/lua/sim/Buff.lua')

local URB0301OLD = URB0301

URB0301 = Class(URB0301OLD) {

	CreateEnhancement = function(self, enh)
        CLandFactoryUnit.CreateEnhancement(self, enh)
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

TypeClass = URB0301