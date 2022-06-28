#****************************************************************************
#**
#**  File     :  /data/lua/modules/EffectTemplates.lua
#**  Author(s):  Gordon Duclos
#**
#**  Summary  :  Generic templates for commonly used effects
#**
#**  Copyright © 2006 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

TableCat = import('utilities.lua').TableCat
EmtBpPath = '/effects/emitters/'
EmitterTempEmtBpPath = '/effects/emitters/temp/'
ModPath = '/mods/4th_Dimension_212/hook/effects/Emitters/'

#---------------------------------------------------------------
# ### EXPLOSIONS ###

#---------------------------------------------------------------
# Concussion Ring Effects
#---------------------------------------------------------------
ConcussionRingSml01 = { EmtBpPath .. 'destruction_explosion_concussion_ring_02_emit.bp',}
ConcussionRingMed01 = { EmtBpPath .. 'destruction_explosion_concussion_ring_01_emit.bp',}
ConcussionRingLrg01 = { EmtBpPath .. 'destruction_explosion_concussion_ring_01_emit.bp',}

#---------------------------------------------------------------
# Fire Cloud Effects
#---------------------------------------------------------------
FireCloudSml01 = {
    EmtBpPath .. 'fire_cloud_05_emit.bp',
    EmtBpPath .. 'fire_cloud_04_emit.bp',
}

FireCloudMed01 = {
    ModPath .. 'fire_cloud_06_emit.bp',
    EmtBpPath .. 'explosion_fire_sparks_01_emit.bp',
}

#---------------------------------------------------------------
# FireShadow Faked Flat Particle Effects
#---------------------------------------------------------------
FireShadowSml01 = { EmtBpPath .. 'destruction_explosion_fire_shadow_02_emit.bp',}
FireShadowMed01 = { EmtBpPath .. 'destruction_explosion_fire_shadow_01_emit.bp',}
FireShadowLrg01 = { EmtBpPath .. 'destruction_explosion_fire_shadow_01_emit.bp',}

#---------------------------------------------------------------
# Flash Effects
#---------------------------------------------------------------
FlashSml01 = { EmtBpPath .. 'flash_01_emit.bp',}

#---------------------------------------------------------------
# Flare Effects
#---------------------------------------------------------------
FlareSml01 = { EmtBpPath .. 'flare_01_emit.bp',}

#---------------------------------------------------------------
# Smoke Effects
#---------------------------------------------------------------
SmokeSml01 = { EmtBpPath .. 'destruction_explosion_smoke_05_emit.bp',}
SmokeMed01 = { EmtBpPath .. 'destruction_explosion_smoke_05_emit.bp',}
SmokeLrg01 = { 
    EmtBpPath .. 'destruction_explosion_smoke_03_emit.bp',
    EmtBpPath .. 'destruction_explosion_smoke_07_emit.bp',
}

SmokePlumeLightDensityMed01 = { EmtBpPath .. 'destruction_explosion_smoke_08_emit.bp',}
SmokePlumeMedDensitySml01 = { EmtBpPath .. 'destruction_explosion_smoke_08_emit.bp',}
SmokePlumeMedDensitySml02 = { EmtBpPath .. 'destruction_explosion_smoke_08_emit.bp',}
SmokePlumeMedDensitySml03 = { EmtBpPath .. 'destruction_explosion_smoke_08_emit.bp',}

#---------------------------------------------------------------
# Wreckage Smoke Effects
#---------------------------------------------------------------
DefaultWreckageEffectsSml01 = TableCat( SmokePlumeLightDensityMed01, SmokePlumeMedDensitySml01, SmokePlumeMedDensitySml02, SmokePlumeMedDensitySml03 ) 
DefaultWreckageEffectsMed01 = TableCat( SmokePlumeLightDensityMed01, SmokePlumeMedDensitySml01, SmokePlumeMedDensitySml02, SmokePlumeMedDensitySml03 )
DefaultWreckageEffectsLrg01 = TableCat( SmokePlumeLightDensityMed01, SmokePlumeMedDensitySml01, SmokePlumeMedDensitySml02, SmokePlumeMedDensitySml01, SmokePlumeMedDensitySml02, SmokePlumeMedDensitySml01, SmokePlumeMedDensitySml02, SmokePlumeMedDensitySml03 )

#---------------------------------------------------------------
# Explosion Debris Effects
#--------------------------------------------------------------- 
ExplosionDebrisSml01 = {
    EmtBpPath .. 'destruction_explosion_debris_07_emit.bp',
    EmtBpPath .. 'destruction_explosion_debris_08_emit.bp',
    EmtBpPath .. 'destruction_explosion_debris_09_emit.bp',
}
ExplosionDebrisMed01 = {
    EmtBpPath .. 'destruction_explosion_debris_10_emit.bp',
    EmtBpPath .. 'destruction_explosion_debris_11_emit.bp',
    EmtBpPath .. 'destruction_explosion_debris_12_emit.bp',
}
ExplosionDebrisLrg01 = {
    EmtBpPath .. 'destruction_explosion_debris_01_emit.bp',
    EmtBpPath .. 'destruction_explosion_debris_02_emit.bp',
    EmtBpPath .. 'destruction_explosion_debris_03_emit.bp',
}

#---------------------------------------------------------------
# Explosion Effects
#---------------------------------------------------------------
ExplosionEffectsSml01 = TableCat( FlareSml01, FireCloudSml01, ExplosionDebrisSml01, GenericDebrisTrails01 )
ExplosionEffectsMed01 = TableCat( SmokeMed01, FireCloudMed01, ExplosionDebrisMed01, GenericDebrisTrails01 )
ExplosionEffectsLrg01 = TableCat( SmokeLrg01, ExplosionDebrisLrg01, GenericDebrisTrails01 )
ExplosionEffectsDefault01 = ExplosionEffectsMed01
ExplosionEffectsSml02 = TableCat( FlareSml01, FireCloudSml01, ExplosionDebrisSml01, GenericDebrisTrails01 )
ExplosionEffectsMed02 = TableCat( SmokeMed01, FireCloudMed01, ExplosionDebrisMed01, GenericDebrisTrails01 )
ExplosionEffectsLrg02 = TableCat( SmokeLrg01, ExplosionDebrisLrg01, GenericDebrisTrails01)

DefaultHitExplosion01 = TableCat( FireCloudMed01, FlashSml01, FlareSml01, SmokeSml01, GenericDebrisTrails01 )
DefaultHitExplosion02 = TableCat( FireCloudSml01, FlashSml01, FlareSml01, SmokeSml01, GenericDebrisTrails01 )

ExplosionEffectsAir = TableCat( FireCloudMed01, ExplosionDebrisMed01, GenericDebrisTrails01 )
DefaultHitExplosionAir = TableCat( FireCloudMed01, FlashSml01, FlareSml01, GenericDebrisTrails01 )
#---------------------------------------------------------------
# Ambient and Weather Effects
#---------------------------------------------------------------
WeatherTwister = {
    EmtBpPath .. 'weather_twister_01_emit.bp',
    EmtBpPath .. 'weather_twister_02_emit.bp',
    EmtBpPath .. 'weather_twister_03_emit.bp',
    EmtBpPath .. 'weather_twister_04_emit.bp',
}

#---------------------------------------------------------------
# ### PROJECTILE IMPACT EFFECTS ###

#---------------------------------------------------------------
# Default Projectile Impact Effects
#---------------------------------------------------------------
DefaultMissileHit01 = TableCat( FireCloudSml01, FlashSml01, FlareSml01 )
DefaultProjectileAirUnitImpact = {
    EmtBpPath .. 'destruction_unit_hit_flash_01_emit.bp',
    EmtBpPath .. 'destruction_unit_hit_shrapnel_01_emit.bp',
}
DefaultProjectileLandImpact = {
    EmtBpPath .. 'projectile_dirt_impact_small_01_emit.bp',
    EmtBpPath .. 'projectile_dirt_impact_small_02_emit.bp',
    EmtBpPath .. 'projectile_dirt_impact_small_03_emit.bp',
    EmtBpPath .. 'projectile_dirt_impact_small_04_emit.bp',
}
DefaultProjectileLandUnitImpact = {
    EmtBpPath .. 'destruction_unit_hit_flash_01_emit.bp',
    EmtBpPath .. 'destruction_unit_hit_shrapnel_01_emit.bp',
}
DefaultProjectileWaterImpact = {
    EmtBpPath .. 'destruction_water_splash_ripples_01_emit.bp',
    EmtBpPath .. 'destruction_water_splash_wash_01_emit.bp',
    EmtBpPath .. 'destruction_water_splash_plume_01_emit.bp',
    EmtBpPath .. 'destruction_water_splash_wash_01_emit.bp',
    EmtBpPath .. 'destruction_water_splash_wash_01_emit.bp',
    EmtBpPath .. 'destruction_water_splash_wash_01_emit.bp',
    EmtBpPath .. 'destruction_water_splash_wash_01_emit.bp',
    EmtBpPath .. 'destruction_water_splash_wash_01_emit.bp',
    EmtBpPath .. 'destruction_water_splash_wash_01_emit.bp',
    EmtBpPath .. 'destruction_water_splash_wash_01_emit.bp',
    EmtBpPath .. 'destruction_water_splash_wash_01_emit.bp',
}
DefaultProjectileUnderWaterImpact = {
    EmtBpPath .. 'destruction_underwater_explosion_flash_01_emit.bp',
    EmtBpPath .. 'destruction_underwater_explosion_splash_01_emit.bp',
}
DustDebrisLand01 = {
    EmtBpPath .. 'dust_cloud_02_emit.bp',
    EmtBpPath .. 'dust_cloud_04_emit.bp',
    EmtBpPath .. 'destruction_explosion_debris_04_emit.bp',
    EmtBpPath .. 'destruction_explosion_debris_05_emit.bp',
}
GenericDebrisLandImpact01 = {
    EmtBpPath .. 'dirtchunks_01_emit.bp',
    EmtBpPath .. 'dust_cloud_05_emit.bp',
}
GenericDebrisTrails01 = { EmtBpPath .. 'destruction_explosion_debris_trail_01_emit.bp',}
UnitHitShrapnel01 = { EmtBpPath .. 'destruction_unit_hit_shrapnel_01_emit.bp',}
WaterSplash01 = { 
    EmtBpPath .. 'water_splash_ripples_ring_01_emit.bp',
    EmtBpPath .. 'water_splash_plume_01_emit.bp',
}



