--modblueprints hook - non-destructive category manipulation for blackops unleashed units

do
	local oldModBlueprints = ModBlueprints

	function ModBlueprints(all_bps)
		oldModBlueprints(all_bps)
			--Removing this function
		--[[
		--Allow Quantum Gates to build all engineers and land units
		local quantumgate_buildablecategories = {
			uab0304 = {
				'BUILTBYTIER3FACTORY AEON MOBILE CONSTRUCTION',
				'BUILTBYTIER3FACTORY AEON MOBILE LAND',
			},
			ueb0304 = {
				'BUILTBYTIER3FACTORY UEF MOBILE CONSTRUCTION',
				'BUILTBYTIER3FACTORY UEF MOBILE LAND',
			},
			urb0304 = {
				'BUILTBYTIER3FACTORY CYBRAN MOBILE CONSTRUCTION',
				'BUILTBYTIER3FACTORY CYBRAN MOBILE LAND',
			},
			xsb0304 = {
				'BUILTBYTIER3FACTORY SERAPHIM MOBILE CONSTRUCTION',
				'BUILTBYTIER3FACTORY SERAPHIM MOBILE LAND',
			},
		}
		for gateid, buildcats in quantumgate_buildablecategories do
			if all_bps.Unit[gateid] then
				--Enable assist for land factory interopability
				all_bps.Unit[gateid].General.CommandCaps.RULEUCC_Guard = true
				--Land unit buildable categories
				for k, buildcat in buildcats do
					table.insert(all_bps.Unit[gateid].Economy.BuildableCategory, buildcat)
				end
			end
		end
		]]--
		--Add T4 categories to T3 engineers, to be removed in OnCreate for human players
		if all_bps.Unit.xsl0309 then
			table.insert(all_bps.Unit.xsl0309.Economy.BuildableCategory, 'BUILTBYTIER4COMMANDER SERAPHIM')
		end
		if all_bps.Unit.url0309 then
			table.insert(all_bps.Unit.url0309.Economy.BuildableCategory, 'BUILTBYTIER4COMMANDER CYBRAN')
		end
		if all_bps.Unit.ual0105 then
			table.insert(all_bps.Unit.ual0105.Economy.BuildableCategory, 'BUILTBYTIER4COMMANDER AEON')
		end		
		if all_bps.Unit.ual0208 then
			table.insert(all_bps.Unit.ual0208.Economy.BuildableCategory, 'BUILTBYTIER4COMMANDER AEON')
		end
		if all_bps.Unit.ual0309 then
			table.insert(all_bps.Unit.ual0309.Economy.BuildableCategory, 'BUILTBYTIER4COMMANDER AEON')
		end		
		if all_bps.Unit.uel0309 then
			table.insert(all_bps.Unit.uel0309.Economy.BuildableCategory, 'BUILTBYTIER4COMMANDER UEF')
		end

		--Limit heavy experimental construction to SCU/T4 only
		local experimental_t4 = {


		}
		for k, unitid in experimental_t4 do
			if all_bps.Unit[unitid] then
				table.insert(all_bps.Unit[unitid].Categories, 'BUILTBYTIER4COMMANDER')
				table.removeByValue(all_bps.Unit[unitid].Categories, 'BUILTBYTIER3COMMANDER')
				table.removeByValue(all_bps.Unit[unitid].Categories, 'BUILTBYTIER3ENGINEER')	
				table.removeByValue(all_bps.Unit[unitid].Categories, 'BUILTBYTIER2COMMANDER')
				table.removeByValue(all_bps.Unit[unitid].Categories, 'BUILTBYTIER2ENGINEER')
				table.removeByValue(all_bps.Unit[unitid].Categories, 'BUILTBYTIER1COMMANDER')
				table.removeByValue(all_bps.Unit[unitid].Categories, 'BUILTBYTIER1ENGINEER')				
			end		
		end


		--Add T4 engineering category to SCUs
		local units_SCU = {
			ual0301 = 'BUILTBYTIER4COMMANDER AEON',
			uel0301 = 'BUILTBYTIER4COMMANDER UEF',
			url0301 = 'BUILTBYTIER4COMMANDER CYBRAN',
			xsl0301 = 'BUILTBYTIER4COMMANDER SERAPHIM',
		}
		for scuid, buildcat in units_SCU do
			if all_bps.Unit[scuid] then
				table.insert(all_bps.Unit[scuid].Economy.BuildableCategory, buildcat)
			end
		end

		
		--Allow Tempest to construct hover units
		if all_bps.Unit.uas0401 then
			table.insert(all_bps.Unit.uas0401.Economy.BuildableCategory, 'BUILTBYTIER3FACTORY AEON MOBILE HOVER')
		end
		
		
		--Add wobble to hover units
		for unitid, unitbp in all_bps.Unit do
			for k, cat in unitbp.Categories do
				if cat == 'HOVER' then
					unitbp.Physics.WobbleFactor = 0.02
					unitbp.Physics.WobbleSpeed = 0.01
				end
			end
		end
			
	end --ModBlueprints

end

