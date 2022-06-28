#****************************************************************************
#**
#**  File     :  /data/projectiles/SonicWave0105/SonicWave0105_script.lua
#**  Author(s):  Gordon Duclos, Matt Vainio
#**
#**  Summary  :  Cybran Proton Artillery projectile script, XRL0403
#**
#**  Copyright � 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local SonicWaveProjectile = import('/mods/BlackOpsUnleashed/lua/BlackOpsprojectiles.lua').SonicWaveProjectile
SonicWave01 = Class(SonicWaveProjectile) {
--[[
	OnImpact = function(self, TargetType, TargetEntity) 
		###self:ShakeCamera( radius, maxShakeEpicenter, minShakeAtRadius, interval )
		self:ShakeCamera( 15, 0.25, 0, 0.2 )
		SonicWaveProjectile.OnImpact (self, TargetType, TargetEntity)
	end,
	    OnImpactDestroy = function( self, targetType, targetEntity )

   if targetEntity and not IsUnit(targetEntity) then
      SonicWaveProjectile.OnImpactDestroy(self, targetType, targetEntity)
      return
   end
   
   if self.counter then
      if self.counter >= 2 then
         SonicWaveProjectile.OnImpactDestroy(self, targetType, targetEntity)
         return
      else
         self.counter = self.counter + 1
      end
   else
      self.counter = 1
   end
   if targetEntity then
self.lastimpact = targetEntity:GetEntityId() #remember what was hit last
end
end,
]]--
}
TypeClass = SonicWave01