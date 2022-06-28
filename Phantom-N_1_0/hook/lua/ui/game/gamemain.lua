#****************************************************************************
#**
#**  File     :  /hook/lua/ui/game/gamemain.lua
#**  Author(s):  novaprim3
#**
#**  Summary  :  Multi-Phantom Mod for Forged Alliance
#**
#****************************************************************************
local modPath = 'Phantom-N_1_0'

local baseCreateUI = CreateUI 

function CreateUI(isReplay) 
	baseCreateUI(isReplay) 
	
  	if not isReplay then
		local parent = import('/lua/ui/game/borders.lua').GetMapGroup()
		import('/mods/'..modPath..'/modules/phantom.lua').CreateModUI(isReplay, parent)
	end
end
