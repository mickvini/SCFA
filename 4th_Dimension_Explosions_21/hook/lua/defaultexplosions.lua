#****************************************************************************
#**
#**  File     :  /lua/defaultexplosions.lua
#**  Author(s):  Gordon Duclos
#**
#**  Summary  :
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local Entity = import('/lua/sim/entity.lua').Entity
local EffectTemplate = import('/lua/EffectTemplates.lua')
local util = import('utilities.lua')
local GetRandomFloat = util.GetRandomFloat
local GetRandomInt = util.GetRandomInt
local GetRandomOffset = util.GetRandomOffset
local EfctUtil = import('EffectUtilities.lua')
local CreateEffects = EfctUtil.CreateEffects
local CreateScaledEffects = EfctUtil.CreateEffects
local CreateEffectsWithOffset = EfctUtil.CreateEffectsWithOffset
local CreateEffectsWithRandomOffset = EfctUtil.CreateEffectsWithRandomOffset
local CreateBoneEffects = EfctUtil.CreateBoneEffects
local CreateBoneEffectsOffset = EfctUtil.CreateBoneEffectsOffset
local CreateRandomEffects = EfctUtil.CreateRandomEffects
local ScaleEmittersParam = EfctUtil.ScaleEmittersParam


#---------------------------------------------------------------
# UTILITY FUNCTIONS
#---------------------------------------------------------------
function GetUnitSizes( unit )
    local bp = unit:GetBlueprint()
    return bp.SizeX, bp.SizeY, bp.SizeZ
end

function GetUnitVolume( unit )
    local x,y,z = GetUnitSizes( unit )
    return x*y*z
end

function GetAverageBoundingXZRadius( unit )
    local bp = unit:GetBlueprint()
    return ((bp.SizeX + bp.SizeZ) * 0.5)
end

function GetAverageBoundingXYZRadius( unit )
    local bp = unit:GetBlueprint()
    return ((bp.SizeX + bp.SizeY + bp.SizeZ) * 0.333)
end

function QuatFromRotation( rotation, x, y, z )
    local angleRot, qw, qx, qy, qz, angle
    angle = 0.00872664625 * rotation
    angleRot = math.sin( angle )
    qw = math.cos( angle )
    qx = x * angleRot
    qy = y * angleRot
    qz = z * angleRot
    return qx, qy, qz, qw
end

#---------------------------------------------------------------
# DEFAULT EXPLOSION BASE FUNCTIONS
#---------------------------------------------------------------
function CreateScalableUnitExplosion( unit, overKillRatio )
    if IsUnit(unit) then 
        local explosionEntity = CreateUnitExplosionEntity( unit, overKillRatio )
        WaitSeconds( Random( 0, 0.5 ) )
        unit:PlayUnitSound('Destroyed') 
        unit:PlayUnitSound('Killed')       
        ForkThread( _CreateScalableUnitExplosion, explosionEntity )
    end
end

function CreateDefaultHitExplosion( obj, scale )
    if obj and not obj:BeenDestroyed() then
        local army = obj:GetArmy()
        CreateFlash( obj, -1, scale * 0.5, army )
        CreateEffects( obj, army, EffectTemplate.FireCloudMed01 )
    end
    obj:PlayUnitSound('DeathExplosion')
end

function CreateDefaultHitExplosionOffset( obj, scale, xOffset, yOffset, zOffset )
    #LOG( xOffset, ' ', yOffset, ' ', zOffset )
    local x,y,z = GetUnitSizes(obj)
    local army = obj:GetArmy()
    #CreateFlash( obj, -1, scale * 0.5, army )
    local randomized
    randomized = Random( 1, 20)
    if randomized > 13 and x * y * z > 2.4 then
    CreateBoneEffectsOffset( obj, -1, army, EffectTemplate.ExplosionEffectsMed02, xOffset, yOffset, zOffset )
    else
    CreateBoneEffectsOffset( obj, -1, army, EffectTemplate.DefaultHitExplosion01, xOffset, yOffset, zOffset )
    end
    obj:PlayUnitSound('DeathExplosion')
end

