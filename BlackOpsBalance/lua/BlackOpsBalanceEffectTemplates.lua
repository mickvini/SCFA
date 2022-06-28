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
EmtBpPathAlt = '/mods/BlackOpsBalance/effects/emitters/'
EmitterTempEmtBpPath = '/effects/emitters/temp/'


#---------------------------------------------------------------

UnitHitShrapnel01 = { EmtBpPath .. 'destruction_unit_hit_shrapnel_01_emit.bp',}

#-------------------------------------------
#			NEW AEON NUKE EFFECTS
#-------------------------------------------
AeonNukeHit01 = {
    EmtBpPathAlt .. 'aeon_nuke_hit_01_emit.bp',			## plasma outward
    EmtBpPathAlt .. 'aeon_nuke_hit_02_emit.bp',			## spiky lines
    EmtBpPathAlt .. 'aeon_nuke_hit_03_emit.bp',			## plasma darkening outward
    EmtBpPathAlt .. 'aeon_nuke_hit_04_emit.bp',			## twirling line buildup
    EmtBpPathAlt .. 'aeon_nuke_detonate_03_emit.bp',	## non oriented glow
    --EmtBpPath .. 'seraphim_expnuke_concussion_01_emit.bp',	## ring fast
    --EmtBpPath .. 'seraphim_expnuke_concussion_02_emit.bp',	## ring slow
}
AeonNukePlumeFxTrails03 = {
    EmtBpPathAlt .. 'aeon_nuke_plume_fxtrails_05_emit.bp',		## plasma trail 
    EmtBpPathAlt .. 'aeon_nuke_plume_fxtrails_06_emit.bp',		## plasma trail darkening  
    EmtBpPathAlt .. 'aeon_nuke_plume_fxtrails_10_emit.bp',		## bright tip
    #EmtBpPath .. '_align_x_emit.bp',
	#EmtBpPath .. '_align_y_emit.bp',
	#EmtBpPath .. '_align_z_emit.bp',   
}
AeonNukePlumeFxTrails05 = {
    EmtBpPathAlt .. 'aeon_nuke_plume_fxtrails_07_emit.bp',	## plasma cloud 
    EmtBpPathAlt .. 'aeon_nuke_plume_fxtrails_08_emit.bp',	## plasma cloud 2, ser 07    
}
AeonNukePlumeFxTrails06 = {
    EmtBpPathAlt .. 'aeon_nuke_plume_fxtrails_09_emit.bp',	## line detail in explosion, fingers.
}


AeonNukeDetonate01 = {
    EmtBpPathAlt .. 'aeon_nuke_explode_01_emit.bp',		## glow
    EmtBpPathAlt .. 'aeon_nuke_explode_02_emit.bp',		## upwards plasma tall    
    EmtBpPathAlt .. 'aeon_nuke_explode_03_emit.bp',		## upwards plasma short/wide    
    EmtBpPathAlt .. 'aeon_nuke_explode_04_emit.bp',		## upwards plasma top column, thin/tall
    EmtBpPathAlt .. 'aeon_nuke_explode_05_emit.bp',		## upwards lines
    EmtBpPathAlt .. 'aeon_nuke_concussion_01_emit.bp',	## ring
    EmtBpPathAlt .. 'aeon_nuke_concussion_02_emit.bp',	## smaller/slower ring bursts
    EmtBpPathAlt .. 'aeon_nuke_hit_05_emit.bp',		## fast flash
    EmtBpPathAlt .. 'aeon_nuke_hit_14_emit.bp',		## long glow
    EmtBpPathAlt .. 'aeon_nuke_hit_13_emit.bp',		## faint plasma, ser7    
}

#-----------------------------------------
#				END EFFECTS
#-----------------------------------------

#---------------------------------------------------------
#				NEW CYBRAN NUKE EFFECTS
#---------------------------------------------------------
CybranNukePlumeFxTrails05 = {
    EmtBpPathAlt .. 'cybran_nuke_plume_fxtrails_07_emit.bp',	## plasma cloud 
    EmtBpPathAlt .. 'cybran_nuke_plume_fxtrails_08_emit.bp',	## plasma cloud 2, ser 07    
}

CybranNukeHeadEffects02 = { 
	EmtBpPathAlt .. 'cybran_nuke_head_smoke_03_emit.bp',
	EmtBpPathAlt .. 'cybran_nuke_head_smoke_04_emit.bp',
		
}
CybranNukeHeadEffects03 = { EmtBpPathAlt .. 'cybran_nuke_head_fire_01_emit.bp', }


#-----------------------------------------------------------
#					END EFFECTS
#-----------------------------------------------------------

CybranPlasmaBallPolytrail01 = EmtBpPath .. 'aeon_quantic_cluster_polytrail_01_emit.bp'
CybranPlasmaBallFxtrail01 = {
	EmtBpPathAlt .. 'cybran_plasma_ball_fxtrails_01_emit.bp',
    EmtBpPathAlt .. 'cybran_plasma_ball_fxtrails_02_emit.bp',
    EmtBpPathAlt .. 'cybran_plasma_ball_fxtrail_03_emit.bp',	##after cloud
    EmtBpPathAlt .. 'cybran_plasma_ball_fxtrail_06_emit.bp',#air ripple
    EmtBpPathAlt .. 'cybran_plasma_ball_fxtrail_08_emit.bp',#ripple
    EmtBpPathAlt .. 'cybran_plasma_ball_fxtrail_09_emit.bp',#ripple

}
CybranPlasmaBallChildFxtrail01 = {
	EmtBpPathAlt .. 'cybran_plasma_ball_child_fxtrails_01_emit.bp',
    EmtBpPathAlt .. 'cybran_plasma_ball_child_fxtrails_02_emit.bp',
}
CybranPlasmaBallHitLand01 = {
    --EmtBpPathAlt .. 'napalm_hvy_flash_emit.bp',
    --EmtBpPathAlt .. 'napalm_hvy_thin_smoke_emit.bp',
    EmtBpPathAlt .. 'blue_napalm_hvy_01_emit.bp',
    EmtBpPathAlt .. 'blue_napalm_hvy_02_emit.bp',
    EmtBpPathAlt .. 'blue_napalm_hvy_03_emit.bp',
}



