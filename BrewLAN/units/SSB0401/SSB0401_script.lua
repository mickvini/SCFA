--------------------------------------------------------------------------------
--  Summary:  The Gantry script
--   Author:  Sean 'Balthazar' Wheeldon
--------------------------------------------------------------------------------
local SSeaFactoryUnit = import('/lua/seraphimunits.lua').SSeaFactoryUnit
--------------------------------------------------------------------------------
local BrewLANPath = import( '/lua/game.lua' ).BrewLANPath()
local Buff = import(BrewLANPath .. '/lua/legacy/VersionCheck.lua').Buff
local GantryUtils = import(BrewLANPath .. '/lua/GantryUtils.lua')
local BuildModeChange = GantryUtils.BuildModeChange
local AIStartOrders = GantryUtils.AIStartOrders
local AIControl = GantryUtils.AIControl
local AIStartCheats = GantryUtils.AIStartCheats
local AICheats = GantryUtils.AICheats
local OffsetBoneToSurface = import(BrewLANPath .. '/lua/terrainutils.lua').OffsetBoneToSurface
--------------------------------------------------------------------------------
SSB0401 = Class(SSeaFactoryUnit) {

    OnKilled = function(self, instigator, type, overkillRatio)
        SSeaFactoryUnit.OnKilled(self, instigator, type, overkillRatio)
    end,

    OnStopBeingBuilt = function(self, builder, layer)
        AIStartCheats(self, Buff)
        SSeaFactoryUnit.OnStopBeingBuilt(self, builder, layer)
        AIStartOrders(self)
    end,

}

TypeClass = SSB0401