function CreateDefaultHitExplosionOffset2( obj, scale, xOffset, yOffset, zOffset )
    #LOG( xOffset, ' ', yOffset, ' ', zOffset )
    local x,y,z = GetUnitSizes(obj)
    local army = obj:GetArmy()
    #CreateFlash( obj, -1, scale * 0.5, army )
    local randomized
    randomized = Random( 1, 20)
    if randomized > 13 and x * y * z > 2.4 then
    CreateBoneEffectsOffset( obj, -1, army, EffectTemplate.ExplosionEffectsAir, xOffset, yOffset, zOffset )
    else
    CreateBoneEffectsOffset( obj, -1, army, EffectTemplate.DefaultHitExplosionAir, xOffset, yOffset, zOffset )
    end
    obj:PlayUnitSound('DeathExplosion')
end

function CreateDefaultHitExplosionAtBone( obj, boneName, scale )
    local army = obj:GetArmy()
    CreateFlash( obj, boneName, scale * 0.5, army )
    CreateBoneEffects( obj, boneName, army, EffectTemplate.FireCloudMed01 )
end

function CreateTimedStuctureUnitExplosion( obj )
    local numExplosions = math.floor( GetAverageBoundingXYZRadius(obj) * GetRandomInt(6,12) )
    local x,y,z = GetUnitSizes(obj)
    obj:ShakeCamera( 30, 1, 0, 0.45 * numExplosions )
    #print(LOC, "obj.Spec.Dimensions", obj.Spec.Dimensions)
    if obj.Spec.Dimensions == nil then
        else 
        CreateDebrisProjectiles( obj, obj.Spec.BoundingXYZRadius, obj.Spec.Dimensions )
    end
    for i = 0, numExplosions do
        CreateDefaultHitExplosionOffset( obj, 1.0, unpack({GetRandomOffset(x,y,z,1.2)}))
        WaitSeconds( GetRandomFloat( 0.1, 0.25 ))
    end
    obj:PlayUnitSound('DeathExplosion')
end

-- this is the 3d explosion for mobile units

function CreateTimedStuctureUnitExplosion2( obj )
    local numExplosions = math.floor( GetAverageBoundingXYZRadius(obj) * GetRandomInt(12,28) )
    if numExplosions > 40 then 
    	numExplosions = 40
    end
    #print("numExplosions:", numExplosions)
    local x,y,z = GetUnitSizes(obj)
    if obj.Spec.Dimensions == nil then
        else 
        CreateDebrisProjectiles( obj, obj.Spec.BoundingXYZRadius, obj.Spec.Dimensions )
    end
    if numExplosions > 30 then
    	obj:ShakeCamera( 30 , 1, 0, 0.45 * numExplosions )    
	end
    for i = 0, numExplosions do
        CreateDefaultHitExplosionOffset2( obj, 2.0, unpack({GetRandomOffset(x , y - 0.5 , z , 1.2)}))
        WaitSeconds( GetRandomFloat( 0.05, 0.1 ))
    end
    obj:PlayUnitSound('DeathExplosion')
end

-- this is the 3d explosion for air units

function CreateTimedStuctureUnitExplosion3( obj )
    local numExplosions = math.floor( GetAverageBoundingXYZRadius(obj) * GetRandomInt(14,28) )
    if numExplosions > 50 then 
    	numExplosions = 50
    end
    obj:PlayUnitSound('DeathExplosion')
    local x,y,z = GetUnitSizes(obj)
    for i = 0, numExplosions do
        CreateDefaultHitExplosionOffset2( obj, 2.0, unpack({GetRandomOffset(x , y - 0.5 , z , 1.2)}))
        WaitSeconds( GetRandomFloat( 0.01, 0.02 ))
    end
    #obj:PlayUnitSound('DeathExplosion')
end

---- experiment

---- experiment    

function MakeExplosionEntitySpec(unit, overKillRatio)
    return {
        Army = unit:GetArmy(),
        Dimensions = {GetUnitSizes( unit )},
        BoundingXZRadius = GetAverageBoundingXZRadius(unit),
        BoundingXYZRadius = GetAverageBoundingXYZRadius(unit),
        OverKillRatio = overKillRatio,
        Volume = GetUnitVolume( unit ), 
        Layer = unit:GetCurrentLayer(),
    }    
end

function CreateUnitExplosionEntity( unit, overKillRatio )
    local localentity = Entity(MakeExplosionEntitySpec(unit, overKillRatio))
    Warp( localentity, unit:GetPosition())
    return localentity
end

