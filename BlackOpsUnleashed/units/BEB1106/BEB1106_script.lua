#****************************************************************************
#**
#**  File     :  /cdimage/units/UEB1106/UEB1106_script.lua
#**  Author(s):  Jessica St. Croix
#**
#**  Summary  :  UEF Mass Storage
#**
#**  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TMassStorageUnit = import('/lua/terranunits.lua').TMassStorageUnit

BEB1106 = Class(TMassStorageUnit) {

    OnStopBeingBuilt = function(self,builder,layer)
        TMassStorageUnit.OnStopBeingBuilt(self,builder,layer)
        self.Trash:Add(CreateStorageManip(self, 'Mass', 'MASS', 0, 0, 0, 0, 0, 0.6))
		self.Trash:Add(CreateStorageManip(self, 'Energy', 'ENERGY', 0, 0, 0, 0, 0, 0.7))
    end,
}

TypeClass = BEB1106