#---------------------------------------------------------------
# Default Unit Damage Effects
#---------------------------------------------------------------
DamageSmoke01 = { EmtBpPath .. 'destruction_damaged_smoke_01_emit.bp',}
DamageSparks01 = { EmtBpPath .. 'destruction_damaged_sparks_01_emit.bp',}
DamageFire01 = { EmtBpPath .. 'destruction_damaged_fire_01_emit.bp',}
DamageFireSmoke01 = TableCat( DamageSmoke01, DamageFire01 )


#---------------------------------------------------------------
# Ambient effects
#---------------------------------------------------------------
TreeBurning01 = TableCat( DamageFire01 ,{EmtBpPath .. 'forest_fire_smoke_01_emit.bp'} )

#---------------------------------------------------------------
# Shield Impact effects
#---------------------------------------------------------------
AeonShieldHit01 = {
	EmtBpPath .. '_test_shield_impact_emit.bp',
}
CybranShieldHit01 = {
	EmtBpPath .. '_test_shield_impact_emit.bp',
}    
UEFShieldHit01 = {
	#EmtBpPath .. 'shield_impact_terran_01_emit.bp',
	#EmtBpPath .. 'shield_impact_terran_02_emit.bp',
	#EmtBpPath .. 'shield_impact_terran_03_emit.bp',
	EmtBpPath .. '_test_shield_impact_emit.bp',
}


#---------------------------------------------------------------
# Teleport effects
#---------------------------------------------------------------
UnitTeleport01 = {
    EmtBpPath .. 'teleport_ring_01_emit.bp',
    EmtBpPath .. 'teleport_rising_mist_01_emit.bp',
    #EmtBpPath .. '_test_commander_gate_explosion_01_emit.bp',
    EmtBpPath .. '_test_commander_gate_explosion_02_emit.bp',
    #EmtBpPath .. '_test_commander_gate_explosion_03_emit.bp',
    EmtBpPath .. '_test_commander_gate_explosion_04_emit.bp',
    EmtBpPath .. '_test_commander_gate_explosion_05_emit.bp',
}

UnitTeleport02 = {
    #EmtBpPath .. 'teleport_phosphor_01_emit.bp',
    EmtBpPath .. 'teleport_timing_01_emit.bp',
    EmtBpPath .. 'teleport_sparks_01_emit.bp',
    EmtBpPath .. 'teleport_ground_01_emit.bp',
    #EmtBpPath .. 'teleport_sparks_02_emit.bp',
}

UnitTeleportSteam01 = {
    EmtBpPath .. 'teleport_commander_mist_01_emit.bp',
}

CommanderTeleport01 = {
    EmtBpPath .. 'teleport_ring_01_emit.bp',
    EmtBpPath .. 'teleport_rising_mist_01_emit.bp',
    EmtBpPath .. 'commander_teleport_01_emit.bp',    
    EmtBpPath .. 'commander_teleport_02_emit.bp',      
    EmtBpPath .. '_test_commander_gate_explosion_02_emit.bp',
    #EmtBpPath .. '_test_commander_gate_explosion_04_emit.bp',
    #EmtBpPath .. '_test_commander_gate_explosion_05_emit.bp',
}

CommanderQuantumGateInEnergy = {
    EmtBpPath .. 'energy_stream_01_emit.bp',
    EmtBpPath .. 'energy_stream_02_emit.bp',     
    EmtBpPath .. 'energy_stream_03_emit.bp',       
    EmtBpPath .. 'energy_stream_04_emit.bp',          
    EmtBpPath .. 'energy_stream_05_emit.bp',     
    EmtBpPath .. 'energy_stream_sparks_01_emit.bp',     
    EmtBpPath .. 'energy_rays_01_emit.bp',        
}

CloudFlareEffects01 = {
    '/effects/emitters/quantum_warhead_02_emit.bp',
    '/effects/emitters/quantum_warhead_04_emit.bp',
}

GenericTeleportCharge01 = {
    EmtBpPath .. 'generic_teleport_charge_01_emit.bp',
    EmtBpPath .. 'generic_teleport_charge_02_emit.bp',
    EmtBpPath .. 'generic_teleport_charge_03_emit.bp',
}
GenericTeleportOut01 = {
    EmtBpPath .. 'generic_teleportout_01_emit.bp',
}
GenericTeleportIn01 = {
    EmtBpPath .. 'generic_teleportin_01_emit.bp',
    EmtBpPath .. 'generic_teleportin_02_emit.bp',
    EmtBpPath .. 'generic_teleportin_03_emit.bp',
}

#---------------------------------------------------------------
# ### UNIT CONSTRUCTION ###

#---------------------------------------------------------------
# Build Effects
#---------------------------------------------------------------
DefaultBuildUnit01 = { EmtBpPath .. 'default_build_01_emit.bp'}

AeonBuildBeams01 = {
    EmtBpPath .. 'aeon_build_beam_01_emit.bp',
    EmtBpPath .. 'aeon_build_beam_02_emit.bp',
    EmtBpPath .. 'aeon_build_beam_03_emit.bp',
}
AeonBuildBeams02 = {
    EmtBpPath .. 'aeon_build_beam_04_emit.bp',
    EmtBpPath .. 'aeon_build_beam_05_emit.bp',
    EmtBpPath .. 'aeon_build_beam_06_emit.bp',
}

CybranBuildUnitBlink01 = { EmtBpPath .. 'build_cybran_blink_blue_01_emit.bp'}
CybranBuildFlash01 =  EmtBpPath .. 'build_cybran_spark_flash_03_emit.bp'
CybranBuildSparks01 =  EmtBpPath .. 'build_sparks_blue_01_emit.bp' 
CybranFactoryBuildSparksLeft01 = {
    EmtBpPath .. 'sparks_04_emit.bp',
    EmtBpPath .. 'build_cybran_spark_flash_02_emit.bp',
}
CybranFactoryBuildSparksRight01 = {
    EmtBpPath .. 'sparks_03_emit.bp',
    EmtBpPath .. 'build_cybran_spark_flash_01_emit.bp',
}
CybranUnitBuildSparks01 = {
    EmtBpPath .. 'build_cybran_sparks_01_emit.bp',
    EmtBpPath .. 'build_cybran_sparks_02_emit.bp',
    EmtBpPath .. 'build_cybran_sparks_03_emit.bp',
}

#---------------------------------------------------------------
# Reclaim Effects
#---------------------------------------------------------------
ReclaimBeams = {
    EmtBpPath .. 'reclaim_beam_01_emit.bp',
    EmtBpPath .. 'reclaim_beam_02_emit.bp',
    EmtBpPath .. 'reclaim_beam_03_emit.bp',	
}

ReclaimObjectAOE = { '/effects/emitters/reclaim_01_emit.bp' }
ReclaimObjectEnd = { '/effects/emitters/reclaim_02_emit.bp' }

#---------------------------------------------------------------
# Capture Effects
#---------------------------------------------------------------
CaptureBeams = {
    EmtBpPath .. 'capture_beam_01_emit.bp',
    EmtBpPath .. 'capture_beam_02_emit.bp',
    EmtBpPath .. 'capture_beam_03_emit.bp',	
}

#---------------------------------------------------------------
# Upgrade Effects
#---------------------------------------------------------------
UpgradeUnitAmbient = {
    EmtBpPath .. 'unit_upgrade_ambient_01_emit.bp',
    EmtBpPath .. 'unit_upgrade_ambient_02_emit.bp',
}
UpgradeBoneAmbient = {
    EmtBpPath .. 'unit_upgrade_bone_ambient_01_emit.bp',
}

#---------------------------------------------------------------
# ### UNIT TRANSPORT BEAMS ###

#---------------------------------------------------------------
# Terran Transport Beam Effects
#---------------------------------------------------------------
TTransportBeam01 = EmtBpPath .. 'terran_transport_beam_01_emit.bp'  # Unit to Transport beam
TTransportBeam02 = EmtBpPath .. 'terran_transport_beam_02_emit.bp'  # Transport to Unit beam
TTransportGlow01 = EmtBpPath .. 'terran_transport_glow_01_emit.bp' # glow on Transport



