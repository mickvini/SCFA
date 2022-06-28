#****************************************************************************
#**
#**  File     :  /cdimage/lua/modules/aeonprojectiles.lua
#**  Author(s):  John Comes, Gordon Duclos
#**
#**  Summary  :
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
#------------------------------------------------------------------------
#  AEON PROJECTILES SCRIPTS
#------------------------------------------------------------------------
local DefaultProjectileFile = import('/lua/sim/defaultprojectiles.lua')
local GetRandomFloat = import('utilities.lua').GetRandomFloat
local EmitterProjectile = DefaultProjectileFile.EmitterProjectile
local OnWaterEntryEmitterProjectile = DefaultProjectileFile.OnWaterEntryEmitterProjectile
local SingleBeamProjectile = DefaultProjectileFile.SingleBeamProjectile
local SinglePolyTrailProjectile = DefaultProjectileFile.SinglePolyTrailProjectile
local MultiPolyTrailProjectile = DefaultProjectileFile.MultiPolyTrailProjectile
local SingleCompositeEmitterProjectile = DefaultProjectileFile.SingleCompositeEmitterProjectile
local MultiCompositeEmitterProjectile = DefaultProjectileFile.MultiCompositeEmitterProjectile
local NullShell = DefaultProjectileFile.NullShell
local DefaultExplosion = import('defaultexplosions.lua')
local DepthCharge = import('/lua/defaultantiprojectile.lua').DepthCharge
local EffectTemplate = import('/lua/EffectTemplates.lua')

#------------------------------------------------------------------------
#  AEON ARROW MISSILE PROJECTILES (4th Dimension Custom Projectile)
#------------------------------------------------------------------------
AMissileArrowProjectile = Class(SingleCompositeEmitterProjectile) {
    PolyTrail = '/effects/emitters/serpentine_missile_trail_emit.bp',
    BeamName = '/effects/emitters/serpentine_missle_exhaust_beam_01_emit.bp',
    PolyTrailOffset = -0.05,

    FxUnitHitScale = 3.0,
    FxLandHitScale = 3.0,
    FxWaterHitScale = 3.0,
    FxUnderWaterHitScale = 2.5,
    FxAirUnitHitScale = 3.0,
    FxNoneHitScale = 3.0,    
    FxImpactUnit = EffectTemplate.AMissileHit01,
    FxImpactProp = EffectTemplate.AMissileHit01,
    FxImpactLand = EffectTemplate.AMissileHit01,
    FxImpactUnderWater = {},
    OnCreate = function(self)
        self:SetCollisionShape('Sphere', 0, 0, 0, 1.0)
        SingleCompositeEmitterProjectile.OnCreate(self)
    end,
}

#------------------------------------------------------------------------
#  AEON LASER PHALANX PROJECTILES (4th Dimension Custom Projectile)
#------------------------------------------------------------------------
ALaserPhalanxProjectile = Class(MultiPolyTrailProjectile) {
    #PolyTrails = {
    #    '/mods/4th_Dimension_194/hook/effects/Emitters/aeon_laser_phalanx_01_emit.bp',
    #},
    #offset is needed for proj to hit the missiles
 
	PolyTrails = {
  	'/effects/emitters/disintegrator_polytrail_04_emit.bp',
  	'/effects/emitters/disintegrator_polytrail_05_emit.bp',
  	'/effects/emitters/default_polytrail_03_emit.bp',
 	},
 
    PolyTrailOffset = EffectTemplate.TPhalanxGunPolyTrailsOffsets,
    FxTrailScale = 0.25,
    FxImpactUnit = {},
    FxImpactProp = {},
    FxImpactNone = {},
    FxImpactLand = {},
    FxImpactUnderWater = {},
    FxImpactProjectile = EffectTemplate.TMissileHit02,
    FxProjectileHitScale = 0.5,
}

#------------------------------------------------------------------------
#  AEON ANTI-NUKE PROJECTILES
#------------------------------------------------------------------------
ASaintAntiNuke = Class(SinglePolyTrailProjectile) {
    PolyTrail = '/effects/emitters/aeon_missile_trail_02_emit.bp',
    FxTrails = {'/effects/emitters/saint_munition_01_emit.bp'},

    FxImpactUnit = EffectTemplate.AMissileHit01,
    FxImpactProp = EffectTemplate.AMissileHit01,
    FxImpactNone = EffectTemplate.AMissileHit01,
    FxImpactLand = EffectTemplate.AMissileHit01,
    FxImpactProjectile = EffectTemplate.ASaintImpact01,
    FxImpactUnderWater = {},

}

