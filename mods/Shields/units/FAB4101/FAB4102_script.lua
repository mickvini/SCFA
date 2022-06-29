--[[#######################################################################
#  File     :  /units/UEB4205/UEB4205_script.lua
#  Author(s):  David Tomandl, Jessica St. Croix
#  Summary  :  UEF Shield Generator Script

#######################################################################]]--


#local TShieldLandUnit = import('/lua/terranunits.lua').TShieldLandUnit
local AShieldStructureUnit = import('/lua/aeonunits.lua').AShieldStructureUnit

FAB4101 = Class(AShieldStructureUnit) {

    ShieldEffects = {
        '/effects/emitters/aeon_shield_generator_mobile_01_emit.bp',
    },
    
    OnStopBeingBuilt = function(self,builder,layer)
        AShieldStructureUnit.OnStopBeingBuilt(self,builder,layer)
		self.ShieldEffectsBag = {}
    end,

    OnShieldEnabled = function(self)
        AShieldStructureUnit.OnShieldEnabled(self)
        if not self.OrbManip1 then
            self.OrbManip1 = CreateRotator(self, 'Orb', 'x', nil, 0, 45, -45)
            self.Trash:Add(self.OrbManip1)
        end
        self.OrbManip1:SetTargetSpeed(-45)
        if not self.OrbManip2 then
            self.OrbManip2 = CreateRotator(self, 'Orb', 'z', nil, 0, 45, 45)
            self.Trash:Add(self.OrbManip2)
        end
        self.OrbManip2:SetTargetSpeed(45)

        if self.ShieldEffectsBag then
            for k, v in self.ShieldEffectsBag do
                v:Destroy()
            end
		    self.ShieldEffectsBag = {}
		end
        for k, v in self.ShieldEffects do
            table.insert( self.ShieldEffectsBag, CreateAttachedEmitter( self, 0, self:GetArmy(), v ):ScaleEmitter(0.75) )
        end
    end,

    OnShieldDisabled = function(self)
        AShieldStructureUnit.OnShieldDisabled(self)
        if self.OrbManip1 then
            self.OrbManip1:SetSpinDown(true)
            self.OrbManip1:SetTargetSpeed(0)
        end
        if self.OrbManip2 then
            self.OrbManip2:SetSpinDown(true)
            self.OrbManip2:SetTargetSpeed(0)
        end
        if self.ShieldEffectsBag then
            for k, v in self.ShieldEffectsBag do
                v:Destroy()
            end
		    self.ShieldEffectsBag = {}
		end
    end,
    
    OnKilled = function(self, instigator, type, overkillRatio)
        AShieldStructureUnit.OnKilled(self, instigator, type, overkillRatio)
        if self.OrbManip1 then
            self.OrbManip1:Destroy()
            self.OrbManip1 = nil
        end
        if self.OrbManip2 then
            self.OrbManip2:Destroy()
            self.OrbManip2 = nil
        end
    end,    
}

TypeClass = FAB4101
