#****************************************************************************
#**
#**  File     :  /cdimage/units/UAB0303/UAB0303_script.lua
#**  Author(s):  John Comes, David Tomandl, Gordon Duclos
#**
#**  Summary  :  Aeon Tier 3 Naval Factory Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local SSeaFactoryUnit = import('/lua/seraphimunits.lua').SSeaFactoryUnit
local XSB0303OLD = XSB0303
local Buff = import('/lua/sim/Buff.lua')

XSB0303 = Class(XSB0303OLD) {

    CreateEnhancement = function(self, enh)
        SSeaFactoryUnit.CreateEnhancement(self, enh)
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

TypeClass = XSB0303

