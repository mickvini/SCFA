#****************************************************************************
#**
#**  File     :  /cdimage/units/UEB0301/UEB0301_script.lua
#**  Author(s):  David Tomandl
#**
#**  Summary  :  Terran Unit Script
#**
#**  Copyright © 2006 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TLandFactoryUnit = import('/lua/terranunits.lua').TLandFactoryUnit
local Buff = import('/lua/sim/Buff.lua')

local UEB0301OLD = UEB0301

UEB0301 = Class(UEB0301OLD) {


	CreateEnhancement = function(self, enh)
        TLandFactoryUnit.CreateEnhancement(self, enh)
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

TypeClass = UEB0301