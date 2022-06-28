#****************************************************************************
#**
#**  File     :  /cdimage/units/UEB2401/UEB2401_script.lua
#**  Author(s):  John Comes
#**
#**  Summary  :  UEF Experimental Artillery Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit
local TIFArtilleryWeapon = import('/lua/terranweapons.lua').TIFArtilleryWeapon

UEB2401 = Class(TStructureUnit) {
    Weapons = {
        MainGun = Class(TIFArtilleryWeapon) {
            FxMuzzleFlashScale = 3,
           
            IdleState = State(TIFArtilleryWeapon.IdleState) {
                OnGotTarget = function(self)
                    TIFArtilleryWeapon.IdleState.OnGotTarget(self)
                    if not self.ArtyAnim then
                        self.ArtyAnim = CreateAnimator(self.unit)
                        self.ArtyAnim:PlayAnim(self.unit:GetBlueprint().Display.AnimationOpen)
                        self.unit.Trash:Add(self.ArtyAnim)
                    end
                end,
            },
            CreateProjectileAtMuzzle = function(self, muzzle)
                ### Updates firing Randomness
                self.unit.CurrentAccuracy = self.unit.MyWeapon:GetFiringRandomness()
                if self.unit.CurrentAccuracy >= 0.3 then
                    self.unit.MyWeapon:SetFiringRandomness(self.unit.CurrentAccuracy - 0.1)
                end

                ### Resets weapon acuracy if the target has changed
                if not self.unit:IsDead() and self.unit.MyWeapon:GetCurrentTarget() then
                    self.unit.CurrentTarget = self.unit.MyWeapon:GetCurrentTarget():GetEntityId()
                    if self.unit.OldTarget == nil then
                        ### Inputs new values into table
                        self.unit.OldTarget = self.unit.CurrentTarget
                    elseif self.unit.OldTarget ~= self.unit.CurrentTarget then
                        self.unit.MyWeapon:SetFiringRandomness(self.unit.MyWeapon:GetBlueprint().FiringRandomness)
                        ### Inputs new target values into OldTarget
                        self.unit.OldTarget = self.unit.CurrentTarget
                    end
                end
                TIFArtilleryWeapon.CreateProjectileAtMuzzle(self, muzzle)
            end,

            OnLostTarget = function(self)
                ### Resets weapon acuracy if target is lost
                if not self.unit:IsDead() then   
                    self.unit.MyWeapon:SetFiringRandomness(self.unit.MyWeapon:GetBlueprint().FiringRandomness)
                end
                TIFArtilleryWeapon.OnLostTarget(self)
            end,

        },
    },

    OnStopBeingBuilt = function(self,builder,layer)
        TStructureUnit.OnStopBeingBuilt(self)
        ### Global variable setup
        self.MyWeapon = self:GetWeaponByLabel('MainGun')
        self.CurrentAccuracy = nil
        self.CurrentTarget = nil
        self.OldTarget = nil
        self.RapidFiringState = true
    end,
}

TypeClass = UEB2401