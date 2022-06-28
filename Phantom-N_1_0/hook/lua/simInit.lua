#****************************************************************************
#**
#**  File     :  /hook/lua/simInit.lua
#**  Author(s):  novaprim3
#**
#**  Summary  :  Multi-Phantom Mod for Forged Alliance
#**
#****************************************************************************
local modPath = 'Phantom-N_1_0'

local ParentBeginSession = BeginSession
function BeginSession()
	ParentBeginSession()
	ForkThread(import('/mods/'..modPath..'/lua/PhantomSim.lua').PhantomMainThread)
end
