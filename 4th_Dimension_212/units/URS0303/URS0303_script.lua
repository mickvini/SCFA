#****************************************************************************
#**
#**  File     :  /cdimage/units/URS0303/URS0303_script.lua
#**  Author(s):  David Tomandl, Andres Mendez
#**
#**  Summary  :  Cybran Aircraft Carrier Script
#**
#**  Copyright © 2008 Resin_Smoker
#****************************************************************************

local CSeaUnit = import('/lua/cybranunits.lua').CSeaUnit
local CybranWeaponsFile = import('/lua/cybranweapons.lua')
local CAAAutocannon = CybranWeaponsFile.CAAAutocannon
local CAMZapperWeapon = CybranWeaponsFile.CAMZapperWeapon
local loading = false

URS0303 = Class(CSeaUnit) {

    Weapons = {
    #Weapons
    # 4 AA Autocannon w/ Guided Rounds
    # 1 "Zapper" Anti-Missile

        AAGun01 = Class(CAAAutocannon) {},
        AAGun02 = Class(CAAAutocannon) {},
        AAGun03 = Class(CAAAutocannon) {},
        AAGun04 = Class(CAAAutocannon) {},

        Zapper = Class(CAMZapperWeapon) {
            SphereEffectIdleMesh = '/effects/entities/cybranphalanxsphere01/cybranphalanxsphere01_mesh',
            SphereEffectActiveMesh = '/effects/entities/cybranphalanxsphere01/cybranphalanxsphere02_mesh',
            SphereEffectBp = '/effects/emitters/zapper_electricity_01_emit.bp',

            OnCreate = function(self)
                CAMZapperWeapon.OnCreate(self)

                self.SphereEffectEntity = import('/lua/sim/Entity.lua').Entity()
                self.SphereEffectEntity:AttachBoneTo(-1,self.unit,'Zapper_Muzzle')
                self.SphereEffectEntity:SetMesh(self.SphereEffectIdleMesh)
                self.SphereEffectEntity:SetDrawScale(0.3)
                self.SphereEffectEntity:SetVizToAllies('Intel')
                self.SphereEffectEntity:SetVizToNeutrals('Intel')
                self.SphereEffectEntity:SetVizToEnemies('Intel')
                local emit = CreateAttachedEmitter(self.unit,'Zapper_Muzzle',self.unit:GetArmy(),self.SphereEffectBp):ScaleEmitter(0.5)

                self.unit.Trash:Add(self.SphereEffectEntity)
                self.unit.Trash:Add(emit)
            end,

            IdleState = State (CAMZapperWeapon.IdleState) {
                Main = function(self)
                    CAMZapperWeapon.IdleState.Main(self)
                end,

                OnGotTarget = function(self)
                    CAMZapperWeapon.OnGotTarget(self)
                    self.SphereEffectEntity:SetMesh(self.SphereEffectActiveMesh)
                end,
            },

            OnLostTarget = function(self)
                CAMZapperWeapon.OnLostTarget(self)
                self.SphereEffectEntity:SetMesh(self.SphereEffectIdleMesh)
            end,
        },

    },

    BuildAttachBone = 'Attachpoint',

    OnStopBeingBuilt = function(self,builder,layer)
        CSeaUnit.OnStopBeingBuilt(self,builder,layer)
        ChangeState(self, self.IdleState)
    end,

    OnFailedToBuild = function(self)
        CSeaUnit.OnFailedToBuild(self)
        ChangeState(self, self.IdleState)
    end,

    IdleState = State {
        Main = function(self)
            self:DetachAll(self.BuildAttachBone)
            self:SetBusy(false)
        end,

        OnStartBuild = function(self, unitBuilding, order)
            CSeaUnit.OnStartBuild(self, unitBuilding, order)
            self.UnitBeingBuilt = unitBuilding
            ChangeState(self, self.BuildingState)
        end,
    },

    BuildingState = State {
        Main = function(self)
            local unitBuilding = self.UnitBeingBuilt
            self:SetBusy(true)
            local bone = self.BuildAttachBone
            self:DetachAll(bone)
            unitBuilding:HideBone(0, true)
            self.UnitDoneBeingBuilt = false
        end,

        OnStopBuild = function(self, unitBeingBuilt)
            CSeaUnit.OnStopBuild(self, unitBeingBuilt)
            ChangeState(self, self.FinishedBuildingState)
        end,
    },

    FinishedBuildingState = State {
        Main = function(self)
            self:SetBusy(true)
            local unitBuilding = self.UnitBeingBuilt
            unitBuilding:DetachFrom(true)
            self:DetachAll(self.BuildAttachBone)
            if self:GetScriptBit('RULEUTC_ProductionToggle') == true and self:TransportHasAvailableStorage() then
                self:AddUnitToStorage(unitBuilding)
            else
                local worldPos = self:CalculateWorldPositionFromRelative({0, 0, -20})
                IssueMoveOffFactory({unitBuilding}, worldPos)
                IssueGuard({unitBuilding}, self)
                unitBuilding:ShowBone(0,true)
            end
            self:SetBusy(false)
            ChangeState(self, self.IdleState)
        end,
    },


}

TypeClass = URS0303