#---------------------------------------------------------------
# ### UNIT MOVEMENT ###

#---------------------------------------------------------------
# Sea Unit Environmental Effects
#---------------------------------------------------------------
DefaultSeaUnitBackWake01 = {
    EmtBpPath .. 'water_move_trail_back_01_emit.bp',   
    EmtBpPath .. 'water_move_trail_back_r_01_emit.bp',
    EmtBpPath .. 'water_move_trail_back_l_01_emit.bp',
}

DefaultSeaUnitIdle01 = { EmtBpPath .. 'water_idle_ripples_02_emit.bp',}
DefaultUnderWaterUnitWake01 = { EmtBpPath .. 'underwater_move_trail_01_emit.bp',}
DefaultUnderWaterIdle01 = { EmtBpPath .. 'underwater_idle_bubbles_01_emit.bp',}

#---------------------------------------------------------------
# Land Unit Environmental Effects
#--------------------------------------------------------------- 
DustBrownMove01 = { EmtBpPath .. 'land_move_brown_dust_01_emit.bp',}
FootFall01 = { 
    EmtBpPath .. 'tt_dirt02_footfall01_01_emit.bp',
    EmtBpPath .. 'tt_dirt02_footfall01_02_emit.bp',
}

#---------------------------------------------------------------
# ### AEON UNIT AMBIENT EFFECTS ###

AT1PowerAmbient = {
    EmtBpPath .. 'aeon_t1power_ambient_01_emit.bp',
    EmtBpPath .. 'aeon_t1power_ambient_02_emit.bp',
}

AT2MassCollAmbient = {
    EmtBpPath .. 'aeon_t2masscoll_ambient_01_emit.bp',
}

AT2PowerAmbient = {
    EmtBpPath .. 'aeon_t2power_ambient_01_emit.bp',
    EmtBpPath .. 'aeon_t2power_ambient_02_emit.bp',
}

AT3PowerAmbient = {
    EmtBpPath .. 'aeon_t3power_ambient_01_emit.bp',
    EmtBpPath .. 'aeon_t3power_ambient_02_emit.bp',
}

AQuantumGateAmbient = {
    EmtBpPath .. 'aeon_gate_01_emit.bp',
    EmtBpPath .. 'aeon_gate_02_emit.bp',
    EmtBpPath .. 'aeon_gate_03_emit.bp',
}

#---------------------------------------------------------------
# ### AEON PROJECTILES ###
ASacrificeOfTheAeon01 = {
	'/effects/emitters/aeon_sacrifice_01_emit.bp',
	'/effects/emitters/aeon_sacrifice_02_emit.bp',	
	'/effects/emitters/aeon_sacrifice_03_emit.bp',		
}

ASacrificeOfTheAeon02 = {
	'/effects/emitters/aeon_sacrifice_04_emit.bp',		
}

#---------------------------------------------------------------
# ### AEON PROJECTILES ###

AAntiMissileFlare = {
    EmtBpPath .. 'aeon_missiled_wisp_01_emit.bp',
    EmtBpPath .. 'aeon_missiled_wisp_02_emit.bp',
    EmtBpPath .. 'aeon_missiled_wisp_04_emit.bp',
}    

AAntiMissileFlareFlash = {
    EmtBpPath .. 'aeon_missiled_flash_01_emit.bp',
    EmtBpPath .. 'aeon_missiled_flash_02_emit.bp',
    EmtBpPath .. 'aeon_missiled_flash_03_emit.bp',
}
AAntiMissileFlareHit = { 
    EmtBpPath .. 'aeon_missiled_hit_01_emit.bp',
    EmtBpPath .. 'aeon_missiled_hit_02_emit.bp',
    EmtBpPath .. 'aeon_missiled_hit_03_emit.bp',
    EmtBpPath .. 'aeon_missiled_hit_04_emit.bp',
}

ABeamHit01 = {
    EmtBpPath .. 'beam_hit_sparks_01_emit.bp',
    EmtBpPath .. 'beam_hit_smoke_01_emit.bp',
}
ABeamHitUnit01 = ABeamHit01
ABeamHitLand01 = ABeamHit01

ABombHit01 = {
    EmtBpPath .. 'aeon_bomber_hit_01_emit.bp',
    EmtBpPath .. 'aeon_bomber_hit_02_emit.bp',
    EmtBpPath .. 'aeon_bomber_hit_03_emit.bp',
    EmtBpPath .. 'aeon_bomber_hit_04_emit.bp',
}

AChronoDampener = {
    EmtBpPath .. 'aeon_chrono_dampener_01_emit.bp',
    EmtBpPath .. 'aeon_chrono_dampener_02_emit.bp',
    EmtBpPath .. 'aeon_chrono_dampener_03_emit.bp',
    EmtBpPath .. 'aeon_chrono_dampener_04_emit.bp',
}

ACommanderOverchargeFlash01 = {
    EmtBpPath .. 'aeon_commander_overcharge_flash_01_emit.bp',
    EmtBpPath .. 'aeon_commander_overcharge_flash_02_emit.bp',
    EmtBpPath .. 'aeon_commander_overcharge_flash_03_emit.bp',
}

ACommanderOverchargeFXTrail01 = { 
    EmtBpPath .. 'aeon_commander_overcharge_01_emit.bp', 
    EmtBpPath .. 'aeon_commander_overcharge_02_emit.bp',
}

ACommanderOverchargeHit01 = { 
    EmtBpPath .. 'aeon_commander_overcharge_hit_01_emit.bp', 
    EmtBpPath .. 'aeon_commander_overcharge_hit_02_emit.bp', 
}

ADepthCharge01 = { EmtBpPath .. 'harmonic_depth_charge_resonance_01_emit.bp',}
ADepthChargeHitUnit01 = DefaultProjectileUnderWaterImpact
ADepthChargeHitUnderWaterUnit01 = TableCat( ADepthCharge01, DefaultProjectileUnderWaterImpact )

ADisruptorCannonMuzzle01 = {
    EmtBpPath .. 'disruptor_cannon_muzzle_01_emit.bp',	
	EmtBpPath .. 'disruptor_cannon_muzzle_02_emit.bp',		
	EmtBpPath .. 'disruptor_cannon_muzzle_03_emit.bp', 		
}

ADisruptorMunition01 = { 
    EmtBpPath .. 'disruptor_cannon_munition_01_emit.bp',	
}
ADisruptorHit01 = { 
    EmtBpPath .. 'disruptor_hit_01_emit.bp',	
}

AHighIntensityLaserHit01 = {
    EmtBpPath .. 'laserturret_hit_flash_04_emit.bp',
    EmtBpPath .. 'laserturret_hit_flash_05_emit.bp',
    EmtBpPath .. 'laserturret_hit_flash_09_emit.bp',
}
AHighIntensityLaserHitUnit01 = TableCat( AHighIntensityLaserHit01, UnitHitShrapnel01 )
AHighIntensityLaserHitLand01 = TableCat( AHighIntensityLaserHit01 )
AHighIntensityLaserFlash01   = {
    EmtBpPath .. 'disruptor_cannon_muzzle_01_emit.bp',	 
    EmtBpPath .. 'quantum_cannon_muzzle_flash_04_emit.bp',	 		
	EmtBpPath .. 'quantum_cannon_muzzle_charge_s01_emit.bp',	
	EmtBpPath .. 'quantum_cannon_muzzle_charge_s02_emit.bp',
}

AGravitonBolterHit01 = {
    EmtBpPath .. 'graviton_bolter_hit_02_emit.bp',
    EmtBpPath .. 'sparks_07_emit.bp',
}
AGravitonBolterMuzzleFlash01 = {
    EmtBpPath .. 'graviton_bolter_flash_01_emit.bp',
}

ALaserBotHit01 = {
    EmtBpPath .. 'laserturret_hit_flash_04_emit.bp',
    EmtBpPath .. 'laserturret_hit_flash_05_emit.bp',
}
ALaserBotHitUnit01 = TableCat( ALaserBotHit01, UnitHitShrapnel01 )
ALaserBotHitLand01 = TableCat( ALaserBotHit01 )

ALaserHit01 = { EmtBpPath .. 'laserturret_hit_flash_02_emit.bp',}
ALaserHitUnit01 = TableCat( ALaserHit01, UnitHitShrapnel01 )
ALaserHitLand01 = TableCat( ALaserHit01 )

ALightLaserHit01 = { EmtBpPath .. 'laserturret_hit_flash_07_emit.bp',}
ALightLaserHit02 = {
    EmtBpPath .. 'laserturret_hit_flash_07_emit.bp',
    EmtBpPath .. 'laserturret_hit_flash_08_emit.bp',
}

ALightLaserHitUnit01 = TableCat( ALightLaserHit02, UnitHitShrapnel01 )

ALightMortarHit01 = {
    EmtBpPath .. 'aeon_light_shell_01_emit.bp',
    EmtBpPath .. 'aeon_light_shell_02_emit.bp',
    EmtBpPath .. 'aeon_light_shell_03_emit.bp',
    #EmtBpPath .. 'aeon_light_shell_05_emit.bp',
}

