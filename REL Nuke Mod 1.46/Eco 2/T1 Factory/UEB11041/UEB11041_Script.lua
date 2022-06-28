#****************************************************************************
#**
#**  File     :  /cdimage/units/UEB1104/UEB1104_script.lua
#**  Author(s):  Jessica St. Croix, David Tomandl
#**
#**  Summary  :  UEF Mass Fabricator
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local TMassFabricationUnit = import('/lua/terranunits.lua').TMassFabricationUnit
local TCivilianStructureUnit = import('/lua/terranunits.lua').TCivilianStructureUnit

UEB1104 = Class(TMassFabricationUnit) {

	EffectBones01 = {
		'Smoke_Left01', 'Smoke_Left02', 'Smoke_Left03', 'Smoke_Left04',	'Smoke_Left_05',					
		'Smoke_Right01', 'Smoke_Right02', 'Smoke_Right03', 'Smoke_Right04',							
	},
	
	EffectBones02 = {
		'Smoke_Right05', 'Smoke_Right06',
	},

    OnCreate = function(self)
		TCivilianStructureUnit.OnCreate(self)
		local army = self:GetArmy()
        for k, v in self.EffectBones01 do
            CreateAttachedEmitter(self,v,army,'/effects/emitters/uec1501_smoke_01_emit.bp')
        end		
        for k, v in self.EffectBones02 do
            CreateAttachedEmitter(self,v,army,'/effects/emitters/uec1501_smoke_02_emit.bp')
        end		        
    end,

    InactiveState = State {
        Main = function(self)
            self:StopUnitAmbientSound( 'ActiveLoop' )

            self.SliderManip:SetGoal(0,-1,0)
            self.SliderManip:SetSpeed(3)
            WaitFor(self.SliderManip)
        end,

        #   User activates unit.
        OnConsumptionActive = function(self)
            TMassFabricationUnit.OnConsumptionActive(self)
            ChangeState(self, self.ActiveState)
        end,
    },
}

TypeClass = UEB1104