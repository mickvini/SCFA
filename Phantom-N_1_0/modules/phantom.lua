#****************************************************************************
#**
#**  File     :  /modules/phantom.lua
#**  Author(s):  novaprim3
#**
#**  Summary  :  Multi-Phantom Mod for Forged Alliance
#**
#****************************************************************************
local modPath = 'Phantom-N_1_0'

local UIUtil = import('/lua/ui/uiutil.lua')
local LayoutHelpers = import('/lua/maui/layouthelpers.lua')
local Group = import('/lua/maui/group.lua').Group
local Bitmap = import('/lua/maui/bitmap.lua').Bitmap
local Button = import('/lua/maui/button.lua').Button
local Checkbox = import('/lua/maui/checkbox.lua').Checkbox
local StatusBar = import('/lua/maui/statusbar.lua').StatusBar
local GameMain = import('/lua/ui/game/gamemain.lua')
local Tooltip = import('/lua/ui/game/tooltip.lua')
local Prefs = import('/lua/user/prefs.lua')
local Tooltip = import('/lua/ui/game/tooltip.lua')

local declare = 8 * 60
local voteDialog = nil

pUI = {
	arrow = false,
	box = false
}

pData = {
	phantom_armies = {},
	innocent_armies = {},
	isPhantom = false
}

pStats = {
	phantom_count = 0,
	innocent_count = 0,
	phantoms_dead = 0,
	innocents_dead = 0
}

parent = false
function CreateModUI(isReplay, _parent)
	parent = _parent
	
	BuildUI()
	SetLayout()
	CommonLogic()
end

function BuildUI()
	# Create arrow checkbox
	pUI.arrow = Checkbox(parent)

	# Create group for main UI
	pUI.box = Group(parent)
	
	# Create main UI objects
	pUI.box.panel = Bitmap(pUI.box)
	pUI.box.leftBracket = Bitmap(pUI.box)
	pUI.box.leftBracketGlow = Bitmap(pUI.box)

	pUI.box.rightGlowTop = Bitmap(pUI.box)
	pUI.box.rightGlowMiddle = Bitmap(pUI.box)
	pUI.box.rightGlowBottom = Bitmap(pUI.box)
	
	pUI.box.title = UIUtil.CreateText(pUI.box, '', 18, UIUtil.bodyFont)
	pUI.box.title:SetDropShadow(true)
	pUI.box.countdown = UIUtil.CreateText(pUI.box, '', 14, UIUtil.bodyFont)
	pUI.box.countdown:SetDropShadow(true)
	
        pUI.box.mass = UIUtil.CreateText(pUI.box, '+0', 10, UIUtil.bodyFont)
        pUI.box.mass:SetDropShadow(true)
        pUI.box.energy = UIUtil.CreateText(pUI.box, '+0', 10, UIUtil.bodyFont)
        pUI.box.energy:SetDropShadow(true)

        pUI.box.kills = UIUtil.CreateText(pUI.box, '0/0', 14, UIUtil.bodyFont)
        pUI.box.kills:SetDropShadow(true)
        
        pUI.box.killIcon = Bitmap(pUI.box)
        
	pUI.box.massBtn = Button(pUI.box,
		UIUtil.SkinnableFile('/mods/'..modPath..'/textures/resources/mass_btn_up_ph.dds'),
		UIUtil.SkinnableFile('/mods/'..modPath..'/textures/resources/mass_btn_down_ph.dds'),
		UIUtil.SkinnableFile('/mods/'..modPath..'/textures/resources/mass_btn_over_ph.dds'),
		UIUtil.SkinnableFile('/mods/'..modPath..'/textures/resources/mass_btn_dis_ph.dds'), 
		'', '')
	#Tooltip.AddButtonTooltip(pUI.box.massBtn, Tooltip.CreateExtendedToolTip(pUI.box.massBtn, 'Dump Mass', 'Dumps 90% of your mass reserve to prevent looking suspicious'))

	pUI.box.energyBtn = Button(pUI.box,
		UIUtil.SkinnableFile('/mods/'..modPath..'/textures/resources/energy_btn_up_ph.dds'),
		UIUtil.SkinnableFile('/mods/'..modPath..'/textures/resources/energy_btn_down_ph.dds'),
		UIUtil.SkinnableFile('/mods/'..modPath..'/textures/resources/energy_btn_over_ph.dds'),
		UIUtil.SkinnableFile('/mods/'..modPath..'/textures/resources/energy_btn_dis_ph.dds'), 
		'', '')		
