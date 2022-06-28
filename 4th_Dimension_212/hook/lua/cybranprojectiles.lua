#****************************************************************************
#**
#**  File     :  /data/lua/modules/cybranprojectiles.lua
#**  Author(s): John Comes, Gordon Duclos
#**
#**  Summary  :
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
#------------------------------------------------------------------------
#  CYBRAN PROJECILES SCRIPTS
#------------------------------------------------------------------------
local DefaultProjectileFile = import('/lua/sim/defaultprojectiles.lua')
local EmitterProjectile = DefaultProjectileFile.EmitterProjectile
local OnWaterEntryEmitterProjectile = DefaultProjectileFile.OnWaterEntryEmitterProjectile
local SingleBeamProjectile = DefaultProjectileFile.SingleBeamProjectile
local MultiBeamProjectile = DefaultProjectileFile.MultiBeamProjectile
local SinglePolyTrailProjectile = DefaultProjectileFile.SinglePolyTrailProjectile
local MultiPolyTrailProjectile = DefaultProjectileFile.MultiPolyTrailProjectile 
local SingleCompositeEmitterProjectile = DefaultProjectileFile.SingleCompositeEmitterProjectile
local DepthCharge = import('/lua/defaultantiprojectile.lua').DepthCharge
local NullShell = DefaultProjectileFile.NullShell
local EffectTemplate = import('/lua/EffectTemplates.lua')
local DefaultExplosion = import('/lua/defaultexplosions.lua')

#------------------------------------------------------------------------
#  CYBRAN PROTON PROJECTILES
#------------------------------------------------------------------------
CIFProtonBombProjectile = Class(NullShell) {
    FxImpactUnit = EffectTemplate.CProtonBombHit01,
    FxImpactProp = EffectTemplate.CProtonBombHit01,
    FxImpactLand = EffectTemplate.CProtonBombHit01,

    OnImpact = function(self, targetType, targetEntity)
        local army = self:GetArmy()
        CreateLightParticle( self, -1, army, 12, 28, 'glow_03', 'ramp_proton_flash_02' )
        CreateLightParticle( self, -1, army, 8, 22, 'glow_03', 'ramp_antimatter_02' )
        if targetType == 'Terrain' then
            CreateSplat( self:GetPosition(), 0, 'scorch_011_albedo', 12, 12, 150, 200, army )
        end

        local blanketSides = 12
        local blanketAngle = (2*math.pi) / blanketSides
        local blanketStrength = 1
        local blanketVelocity = 6.25

        for i = 0, (blanketSides-1) do
            local blanketX = math.sin(i*blanketAngle)
            local blanketZ = math.cos(i*blanketAngle)
            self:CreateProjectile('/effects/entities/EffectProtonAmbient01/EffectProtonAmbient01_proj.bp', blanketX, 0.5, blanketZ, blanketX, 0, blanketZ)
                :SetVelocity(blanketVelocity):SetAcceleration(-0.3)
        end

        EmitterProjectile.OnImpact(self, targetType, targetEntity)
    end,
}

#------------------------------------------------------------------------
#  CYBRAN PROTON PROJECTILES
#------------------------------------------------------------------------
CDFProtonCannonProjectile = Class(MultiPolyTrailProjectile) {
    PolyTrails = {
		EffectTemplate.CProtonCannonPolyTrail,
		'/effects/emitters/default_polytrail_01_emit.bp',
	},
	PolyTrailOffset = {0,0}, 
	
    FxTrails = EffectTemplate.CProtonCannonFXTrail01,
    #PolyTrail = EffectTemplate.CProtonCannonPolyTrail,
    FxImpactUnit = EffectTemplate.CProtonCannonHit01,
    FxImpactProp = EffectTemplate.CProtonCannonHit01,
    FxImpactLand = EffectTemplate.CProtonCannonHit01,
    FxTrailOffset = 0,
    FxImpactUnderWater = {},
}

#------------------------------------------------------------------------
#  CYBRAN DISSIDENT PROJECTILE
#------------------------------------------------------------------------
CAADissidentProjectile = Class(SinglePolyTrailProjectile) {

    PolyTrail = '/effects/emitters/electron_bolter_trail_01_emit.bp',
    FxTrails = {'/effects/emitters/electron_bolter_munition_01_emit.bp',},

    # Hit Effects
    FxImpactUnit = EffectTemplate.TMissileHit01,
    FxImpactProp = EffectTemplate.TMissileHit01,
    FxImpactLand = EffectTemplate.TMissileHit01,
    FxImpactProjectile = EffectTemplate.TMissileHit01,
}

