#****************************************************************************
#**
#**  File     :  /data/projectiles/SIFZthuthaamArtilleryShell02/SIFZthuthaamArtilleryShell02_script.lua
#**  Author(s):  Gordon Duclos, Aaron Lundquist
#**
#**  Summary  :  Zthuthaam Artillery Shell Projectile script, XSB2303
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local SZthuthaamArtilleryShell = import('/lua/seraphimprojectiles.lua').SZthuthaamArtilleryShell 
local RandomFloat = import('/lua/utilities.lua').GetRandomFloat
local EffectTemplate = import('/lua/EffectTemplates.lua')

SIFZthuthaamArtilleryShell03 = Class(SZthuthaamArtilleryShell) {
	FxSplashScale = .4,
	FxEnterWaterEmitter = {
		'/effects/emitters/destruction_water_splash_ripples_01_emit.bp',
		'/effects/emitters/destruction_water_splash_wash_01_emit.bp',
	},
	
	OnEnterWater = function(self)
		SZthuthaamArtilleryShell.OnEnterWater(self)
		local army = self:GetArmy()

		for i in self.FxEnterWaterEmitter do #splash
			CreateEmitterAtEntity(self,army,self.FxEnterWaterEmitter[i]):ScaleEmitter(self.FxSplashScale)
		end
		--self.AirTrails:Destroy()
		CreateEmitterOnEntity(self,army,EffectTemplate.SHeavyCavitationTorpedoFxTrails)
				
		self:TrackTarget(true):StayUnderwater(true)
		self:SetMaxSpeed(1)
    	self:SetCollideSurface(false)
		self:SetTurnRate(780)
		self:ForkThread(self.ProjectileSplit)
	end,
    
	ProjectileSplit = function(self)
		WaitSeconds(0.5)
		local ChildProjectileBP = '/mods/BlackOpsBalance/projectiles/SANHeavyCavitationTorpedo05/SANHeavyCavitationTorpedo05_proj.bp'  
		local vx, vy, vz = self:GetVelocity()
		local velocity = 10
	    
		# Create projectiles in a dispersal pattern
		local numProjectiles = 6
		local angle = (2*math.pi) / numProjectiles
		local angleInitial = RandomFloat( 0, angle )
	    
		# Randomization of the spread
		local angleVariation = angle * 0.3 # Adjusts angle variance spread
		local spreadMul = .4 # Adjusts the width of the dispersal        
		local xVec = 0 
		local yVec = vy
		local zVec = 0
	    
		# Divide the damage between each projectile.  The damage in the BP is used as the initial projectile's 
		# damage, in case the torpedo hits something before it splits.
		local DividedDamageData = self.DamageData
		DividedDamageData.DamageAmount = DividedDamageData.DamageAmount / numProjectiles
	    
	    local FxFragEffect = EffectTemplate.SHeavyCavitationTorpedoSplit

        # Split effects
        for k, v in FxFragEffect do
            CreateEmitterAtEntity( self, self:GetArmy(), v )
        end
	    
		# Launch projectiles at semi-random angles away from split location
		for i = 0, (numProjectiles -1) do
			xVec = vx + (math.sin(angleInitial + (i*angle) + RandomFloat(-angleVariation, angleVariation))) * spreadMul
			zVec = vz + (math.cos(angleInitial + (i*angle) + RandomFloat(-angleVariation, angleVariation))) * spreadMul 
			local proj = self:CreateChildProjectile(ChildProjectileBP)
			proj:PassDamageData(DividedDamageData)
			proj:PassData(self:GetTrackingTarget())  
			proj:SetVelocity(xVec,yVec,zVec)
			proj:SetVelocity(velocity)
		end         
		self:Destroy()
	end,	
}
TypeClass = SIFZthuthaamArtilleryShell03