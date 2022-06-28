#****************************************************************************
#**
#**  File     :  /data/lua/EffectTemplates.lua
#**  Author(s):  Gordon Duclos, Greg Kohne, Matt Vainio, Aaron Lundquist
#**
#**  Summary  :  Generic templates for commonly used effects
#**
#**  Copyright © 2006 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
TableCat = import('/lua/utilities.lua').TableCat
EmtBpPath = '/effects/emitters/'
ModPath = '/mods/4th_Dimension_212/hook/effects/emitters/'
EmitterTempEmtBpPath = '/effects/emitters/temp/'


# For gatling gun cooldown
WeaponSteam01 = {
    EmtBpPath .. 'weapon_mist_01_emit.bp',
}




-- #---------------------------------------------------------------
-- # Concussion Ring Effects
-- #---------------------------------------------------------------
-- ConcussionRingSml01 = { EmtBpPath .. 'destruction_explosion_concussion_ring_02_emit.bp',}
-- ConcussionRingMed01 = { EmtBpPath .. 'destruction_explosion_concussion_ring_01_emit.bp',}
-- ConcussionRingLrg01 = { EmtBpPath .. 'destruction_explosion_concussion_ring_01_emit.bp',}


#---------------------------------------------------------------
# Fire Cloud Effects
#---------------------------------------------------------------
FireCloudSml01 = {
    EmtBpPath .. 'fire_cloud_05_emit.bp',
    EmtBpPath .. 'fire_cloud_04_emit.bp',
}

-- FireCloudMed01 = {
    -- EmtBpPath .. 'fire_cloud_06_emit.bp',
    -- EmtBpPath .. 'explosion_fire_sparks_01_emit.bp',
-- }


-- #---------------------------------------------------------------
-- # FireShadow Faked Flat Particle Effects
-- #---------------------------------------------------------------
-- FireShadowSml01 = { EmtBpPath .. 'destruction_explosion_fire_shadow_02_emit.bp',}
-- FireShadowMed01 = { EmtBpPath .. 'destruction_explosion_fire_shadow_01_emit.bp',}
-- FireShadowLrg01 = { EmtBpPath .. 'destruction_explosion_fire_shadow_01_emit.bp',}


#---------------------------------------------------------------
# Flash Effects
#---------------------------------------------------------------
FlashSml01 = { EmtBpPath .. 'flash_01_emit.bp',}


