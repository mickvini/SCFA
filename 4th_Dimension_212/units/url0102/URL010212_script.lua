#****************************************************************************
#**
#**  File     :  /cdimage/units/URL0205/URL0205_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Cybran Mobile Flak Artillery Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CLandUnit = import('/lua/cybranunits.lua').CLandUnit
local CDFParticleCannonWeapon = import('/lua/cybranweapons.lua').CDFParticleCannonWeapon

URL0102 = Class(CLandUnit) {

    Weapons = {
        RightGun = Class(CDFParticleCannonWeapon) {
            FxMuzzleFlash = {'/effects/emitters/particle_cannon_muzzle_02_emit.bp'},
            PlayFxWeaponUnpackSequence = function(self)
                    if not self.SpinManip then 
                        self.SpinManip = CreateRotator(self.unit, 'RotatorRight', 'z', nil, 270, 280, 60)
                        self.unit.Trash:Add(self.SpinManip)
                    end
                    if self.SpinManip then
                        self.SpinManip:SetTargetSpeed(1470)
                    end
                    CDFParticleCannonWeapon.PlayFxWeaponUnpackSequence(self)
                end,

                PlayFxWeaponPackSequence = function(self)
                    if self.SpinManip then
                        self.SpinManip:SetTargetSpeed(0)
                    end
                    CDFParticleCannonWeapon.PlayFxWeaponPackSequence(self)
                end,
        },
        
        LeftGun = Class(CDFParticleCannonWeapon) {
            FxMuzzleFlash = {'/effects/emitters/particle_cannon_muzzle_02_emit.bp'},
            PlayFxWeaponUnpackSequence = function(self)
                    if not self.SpinManip then 
                        self.SpinManip = CreateRotator(self.unit, 'RotatorLeft', 'z', nil, 270, 280, 60)
                        self.unit.Trash:Add(self.SpinManip)
                    end
                    if self.SpinManip then
                        self.SpinManip:SetTargetSpeed(1470)
                    end
                    CDFParticleCannonWeapon.PlayFxWeaponUnpackSequence(self)
                end,

                PlayFxWeaponPackSequence = function(self)
                    if self.SpinManip then
                        self.SpinManip:SetTargetSpeed(0)
                    end
                    CDFParticleCannonWeapon.PlayFxWeaponPackSequence(self)
                end,
        },
    },
}

TypeClass = URL0102