AMiasmaMunition01 = {
    EmtBpPath .. 'miasma_munition_trail_01_emit.bp',
}
AMiasmaMunition02 = {
    EmtBpPath .. 'miasma_cloud_02_emit.bp',
}

AMiasma01 = { 
    EmtBpPath .. 'miasma_munition_burst_01_emit.bp',
}

AMiasmaField01 = {
    EmtBpPath .. 'miasma_cloud_01_emit.bp',
}

AMissileHit01 = TMissileHit01

AOblivionCannonHit01 = {
    EmtBpPath .. 'oblivion_cannon_hit_01_emit.bp',
    EmtBpPath .. 'oblivion_cannon_hit_02_emit.bp',
    EmtBpPath .. 'oblivion_cannon_hit_03_emit.bp',    
    EmtBpPath .. 'oblivion_cannon_hit_04_emit.bp',       
}
AQuantumCannonMuzzle01 = {
    EmtBpPath .. 'disruptor_cannon_muzzle_01_emit.bp',	 
    EmtBpPath .. 'quantum_cannon_muzzle_flash_04_emit.bp',	 		
	EmtBpPath .. 'aeon_light_tank_muzzle_charge_01_emit.bp',	
	EmtBpPath .. 'aeon_light_tank_muzzle_charge_02_emit.bp',
}
AQuantumCannonMuzzle02 = {                      # tweaked version for ships
    EmtBpPath .. 'disruptor_cannon_muzzle_01_emit.bp',	 
    EmtBpPath .. 'quantum_cannon_muzzle_flash_04_emit.bp',	 		
	EmtBpPath .. 'quantum_cannon_muzzle_charge_s01_emit.bp',	
	EmtBpPath .. 'quantum_cannon_muzzle_charge_s02_emit.bp',
}
AQuantumCannonHit01 = {
    EmtBpPath .. 'quantum_hit_flash_04_emit.bp',
    EmtBpPath .. 'quantum_hit_flash_05_emit.bp',
    EmtBpPath .. 'quantum_hit_flash_06_emit.bp',
    EmtBpPath .. 'quantum_hit_flash_07_emit.bp',
    EmtBpPath .. 'quantum_hit_flash_08_emit.bp',
    EmtBpPath .. 'quantum_hit_flash_09_emit.bp',
}
AQuantumDisruptor01 = { 
    EmtBpPath .. 'aeon_commander_disruptor_01_emit.bp', 
    EmtBpPath .. 'aeon_commander_disruptor_02_emit.bp',
}
AQuantumDisruptorHit01 = { 
    EmtBpPath .. 'aeon_commander_disruptor_hit_01_emit.bp', 
    EmtBpPath .. 'aeon_commander_disruptor_hit_02_emit.bp', 
    EmtBpPath .. 'aeon_commander_disruptor_hit_03_emit.bp',     
}
AQuantumDisplacementHit01 = {
    EmtBpPath .. 'quantum_displacement_cannon_hit_01_emit.bp',
    EmtBpPath .. 'quantum_displacement_cannon_hit_02_emit.bp',
}
AQuantumDisplacementTeleport01 = {
    EmtBpPath .. 'sparks_07_emit.bp',
    EmtBpPath .. 'teleport_01_emit.bp',
}
AQuarkBomb01 = {
    EmtBpPath .. 'quark_bomb_01_emit.bp',
    EmtBpPath .. 'quark_bomb_02_emit.bp',
    EmtBpPath .. 'sparks_06_emit.bp',
}
AQuarkBomb02 = {                                   # A larger version of AQuarkBomb01
    EmtBpPath .. 'quark_bomb2_01_emit.bp',
    EmtBpPath .. 'quark_bomb2_02_emit.bp',
    EmtBpPath .. 'sparks_11_emit.bp',
}
AQuarkBombHit01 = {
    EmtBpPath .. 'quark_bomb_explosion_03_emit.bp',
    EmtBpPath .. 'quark_bomb_explosion_04_emit.bp',
    EmtBpPath .. 'quark_bomb_explosion_05_emit.bp',
    EmtBpPath .. 'quark_bomb_explosion_07_emit.bp',
    EmtBpPath .. 'quark_bomb_explosion_08_emit.bp',
}
AQuarkBombHit02 = {
    EmtBpPath .. 'quark_bomb_explosion_03_emit.bp',
    EmtBpPath .. 'quark_bomb_explosion_06_emit.bp',
}
AQuarkBombHitUnit01 = AQuarkBombHit01
AQuarkBombHitAirUnit01 = AQuarkBombHit02
AQuarkBombHitLand01 = AQuarkBombHit01

APhasonLaserMuzzle01 = {
    EmtBpPath .. 'phason_laser_muzzle_01_emit.bp',
    EmtBpPath .. 'phason_laser_muzzle_02_emit.bp',    
}

APhasonLaserImpact01 = {
    EmtBpPath .. 'phason_laser_end_01_emit.bp',
    EmtBpPath .. 'phason_laser_end_02_emit.bp',    
}

AReactonCannon01 = {
    EmtBpPath .. 'flash_03_emit.bp',
    EmtBpPath .. 'reacton_cannon_hit_03_emit.bp',
    EmtBpPath .. 'reacton_cannon_hit_04_emit.bp',
    EmtBpPath .. 'reacton_cannon_hit_05_emit.bp',
    EmtBpPath .. 'reacton_cannon_hit_06_emit.bp',
}
AReactonCannon02 = {
    EmtBpPath .. 'flash_03_emit.bp',
    EmtBpPath .. 'sparks_10_emit.bp',
    EmtBpPath .. 'reacton_cannon_hit_01_emit.bp',
    EmtBpPath .. 'reacton_cannon_hit_02_emit.bp',
}
AReactonCannonHitUnit01 = AReactonCannon01
AReactonCannonHitUnit02 = AReactonCannon02
AReactonCannonHitLand01 = AReactonCannon01
AReactonCannonHitLand02 = AReactonCannon02

ASaintLaunch01 = 
{
    EmtBpPath .. 'flash_03_emit.bp', 
    EmtBpPath .. 'saint_launch_01_emit.bp', 
    EmtBpPath .. 'saint_launch_02_emit.bp', 
}

ASaintImpact01 = 
{
    EmtBpPath .. 'flash_03_emit.bp', 
    EmtBpPath .. 'saint_launch_01_emit.bp', 
    EmtBpPath .. 'saint_launch_02_emit.bp', 
}

ASonanceWeaponFXTrail01 = {
    EmtBpPath .. 'aeon_heavy_artillery_trail_02_emit.bp',
    EmtBpPath .. 'quark_bomb_01_emit.bp',
    EmtBpPath .. 'quark_bomb_02_emit.bp',
}
ASonanceWeaponFXTrail02 = {                                   # A larger version of ASonanceWeaponFXTrail01
    EmtBpPath .. 'aeon_heavy_artillery_trail_01_emit.bp',
    EmtBpPath .. 'quark_bomb2_01_emit.bp',
    EmtBpPath .. 'quark_bomb2_02_emit.bp',
}
ASonanceWeaponHit02 = {
    EmtBpPath .. 'aeon_sonance_hit_01_emit.bp',
    EmtBpPath .. 'aeon_sonance_hit_02_emit.bp',
    EmtBpPath .. 'aeon_sonance_hit_03_emit.bp',
    EmtBpPath .. 'aeon_sonance_hit_04_emit.bp',
    EmtBpPath .. 'quark_bomb_explosion_08_emit.bp',
    EmtBpPath .. 'quark_bomb_explosion_06_emit.bp',
    EmtBpPath .. 'quark_bomb_explosion_03_emit.bp',
    EmtBpPath .. 'quark_bomb_explosion_04_emit.bp',
    EmtBpPath .. 'quark_bomb_explosion_05_emit.bp',
    EmtBpPath .. 'quark_bomb_explosion_07_emit.bp',	 
}

ASonicPulse01 = { EmtBpPath .. 'sonic_pulse_hit_flash_01_emit.bp',}
ASonicPulseHitUnit01 = TableCat( ASonicPulse01, UnitHitShrapnel01 )
ASonicPulseHitAirUnit01 = ASonicPulseHitUnit01
ASonicPulseHitLand01 = TableCat( ASonicPulse01 )

ASonicPulsarMunition01 = {
	'/effects/emitters/sonic_pulsar_01_emit.bp', 
}

ATemporalFizzHit01 = {
	EmtBpPath .. 'temporal_fizz_02_emit.bp',
    EmtBpPath .. 'temporal_fizz_03_emit.bp',
    EmtBpPath .. 'temporal_fizz_hit_flash_01_emit.bp',
}

ATorpedoUnitHit01 = TableCat( DefaultProjectileWaterImpact, DefaultProjectileUnderWaterImpact )

#---------------------------------------------------------------
# ### CYBRAN UNIT AMBIENT EFFECTS ###