#------------------------------------------------------------------------
#  ELECTRON BURST CLOUD PROJECILE
#------------------------------------------------------------------------
CAAElectronBurstCloudProjectile = Class(SinglePolyTrailProjectile) {

	PolyTrail = '/effects/emitters/default_polytrail_02_emit.bp',
    
    # Hit Effects
    FxImpactLand = {},
    FxImpactWater = {},
    FxImpactUnderWater = {},
    FxImpactAirUnit = EffectTemplate.CElectronBurstCloud01,
    FxImpactNone = EffectTemplate.CElectronBurstCloud01,
}

#------------------------------------------------------------------------
#  NANITE MISSILE PROJECILE
#------------------------------------------------------------------------
CAAMissileNaniteProjectile = Class(SingleCompositeEmitterProjectile) {
# Emitter Values
    FxTrails = {},
    FxTrailOffset = -0.05,
    PolyTrail = '/effects/emitters/caamissilenanite01_polytrail_01_emit.bp',
    BeamName = '/effects/emitters/missile_nanite_exhaust_beam_01_emit.bp',

    # Hit Effects
    FxUnitHitScale = 2.1,
    FxImpactAirUnit = EffectTemplate.CMissileHit01,
    FxImpactNone = EffectTemplate.CMissileHit01,
    FxImpactUnit = EffectTemplate.CMissileHit01,
    FxImpactProp = EffectTemplate.CMissileHit01,
    FxLandHitScale = 2.1,
    FxImpactLand = EffectTemplate.CMissileHit01,
    FxImpactUnderWater = {},
}

#------------------------------------------------------------------------
#  NANODART PROJECILE
#------------------------------------------------------------------------
CAANanoDartProjectile = Class(NullShell) {
    FxTrails = {'/effects/emitters/missile_munition_trail_01_emit.bp',},

    # Hit Effects
    FxUnitHitScale = 1.0,
    FxImpactAirUnit = EffectTemplate.CMissileHit01,
    FxImpactUnit = EffectTemplate.CMissileHit01,
    FxImpactLand = {},
    FxImpactWater = {},
    FxImpactUnderWater = {},
}

#------------------------------------------------------------------------
#  CYBRAN ARTILLERY PROJECILES
#------------------------------------------------------------------------
CArtilleryProjectile = Class(EmitterProjectile) {
    FxTrails = {'/effects/emitters/mortar_munition_03_emit.bp',},

    # Hit Effects
    FxImpactUnit = EffectTemplate.CArtilleryHit01,
    FxImpactProp = EffectTemplate.CArtilleryHit01,
    FxImpactLand = EffectTemplate.CArtilleryHit01,
    FxImpactUnderWater = {},
}

CArtilleryProtonProjectile = Class(SinglePolyTrailProjectile) {
    FxTrails = {},
	#PolyTrail = EffectTemplate.CProtonArtilleryPolytrail01,    
	PolyTrail = '/effects/emitters/default_polytrail_01_emit.bp',

    # Hit Effects
    FxImpactUnit = EffectTemplate.CProtonArtilleryHit01,
    FxImpactProp = EffectTemplate.CProtonArtilleryHit01,    
    FxImpactLand = EffectTemplate.CProtonArtilleryHit01,
    FxImpactUnderWater = {},
}

#------------------------------------------------------------------------
#  CYBRAN BEAM PROJECILES
#------------------------------------------------------------------------
CBeamProjectile = Class(NullShell) {
    FxUnitHitScale = 0.5,
    FxImpactUnit = EffectTemplate.CBeamHitUnit01,
    FxImpactProp = EffectTemplate.CBeamHitUnit01,
    FxImpactLand = EffectTemplate.CBeamHitLand01,
    FxImpactUnderWater = {},
}

#------------------------------------------------------------------------
#  CYBRAN BOMBs
#------------------------------------------------------------------------
CBombProjectile = Class(EmitterProjectile) {
    FxTrails = {'/effects/emitters/bomb_munition_plasma_aeon_01_emit.bp'},

    # Hit Effects
    FxImpactUnit = EffectTemplate.CBombHit01,
    FxImpactProp = EffectTemplate.CBombHit01,
    FxImpactLand = EffectTemplate.CBombHit01,
    FxImpactUnderWater = {},
}

#------------------------------------------------------------------------
#  CYBRAN SHIP PROJECILES
#------------------------------------------------------------------------
CCannonSeaProjectile = Class(SingleBeamProjectile) {
    BeamName = '/effects/emitters/cannon_munition_ship_cybran_beam_01_emit.bp',
    FxImpactUnderWater = {},
}

#-------------------------------------------------------------------
#  CYBRAN TANK CANNON PROJECILES
#------------------------------------------------------------------------
CCannonTankProjectile = Class(SingleBeamProjectile) {
    BeamName = '/effects/emitters/cannon_munition_ship_cybran_beam_01_emit.bp',
    FxImpactUnderWater = {},
}

