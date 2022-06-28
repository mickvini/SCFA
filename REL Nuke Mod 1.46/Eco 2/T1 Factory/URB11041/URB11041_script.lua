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

	EffectBones01 = {
		'Smoke_Left01', 'Smoke_Left02', 'Smoke_Left03', 'Smoke_Left04',	'Smoke_Left05',					
		'Smoke_Right01', 'Smoke_Right02', 'Smoke_Right03', 'Smoke_Right04',	'Smoke_Right05',
		'Smoke_Center01', 'Smoke_Center02',						
	},

    OnCreate = function(self)
		CCivilianStructureUnit.OnCreate(self)
		local army = self:GetArmy()
        for k, v in self.EffectBones01 do
            CreateAttachedEmitter(self,v,army,'/effects/emitters/urc1501_ambient_01_emit.bp')
            CreateAttachedEmitter(self,v,army,'/effects/emitters/urc1501_ambient_02_emit.bp')
        end		
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