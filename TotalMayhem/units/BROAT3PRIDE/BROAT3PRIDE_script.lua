#****************************************************************************
#**
#**  File     :  /cdimage/units/UAA0203/UAA0203_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Aeon Gunship Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local AAirUnit = import('/lua/aeonunits.lua').AAirUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local AeonWeapons = import('/lua/aeonweapons.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local TMWeaponsFile = import('/mods/TotalMayhem/lua/TMAeonWeapons.lua')
local TMAnovacatgreenlaserweapon = TMWeaponsFile.TMAnovacatgreenlaserweapon
local TMAnovacatbluelaserweapon = TMWeaponsFile.TMAnovacatbluelaserweapon
local ADFQuantumAutogunWeapon = AeonWeapons.ADFQuantumAutogunWeapon
local AAAZealotMissileWeapon = AeonWeapons.AAAZealotMissileWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtils = import('/lua/effectutilities.lua')
local TMEffectTemplate = import('/mods/TotalMayhem/lua/TMEffectTemplates.lua')
local TMMMEffectTemplate = import('/mods/TotalMayhem/lua/TMavaEffectTemplates.lua')
local util = import('/lua/utilities.lua')
local fxutil = import('/lua/effectutilities.lua')

BROAT3PRIDE = Class(AAirUnit) {
    Weapons = {
        laserblue = Class(TMAnovacatbluelaserweapon) {
	},
        lasergreen = Class(TMAnovacatgreenlaserweapon) {
    FxMuzzleFlash = EffectTemplate.SDFExperimentalPhasonProjChargeMuzzleFlash,
			            FxMuzzleFlashScale = 2.8, 
	},
        lasergreen2 = Class(TMAnovacatgreenlaserweapon) {
	},
        lasergreen3 = Class(TMAnovacatgreenlaserweapon) {
	},
        lasergreen4 = Class(TMAnovacatgreenlaserweapon) {
	},
        lasergreen5 = Class(TMAnovacatgreenlaserweapon) {
	},
        autoattack = Class(TDFGaussCannonWeapon) {
			            FxMuzzleFlashScale = 0.0, 
	},
        AntiAirMissiles01 = Class(AAAZealotMissileWeapon) {},
        bigGun = Class(TDFGaussCannonWeapon) {
          FxMuzzleFlash = TMEffectTemplate.AeonUnitDeathRing03,
			            FxMuzzleFlashScale = 24.8, 
        },
        smallproj01 = Class(TDFGaussCannonWeapon) {  
            FxMuzzleFlashScale = 9,
            FxMuzzleFlash = EffectTemplate.ASDisruptorCannonChargeMuzzle01,
	}, 
        smallproj02 = Class(TDFGaussCannonWeapon) {  
            FxMuzzleFlashScale = 9,
            FxMuzzleFlash = EffectTemplate.ASDisruptorCannonChargeMuzzle01,
	},
        smallproj03 = Class(TDFGaussCannonWeapon) {  
            FxMuzzleFlashScale = 9,
            FxMuzzleFlash = EffectTemplate.ASDisruptorCannonChargeMuzzle01,
	},
        smallproj04 = Class(TDFGaussCannonWeapon) {  
            FxMuzzleFlashScale = 9,
            FxMuzzleFlash = EffectTemplate.ASDisruptorCannonChargeMuzzle01,
	},

        mainproj01 = Class(TDFGaussCannonWeapon) {  
            FxMuzzleFlashScale = 9,
            FxMuzzleFlash = EffectTemplate.ASDisruptorCannonChargeMuzzle01,
	}, 
        mainproj02 = Class(TDFGaussCannonWeapon) {  
            FxMuzzleFlashScale = 9,
            FxMuzzleFlash = EffectTemplate.ASDisruptorCannonChargeMuzzle01,
	}, 
        mainproj03 = Class(TDFGaussCannonWeapon) {  
            FxMuzzleFlashScale = 9,
            FxMuzzleFlash = EffectTemplate.ASDisruptorCannonChargeMuzzle01,
	}, 
        mainproj04 = Class(TDFGaussCannonWeapon) {  
            FxMuzzleFlashScale = 9,
            FxMuzzleFlash = EffectTemplate.ASDisruptorCannonChargeMuzzle01,
	}, 
        newproj01 = Class(TDFGaussCannonWeapon) {  
            FxMuzzleFlashScale = 0,
            FxMuzzleFlash = EffectTemplate.ASDisruptorCannonChargeMuzzle01,
	}, 
        newproj02 = Class(TDFGaussCannonWeapon) {  
            FxMuzzleFlashScale = 0,
            FxMuzzleFlash = EffectTemplate.ASDisruptorCannonChargeMuzzle01,
	}, 
        newproj03 = Class(TDFGaussCannonWeapon) {  
            FxMuzzleFlashScale = 0,
            FxMuzzleFlash = EffectTemplate.ASDisruptorCannonChargeMuzzle01,
	}, 
        newproj04 = Class(TDFGaussCannonWeapon) {  
            FxMuzzleFlashScale = 0,
            FxMuzzleFlash = EffectTemplate.ASDisruptorCannonChargeMuzzle01,
	}, 
    },




    MovementAmbientExhaustBones = {
                            'ex01',
                            'ex02',
                            'ex03',
                            'ex04',
                            'ex05',
                            'ex06',
                            'ex07',
                            'ex08',
    },

    DestructionPartsChassisToss = {'BROAT3PRIDE',},
    DestroyNoFallRandomChance = 1.1,











OnStopBeingBuilt = function(self,builder,layer)
        AAirUnit.OnStopBeingBuilt(self,builder,layer)
        self.Trash:Add(CreateRotator(self, 'Object12', 'y', nil, -5, 0, 0))
        self.Trash:Add(CreateRotator(self, 'Cylinder02', 'y', nil, 5, 0, 0))
        self:CreatTheEffects()   


      if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
         self:SetWeaponEnabledByLabel('autoattack', false)
      else
         self:SetWeaponEnabledByLabel('autoattack', true)
      end      
    end,








    OnMotionHorzEventChange = function(self, new, old )
		AAirUnit.OnMotionHorzEventChange(self, new, old)
	
		if self.ThrustExhaustTT1 == nil then 
			if self.MovementAmbientExhaustEffectsBag then
				fxutil.CleanupEffectBag(self,'MovementAmbientExhaustEffectsBag')
			else
				self.MovementAmbientExhaustEffectsBag = {}
			end
			self.ThrustExhaustTT1 = self:ForkThread(self.MovementAmbientExhaustThread)
		end
		
        if new == 'Stopped' and self.ThrustExhaustTT1 != nil then
			KillThread(self.ThrustExhaustTT1)
			fxutil.CleanupEffectBag(self,'MovementAmbientExhaustEffectsBag')
			self.ThrustExhaustTT1 = nil
        end		 
    end,
    
    MovementAmbientExhaustThread = function(self)
		while not self:IsDead() do
			local ExhaustEffects = {
				'/effects/emitters/dirty_exhaust_smoke_01_emit.bp',
				'/effects/emitters/dirty_exhaust_sparks_01_emit.bp',			
			}
			local ExhaustBeam = '/effects/emitters/missile_exhaust_fire_beam_03_emit.bp'
			local army = self:GetArmy()			
			
			for kE, vE in ExhaustEffects do
				for kB, vB in self.MovementAmbientExhaustBones do
					table.insert( self.MovementAmbientExhaustEffectsBag, CreateAttachedEmitter(self, vB, army, vE ))
					table.insert( self.MovementAmbientExhaustEffectsBag, CreateBeamEmitterOnEntity( self, vB, army, ExhaustBeam ))
				end
			end
			
			WaitSeconds(2)
			fxutil.CleanupEffectBag(self,'MovementAmbientExhaustEffectsBag')
							
			WaitSeconds(util.GetRandomFloat(1,7))
		end	
    end,



CreatTheEffects = function(self)
	local army =  self:GetArmy()
	for k, v in TMMMEffectTemplate['PrideFlyingEmitter'] do
		CreateAttachedEmitter(self, 'eff01', army, v):ScaleEmitter(1.35)
	end
end,



OnKilled = function(self,builder,layer)
        AAirUnit.OnKilled(self,builder,layer)
        self:CreatTheEffectsDeath()  
    end,

CreatTheEffectsDeath = function(self)
	local army =  self:GetArmy()
	for k, v in TMEffectTemplate['AeonBattleShipHit01'] do
		CreateAttachedEmitter(self, 'BROAT3PRIDE', army, v):ScaleEmitter(8.65)
	end
end,
}

TypeClass = BROAT3PRIDE