#---------------------------
#  CYBRAN TRACKER PROJECILES
#---------------------------
CDFTrackerProjectile = Class(SingleCompositeEmitterProjectile) {
# Emitter Values
    FxInitial = {},
    TrailDelay = 1,
    FxTrails = {'/effects/emitters/missile_sam_munition_trail_01_emit.bp',},
    FxTrailOffset = 0.5,

    BeamName = '/effects/emitters/missile_sam_munition_exhaust_beam_01_emit.bp',

    # Hit Effects
    FxUnitHitScale = 0.5,
    FxImpactUnit = {},
    FxLandHitScale = 0.5,
    FxImpactLand = EffectTemplate.CMissileHit01,
    FxImpactUnderWater = {},
}

#------------------------------------------------------------------------
#  DISINTEGRATOR LASER PROJECILE
#------------------------------------------------------------------------
CDisintegratorLaserProjectile = Class(MultiPolyTrailProjectile) {
    PolyTrails = {
		'/effects/emitters/disintegrator_polytrail_01_emit.bp',
		
	},
	PolyTrailOffset = {0,0},    
    FxTrailScale = 2,
    FxUnitHitScale = 1.0,
    FxLandHitScale = 1.0,
    FxWaterHitScale = 1.0,
    FxUnderWaterHitScale = 1.0,
    FxAirUnitHitScale = 1.0,
    FxNoneHitScale = 1.0,	
	
    # Hit Effects
	FxImpactUnit = EffectTemplate.CHvyDisintegratorHitUnit01,
    FxImpactProp = EffectTemplate.CHvyDisintegratorHitUnit01,
    FxImpactLand = EffectTemplate.CHvyDisintegratorHitLand01,
    FxImpactUnderWater = {},
}

CDisintegratorLaserProjectile2 = Class(MultiPolyTrailProjectile) {
    PolyTrails = {
		'/mods/4th_Dimension_212/hook/effects/Emitters/disintegrator_polytrail_06_emit.bp',
		
	},
	PolyTrailOffset = {0,0},    
    FxTrailScale = 2,
    FxUnitHitScale = 1.0,
    FxLandHitScale = 1.0,
    FxWaterHitScale = 1.0,
    FxUnderWaterHitScale = 1.0,
    FxAirUnitHitScale = 1.0,
    FxNoneHitScale = 1.0,	
	
    # Hit Effects
	FxImpactUnit = EffectTemplate.CHvyDisintegratorHitUnit01,
    FxImpactProp = EffectTemplate.CHvyDisintegratorHitUnit01,
    FxImpactLand = EffectTemplate.CHvyDisintegratorHitLand01,
    FxImpactUnderWater = {},
}

CDisintegratorLaserProjectile3 = Class(MultiPolyTrailProjectile) {
    PolyTrails = {
		'/Mods/4th_Dimension_212/hook/effects/Emitters/disintegrator_polytrail_07_emit.bp',
		
	},
	PolyTrailOffset = {0,0},    
    FxTrailScale = 2,
    FxUnitHitScale = 0.8,
    FxLandHitScale = 0.8,
    FxWaterHitScale = 0.8,
    FxUnderWaterHitScale = 0.8,
    FxAirUnitHitScale = 0.8,
    FxNoneHitScale = 0.8,	
	
    # Hit Effects
    FxImpactUnit = EffectTemplate.CCorsairMissileUnitHit01,
    FxImpactProp = EffectTemplate.CCorsairMissileHit01,
    FxImpactLand = EffectTemplate.CCorsairMissileLandHit01,
    FxImpactAirUnit = EffectTemplate.CCorsairMissileUnitHit01,
    FxImpactUnderWater = {},
}
#------------------------------------------------------------------------
#  CYBRAN ELECTRON BOLTER PROJECILES
#------------------------------------------------------------------------
CElectronBolterProjectile = Class(MultiPolyTrailProjectile) {

    PolyTrails = {
		'/effects/emitters/electron_bolter_trail_01_emit.bp',
		'/effects/emitters/default_polytrail_03_emit.bp',
	},
	PolyTrailOffset = {0,0},  
    FxTrails = {'/effects/emitters/electron_bolter_munition_01_emit.bp',},

    # Hit Effects
    FxImpactUnit = EffectTemplate.CElectronBolterHitUnit01,
    FxImpactProp = EffectTemplate.CElectronBolterHitUnit01,
    FxImpactLand = EffectTemplate.CElectronBolterHitLand01,
}

