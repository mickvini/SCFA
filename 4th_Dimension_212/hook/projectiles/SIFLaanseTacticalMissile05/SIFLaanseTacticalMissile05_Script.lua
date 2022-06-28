#****************************************************************************
#**
#**  File     :  /projectiles/SIFLaanseTacticalMissile05/SIFLaanseTacticalMissile05_script.lua
#**  Author(s):  EbolaSoup, Resin Smoker, Optimus Prime
#**
#**  Summary  :  Laanse Tactical Missile Projectile script for XSL0310a
#**
#**  Copyright © 2009 4th Dimension Mod  All rights reserved.
#****************************************************************************

local SLaanseTacticalMissile = import('/lua/seraphimprojectiles.lua').SLaanseTacticalMissile

SIFLaanseTacticalMissile05 = Class(SLaanseTacticalMissile) {
    
    FxAirUnitHitScale = 0.5,
    FxLandHitScale = 0.5,
    FxNoneHitScale = 0.5,
    FxPropHitScale = 0.5,
    FxProjectileHitScale = 0.5,
    FxProjectileUnderWaterHitScale = 0.5,
    FxShieldHitScale = 0.5,
    FxUnderWaterHitScale = 0.5,
    FxUnitHitScale = 0.5,
    FxWaterHitScale = 0.5,
    FxOnKilledScale = 0.5,
	
    OnCreate = function(self)
        SLaanseTacticalMissile.OnCreate(self)    
        self:SetCollisionShape('Sphere', 0, 0, 0, 0.5)
        self.MoveThread = self:ForkThread(self.MovementThread)
    end,

    MovementThread = function(self)  
        self.WaitTime = 0.1
        self.Distance = self:GetDistanceToTarget()
        self:SetTurnRate(8)
        self:TrackTarget(false)        
        WaitSeconds(0.3) 
        if not self:BeenDestroyed() then
            self:TrackTarget(true)
            self:SetTurnRateByDist()                         
        end     
    end,

    SetTurnRateByDist = function(self)
        local dist = self:GetDistanceToTarget()
        if dist > self.Distance then
        	self:SetTurnRate(75)
        	WaitSeconds(3)
        	self:SetTurnRate(8)
        	self.Distance = self:GetDistanceToTarget()
        end
        if dist > 50 then        
            #Freeze the turn rate as to prevent steep angles at long distance targets
            WaitSeconds(2)
            self:SetTurnRate(10)
        elseif dist > 30 and dist <= 50 then
						self:SetTurnRate(12)
						WaitSeconds(1.5)
            self:SetTurnRate(12)
        elseif dist > 10 and dist <= 25 then
            WaitSeconds(0.3)
            self:SetTurnRate(50)
				elseif dist > 0 and dist <= 10 then           
            self:SetTurnRate(100)   
            KillThread(self.MoveThread)         
        end
    end,           

    GetDistanceToTarget = function(self)
        local tpos = self:GetCurrentTargetPosition()
        local mpos = self:GetPosition()
        local dist = VDist2(mpos[1], mpos[3], tpos[1], tpos[3])
        return dist
    end,
	

}
TypeClass = SIFLaanseTacticalMissile05