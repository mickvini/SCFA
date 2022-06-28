#****************************************************************************
#**
#**  File     :  /cdimage/units/XSB4205/XSB4205_script.lua
#**  Author(s):  Dru Staltman
#**
#**  Summary  :  Seraphim T2 Power Generator Script
#**
#**  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local SStructureUnit = import('/lua/seraphimunits.lua').SStructureUnit
local Buff = import('/lua/sim/Buff.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local Entity = import('/lua/sim/Entity.lua').Entity
local AIUtils = import('/lua/AI/aiutilities.lua')

BSB4205 = Class(SStructureUnit) {
	    AmbientEffects = 'ST2PowerAmbient',
	    ShieldEffects = {
        '/effects/emitters/seraphim_regenerative_aura_01_emit.bp',
    	},
    	
    --OnStopBeingBuilt = function(self,builder,layer)
   -- 	SStructureUnit.OnCreate(self,builder,layer)
   -- 	self:DisableUnitIntel('CloakField')
   -- end,


    # Copy of XSL0001_script's RegenBuffThread with slight alterations (Enhancement and RegenField)
    RegenBuffThread = function(self)
        while not self:IsDead() do
            # Get friendly units in the area (including self)
            local units = AIUtils.GetOwnUnitsAroundPoint(self:GetAIBrain(), categories.ALLUNITS, self:GetPosition(), self:GetBlueprint().RegenAura.RegenRadius)

            # Give them a 5 second regen buff
            for _,unit in units do
                Buff.ApplyBuff(unit, 'SeraphimRegenFieldMoo')
            end

            #Wait 5 seconds
            WaitSeconds(5)
        end
    end,




    OnStopBeingBuilt = function(self)
 
        SStructureUnit.OnStopBeingBuilt(self)
		self:SetMaintenanceConsumptionActive()
		self:DisableUnitIntel('CloakField')
        if not self.ShieldEffectsBag then
            self.ShieldEffectsBag = {}
        end
        self.ShieldEffectsBag = {}
        local army =  self:GetArmy()
        if self.AmbientEffects then
            for k, v in EffectTemplate[self.AmbientEffects] do
				CreateAttachedEmitter(self, 'XSB4205', army, v):ScaleEmitter(1.2)
            end
        end
               
        local bp = self:GetBlueprint().RegenAura

        if not Buffs['SeraphimRegenFieldMoo'] then
            BuffBlueprint {
                Name = 'SeraphimRegenFieldMoo',
                DisplayName = 'SeraphimRegenFieldMoo',
                BuffType = 'COMMANDERAURA',
                Stacks = 'REPLACE',
                Duration = 5,
                Affects = {
                    RegenPercent = {
                        Add = 0,
                        Mult = bp.RegenPerSecond or 0.1,
                        Ceil = bp.RegenCeiling,
                        Floor = bp.RegenFloor,
                    },
                    #MaxHealth = {
                    #    Add = 0,
                    #    Mult = bp.MaxHealthFactor or 1.0,
                    #    DoNoFill = true,
                    #},                        
                },
            }
        end

        table.insert( self.ShieldEffectsBag, CreateAttachedEmitter( self, 'XSB4205', self:GetArmy(), '/effects/emitters/seraphim_regenerative_aura_01_emit.bp' ) )
        self.RegenThreadHandle = self:ForkThread(self.RegenBuffThread)

    end,

}
TypeClass = BSB4205