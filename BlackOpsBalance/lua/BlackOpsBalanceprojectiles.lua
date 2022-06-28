#****************************************************************************
#**
#**  File     : /cdimage/lua/modules/BlackOpsBalanceprojectiles.lua
#**  Author(s): Lt_Hawkeye
#**
#**  Summary  :
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
#------------------------------------------------------------------------
#  Lt_hawkeye's Custom Projectiles
#------------------------------------------------------------------------
local Projectile = import('/lua/sim/projectile.lua').Projectile
local DefaultProjectileFile = import('/lua/sim/defaultprojectiles.lua')
local EmitterProjectile = DefaultProjectileFile.EmitterProjectile
local OnWaterEntryEmitterProjectile = DefaultProjectileFile.OnWaterEntryEmitterProjectile
local SingleBeamProjectile = DefaultProjectileFile.SingleBeamProjectile
local SinglePolyTrailProjectile = DefaultProjectileFile.SinglePolyTrailProjectile
local MultiPolyTrailProjectile = DefaultProjectileFile.MultiPolyTrailProjectile
local SingleCompositeEmitterProjectile = DefaultProjectileFile.SingleCompositeEmitterProjectile
local MultiCompositeEmitterProjectile = DefaultProjectileFile.MultiCompositeEmitterProjectile
local Explosion = import('/lua/defaultexplosions.lua')
local NullShell = DefaultProjectileFile.NullShell

local EffectTemplate = import('/lua/EffectTemplates.lua')
local BlackOpsBalanceEffectTemplate = import('/mods/BlackOpsBalance/lua/BlackOpsBalanceEffectTemplates.lua')
local DepthCharge = import('/lua/defaultantiprojectile.lua').DepthCharge
local util = import('/lua/utilities.lua')

#---------------------------------------------------------------
# Null Shell
#---------------------------------------------------------------
EXNullShell = Class(Projectile) {}

#---------------------------------------------------------------
# PROJECTILE WITH ATTACHED EFFECT EMITTERS
#---------------------------------------------------------------
EXEmitterProjectile = Class(Projectile) {
    FxTrails = {'/effects/emitters/missile_munition_trail_01_emit.bp',},
    FxTrailScale = 1,
    FxTrailOffset = 0,

    OnCreate = function(self)
        Projectile.OnCreate(self)
        local army = self:GetArmy()
        for i in self.FxTrails do
            CreateEmitterOnEntity(self, army, self.FxTrails[i]):ScaleEmitter(self.FxTrailScale):OffsetEmitter(0, 0, self.FxTrailOffset)
        end
    end,
}

#---------------------------------------------------------------
# BEAM PROJECTILES
#---------------------------------------------------------------
EXSingleBeamProjectile = Class(EXEmitterProjectile) {

    BeamName = '/effects/emitters/default_beam_01_emit.bp',
    FxTrails = {},

    OnCreate = function(self)
        EmitterProjectile.OnCreate(self)
        if self.BeamName then
            CreateBeamEmitterOnEntity( self, -1, self:GetArmy(), self.BeamName )
        end
    end,
}

EXMultiBeamProjectile = Class(EXEmitterProjectile) {

    Beams = {'/effects/emitters/default_beam_01_emit.bp',},
    FxTrails = {},

    OnCreate = function(self)
        EmitterProjectile.OnCreate(self)
        local beam = nil
        local army = self:GetArmy()
        for k, v in self.Beams do
            CreateBeamEmitterOnEntity( self, -1, army, v )
        end
    end,
}

#---------------------------------------------------------------
# POLY-TRAIL PROJECTILES
#---------------------------------------------------------------
EXSinglePolyTrailProjectile = Class(EXEmitterProjectile) {

    PolyTrail = '/effects/emitters/test_missile_trail_emit.bp',
    PolyTrailOffset = 0,
    FxTrails = {},

    OnCreate = function(self)
        EmitterProjectile.OnCreate(self)
        if self.PolyTrail != '' then
            CreateTrail(self, -1, self:GetArmy(), self.PolyTrail):OffsetEmitter(0, 0, self.PolyTrailOffset)
        end
    end,
}

EXMultiPolyTrailProjectile = Class(EXEmitterProjectile) {

    PolyTrailOffset = {0},
    FxTrails = {},
    RandomPolyTrails = 0,   # Count of how many are selected randomly for PolyTrail table

    OnCreate = function(self)
        EmitterProjectile.OnCreate(self)
        if self.PolyTrails then
            local NumPolyTrails = table.getn( self.PolyTrails )
            local army = self:GetArmy()

            if self.RandomPolyTrails != 0 then
                local index = nil
                for i = 1, self.RandomPolyTrails do
                    index = math.floor( Random( 1, NumPolyTrails))
                    CreateTrail(self, -1, army, self.PolyTrails[index] ):OffsetEmitter(0, 0, self.PolyTrailOffset[index])
                end
            else
                for i = 1, NumPolyTrails do
                    CreateTrail(self, -1, army, self.PolyTrails[i] ):OffsetEmitter(0, 0, self.PolyTrailOffset[i])
                end
            end
        end
    end,
}


#---------------------------------------------------------------
# COMPOSITE EMITTER PROJECTILES - MULTIPURPOSE PROJECTILES
# - THAT COMBINES BEAMS, POLYTRAILS, AND NORMAL EMITTERS
#---------------------------------------------------------------

