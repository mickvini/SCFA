#****************************************************************************
#**
#**  File     :  /cdimage/units/UEL0201/UEL0201_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  BRN Scavenger Medium Tank
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local AWeaponsFile = import('/lua/aeonweapons.lua')
local ACruiseMissileWeapon = AWeaponsFile.ACruiseMissileWeapon
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local TIFCommanderDeathWeapon = WeaponsFile.TIFCommanderDeathWeapon
local TDFMachineGunWeapon = WeaponsFile.TDFMachineGunWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtils = import('/lua/effectutilities.lua')
local TMEffectTemplate = import('/mods/TotalMayhem/lua/TMEffectTemplates.lua')

BRNT2EXM2 = Class(TLandUnit) {
    SwitchAnims = true,
    IsWaiting = false,
    Weapons = {
        rocket = Class(ACruiseMissileWeapon) {
            FxMuzzleFlash = EffectTemplate.CIFCruiseMissileLaunchSmoke,
            FxMuzzleFlashScale = 3.2,
	},
        rocket2 = Class(ACruiseMissileWeapon) {
            FxMuzzleFlash = EffectTemplate.CIFCruiseMissileLaunchSmoke,
            FxMuzzleFlashScale = 3.2,
	},
        robottalk = Class(TDFGaussCannonWeapon) {
			            FxMuzzleFlashScale = 0.0, 
	},
    },
    
   --[[OnCreate = function(self)
		TLandUnit.OnCreate(self)
		self:SetWeaponEnabledByLabel('rocket', false)
		--self:SetOnScriptBitSet(true)
    end,]]--

    OnStopBeingBuilt = function(self,builder,layer)
        TLandUnit.OnStopBeingBuilt(self,builder,layer)
        # If created with F2 on land, then play the transform anim.
        if(self:GetCurrentLayer() == 'Land') then
            self.AT1 = self:ForkThread(self.TransformThread, false)
        end

        TLandUnit.OnStopBeingBuilt(self,builder,layer)
      
      if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
         self:SetWeaponEnabledByLabel('rocket2', false)
         self:SetWeaponEnabledByLabel('robottalk', false)
      else
         self:SetWeaponEnabledByLabel('rocket2', true)
         self:SetWeaponEnabledByLabel('robottalk', true)
        end
    end,	
	
    TransformThread = function(self, land)
        if( not self.AnimManip ) then
            self.AnimManip = CreateAnimator(self)
        end
        local bp = self:GetBlueprint()
        local scale = bp.Display.UniformScale or 1

        if( land ) then
		self:SetImmobile(true)
		self:SetSpeedMult(0)

            
            self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationTransform)
            self.AnimManip:SetRate(0.5)
            self.IsWaiting = true
            WaitFor(self.AnimManip)
			self.IsWaiting = false
            self.Trash:Add(self.AnimManip)
			self:SetWeaponEnabledByLabel('rocket', true)
			self.SwitchAnims = true
        else
            self:SetImmobile(true)
            self:SetWeaponEnabledByLabel('rocket', false)
            self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationTransform)
            self.AnimManip:SetAnimationFraction(1)
            self.AnimManip:SetRate(-1)
            self.IsWaiting = true
            WaitFor(self.AnimManip)
			self.IsWaiting = false
            self.AnimManip = nil
            self:SetImmobile(false)
			self:SetSpeedMult(1)
        end
    end,
	
    OnScriptBitSet = function(self, bit)
        TLandUnit.OnScriptBitSet(self, bit)
		local bp = self:GetBlueprint()
        if bit == 1 then 
			self.AT1 = self:ForkThread(self.TransformThread, true)
        end
    end,

    OnScriptBitClear = function(self, bit)
        TLandUnit.OnScriptBitClear(self, bit)
        if bit == 1 then 
			self.AT1 = self:ForkThread(self.TransformThread, false)
        end
    end,

OnKilled = function(self,builder,layer)
        TLandUnit.OnKilled(self,builder,layer)
        self:CreatTheEffectsDeath()  
    end,

CreatTheEffectsDeath = function(self)
	local army =  self:GetArmy()
	for k, v in TMEffectTemplate['UEFHEAVYROCKET'] do
		CreateAttachedEmitter(self, 'BRNT2EXM2', army, v):ScaleEmitter(1.0)
	end
end,
}

TypeClass = BRNT2EXM2