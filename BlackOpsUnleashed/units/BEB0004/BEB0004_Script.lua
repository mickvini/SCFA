#****************************************************************************
#** 
#**  File     :  /cdimage/units/XSB0003/XSB0003_script.lua 
#**  Author(s):  John Comes, David Tomandl 
#** 
#**  Summary  :  UEF Wall Piece Script 
#** 
#**  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local SStructureUnit = import('/lua/seraphimunits.lua').SStructureUnit


BEB0003 = Class(SStructureUnit) {


### File pathing and special paramiters called ###########################

### Setsup parent call backs between drone and parent
Parent = nil,

SetParent = function(self, parent, droneName)
    self.Parent = parent
    self.Drone = droneName
end,

##########################################################################
ShieldEffects = {
       '/effects/emitters/terran_shield_generator_t2_01_emit.bp',
        '/effects/emitters/terran_shield_generator_t2_02_emit.bp',
    },
	   OnCreate = function(self, builder, layer)
        SStructureUnit.OnCreate(self, builder, layer)
        self.ShieldEffectsBag = {}
        if self.ShieldEffectsBag then
            for k, v in self.ShieldEffectsBag do
                v:Destroy()
            end
		    self.ShieldEffectsBag = {}
		end
        for k, v in self.ShieldEffects do
            table.insert( self.ShieldEffectsBag, CreateAttachedEmitter( self, 'Effect01', self:GetArmy(), v ):ScaleEmitter(0.5) )
        end
    end,
    --Make this unit invulnerable
    OnDamage = function()
    end,
    OnKilled = function(self, instigator, type, overkillRatio)
        SStructureUnit.OnKilled(self, instigator, type, overkillRatio)
        if self.ShieldEffctsBag then
            for k,v in self.ShieldEffectsBag do
                v:Destroy()
            end
        end
    end,  
    DeathThread = function(self)
        self:Destroy()
    end,
}


TypeClass = BEB0003