CT2PowerAmbient = {
    EmtBpPath .. 'cybran_t2power_ambient_01_emit.bp',
    EmtBpPath .. 'cybran_t2power_ambient_01b_emit.bp',
    EmtBpPath .. 'cybran_t2power_ambient_02_emit.bp',
    EmtBpPath .. 'cybran_t2power_ambient_02b_emit.bp',
    EmtBpPath .. 'cybran_t2power_ambient_03_emit.bp',
    EmtBpPath .. 'cybran_t2power_ambient_03b_emit.bp',
}

CT3PowerAmbient = {
    EmtBpPath .. 'cybran_t3power_ambient_01_emit.bp',
    EmtBpPath .. 'cybran_t3power_ambient_01b_emit.bp',
    EmtBpPath .. 'cybran_t3power_ambient_02_emit.bp',
    EmtBpPath .. 'cybran_t3power_ambient_02b_emit.bp',
    EmtBpPath .. 'cybran_t3power_ambient_03_emit.bp',
    EmtBpPath .. 'cybran_t3power_ambient_03b_emit.bp',
}

#---------------------------------------------------------------
# ### CYBRAN PROJECTILES ###

CAntiNukeLaunch01 = {
    EmtBpPath .. 'cybran_antinuke_launch_02_emit.bp',
    EmtBpPath .. 'cybran_antinuke_launch_03_emit.bp',
    EmtBpPath .. 'cybran_antinuke_launch_04_emit.bp',
    EmtBpPath .. 'cybran_antinuke_launch_05_emit.bp',
}

CAntiTorpedoHit01 = {
    EmtBpPath .. 'anti_torpedo_flare_hit_01_emit.bp',
	EmtBpPath .. 'anti_torpedo_flare_hit_02_emit.bp',    
	EmtBpPath .. 'anti_torpedo_flare_hit_03_emit.bp',	
}
CArtilleryHit01 = DefaultHitExplosion01

CBeamHit01 = {
    EmtBpPath .. 'beam_hit_sparks_01_emit.bp',
    EmtBpPath .. 'beam_hit_smoke_01_emit.bp',
}
CBeamHitUnit01 = CBeamHit01
CBeamHitLand01 = CBeamHit01

CBombHit01 = {
    EmtBpPath .. 'bomb_hit_flash_01_emit.bp',
    EmtBpPath .. 'bomb_hit_fire_01_emit.bp',
    EmtBpPath .. 'bomb_hit_fire_shadow_01_emit.bp',
}

CCommanderOverchargeFxTrail01 = {
	EmtBpPath .. 'cybran_commander_overcharge_fxtrail_01_emit.bp',
	EmtBpPath .. 'cybran_commander_overcharge_fxtrail_02_emit.bp',
}
CCommanderOverchargeHit01 = {
	EmtBpPath .. 'cybran_commander_overcharge_hit_01_emit.bp',
	EmtBpPath .. 'cybran_commander_overcharge_hit_02_emit.bp',
	#EmtBpPath .. 'cybran_commander_overcharge_hit_03_emit.bp',
}

CDisintegratorHit01 = {   
    EmtBpPath .. 'disintegrator_hit_flash_01_emit.bp',
    EmtBpPath .. 'disintegrator_hit_flash_02_emit.bp',
}
CDisintegratorHit02 = { EmtBpPath .. 'disintegrator_hit_sparks_01_emit.bp',}
CDisintegratorHitUnit01 = TableCat( CDisintegratorHit01, CDisintegratorHit02 )
CDisintegratorHitLand01 = CDisintegratorHit01

CDisruptorGroundEffect = {
	EmtBpPath .. 'cybran_lra_ground_effect_01_emit.bp'
}
CDisruptorVentEffect = {
	EmtBpPath .. 'cybran_lra_vent_effect_01_emit.bp'
}
CDisruptorMuzzleEffect = {
	EmtBpPath .. 'cybran_lra_muzzle_effect_01_emit.bp',
	EmtBpPath .. 'cybran_lra_muzzle_effect_02_emit.bp',
}
CDisruptorCoolDownEffect = {
	EmtBpPath .. 'cybran_lra_cooldown_effect_01_emit.bp',
	EmtBpPath .. 'cybran_lra_barrel_effect_01_emit.bp',
}

CElectronBolterMuzzleFlash01 = 
{
	EmtBpPath .. 'electron_bolter_flash_01_emit.bp',
	EmtBpPath .. 'electron_bolter_flash_02_emit.bp',
	EmtBpPath .. 'laserturret_muzzle_flash_01_emit.bp',
}

CElectronBolterMuzzleFlash02 = 
{
	EmtBpPath .. 'electron_bolter_flash_03_emit.bp',
    EmtBpPath .. 'electron_bolter_sparks_01_emit.bp',
}

CElectronBolterHit01 = {
    EmtBpPath .. 'electron_bolter_hit_02_emit.bp',
    EmtBpPath .. 'electron_bolter_hit_flash_01_emit.bp',
}
CElectronBolterHit02 = { EmtBpPath .. 'electron_bolter_hit_01_emit.bp',}
CElectronBolterHitUnit01 = TableCat( CElectronBolterHit01, CElectronBolterHit02 )
CElectronBolterHitLand01 = CElectronBolterHit01

CElectronBolterHit03 = {
    EmtBpPath .. 'electron_bolter_hit_02_emit.bp',
    EmtBpPath .. 'electron_bolter_hit_flash_01_emit.bp',
}

CElectronBolterHit04 = {
    EmtBpPath .. 'electron_bolter_hit_02_emit.bp',
    EmtBpPath .. 'electron_bolter_hit_flash_02_emit.bp',
}


CElectronBurstCloud01 = {
    EmtBpPath .. 'electron_burst_cloud_gas_01_emit.bp',
    EmtBpPath .. 'electron_burst_cloud_sparks_01_emit.bp',
    EmtBpPath .. 'electron_burst_cloud_flash_01_emit.bp',
}

CEMPGrenadeHit01 = {
    EmtBpPath .. 'cybran_empgrenade_hit_01_emit.bp',
    EmtBpPath .. 'cybran_empgrenade_hit_02_emit.bp',
    EmtBpPath .. 'cybran_empgrenade_hit_03_emit.bp',    
}

CIFCruiseMissileLaunchSmoke = {
    EmtBpPath .. 'cybran_cruise_missile_launch_01_emit.bp',
    EmtBpPath .. 'cybran_cruise_missile_launch_02_emit.bp',
}

CLaserHit01 = {   
    EmtBpPath .. 'cybran_laser_hit_flash_01_emit.bp',
    EmtBpPath .. 'cybran_laser_hit_flash_02_emit.bp',
}
CLaserHit02 = {   
    EmtBpPath .. 'cybran_laser_hit_flash_01_emit.bp',
    EmtBpPath .. 'cybran_laser_hit_sparks_01_emit.bp',
}
CLaserHitLand01 = CLaserHit01
CLaserHitUnit01 = TableCat( CLaserHit02, UnitHitShrapnel01 )
CLaserMuzzleFlash01 = {
    EmtBpPath .. 'laser_muzzle_flash_02_emit.bp',
    EmtBpPath .. 'default_muzzle_flash_01_emit.bp',
    EmtBpPath .. 'default_muzzle_flash_02_emit.bp',
}

CLaserMuzzleFlash02 = {
    EmtBpPath .. 'cybran_laser_muzzle_flash_01_emit.bp',
    EmtBpPath .. 'cybran_laser_muzzle_flash_02_emit.bp',
}
                          
CMicrowaveLaserMuzzle01 = { 
    EmtBpPath .. 'microwave_laser_flash_01_emit.bp',
    EmtBpPath .. 'microwave_laser_muzzle_01_emit.bp',
}

CMicrowaveLaserCharge01 = { 
    EmtBpPath .. 'microwave_laser_charge_01_emit.bp',
    EmtBpPath .. 'microwave_laser_charge_02_emit.bp',
}
CMicrowaveLaserEndPoint01 = {
    EmtBpPath .. 'microwave_laser_end_01_emit.bp',
    EmtBpPath .. 'microwave_laser_end_02_emit.bp',
    EmtBpPath .. 'microwave_laser_end_03_emit.bp',
    EmtBpPath .. 'microwave_laser_end_04_emit.bp',
    EmtBpPath .. 'microwave_laser_end_05_emit.bp',
    EmtBpPath .. 'microwave_laser_end_06_emit.bp',
}

CMissileHit01 = DefaultMissileHit01
CMissileLOAHit01 = {
    EmtBpPath .. 'cybran_missile_hit_01_emit.bp',
    EmtBpPath .. 'cybran_missile_hit_02_emit.bp',
}

#CMolecularResonanceHitUnit01 = {
#    EmtBpPath .. 'molecular_resonance_cannon_01_emit.bp',
#    EmtBpPath .. 'molecular_resonance_cannon_02_emit.bp',
#    EmtBpPath .. 'molecular_resonance_cannon_03_emit.bp',
#    EmtBpPath .. 'molecular_resonance_cannon_04_emit.bp',
#    EmtBpPath .. 'molecular_resonance_cannon_ring_03_emit.bp',
#    EmtBpPath .. 'molecular_resonance_cannon_ring_04_emit.bp',
#}
CMolecularResonanceHitUnit01 = {
    EmtBpPath .. 'cybran_light_artillery_hit_01_emit.bp',
    EmtBpPath .. 'cybran_light_artillery_hit_02_emit.bp',
}

