#****************************************************************************
#**
#**  File     :  /cdimage/units/UEL0201/UEL0201_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  BRN Scavenger Medium Tank
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TWalkingLandUnit = import('/lua/terranunits.lua').TWalkingLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local TDFIonizedPlasmaCannon = WeaponsFile.TDFIonizedPlasmaCannon
local TDFMachineGunWeapon = WeaponsFile.TDFMachineGunWeapon
local TSAMLauncher = WeaponsFile.TSAMLauncher
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local TDFGaussCannonWeapon2 = WeaponsFile.TDFLandGaussCannonWeapon
local TDFGaussCannonWeapon3 = WeaponsFile.TDFLandGaussCannonWeapon
local TIFCommanderDeathWeapon = WeaponsFile.TIFCommanderDeathWeapon
local TANTorpedoAngler = WeaponsFile.TANTorpedoAngler
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtils = import('/lua/effectutilities.lua')
local TMEffectTemplate = import('/mods/TotalMayhem/lua/TMEffectTemplates.lua')
local TMMMEffectTemplate = import('/mods/TotalMayhem/lua/TMavaEffectTemplates.lua')

BRNT3SHBM2 = Class(TWalkingLandUnit) {

    Weapons = {
        Torpedo01 = Class(TANTorpedoAngler) {},
        MissileRack01 = Class(TSAMLauncher) {},
        mainrockets = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 0,
	},
        mainrockets2 = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 0,
	},
        sm1weapon = Class(TDFGaussCannonWeapon3) {
            FxMuzzleFlashScale = 1.5,
	},
        lefthandweapon = Class(TDFGaussCannonWeapon3) {
            FxMuzzleFlashScale = 4.5,
            FxMuzzleFlash = EffectTemplate.ASDisruptorCannonMuzzle01,
	},
        righthandweapon = Class(TDFGaussCannonWeapon3) {
            FxMuzzleFlashScale = 4.5,
            FxMuzzleFlash = EffectTemplate.ASDisruptorCannonMuzzle01,
	},
        rocketweapon1 = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 0,
	},
        rocketweapon2 = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 0,
	},
        rocketweapon3 = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 0,
	},
        rocketweapon4 = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 0,
	},
        rocketweapon5 = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 0,
	},
        rocketweapon6 = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 0,
	},
        rocketweapon7 = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 0,
	},
        rocketweapon8 = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 0,
	},
        robottalk = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 0,
	},
        empweapon = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 0,
	    FxGroundEffect = EffectTemplate.ConcussionRingLrg01,
	        FxVentEffect3 = TMMMEffectTemplate.Mayhemmk4EMPeffect,
	        FxCoolDownEffect = EffectTemplate.CDisruptorCoolDownEffect,     
	        PlayFxMuzzleSequence = function(self, muzzle)
		        local army = self.unit:GetArmy()
		        
	            for k, v in self.FxVentEffect3 do
                    CreateAttachedEmitter(self.unit, 'Turret', army, v):ScaleEmitter(3.35)
                end
            end, 
	},
        DeathWeapon = Class(TIFCommanderDeathWeapon) {
        },
    },

    OnStartBeingBuilt = function(self, builder, layer)
        TWalkingLandUnit.OnStartBeingBuilt(self, builder, layer)
        if not self.AnimationManipulator then
            self.AnimationManipulator = CreateAnimator(self)
            self.Trash:Add(self.AnimationManipulator)
        end
        self.AnimationManipulator:PlayAnim(self:GetBlueprint().Display.AnimationActivate, false):SetRate(0)
    end,

OnStopBeingBuilt = function(self,builder,layer)
        TWalkingLandUnit.OnStopBeingBuilt(self,builder,layer)

        if self.AnimationManipulator then
            self:SetUnSelectable(true)
            self.AnimationManipulator:SetRate(1)
            
            self:ForkThread(function()
                WaitSeconds(self.AnimationManipulator:GetAnimationDuration()*self.AnimationManipulator:GetRate())
                self:SetUnSelectable(false)
                self.AnimationManipulator:Destroy()
            end)
        end  
      
        self:CreatTheEffects()
      if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
         self:SetWeaponEnabledByLabel('robottalk', false)
      else
         self:SetWeaponEnabledByLabel('robottalk', true)
      end      
    end,

CreatTheEffects = function(self)
	local army =  self:GetArmy()
	for k, v in EffectTemplate['SmokePlumeMedDensitySml01'] do
		CreateAttachedEmitter(self, 'ex01', army, v):ScaleEmitter(1.35)
	end
	for k, v in EffectTemplate['SmokePlumeMedDensitySml01'] do
		CreateAttachedEmitter(self, 'ex02', army, v):ScaleEmitter(1.35)
	end
end,

OnKilled = function(self,builder,layer)
        TWalkingLandUnit.OnKilled(self,builder,layer)
        self:CreatTheEffectsDeath()  
    end,

CreatTheEffectsDeath = function(self)
	local army =  self:GetArmy()
	for k, v in TMEffectTemplate['UEFDeath02'] do
		CreateAttachedEmitter(self, 'Turret', army, v):ScaleEmitter(2.25)
	end
end,
}

TypeClass = BRNT3SHBM2