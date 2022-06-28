#****************************************************************************
#**
#**  File     :  /cdimage/units/UAB0302/UAB0302_script.lua 
#**  Author(s):  John Comes, David Tomandl, Gordon Duclos
#**
#**  Summary  :  Aeon Unit Script 
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local AAirFactoryUnit = import('/lua/aeonunits.lua').AAirFactoryUnit
local Buff = import('/lua/sim/Buff.lua')
local UAB0302OLD = UAB0302

UAB0302 = Class(UAB0302OLD) {



	CreateEnhancement = function(self, enh)
        AAirFactoryUnit.CreateEnhancement(self, enh)
		local bp = self:GetBlueprint().Enhancements[enh]
		if enh =='EngineeringPod' then
            if not bp then return end
            if not Buffs['AeonFactoryBuildRate'] then
                BuffBlueprint {
                    Name = 'AeonFactoryBuildRate',
                    DisplayName = 'AeonFactoryBuildRate',
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
            Buff.ApplyBuff(self, 'AeonFactoryBuildRate')
        elseif enh =='EngineeringPodRemove' then
            local bp = self:GetBlueprint().Economy.BuildRate
            if not bp then return end
            if Buff.HasBuff( self, 'AeonFactoryBuildRate' ) then
                Buff.RemoveBuff( self, 'AeonFactoryBuildRate' )
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

TypeClass = UAB0302