CHeavyElectronBolterProjectile = Class(MultiPolyTrailProjectile) {

    PolyTrails = {
		'/effects/emitters/electron_bolter_trail_01_emit.bp',
		'/effects/emitters/default_polytrail_05_emit.bp',
	},
	PolyTrailOffset = {0,0},  
    FxTrails = {'/effects/emitters/electron_bolter_munition_02_emit.bp',},

    # Hit Effects
    FxImpactUnit = EffectTemplate.CElectronBolterHit04,
    FxImpactProp = EffectTemplate.CElectronBolterHit04,
    FxImpactLand = EffectTemplate.CElectronBolterHit04,
}

#------------------------------------------------------------------------
#  TERRAN SUB-LAUNCHED CRUISE MISSILE PROJECTILES
#------------------------------------------------------------------------
CEMPFluxWarheadProjectile = Class(SingleBeamProjectile) {
    BeamName = '/effects/emitters/missile_exhaust_fire_beam_01_emit.bp',
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
    FxImpactUnit = {},
    FxImpactLand = {},
    FxImpactUnderWater = {},
}

#------------------------------------------------------------------------
#  CYBRAN FLAME THROWER PROJECTILES
#------------------------------------------------------------------------
CFlameThrowerProjectile = Class(EmitterProjectile) {
    FxTrails = {'/effects/emitters/flamethrower_02_emit.bp'},
    FxTrailScale = 1,
    FxTrailOffset = 0,
    FxImpactUnderWater = {},
}

#------------------------------------------------------------------------
#  CYBRAN MOLECULAR RESONANCE SHELL PROJECTILE
#------------------------------------------------------------------------
CIFMolecularResonanceShell = Class(SinglePolyTrailProjectile) {

    PolyTrail = '/effects/emitters/default_polytrail_01_emit.bp',

    # Hit Effects
    FxImpactUnit = EffectTemplate.CMolecularResonanceHitUnit01,
    FxImpactProp = EffectTemplate.CMolecularResonanceHitUnit01,
    FxImpactLand = EffectTemplate.CMolecularResonanceHitUnit01,
    FxImpactUnderWater = {},
    DestroyOnImpact = false,

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
                DefaultExplosion.CreateScorchMarkSplat( self, 2.0 )
            else
                SinglePolyTrailProjectile.OnImpact(self, TargetType, TargetEntity)
                self:Destroy()
            end
        end
    end,
}

#------------------------------------------------------------------------
#  CORSAIR MISSILE PROJECTILES
#------------------------------------------------------------------------
CCorsairRocketProjectile = Class(SingleCompositeEmitterProjectile) {

    FxTrails = {'/effects/emitters/missile_cruise_munition_trail_01_emit.bp',},
 	FxTrailScale = 0.7,

	PolyTrail = EffectTemplate.CCorsairMissilePolyTrail01,    
    BeamName = '/effects/emitters/rocket_iridium_exhaust_beam_01_emit.bp',
    FxImpactUnit = EffectTemplate.CCorsairMissileUnitHit01,
    FxImpactProp = EffectTemplate.CCorsairMissileHit01,
    FxImpactLand = EffectTemplate.CCorsairMissileLandHit01,
    FxImpactAirUnit = EffectTemplate.CCorsairMissileUnitHit01,
    FxImpactUnderWater = {},
}

#------------------------------------------------------------------------
#  IRIDIUM ROCKET PROJECTILES
#------------------------------------------------------------------------
CIridiumRocketProjectile = Class(SingleCompositeEmitterProjectile) {
    FxTrails = {},
	PolyTrail = '/effects/emitters/default_polytrail_01_emit.bp',    
    BeamName = '/effects/emitters/rocket_iridium_exhaust_beam_01_emit.bp',
    FxImpactUnit = EffectTemplate.CMissileHit01,
    FxImpactProp = EffectTemplate.CMissileHit01,
    FxImpactLand = EffectTemplate.CMissileHit01,
    FxImpactAirUnit = EffectTemplate.CMissileHit01,
    FxAirUnitHitScale = 2,
    FxLandHitScale = 2,
    FxNoneHitScale = 2,
    FxPropHitScale = 2,
    FxShieldHitScale = 2,
    FxUnitHitScale = 2,
    FxWaterHitScale = 2,
    FxImpactUnderWater = {},
}

#------------------------------------------------------------------------
#  CYBRAN LASER PROJECILES
#------------------------------------------------------------------------
CLaserLaserProjectile = Class(MultiPolyTrailProjectile) {
    PolyTrails = {
        '/effects/emitters/cybran_laser_trail_01_emit.bp',
		--'/effects/emitters/default_polytrail_02_emit.bp',
	},
	PolyTrailOffset = {0,0}, 
    FxTrailScale = 0,
    
    # Hit Effects
    FxImpactUnit = EffectTemplate.CLaserHitUnit01,
    FxImpactProp = EffectTemplate.CLaserHitUnit01,
    FxImpactLand = EffectTemplate.CLaserHitLand01,
    FxImpactUnderWater = {},
}