function _CreateScalableUnitExplosion( obj )
    local army = obj.Spec.Army
    local scale = obj.Spec.BoundingXYZRadius
    local layer = obj.Spec.Layer
    local BaseEffectTable = {}
    local EnvironmentalEffectTable = {}
    local EffectTable = {}
    local ShakeTimeModifier = 0
    local ShakeMaxMul = 1 
    
    # Determine effect table to use, based on unit bounding box scale
    #LOG(scale)
    local randomized = Random( 1, 6)
	#print(LOC, "scale", scale)
    if scale < 0.6 then   									## Small units
    	BaseEffectTable = EffectTemplate.ExplosionEffectsSml01
    end	
    if scale > 0.9 then 									## Large units 
  		if randomized > 3 then
        	BaseEffectTable = EffectTemplate.ExplosionEffectsLrg01
        else
        	BaseEffectTable = EffectTemplate.ExplosionEffectsLrg02
        end
        ShakeTimeModifier = 1.0
        ShakeMaxMul = 0.25
    end
    if scale >= 0.6 and scale <= 0.9 then                  	## Medium units
    	if randomized > 3 then
        	BaseEffectTable = EffectTemplate.ExplosionEffectsMed01
        else
        	BaseEffectTable = EffectTemplate.ExplosionEffectsMed02
        end
    end        	
    
    
    # Get Environmental effects for current layer
    EnvironmentalEffectTable = GetUnitEnvironmentalExplosionEffects( layer, scale )

    # Merge resulting tables to final explosion emitter list
    if table.getn( EnvironmentalEffectTable ) != 0 then
        EffectTable = EffectTemplate.TableCat( BaseEffectTable, EnvironmentalEffectTable )
    else
        EffectTable = BaseEffectTable
    end
    
    #LOG( 'ExplosionEntity ', repr(obj), '\nEffect Table ', repr(EffectTable), '\nPosition ', repr(obj:GetPosition()) )

    #---------------------------------------------------------------
    # Create Generic emitter effects
    CreateScaledEffects( obj, army, EffectTable, scale*scale )
    #:ScaleEmitter(0.9)
    # Create scorch mark
    #print(LOC, "scale", scale)
    if layer == 'Land' then
        if scale > 0.4 and scale < 6 then
            CreateScorchMarkDecal( obj, scale * 1.2, army )
        elseif scale > 6 then
        	CreateScorchMarkDecal( obj, scale * 0.9, army )
        else	
            CreateScorchMarkSplat( obj, scale * 1.5, army )
        end
    end
    # Create Light particle flash
    CreateFlash( obj, -1, scale, army )


    # Create GenericDebris chunks
    #obj:PlayUnitSound('Destroyed')
    CreateDebrisProjectiles( obj, obj.Spec.BoundingXYZRadius, obj.Spec.Dimensions )
    # Camera Shake  (.radius .maxshake .minshake .lifetime)
    obj:ShakeCamera( 30 * scale, scale * ShakeMaxMul, 0, 0.5 + ShakeTimeModifier )
    #---------------------------------------------------------------
    #WaitSeconds( 2.0 )
    #_CreateScalableUnitExplosion( obj )
    obj:Destroy()
end

function GetUnitEnvironmentalExplosionEffects( layer, scale )
    local EffectTable = {}
    if layer == 'Water' then
        if scale < 0.5 then
            EffectTable = EffectTemplate.WaterSplash01
        elseif scale > 1.5 then
            EffectTable = EffectTemplate.DefaultProjectileWaterImpact      
        else 
            EffectTable = EffectTemplate.DefaultProjectileWaterImpact      
        end
    end 
    return EffectTable
end

#---------------------------------------------------------------
# CREATELIGHTPARTICLE FLASH
#---------------------------------------------------------------
function CreateFlash( obj, bone, scale, army )
    CreateLightParticle( obj, bone, army, GetRandomFloat(5,10) * scale, GetRandomFloat(5, 14), 'glow_03', 'ramp_flare_02' )
end

#---------------------------------------------------------------
# SCORCH MARK SPLATS
#---------------------------------------------------------------
function CreateScorchMarkSplat( obj, scale, army )
    CreateSplat(obj:GetPosition(),GetRandomFloat(0,2*math.pi),ScorchSplatTextures[GetRandomInt(1,table.getn(ScorchSplatTextures))], scale * 4, scale * 4, GetRandomFloat(200,350), GetRandomFloat(300,600), army )
end

function CreateScorchMarkDecal( obj, scale, army )
    CreateDecal(obj:GetPosition(),GetRandomFloat(0,2*math.pi),ScorchDecalTextures[GetRandomInt(1,table.getn(ScorchDecalTextures))], '', 'Albedo', scale * 3, scale * 3, GetRandomFloat(200,350), GetRandomFloat(300,600), army)
