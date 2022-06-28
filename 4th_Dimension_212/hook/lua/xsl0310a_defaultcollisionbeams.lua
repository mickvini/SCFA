#****************************************************************************
#**  File     :  /lua/xsl0310a_defaultcollisionbeams.lua
#**  Author(s):  Ebola_Soup, Resin Smoker 
#**
#**  (Weapon Templates by:Exavier Macbeth)
#**
#**  Copyright © 2009 4th_Dimension.  All rights reserved.
#****************************************************************************

local CollisionBeam = import('/lua/sim/CollisionBeam.lua').CollisionBeam
local EffectTemplate = import('/lua/EffectTemplates.lua')
local xsl0310a_EffectTemplate = import('/mods/4th_Dimension_212/hook/lua/xsl0310a_EffectTemplates.lua')
local Util = import('/lua/utilities.lua')
EmtBpPath = '/effects/emitters/'

#-----------------------------
#   Base class that defines supreme commander specific defaults
#-----------------------------
SCCollisionBeam = Class(CollisionBeam) {
    FxImpactUnit = EffectTemplate.DefaultProjectileLandUnitImpact,
    FxUnitHitScale = 0.3,     
    FxImpactLand = EffectTemplate.DefaultProjectileLandImpact,
    FxLandHitScale = .3,    
    FxImpactWater = EffectTemplate.DefaultProjectileWaterImpact,
    FxImpactUnderWater = EffectTemplate.DefaultProjectileUnderWaterImpact,
    FxImpactAirUnit = EffectTemplate.DefaultProjectileAirUnitImpact,
    FxImpactProp = {},
    FxImpactShield = {},    
    FxImpactNone = {},
}

#-----------------------------
#   Start Your Code Here
#-----------------------------

xsl0310a_LightningBeam = Class(SCCollisionBeam) {

    TerrainImpactType = 'LargeBeam01',
    TerrainImpactScale = 0.25,
    FxBeamStartPoint = EffectTemplate.SExperimentalUnstablePhasonLaserMuzzle01,
    FxBeam = xsl0310a_EffectTemplate.OthuyElectricityStrikeBeam,
    FxBeamEndPoint = EffectTemplate.OthuyElectricityStrikeHit,
    FxBeamEndPointScale = .25, 
    SplatTexture = 'czar_mark01_albedo',
    ScorchSplatDropTime = 0.1,

    OnImpact = function(self, impactType, targetEntity)
        if impactType == 'Terrain' then
            if self.Scorching == nil then
                self.Scorching = self:ForkThread( self.ScorchThread )   
            end
        elseif not impactType == 'Unit' then
            KillThread(self.Scorching)
            self.Scorching = nil
        end
        SCCollisionBeam.OnImpact(self, impactType, targetEntity)
    end,

    OnDisable = function( self )
        SCCollisionBeam.OnDisable(self)
        KillThread(self.Scorching)
        self.Scorching = nil   
    end,

    ScorchThread = function(self)
        local army = self:GetArmy()
        local size = 1.5 + (Random() * 1.5) 
        local CurrentPosition = self:GetPosition(1)
        local LastPosition = Vector(0,0,0)
        local skipCount = 1
        while true do
            if Util.GetDistanceBetweenTwoVectors( CurrentPosition, LastPosition ) > 0.25 or skipCount > 100 then
                CreateSplat( CurrentPosition, Util.GetRandomFloat(0,2*math.pi), self.SplatTexture, size, size, 100, 100, army )
                LastPosition = CurrentPosition
                skipCount = 1
            else
                skipCount = skipCount + self.ScorchSplatDropTime
            end
                
            WaitSeconds( self.ScorchSplatDropTime )
            size = 1.2 + (Random() * 1.5)
            CurrentPosition = self:GetPosition(1)
        end
    end,
}