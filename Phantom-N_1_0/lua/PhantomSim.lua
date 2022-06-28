#****************************************************************************
#**
#**  File     :  /lua/PhantomSim.lua
#**  Author(s):  novaprim3
#**
#**  Summary  :  Multi-Phantom Mod for Forged Alliance
#**
#****************************************************************************
local modPath = 'Phantom-N_1_0'

local cur = {
	innocents = {},
	phantoms = {},
	delta = { mass = {}, energy = {} }, 
	phantom_war = false,
	trash = nil,
	config = {
		vote = 7 * 60,
		declare = 8 * 60,
		phantom_coefficient = 1/3, 
		phantom_economy = {}
	},
	phantom_bonus = { mass = 0, energy = 0 },
	stats = {
		phantom_count = 0,
		innocent_count = 0,
		phantoms_dead = 0,
		innocents_dead = 0
	},
	votes = {}
}


function PhantomMainThread()
	cur.config.phantom_economy[0] = { ally = 0.00, mix = 0.00, enemy = 0.00, phantom_war = 1.0, vampire = 0.0 }
	cur.config.phantom_economy[1] = { ally = 0.20, mix = 0.25, enemy = 0.30, phantom_war = 1.0, vampire = 0.0 }
	cur.config.phantom_economy[2] = { ally = 0.10, mix = 0.15, enemy = 0.20, phantom_war = 1.2, vampire = 0.5 }
	cur.config.phantom_economy[3] = { ally = 0.08, mix = 0.10, enemy = 0.15, phantom_war = 1.1, vampire = 0.4 }
	cur.votes[1] = 0
	cur.votes[2] = 0
	cur.votes[3] = 0

	cur.trash = TrashBag()

	import('/lua/SimPlayerQuery.lua').AddQueryListener("PhantomDumpResources", dumpResources)
	import('/lua/SimPlayerQuery.lua').AddQueryListener("PhantomVote", vote)

	Sync.pSkin = true
	
	for army1, brain1 in ArmyBrains do
		if ArmyIsCivilian(army1) == false and ArmyIsOutOfGame(army1) == false then
			SetAlliedVictory(army1, false)
			brain1:SetResourceSharing(false)
			brain1.CalculateScore = PhantomCalculateScore
			for army2, brain2 in ArmyBrains do
				if ArmyIsCivilian(army2) == false and ArmyIsOutOfGame(army2) == false and army1 != army2 then
					SetAlliance(army1, army2, 'Ally')
				end
			end
		end
	end
	
	Sync.PAssignment = "Phantom Assignment Pending"
	WaitSeconds(cur.config.vote)
	Sync.pVote = true
	WaitSeconds(cur.config.declare - cur.config.vote)

	# Move all elegiable players to the innocents table
	for army, brain in ArmyBrains do
		if ArmyIsCivilian(army) == false and ArmyIsOutOfGame(army) == false then
			table.insert(cur.innocents, army)
		end
	end
	
	# Count innocents and determine how many we will move to the phantom table
	# Check votes for a phantom count, this should select the lower of two even votes
	local voteMax = 0
	local voteIndex = 0
	for key, val in cur.votes do
		if val > voteMax then
			voteMax = val
			voteIndex = key
		end
	end
	if voteIndex > 0 then
		cur.stats.phantom_count = voteIndex
		if cur.stats.phantom_count >= table.getn(cur.innocents) then
			cur.stats.phantom_count = table.getn(cur.innocents) - 1
		end
		
	else
		cur.stats.phantom_count = math.ceil(table.getn(cur.innocents) * cur.config.phantom_coefficient)
	end
	cur.stats.innocent_count = table.getn(cur.innocents) - cur.stats.phantom_count
		
	# Move a few innocents over to phantoms
	local try = 0
	for i=1,cur.stats.phantom_count do
		# This is pretty messy, but I couldn't get table.remove working the way I wanted it to
		local ok = false
		local p = 0
		repeat
			ok = true
			p = math.random(table.getn(cur.innocents))
			for index, army in cur.phantoms do
				if cur.innocents[p] == army then
					ok = false
				end
			end
		until ok == true
		table.insert(cur.phantoms, cur.innocents[p])
		# Disable resource sharing for phantoms (in-case anyone reenabled it)
		ArmyBrains[cur.innocents[p]]:SetResourceSharing(false)
	end
	
	# Remove phantoms from the innocents table
	for i=1,table.getn(cur.innocents) do
		for index, army in cur.phantoms do
			if cur.innocents[i] == army then
				cur.innocents[i] = nil
			end
		end
	end
	
	# Prepare data to send to the UI
	pData = {
		phantom_armies = {}, 
		innocent_armies = {}, 
		isPhantom = false
	}
	if IsPhantom(GetFocusArmy()) then
		Sync.pAlert = { "Designation: PHANTOM", "Kill Everyone" }
		Sync.PAssignment = "Phantom"
		pData.isPhantom = true
		
	else
		Sync.pAlert = { "Designation: INNOCENT", "Kill All Phantoms" }
		Sync.PAssignment = "Innocent"
		pData.isPhantom = false
	end
	
	pData.phantom_armies = cur.phantoms
	pData.innocent_armies = cur.innocents
	Sync.pData = pData
	
	# Fire up the eco thread
	cur.trash:Add(ForkThread(PhantomResourceThread))
	
	# Main loop
	local end_game = false
	local stats_changed = true
	while end_game == false do
		WaitSeconds(0.1)

		local innocents_dead = 0
		local phantoms_dead = 0
		for index, army in cur.phantoms do
			if ArmyIsOutOfGame(army) then
				phantoms_dead = phantoms_dead + 1
			end
		end
		for index, army in cur.innocents do
			if ArmyIsOutOfGame(army) then
				innocents_dead = innocents_dead + 1
			end
		end
		
		# Phantom killed
		if phantoms_dead > cur.stats.phantoms_dead then
			local remain = cur.stats.phantom_count - phantoms_dead
			local txt = remain
			if remain > 1 then
				txt = txt .. " phantoms remain"
			else
				if remain == 0 then
					txt = "All phantoms killed"
				else
					txt = txt .. " phantom remains"
				end
			end
			WaitSeconds(2)
			Sync.pAlert = { "Phantom Assassinated", txt }
			WaitSeconds(2)
			stats_changed = true
		end

		# Innocent killed
		if innocents_dead > cur.stats.innocents_dead then
			local remain = cur.stats.innocent_count - innocents_dead
			local txt = remain
			if remain > 1 then
				txt = txt .. " innocents remain"
			else
				if remain == 0 then
					txt = "All innocents killed"
				else
					txt = txt .. " innocent remains"
				end
			end
			WaitSeconds(2)
			Sync.pAlert = { "Innocent Assassinated", txt }
			WaitSeconds(2)
			stats_changed = true
			
			# All innocents are dead, multiple phantoms alive - pitch them at each other
			local pAlive = cur.stats.phantom_count - phantoms_dead
			if innocents_dead == cur.stats.innocent_count and pAlive > 1 then
				Sync.pAlert = { "Phantom War", "Vampire rules now in effect" }
				cur.phantom_war = true
				# All phantoms declare war
				for index1, army1 in cur.phantoms do
					SetAlliedVictory(army1, false)
					for index2, army2 in cur.phantoms do
						if ArmyIsOutOfGame(army1) == false and ArmyIsOutOfGame(army2) == false and army1 != army2 then
							SetAlliance(army1, army2, 'Enemy')
						end
					end
				end
			end

		end
		
		cur.stats.phantoms_dead = phantoms_dead
		cur.stats.innocents_dead = innocents_dead
		
		# Send stats to the UI
		if stats_changed then
			stats_changed = false
			Sync.pStats = cur.stats
		end
				
		# All phantoms dead (innocent victory)
		if cur.stats.innocents_dead < cur.stats.innocent_count and cur.stats.phantoms_dead == cur.stats.phantom_count then
			Sync.pAlert = { "Innocents Win", false }
			# Ally all innocents and set allied victory to true
			for index1, army1 in cur.innocents do
				SetAlliedVictory(army1, true)
				for index2, army2 in cur.innocents do
					if ArmyIsOutOfGame(army1) == false and ArmyIsOutOfGame(army2) == false and army1 != army2 then
						SetAlliance(army1, army2, 'Ally')
					end
				end
			end
			end_game = true
		end

		# One phantom remains (phantom victory)
		local pAlive = cur.stats.phantom_count - cur.stats.phantoms_dead
		if cur.stats.innocents_dead == cur.stats.innocent_count and pAlive == 1 then
			# not really much to do here, only one man alive
			Sync.pAlert = { "Phantom Victory", false }
			end_game = true
		end
		
		# Everyone fails
		if cur.stats.innocents_dead == cur.stats.innocent_count and cur.stats.phantoms_dead == cur.stats.phantom_count then
			Sync.pAlert = { "Nobody Wins", false }
			end_game = true
		end
		
	end
	cur.trash:Destroy()
