--[[#######################################################################
#  File     :  /units/UEB4205/UEB4205_script.lua
#  Author(s):  David Tomandl, Jessica St. Croix
#  Summary  :  UEF Shield Generator Script

#######################################################################]]--


#local TShieldLandUnit = import('/lua/terranunits.lua').TShieldLandUnit
local TShieldStructureUnit = import('/lua/terranunits.lua').TShieldStructureUnit

FEB4101 = Class(TShieldStructureUnit) {

    ShieldEffects = {
        '/effects/emitters/terran_shield_generator_mobile_01_emit.bp',
        '/effects/emitters/terran_shield_generator_mobile_02_emit.bp',
    },
    
    OnStopBeingBuilt = function(self,builder,layer)
        TShieldStructureUnit.OnStopBeingBuilt(self,builder,layer)
	self.RotatorManipulator = CreateRotator( self, 'Object05', 'y' )
	self.Trash:Add( self.RotatorManipulator )
		self.ShieldEffectsBag = {}
    end,
    
    OnShieldEnabled = function(self)
        TShieldStructureUnit.OnShieldEnabled(self)
        KillThread( self.DestroyManipulatorsThread )
        if not self.RotatorManipulator then
            self.RotatorManipulator = CreateRotator( self, 'Object05', 'y' )
            self.Trash:Add( self.RotatorManipulator )
        end
        self.RotatorManipulator:SetAccel( 5 )
        self.RotatorManipulator:SetTargetSpeed( 30 )
        if not self.AnimationManipulator then
            local myBlueprint = self:GetBlueprint()
            #LOG( 'it is ', repr(myBlueprint.Display.AnimationOpen) )
            self.AnimationManipulator = CreateAnimator(self)
            self.AnimationManipulator:PlayAnim( myBlueprint.Display.AnimationOpen )
            self.Trash:Add( self.AnimationManipulator )
        end
        self.AnimationManipulator:SetRate(1)
        
        if self.ShieldEffectsBag then
            for k, v in self.ShieldEffectsBag do
                v:Destroy()
            end
		    self.ShieldEffectsBag = {}
		end
        for k, v in self.ShieldEffects do
            table.insert( self.ShieldEffectsBag, CreateAttachedEmitter( self, 0, self:GetArmy(), v ) )
        end
    end,

    OnShieldDisabled = function(self)
        TShieldStructureUnit.OnShieldDisabled(self)
        KillThread( self.DestroyManipulatorsThread )
        self.DestroyManipulatorsThread = self:ForkThread( self.DestroyManipulators )
        
        if self.ShieldEffectsBag then
            for k, v in self.ShieldEffectsBag do
                v:Destroy()
            end
		    self.ShieldEffectsBag = {}
		end
    end,

    DestroyManipulators = function(self)
        if self.RotatorManipulator then
            self.RotatorManipulator:SetAccel( 10 )
            self.RotatorManipulator:SetTargetSpeed( 0 )
        end
        if self.AnimationManipulator then
            self.AnimationManipulator:SetRate(-1)
            WaitFor( self.AnimationManipulator )
            self.AnimationManipulator:Destroy()
            self.AnimationManipulator = nil
        end
    end,
}

TypeClass = FEB4101
