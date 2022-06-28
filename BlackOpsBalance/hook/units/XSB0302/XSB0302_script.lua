#****************************************************************************
#**
#**  File     :  /units/XSB0302/XSB0302_script.lua
#**
#**  Summary  :  Seraphim T3 Air FactoryScript
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local SAirFactoryUnit = import('/lua/seraphimunits.lua').SAirFactoryUnit
local XSB0302OLD = XSB0302
local Buff = import('/lua/sim/Buff.lua')

XSB0302 = Class(XSB0302OLD) {

    CreateEnhancement = function(self, enh)
        SAirFactoryUnit.CreateEnhancement(self, enh)
		local bp = self:GetBlueprint().Enhancements[enh]
		if enh =='EngineeringPod' then
            if not bp then return end
            if not Buffs['SeraphimFactoryBuildRate'] then
                BuffBlueprint {
                    Name = 'SeraphimFactoryBuildRate',
                    DisplayName = 'SeraphimFactoryBuildRate',
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
            Buff.ApplyBuff(self, 'SeraphimFactoryBuildRate')
        elseif enh =='EngineeringPodRemove' then
            local bp = self:GetBlueprint().Economy.BuildRate
            if not bp then return end
            if Buff.HasBuff( self, 'SeraphimFactoryBuildRate' ) then
                Buff.RemoveBuff( self, 'SeraphimFactoryBuildRate' )
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

TypeClass = XSB0302