end

function SetLayout()
	# Assign layout info to arrow checkbox
	pUI.arrow:SetTexture(UIUtil.UIFile('/game/tab-l-btn/tab-close_btn_up.dds'))
	pUI.arrow:SetNewTextures(UIUtil.UIFile('/game/tab-l-btn/tab-close_btn_up.dds'),
		UIUtil.UIFile('/game/tab-l-btn/tab-open_btn_up.dds'),
		UIUtil.UIFile('/game/tab-l-btn/tab-close_btn_over.dds'),
		UIUtil.UIFile('/game/tab-l-btn/tab-open_btn_over.dds'),
		UIUtil.UIFile('/game/tab-l-btn/tab-close_btn_dis.dds'),
		UIUtil.UIFile('/game/tab-l-btn/tab-open_btn_dis.dds'))
		
	LayoutHelpers.AtLeftTopIn(pUI.arrow, GetFrame(0), -3, 172)
	pUI.arrow.Depth:Set(function() return pUI.box.Depth() + 10 end)

	# Assign layout info to main UI
	pUI.box.panel:SetTexture(UIUtil.UIFile('/game/resource-panel/resources_panel_bmp.dds'))
	LayoutHelpers.AtLeftTopIn(pUI.box.panel, pUI.box)

	pUI.box.Height:Set(pUI.box.panel.Height)
	pUI.box.Width:Set(pUI.box.panel.Width)
	LayoutHelpers.AtLeftTopIn(pUI.box, parent, 16, 153)
	
	pUI.box:DisableHitTest()

	pUI.box.leftBracket:SetTexture(UIUtil.UIFile('/game/filter-ping-panel/bracket-left_bmp.dds'))
	pUI.box.leftBracketGlow:SetTexture(UIUtil.UIFile('/game/filter-ping-panel/bracket-energy-l_bmp.dds'))

	pUI.box.leftBracket.Right:Set(function() return pUI.box.panel.Left() + 10 end)
	pUI.box.leftBracketGlow.Left:Set(function() return pUI.box.leftBracket.Left() + 12 end)

	pUI.box.leftBracket.Depth:Set(pUI.box.panel.Depth)
	pUI.box.leftBracketGlow.Depth:Set(function() return pUI.box.leftBracket.Depth() - 1 end)

	LayoutHelpers.AtVerticalCenterIn(pUI.box.leftBracket, pUI.box.panel)
	LayoutHelpers.AtVerticalCenterIn(pUI.box.leftBracketGlow, pUI.box.panel)

	pUI.box.rightGlowTop:SetTexture(UIUtil.UIFile('/game/bracket-right-energy/bracket_bmp_t.dds'))
	pUI.box.rightGlowMiddle:SetTexture(UIUtil.UIFile('/game/bracket-right-energy/bracket_bmp_m.dds'))
	pUI.box.rightGlowBottom:SetTexture(UIUtil.UIFile('/game/bracket-right-energy/bracket_bmp_b.dds'))

	pUI.box.rightGlowTop.Top:Set(function() return pUI.box.Top() + 2 end)
	pUI.box.rightGlowTop.Left:Set(function() return pUI.box.Right() - 12 end)
	pUI.box.rightGlowBottom.Bottom:Set(function() return pUI.box.Bottom() - 2 end)
	pUI.box.rightGlowBottom.Left:Set(pUI.box.rightGlowTop.Left)
	pUI.box.rightGlowMiddle.Top:Set(pUI.box.rightGlowTop.Bottom)
	pUI.box.rightGlowMiddle.Bottom:Set(function() return math.max(pUI.box.rightGlowTop.Bottom(), pUI.box.rightGlowBottom.Top()) end)
	pUI.box.rightGlowMiddle.Right:Set(function() return pUI.box.rightGlowTop.Right() end)

	LayoutHelpers.AtLeftTopIn(pUI.box.title, pUI.box, 15, 10)
	pUI.box.title:SetColor('ffb7e75f')

	LayoutHelpers.AtLeftTopIn(pUI.box.countdown, pUI.box, 15, 41)
	pUI.box.countdown:SetColor('ffb7e75f')		
	
	
	# Phantom Special Options
	# Mass
	LayoutHelpers.AtTopIn(pUI.box.mass, pUI.box, 10)
	LayoutHelpers.AtRightIn(pUI.box.mass, pUI.box, 20)
	pUI.box.mass:SetColor('ffb7e75f')
	pUI.box.mass:Hide()

	# Energy
	LayoutHelpers.AtTopIn(pUI.box.energy, pUI.box, 22)
	LayoutHelpers.AtRightIn(pUI.box.energy, pUI.box, 20)
	pUI.box.energy:SetColor('fff7c70f')
	pUI.box.energy:Hide()

	# Kills
	LayoutHelpers.AtTopIn(pUI.box.kills, pUI.box, 14)
	LayoutHelpers.AtRightIn(pUI.box.kills, pUI.box, 50)
	pUI.box.kills:SetColor('fff30017')
	pUI.box.kills:Hide()

	pUI.box.killIcon:SetTexture(UIUtil.UIFile('/game/unit-over/icon-skull_bmp.dds'))
	LayoutHelpers.AtTopIn(pUI.box.killIcon, pUI.box, 11)
	LayoutHelpers.AtRightIn(pUI.box.killIcon, pUI.box, 70)
	pUI.box.killIcon:Hide()

	# Buttons
	pUI.box.massBtn.Width:Set(36)
	pUI.box.massBtn.Height:Set(36)
	LayoutHelpers.AtLeftTopIn(pUI.box.massBtn, pUI.box, 235, 32)
	pUI.box.massBtn.Depth:Set(function() return pUI.box.Depth() + 10 end)
	pUI.box.massBtn:Hide()
	
	pUI.box.energyBtn.Width:Set(36)
	pUI.box.energyBtn.Height:Set(36)
	LayoutHelpers.AtLeftTopIn(pUI.box.energyBtn, pUI.box, 271, 32)
	pUI.box.energyBtn.Depth:Set(function() return pUI.box.Depth() + 10 end)
	pUI.box.energyBtn:Hide()
	
	# Hide panel
	pUI.box:Hide()
	ShowHidePhantomElements(false)
	pUI.arrow:SetCheck(true, true)
	pUI.box.Left:Set(parent.Left()-pUI.box.Width())