CHeavyLaserProjectile = Class(MultiPolyTrailProjectile) {
    PolyTrails = {
        '/effects/emitters/cybran_laser_trail_02_emit.bp',
		--'/effects/emitters/default_polytrail_03_emit.bp',
	},
	PolyTrailOffset = {0,0}, 
    
	FxTrailScale = 0,	
    # Hit Effects
	FxUnitHitScale = 0.4,
    FxLandHitScale = 0.4,
    FxWaterHitScale = 0.4,
    FxUnderWaterHitScale = 0.4,
    FxAirUnitHitScale = 0.4,
    FxNoneHitScale = 0.4,	
    FxImpactUnit = EffectTemplate.CLaserHitUnit01,
    FxImpactProp = EffectTemplate.CLaserHitUnit01,
    FxImpactLand = EffectTemplate.CLaserHitLand01,
	FxImpactUnit = EffectTemplate.CCorsairMissileUnitHit01,
    FxImpactProp = EffectTemplate.CCorsairMissileHit01,
    FxImpactLand = EffectTemplate.CCorsairMissileLandHit01,
    FxImpactAirUnit = EffectTemplate.CCorsairMissileUnitHit01,
    FxImpactUnderWater = {},
}


#------------------------------------------------------------------------
#  CYBRAN MOLECULAR CANNON PROJECTILE
#------------------------------------------------------------------------
CMolecularCannonProjectile = Class(SinglePolyTrailProjectile) {

    PolyTrail = '/effects/emitters/default_polytrail_03_emit.bp',
    FxTrails = EffectTemplate.CMolecularCannon01,

    # Hit Effects
    FxImpactUnit = EffectTemplate.CMolecularRipperHit01,
    FxImpactProp = EffectTemplate.CMolecularRipperHit01,
    FxImpactLand = EffectTemplate.CMolecularRipperHit01,
}

#------------------------------------------------------------------------
#  CYBRAN AA MISSILE PROJECILES - Air Targets
#------------------------------------------------------------------------
CMissileAAProjectile = Class(SingleCompositeEmitterProjectile) {
    # Emitter Values
    FxInitial = {},
    TrailDelay = 1,
    FxTrails = {'/effects/emitters/missile_sam_munition_trail_01_emit.bp',},
    FxTrailOffset = 0.5,

    BeamName = '/effects/emitters/missile_sam_munition_exhaust_beam_01_emit.bp',

    # Hit Effects
    FxUnitHitScale = 0.5,
    FxImpactUnit = EffectTemplate.CMissileHit01,
    FxImpactProp = EffectTemplate.CMissileHit01,    
    FxLandHitScale = 0.5,
    FxImpactLand = EffectTemplate.CMissileHit01,
    FxImpactAirUnit = EffectTemplate.CMissileHit01,
    FxUnitHitScale = 0.5,
    FxImpactUnderWater = {},

    OnCreate = function(self)
        self:SetCollisionShape('Sphere', 0, 0, 0, 1.0)
        SingleBeamProjectile.OnCreate(self)
    end,
}

#------------------------------------------------------------------------
#  NEUTRON CLUSTER BOMB PROJECTILES
#------------------------------------------------------------------------
CNeutronClusterBombChildProjectile = Class(SinglePolyTrailProjectile) {
    FxTrails = {},
    PolyTrail = '/effects/emitters/default_polytrail_05_emit.bp',

    # Hit Effects
    FxImpactUnit = EffectTemplate.CNeutronClusterBombHitUnit01,
    FxImpactProp = EffectTemplate.CNeutronClusterBombHitUnit01,    
    FxImpactLand = EffectTemplate.CNeutronClusterBombHitLand01,
    FxImpactWater = EffectTemplate.CNeutronClusterBombHitWater01,
    FxImpactUnderWater = {},

    # No damage dealt by this child.
    DoDamage = function(self, instigator, damageData, targetEntity)
    end,
}