#------------------------------------------------------------------------
#  AEON ARTILLERY PROJECTILES
#------------------------------------------------------------------------
AArtilleryProjectile = Class(EmitterProjectile) {
    FxTrails = EffectTemplate.AQuarkBomb01,
    FxTrailScale = 0.75,

	# Hit Effects
    FxImpactUnit =  EffectTemplate.AQuarkBombHitUnit01,
    FxImpactProp =  EffectTemplate.AQuarkBombHitUnit01,
    FxImpactLand =  EffectTemplate.AQuarkBombHitLand01,
    FxImpactAirUnit =  EffectTemplate.AQuarkBombHitAirUnit01,
    FxImpactUnderWater = {},
    FxUnitHitScale = 0.6,
    FxLandHitScale = 0.6,
    FxWaterHitScale = 0.6,
    FxUnderWaterHitScale = 0.6,
    FxAirUnitHitScale = 0.6,
    FxNoneHitScale = 0.6,   
}
#------------------------------------------------------------------------
#  AEON DISRUPTORSHELL PROJECTILES
#------------------------------------------------------------------------

ADisruptorShellProjectile = Class(EmitterProjectile) {
    FxTrails = EffectTemplate.AQuarkBomb01,
    FxTrailScale = 0.5,

	# Hit Effects
    FxImpactUnit =  EffectTemplate.AQuarkBombHitUnit01,
    FxImpactProp =  EffectTemplate.AQuarkBombHitUnit01,
    FxImpactLand =  EffectTemplate.AQuarkBombHitLand01,
    FxImpactAirUnit =  EffectTemplate.AQuarkBombHitAirUnit01,
    FxImpactUnderWater = {},
    FxUnitHitScale = 0.4,
    FxLandHitScale = 0.4,
    FxWaterHitScale = 0.4,
    FxUnderWaterHitScale = 0.4,
    FxAirUnitHitScale = 0.4,
    FxNoneHitScale = 0.4,   
}

#------------------------------------------------------------------------
#  AEON BEAM PROJECTILES
#------------------------------------------------------------------------
ABeamProjectile = Class(NullShell) {

# Hit Effects
    FxUnitHitScale = 0.5,
    FxImpactUnit = EffectTemplate.ABeamHitUnit01,
    FxImpactProp = EffectTemplate.ABeamHitUnit01,
    FxImpactLand = EffectTemplate.ABeamHitLand01,
    FxImpactUnderWater = {},
}

#------------------------------------------------------------------------
#  AEON GRAVITON BOMB
#------------------------------------------------------------------------
AGravitonBombProjectile = Class(SinglePolyTrailProjectile) {
	PolyTrail = '/effects/emitters/default_polytrail_03_emit.bp',
    FxTrails = {'/effects/emitters/torpedo_munition_trail_01_emit.bp',},

# Hit Effects
    FxImpactUnit = EffectTemplate.ABombHit01,
    FxImpactProp = EffectTemplate.ABombHit01,
    FxImpactLand = EffectTemplate.ABombHit01,
    FxImpactUnderWater = {},
}

#------------------------------------------------------------------------
#  AEON SHIP PROJECTILES
#------------------------------------------------------------------------
ACannonSeaProjectile = Class(SingleBeamProjectile) {
    BeamName = '/effects/emitters/cannon_munition_ship_aeon_beam_01_emit.bp',

    FxImpactUnderWater = {},
}


#------------------------------------------------------------------------
#  AEON TANK PROJECTILES
#------------------------------------------------------------------------
ACannonTankProjectile = Class(SingleBeamProjectile) {
    BeamName = '/effects/emitters/cannon_munition_ship_aeon_beam_01_emit.bp',
    #PolyTrails = {'cannon_polytrail_01'},
    FxImpactUnderWater = {},

    OnCreate = function(self)
        SingleBeamProjectile.OnCreate(self)
        if self.PolyTrails then
            for key, value in self.PolyTrails do
                CreateTrail(self,-1,self:GetArmy(), value)
            end
        end
    end,
}

