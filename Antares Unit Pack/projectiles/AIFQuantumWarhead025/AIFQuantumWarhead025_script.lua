local AQuantumWarheadProjectile = import('/lua/aeonprojectiles.lua').AQuantumWarheadProjectile
local EffectTemplate = import('/lua/EffectTemplates.lua')
local RandomFloat = import('/lua/utilities.lua').GetRandomFloat
local VizMarker = import('/lua/sim/VizMarker.lua').VizMarker

AIFQuantumWarhead025 = Class(AQuantumWarheadProjectile) {

    Beams = {'/effects/emitters/aeon_nuke_exhaust_beam_01_emit.bp',},

    OnCreate = function(self)
        AQuantumWarheadProjectile.OnCreate(self)
        self:SetCollisionShape('Sphere', 0, 0, 0, 2.0)
        self.MoveThread = self:ForkThread(self.MovementThread)
    end,
    
    PassDamageData = function(self, damageData)
        AQuantumWarheadProjectile.PassDamageData(self,damageData)
        local launcherbp = self:GetLauncher():GetBlueprint()  
        self.ChildDamageData = table.copy(self.DamageData) 
    end,    
        
    OnImpact = function(self, TargetType, TargetEntity) 
        
        local FxFragEffect = EffectTemplate.TFragmentationSensorShellFrag 
        local ChildProjectileBP = '/mods/Antares Unit Pack/projectiles/AIFQuantumWarhead13/AIFQuantumWarhead13_proj.bp'  
              
        
        # Split effects
        for k, v in FxFragEffect do
            CreateEmitterAtEntity( self, self:GetArmy(), v )
        end
        
        local vx, vy, vz = self:GetVelocity()
        local velocity = 6
    
		# One initial projectile following same directional path as the original
        self:CreateChildProjectile(ChildProjectileBP):SetVelocity(vx, vy, vz):SetVelocity(velocity):PassDamageData(self.DamageData)
   		
		# Create several other projectiles in a dispersal pattern
        local numProjectiles = 8
        local angle = (2*math.pi) / numProjectiles
        local angleInitial = RandomFloat( 0, angle )
        
        # Randomization of the spread
        local angleVariation = angle * 0.35 # Adjusts angle variance spread
        local spreadMul = 2.5 # Adjusts the width of the dispersal        
        
        local xVec = 0 
        local yVec = vy
        local zVec = 0
        

        # Launch projectiles at semi-random angles away from split location
        for i = 0, (numProjectiles -1) do
            xVec = vx + (math.sin(angleInitial + (i*angle) + RandomFloat(-angleVariation, angleVariation))) * spreadMul
            zVec = vz + (math.cos(angleInitial + (i*angle) + RandomFloat(-angleVariation, angleVariation))) * spreadMul 
            local proj = self:CreateChildProjectile(ChildProjectileBP)
            proj:SetVelocity(xVec,yVec,zVec)
            proj:SetVelocity(velocity)
            proj:PassDamageData(self.DamageData)                        
        end
        self:Destroy()
        AQuantumWarheadProjectile.OnImpact(self, TargetType, TargetEntity) 
    end,
    

    MovementThread = function(self)
        local army = self:GetArmy()
        local launcher = self:GetLauncher()
        self:TrackTarget(false)
        WaitSeconds(2.5)		# Height
        self:SetCollision(true)
        WaitSeconds(2.5)
        WaitSeconds(2.5)
        self:TrackTarget(true) # Turn ~90 degrees towards target
        self:SetDestroyOnWater(true)        
        self:SetTurnRate(47.36)
        WaitSeconds(2) 					# Now set turn rate to zero so nuke flies straight
        self:SetTurnRate(0)
        self:SetAcceleration(0.001)
        self.WaitTime = 0.5
        while not self:BeenDestroyed() do
            self:SetTurnRateByDist()
            WaitSeconds(self.WaitTime)
        end
    end,

    SetTurnRateByDist = function(self)
        local dist = self:GetDistanceToTarget()
        #Get the nuke as close to 90 deg as possible
        if dist > 150 then        
            #Freeze the turn rate as to prevent steep angles at long distance targets
            self:SetTurnRate(0)
        elseif dist > 75 and dist <= 150 then
						# Increase check intervals
            self.WaitTime = 0.3
        elseif dist > 32 and dist <= 75 then
						# Further increase check intervals
            self.WaitTime = 0.1
        elseif dist < 15 then
						# Turn the missile down
            self:SetTurnRate(95)
        end
    end,

    GetDistanceToTarget = function(self)
        local tpos = self:GetCurrentTargetPosition()
        local mpos = self:GetPosition()
        local dist = VDist2(mpos[1], mpos[3], tpos[1], tpos[3])
        return dist
    end,
}

TypeClass = AIFQuantumWarhead025