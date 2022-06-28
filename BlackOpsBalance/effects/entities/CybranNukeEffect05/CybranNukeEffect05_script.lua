#****************************************************************************
#**
#**  File     :  /data/projectiles/CybranNukeEffect05/CybranNukeEffect05_script.lua
#**  Author(s):  Matt Vainio
#**
#**  Summary  :  Seraphim experimental nuke effect script, non-damaging
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local EffectTemplate = import('/lua/EffectTemplates.lua')
local BlackOpsBalanceEffectTemplate = import('/mods/BlackOpsBalance/lua/BlackOpsBalanceEffectTemplates.lua')

CybranNukeEffect05 = Class(import('/lua/sim/defaultprojectiles.lua').EmitterProjectile) {
    FxTrails = BlackOpsBalanceEffectTemplate.CybranNukePlumeFxTrails05,
	FxTrailScale = 0.5,
}
TypeClass = CybranNukeEffect05

