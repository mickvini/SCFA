#****************************************************************************
#**
#**  File     :  /hook/lua/UserSync.lua
#**  Author(s):  novaprim3
#**
#**  Summary  :  Multi-Phantom Mod for Forged Alliance
#**
#****************************************************************************
local modPath = 'Phantom-N_1_0'

local baseOnSync = OnSync

function OnSync()
	baseOnSync()
	
	# Sim to UI
	if Sync.PAssignment then
		import('/mods/'..modPath..'/modules/phantom.lua').SetAssignment(Sync.PAssignment)
	end
	if Sync.pData then
		import('/mods/'..modPath..'/modules/phantom.lua').SetPhantomData(Sync.pData)
	end
	if Sync.pStats then
		import('/mods/'..modPath..'/modules/phantom.lua').SetPhantomStats(Sync.pStats)
	end
	if Sync.pEco then
		import('/mods/'..modPath..'/modules/phantom.lua').SetPhantomEco(Sync.pEco)
	end	
	if Sync.pAlert then
		import('/mods/'..modPath..'/modules/phantom.lua').ShowAlert(Sync.pAlert)
	end
	if Sync.pSkin then
		import('/mods/'..modPath..'/modules/phantom.lua').SetLayout()
	end
	if Sync.pVote then
		import('/mods/'..modPath..'/modules/phantom.lua').ShowPhantomVote()
	end
end