CNeutronClusterBombProjectile = Class(SinglePolyTrailProjectile) {
    FxTrails = {},
    PolyTrail = '/effects/emitters/default_polytrail_03_emit.bp',

    # Hit Effects
    FxImpactUnit = {},
    FxImpactLand = {},
    FxImpactUnderWater = {},

    ChildProjectile = '/projectiles/CIFNeutronClusterBomb02/CIFNeutronClusterBomb02_proj.bp',

    OnCreate = function(self)
        SinglePolyTrailProjectile.OnCreate(self)
        self.Impacted = false
    end,

    # -------------------------------------------------------------------------
    # Over-ride the way damage is dealt to allow custom damage to be dealt.
    # Spec 9/21/05 states that possible instakill functionality could be dealt
    # to unit, dependent on units current armor level.
    # ### Spec pending revision ### Update when finalized.
    # ---------------------------------------------------------------------------
    DoDamage = function(self, instigator, damageData, targetEntity)
        SinglePolyTrailProjectile.DoDamage(self, instigator, damageData, targetEntity)
    end,

    # ---------------------------------------------------------------------------
    # Note: Damage is done once in AOE by main projectile. Secondary projectiles
    # are just visual.
    # ---------------------------------------------------------------------------
    OnImpact = function(self, TargetType, TargetEntity)
        if self.Impacted == false and TargetType != 'Air' then
            self.Impacted = true
            self:CreateChildProjectile(self.ChildProjectile):SetVelocity(0,Random(1,3),Random(1.5,3))
            self:CreateChildProjectile(self.ChildProjectile):SetVelocity(Random(1,2),Random(1,3),Random(1,2))
            self:CreateChildProjectile(self.ChildProjectile):SetVelocity(0,Random(1,3),-Random(1.5,3))
            self:CreateChildProjectile(self.ChildProjectile):SetVelocity(Random(1.5,3),Random(1,3),0)
            self:CreateChildProjectile(self.ChildProjectile):SetVelocity(-Random(1,2),Random(1,3),-Random(1,2))
            self:CreateChildProjectile(self.ChildProjectile):SetVelocity(-Random(1.5,2.5),Random(1,3),0)
            self:CreateChildProjectile(self.ChildProjectile):SetVelocity(-Random(1,2),Random(1,3),Random(2,4))
            SinglePolyTrailProjectile.OnImpact(self, TargetType, TargetEntity)
        end
    end,
    
    # Overiding Destruction
    OnImpactDestroy = function( self, TargetType, TargetEntity)
        self:ForkThread( self.DelayedDestroyThread )
    end,

    DelayedDestroyThread = function(self)
        WaitSeconds( 0.5 )
        self:Destroy()
    end,
}

#------------------------------------------------------------------------
#  CYBRAN MACHINE GUN SHELLS
#------------------------------------------------------------------------
CParticleCannonProjectile = Class(SingleBeamProjectile) {
    BeamName = '/effects/emitters/laserturret_munition_beam_01_emit.bp',

# Hit Effects
    FxImpactUnit = EffectTemplate.CParticleCannonHitUnit01,
    FxImpactProp = EffectTemplate.CParticleCannonHitUnit01,
    FxImpactLand = EffectTemplate.CParticleCannonHitLand01,
    FxImpactUnderWater = {},
}

#------------------------------------------------------------------------
#  CYBRAN RAIL GUN PROJECTILES
#------------------------------------------------------------------------
CRailGunProjectile = Class(EmitterProjectile) {
    FxTrails = {'/effects/emitters/railgun_munition_trail_02_emit.bp',
                '/effects/emitters/railgun_munition_trail_01_emit.bp'},
    FxTrailScale = 0,
    FxTrailOffset = 0,
    FxImpactUnderWater = {},
}

#------------------------------------------------------------------------
#  CYBRAN ROCKET PROJECILES
#------------------------------------------------------------------------
CRocketProjectile = Class(SingleBeamProjectile) {
    # Emitter Values
    BeamName = '/effects/emitters/rocket_iridium_exhaust_beam_01_emit.bp',

    # Hit Effects
    FxImpactUnit = EffectTemplate.CMissileHit01,
    FxImpactProp = EffectTemplate.CMissileHit01,
    FxImpactLand = EffectTemplate.CMissileHit01,
    FxImpactUnderWater = {},
}

CLOATacticalMissileProjectile = Class(SingleBeamProjectile) {

    BeamName = '/effects/emitters/missile_loa_munition_exhaust_beam_01_emit.bp',
    FxTrails = {'/effects/emitters/missile_cruise_munition_trail_01_emit.bp',},
    FxTrailOffset = -0.5,
    FxExitWaterEmitter = EffectTemplate.TIFCruiseMissileLaunchExitWater,
    
    # Hit Effects
    FxImpactUnit = EffectTemplate.CMissileLOAHit01,
    FxImpactLand = EffectTemplate.CMissileLOAHit01,
    FxImpactProp = EffectTemplate.CMissileLOAHit01,
    FxImpactNone = EffectTemplate.CMissileLOAHit01,
    FxImpactUnderWater = {},
    
    CreateImpactEffects = function( self, army, EffectTable, EffectScale )
        local emit = nil
        for k, v in EffectTable do
            emit = CreateEmitterAtEntity(self,army,v)
            if emit and EffectScale != 1 then
                emit:ScaleEmitter(EffectScale or 1)
            end
        end
    end,
    
    OnExitWater = function(self)
		EmitterProjectile.OnExitWater(self)
		local army = self:GetArmy()
		for k, v in self.FxExitWaterEmitter do
			CreateEmitterAtBone(self,-2,army,v)
		end
    end,
    
    OnImpact = function(self, targetType, targetEntity)       
    	local army = self:GetArmy()
        SingleBeamProjectile.OnImpact(self, targetType, targetEntity) 
        DefaultExplosion.CreateScorchMarkSplat( self, 1.5 )
    end,      
}

