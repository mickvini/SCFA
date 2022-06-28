#****************************************************************************
#**
#**  File     :  /data/projectiles/AeonNukeEffect06/AeonNukeEffect06_script.lua
#**  Author(s):  Matt Vainio
#**
#**  Summary  :  Seraphim experimental nuke effect script, non-damaging
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local EffectTemplate = import('/lua/EffectTemplates.lua')
local BlackOpsBalanceEffectTemplate = import('/mods/BlackOpsBalance/lua/BlackOpsBalanceEffectTemplates.lua')

AeonNukeEffect06 = Class(import('/lua/sim/defaultprojectiles.lua').EmitterProjectile) {
    FxTrails = BlackOpsBalanceEffectTemplate.AeonNukePlumeFxTrails06,
	FxTrailScale = 0.7,
}
TypeClass = AeonNukeEffect06