end

function CommonLogic()
	# Add heartbeat
	GameMain.AddBeatFunction(PhantomUIBeat)
	GameMain.AddBeatFunction(InitPhantomPanel)
	
	pUI.box.OnDestroy = function(self)
		GameMain.RemoveBeatFunction(PhantomUIBeat)
	end

	# Button Actions
	pUI.arrow.OnCheck = function(self, checked)
		TogglePhantomPanel()
	end

	pUI.box.massBtn.OnClick = function(self, checked)
		pMassBtnClick()
	end

	pUI.box.energyBtn.OnClick = function(self, checked)
		pEnergyBtnClick()
	end	
end

function PhantomUIBeat()
	phantomSeconds = declare
	if table.getn(pData.phantom_armies) == 0 then
		timeLeft = phantomSeconds - GetGameTimeSeconds()
		if timeLeft < 0 then timeLeft = 0 end
		pUI.box.countdown:SetText(string.format("Time until assignment:  %02d:%02d", math.floor(timeLeft / 60), math.mod(timeLeft, 60)))
	end
end

function SetAssignment(assignment)
	pUI.box.title:SetText(assignment)
end

function SetPhantomData(data)
	if voteDialog then
		voteDialog:Destroy()
		voteDialog = nil
	end

	pData.isPhantom = data.isPhantom
	pData.phantom_armies = data.phantom_armies
	pData.innocent_armies = data.innocent_armies
	
	ShowHidePhantomElements(true)

	#local phantoms = 'Phantoms: '
	#for index, army in pData.phantom_armies do
	#	phantoms = phantoms .. GetArmiesTable().armiesTable[army].nickname .. ', '
	#end
	#print(phantoms)
	#local innocents = 'Innocents: '
	#for index, army in pData.innocent_armies do
	#	innocents = innocents .. GetArmiesTable().armiesTable[army].nickname .. ', '
	#end
	#print(innocents)

	
	# Remove unnessessary countdown heartbeat
	GameMain.RemoveBeatFunction(PhantomUIBeat)
