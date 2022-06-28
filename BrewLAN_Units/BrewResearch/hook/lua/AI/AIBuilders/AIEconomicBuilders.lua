BuilderGroup {
    BuilderGroupName = 'EngineerResearchBuilders',
    BuildersType = 'EngineerBuilder',

    Builder {
        BuilderName = 'Engineer Research',
        PlatoonTemplate = 'EngineerBuilder',
        Priority = 1000,
        BuilderConditions = {
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2} },
            { IBC, 'BrainNotLowPowerMode', {} },
            { UCBC, 'UnitCapCheckLess', { .85 } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.RESEARCHCENTRE } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.RESEARCHCENTRE } },
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1ResearchCentre',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'CDR Research',
        PlatoonTemplate = 'CommanderBuilder',
        Priority = 990,
        BuilderConditions = {
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2} },
            { IBC, 'BrainNotLowPowerMode', {} },
            { UCBC, 'UnitCapCheckLess', { .85 } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.RESEARCHCENTRE } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.RESEARCHCENTRE } },
        },
        BuilderType = 'Any',
        PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1ResearchCentre',
                },
                Location = 'LocationType',
            }
        }
    }
}
