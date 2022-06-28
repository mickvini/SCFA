#****************************************************************************
#**
#**  File     :  /cdimage/units/URB0303/URB0303_script.lua
#**  Author(s):  John Comes, David Tomandl
#**
#**  Summary  :  Cybran T3 Naval Factory Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CSeaFactoryUnit = import('/lua/cybranunits.lua').CSeaFactoryUnit
local Buff = import('/lua/sim/Buff.lua')

local URB0303OLD = URB0303

URB0303 = Class(URB0303OLD) {    

    CreateEnhancement = function(self, enh)
        CSeaFactoryUnit.CreateEnhancement(self, enh)
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

TypeClass = URB0303