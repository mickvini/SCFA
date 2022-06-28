#****************************************************************************
#**
#**  File     :  /data/projectiles/AeonNukeEffect04/AeonNukeEffect04_script.lua
#**  Author(s):  Greg Kohne, Gordon Duclos
#**
#**  Summary  :  Seraphim Experimental Nuke effect script, non-damaging
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local EffectTemplate = import('/lua/EffectTemplates.lua')
local BlackOpsBalanceEffectTemplate = import('/mods/BlackOpsBalance/lua/BlackOpsBalanceEffectTemplates.lua')

AeonNukeEffect04 = Class(import('/lua/sim/defaultprojectiles.lua').EmitterProjectile) {
	FxTrails = BlackOpsBalanceEffectTemplate.AeonNukePlumeFxTrails03,
	FxTrailScale = 0.5,
}
TypeClass = AeonNukeEffect04
