#****************************************************************************
#
#    File     :  /data/Projectiles/ADFReactonCannnon01/ADFReactonCannnon01_script.lua
#    Author(s): Jessica St.Croix, Gordon Duclos
#
#    Summary  : Aeon Reacton Cannon Area of Effect Projectile
#
#    Copyright � 2006 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local ArtemisCannonProjectile = import('/mods/BlackOpsUnleashed/lua/BlackOpsprojectiles.lua').ArtemisCannonProjectile

ADFReactonCannon01 = Class(ArtemisCannonProjectile) {

    OnImpact = function(self, TargetType, TargetEntity)
        if not TargetEntity or not EntityCategoryContains(categories.PROJECTILE, TargetEntity) then
            # Play the explosion sound
            local myBlueprint = self:GetBlueprint()
            if myBlueprint.Audio.Explosion then
                self:PlaySound(myBlueprint.Audio.Explosion)
            end
           
			nukeProjectile = self:CreateProjectile('/mods/BlackOpsUnleashed/effects/entities/ArtemisBombEffectController01/ArtemisBombEffectController01_proj.bp', 0, 0, 0, 0, 0, 0):SetCollision(false)
            local pos = self:GetPosition()
			pos[2] = pos[2] + 10
            Warp( nukeProjectile, pos)
			nukeProjectile:PassData(self.Data)
        end
        ArtemisCannonProjectile.OnImpact(self, TargetType, TargetEntity)
    end,

    DoTakeDamage = function(self, instigator, amount, vector, damageType)
        if self.ProjectileDamaged then
            # Play the explosion sound
            local myBlueprint = self:GetBlueprint()
            if myBlueprint.Audio.Explosion then
                self:PlaySound(myBlueprint.Audio.Explosion)
            end
           
			nukeProjectile = self:CreateProjectile('/mods/BlackOpsUnleashed/projectiles/ArtemisWarhead02/ArtemisWarhead02_proj.bp', 0, 0, 0, nil, nil, nil):SetCollision(false)
            nukeProjectile:PassData(self.Data)
            #local launcherbp = self:GetLauncher():GetBlueprint()  
            #local wep = self:GetLauncher()
            #self.wep.DoTakeDamage = launcherbp.NukeInnerRingDamage
        end
        ArtemisCannonProjectile.DoTakeDamage(self, instigator, amount, vector, damageType)
    end,

    OnCreate = function(self)
        ArtemisCannonProjectile.OnCreate(self)
        local launcher = self:GetLauncher()
        if launcher and not launcher:IsDead() and launcher.EventCallbacks.ProjectileDamaged then
            self.ProjectileDamaged = {}
            for k,v in launcher.EventCallbacks.ProjectileDamaged do
                table.insert( self.ProjectileDamaged, v )
            end
        end
        --self:SetCollisionShape('Sphere', 0, 0, 0, 2.0)
    end,
}
TypeClass = ADFReactonCannon01