CMolecularResonanceHitLand01 = {
    EmtBpPath .. 'dust_cloud_06_emit.bp',
    EmtBpPath .. 'dirtchunks_01_emit.bp',
    EmtBpPath .. 'molecular_resonance_cannon_ring_02_emit.bp',
}

CMolecularRipperFlash01 = {
	EmtBpPath .. 'molecular_ripper_flash_01_emit.bp',
	EmtBpPath .. 'molecular_ripper_charge_01_emit.bp',		
	EmtBpPath .. 'molecular_ripper_charge_02_emit.bp',
	EmtBpPath .. 'molecular_cannon_muzzle_flash_01_emit.bp',
	EmtBpPath .. 'default_muzzle_flash_01_emit.bp',		
	EmtBpPath .. 'default_muzzle_flash_02_emit.bp'				
}
CMolecularRipperOverChargeFlash01 = {
	EmtBpPath .. 'molecular_ripper_flash_01_emit.bp',
	EmtBpPath .. 'molecular_ripper_oc_charge_01_emit.bp',
	EmtBpPath .. 'molecular_ripper_oc_charge_02_emit.bp',					
	EmtBpPath .. 'molecular_ripper_oc_charge_03_emit.bp',		
	EmtBpPath .. 'molecular_cannon_muzzle_flash_01_emit.bp',
	EmtBpPath .. 'default_muzzle_flash_01_emit.bp',		
	EmtBpPath .. 'default_muzzle_flash_02_emit.bp'				
}
CMolecularCannon01 = {
	EmtBpPath .. 'molecular_ripper_01_emit.bp',
	EmtBpPath .. 'molecular_ripper_02_emit.bp',
}

CMolecularRipperHit01 = {   
    EmtBpPath .. 'disintegrator_hit_flash_01_emit.bp',
    EmtBpPath .. 'disintegrator_hit_flash_02_emit.bp',
    EmtBpPath .. 'molecular_ripper_hit_01_emit.bp',    
}

CNeutronClusterBombHit01 = {
    EmtBpPath .. 'neutron_cluster_bomb_hit_01_emit.bp',
    EmtBpPath .. 'neutron_cluster_bomb_hit_02_emit.bp',
}
CNeutronClusterBombHitUnit01 = CNeutronClusterBombHit01
CNeutronClusterBombHitLand01 = CNeutronClusterBombHit01
CNeutronClusterBombHitWater01 = CNeutronClusterBombHit01

CParticleCannonHit01 = { EmtBpPath .. 'laserturret_hit_flash_01_emit.bp',}
CParticleCannonHitUnit01 = TableCat( CParticleCannonHit01, UnitHitShrapnel01 )
CParticleCannonHitLand01 = TableCat( CParticleCannonHit01 )

CProtonBombHit01 = {
    EmtBpPath .. 'proton_bomb_hit_01_emit.bp',
    EmtBpPath .. 'proton_bomb_hit_02_emit.bp',
}
CProtonCannonHit01 = {
     EmtBpPath .. 'proton_cannon_hit_01_emit.bp',
}
CProtonCannonPolyTrail =  EmtBpPath .. 'proton_cannon_polytrail_01_emit.bp'
CProtonCannonPolyTrail02 =  EmtBpPath .. 'proton_cannon_polytrail_02_emit.bp'
CProtonCannonFXTrail01 =  { EmtBpPath .. 'proton_cannon_fxtrail_01_emit.bp' }
CProtonCannonFXTrail02 =  { EmtBpPath .. 'proton_cannon_fxtrail_02_emit.bp' }
CProtonArtilleryPolytrail01 = EmtBpPath .. 'proton_artillery_polytrail_01_emit.bp'
CProtonArtilleryHit01 = {
    EmtBpPath .. 'proton_bomb_hit_02_emit.bp',
    EmtBpPath .. 'proton_artillery_hit_01_emit.bp',    
    EmtBpPath .. 'proton_artillery_hit_02_emit.bp',        
    EmtBpPath .. 'proton_artillery_hit_03_emit.bp',            
    EmtBpPath .. 'shockwave_01_emit.bp',    
}

CTorpedoUnitHit01 = TableCat( DefaultProjectileWaterImpact, DefaultProjectileUnderWaterImpact )

CZealotLaunch01 = {
    EmtBpPath .. 'muzzle_flash_01_emit.bp',
    EmtBpPath .. 'zealot_launch_01_emit.bp',
    EmtBpPath .. 'zealot_launch_02_emit.bp', 
}

#---------------------------------------------------------------
# ### TERRAN UEF PROJECTILES ###

TAAGinsuHitLand = {
    EmtBpPath .. 'ginsu_laser_hit_land_01_emit.bp',
}

TAAGinsuHitUnit = {
    EmtBpPath .. 'ginsu_laser_hit_unit_01_emit.bp',
    EmtBpPath .. 'laserturret_hit_flash_03_emit.bp',
    EmtBpPath .. 'destruction_unit_hit_shrapnel_01_emit.bp',
}

TAAMissileLaunch = {
    EmtBpPath .. 'terran_sam_launch_smoke_emit.bp',
    EmtBpPath .. 'terran_sam_launch_smoke2_emit.bp',
}
TAAMissileLaunchNoBackSmoke = {
    EmtBpPath .. 'terran_sam_launch_smoke_emit.bp',
}

TMissileExhaust01 = { EmtBpPath .. 'missile_munition_trail_01_emit.bp',}
TMissileExhaust02 = { EmtBpPath .. 'missile_munition_trail_02_emit.bp',}
TMissileExhaust03 = { EmtBpPath .. 'missile_smoke_exhaust_02_emit.bp',}

TAntiMatterShellHit01 = {
    EmtBpPath .. 'napalm_flash_emit.bp',
    EmtBpPath .. 'destruction_explosion_fire_plume_02_emit.bp',
    EmtBpPath .. 'napalm_thin_smoke_emit.bp', 
    EmtBpPath .. 'gauss_cannon_hit_01_emit.bp',
    EmtBpPath .. 'gauss_cannon_hit_02_emit.bp',
    EmtBpPath .. 'gauss_cannon_hit_03_emit.bp',
    EmtBpPath .. 'gauss_cannon_hit_04_emit.bp',
    EmtBpPath .. 'gauss_cannon_hit_05_emit.bp',
    EmtBpPath .. 'destruction_explosion_concussion_ring_01_emit.bp',
    EmtBpPath .. 'quantum_hit_flash_07_emit.bp',
    EmtBpPath .. 'terran_commander_overcharge_hit_01_emit.bp',
    EmtBpPath .. 'terran_commander_overcharge_hit_02_emit.bp',
    EmtBpPath .. 'terran_commander_overcharge_hit_03_emit.bp',
    EmtBpPath .. 'terran_commander_overcharge_hit_04_emit.bp',
    EmtBpPath .. 'fire_cloud_05_emit.bp',
    EmtBpPath .. 'fire_cloud_04_emit.bp',
    EmtBpPath .. 'antimatter_hit_01_emit.bp',	##	glow	
    EmtBpPath .. 'antimatter_hit_02_emit.bp',	##	flash	     
    EmtBpPath .. 'antimatter_hit_03_emit.bp', 	##	sparks
    EmtBpPath .. 'antimatter_hit_04_emit.bp',	##	plume fire
    EmtBpPath .. 'antimatter_hit_05_emit.bp',	##	plume dark 
    EmtBpPath .. 'antimatter_hit_06_emit.bp',	##	base fire
    EmtBpPath .. 'antimatter_hit_07_emit.bp',	##	base dark 
    EmtBpPath .. 'antimatter_hit_08_emit.bp',	##	plume smoke
    EmtBpPath .. 'antimatter_hit_09_emit.bp',	##	base smoke
    EmtBpPath .. 'antimatter_hit_10_emit.bp',	##	plume highlights
    EmtBpPath .. 'antimatter_hit_11_emit.bp',	##	base highlights
    EmtBpPath .. 'antimatter_ring_01_emit.bp',	##	ring14
    EmtBpPath .. 'antimatter_ring_02_emit.bp',	##	ring11	     
}

TAPDSHit01 = {
    EmtBpPath .. 'bomb_hit_flash_01_emit.bp',
    EmtBpPath .. 'terran_artillery_hit_01_emit.bp',
    EmtBpPath .. 'terran_artillery_hit_02_emit.bp',
    EmtBpPath .. 'terran_artillery_hit_03_emit.bp',
}
TAPDSHitUnit01 = TAPDSHit01
TAPDSHitLand01 = TAPDSHit01



TBombHit01 = {
    EmtBpPath .. 'bomb_hit_flash_01_emit.bp',
    EmtBpPath .. 'bomb_hit_fire_01_emit.bp',
    EmtBpPath .. 'bomb_hit_fire_shadow_01_emit.bp',
}

