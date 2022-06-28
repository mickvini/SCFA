--------------------------------------------------------------------------------
--  Summary:  Iyadesu Script
--   Author:  Sean 'Balthazar' Wheeldon
--------------------------------------------------------------------------------
local SConstructionUnit = import('/lua/seraphimunits.lua').SConstructionUnit
local SLandUnit = import('/lua/seraphimunits.lua').SLandUnit
local EffectUtil = import('/lua/EffectUtilities.lua')
local SDFUltraChromaticBeamGenerator = import('/lua/seraphimweapons.lua').SDFUltraChromaticBeamGenerator
local tablefind = table.find -- local this to lower the overhead slightly.
local BrewLANPath = import('/lua/game.lua').BrewLANPath()
local VersionIsFAF = import(BrewLANPath .. "/lua/legacy/versioncheck.lua").VersionIsFAF()

SSL0403 = Class(SConstructionUnit) {
    Weapons = {
        MainTurret = Class(SDFUltraChromaticBeamGenerator) {},
        --[[
        BladeWeapon = Class(SDFUltraChromaticBeamGenerator) {
            CreateProjectileAtMuzzle = function(self, muzzle)
                --LOG("AASDKBASD")
                SDFUltraChromaticBeamGenerator.CreateProjectileAtMuzzle(self, muzzle)
            end,

            --OnFire = function(self)
            --    SDFUltraChromaticBeamGenerator.OnFire(self)
            --    LOG("OnFire")
            --end,

            IdleState = State {

                OnFire = function(self)
                    SDFUltraChromaticBeamGenerator.IdleState.OnFire(self)

                    LOG("idle")
                        --SDFUltraChromaticBeamGenerator.IdleState.OnFire(self)
                    if not self.AttackAnim then
                        self.AttackAnim = CreateAnimator(self.unit)
                    end
                    self.AttackAnim:PlayAnim( self:GetBlueprint().WeaponAttackAnimation[1].Animation )
                    self.unit.Trash:Add( self.AttackAnim )
                end,
                    --Main = function(self)
                    --    LOG("main")
                    --    SDFUltraChromaticBeamGenerator.IdleState.Main(self)
                    --end,
            },

            RackSalvoFireReadyState = State {

                OnFire = function(self)
                    SDFUltraChromaticBeamGenerator.RackSalvoFireReadyState.OnFire(self)
                    LOG("FIRE READ")
                        --SDFUltraChromaticBeamGenerator.IdleState.OnFire(self)
                    if not self.AttackAnim then
                        self.AttackAnim = CreateAnimator(self.unit)
                    end
                    self.AttackAnim:PlayAnim( self:GetBlueprint().WeaponAttackAnimation[1].Animation )
                    self.unit.Trash:Add( self.AttackAnim )
                end,
            },
        },]]
    },

    OnCreate = function(self)
        SConstructionUnit.OnCreate(self)
        self:CreateIdleEffects()
        self.Pods = { }
        local pod = {
            PodAttachpoint = 'AttachSpecial0',
            PodName = 'Pod',
            PodUnitID = 'SSA0001',
            Entity = {},
            Active = false,
        }
        for i = 1, 8 do
            self.Pods[i] = {}
            for k, v in pod do
                if k == "PodAttachpoint" or k == "PodName" then
                    self.Pods[i][k] = v .. tostring(i)
                else
                    self.Pods[i][k] = v
                end
            end
        end
    end,

    OnStopBeingBuilt = function(self, ...)
        SConstructionUnit.OnStopBeingBuilt(self, unpack(arg) )
        self:MoveArms(0)
    end,

    StartBeingBuiltEffects = function(self, builder, layer)
        SConstructionUnit.StartBeingBuiltEffects(self, builder, layer)
        self:ForkThread( EffectUtil.CreateSeraphimExperimentalBuildBaseThread, builder, self.OnBeingBuiltEffectsBag )
    end,

    OnStartReclaim = function(self, target)
        local TargetId = target.AssociatedBP or target:GetBlueprint().BlueprintId
        if TargetId and not string.find(TargetId, "/") then
            self.ReclaimID = {id = TargetId}
        end
        self:MoveArms()
        SConstructionUnit.OnStartReclaim(self, target)
    end,

    OnStopReclaim = function(self, target)
        if not target and self.ReclaimID.id then
            self:CreatePod(self.ReclaimID.id)
        end
        self.ReclaimID = {}
        self:MoveArms(0)
        SConstructionUnit.OnStopReclaim(self, target)
    end,

    OnStartBuild = function(self, unitBeingBuilt, order)
        SConstructionUnit.OnStartBuild(self, unitBeingBuilt, order)
        self:MoveArms(100)
    end,

    OnStopBuild = function(self)
        SConstructionUnit.OnStopBuild(self)
        self:MoveArms(0)
    end,

    OnProductionPaused = function(self)
        self:MoveArms(0)
        SConstructionUnit.OnProductionPaused(self)
    end,

    OnProductionUnpaused = function(self)
        self:MoveArms(100)
        SConstructionUnit.OnProductionUnpaused(self)
    end,

    MoveArms = function(self, num)
        if self.SARotators then
            for i = 1, 6 do
                self.SARotators[i]:SetGoal(- (num or 100) + math.random(0,30))
            end
        else
            self.SARotators = {}
            for i = 1, 6 do
                self.SARotators[i] = CreateRotator(self, 'Small_Blade_00' .. i, 'x', - (num or 100) + math.random(0,30), 300, 100)
            end
        end
    end,


    NotifyOfPodDeath = function(self, pod)
        self.Pods[pod].Active = false
        self.Pods[pod].StorageID = nil
        self:RefreshBuildRestrictions()
    end,


    OnMotionHorzEventChange = function( self, new, old )
        SConstructionUnit.OnMotionHorzEventChange(self, new, old)

        if ( old == 'Stopped' ) then
            if (not self.Animator) then
                self.Animator = CreateAnimator(self, true)
            end
            local bpDisplay = self:GetBlueprint().Display
            if bpDisplay.AnimationWalk then
                self.Animator:PlayAnim(bpDisplay.AnimationWalk, true)
                self.Animator:SetRate(bpDisplay.AnimationWalkRate or 1)
            end
        elseif ( new == 'Stopped' ) then
            -- only keep the animator around if we are dying and playing a death anim
            -- or if we have an idle anim
            if(self.IdleAnim and not self.Dead) then
                self.Animator:PlayAnim(self.IdleAnim, true)
            elseif(not self.DeathAnim or not self.Dead) then
                self.Animator:Destroy()
                self.Animator = false
            end
        end
    end,
}

TypeClass = SSL0403