CLOATacticalChildMissileProjectile = Class(SingleBeamProjectile) {
    BeamName = '/effects/emitters/missile_loa_munition_exhaust_beam_02_emit.bp',
    FxTrails = {'/effects/emitters/missile_cruise_munition_trail_03_emit.bp',},
    FxTrailOffset = -0.5,
    FxExitWaterEmitter = EffectTemplate.TIFCruiseMissileLaunchExitWater,
    
    # Hit Effects
    FxImpactUnit = EffectTemplate.CMissileLOAHit01,
    FxImpactLand = EffectTemplate.CMissileLOAHit01,
    FxImpactProp = EffectTemplate.CMissileLOAHit01,
    FxImpactUnderWater = {},
    FxImpactNone = EffectTemplate.CMissileLOAHit01,
    FxAirUnitHitScale = 0.375,
    FxLandHitScale = 0.375,
    FxNoneHitScale = 0.375,
    FxPropHitScale = 0.375,
    FxProjectileHitScale = 0.375,
    FxShieldHitScale = 0.375,
    FxUnitHitScale = 0.375,
    FxWaterHitScale = 0.375,
    FxOnKilledScale = 0.375,       
    
    OnCreate = function(self)
        self:SetCollisionShape('Sphere', 0, 0, 0, 1.0)
        SingleBeamProjectile.OnCreate(self)
    end,
    
    OnImpact = function(self, targetType, targetEntity)
        local army = self:GetArmy()
        CreateLightParticle( self, -1, army, 1, 7, 'glow_03', 'ramp_fire_11' ) 
        SingleBeamProjectile.OnImpact(self, targetType, targetEntity)
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
    
    OnExitWater = function(self)
		EmitterProjectile.OnExitWater(self)
		local army = self:GetArmy()
		for k, v in self.FxExitWaterEmitter do
			CreateEmitterAtBone(self,-2,army,v)
		end
    end,
}

#------------------------------------------------------------------------
#  CYBRAN AUTOCANNON PROJECILES
#------------------------------------------------------------------------
CShellAAAutoCannonProjectile = Class(MultiPolyTrailProjectile) {
    PolyTrails = {
		'/effects/emitters/auto_cannon_trail_01_emit.bp',
		--'/effects/emitters/default_polytrail_03_emit.bp',
	},
	PolyTrailOffset = {0,0},
    FxTrailScale = 0,
    # Hit Effects
    FxImpactUnit = {'/effects/emitters/auto_cannon_hit_flash_01_emit.bp', },
    FxImpactProp ={'/effects/emitters/auto_cannon_hit_flash_01_emit.bp', },
    FxImpactAirUnit = {'/effects/emitters/auto_cannon_hit_flash_01_emit.bp', },
    FxImpactLand = {},
    FxImpactWater = {},
    FxImpactUnderWater = {},
}

#------------------------------------------------------------------------
#  CYBRAN RIOT PROJECILES
#------------------------------------------------------------------------
CShellRiotProjectile = Class(SingleBeamProjectile) {
    BeamName = '/effects/emitters/riotgun_munition_beam_01_emit.bp',

    # Hit Effects
    FxImpactUnit = {'/effects/emitters/destruction_explosion_sparks_01_emit.bp',},
    FxImpactProp = {'/effects/emitters/destruction_explosion_sparks_01_emit.bp',},
    FxLandHitScale = 3,
    FxImpactLand = {'/effects/emitters/destruction_land_hit_puff_01_emit.bp',},
    FxImpactUnderWater = {},
}

