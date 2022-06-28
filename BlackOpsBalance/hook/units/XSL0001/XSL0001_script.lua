#****************************************************************************
#**
#**  File     :  /cdimage/units/XSL0001/XSL0001_script.lua
#**  Author(s):  Drew Staltman, Jessica St. Croix, Gordon Duclos
#**
#**  Summary  :  Seraphim Commander Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local SWalkingLandUnit = import('/lua/seraphimunits.lua').SWalkingLandUnit
local Buff = import('/lua/sim/Buff.lua')

local SWeapons = import('/lua/seraphimweapons.lua')
local SDFChronotronCannonWeapon = SWeapons.SDFChronotronCannonWeapon
local SDFChronotronOverChargeCannonWeapon = SWeapons.SDFChronotronCannonOverChargeWeapon
local SIFCommanderDeathWeapon = SWeapons.SIFCommanderDeathWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')
local SIFLaanseTacticalMissileLauncher = SWeapons.SIFLaanseTacticalMissileLauncher
local AIUtils = import('/lua/ai/aiutilities.lua')

# Setup as RemoteViewing child unit rather than SWalkingLandUnit
local RemoteViewing = import('/lua/RemoteViewing.lua').RemoteViewing
SWalkingLandUnit = RemoteViewing( SWalkingLandUnit ) 

local oldXSL0001 = XSL0001

XSL0001 = Class( oldXSL0001 ) {
    
    OnCreate = function(self)
        oldXSL0001.OnCreate(self)
        # Restrict what enhancements will enable later
        self:AddBuildRestriction( categories.SERAPHIM * ( categories.BUILTBYTIER2COMMANDER + categories.BUILTBYTIER3COMMANDER) )
        self:AddBuildRestriction( categories.SERAPHIM * ( categories.BUILTBYTIER4COMMANDER) )
    end,

    CreateEnhancement = function(self, enh)
        oldXSL0001.CreateEnhancement(self, enh)
        local bp = self:GetBlueprint().Enhancements[enh]
        if enh =='AdvancedEngineeringRemove' then
            local bp = self:GetBlueprint().Economy.BuildRate
            if not bp then return end
            self:RestoreBuildRestrictions()
            self:AddBuildRestriction( categories.SERAPHIM * ( categories.BUILTBYTIER2COMMANDER + categories.BUILTBYTIER3COMMANDER) )
            self:AddBuildRestriction( categories.SERAPHIM * ( categories.BUILTBYTIER4COMMANDER) )
            if Buff.HasBuff( self, 'SeraphimACUT2BuildRate' ) then
                Buff.RemoveBuff( self, 'SeraphimACUT2BuildRate' )
            end
        elseif enh =='T3EngineeringRemove' then
            local bp = self:GetBlueprint().Economy.BuildRate
            if not bp then return end
            self:RestoreBuildRestrictions()
            if Buff.HasBuff( self, 'SeraphimACUT3BuildRate' ) then
                Buff.RemoveBuff( self, 'SeraphimACUT3BuildRate' )
            end
            self:AddBuildRestriction( categories.SERAPHIM * ( categories.BUILTBYTIER2COMMANDER + categories.BUILTBYTIER3COMMANDER) )
            self:AddBuildRestriction( categories.SERAPHIM * ( categories.BUILTBYTIER4COMMANDER) )
            #T4 Engineering
        elseif enh =='T4Engineering' then
            local bp = self:GetBlueprint().Enhancements[enh]
            if not bp then return end
            local cat = ParseEntityCategory(bp.BuildableCategoryAdds)
            self:RemoveBuildRestriction(cat)
            if not Buffs['SeraphimACUT4BuildRate'] then
                BuffBlueprint {
                    Name = 'SeraphimACUT4BuildRate',
                    DisplayName = 'SeraphimCUT4BuildRate',
                    BuffType = 'ACUBUILDRATE',
                    Stacks = 'REPLACE',
                    Duration = -1,
                    Affects = {
                        BuildRate = {
                            Add =  bp.NewBuildRate - self:GetBlueprint().Economy.BuildRate,
                            Mult = 1,
                        },
                        MaxHealth = {
                            Add = bp.NewHealth,
                            Mult = 1.0,
                        },
                        Regen = {
                            Add = bp.NewRegenRate,
                            Mult = 1.0,
                        },
                    },
                }
            end
            Buff.ApplyBuff(self, 'SeraphimACUT4BuildRate')
        elseif enh =='T4EngineeringRemove' then
            local bp = self:GetBlueprint().Economy.BuildRate
            if not bp then return end
            self:RestoreBuildRestrictions()
            if Buff.HasBuff( self, 'SeraphimACUT4BuildRate' ) then
                Buff.RemoveBuff( self, 'SeraphimACUT4BuildRate' )
            end
            self:AddBuildRestriction( categories.SERAPHIM * ( categories.BUILTBYTIER2COMMANDER + categories.BUILTBYTIER3COMMANDER) )
            self:AddBuildRestriction( categories.SERAPHIM * ( categories.BUILTBYTIER4COMMANDER) )
        end
    end,

}

TypeClass = XSL0001