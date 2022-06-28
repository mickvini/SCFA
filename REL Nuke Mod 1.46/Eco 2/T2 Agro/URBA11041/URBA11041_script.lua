#****************************************************************************
#**
#**  File     :  /cdimage/units/URB1104/URB1104_script.lua
#**  Author(s):  Jessica St. Croix, David Tomandl
#**
#**  Summary  :  Cybran Mass Fabricator
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local CMassFabricationUnit = import('/lua/cybranunits.lua').CMassFabricationUnit
local CCivilianStructureUnit = import('/lua/cybranunits.lua').CCivilianStructureUnit

URB1104 = Class(CMassFabricationUnit) {

	OnCreate = function(self)
		CCivilianStructureUnit.OnCreate(self)

        self.WindowEntity = import('/lua/sim/Entity.lua').Entity({Owner = self,})
        self.WindowEntity:AttachBoneTo( -1, self, 'URC1401' )
        self.WindowEntity:SetMesh('/effects/Entities/URC1401_WINDOW/URC1401_WINDOW_mesh')
        self.WindowEntity:SetDrawScale(0.1)
        self.WindowEntity:SetVizToAllies('Intel')
        self.WindowEntity:SetVizToNeutrals('Intel')
        self.WindowEntity:SetVizToEnemies('Intel')         
        self.Trash:Add(self.WindowEntity)
	end,

    OnStopBeingBuilt = function(self,builder,layer)
        CMassFabricationUnit.OnStopBeingBuilt(self,builder,layer)

    end,
    
    OnProductionUnpaused = function(self)
        CMassFabricationUnit.OnProductionUnpaused(self)
    end,
    
    OnProductionPaused = function(self)
        CMassFabricationUnit.OnProductionPaused(self)
    end,
	
}

TypeClass = URB1104