end

# This function changes the way the score works
function PhantomCalculateScore(self)
	local massValueDestroyed = self:GetArmyStat("Enemies_MassValue_Destroyed",0.0).Value
	local massValueLost = self:GetArmyStat("Units_MassValue_Lost",0.0).Value
	local energyValueDestroyed = self:GetArmyStat("Enemies_EnergyValue_Destroyed",0.0).Value
	local energyValueLost = self:GetArmyStat("Units_EnergyValue_Lost",0.0).Value

	local energyValueCoefficient = 0.02
	return math.floor((massValueDestroyed - massValueLost) + (energyValueDestroyed - energyValueLost) * energyValueCoefficient)
end

# This functions gives the resource bonus to the phantom
function PhantomResourceThread()
	pEco = {
		mass = 0,
		energy = 0
	}
	while true do
		WaitSeconds(0.1)
		
		if cur.phantom_war == false then
			###########################################################
			# Normal Conditions, phantoms get bonus as per normal
			###########################################################
			
			# Work out innocents combined incomes
			local mass = 0
			local energy = 0
			for index, army in cur.innocents do
				if ArmyIsOutOfGame(army) == false then
					brain = ArmyBrains[army]
					mass = mass + brain:GetEconomyIncome('MASS')
					energy = energy + brain:GetEconomyIncome('ENERGY')
				end
			end

			# What alliance status do we have, all allied, mixed or all out war?
			local allied = false
			local enemy = false
			for pindex, parmy in cur.phantoms do
				if ArmyIsOutOfGame(parmy) == false then
					for iindex, iarmy in cur.innocents do
						if IsAlly(parmy, iarmy) then
							allied = true
						else
							enemy = true
						end
					end
				end
			end

			local bonus = 0
			# All phantoms allied with all innocents
			if allied == true and enemy == false then
				bonus = cur.config.phantom_economy[cur.stats.phantom_count].ally
			end

			# Mixed alliances
			if allied == true and enemy == true then
				bonus = cur.config.phantom_economy[cur.stats.phantom_count].mix
			end

			# All out war, max bonus
			if allied == false and enemy == true then
				bonus = cur.config.phantom_economy[cur.stats.phantom_count].enemy
			end

			# Give bonus to phantoms
			for index1, army1 in cur.phantoms do
				if ArmyIsOutOfGame(army1) == false then
					local phantom_war = false
					for index2, army2 in cur.phantoms do
						if ArmyIsOutOfGame(army2) == false and army1 != army2 and IsAlly(army1, army2) == false and allied == true then
							phantom_war = true
							break
						end
					end
					local player_coeffiecient = bonus
					if phantom_war then
						player_coeffiecient = player_coeffiecient * cur.config.phantom_economy[cur.stats.phantom_count].phantom_war
					end
					player_mass = mass * player_coeffiecient
					player_energy = energy * player_coeffiecient

					brain = ArmyBrains[army1]
					brain:GiveResource('MASS', player_mass)
					brain:GiveResource('ENERGY', player_energy)

					if army1 == GetFocusArmy() then
						# Sync with UI
						pEco.mass = math.ceil(player_mass * 10)
						pEco.energy = math.ceil(player_energy * 10)
						Sync.pEco = pEco
					end
				end
			end
		else
			###########################################################
			# Phantom War (Vampire) conditions (only phantoms remain)
			###########################################################
			for index, army in cur.phantoms do
				if ArmyIsOutOfGame(army) == false then
					brain = ArmyBrains[army]
					local mass = brain:GetArmyStat("Enemies_MassValue_Destroyed",0.0).Value
					local energy = brain:GetArmyStat("Enemies_EnergyValue_Destroyed",0.0).Value
					if cur.delta.mass[army] > 0 then
						local deltaMass = (mass - cur.delta.mass[army]) * cur.config.phantom_economy[cur.stats.phantom_count].vampire
						local deltaEnergy = (energy - cur.delta.energy[army]) * cur.config.phantom_economy[cur.stats.phantom_count].vampire
						
						brain:GiveResource('MASS', deltaMass)
						brain:GiveResource('ENERGY', deltaEnergy)

						if army == GetFocusArmy() then
							# Sync with UI
							pEco.mass = math.ceil(deltaMass)
							pEco.energy = math.ceil(deltaEnergy)
							Sync.pEco = pEco
						end
					end
					cur.delta.mass[army] = mass
					cur.delta.energy[army] = energy
				end
			end
		end
	end
end

# Determines if an army is a phantom
function IsPhantom(army)
	if table.getn(cur.phantoms) == 0 then
		return false
	else
		for index, p in cur.phantoms do
			if p == army then
				return true
			end
		end
		return false
	end
end

# Dump Resources (from UI)
function dumpResources(data)
	brain = ArmyBrains[data.From]
	brain:TakeResource(data.Args, math.floor(brain:GetEconomyStored(data.Args) * 0.9))	
end

# Vote (from UI)
function vote(data)
	cur.votes[data.Args.Vote] = cur.votes[data.Args.Vote] + 1
	if data.Args.Vote == 1 then
		print(data.Args.Nick.." voted for a single phantom")
	else
		print(data.Args.Nick.." voted for "..data.Args.Vote.." phantoms")
	end
end