#------------------------------------------------------------------------
#  CYBRAN ABOVE WATER LAUNCHED TORPEDO
#------------------------------------------------------------------------
CTorpedoShipProjectile = Class(OnWaterEntryEmitterProjectile) {
    FxSplashScale = 1.5,
    FxTrails = {'/effects/emitters/torpedo_munition_trail_01_emit.bp',},
    FxTrailScale = 1.25,
    FxTrailOffset = 0.2,    
    FxEnterWater= { '/effects/emitters/water_splash_ripples_ring_01_emit.bp',
                    '/effects/emitters/water_splash_plume_01_emit.bp',},    

# Hit Effects
    FxUnitHitScale = 1.0,
    FxLandHitScale = 1.0,
    FxWaterHitScale = 1.0,
    FxUnderWaterHitScale = 1.0,
    FxAirUnitHitScale = 1.0,
    FxNoneHitScale = 1.0,
    FxImpactUnit = EffectTemplate.CTorpedoUnitHit01,
    FxImpactProp = EffectTemplate.CTorpedoUnitHit01,
    FxImpactUnderWater = EffectTemplate.CTorpedoUnitHit01,
    FxImpactLand = {},
    FxImpactNone = {},

    OnCreate = function(self, inWater)
        self:SetCollisionShape('Sphere', 0, 0, 0, 1.0)
        OnWaterEntryEmitterProjectile.OnCreate(self, inWater)
        # if we are starting in the water then immediately switch to tracking in water
        if inWater == true then
            self:TrackTarget(true):StayUnderwater(true)
        end
    end,
}

#------------------------------------------------------------------------
#  CYBRAN SUB LAUNCHED TORPEDO
#------------------------------------------------------------------------
CTorpedoSubProjectile = Class(EmitterProjectile) {
    FxTrails = {'/effects/emitters/torpedo_underwater_wake_02_emit.bp',},
    FxSplashScale = 1.5,
    
    # Hit Effects
    FxUnitHitScale = 1.0,
    FxLandHitScale = 1.0,
    FxWaterHitScale = 1.0,
    FxUnderWaterHitScale = 1.0,
    FxAirUnitHitScale = 1.0,
    FxNoneHitScale = 1.0,
    FxImpactUnit = EffectTemplate.CTorpedoUnitHit01,
    FxImpactProp = EffectTemplate.CTorpedoUnitHit01,
    FxImpactUnderWater = EffectTemplate.CTorpedoUnitHit01,    
    FxImpactLand = {},
    FxNoneHitScale = 1,
    FxImpactNone = {},
    OnCreate = function(self, inWater)
        self:SetCollisionShape('Sphere', 0, 0, 0, 1.0)
        EmitterProjectile.OnCreate(self, inWater)
    end,
}

#------------------------------------------------------------------------
#  Cybran DEPTH CHARGE PROJECTILES
#------------------------------------------------------------------------
CDepthChargeProjectile = Class(OnWaterEntryEmitterProjectile) {
    FxInitial = {},
    FxTrails = {
		'/effects/emitters/anti_torpedo_flare_01_emit.bp',
		'/effects/emitters/anti_torpedo_flare_02_emit.bp',
	},

    # Hit Effects
    FxUnitHitScale = 1.5,
    FxLandHitScale = 1.5,
    FxWaterHitScale = 1.5,
    FxUnderWaterHitScale = 1.5,
    FxAirUnitHitScale = 1.5,
    FxNoneHitScale = 1.5,
    FxImpactLand = {},
    FxImpactUnit = EffectTemplate.CAntiTorpedoHit01,
    FxImpactProp = EffectTemplate.CAntiTorpedoHit01,
    FxImpactUnderWater = EffectTemplate.CAntiTorpedoHit01,    
    FxImpactProjectile = EffectTemplate.CAntiTorpedoHit01,
    FxImpactNone = EffectTemplate.CAntiTorpedoHit01,
    FxOnKilled = EffectTemplate.CAntiTorpedoHit01,
    FxEnterWater= EffectTemplate.WaterSplash01,

    OnCreate = function(self, inWater)
        OnWaterEntryEmitterProjectile.OnCreate(self)
        if inWater then
			local army = self:GetArmy()
			for i in self.FxTrails do
				CreateEmitterOnEntity(self, army, self.FxTrails[i]):ScaleEmitter(self.FxTrailScale):OffsetEmitter(0, 0, self.FxTrailOffset)
			end
		end
        
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
CHeavyDisintegratorPulseLaser = Class(MultiPolyTrailProjectile) {
    PolyTrails = {
		'/effects/emitters/disintegrator_polytrail_02_emit.bp',
		'/effects/emitters/disintegrator_polytrail_03_emit.bp',
		'/effects/emitters/default_polytrail_03_emit.bp',
	},
	PolyTrailOffset = {0,0,0},    
    FxUnitHitScale = 2.0,
    FxLandHitScale = 2.0,
    FxWaterHitScale = 2.0,
    FxUnderWaterHitScale = 2.0,
    FxAirUnitHitScale = 2.0,
    FxNoneHitScale = 2.0,	
    # Hit Effects
    FxImpactUnit = EffectTemplate.CHvyDisintegratorHitUnit01,
    FxImpactProp = EffectTemplate.CHvyDisintegratorHitUnit01,
    FxImpactLand = EffectTemplate.CHvyDisintegratorHitLand01,
    FxImpactUnderWater = {},
    FxTrails = {},
    FxTrailOffset = 0,
}