#---------------------------------------------------------------
# Flare Effects
#---------------------------------------------------------------
FlareSml01 = { EmtBpPath .. 'flare_01_emit.bp',}


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
}
DefaultProjectileUnderWaterImpact = {
    EmtBpPath .. 'destruction_underwater_explosion_flash_01_emit.bp',
    EmtBpPath .. 'destruction_underwater_explosion_flash_02_emit.bp',
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




#------------------------------------------------------------------------
#  TERRAN MAGMA CANNON EMITTERS:  Hacked by Ebola Soup for Magma Cannon from Ionized Plasma Gatling Cannon
#------------------------------------------------------------------------
TMagmaCannonHit01 = { # for all hits..ground and units

	# -- Below: borrowed from Heavy Napalm weapon.
	-- EmtBpPath .. 'napalm_hvy_flash_emit.bp',
    EmtBpPath .. 'napalm_hvy_thick_smoke_emit.bp',
    -- EmtBpPath .. 'napalm_hvy_thin_smoke_emit.bp',
    EmtBpPath .. 'napalm_hvy_01_emit.bp',
    -- EmtBpPath .. 'napalm_hvy_02_emit.bp',
    -- EmtBpPath .. 'napalm_hvy_03_emit.bp',
	# --------------
	# Ground hit effect borrowed from Cybran Artillery:
    ModPath .. 'balrog_proton_bomb_hit_01_emit.bp',
    -- ModPath .. 'balrog_proton_bomb_hit_02_emit.bp',
	# ----------------------
	# Impact frome Mavor shell:
    ModPath .. 'balrog_antimatter_hit_01_emit.bp',	##	glow	
    EmtBpPath .. 'antimatter_hit_02_emit.bp',	##	flash	     

    -- EmtBpPath .. 'antimatter_hit_04_emit.bp',	##	plume fire
    -- EmtBpPath .. 'antimatter_hit_05_emit.bp',	##	plume dark 
    -- EmtBpPath .. 'antimatter_hit_08_emit.bp',	##	plume smoke
    ModPath .. 'balrog_antimatter_hit_06_emit.bp',	##	base fire
    EmtBpPath .. 'antimatter_hit_07_emit.bp',	##	base dark 
    EmtBpPath .. 'antimatter_hit_09_emit.bp',	##	base smoke
    -- EmtBpPath .. 'antimatter_hit_10_emit.bp',	##	plume highlights
    EmtBpPath .. 'antimatter_hit_11_emit.bp',	##	base highlights
	-- EmtBpPath .. 'antimatter_hit_14_emit.bp',	##	base black stuff
    -- EmtBpPath .. 'antimatter_ring_02_emit.bp',	##	ring11
	EmtBpPath .. 'antimatter_ring_04_emit.bp',	##	black ring	
	#	----------------------------------------
	
}
TMagmaCannonHit02 = { # for Ground hits
    -- EmtBpPath .. 'ionized_plasma_gatling_cannon_laser_land_hit_01_emit.bp',
    -- EmtBpPath .. 'ionized_plasma_gatling_cannon_laser_land_hit_02_emit.bp',
    -- EmtBpPath .. 'antimatter_ring_01_emit.bp',	##	ring14
    EmtBpPath .. 'antimatter_hit_09_emit.bp',	##	base smoke

}

TMagmaCannonHit03 = { # for Unit hits
    -- EmtBpPath .. 'ionized_plasma_gatling_cannon_laser_hitunit_01_emit.bp',
    -- EmtBpPath .. 'ionized_plasma_gatling_cannon_laser_hitunit_03_emit.bp',
    -- EmtBpPath .. 'ionized_plasma_gatling_cannon_laser_hitunit_06_emit.bp',
    EmtBpPath .. 'antimatter_hit_03_emit.bp', 	##	sparks
    #  Additional fire:
    EmtBpPath .. 'explosion_fire_sparks_01_emit.bp',
    EmtBpPath .. 'flash_01_emit.bp', # Unit hit from Napalm bomb
}
TMagmaCannonUnitHit = TableCat( TMagmaCannonHit01, TMagmaCannonHit03, UnitHitShrapnel01 )
TMagmaCannonHit = TableCat( TMagmaCannonHit01, TMagmaCannonHit02 )
TMagmaCannonMuzzleFlash = {
    -- EmtBpPath .. 'ionized_plasma_gatling_cannon_laser_muzzle_flash_01_emit.bp',
    ModPath .. 'balrog_magma_cannon_muzzle_flash_01_emit.bp',
    -- EmtBpPath .. 'ionized_plasma_gatling_cannon_laser_muzzle_flash_02_emit.bp',
    ModPath .. 'balrog_magma_cannon_muzzle_flash_02_emit.bp',
    -- EmtBpPath .. 'ionized_plasma_gatling_cannon_laser_muzzle_flash_03_emit.bp',
    -- EmtBpPath .. 'ionized_plasma_gatling_cannon_laser_muzzle_flash_04_emit.bp',
    -- EmtBpPath .. 'ionized_plasma_gatling_cannon_laser_muzzle_flash_05_emit.bp',
    -- EmtBpPath .. 'ionized_plasma_gatling_cannon_laser_muzzle_flash_06_emit.bp',
	-- EmtBpPath .. 'fire_emit.bp',
	
}
TMagmaCannonFxTrails = {
    -- EmtBpPath .. 'ionized_plasma_gatling_cannon_laser_fxtrail_01_emit.bp',
    -- EmtBpPath .. 'ionized_plasma_gatling_cannon_laser_fxtrail_02_emit.bp', # faint tendrils around trail in original
    ModPath .. 'balrog_magma_projectile_fxtrail_01_emit.bp', # main orange/yellow glowing blob

}


TMagmaCannonPolyTrails = {
    ModPath .. 'balrog_missile_smoke_polytrail_01_emit.bp', # for dark black smoke around edges of fireball trail..transparent in center
    ModPath .. 'balrog_missile_smoke_polytrail_02_emit.bp', # narrower black/red trail following behind
}