TCommanderOverchargeFlash01 = {
    EmtBpPath .. 'terran_commander_overcharge_flash_01_emit.bp',
}
TCommanderOverchargeFXTrail01 = {
    EmtBpPath .. 'terran_commander_overcharge_trail_01_emit.bp',
    EmtBpPath .. 'terran_commander_overcharge_trail_02_emit.bp',
}
TCommanderOverchargeHit01 = {
    EmtBpPath .. 'quantum_hit_flash_07_emit.bp',
    EmtBpPath .. 'terran_commander_overcharge_hit_01_emit.bp',
    EmtBpPath .. 'terran_commander_overcharge_hit_02_emit.bp',
    EmtBpPath .. 'terran_commander_overcharge_hit_03_emit.bp',
    EmtBpPath .. 'terran_commander_overcharge_hit_04_emit.bp',
}

TFragmentationSensorShellFrag = {
    EmtBpPath .. 'terran_fragmentation_bomb_split_01_emit.bp',
    EmtBpPath .. 'terran_fragmentation_bomb_split_02_emit.bp',
}
TFragmentationSensorShellHit = {
    #EmtBpPath .. 'plasma_cannon_hit_01_emit.bp',
    EmtBpPath .. 'terran_fragmentation_bomb_hit_01_emit.bp',
    EmtBpPath .. 'terran_fragmentation_bomb_hit_02_emit.bp',
    EmtBpPath .. 'terran_fragmentation_bomb_hit_03_emit.bp',
    EmtBpPath .. 'terran_fragmentation_bomb_hit_04_emit.bp',
    EmtBpPath .. 'terran_fragmentation_bomb_hit_05_emit.bp',
}
TFragmentationSensorShellTrail = {
    EmtBpPath .. 'mortar_munition_02_emit.bp',
    EmtBpPath .. 'mortar_munition_02_flare_emit.bp',
}

TGaussCannonFlash = {
    EmtBpPath .. 'gauss_cannon_muzzle_flash_01_emit.bp',
    EmtBpPath .. 'gauss_cannon_muzzle_flash_02_emit.bp',
    EmtBpPath .. 'gauss_cannon_muzzle_smoke_02_emit.bp',
    #EmtBpPath .. 'cannon_muzzle_smoke_02_emit.bp',
    EmtBpPath .. 'cannon_muzzle_smoke_09_emit.bp', 
}
TGaussCannonHit01 = {
    EmtBpPath .. 'gauss_cannon_hit_01_emit.bp',
    EmtBpPath .. 'gauss_cannon_hit_02_emit.bp',
    EmtBpPath .. 'gauss_cannon_hit_03_emit.bp', #
    EmtBpPath .. 'gauss_cannon_hit_04_emit.bp',
    EmtBpPath .. 'gauss_cannon_hit_05_emit.bp',
}
TGaussCannonHit02 = {
    EmtBpPath .. 'gauss_cannon_hit_01_emit.bp',
    EmtBpPath .. 'gauss_cannon_hit_02_emit.bp',
    EmtBpPath .. 'gauss_cannon_hit_03_emit.bp', #
    EmtBpPath .. 'gauss_cannon_hit_04_emit.bp',
    EmtBpPath .. 'gauss_cannon_hit_05_emit.bp',
}
TGaussCannonHitUnit01 = TableCat( TGaussCannonHit01, UnitHitShrapnel01 )
TGaussCannonHitLand01 = TGaussCannonHit01
TGaussCannonHitUnit02 = TableCat( TGaussCannonHit02, UnitHitShrapnel01 )
TGaussCannonHitLand02 = TGaussCannonHit02
TGaussCannonPolyTrail =  {
   
    EmtBpPath .. 'gauss_cannon_polytrail_02_emit.bp',    
}

TFlakCannonMuzzleFlash01 = {
	EmtBpPath .. 'cannon_muzzle_flash_05_emit.bp',
    EmtBpPath .. 'muzzle_sparks_01_emit.bp',
    EmtBpPath .. 'cannon_muzzle_smoke_09_emit.bp', 		
}
TFragmentationShell01 = {
	EmtBpPath .. 'fragmentation_shell_phosphor_01_emit.bp',
    EmtBpPath .. 'fragmentation_shell_hit_flash_01_emit.bp',
    EmtBpPath .. 'fragmentation_shell_shrapnel_01_emit.bp',
    EmtBpPath .. 'fragmentation_shell_smoke_01_emit.bp',
}

TIFCruiseMissileLaunchSmoke = {
    EmtBpPath .. 'terran_cruise_missile_launch_01_emit.bp',
    EmtBpPath .. 'terran_cruise_missile_launch_02_emit.bp',
}
TIFCruiseMissileLaunchBuilding = {
    EmtBpPath .. 'terran_cruise_missile_launch_03_emit.bp',
    EmtBpPath .. 'terran_cruise_missile_launch_04_emit.bp',
    EmtBpPath .. 'terran_cruise_missile_launch_05_emit.bp',
}
TIFCruiseMissileLaunchUnderWater = {
    EmtBpPath .. 'terran_cruise_missile_sublaunch_01_emit.bp',
}
TIFCruiseMissileLaunchExitWater = {
    EmtBpPath .. 'water_splash_ripples_ring_01_emit.bp',
    EmtBpPath .. 'water_splash_plume_01_emit.bp',
}

TIFArtilleryMuzzleFlash = {
    EmtBpPath .. 'cannon_artillery_muzzle_flash_01_emit.bp',
    #EmtBpPath .. 'cannon_muzzle_smoke_06_emit.bp',
    EmtBpPath .. 'cannon_muzzle_smoke_07_emit.bp',
    EmtBpPath .. 'cannon_muzzle_smoke_10_emit.bp',
    EmtBpPath .. 'cannon_muzzle_flash_03_emit.bp',
}
    
TLaserHit01 = { EmtBpPath .. 'laserturret_hit_flash_02_emit.bp',}
TLaserHit02 = { 
    EmtBpPath .. 'terran_commander_cannon_hit_01_emit.bp',
    EmtBpPath .. 'heavy_plasma_cannon_hit_03_emit.bp',
    EmtBpPath .. 'terran_commander_cannon_hit_02_emit.bp',
    
}
TLaserHitUnit01 = TableCat( TLaserHit01, UnitHitShrapnel01 )
TLaserHitLand01 = TableCat( TLaserHit01 )
TLaserHitUnit02 = TableCat( TLaserHit02, UnitHitShrapnel01 )
TLaserHitLand02 = TableCat( TLaserHit02 )

TMachineGunPolyTrail =  EmtBpPath .. 'machinegun_polytrail_01_emit.bp'
#TMissileHit01 = DefaultMissileHit01
#TMissileHit01 = TGaussCannonHit01
TMissileHit01 = {
    EmtBpPath .. 'terran_missile_hit_01_emit.bp',
    EmtBpPath .. 'terran_missile_hit_02_emit.bp',
    EmtBpPath .. 'terran_missile_hit_03_emit.bp',
    EmtBpPath .. 'terran_missile_hit_04_emit.bp',
}


TMobileMortarMuzzleEffect01 = {
    EmtBpPath .. 'cannon_muzzle_smoke_02_emit.bp',
    EmtBpPath .. 'cannon_muzzle_smoke_09_emit.bp',     
    EmtBpPath .. 'cannon_artillery_fire_01_emit.bp',     
    EmtBpPath .. 'cannon_artillery_flash_01_emit.bp',      
}

TNapalmCarpetBombHitUnit01 = { EmtBpPath .. 'flash_01_emit.bp',}
TNapalmCarpetBombHitLand01 = {
    EmtBpPath .. 'napalm_flash_emit.bp',
    EmtBpPath .. 'napalm_thick_smoke_emit.bp',
    ModPath  .. 'napalm_fire_emit_2.bp',
    EmtBpPath .. 'napalm_thin_smoke_emit.bp',
    EmtBpPath .. 'napalm_01_emit.bp',
}

TNukeRings01 = {
    EmtBpPath .. 'nuke_concussion_ring_01_emit.bp',
	EmtBpPath .. 'nuke_concussion_ring_02_emit.bp',
}
TNukeFlavorPlume01 = { EmtBpPath .. 'nuke_smoke_trail01_emit.bp', }
TNukeGroundConvectionEffects01 = { EmtBpPath .. 'nuke_mist_01_emit.bp', }
TNukeBaseEffects01 = { EmtBpPath .. 'nuke_base03_emit.bp', }
TNukeBaseEffects02 = { EmtBpPath .. 'nuke_base05_emit.bp', }
TNukeHeadEffects01 = { EmtBpPath .. 'nuke_plume_01_emit.bp', }
TNukeHeadEffects02 = { 
	EmtBpPath .. 'nuke_head_smoke_03_emit.bp',
	EmtBpPath .. 'nuke_head_smoke_04_emit.bp',
		
}
TNukeHeadEffects03 = { EmtBpPath .. 'nuke_head_fire_01_emit.bp', }

TRailGunMuzzleFlash01 = { EmtBpPath .. 'railgun_flash_02_emit.bp', }
TRailGunMuzzleFlash02 = { EmtBpPath .. 'muzzle_flash_01_emit.bp', }
TRailGunHitAir01 = {
	EmtBpPath .. 'destruction_unit_hit_shrapnel_01_emit.bp',
	EmtBpPath .. 'terran_railgun_hit_air_01_emit.bp',
	EmtBpPath .. 'terran_railgun_hit_air_02_emit.bp',
	EmtBpPath .. 'terran_railgun_hit_air_03_emit.bp',
}
TRailGunHitGround01 = {
	EmtBpPath .. 'destruction_unit_hit_shrapnel_01_emit.bp',
	EmtBpPath .. 'terran_railgun_hit_ground_01_emit.bp',
	EmtBpPath .. 'terran_railgun_hit_air_02_emit.bp',
	EmtBpPath .. 'terran_railgun_hit_ground_03_emit.bp',
}


