#****************************************************************************
#**
#**  File     :  /lua/terranweapons.lua
#**  Author(s):  John Comes, David Tomandl, Gordon Duclos
#**
#**  Summary  :  Terran-specific weapon definitions
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local WeaponFile = import('/lua/sim/DefaultWeapons.lua')
local CollisionBeams = import('defaultcollisionbeams.lua')
local BareBonesWeapon = WeaponFile.BareBonesWeapon
local DefaultProjectileWeapon = WeaponFile.DefaultProjectileWeapon
local DefaultBeamWeapon = WeaponFile.DefaultBeamWeapon
local GinsuCollisionBeam = CollisionBeams.GinsuCollisionBeam
local EffectTemplate = import('/lua/EffectTemplates.lua')

TDFLightPlasmaCannonWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TPlasmaCannonLightMuzzleFlash,
}

TDFHeavyPlasmaCannonWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TPlasmaCannonHeavyMuzzleFlash,
}


TDFOverchargeWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TCommanderOverchargeFlash01,
}

TDFMachineGunWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = {
        '/effects/emitters/machinegun_muzzle_fire_02_emit.bp',},
    FxMuzzleFlashScale = 1.3,
}

TDFGaussCannonWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TGaussCannonFlash,
    FxMuzzleFlashScale = 1.6,
}

TDFZephyrCannonWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = {
        '/effects/emitters/terran_commander_cannon_flash_01_emit.bp',
        '/effects/emitters/terran_commander_cannon_flash_02_emit.bp', },
        #'/effects/emitters/cannon_muzzle_smoke_01_emit.bp',
        #'/effects/emitters/cannon_muzzle_water_shock_01_emit.bp',},
}

TDFRiotWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFx,
    FxMuzzleFlashScale = 0.6,
}

TAAGinsuRapidPulseWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = {},
}

TAAFlakArtilleryCannon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TFlakCannonMuzzleFlash01,
    # Custom over-ride for this weapon, so it passes data and damageTable
    CreateProjectileForWeapon = function(self, bone)
        local proj = self:CreateProjectile(bone)
        local damageTable = self:GetDamageTable()
        local blueprint = self:GetBlueprint()
        local data = {
            Instigator = self.unit,
            Damage = blueprint.DoTDamage,
            Duration = blueprint.DoTDuration,
            Frequency = blueprint.DoTFrequency,
            Radius = blueprint.DamageRadius,
            Type = 'Normal',
            DamageFriendly = blueprint.DamageFriendly,
        }

        if proj and not proj:BeenDestroyed() then
            proj:PassDamageData(damageTable)
            proj:PassData(data)
        end

        return proj
    end
}

TAALinkedRailgun = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TRailGunMuzzleFlash01,
}


TAirToAirLinkedRailgun = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TRailGunMuzzleFlash02,
}

TIFCruiseMissileUnpackingLauncher = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = {},
}
TIFCruiseMissileLauncher = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TIFCruiseMissileLaunchSmoke,
}

TIFCruiseMissileLauncherSub = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TIFCruiseMissileLaunchUnderWater,
}

TSAMLauncher = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TAAMissileLaunch,
}

TANTorpedoLandWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = {
		'/effects/emitters/default_muzzle_flash_01_emit.bp',
        '/effects/emitters/default_muzzle_flash_02_emit.bp',
        '/effects/emitters/torpedo_underwater_launch_01_emit.bp',
    },
}

TANTorpedoAngler = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = {
		'/effects/emitters/default_muzzle_flash_01_emit.bp',
        '/effects/emitters/default_muzzle_flash_02_emit.bp',
        '/effects/emitters/torpedo_underwater_launch_01_emit.bp',
    },
}


TIFSmartCharge = Class(DefaultProjectileWeapon) {
    
    CreateProjectileAtMuzzle = function(self, muzzle)
        local proj = DefaultProjectileWeapon.CreateProjectileAtMuzzle(self, muzzle)
        local tbl = self:GetBlueprint().DepthCharge
        proj:AddDepthCharge(tbl)
    end,
}


TIFCommanderDeathWeapon = Class(BareBonesWeapon) {
    FiringMuzzleBones = {0}, # just fire from the base bone of the unit

    OnCreate = function(self)
        BareBonesWeapon.OnCreate(self)
        local myBlueprint = self:GetBlueprint()
        # The "or x" is supplying default values in case the blueprint doesn't have an overriding value
        self.Data = {
            NukeOuterRingDamage = myBlueprint.NukeOuterRingDamage or 10,
            NukeOuterRingRadius = myBlueprint.NukeOuterRingRadius or 40,
            NukeOuterRingTicks = myBlueprint.NukeOuterRingTicks or 20,
            NukeOuterRingTotalTime = myBlueprint.NukeOuterRingTotalTime or 10,

            NukeInnerRingDamage = myBlueprint.NukeInnerRingDamage or 2000,
            NukeInnerRingRadius = myBlueprint.NukeInnerRingRadius or 30,
            NukeInnerRingTicks = myBlueprint.NukeInnerRingTicks or 24,
            NukeInnerRingTotalTime = myBlueprint.NukeInnerRingTotalTime or 24,
        }
        self:SetWeaponEnabled(false)
    end,
    
    OnFire = function(self)
        
    end,
    
    Fire = function(self)
        local myBlueprint = self:GetBlueprint()
        local myProjectile = self.unit:CreateProjectile( myBlueprint.ProjectileId, 0, 0, 0, nil, nil, nil):SetCollision(false)
        myProjectile:PassDamageData(self:GetDamageTable())
        if self.Data then
            myProjectile:PassData(self.Data)
        end
    end,
    
}


TIFStrategicMissileWeapon = Class(DefaultProjectileWeapon) {}

TIFArtilleryWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TIFArtilleryMuzzleFlash
}

TIFCarpetBombWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = {'/effects/emitters/antiair_muzzle_fire_02_emit.bp',},

    CreateProjectileForWeapon = function(self, bone)
        local projectile = self:CreateProjectile(bone)
        local damageTable = self:GetDamageTable()
        local blueprint = self:GetBlueprint()
        local data = {
            Instigator = self.unit,
            Damage = blueprint.DoTDamage,
            Duration = blueprint.DoTDuration,
            Frequency = blueprint.DoTFrequency,
            Radius = blueprint.DamageRadius,
            Type = 'Normal',
            DamageFriendly = blueprint.DamageFriendly,
        }
        if projectile and not projectile:BeenDestroyed() then
            projectile:PassData(data)
            projectile:PassDamageData(damageTable)
        end
        return projectile
    end,
}

TIFSmallYieldNuclearBombWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = {'/effects/emitters/antiair_muzzle_fire_02_emit.bp',},
}

TIFHighBallisticMortarWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TMobileMortarMuzzleEffect01,
}

TAMInterceptorWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = {'/effects/emitters/terran_antinuke_launch_01_emit.bp',},
}

TAMPhalanxWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TPhalanxGunMuzzleFlash,
    FxShellEject  = EffectTemplate.TPhalanxGunShells,
    
    PlayFxMuzzleSequence = function(self, muzzle)
		DefaultProjectileWeapon.PlayFxMuzzleSequence(self, muzzle)
		for k, v in self.FxShellEject do
            CreateAttachedEmitter(self.unit, self:GetBlueprint().TurretBonePitch, self.unit:GetArmy(), v)
        end
    end,
}
TAMPhalanxWeapon2 = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TPhalanxGunMuzzleFlash,
    
}

TDFIonizedPlasmaCannon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TIonizedPlasmaGatlingCannonMuzzleFlash, 
}