#------------------------------------------------------------------------
#  AEON DEPTH CHARGE
#------------------------------------------------------------------------
ADepthChargeProjectile = Class(OnWaterEntryEmitterProjectile) {
    FxInitial = {},
    FxTrails = {'/effects/emitters/torpedo_munition_trail_01_emit.bp',},
    TrailDelay = 0,
    TrackTime = 0,

    FxUnitHitScale = 1.5,
    FxLandHitScale = 1.5,
    FxWaterHitScale = 1.5,
    FxUnderWaterHitScale = 1.5,
    FxAirUnitHitScale = 1.5,
    FxNoneHitScale = 1.5,
    FxImpactLand = {},
    FxImpactUnit = EffectTemplate.ADepthChargeHitUnit01,
    FxImpactProp = EffectTemplate.ADepthChargeHitUnit01,
    FxImpactUnderWater = EffectTemplate.ADepthChargeHitUnderWaterUnit01,
    FxImpactNone = {},

    OnCreate = function(self, inWater)
        OnWaterEntryEmitterProjectile.OnCreate(self)
        #self:TrackTarget(true)
    end,

    OnEnterWater = function(self)
        OnWaterEntryEmitterProjectile.OnEnterWater(self)
        local army = self:GetArmy()

        for k, v in self.FxEnterWater do #splash
            CreateEmitterAtEntity(self,army,v)
        end

        #self:TrackTarget(false)
        #self:StayUnderwater(true)
        #self:SetTurnRate(0)
        #self:SetMaxSpeed(1)
        #self:SetVelocity(0, -0.25, 0)
        #self:SetVelocity(0.25)
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
#  AEON ARTILLERY PROJECTILES
#------------------------------------------------------------------------
AGravitonProjectile = Class(EmitterProjectile) {

    FxTrails = {'/effects/emitters/graviton_munition_trail_01_emit.bp',},
    FxTrailScale = 0.7,    
    FxImpactUnit = EffectTemplate.AGravitonBolterHit01,
    FxImpactLand = EffectTemplate.AGravitonBolterHit01,
    FxImpactProp = EffectTemplate.AGravitonBolterHit01,
    DirectionalImpactEffect = {'/effects/emitters/graviton_bolter_hit_01_emit.bp',},
}




#------------------------------------------------------------------------
#  AEON LASER PROJECTILES
#------------------------------------------------------------------------
AHighIntensityLaserProjectile = Class(SinglePolyTrailProjectile) {

    FxTrails = {
        '/effects/emitters/aeon_laser_fxtrail_01_emit.bp',
        '/effects/emitters/aeon_laser_fxtrail_02_emit.bp',
    },
    PolyTrail = '/effects/emitters/aeon_laser_trail_01_emit.bp',

    # Hit Effects
    FxImpactUnit = EffectTemplate.AHighIntensityLaserHitUnit01,
    FxImpactProp = EffectTemplate.AHighIntensityLaserHitUnit01,
    FxImpactLand = EffectTemplate.AHighIntensityLaserHitLand01,
    FxImpactUnderWater = {},
}

#------------------------------------------------------------------------
#  AEON FLARE PROJECTILES
#------------------------------------------------------------------------
AIMFlareProjectile = Class(EmitterProjectile) {
    FxTrails = EffectTemplate.AAntiMissileFlare,
    FxTrailScale = 1.0,
    FxImpactUnit = {},
    FxImpactAirUnit = {},
    FxImpactNone = EffectTemplate.AAntiMissileFlareHit,
    FxImpactProjectile = EffectTemplate.AAntiMissileFlareHit,
    FxOnKilled = EffectTemplate.AAntiMissileFlareHit,
    FxUnitHitScale = 0.4,
    FxLandHitScale = 0.4,
    FxWaterHitScale = 0.4,
    FxUnderWaterHitScale = 0.4,
    FxAirUnitHitScale = 0.4,
    FxNoneHitScale = 0.4,
    FxImpactLand = {},
    FxImpactUnderWater = {},
    DestroyOnImpact = false,

    OnImpact = function(self, TargetType, targetEntity)
        EmitterProjectile.OnImpact(self, TargetType, targetEntity)
        if TargetType == 'Terrain' or TargetType == 'Water' or TargetType == 'Prop' then
            if self.Trash then
                self.Trash:Destroy()
            end
            self:Destroy()
        end
    end,
}

#------------------------------------------------------------------------
#  AEON LASER PROJECTILES
#------------------------------------------------------------------------
ALaserBotProjectile = Class(SinglePolyTrailProjectile) {

    PolyTrail = '/effects/emitters/aeon_laser_trail_01_emit.bp',

    # Hit Effects
    FxImpactUnit = EffectTemplate.ALaserBotHitUnit01,
    FxImpactProp = EffectTemplate.ALaserBotHitUnit01,
    FxImpactLand = EffectTemplate.ALaserBotHitLand01,
    FxImpactUnderWater = {},
}

ALaserProjectile = Class(SingleBeamProjectile) {

    BeamName = '/effects/emitters/laserturret_munition_beam_02_emit.bp',

    # Hit Effects
    FxImpactUnit = EffectTemplate.ALaserHitUnit01,
    FxImpactProp = EffectTemplate.ALaserHitUnit01,
    FxImpactLand = EffectTemplate.ALaserHitLand01,
    FxImpactUnderWater = {},
}

ALightLaserProjectile = Class(MultiPolyTrailProjectile) {

    PolyTrails = {
		'/effects/emitters/aeon_laser_trail_02_emit.bp',
	},
	PolyTrailOffset = {0,0},
	FxTrailScale = 0,
    # Hit Effects
    FxImpactUnit = EffectTemplate.ALightLaserHitUnit01,
    FxImpactProp = EffectTemplate.ALightLaserHitUnit01,
    FxImpactLand = EffectTemplate.ALightLaserHit01,
    FxImpactUnderWater = {},
}

AQuadLightLaserProjectile = Class(MultiPolyTrailProjectile) {

    PolyTrails = {
		'/effects/emitters/aeon_laser_trail_02_emit.bp',
	},
	PolyTrailOffset = {0,0},
	FxTrailScale = 1.5,
	
    # Hit Effects
    FxImpactUnit = EffectTemplate.ALightLaserHitUnit01,
    FxImpactProp = EffectTemplate.ALightLaserHitUnit01,
    FxImpactLand = EffectTemplate.ALightLaserHit01,
    FxImpactUnderWater = {},
    
    #PolyTrails = EffectTemplate.Aeon_QuadLightLaserCannonProjectilePolyTrails,
	#PolyTrailOffset = {0,0},
    #FxTrails = EffectTemplate.Aeon_QuadLightLaserCannonProjectileFxTrails,

    # Hit Effects
    #FxImpactUnit = EffectTemplate.Aeon_QuadLightLaserCannonUnitHit,
    #FxImpactProp = EffectTemplate.Aeon_QuadLightLaserCannonHit,
    #FxImpactLand = EffectTemplate.Aeon_QuadLightLaserCannonLandHit,
    #FxImpactUnderWater = EffectTemplate.Aeon_QuadLightLaserCannonLandHit,
}

ASonicPulsarProjectile = Class(EmitterProjectile){
    FxTrails = EffectTemplate.ASonicPulsarMunition01,
}


#------------------------------------------------------------------------
#  AEON ARTILLERY PROJECTILES
#------------------------------------------------------------------------
AMiasmaProjectile = Class(EmitterProjectile) {

    FxTrails = EffectTemplate.AMiasmaMunition01,
    FxImpactNone = EffectTemplate.AMiasma01,
}

AMiasmaProjectile02 = Class(EmitterProjectile) {
	FxTrails = EffectTemplate.AMiasmaMunition02,
	FxImpactLand = EffectTemplate.AMiasmaField01,
    FxImpactUnit = EffectTemplate.AMiasmaField01,
    FxImpactProp = EffectTemplate.AMiasmaField01,
}

#------------------------------------------------------------------------
#  AEON QUANTUM AUTOGUN SHELL
#------------------------------------------------------------------------
AQuantumAutogun = Class(SinglePolyTrailProjectile) {
	FxImpactLand = EffectTemplate.Aeon_DualQuantumAutoGunHitLand,
    FxImpactNone = EffectTemplate.Aeon_DualQuantumAutoGunHit,
    FxImpactProp = EffectTemplate.Aeon_DualQuantumAutoGunHit_Unit,  
    FxImpactWater = EffectTemplate.Aeon_DualQuantumAutoGunHitLand,   
    FxImpactUnit = EffectTemplate.Aeon_DualQuantumAutoGunHit_Unit,    
    
    PolyTrail = EffectTemplate.Aeon_DualQuantumAutoGunProjectileTrail, 
    FxTrails = EffectTemplate.Aeon_DualQuantumAutoGunFxTrail,
    FxImpactProjectile = {},
}

#------------------------------------------------------------------------
#  AEON AA MISSILE PROJECTILES
#------------------------------------------------------------------------
AMissileAAProjectile = Class(SinglePolyTrailProjectile) {
    PolyTrail = '/effects/emitters/aeon_missile_trail_01_emit.bp',

    FxImpactUnit = EffectTemplate.AMissileHit01,
    FxImpactProp = EffectTemplate.AMissileHit01,
    FxImpactNone = EffectTemplate.AMissileHit01,
    FxImpactLand = EffectTemplate.AMissileHit01,
    FxImpactAirUnit = EffectTemplate.AMissileHit01,
    FxAirUnitHitScale = 1.6,
    FxLandHitScale = 1.6,
    FxNoneHitScale = 1.6,
    FxPropHitScale = 1.6,
    FxShieldHitScale = 1.6,
    FxUnitHitScale = 1.6,
    FxWaterHitScale = 1.6,
    FxImpactUnderWater = {},
}

#------------------------------------------------------------------------
#  AEON SUB-LAUNCHED CRUISE MISSILE PROJECTILES
#------------------------------------------------------------------------
AMissileCruiseSubProjectile = Class(EmitterProjectile) {
    FxInitialAtEntityEmitter = {},
    FxUnderWaterTrail = {'/effects/emitters/missile_cruise_munition_underwater_trail_01_emit.bp',},
    FxOnEntityEmitter = {},
    FxExitWaterEmitter = EffectTemplate.DefaultProjectileWaterImpact,
    FxSplashScale = 0.65,
    ExitWaterTicks = 9,
    FxTrailOffset = -0.5,

    # LAUNCH TRAILS
    FxLaunchTrails = {},

    # TRAILS
    FxTrails = {'/effects/emitters/missile_cruise_munition_trail_01_emit.bp',},

    # Hit Effects
    FxImpactUnit = EffectTemplate.AMissileHit01,
    FxImpactProp = EffectTemplate.AMissileHit01,
    FxImpactLand = EffectTemplate.AMissileHit01,
    FxImpactUnderWater = {},
    OnCreate = function(self)
        self:SetCollisionShape('Sphere', 0, 0, 0, 1.0)
        SinglePolyTrailProjectile.OnCreate(self)
    end,
}

#------------------------------------------------------------------------
#  AEON SERPENTINE MISSILE PROJECTILES
#------------------------------------------------------------------------
AMissileSerpentineProjectile = Class(SingleCompositeEmitterProjectile) {
    PolyTrail = '/effects/emitters/serpentine_missile_trail_emit.bp',
    BeamName = '/effects/emitters/serpentine_missle_exhaust_beam_01_emit.bp',
    PolyTrailOffset = -0.05,

    FxUnitHitScale = 3.0,
    FxLandHitScale = 3.0,
    FxWaterHitScale = 3.0,
    FxUnderWaterHitScale = 2.5,
    FxAirUnitHitScale = 3.0,
    FxNoneHitScale = 3.0,    
    FxImpactUnit = EffectTemplate.AMissileHit01,
    FxImpactProp = EffectTemplate.AMissileHit01,
    FxImpactLand = EffectTemplate.AMissileHit01,
    FxImpactUnderWater = {},
    OnCreate = function(self)
        self:SetCollisionShape('Sphere', 0, 0, 0, 1.0)
        SingleCompositeEmitterProjectile.OnCreate(self)
    end,
    OnImpact = function(self, TargetType, targetEntity)
        DefaultExplosion.CreateScorchMarkSplat( self, 1.5 )
        EmitterProjectile.OnImpact( self, TargetType, targetEntity )
    end,    
    
}

AMissileSerpentineProjectile2 = Class(SingleCompositeEmitterProjectile) {
    PolyTrail = '/effects/emitters/serpentine_missile_trail_emit.bp',
    BeamName = '/effects/emitters/serpentine_missle_exhaust_beam_01_emit.bp',
    PolyTrailOffset = -0.05,

    FxUnitHitScale = 2.0,
    FxLandHitScale = 2.0,
    FxWaterHitScale = 2.0,
    FxUnderWaterHitScale = 1.5,
    FxAirUnitHitScale = 2.0,
    FxNoneHitScale = 2.0,    
    FxImpactUnit = EffectTemplate.AMissileHit01,
    FxImpactProp = EffectTemplate.AMissileHit01,
    FxImpactLand = EffectTemplate.AMissileHit01,
    FxImpactUnderWater = {},
    OnCreate = function(self)
        self:SetCollisionShape('Sphere', 0, 0, 0, 1.0)
        SingleCompositeEmitterProjectile.OnCreate(self)
    end,
    OnImpact = function(self, TargetType, targetEntity)
        DefaultExplosion.CreateScorchMarkSplat( self, 1.0 )
        EmitterProjectile.OnImpact( self, TargetType, targetEntity )
    end,     
}

#------------------------------------------------------------------------
#  AEON OBLIVION PROJECILE
#------------------------------------------------------------------------
AOblivionCannonProjectile = Class(EmitterProjectile) {
    FxTrails = {'/effects/emitters/oblivion_cannon_munition_01_emit.bp'},
    FxTrailScale = 0.6,
    FxImpactUnit = EffectTemplate.AOblivionCannonHit01,
    FxImpactProp = EffectTemplate.AOblivionCannonHit01,
    FxImpactLand = EffectTemplate.AOblivionCannonHit01,
    FxImpactWater = EffectTemplate.AOblivionCannonHit01,
}

#------------------------------------------------------------------------
#  AEON QUANTUM PROJECTILES
#------------------------------------------------------------------------
AQuantumCannonProjectile = Class(SinglePolyTrailProjectile) {
    FxTrails = {
        '/effects/emitters/quantum_cannon_munition_03_emit.bp',
        '/effects/emitters/quantum_cannon_munition_04_emit.bp',
    },
    PolyTrail = '/effects/emitters/quantum_cannon_polytrail_01_emit.bp',
    FxImpactUnit = EffectTemplate.AQuantumCannonHit01,
    FxImpactProp = EffectTemplate.AQuantumCannonHit01,
    FxImpactLand = EffectTemplate.AQuantumCannonHit01,
}

AQuantumDisruptorProjectile = Class(SinglePolyTrailProjectile) {
    PolyTrail = '/effects/emitters/default_polytrail_03_emit.bp',
    FxTrails = EffectTemplate.AQuantumDisruptor01,
    
    FxImpactUnit = EffectTemplate.AQuantumDisruptorHit01,
    FxImpactProp = EffectTemplate.AQuantumDisruptorHit01,
    FxImpactLand = EffectTemplate.AQuantumDisruptorHit01,
}

#------------------------------------------------------------------------
#  AEON AA PROJECTILES
#------------------------------------------------------------------------
AAAQuantumDisplacementCannonProjectile = Class(NullShell) {

    # Projectile Effects
    FxTrails = {},#'/effects/emitters/oblivion_cannon_munition_01_emit.bp'},
    PolyTrail = '/effects/emitters/quantum_displacement_cannon_polytrail_01_emit.bp',

    # Impact Effects
    FxImpactUnit = EffectTemplate.AQuantumDisplacementHit01,
    FxImpactProp = EffectTemplate.AQuantumDisplacementHit01,
    FxImpactAirUnit = EffectTemplate.AQuantumDisplacementHit01,
    FxImpactLand = EffectTemplate.AQuantumDisplacementHit01,
    FxImpactNone = EffectTemplate.AQuantumDisplacementHit01,

    # Teleport Effects
    FxTeleport = EffectTemplate.AQuantumDisplacementTeleport01,
    FxInvisible = '/effects/emitters/sparks_08_emit.bp',

    OnCreate = function(self)
        NullShell.OnCreate(self)

        self.TrailEmitters = {}
        self.CreateTrailFX(self)
        self:ForkThread(self.UpdateThread)
    end,

    CreateTrailFX = function(self)
        local army = self:GetArmy()
        if( self.PolyTrail ) then
            table.insert( self.TrailEmitters, CreateTrail(self, -1, army, self.PolyTrail ))
        end
        for i in self.FxTrails do
            table.insert( self.TrailEmitters, CreateEmitterOnEntity(self, army, self.FxTrails[i]))
        end
    end,

    CreateTeleportFX = function(self, army)
        for i in self.FxTeleport do
            CreateEmitterAtEntity(self, army, self.FxTeleport[i])
        end
    end,

    DestroyTrailFX = function(self)
        if self.TrailEmitters then
            for k,v in self.TrailEmitters do
                v:Destroy()
                v = nil
            end
        end
    end,

    UpdateThread = function(self)
        local army = self:GetArmy()
        WaitSeconds(0.3)
        self.DestroyTrailFX(self)
        self.CreateTeleportFX(self, army)
        local emit = CreateEmitterOnEntity(self, army, self.FxInvisible)
        WaitSeconds(0.45)
        emit:Destroy()
        self.CreateTeleportFX(self)
        self.CreateTrailFX(self)
    end,
}


#------------------------------------------------------------------------
#  AEON QUANTUM DISTORTION NUCLEAR WARHEAD PROJECTILES
#------------------------------------------------------------------------
AQuantumWarheadProjectile = Class(MultiCompositeEmitterProjectile) {

    Beams = {'/effects/emitters/aeon_nuke_exhaust_beam_01_emit.bp',},
    PolyTrails = {'/effects/emitters/aeon_nuke_trail_emit.bp',},

    # Hit Effects
    FxImpactUnit = {},
    FxImpactLand = {},
    FxImpactUnderWater = {},
}

#------------------------------------------------------------------------
#  AEON QUARK BOMB
#------------------------------------------------------------------------
AQuarkBombProjectile = Class(EmitterProjectile) {
    FxTrails = EffectTemplate.AQuarkBomb01,
    FxTrailScale = 1,

# Hit Effects
    FxImpactUnit = EffectTemplate.AQuarkBombHitUnit01,
    FxImpactProp = EffectTemplate.AQuarkBombHitUnit01,
    FxImpactAirUnit = EffectTemplate.AQuarkBombHitAirUnit01,
    FxImpactLand = EffectTemplate.AQuarkBombHitLand01,
    FxImpactUnderWater = {},

    OnImpact = function(self, TargetType, targetEntity)
        CreateLightParticle(self, -1,self:GetArmy(), 26, 6, 'sparkle_white_add_08', 'ramp_white_02' )
        DefaultExplosion.CreateScorchMarkSplat( self, 3 )

        EmitterProjectile.OnImpact( self, TargetType, targetEntity )
    end,
}

#------------------------------------------------------------------------
#  AEON RAIL GUN PROJECTILES
#------------------------------------------------------------------------
ARailGunProjectile = Class(EmitterProjectile) {
    FxTrails = {'/effects/emitters/railgun_munition_trail_02_emit.bp',
        '/effects/emitters/railgun_munition_trail_01_emit.bp'},
    FxTrailScale = 0,
    FxTrailOffset = 0,
    FxImpactUnderWater = {},
}


#------------------------------------------------------------------------
#  AEON REACTON CANNON PROJECTILES
#------------------------------------------------------------------------
AReactonCannonProjectile = Class(EmitterProjectile) {
    FxTrails = {
        '/effects/emitters/reacton_cannon_fxtrail_01_emit.bp',
        '/effects/emitters/reacton_cannon_fxtrail_02_emit.bp',
        '/effects/emitters/reacton_cannon_fxtrail_03_emit.bp',
    },

    FxImpactUnit = EffectTemplate.AReactonCannonHitUnit01,
    FxImpactProp = EffectTemplate.AReactonCannonHitUnit01,
    FxImpactLand = EffectTemplate.AReactonCannonHitLand01,
}

AReactonCannonAOEProjectile = Class(EmitterProjectile) {
    FxTrails = {
        '/effects/emitters/reacton_cannon_fxtrail_01_emit.bp',
        '/effects/emitters/reacton_cannon_fxtrail_02_emit.bp',
        '/effects/emitters/reacton_cannon_fxtrail_03_emit.bp',
    },

    FxImpactUnit = EffectTemplate.AReactonCannonHitUnit01,
    FxImpactProp = EffectTemplate.AReactonCannonHitUnit01,
    FxImpactLand = EffectTemplate.AReactonCannonHitLand02,
}

#------------------------------------------------------------------------
#  AEON DISRUPTOR PROJECTILES
#------------------------------------------------------------------------
ADisruptorProjectile = Class(SinglePolyTrailProjectile) {

	PolyTrail = '/effects/emitters/default_polytrail_03_emit.bp',
    FxTrails = EffectTemplate.ADisruptorMunition01,

	# Hit Effects
    FxImpactUnit = EffectTemplate.ADisruptorHit01,
    FxImpactProp = EffectTemplate.ADisruptorHit01,
    FxImpactLand = EffectTemplate.ADisruptorHit01,
}

#------------------------------------------------------------------------
#  AEON ROCKET PROJECTILES
#------------------------------------------------------------------------
ARocketProjectile = Class(EmitterProjectile) {

    FxInitial = {},
    FxTrails = {'/effects/emitters/missile_sam_munition_trail_cybran_01_emit.bp',},
    FxTrailOffset = 0.5,

    # Hit Effects
    FxImpactUnit = EffectTemplate.AMissileHit01,
    FxImpactProp = EffectTemplate.AMissileHit01,
    FxImpactLand = EffectTemplate.AMissileHit01,
    FxImpactUnderWater = {},
}

#------------------------------------------------------------------------
#  AEON SONIC PULSE AA PROJECTILES
#------------------------------------------------------------------------
ASonicPulseProjectile = Class(SinglePolyTrailProjectile) {
    PolyTrail = '/effects/emitters/sonic_pulse_munition_polytrail_01_emit.bp',

    # Hit Effects
    FxImpactAirUnit = EffectTemplate.ASonicPulseHitAirUnit01,
    FxImpactUnit = EffectTemplate.ASonicPulseHitUnit01,
    FxImpactProp = EffectTemplate.ASonicPulseHitUnit01,
    FxImpactLand = EffectTemplate.ASonicPulseHitLand01,
    FxImpactUnderWater = {},
}

# Custom version of the sonic pulse battery projectile for flying units
ASonicPulseProjectile02 = Class(SinglePolyTrailProjectile) {
    PolyTrail = '/effects/emitters/sonic_pulse_munition_polytrail_02_emit.bp',

    # Hit Effects
    FxImpactAirUnit = EffectTemplate.ASonicPulseHitAirUnit01,
    FxImpactUnit = EffectTemplate.ASonicPulseHitUnit01,
    FxImpactProp = EffectTemplate.ASonicPulseHitUnit01,
    FxImpactLand = EffectTemplate.ASonicPulseHitLand01,
    FxImpactUnderWater = {},
}

#------------------------------------------------------------------------
#  AEON FIZZ LAUNCHER PROJECTILE
#------------------------------------------------------------------------
ATemporalFizzAAProjectile = Class(SingleCompositeEmitterProjectile) {
    BeamName = '/effects/emitters/temporal_fizz_munition_beam_01_emit.bp',
    PolyTrail = '/effects/emitters/default_polytrail_03_emit.bp',
    FxImpactUnit = EffectTemplate.ATemporalFizzHit01,
    FxImpactAirUnit = EffectTemplate.ATemporalFizzHit01,
    FxImpactNone = EffectTemplate.ATemporalFizzHit01,
}

#------------------------------------------------------------------------
#  AEON ABOVE WATER LAUNCHED TORPEDO
#------------------------------------------------------------------------
ATorpedoShipProjectile = Class(OnWaterEntryEmitterProjectile) {
    FxInitial = {},
    FxTrails = {'/effects/emitters/torpedo_munition_trail_01_emit.bp',},
    FxTrailScale = 1,
    TrailDelay = 0,
    TrackTime = 0,

    FxUnitHitScale = 1.0,
    FxLandHitScale = 1.0,
    FxWaterHitScale = 1.0,
    FxUnderWaterHitScale = 1.0,
    FxAirUnitHitScale = 1.0,
    FxNoneHitScale = 1.0,
    FxImpactLand = {},
    FxImpactUnit = EffectTemplate.ATorpedoUnitHit01,
    FxImpactProp = EffectTemplate.ATorpedoUnitHit01,
    FxImpactUnderWater = EffectTemplate.DefaultProjectileUnderWaterImpact,
    FxImpactProjectile = EffectTemplate.ATorpedoUnitHit01,
    FxImpactProjectileUnderWater = EffectTemplate.DefaultProjectileUnderWaterImpact,
    FxKilled = EffectTemplate.ATorpedoUnitHit01,
    FxImpactNone = {},

    OnCreate = function(self,inWater)
        self:SetCollisionShape('Sphere', 0, 0, 0, 1.0)
        OnWaterEntryEmitterProjectile.OnCreate(self,inWater)
        # if we are starting in the water then immediately switch to tracking in water
        if inWater == true then
            self:TrackTarget(true):StayUnderwater(true)
        else
            self:TrackTarget(false)
        end
    end,
}


#------------------------------------------------------------------------
#  AEON SUB LAUNCHED TORPEDO
#------------------------------------------------------------------------
ATorpedoSubProjectile = Class(EmitterProjectile) {
    FxTrails = {'/effects/emitters/torpedo_munition_trail_01_emit.bp',},

    # Hit Effects
    FxImpactLand = {},
    FxUnitHitScale = 1.0,
    FxLandHitScale = 1.0,
    FxWaterHitScale = 1.0,
    FxUnderWaterHitScale = 1.0,
    FxAirUnitHitScale = 1.0,
    FxNoneHitScale = 1.0,
    FxImpactUnit = EffectTemplate.ATorpedoUnitHit01,
    FxImpactProp = EffectTemplate.ATorpedoUnitHit01,
    FxImpactUnderWater = EffectTemplate.ATorpedoUnitHit01,
    FxImpactProjectileUnderWater = EffectTemplate.DefaultProjectileUnderWaterImpact,

    FxNoneHitScale = 1,
    FxImpactNone = {},
    OnCreate = function(self, inWater)
        self:SetCollisionShape('Sphere', 0, 0, 0, 1.0)
        EmitterProjectile.OnCreate(self, inWater)
    end,

}