end

function SetPhantomStats(stats)
	pStats = stats
	if pData.isPhantom then
		# Show innocent kills
		pUI.box.kills:SetText(pStats.innocents_dead..'/'..pStats.innocent_count)
	else
		# Show phantom kills
		pUI.box.kills:SetText(pStats.phantoms_dead..'/'..pStats.phantom_count)
	end
	
	# Show player statuses
	local iRemain = pStats.innocent_count - pStats.innocents_dead
	local pRemain = pStats.phantom_count - pStats.phantoms_dead
	local statusText = "Alive: "..iRemain
	if iRemain > 1 or iRemain == 0 then
		statusText = statusText .. " innocents, "
	else
		statusText = statusText .. " innocent, "
	end
	statusText = statusText .. pRemain
	if pRemain > 1 or pRemain == 0 then
		statusText = statusText .. " phantoms"
	else
		statusText = statusText .. " phantom"
	end
	
	pUI.box.countdown:SetText(statusText)
end

function SetPhantomEco(pEco)
	if pData.isPhantom then
		pUI.box.mass:SetText("+" .. pEco.mass)
		pUI.box.energy:SetText("+" .. pEco.energy)
	end
end

function pMassBtnClick()
	data = {
		From = GetFocusArmy(),
		To = -1,
		Name = "PhantomDumpResources",
		Args = "MASS"
	}
	import('/lua/UserPlayerQuery.lua').Query( data, QueryResult )
end

function pEnergyBtnClick()
	data = {
		From = GetFocusArmy(),
		To = -1,
		Name = "PhantomDumpResources",
		Args = "ENERGY"
	}
	import('/lua/UserPlayerQuery.lua').Query( data, QueryResult )	
end

function TogglePhantomPanel(state)
	if import('/lua/ui/game/gamemain.lua').gameUIHidden and state != nil then
		return
	end

	if UIUtil.GetAnimationPrefs() then
		if state or pUI.box:IsHidden() then
			PlaySound(Sound({Cue = "UI_Score_Window_Open", Bank = "Interface"}))
			pUI.box:Show()
			ShowHidePhantomElements(true)
			pUI.box:SetNeedsFrameUpdate(true)
			pUI.box.OnFrame = function(self, delta)
				local newLeft = self.Left() + (1000*delta)
				if newLeft > parent.Left()+14 then
					newLeft = parent.Left()+14
					self:SetNeedsFrameUpdate(false)
				end
				self.Left:Set(newLeft)
			end
			pUI.arrow:SetCheck(false, true)
		else
			PlaySound(Sound({Cue = "UI_Score_Window_Close", Bank = "Interface"}))
			pUI.box:SetNeedsFrameUpdate(true)
			pUI.box.OnFrame = function(self, delta)
				local newLeft = self.Left() - (1000*delta)
				if newLeft < parent.Left()-self.Width() then
					newLeft = parent.Left()-self.Width()
					self:SetNeedsFrameUpdate(false)
					self:Hide()
					ShowHidePhantomElements(false)
				end
				self.Left:Set(newLeft)
			end
			pUI.arrow:SetCheck(true, true)
		end
	else
		if state or pUI.box:IsHidden() then
			pUI.box:Show()
			ShowHidePhantomElements(true)
			pUI.arrow:SetCheck(false, true)
		else
			pUI.box:Hide()
			ShowHidePhantomElements(false)
			pUI.arrow:SetCheck(true, true)
		end
	end
end

function InitPhantomPanel()
	if import('/lua/ui/game/gamemain.lua').gameUIHidden then
		return
	end
	
	if UIUtil.GetAnimationPrefs() then
		pUI.box:Show()
		pUI.box:SetNeedsFrameUpdate(true)
		pUI.box.OnFrame = function(self, delta)
			local newLeft = self.Left() + (1000*delta)
			if newLeft > parent.Left()+14 then
				newLeft = parent.Left()+14
				self:SetNeedsFrameUpdate(false)
			end
			self.Left:Set(newLeft)
		end
		pUI.arrow:SetCheck(false, true)

	else
		pUI.box:Show()
		pUI.arrow:SetCheck(false, true)	
	end
	pUI.box.mass:Hide()
	pUI.box.energy:Hide()
	pUI.box.massBtn:Hide()
	pUI.box.energyBtn:Hide()
	pUI.box.kills:Hide()
	pUI.box.killIcon:Hide()
	GameMain.RemoveBeatFunction(InitPhantomPanel)
