do

function ShowEnhancement(bp, bpID, iconID, iconPrefix, userUnit)
    if CheckFormat() then
        # Name / Description
        View.UnitImg:SetTexture(iconPrefix..'_btn_up.dds')
        
        LayoutHelpers.AtTopIn(View.UnitShortDesc, View, 10)
        View.UnitShortDesc:SetFont(UIUtil.bodyFont, 14)

        local slotName = enhancementSlotNames[string.lower(bp.Slot)]
        slotName = slotName or bp.Slot

        if bp.Name != nil then
            View.UnitShortDesc:SetText(LOCF("%s: %s", bp.Name, slotName))
        else
            View.UnitShortDesc:SetText(LOC(slotName))
        end
        if View.UnitShortDesc:GetStringAdvance(View.UnitShortDesc:GetText()) > View.UnitShortDesc.Width() then
            LayoutHelpers.AtTopIn(View.UnitShortDesc, View, 14)
            View.UnitShortDesc:SetFont(UIUtil.bodyFont, 10)
        end
        
        local showecon = true
        local showAbilities = false
        local showUpKeep = false
        local time, energy, mass
        if bp.Icon != nil and not string.find(bp.Name, 'Remove') then
            time, energy, mass = import('/lua/game.lua').GetConstructEconomyModel(userUnit, bp)
            time = math.max(time, 1)
            showUpKeep = DisplayResources(bp, time, energy, mass)
            View.TimeStat.Value:SetFont(UIUtil.bodyFont, 14)
            View.TimeStat.Value:SetText(string.format("%s", FormatTime(time)))
            if string.len(View.TimeStat.Value:GetText()) > 5 then
                View.TimeStat.Value:SetFont(UIUtil.bodyFont, 10)
            end
        else
            showecon = false
            if View.Description then
                View.Description:Hide()
                for i, v in View.Description.Value do
                    v:SetText("")
                end
            end
        end
        
        if View.Description then
            local tempDescID = bpID.."-"..iconID
            if UnitDescriptions[tempDescID] and not string.find(bp.Name, 'Remove') then
                local tempDesc = LOC(UnitDescriptions[tempDescID])
                WrapAndPlaceText(nil, tempDesc, View.Description)
            else
                WARN('No description found for unit: ', bpID, ' enhancement: ', iconID)
                View.Description:Hide()
                for i, v in View.Description.Value do
                    v:SetText("")
                end
            end
        end
        
        local showShield = false
        if bp.ShieldMaxHealth then
            showShield = true
            View.ShieldStat.Value:SetText(bp.ShieldMaxHealth)
        end
    
        ShowView(showUpKeep, true, showecon, showShield)
        if time == 0 and energy == 0 and mass == 0 then
            View.BuildCostGroup:Hide()
            View.TimeStat:Hide()
        end
    else
        Hide()
    end
end

end