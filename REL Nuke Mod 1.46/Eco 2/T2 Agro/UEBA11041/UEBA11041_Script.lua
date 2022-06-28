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

    OnCreate = function(self)
		TCivilianStructureUnit.OnCreate(self)
        self.WindowEntity = import('/lua/sim/Entity.lua').Entity({Owner = self,})
        self.WindowEntity:AttachBoneTo( -1, self, 'UEC1401' )
        self.WindowEntity:SetMesh('/effects/Entities/UEC1401_WINDOW/UEC1401_WINDOW_mesh')
        self.WindowEntity:SetDrawScale(0.1)
        self.WindowEntity:SetVizToAllies('Intel')
        self.WindowEntity:SetVizToNeutrals('Intel')
        self.WindowEntity:SetVizToEnemies('Intel')        
        self.Trash:Add(self.WindowEntity)
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