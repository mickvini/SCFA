#****************************************************************************
#**
#**  File     : /cdimage/lua/modules/terranprojectiles.lua
#**  Author(s): John Comes, Gordon Duclos
#**
#**  Summary  :
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
#------------------------------------------------------------------------
#  TERRAN PROJECTILES SCRIPTS
#------------------------------------------------------------------------
local Projectile = import('/lua/sim/projectile.lua').Projectile
local DefaultProjectileFile = import('/lua/sim/defaultprojectiles.lua')
local EmitterProjectile = DefaultProjectileFile.EmitterProjectile
local OnWaterEntryEmitterProjectile = DefaultProjectileFile.OnWaterEntryEmitterProjectile
local SingleBeamProjectile = DefaultProjectileFile.SingleBeamProjectile
local SinglePolyTrailProjectile = DefaultProjectileFile.SinglePolyTrailProjectile
local MultiPolyTrailProjectile = DefaultProjectileFile.MultiPolyTrailProjectile
local SingleCompositeEmitterProjectile = DefaultProjectileFile.SingleCompositeEmitterProjectile
local Explosion = import('defaultexplosions.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local DepthCharge = import('/lua/defaultantiprojectile.lua').DepthCharge
local util = import('utilities.lua')
local DefaultExplosion = import('defaultexplosions.lua')

TIFMissileNuke = Class(SingleBeamProjectile) {
    BeamName = '/effects/emitters/missile_exhaust_fire_beam_01_emit.bp',
    FxImpactUnit = {},
    FxImpactLand = {},
    FxImpactUnderWater = {},
}

TIFTacticalNuke = Class(EmitterProjectile) {
    FxImpactUnit = {},
    FxImpactLand = {},
    FxImpactUnderWater = {},
}

#--------------------------------------
# UEF GINSU RAPID PULSE BEAM PROJECTILE
#--------------------------------------
TAAGinsuRapidPulseBeamProjectile = Class(SingleBeamProjectile) {
    BeamName = '/effects/emitters/laserturret_munition_beam_03_emit.bp',
    FxUnitHitScale = 1.0,
    FxLandHitScale = 1.0,
    FxWaterHitScale = 1.0,
    FxUnderWaterHitScale = 1.0,
    FxAirUnitHitScale = 1.0,
    FxNoneHitScale = 1.0,		
    FxImpactUnit = EffectTemplate.THeavyPlasmaGatlingCannonHit,
    FxImpactProp = EffectTemplate.THeavyPlasmaGatlingCannonHit,
    FxImpactWater = EffectTemplate.THeavyPlasmaGatlingCannonHit,
    FxImpactLand = EffectTemplate.THeavyPlasmaGatlingCannonHit,
	FxImpactAirUnit = EffectTemplate.THeavyPlasmaGatlingCannonHit,
    FxImpactUnderWater = {},
}

#------------------------------------------------------------------------
#  TERRAN AA PROJECTILES
#------------------------------------------------------------------------
TAALightFragmentationProjectile = Class(SingleCompositeEmitterProjectile) {
    BeamName = '/effects/emitters/antiair_munition_beam_01_emit.bp',
    PolyTrail = '/effects/emitters/default_polytrail_01_emit.bp',
    PolyTrailOffset = 0,
    FxTrails = {'/effects/emitters/terran_flack_fxtrail_01_emit.bp'},
    FxImpactAirUnit = EffectTemplate.TFragmentationShell01,
    FxImpactNone = EffectTemplate.TFragmentationShell01,
    FxImpactUnderWater = {},
}

#------------------------------------------------------------------------
#  TERRAN ANTIMATTER ARTILLERY PROJECTILES
#------------------------------------------------------------------------
TArtilleryAntiMatterProjectile = Class(SinglePolyTrailProjectile) {
	FxImpactTrajectoryAligned = false,
    PolyTrail = '/effects/emitters/default_polytrail_01_emit.bp',
    PolyTrailOffset = 0,

    # Hit Effects
    FxImpactUnit = EffectTemplate.TAntiMatterShellHit01,
    FxImpactProp = EffectTemplate.TAntiMatterShellHit01,
    FxImpactLand = EffectTemplate.TAntiMatterShellHit01,
    FxUnitHitScale = 1.5,
    FxLandHitScale = 1.5,
    FxWaterHitScale = 1.5,
    FxUnderWaterHitScale = 1.5,
    FxAirUnitHitScale = 1.5,
    FxNoneHitScale = 1.5,
    FxImpactUnderWater = {},
    FxSplatScale = 8,

    OnImpact = function(self, targetType, targetEntity)
        local army = self:GetArmy()
        CreateLightParticle( self, -1, army, 16, 60, 'glow_03', 'ramp_antimatter_02' )
        if targetType == 'Terrain' then
            CreateDecal( self:GetPosition(), util.GetRandomFloat(0,2*math.pi), 'nuke_scorch_001_normals', '', 'Alpha Normals', self.FxSplatScale, self.FxSplatScale, 150, 200, army )
            CreateDecal( self:GetPosition(), util.GetRandomFloat(0,2*math.pi), 'nuke_scorch_002_albedo', '', 'Albedo', self.FxSplatScale * 2, self.FxSplatScale * 2, 150, 200, army )
            self:ShakeCamera(20, 1, 0, 1)
        end
        local pos = self:GetPosition()
        DamageArea(self, pos, self.DamageData.DamageRadius, 1, 'Force', true)
        DamageArea(self, pos, self.DamageData.DamageRadius, 1, 'Force', true)
        EmitterProjectile.OnImpact(self, targetType, targetEntity)
    end,
}

TArtilleryAntiMatterProjectile02 = Class(TArtilleryAntiMatterProjectile) {
	PolyTrail = '/effects/emitters/default_polytrail_07_emit.bp',

    # Hit Effects
    FxImpactUnit = EffectTemplate.TAntiMatterShellHit02,
    FxImpactProp = EffectTemplate.TAntiMatterShellHit02,
    FxImpactLand = EffectTemplate.TAntiMatterShellHit02,

    FxUnitHitScale = 0.7,
    FxLandHitScale = 0.7,
    FxWaterHitScale = 0.7,
    FxUnderWaterHitScale = 0.7,
    FxAirUnitHitScale = 0.7,
    FxNoneHitScale = 0.7,  
    FxSplatScale = 0.9, 
    OnImpact = function(self, targetType, targetEntity)
        local army = self:GetArmy()
        #CreateLightParticle( self, -1, army, 16, 6, 'glow_03', 'ramp_antimatter_02' )
        if targetType == 'Terrain' then
            CreateDecal( self:GetPosition(), util.GetRandomFloat(0,2*math.pi), 'nuke_scorch_001_normals', '', 'Alpha Normals', self.FxSplatScale * 2, self.FxSplatScale, 150, 30, army )
            CreateDecal( self:GetPosition(), util.GetRandomFloat(0,2*math.pi), 'nuke_scorch_002_albedo', '', 'Albedo', self.FxSplatScale * 3, self.FxSplatScale * 2, 150, 30, army )
            self:ShakeCamera(20, 1, 0, 1)
            DefaultExplosion.CreateScorchMarkSplat( self, 1.5 )
        end
        local pos = self:GetPosition()
        DamageArea(self, pos, self.DamageData.DamageRadius, 1, 'Force', true)
        DamageArea(self, pos, self.DamageData.DamageRadius, 1, 'Force', true)
        EmitterProjectile.OnImpact(self, targetType, targetEntity)
    end,
}

TArtilleryAntiMatterSmallProjectile = Class(TArtilleryAntiMatterProjectile) {
    FxLandHitScale = 0.5,
    FxUnitHitScale = 0.5,
    FxSplatScale = 4,
}

#------------------------------------------------------------------------
#  TERRAN ARTILLERY PROJECTILES
#------------------------------------------------------------------------
TArtilleryProjectile = Class(EmitterProjectile) {
    FxTrails = {'/effects/emitters/mortar_munition_01_emit.bp',},
    FxImpactUnit = EffectTemplate.TPlasmaCannonHeavyHitUnit01,
    FxImpactProp = EffectTemplate.TPlasmaCannonHeavyHitUnit01,
    FxImpactLand = EffectTemplate.TPlasmaCannonHeavyHitLand01,
}
TArtilleryProjectilePolytrail = Class(SinglePolyTrailProjectile) {
    FxImpactUnit = EffectTemplate.TPlasmaCannonHeavyHitUnit01,
    FxImpactProp = EffectTemplate.TPlasmaCannonHeavyHitUnit01,
    FxImpactLand = EffectTemplate.TPlasmaCannonHeavyHitLand01,
    FxUnitHitScale = 2,
    FxLandHitScale = 2,
    FxWaterHitScale = 2,
    FxUnderWaterHitScale = 2,
    FxAirUnitHitScale = 2,
    FxNoneHitScale = 2,

    OnCreate = function(self)
        SinglePolyTrailProjectile.OnCreate(self)
        self.Impacted = false
    end,
    DelayedDestroyThread = function(self)
        WaitSeconds( 0.3 )
        self.CreateImpactEffects( self, self:GetArmy(), self.FxImpactUnit, self.FxUnitHitScale )
        self:Destroy()
    end,        
    OnImpact = function(self, TargetType, TargetEntity)
        if self.Impacted == false then
            self.Impacted = true
            if TargetType == 'Terrain' then
                SinglePolyTrailProjectile.OnImpact(self, TargetType, TargetEntity)
                self:ForkThread( self.DelayedDestroyThread )
                DefaultExplosion.CreateScorchMarkSplat( self, 1.9 )
            else
                SinglePolyTrailProjectile.OnImpact(self, TargetType, TargetEntity)
                self:Destroy()
            end
        end
     end,   
}

#------------------------------------------------------------------------
#  TERRAN SHIP CANNON PROJECTILES
#------------------------------------------------------------------------
TCannonSeaProjectile = Class(SingleBeamProjectile) {
    BeamName = '/effects/emitters/cannon_munition_ship_beam_01_emit.bp',
    FxImpactUnderWater = {},
}

#------------------------------------------------------------------------
#  TERRAN TANK CANNON PROJECTILES
#------------------------------------------------------------------------
TCannonTankProjectile = Class(SingleBeamProjectile) {
    BeamName = '/effects/emitters/cannon_munition_tank_beam_01_emit.bp',
    FxImpactUnderWater = {},
}

#------------------------------------------------------------------------
#  TERRAN DEPTH CHARGE PROJECTILES
#------------------------------------------------------------------------
TDepthChargeProjectile = Class(OnWaterEntryEmitterProjectile) {
    FxInitial = {},
    FxTrails = {'/effects/emitters/torpedo_underwater_wake_01_emit.bp',},
    TrailDelay = 0,

    # Hit Effects
    FxImpactLand = {},
    FxUnitHitScale = 1.5,
    FxLandHitScale = 1.5,
    FxWaterHitScale = 1.5,
    FxUnderWaterHitScale = 1.5,
    FxAirUnitHitScale = 1.5,
    FxNoneHitScale = 1.5,
    FxImpactUnit = EffectTemplate.TTorpedoHitUnit01,
    FxImpactProp = EffectTemplate.TTorpedoHitUnit01,
    FxImpactUnderWater = EffectTemplate.TTorpedoHitUnit01,
    FxImpactProjectile = EffectTemplate.TTorpedoHitUnit01,
    FxImpactNone = {},
    FxEnterWater= EffectTemplate.WaterSplash01,

    OnCreate = function(self, inWater)
        OnWaterEntryEmitterProjectile.OnCreate(self)
        self:TrackTarget(false)
    end,

    OnEnterWater = function(self)
        OnWaterEntryEmitterProjectile.OnEnterWater(self)
        local army = self:GetArmy()

        for k, v in self.FxEnterWater do #splash
            CreateEmitterAtEntity(self,army,v)
        end

        self:TrackTarget(false)
        self:StayUnderwater(true)
        self:SetTurnRate(0)
        self:SetMaxSpeed(1)
        self:SetVelocity(0, -0.25, 0)
        self:SetVelocity(0.25)
    end,

    AddDepthCharge = function(self, tbl)
        if not tbl then return end
        if not tbl.Radius then return end
        self.MyDepthCharge = DepthCharge {
            Owner = self,
            Radius = tbl.Radius or 10,
        }
        self.Trash:Add(self.MyDepthCharge)
    end,
}



#------------------------------------------------------------------------
#  TERRAN GAUSS CANNON PROJECTILES
#------------------------------------------------------------------------
TDFGaussCannonProjectile = Class(MultiPolyTrailProjectile) {
    FxTrails = {},
    PolyTrails = EffectTemplate.TGaussCannonPolyTrail,
    PolyTrailOffset = {0,0},
    FxImpactUnit = EffectTemplate.TGaussCannonHitUnit01,
    FxImpactProp = EffectTemplate.TGaussCannonHitUnit01,
    FxImpactLand = EffectTemplate.TGaussCannonHitLand01,
    FxTrailOffset = 0,
    FxImpactUnderWater = {},
    FxUnitHitScale = 2,
    FxLandHitScale = 2,
}

#------------------------------------------------------------------------
#  TERRAN HEAVY PLASMA CANNON PROJECTILES
#------------------------------------------------------------------------
THeavyPlasmaCannonProjectile = Class(MultiPolyTrailProjectile) {
    FxTrails = EffectTemplate.TPlasmaCannonHeavyMunition,
    RandomPolyTrails = 1,
    PolyTrailOffset = {0,0,0},
    PolyTrails = EffectTemplate.TPlasmaCannonHeavyPolyTrails,
    FxImpactUnit = EffectTemplate.TPlasmaCannonHeavyHitUnit01,
    FxImpactProp = EffectTemplate.TPlasmaCannonHeavyHitUnit01,
    FxImpactLand = EffectTemplate.TPlasmaCannonHeavyHitLand01,
}


#------------------------------
#  UEF SMALL YIELD NUCLEAR BOMB
#------------------------------
TIFSmallYieldNuclearBombProjectile = Class(EmitterProjectile) {
    FxTrails = {},
    FxImpactUnit = EffectTemplate.TSmallYieldNuclearBombHit01,
    FxImpactProp = EffectTemplate.TSmallYieldNuclearBombHit01,
    FxImpactLand = EffectTemplate.TSmallYieldNuclearBombHit01,
    FxImpactUnderWater = {},

    OnImpact = function(self, TargetType, TargetEntity)
        local army = self:GetArmy()
        CreateLightParticle( self, -1, army, 8, 4, 'glow_03', 'ramp_fire_01' )
        if TargetType == 'Terrain' then
            CreateSplat( self:GetPosition(), 0, 'scorch_008_albedo', 6, 6, 250, 200, army )

            #local blanketSides = 12
            #local blanketAngle = (2*math.pi) / blanketSides
            #local blanketStrength = 1
            #local blanketVelocity = 2.25

            #for i = 0, (blanketSides-1) do
            #    local blanketX = math.sin(i*blanketAngle)
            #    local blanketZ = math.cos(i*blanketAngle)
            #    local Blanketparts = self:CreateProjectile('/effects/entities/DestructionDust01/DestructionDust01_proj.bp', blanketX, 0.5, blanketZ, blanketX, 0, blanketZ)
            #        :SetVelocity(blanketVelocity):SetAcceleration(-0.3)
            #end
        end
        EmitterProjectile.OnImpact( self, TargetType, TargetEntity )
    end,
}

#------------------------------------------------------------------------
#  TERRAN BOT LASER PROJECTILES
#------------------------------------------------------------------------
TLaserBotProjectile = Class(MultiPolyTrailProjectile) {
    PolyTrails = {
        '/effects/emitters/laserturret_munition_trail_01_emit.bp',
        '/effects/emitters/default_polytrail_06_emit.bp',
    },
    FxTrailScale = 4.6,   
    FxUnitHitScale = 1.4,
    FxLandHitScale = 1.4,
    FxWaterHitScale = 1.4,
    FxUnderWaterHitScale = 1.4,
    FxAirUnitHitScale = 1.4,
    FxNoneHitScale = 1.4,   
    PolyTrailOffset = {0,0},
    #BeamName = '/effects/emitters/laserturret_munition_beam_03_emit.bp',
    FxImpactUnit = EffectTemplate.TLaserHitUnit02,
    FxImpactProp = EffectTemplate.TLaserHitUnit02,
    FxImpactLand = EffectTemplate.TLaserHitLand02,
    FxImpactUnderWater = {},
}

#------------------------------------------------------------------------
#  TERRAN LASER PROJECTILES
#------------------------------------------------------------------------
TLaserProjectile = Class(SingleBeamProjectile) {
    BeamName = '/effects/emitters/laserturret_munition_beam_02_emit.bp',
    FxImpactUnit = EffectTemplate.TLaserHitUnit01,
    FxImpactProp = EffectTemplate.TLaserHitUnit01,
    FxImpactLand = EffectTemplate.TLaserHitLand01,
    FxImpactUnderWater = {},
}

#------------------------------------------------------------------------
#  TERRAN MACHINE GUN SHELLS
#------------------------------------------------------------------------
TMachineGunProjectile = Class(SinglePolyTrailProjectile) {
    PolyTrail = EffectTemplate.TMachineGunPolyTrail,
    FxTrails = {},
    FxImpactUnit = {'/effects/emitters/gauss_cannon_muzzle_flash_01_emit.bp'},
    FxImpactProp = {'/effects/emitters/gauss_cannon_muzzle_flash_01_emit.bp'},
    FxImpactLand = {'/effects/emitters/gauss_cannon_muzzle_flash_01_emit.bp'},
}


#------------------------------------------------------------------------
#  TERRAN AA MISSILE PROJECTILES - Air Targets
#------------------------------------------------------------------------
TMissileAAProjectile = Class(EmitterProjectile) {
# Emitter Values
    FxInitial = {},
    TrailDelay = 1,
    FxTrails = {'/effects/emitters/missile_sam_munition_trail_01_emit.bp',},
    FxTrailOffset = -0.5,

    FxImpactUnit = EffectTemplate.TMissileHit01,
    FxImpactProp = EffectTemplate.TMissileHit01,
    FxImpactLand = EffectTemplate.TMissileHit01,
    FxImpactAirUnit = EffectTemplate.TMissileHit01,
    FxAirUnitHitScale = 1.5,
    FxLandHitScale = 1.5,
    FxNoneHitScale = 1.5,
    FxPropHitScale = 1.5,
    FxShieldHitScale = 1.5,
    FxUnitHitScale = 1.5,
    FxWaterHitScale = 1.5,
    FxImpactUnderWater = {},
}

TAntiNukeInterceptorProjectile = Class(SingleBeamProjectile) {
    BeamName = '/effects/emitters/missile_exhaust_fire_beam_02_emit.bp',
    FxTrails = EffectTemplate.TMissileExhaust03,

    FxImpactUnit = EffectTemplate.TMissileHit01,
    FxImpactProp = EffectTemplate.TMissileHit01,
    FxImpactLand = EffectTemplate.TMissileHit01,
    FxImpactProjectile = EffectTemplate.TMissileHit01,
    FxProjectileHitScale = 5,
    FxImpactUnderWater = {},
}


#------------------------------------------------------------------------
#  TERRAN CRUISE MISSILE PROJECTILES - Surface Targets
#------------------------------------------------------------------------
TMissileCruiseProjectile = Class(SingleBeamProjectile) {
    DestroyOnImpact = false,
    FxTrails = EffectTemplate.TMissileExhaust02,
    FxTrailOffset = -1,
    BeamName = '/effects/emitters/missile_munition_exhaust_beam_01_emit.bp',

    FxUnitHitScale = 2,
    FxLandHitScale = 2,
    FxWaterHitScale = 2,
    FxUnderWaterHitScale = 2,
    FxAirUnitHitScale = 2,
    FxNoneHitScale = 2,  
    FxImpactUnit = EffectTemplate.TMissileHit01,
    FxImpactLand = EffectTemplate.TMissileHit01,
    FxImpactProp = EffectTemplate.TMissileHit01,
    FxImpactUnderWater = {},

    OnImpact = function(self, targetType, targetEntity)
        local army = self:GetArmy()
        #CreateLightParticle( self, -1, army, 8, 4, 'glow_03', 'ramp_fire_01' )
        SingleBeamProjectile.OnImpact(self, targetType, targetEntity)
        DefaultExplosion.CreateScorchMarkSplat( self, 1.7 )
    end,

    CreateImpactEffects = function( self, army, EffectTable, EffectScale )
        local emit = nil
        for k, v in EffectTable do
            emit = CreateEmitterAtEntity(self,army,v)
            if emit and EffectScale != 1 then
                emit:ScaleEmitter(EffectScale or 1)
            end
        end
    end,
}



#------------------------------------------------------------------------
#  TERRAN SUB-LAUNCHED CRUISE MISSILE PROJECTILES
#------------------------------------------------------------------------
TMissileCruiseSubProjectile = Class(SingleBeamProjectile) {
    FxExitWaterEmitter = EffectTemplate.TIFCruiseMissileLaunchExitWater,
    FxTrailOffset = -0.35,

    # TRAILS
    FxTrails = EffectTemplate.TMissileExhaust02,
    BeamName = '/effects/emitters/missile_munition_exhaust_beam_01_emit.bp',

    # Hit Effects
    FxImpactUnit = EffectTemplate.TMissileHit01,
    FxImpactLand = EffectTemplate.TMissileHit01,
    FxImpactProp = EffectTemplate.TMissileHit01,
    FxImpactUnderWater = {},

    OnExitWater = function(self)
		EmitterProjectile.OnExitWater(self)
		local army = self:GetArmy()
		for k, v in self.FxExitWaterEmitter do
			CreateEmitterAtBone(self,-2,army,v)
		end
    end,

}

#------------------------------------------------------------------------
#  TERRAN MISSILE PROJECTILES - General Purpose
#------------------------------------------------------------------------
TMissileProjectile = Class(SingleBeamProjectile) {
    FxTrails = {'/effects/emitters/missile_munition_trail_01_emit.bp',},
    FxTrailOffset = -1,
    BeamName = '/effects/emitters/missile_munition_exhaust_beam_01_emit.bp',

    FxImpactUnit = EffectTemplate.TMissileHit01,
    FxImpactProp = EffectTemplate.TMissileHit01,
    FxImpactLand = EffectTemplate.TMissileHit01,
    FxImpactUnderWater = {},
}

#------------------------------------------------------------------------
#  TERRAN NAPALM CARPET BOMB
#------------------------------------------------------------------------
TNapalmCarpetBombProjectile = Class(EmitterProjectile) {
    FxTrails = {},

    # Hit Effects
    FxImpactUnit = EffectTemplate.TNapalmCarpetBombHitUnit01,
    FxImpactProp = EffectTemplate.TNapalmCarpetBombHitUnit01,
    FxImpactLand = EffectTemplate.TNapalmCarpetBombHitLand01,
    FxImpactUnderWater = {},
}

#------------------------------------------------------------------------
#  TERRAN PLASMA CANNON PROJECTILES
#------------------------------------------------------------------------
TPlasmaCannonProjectile = Class(SinglePolyTrailProjectile) {
    FxTrails = EffectTemplate.TPlasmaCannonLightMunition,
    PolyTrailOffset = 0,
    PolyTrail = EffectTemplate.TPlasmaCannonLightPolyTrail,
    FxImpactUnit = EffectTemplate.TPlasmaCannonLightHitUnit01,
    FxImpactProp = EffectTemplate.TPlasmaCannonLightHitUnit01,
    FxImpactLand = EffectTemplate.TPlasmaCannonLightHitLand01,
}

#------------------------------------------------------------------------
#  TERRAN RAIL GUN PROJECTILES
#------------------------------------------------------------------------
TRailGunProjectile = Class(SinglePolyTrailProjectile) {
    #FxTrails = {'/effects/emitters/railgun_munition_trail_02_emit.bp' },
    PolyTrail = '/effects/emitters/railgun_polytrail_01_emit.bp',
    FxTrailScale = 1,
    FxTrailOffset = 0,
    FxImpactUnderWater = {},
    FxImpactUnit = EffectTemplate.TRailGunHitGround01,
    FxImpactProp = EffectTemplate.TRailGunHitGround01,
	FxImpactAirUnit = EffectTemplate.TRailGunHitAir01,
}

#------------------------------------------------------------------------
#  TERRAN PHALANX PROJECTILES
#------------------------------------------------------------------------
TShellPhalanxProjectile = Class(MultiPolyTrailProjectile) {
    PolyTrails = EffectTemplate.TPhalanxGunPolyTrails,
    PolyTrailOffset = EffectTemplate.TPhalanxGunPolyTrailsOffsets,
    FxImpactUnit = EffectTemplate.TRiotGunHitUnit01,
    FxImpactProp = EffectTemplate.TRiotGunHitUnit01,
    FxImpactNone = EffectTemplate.FireCloudSml01,
    FxImpactLand = EffectTemplate.TRiotGunHit01,
    FxImpactUnderWater = {},
}

#------------------------------------------------------------------------
#  TERRAN RIOT PROJECTILES
#------------------------------------------------------------------------
TShellRiotProjectile = Class(MultiPolyTrailProjectile) {
    PolyTrails = EffectTemplate.TRiotGunPolyTrails,
    PolyTrailOffset = EffectTemplate.TRiotGunPolyTrailsOffsets,
    FxTrails = EffectTemplate.TRiotGunMunition01,
    RandomPolyTrails = 1,
    FxImpactUnit = EffectTemplate.TRiotGunHitUnit01,
    FxImpactProp = EffectTemplate.TRiotGunHitUnit01,
    FxImpactLand = EffectTemplate.TRiotGunHit01,
    FxImpactUnderWater = {},
}

#------------------------------------------------------------------------
#  TERRAN ABOVE WATER LAUNCHED TORPEDO
#------------------------------------------------------------------------
TTorpedoShipProjectile = Class(OnWaterEntryEmitterProjectile) {
    FxInitial = {},
    FxTrails = {'/effects/emitters/torpedo_underwater_wake_01_emit.bp',},
    TrailDelay = 0,

    # Hit Effects
    FxImpactLand = {},
    FxUnitHitScale = 1.0,
    FxLandHitScale = 1.0,
    FxWaterHitScale = 1.0,
    FxUnderWaterHitScale = 1.0,
    FxAirUnitHitScale = 1.0,
    FxNoneHitScale = 1.0,
    FxImpactUnit = EffectTemplate.TTorpedoHitUnit01,
    FxImpactProp = EffectTemplate.TTorpedoHitUnit01,
    FxImpactUnderWater = EffectTemplate.TTorpedoHitUnitUnderwater01,
    FxImpactNone = {},
    FxEnterWater= EffectTemplate.WaterSplash01,

    OnCreate = function(self, inWater)
        self:SetCollisionShape('Sphere', 0, 0, 0, 1.0)
        OnWaterEntryEmitterProjectile.OnCreate(self)
        # if we are starting in the water then immediately switch to tracking in water and
        # create underwater trail effects
        if inWater == true then
            self:TrackTarget(true):StayUnderwater(true)
            OnWaterEntryEmitterProjectile.OnEnterWater(self)
        end
    end,

    OnEnterWater = function(self)
        OnWaterEntryEmitterProjectile.OnEnterWater(self)
        local army = self:GetArmy()

        for k, v in self.FxEnterWater do #splash
            CreateEmitterAtEntity(self,army,v)
        end
        self:TrackTarget(true)
        self:StayUnderwater(true)
        self:SetTurnRate(720)
        self:SetMaxSpeed(18)
        self:SetVelocity(0)
        self:ForkThread(self.MovementThread)
    end,
    
    MovementThread = function(self)
        WaitTicks(1)
        self:SetVelocity(3)
    end,
}
#------------------------------------------------------------------------
#  TERRAN SUB LAUNCHED TORPEDO
#------------------------------------------------------------------------
TTorpedoSubProjectile = Class(EmitterProjectile) {
    FxTrails = {'/effects/emitters/torpedo_munition_trail_01_emit.bp',},
    FxImpactLand = {},
    FxUnitHitScale = 1.0,
    FxLandHitScale = 1.0,
    FxWaterHitScale = 1.0,
    FxUnderWaterHitScale = 1.0,
    FxAirUnitHitScale = 1.0,
    FxNoneHitScale = 1.0,
    FxImpactUnit = EffectTemplate.TTorpedoHitUnit01,
    FxImpactProp = EffectTemplate.TTorpedoHitUnit01,
    FxImpactUnderWater = EffectTemplate.TTorpedoHitUnit01,
    FxImpactNone = {},
    OnCreate = function(self, inWater)
        self:SetCollisionShape('Sphere', 0, 0, 0, 1.0)
        EmitterProjectile.OnCreate(self, inWater)
    end,
}

