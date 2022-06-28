local DefaultExplosion = import('/lua/defaultexplosions.lua')
do
local OldProjectile = Projectile
Projectile = Class(OldProjectile) {

    DoDamage = function(self, instigator, damageData, targetEntity)
        local damage = damageData.DamageAmount
        if damage and damage > 0 then
            local radius = damageData.DamageRadius
            if radius and radius > 0 then
                if not damageData.DoTTime or damageData.DoTTime <= 0 then
                    DamageArea(instigator, self:GetPosition(), radius * 0.5, damage * 0.4, damageData.DamageType, damageData.DamageFriendly, damageData.DamageSelf or false)
                    DamageArea(instigator, self:GetPosition(), radius * 0.75, damage * 0.3, damageData.DamageType, damageData.DamageFriendly, damageData.DamageSelf or false)
		            DamageArea(instigator, self:GetPosition(), radius, damage * 0.3, damageData.DamageType, damageData.DamageFriendly, damageData.DamageSelf or false)
                 	if radius > 1.4 then
        				DamageArea(instigator, self:GetPosition(), radius* 0.7, 1, 'Force', true)
        				DamageArea(instigator, self:GetPosition(), radius * 0.7, 1, 'Force', false)
		            end
		            else
                    ForkThread(DefaultDamage.AreaDoTThread, instigator, self:GetPosition(), damageData.DoTPulses or 1, (damageData.DoTTime / (damageData.DoTPulses or 1)), radius, damage, damageData.DamageType, damageData.DamageFriendly)
                end
            #ONLY DO DAMAGE IF THERE IS DAMAGE DATA.  SOME PROJECTILES DO NOT DO DAMAGE WHEN THEY IMPACT.
            elseif damageData.DamageAmount and targetEntity then
                if not damageData.DoTTime or damageData.DoTTime <= 0 then
                    Damage(instigator, self:GetPosition(), targetEntity, damageData.DamageAmount, damageData.DamageType)
                else
                    ForkThread(DefaultDamage.UnitDoTThread, instigator, targetEntity, damageData.DoTPulses or 1, (damageData.DoTTime / (damageData.DoTPulses or 1)), damage, damageData.DamageType, damageData.DamageFriendly)
                end
            end
        end
    end,

    DoTaperedDamage = function(self, instigator, damageRadius, damage, damageType, damageFriendly, damageSelf, EdgeDamageRatio)
        if damageRadius and damage then
            local Run1Step = false
            if not EdgeDamageRatio then
                Run1Step = true
            else
                if EdgeDamageRatio >= 1 then
                    Run1Step = true
                end
            end
            if damageRadius < 2 then
                Run1Step = true
            end
            if Run1Step then
                DamageArea(instigator, self:GetPosition(), damageRadius, damage, damageType or 'Normal', damageFriendly or true, damageSelf or false)
            else
                local EdgeDamage = damage * EdgeDamageRatio
                local HalfWay = math.ceil(damageRadius / 2)
                local EdgeFloor = math.floor(damageRadius)
                local StepCount = EdgeFloor - HalfWay
                local DamageFalloff = damage - EdgeDamage
                local StepDamage = DamageFalloff / StepCount
                local ThisDamageRing = HalfWay
                for i=1,StepCount do
                    DamageArea(instigator, self:GetPosition(), ThisDamageRing, StepDamage, damageType or 'Normal', damageFriendly or true, damageSelf or false)
                    ThisDamageRing = ThisDamageRing + 1
                end
                DamageArea(instigator, self:GetPosition(), damageRadius, EdgeDamage, damageType or 'Normal', damageFriendly or true, damageSelf or false)
            end
        end
    end,

    PassDamageData = function(self, damageData)
        OldProjectile.PassDamageData(self,damageData)
        self.DamageData.EdgeDamageRatio = damageData.EdgeDamageRatio
    end,

} TypeClass = Projectile
end