end

function CreateRandomScorchSplatAtObject( obj, scale, LOD, lifetime, army )
    CreateSplat(obj:GetPosition(),GetRandomFloat(0,2*math.pi),ScorchSplatTextures[GetRandomInt(1,table.getn(ScorchSplatTextures))], scale, scale, LOD, lifetime, army )
end

ScorchSplatTextures = {
    'scorch_001_albedo',
    'scorch_002_albedo',
    'scorch_003_albedo',
    'scorch_004_albedo',
    'scorch_005_albedo',
    'scorch_006_albedo',
    'scorch_007_albedo',
    'scorch_008_albedo',
    'scorch_009_albedo',
    'scorch_010_albedo',}

ScorchDecalTextures = {
    'scorch_001_albedo',
    'scorch_002_albedo',
    'scorch_003_albedo',
    'scorch_004_albedo',
    'scorch_005_albedo',
    'scorch_006_albedo',
    'scorch_007_albedo',
    'scorch_008_albedo',
    'scorch_009_albedo',
    'scorch_010_albedo',}

#---------------------------------------------------------------
# WRECKAGE EFFECTS
#---------------------------------------------------------------
function CreateWreckageEffects( obj, prop )
    if IsUnit(obj) then
        local army = obj:GetArmy()
        local scale = GetAverageBoundingXYZRadius( obj )
        local emitters = {}
        local layer = obj:GetCurrentLayer()

        if scale < 0.5 then # SMALL UNITS
            emitters = CreateRandomEffects( prop, army, EffectTemplate.DefaultWreckageEffectsSml01, 1 )
        elseif scale > 1.5 then # LARGE UNITS 
            local x,y,z = GetUnitSizes(obj)
            emitters = CreateEffectsWithRandomOffset( prop, army, EffectTemplate.DefaultWreckageEffectsLrg01, x, 0, z )
        else # MEDIUM UNITS
            emitters = CreateRandomEffects( prop, army, EffectTemplate.DefaultWreckageEffectsMed01, 2 )
        end

        # Give the emitters created some random lifetimes
        ScaleEmittersParam( emitters, 'LIFETIME', 100, 1000 )

        for k, v in emitters do
            v:ScaleEmitter(GetRandomFloat(0.25,1))
        end
    end
end

#---------------------------------------------------------------
# DEBRIS PROJECTILES EFFECTS
#---------------------------------------------------------------
function CreateDebrisProjectiles( obj, volume, dimensions )
    local partamounts = GetRandomInt( ((volume * 3)- 1), ((volume * 10) - 1) )
    local sx, sy, sz = unpack(dimensions)
    local rando = Random(1,10)
	local size = volume
	if volume < 7 then
		if rando > 3 then
    		for j = 1, partamounts do
        		local xpos, xpos, zpos = GetRandomOffset( sx, sy, sz, 1 )
        		local xdir,ydir,zdir = GetRandomOffset( sx, sy, sz, 10 )
        		local rand = Random(1,8)
        		if size > 0.8 then
        			size = 0.8
        		end 
        		proj = obj:CreateProjectile('/mods/4th_Dimension_Explosions_21/hook/effects/entities/DebrisMisc0' .. rand .. '/DebrisMisc0' .. rand .. '_proj.bp',xpos,xpos,zpos,xdir,ydir + 2.5,zdir)
    			proj:SetScale((size * 0.5),(size * 0.5),(size * 0.5))
   			end
   		end
   	rando = Random(1,10)
   	if volume < 3 then
	   	if rando > 3 then
	   		local number = ((Random (2, 4) * partamounts) + (Random (3, 9)))
	   		for j = 1, number do
	   			local randomscle = GetRandomFloat (2,5)
	   			local xpos, xpos, zpos = GetRandomOffset( sx, sy, sz, 1 )
	        	local xdir,ydir,zdir = GetRandomOffset( sx, sy, sz, 10 )
	   			proj = obj:CreateProjectile('/mods/4th_Dimension_Explosions_21/hook/projectiles/FireSparks/FireSparks_proj.bp',xpos,xpos,zpos,xdir,ydir + 2.5,zdir)
				proj:SetScale((size * randomscle),(size * randomscle),(size * randomscle))
			end
		end
		rando = Random(1,10)
		if rando > 3 then
	   		local number = ((Random (1, 2) * partamounts) + (Random (0, 3)))
	   		for j = 1, number do
	   			local randomscle = GetRandomFloat (0.5,1)
	   			local xpos, xpos, zpos = GetRandomOffset( sx, sy, sz, 1 )
	        	local xdir,ydir,zdir = GetRandomOffset( sx, sy, sz, 10 )
	   			proj = obj:CreateProjectile('/mods/4th_Dimension_Explosions_21/hook/projectiles/ShellRiotTerran01/ShellRiotTerran01_proj.bp',xpos,xpos,zpos,xdir,ydir + 2.5,zdir)
				proj:SetScale((size * randomscle),(size * randomscle),(size * randomscle))
			end
		end
	end
	end