# LIGHTWEIGHT VERSION THAT LIMITS USE TO 1 BEAM, 1 POLYTRAIL, AND STANDARD EMITTERS
EXSingleCompositeEmitterProjectile = Class(EXSinglePolyTrailProjectile) {

    BeamName = '/effects/emitters/default_beam_01_emit.bp',
    FxTrails = {},

    OnCreate = function(self)
        SinglePolyTrailProjectile.OnCreate(self)
        if self.BeamName != '' then
            CreateBeamEmitterOnEntity( self, -1, self:GetArmy(), self.BeamName )
        end
    end,
}

# HEAVYWEIGHT VERSION, ALLOWS FOR MULTIPLE BEAMS, POLYTRAILS, AND STANDARD EMITTERS
EXMultiCompositeEmitterProjectile = Class(EXMultiPolyTrailProjectile) {

    Beams = {'/effects/emitters/default_beam_01_emit.bp',},
    PolyTrailOffset = {0},
    RandomPolyTrails = 0,   # Count of how many are selected randomly for PolyTrail table
    FxTrails = {},

    OnCreate = function(self)
        MultiPolyTrailProjectile.OnCreate(self)
        local beam = nil
        local army = self:GetArmy()
        for k, v in self.Beams do
            CreateBeamEmitterOnEntity( self, -1, army, v )
        end
    end,
}

#------------------------------------------------------------------------
#  MGAI PROJECTILES
#------------------------------------------------------------------------
CybranPlasmaBallChildProjectile = Class(EmitterProjectile) {
    #PolyTrail = BlackOpsBalanceEffectTemplate.CybranPlasmaBallPolytrail01,
    FxTrails = BlackOpsBalanceEffectTemplate.CybranPlasmaBallChildFxtrail01,
	FxTrailScale = 2,
    # Hit Effects
    FxImpactUnit = BlackOpsBalanceEffectTemplate.CybranPlasmaBallHitLand01,
	FxUnitHitScale = 2,
    FxImpactProp = BlackOpsBalanceEffectTemplate.CybranPlasmaBallHitLand01,
	FxPropHitScale = 2,
    FxImpactLand = BlackOpsBalanceEffectTemplate.CybranPlasmaBallHitLand01,
	FxLandHitScale = 2,
    --FxImpactUnderWater = BlackOpsBalanceEffectTemplate.CybranPlasmaBallHitLand01,
	--FxUnderWaterHitScale = 2,
    FxImpactWater = BlackOpsBalanceEffectTemplate.CybranPlasmaBallHitLand01,
	FxWaterHitScale = 2,
    OnCreate = function(self, TargetType, TargetEntity)
    local projectile = self
		
		SetDamageThread = ForkThread(function(self)
			projectile.DamageData = {
	            DamageRadius = 4,
	            DamageAmount = 100,
	            DoTPulses = 30,
            	DoTTime = 9,
	            DamageType = 'Normal',
	            DamageFriendly = true,
	            MetaImpactAmount = nil,
	            MetaImpactRadius = nil,
	        }
			KillThread(self)
		end)
		EmitterProjectile.OnCreate(self, TargetType, TargetEntity)
	end,

}

CybranPlasmaBallProjectile = Class(EmitterProjectile) {
    #PolyTrail = BlackOpsBalanceEffectTemplate.CybranPlasmaBallPolytrail01,
    FxTrails = BlackOpsBalanceEffectTemplate.CybranPlasmaBallFxtrail01,
	FxTrailScale = 2,

    # Hit Effects
    FxImpactUnit = {},
    FxImpactLand = {},
    FxImpactUnderWater = {},

    ChildProjectile = '/mods/BlackOpsBalance/projectiles/CybranPlasmaBallChild01/CybranPlasmaBallChild01_proj.bp',

    OnCreate = function(self)
        EmitterProjectile.OnCreate(self)
        self.Impacted = false
    end,
    DoDamage = function(self, instigator, damageData, targetEntity)
        EmitterProjectile.DoDamage(self, instigator, damageData, targetEntity)
    end,
    OnImpact = function(self, TargetType, TargetEntity)
        if self.Impacted == false and TargetType != 'Air' then
            self.Impacted = true
            self:CreateChildProjectile(self.ChildProjectile):SetVelocity(0,Random(1,5),Random(1.5,5))
            self:CreateChildProjectile(self.ChildProjectile):SetVelocity(Random(1,4),Random(1,5),Random(1,2))
            self:CreateChildProjectile(self.ChildProjectile):SetVelocity(0,Random(1,5),-Random(1.5,5))
            self:CreateChildProjectile(self.ChildProjectile):SetVelocity(Random(1.5,5),Random(1,5),0)
            self:CreateChildProjectile(self.ChildProjectile):SetVelocity(-Random(1,4),Random(1,5),-Random(1,2))
            self:CreateChildProjectile(self.ChildProjectile):SetVelocity(-Random(1.5,4.5),Random(1,5),0)
            self:CreateChildProjectile(self.ChildProjectile):SetVelocity(-Random(1,4),Random(1,5),Random(2,4))
            self:CreateChildProjectile(self.ChildProjectile):SetVelocity(-Random(1,2),Random(1,7),-Random(1,3))
            self:CreateChildProjectile(self.ChildProjectile):SetVelocity(-Random(2.5,3.5),Random(2,6),0)
            self:CreateChildProjectile(self.ChildProjectile):SetVelocity(-Random(2,3),Random(2,3),Random(3,5))
            EmitterProjectile.OnImpact(self, TargetType, TargetEntity)
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
