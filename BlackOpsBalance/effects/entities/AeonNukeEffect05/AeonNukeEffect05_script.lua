#****************************************************************************
#**
#**  File     :  /data/projectiles/AeonNukeEffect05/AeonNukeEffect05_script.lua
#**  Author(s):  Matt Vainio
#**
#**  Summary  :  Seraphim experimental nuke effect script, non-damaging
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local EffectTemplate = import('/lua/EffectTemplates.lua')
local BlackOpsBalanceEffectTemplate = import('/mods/BlackOpsBalance/lua/BlackOpsBalanceEffectTemplates.lua')

AeonNukeEffect05 = Class(import('/lua/sim/defaultprojectiles.lua').EmitterProjectile) {
    FxTrails = BlackOpsBalanceEffectTemplate.AeonNukePlumeFxTrails05,
	FxTrailScale = 0.5,
}
TypeClass = AeonNukeEffect05