end

#---------------------------------------------------------------
# OLD EXPLOSION TECH
#---------------------------------------------------------------
function CreateDefaultExplosion( unit, scale, overKillRatio )

    local spec = {
        Position = unit:GetPosition(),
        Dimensions = GetUnitSizes( unit ),
        Volume = GetUnitVolume( unit ),
    }
    local Explosion = unit #Entity(spec)
    local army = unit:GetArmy()

    CreateConcussionRing( Explosion, scale )
    #CreateDestructionFire( Explosion, scale )
    #CreateFlash( Explosion, scale, army )
    #CreateFirePlume( Explosion, scale )
    #CreateGenericDebris( Explosion )
    #CreateScorchMark( Explosion, GetRandomFloat( scale * 0.9, scale * 1.2), army )
    #CreateFireShadow( Explosion, scale )
    #unit:ShakeCamera(50, 2, 0, 0.5)
    #CreateSmoke( Explosion, scale )
    #CreateDestructionSparks( Explosion, scale )

    #ForkThread( CreateCompositeExplosionMeshes, Explosion )

end

function CreateDestructionFire( object, scale )
    local proj = object:CreateProjectile('/effects/entities/DestructionFire01/DestructionFire01_proj.bp', 0, 0, 0, nil, nil, nil)
    proj:SetBallisticAcceleration(GetRandomFloat(-2, -3)):SetCollision(false)
    CreateEmitterOnEntity(proj,proj:GetArmy(),'/effects/emitters/destruction_explosion_fire_01_emit.bp'):ScaleEmitter(scale)
end

function CreateDestructionSparks( object, scale )
    local proj
    for i = 1, GetRandomInt(10, 50) do
        proj = object:CreateProjectile('/effects/entities/DestructionSpark01/DestructionSpark01_proj.bp', 0, 0, 0, nil, nil, nil)
        proj:SetBallisticAcceleration(GetRandomFloat(-2, -3)):SetCollision(false)
        CreateEmitterOnEntity(proj,proj:GetArmy(),'/effects/emitters/destruction_explosion_sparks_02_emit.bp'):ScaleEmitter(scale)
    end
end

function CreateFirePlume( object, scale )
    local proj
    for i = 1, GetRandomInt(4, 8) do
        proj = object:CreateProjectile('/effects/entities/DestructionFirePlume01/DestructionFirePlume01_proj.bp', 0, 0, 0, nil, nil, nil)
        proj:SetBallisticAcceleration(GetRandomFloat(-2, -3)):SetCollision(false)
        local emitter = CreateEmitterOnEntity(proj,proj:GetArmy(),'/effects/emitters/destruction_explosion_fire_plume_02_emit.bp')
        #emitter:ScaleEmitter(scale)

        local lifetime = GetRandomFloat( 24, 48 )
        emitter:SetEmitterParam('REPEATTIME',lifetime)
        emitter:SetEmitterParam('LIFETIME', lifetime)
    end
end


function CreateExplosionProjectile( object, projectile, minnumber, maxnumber, effect, fxscalemin, fxscalemax, gravitymin, gravitymax, xpos, ypos, zpos, emitterparam)
    local fxscale = (Random() * (fxscalemax - fxscalemin) + fxscalemin)
    local yaccel = (Random() * (gravitymax - gravitymin) + gravitymin) * fxscale
    local number = (Random() * (maxnumber - minnumber) + minnumber)
    local proj, emitter
    ypos = ypos / 2
    for j = 1, number do
        proj = object:CreateProjectile(projectile, xpos, ypos, zpos, nil, nil, nil):SetBallisticAcceleration(yaccel):SetCollision(false)
        emitter = CreateEmitterOnEntity(proj,proj:GetArmy(),effect):ScaleEmitter(fxscale)
        if emitterparam then
            emitter:SetEmitterParam('REPEATTIME',math.floor(12 * fxscale + 0.5))
            emitter:SetEmitterParam('LIFETIME',math.floor(12 * fxscale + 0.5))
        end
    end