TRiotGunHit01 = {
     EmtBpPath .. 'riot_gun_hit_01_emit.bp',
     EmtBpPath .. 'riot_gun_hit_02_emit.bp',
}
TRiotGunHitUnit01 = TableCat( TRiotGunHit01, UnitHitShrapnel01 )
TRiotGunMuzzleFx = {
	EmtBpPath .. 'riotgun_muzzle_fire_01_emit.bp',
	EmtBpPath .. 'riotgun_muzzle_flash_01_emit.bp',
	EmtBpPath .. 'riotgun_muzzle_smoke_01_emit.bp',
	EmtBpPath .. 'riotgun_muzzle_sparks_01_emit.bp',
    EmtBpPath .. 'cannon_muzzle_flash_01_emit.bp',
}
TRiotGunMuzzleFxTank = {
	EmtBpPath .. 'riotgun_muzzle_fire_01_emit.bp',
	EmtBpPath .. 'riotgun_muzzle_flash_02_emit.bp',		
	EmtBpPath .. 'riotgun_muzzle_smoke_01_emit.bp',
}
TRiotGunPolyTrails = {
    #EmtBpPath .. 'phalanx_munition_polytrail_01_emit.bp',
    ModPath .. 'riot_gun_polytrail_01_emit.bp',
    ModPath .. 'riot_gun_polytrail_02_emit.bp',
    ModPath .. 'riot_gun_polytrail_03_emit.bp',
}

TRiotGunPolyTrailsTank = {
    #EmtBpPath .. 'phalanx_munition_polytrail_01_emit.bp',
    EmtBpPath .. 'riot_gun_polytrail_tank_01_emit.bp',
    EmtBpPath .. 'riot_gun_polytrail_tank_02_emit.bp',
    EmtBpPath .. 'riot_gun_polytrail_tank_03_emit.bp',
}
TRiotGunPolyTrailsOffsets = {0.00,0.00,0.00}

TRiotGunMunition01 = {
    EmtBpPath .. 'riotgun_munition_01_emit.bp',
}

TPhalanxGunPolyTrails = {
    EmtBpPath .. 'phalanx_munition_polytrail_01_emit.bp',
}
TPhalanxGunMuzzleFlash = {
    EmtBpPath .. 'phalanx_muzzle_flash_01_emit.bp',
    EmtBpPath .. 'phalanx_muzzle_glow_01_emit.bp',
}
TPhalanxGunShells = {
    EmtBpPath .. 'phalanx_shells_01_emit.bp',
}
TPhalanxGunPolyTrailsOffsets = {0.05,0.05,0.05}

TPlasmaCannonLightMuzzleFlash = {
    '/effects/emitters/plasma_cannon_muzzle_flash_03_emit.bp',
    '/effects/emitters/plasma_cannon_muzzle_flash_04_emit.bp',    
}
TPlasmaCannonLightHit01 = {
    EmtBpPath .. 'plasma_cannon_hit_01_emit.bp',
    EmtBpPath .. 'plasma_cannon_hit_02_emit.bp',
    EmtBpPath .. 'plasma_cannon_hit_03_emit.bp',
    EmtBpPath .. 'cannon_muzzle_flash_01_emit.bp',
}
TPlasmaCannonLightHitUnit01 = TPlasmaCannonLightHit01 
TPlasmaCannonLightHitLand01 = TPlasmaCannonLightHit01

TPlasmaCannonHeavyMuzzleFlash = {
    '/effects/emitters/plasma_cannon_muzzle_flash_01_emit.bp',
    '/effects/emitters/plasma_cannon_muzzle_flash_02_emit.bp',
    '/effects/emitters/cannon_muzzle_flash_01_emit.bp',
}
TPlasmaCannonHeavyHit01 = {
    EmtBpPath .. 'heavy_plasma_cannon_hit_01_emit.bp',
    EmtBpPath .. 'heavy_plasma_cannon_hit_02_emit.bp',
    EmtBpPath .. 'heavy_plasma_cannon_hit_03_emit.bp',
    EmtBpPath .. 'heavy_plasma_cannon_hit_04_emit.bp',
}
TPlasmaCannonHeavyHitUnit01 = TPlasmaCannonHeavyHit01 
TPlasmaCannonHeavyHitLand01 = TPlasmaCannonHeavyHit01
TPlasmaCannonHeavyMunition = {
    EmtBpPath .. 'plasma_cannon_trail_02_emit.bp',
}
TPlasmaCannonHeavyPolyTrails = {
    EmtBpPath .. 'plasma_cannon_polytrail_01_emit.bp',
    EmtBpPath .. 'plasma_cannon_polytrail_02_emit.bp',
    EmtBpPath .. 'plasma_cannon_polytrail_03_emit.bp',
}
TPlasmaCannonLightMunition = {
    EmtBpPath .. 'plasma_cannon_trail_01_emit.bp',
}
TPlasmaCannonLightPolyTrail = EmtBpPath .. 'plasma_cannon_polytrail_04_emit.bp'


TSmallYieldNuclearBombHit01 = {
    EmtBpPath .. 'terran_bomber_bomb_explosion_01_emit.bp',
    #EmtBpPath .. 'terran_bomber_bomb_explosion_02_emit.bp',
    EmtBpPath .. 'terran_bomber_bomb_explosion_03_emit.bp',
    EmtBpPath .. 'terran_bomber_bomb_explosion_05_emit.bp',
    EmtBpPath .. 'terran_bomber_bomb_explosion_06_emit.bp',
}

TTorpedoHitUnit01 = TableCat( DefaultProjectileWaterImpact, DefaultProjectileUnderWaterImpact )
TTorpedoHitUnitUnderwater01 = DefaultProjectileUnderWaterImpact


# -----------------------------------------------------------------------------------
# ##  TEST EMITTERS!  ##
# -----------------------------------------------------------------------------------
TestExplosion01 = {
    EmtBpPath .. '_test_explosion_b1_emit.bp', #lowest layer orange   
    EmtBpPath .. '_test_explosion_b2_emit.bp', #top layer smoke   
    EmtBpPath .. '_test_explosion_b3_emit.bp', #midlayer orange   
    EmtBpPath .. '_test_explosion_b1_flash_emit.bp',    
    EmtBpPath .. '_test_explosion_b1_sparks_emit.bp',  
    EmtBpPath .. '_test_explosion_b2_dustring_emit.bp',  
    EmtBpPath .. '_test_explosion_b2_flare_emit.bp',                             
    EmtBpPath .. '_test_explosion_b2_smokemask_emit.bp',       
}

CSGTestEffect = {
    EmtBpPath .. '_test_explosion_medium_01_emit.bp',
    EmtBpPath .. '_test_explosion_medium_02_emit.bp',
    EmtBpPath .. '_test_explosion_medium_03_emit.bp',
    EmtBpPath .. '_test_explosion_medium_04_emit.bp',
    EmtBpPath .. '_test_explosion_medium_05_emit.bp',
    EmtBpPath .. '_test_explosion_medium_06_emit.bp',
}

CSGTestEffect2 = {
    EmtBpPath .. '_test_swirl_01b_emit.bp',
    #EmtBpPath .. '_test_swirl_02_emit.bp',
    EmtBpPath .. '_test_swirl_03_emit.bp',
    EmtBpPath .. '_test_swirl_04_emit.bp',
    EmtBpPath .. '_test_swirl_05_emit.bp',
    EmtBpPath .. '_test_swirl_06_emit.bp',
}
CSGTestSpinner1 = {
    EmtBpPath .. '_test_gatecloud_01_emit.bp',
    EmtBpPath .. '_test_gatecloud_02_emit.bp',
    EmtBpPath .. '_test_gatecloud_03_emit.bp',
}
CSGTestSpinner2 = {
    EmtBpPath .. '_test_gatecloud_04_emit.bp',
    EmtBpPath .. '_test_gatecloud_05_emit.bp',
}
CSGTestSpinner3 = {
    #EmtBpPath .. '_test_gatecloud_06_emit.bp',
    EmtBpPath .. '_test_gatecloud_07_emit.bp',
}


######
# Delete these soon...
######
CSGTestAeonGroundFX = {
    EmtBpPath .. '_test_aeon_groundfx_emit.bp',
}

CSGTestAeonGroundFXSmall = {
    EmtBpPath .. '_test_aeon_groundfx_small_emit.bp',
}

CSGTestAeonGroundFXMedium = {
    EmtBpPath .. '_test_aeon_groundfx_medium_emit.bp',
}

CSGTestAeonGroundFXLow = {
    EmtBpPath .. '_test_aeon_groundfx_low_emit.bp',
}

CSGTestAeonT2EngineerGroundFX = {
    EmtBpPath .. '_test_aeon_t2eng_groundfx01_emit.bp',
    EmtBpPath .. '_test_aeon_t2eng_groundfx02_emit.bp',
}
