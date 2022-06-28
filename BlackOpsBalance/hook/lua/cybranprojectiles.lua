#****************************************************************************
#**
#**  File     :  /data/lua/cybranprojectiles.lua
#**  Author(s): John Comes, Gordon Duclos
#**
#**  Summary  : edited Megalith effects
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
do
local BlackOpsEffectTemplate = import('/mods/BlackOpsUnleashed/lua/BlackOpsEffectTemplates.lua')
local CDFHvyProtonOld = CDFHvyProtonCannonProjectile

CDFHvyProtonCannonProjectile = Class(CDFHvyProtonOld) {
    PolyTrails = {
        EffectTemplate.CHvyProtonCannonPolyTrail,
        '/mods/BlackOpsUnleashed/effects/emitters/shadow_bolter_trail_01_emit.bp',
    },

    FxTrails = BlackOpsEffectTemplate.ShadowCannonFXTrail02,
    FxUnitHitScale = 1.5,
    FxPropHitScale = 1.5,
    FxLandHitScale = 1.5,
    FxUnderWarerHitScale = 1.5,
    FxWaterHitScale = 1.5,
}
end