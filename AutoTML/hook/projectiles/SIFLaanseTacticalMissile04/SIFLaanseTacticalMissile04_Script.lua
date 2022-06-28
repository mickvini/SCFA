#
# Auto targeting for the Seraphim Land-Based Tactical Missile
#
local SLaanseTacticalMissile = import('/lua/seraphimprojectiles.lua').SLaanseTacticalMissile1
local Explosion = import('/lua/defaultexplosions.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')

SIFLaanseTacticalMissile04 = Class(SLaanseTacticalMissile) {

    OnCreate = function(self)
        SLaanseTacticalMissile.OnCreate(self)
        self:SetCollisionShape('Sphere', 0, 0, 0, 2.0)
        self.MovementTurnLevel = 1
        self:SetMaxSpeed(20)
        self:ChangeMaxZigZag(5)
        self:ForkThread( self.TargetTracking)
    end,

    TargetTracking = function(self)
        self:SetCollision(true)
        self:TrackTarget(true)
        self:SetTurnRate(20)
        WaitSeconds(0.1)
        local target = self:GetTrackingTarget()
        if table.getsize (target) < 1 then
            self:SetTurnRateByDist()
        else

            if target.IncommingDamage then
                if target.IncommingDamage<target:GetHealth()*1.5 then
                    target.IncommingDamage=target.IncommingDamage+self.DamageData.DamageAmount
                else
                    self:Retarget()
                end
            else
                target.IncommingDamage=self.DamageData.DamageAmount
            end
            
            while not self:BeenDestroyed() do
                WaitSeconds(0.1) 
                if target:IsDead() then
                    self:Retarget()
                else
                WaitSeconds(0.1)
                    self:SetTurnRateByDist()
                end
            end
        end
    end,

    Retarget = function(self)
        self:SetTurnRate(1)
        self:ChangeMaxZigZag(1)
        self.MovementTurnLevel = 1
        self:SetMaxSpeed(5) 

        local launcher = self:GetLauncher()
        local aiBrain = launcher:GetAIBrain()
        local position = self:GetPosition()
        local radius = 256
        local targetlist = aiBrain:GetUnitsAroundPoint(categories.ALLUNITS - categories.AIR - categories.SUBMERSIBLE - categories.WALL, position, radius, 'ENEMY')
        local num = table.getsize (targetlist)
        local ran = Random(1, num)

        if table.getsize (targetlist) > 0 then
           self:SetNewTarget(targetlist[ran])
           self:TargetTracking()
        else
           WaitSeconds(0.1)
           self:Retarget()
        end
    end,

    SetTurnRateByDist = function(self)
        local dist = self:GetDistanceToTarget()
        if dist > 150 and dist <= 200 then
            self:SetTurnRate(20)
            self:ChangeMaxZigZag(20)
            self:SetMaxSpeed(30)
            self.MovementTurnLevel = 1
        elseif dist > 100 and dist <= 150 then
            self:SetTurnRate(25)
            self:ChangeMaxZigZag(15)
            self:SetMaxSpeed(27.5)
            self.MovementTurnLevel = 2
        elseif dist > 50 and dist <= 100 then
            self:SetTurnRate(30)
            self:ChangeMaxZigZag(10)
            self:SetMaxSpeed(25)
            self.MovementTurnLevel = 3
        elseif dist > 25 and dist <= 50 then
            self:SetTurnRate(35)
            self:ChangeMaxZigZag(5)
            self:SetMaxSpeed(22.5)
            self.MovementTurnLevel = 4
        elseif dist < 25 then
            self:SetTurnRate(40)
            self:ChangeMaxZigZag(1)
            self:SetMaxSpeed(20)
            self.MovementTurnLevel = 5
        end
    end,

    GetDistanceToTarget = function(self)
        local tpos = self:GetCurrentTargetPosition()
        local mpos = self:GetPosition()
        local dist = VDist2(mpos[1], mpos[3], tpos[1], tpos[3])
        return dist
    end,

    OnDestroy = function(self)
        local target = self:GetTrackingTarget()
        if target and target.IncommingDamage then
            target.IncommingDamage=target.IncommingDamage-self.DamageData.DamageAmount
        end	
        if self.Trash then
            self.Trash:Destroy()
        end
    end,
}
TypeClass = SIFLaanseTacticalMissile04

