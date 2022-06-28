#****************************************************************************
#**
#**  File     :  /lua/unit.lua
#**  Author(s):  John Comes, David Tomandl, Gordon Duclos
#**


do
local oldUnit = Unit
Unit = Class(oldUnit) {

	##########################################################################################
    ## TRANSPORTING Scripts required for the Advanced Jamming mod
    ##########################################################################################

    # copied from the community bug fix patch v3, slightly edited

    OnTransportAttach = function(self, attachBone, unit)
        oldUnit.OnTransportAttach(self, attachBone, unit)
        unit:OnAttachedToTransport(self)
    end,

    OnAttachedToTransport = function(self, transport)
    end,

    OnTransportDetach = function(self, attachBone, unit)
        oldUnit.OnTransportDetach(self, attachBone, unit)
        unit:OnDetachedToTransport(self)
    end,

    OnDetachedToTransport = function(self, transport)
    end,   

    OnCreate = function(self)
        oldUnit.OnCreate(self)
		self.VeteranTracker = 0
	end,

	
   CreateDestructionEffects = function( self, overKillRatio )
        local scale = self:GetBlueprint().SizeX * self:GetBlueprint().SizeY * self:GetBlueprint().SizeZ
    	local category = self:GetBlueprint().Categories
    	local island = 0
    	local isnaval = 0
		local isair = 0
		local issub = 0
		    	
    	if table.find(category, 'LAND') then 
    	island = 1
    	end
		if table.find(category, 'NAVAL') then 
    	isnaval = 1
    	end
		if table.find(category, 'AIR') then 
    	isair = 1
    	end
    	if table.find(category, 'SUBMERSIBLE') then 
    	issub = 1
    	end   	
    	self:PlayUnitSound('Destroyed')
        #print(LOC, "scale", scale)
    	randomized = Random( 1, 20)
        if scale > 0.2 and randomized > 14 and randomized < 19 and island == 1 then
        	if scale > 1 then
        		scale = 0.6
        	end
        CreateAttachedEmitter(self, 0, self:GetArmy(), '/effects/emitters/destruction_explosion_concussion_ring_03_emit.bp'):ScaleEmitter(scale * 0.45)
        end	
        if scale > 0.26 and randomized > 17 and island == 1 then
            if scale > 1 then
        		scale = 0.6
        	end
        CreateAttachedEmitter(self, 0, self:GetArmy(), '/effects/emitters/nuke_concussion_ring_01_emit.bp'):ScaleEmitter(scale * 0.25)
        end	

        randomized = Random( 1, 7)
        if randomized > 0 and isair == 1 then
        	explosion.CreateTimedStuctureUnitExplosion( self )
			WaitSeconds( Random( 0, 0.5 ) )  
		end     
                            	
        explosion.CreateScalableUnitExplosion( self, overKillRatio )
        
        randomized = Random( 1, 6)
        if randomized > 4 and isnaval == 0 then
        	explosion.CreateTimedStuctureUnitExplosion( self )
			WaitSeconds( Random( 0, 0.5 ) )  
		end     
	 	
        randomized = Random( 1, 6)
        self:PlayUnitSound('Destroyed')
        if randomized > 5 and isnaval == 0 then
        	explosion.CreateTimedStuctureUnitExplosion( self )  
        end            
        if randomized > 3 and isair == 0 then
        	WaitSeconds( Random( 0.2, 1.0 ) )
        	self:PlayUnitSound('Destroyed')        
        	explosion.CreateScalableUnitExplosion( self, overKillRatio )        
        end
        
    end,	

    DeathWeaponDamageThread = function( self , damageRadius, damage, damageType, damageFriendly)
        DamageArea(self, self:GetPosition(), damageRadius * 0.6 or 1, damage * 0.4 or 1, damageType or 'Normal', damageFriendly or true)
        WaitSeconds( 0.3 )
		DamageArea(self, self:GetPosition(), damageRadius * 0.7 or 1, damage * 0.185 or 1, damageType or 'Normal', damageFriendly or true)
		WaitSeconds( 0.3 )
		DamageArea(self, self:GetPosition(), damageRadius * 0.8 or 1, damage * 0.15 or 1, damageType or 'Normal', damageFriendly or true)
		WaitSeconds( 0.3 )
		DamageArea(self, self:GetPosition(), damageRadius * 0.9 or 1, damage * 0.1 or 1, damageType or 'Normal', damageFriendly or true)
		WaitSeconds( 0.3 )
		DamageArea(self, self:GetPosition(), damageRadius * 1.0 or 1, damage * 0.085 or 1, damageType or 'Normal', damageFriendly or true)
		WaitSeconds( 0.3 )
		DamageArea(self, self:GetPosition(), damageRadius * 1.1 or 1, damage * 0.085 or 1, damageType or 'Normal', damageFriendly or true)
		WaitSeconds( 0.3 )
		DamageArea(self, self:GetPosition(), damageRadius * 1.2 or 1, damage * 0.05 or 1, damageType or 'Normal', damageFriendly or true)
    end,

    DeathThread = function( self, overkillRatio, instigator)
		local category = self:GetBlueprint().Categories
    	local isnaval = 0
		local isair = 0
		    	
		if table.find(category, 'NAVAL') then 
    	isnaval = 1
    	end
		if table.find(category, 'AIR') then 
    	isair = 1
    	end
  	
    	    	
        #LOG('*DEBUG: OVERKILL RATIO = ', repr(overkillRatio))

        WaitSeconds( utilities.GetRandomFloat( self.DestructionExplosionWaitDelayMin, self.DestructionExplosionWaitDelayMax) )
        self:DestroyAllDamageEffects()

        if self.PlayDestructionEffects then
            self:CreateDestructionEffects( self, overkillRatio )
        end

        #MetaImpact( self, self:GetPosition(), 0.1, 0.5 )
        if self.DeathAnimManip then
            WaitFor(self.DeathAnimManip)
            if self.PlayDestructionEffects and self.PlayEndAnimDestructionEffects then
                self:CreateDestructionEffects( self, overkillRatio )
            end
        end

        self:CreateWreckage( overkillRatio )

        # CURRENTLY DISABLED UNTIL DESTRUCTION
        # Create destruction debris out of the mesh, currently these projectiles look like crap,
        # since projectile rotation and terrain collision doesn't work that great. These are left in
        # hopes that this will look better in the future.. =)
        if( self.ShowUnitDestructionDebris and overkillRatio ) then
            if overkillRatio <= 1 then
                self.CreateUnitDestructionDebris( self, true, true, false )
            elseif overkillRatio <= 2 then
                self.CreateUnitDestructionDebris( self, true, true, false )
            elseif overkillRatio <= 3 then
                self.CreateUnitDestructionDebris( self, true, true, true )
            else #VAPORIZED
                self.CreateUnitDestructionDebris( self, true, true, true )
            end
        end

        #LOG('*DEBUG: DeathThread Destroying in ',  self.DeathThreadDestructionWaitTime )
        WaitSeconds(self.DeathThreadDestructionWaitTime)
        #WaitSeconds(2)
		#if (isair == 1 or isnaval == 1) then
		#	WaitSeconds(10)
		#end
        #self:PlayUnitSound('Destroyed')
        
        self:Destroy()
    end,


	PlayAnimationThread = function(self, anim)
        local bp = self:GetBlueprint().Display[anim]
        if bp then
            local totWeight = 0
            for k, v in bp do
                if v.Weight then
                    totWeight = totWeight + v.Weight
                end
            end
            local val = 1
            local num = Random(0, totWeight)
            for k, v in bp do
                if v.Weight then
                    val = val + v.Weight
                end
                if num < val then
                    bp = v
                    break
                end
            end
            if bp.Mesh then
                self:SetMesh(bp.Mesh)
            end
            if bp.Animation then
                local sinkAnim = CreateAnimator(self)
                self:StopRocking()
                self.DeathAnimManip = sinkAnim
                sinkAnim:PlayAnim(bp.Animation)
                local rate = 1
                if bp.AnimationRateMax and bp.AnimationRateMin then
                    rate = Random(bp.AnimationRateMin * 10, bp.AnimationRateMax * 10) / 20
                end
                sinkAnim:SetRate(rate)
                self.Trash:Add(sinkAnim)
                WaitFor(sinkAnim)
            end
        end
    end,   
      
}
end