end

function CreateUnitDebrisEffects( object, bone )
    local Effects = {'/effects/emitters/destruction_explosion_smoke_09_emit.bp'}

    for k, v in Effects do
        CreateAttachedEmitter(object,bone,object:GetArmy(),v)
    end
end



# Composite effects
# *********************
function CreateExplosionMesh( object, projBP, posX, posY, posZ, scale, scaleVelocity, Lifetime, velX, velY, VelZ, orientRot, orientX, orientY, orientZ  )

    proj = object:CreateProjectile(projBP, posX, posY, posZ, nil, nil, nil)
    proj:SetScale(scale,scale,scale):SetScaleVelocity( scaleVelocity ):SetLifetime( Lifetime ):SetVelocity( velX, velY, VelZ )

    local orient = {0,0,0,0}
    orient[1], orient[2], orient[3], orient[4] = QuatFromRotation( orientRot, orientX, orientY, orientZ )
    #LOG('Quat(xyzw)', repr(orient))
    proj:SetOrientation( orient, true)

    CreateEmitterAtEntity(proj,proj:GetArmy(),'/effects/emitters/destruction_explosion_smoke_10_emit.bp')
    return proj
end

function CreateCompositeExplosionMeshes( object )
    local lifetime = 6.0
    local explosionMeshProjectiles = {}
    local scalingmin = 0.065
    local scalingmax = 0.135

    table.insert( explosionMeshProjectiles, CreateExplosionMesh( object, '/effects/Explosion/Explosion01_a_proj.bp', 0.4, 0.4, 0.4, GetRandomFloat( 0.1, 0.2 ), GetRandomFloat( scalingmin, scalingmax ), lifetime, 0.1, 0.1, 0.1, -45, 1,0,0 ))
    table.insert( explosionMeshProjectiles, CreateExplosionMesh( object, '/effects/Explosion/Explosion01_b_proj.bp', -0.4, 0.4, 0.4, GetRandomFloat( 0.1, 0.2 ), GetRandomFloat( scalingmin, scalingmax ), lifetime, -0.1, 0.1, 0.1, -80, 1, 0, -1  ))
    table.insert( explosionMeshProjectiles, CreateExplosionMesh( object, '/effects/Explosion/Explosion01_c_proj.bp', -0.2, 0.4, -0.4, GetRandomFloat( 0.1, 0.2 ), GetRandomFloat( scalingmin, scalingmax ), lifetime, -0.04, 0.1, -0.1, -90, -1,0,0 ))
    table.insert( explosionMeshProjectiles, CreateExplosionMesh( object, '/effects/Explosion/Explosion01_d_proj.bp', 0.0, 0.7, 0.4, GetRandomFloat( 0.1, 0.14 ), GetRandomFloat( scalingmin, scalingmax ), lifetime, 0, 0.1, 0, 90, 1,0,0 ))

    # Slow down scaling of secondary meshes
    WaitSeconds( 0.3 )

    for k, v in explosionMeshProjectiles do
        #v:SetScaleVelocity( GetRandomFloat( 0.03, 0.06 ) )
    end
end


#---------------------------------------------------------------
#  Replaced by new effect structure (see EffectTemplates.lua)
#---------------------------------------------------------------
function CreateSmoke( object, scale )
    local SmokeEffects = {'/effects/emitters/destruction_explosion_smoke_03_emit.bp',
                          '/effects/emitters/destruction_explosion_smoke_07_emit.bp'}

    for k, v in SmokeEffects do
        CreateEmitterAtEntity(object,object:GetArmy(),v):ScaleEmitter(scale)
    end
end

function CreateConcussionRing( object, scale )
    CreateEmitterAtEntity(object,object:GetArmy(),'/effects/emitters/destruction_explosion_concussion_ring_01_emit.bp'):ScaleEmitter(scale)
end

function CreateFireShadow( object, scale )
    CreateEmitterAtEntity(object,object:GetArmy(),'/effects/emitters/destruction_explosion_fire_shadow_01_emit.bp'):ScaleEmitter(scale)
end


function OldCreateWreckageEffects( object )
    local Effects = {'/effects/emitters/destruction_explosion_smoke_08_emit.bp'}

    for k, v in Effects do
        CreateEmitterAtEntity(object,object:GetArmy(),v):SetEmitterParam('LIFETIME', GetRandomFloat( 100, 1000 ))
    end
end