end

function ShowHidePhantomElements(show) 
	if show then
		if pData.isPhantom then
			pUI.box.mass:Show()
			pUI.box.energy:Show()
			pUI.box.massBtn:Show()
			pUI.box.energyBtn:Show()	
		else
			pUI.box.mass:Hide()
			pUI.box.energy:Hide()
			pUI.box.massBtn:Hide()
			pUI.box.energyBtn:Hide()
		end
		if table.getn(pData.phantom_armies) > 0 then
			pUI.box.kills:Show()
			pUI.box.killIcon:Show()		
		else
			pUI.box.kills:Hide()
			pUI.box.killIcon:Hide()		
		end
	else
		pUI.box.mass:Hide()
		pUI.box.energy:Hide()
		pUI.box.massBtn:Hide()
		pUI.box.energyBtn:Hide()
		pUI.box.kills:Hide()
		pUI.box.killIcon:Hide()
	end
end

function ShowAlert(args)
	import('/lua/ui/game/announcement.lua').CreateAnnouncement(args[1], pUI.arrow, args[2])
end

function QueryResult(data)
	# Nothing needed
end

function ShowPhantomVote()
	local layout =  UIUtil.SkinnableFile('/mods/'..modPath..'/modules/layout/vote.lua')
	local worldView = import('/lua/ui/game/worldview.lua').view
	
	voteDialog = Bitmap(worldView, UIUtil.SkinnableFile('/dialogs/diplomacy-team-alliance/team-panel_bmp.dds'))
	voteDialog:SetRenderPass(UIUtil.UIRP_PostGlow)  -- just in case our parent is the map
	voteDialog:SetName("Phantom Vote")

	LayoutHelpers.AtCenterIn(voteDialog,worldView)

	local dialogTitle = UIUtil.CreateText(voteDialog, "Phantom Vote", 18, UIUtil.titleFont )
	dialogTitle:SetColor( UIUtil.dialogCaptionColor )
	LayoutHelpers.RelativeTo(dialogTitle, voteDialog, layout, "title", "panel")

	local text = "Select the number of players to be designated Phantoms"
	local message = UIUtil.CreateText(voteDialog, text, 12, UIUtil.bodyFont )
	LayoutHelpers.RelativeTo(message, voteDialog, layout, "text", "panel")
	LayoutHelpers.AtHorizontalCenterIn(message,voteDialog)

	local function MakeClickCallback(result)
		return function(self, modifiers)
			voteDialog:Destroy()
			voteDialog = nil
			SetVote(result)
		end
	end

	local one = UIUtil.CreateDialogButtonStd(voteDialog, "/dialogs/standard_btn/standard", "One", 12)
	LayoutHelpers.RelativeTo(one, voteDialog, layout, "btn_one", "panel")
	one.OnClick = MakeClickCallback(1)

	local two = UIUtil.CreateDialogButtonStd(voteDialog, "/dialogs/standard_btn/standard", "Two", 12)
	LayoutHelpers.RelativeTo(two, voteDialog, layout, "btn_two", "panel")
	two.OnClick = MakeClickCallback(2)

	local three = UIUtil.CreateDialogButtonStd(voteDialog, "/dialogs/standard_btn/standard", "Three", 12)
	LayoutHelpers.RelativeTo(three, voteDialog, layout, "btn_three", "panel")
	three.OnClick = MakeClickCallback(3)
end

function SetVote(vote)
	data = {
		From = GetFocusArmy(),
		To = -1,
		Name = "PhantomVote",
		Args = { Nick = GetArmiesTable().armiesTable[GetFocusArmy()].nickname, Vote = vote }
	}
	import('/lua/UserPlayerQuery.lua').Query( data, QueryResult )	
end