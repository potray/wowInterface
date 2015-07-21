local Breeze, _ = ...
local addonName = "Breeze"
local missions

Breeze = CreateFrame("Frame")
SetCVar("lastGarrisonMissionTutorial", 8) -- Setting tutorials as "seen" on all possible alts.
SLASH_BREEZE1 = "/breeze";

local function myDebug(text)
  --[===[@debug@
  print("|cFFFE0E89Breeze DEBUG|r: " .. text)
  --@end-debug@]===]
end

-- setting garrison animation length to 0 
GARRISON_ANIMATION_LENGTH = 0

-- GarrisonMissionFrame.MissionComplete.NextMissionButton.Disable = function() end

function Breeze:GARRISON_MISSION_COMPLETE_RESPONSE(...)

  local missionID, requestCompleted, succeeded = ...

  if not requestCompleted then
    myDebug("Server failed request!");
  end
  
  local mc = GarrisonMissionFrame.MissionComplete
  
  if mc.currentMission then
    mc.NextMissionButton:SetText(NEXT)
    mc.Stage.EncountersFrame.FadeOut:Play()
    mc.animIndex = GarrisonMissionComplete_FindAnimIndexFor(GarrisonMissionComplete_AnimRewards) - 1
    mc.animTimeLeft = 0
    
    if C_Garrison.CanOpenMissionChest(missionID) and succeeded then
      myDebug("Mission Success!")
      local bonusRewards = mc.BonusRewards
      bonusRewards.waitForEvent = true
      bonusRewards.waitForTimer = true
      bonusRewards.success = false
      bonusRewards:RegisterEvent("GARRISON_MISSION_BONUS_ROLL_COMPLETE")
      C_Timer.After(1, GarrisonMissionComplete_OnRewardTimer)
      C_Garrison.MissionBonusRoll(missionID)
      mc.BonusRewards.ChestModel:Hide()
      PlaySound("UI_Garrison_CommandTable_ChestUnlock_Gold_Success")
      mc.NextMissionButton:Disable()
    else
      myDebug("Mission Failed!")
      mc.NextMissionButton:SetText("FAILED!")
      C_Garrison.MissionBonusRoll(missionID)
    end
  end  
end

function SlashCmdList.BREEZE(arg)
  if arg == "auto" then
    Breeze_AutoClick = not Breeze_AutoClick
    SELECTED_CHAT_FRAME:AddMessage("|cFFFE0E89Breeze|r: Auto Mode " .. (Breeze_AutoClick and "enabled" or "|cFFFF0026disabled|r"))
  elseif arg == "chat" then
    Breeze_ChatOutput = not Breeze_ChatOutput
    SELECTED_CHAT_FRAME:AddMessage("|cFFFE0E89Breeze|r: Chat Output " .. (Breeze_ChatOutput and "enabled" or "|cFFFF0026disabled|r"))
  else
    -- SELECTED_CHAT_FRAME:AddMessage("|cFFFE0E89Breeze|r Options: chat, auto [NYI]")
    SELECTED_CHAT_FRAME:AddMessage("|cFFFE0E89Breeze|r Options: chat - toggles chat output")
  end
end



-- Runing this code after the Garrison UI has loaded but before any of the missions are completed
function Breeze:GARRISON_MISSION_NPC_OPENED()
    -- Get standard completion data for the missions
    missions = nil
    missions = C_Garrison.GetCompleteMissions()

    if missions and (#missions > 0) then
        -- Prevent taint from this loop statement
        local _
        for m_index, result_table in next, missions do
            -- Get general mission data
            _, missions[m_index].xp = C_Garrison.GetMissionInfo(missions[m_index].missionID)
            _, _, _, missions[m_index].successChance, _, _, missions[m_index].xpBonus, missions[m_index].materialMultiplier = C_Garrison.GetPartyMissionInfo(missions[m_index].missionID)
        end
    end
end

function Breeze:GARRISON_MISSION_LIST_UPDATE()
  Breeze:GARRISON_MISSION_NPC_OPENED()
end

-- Use this for output; just pass the missionID to it
function Breeze:GARRISON_MISSION_BONUS_ROLL_COMPLETE(missionID, success)
    -- Local shortcut
    local m = missionID
    
    -- Sometm
    local found = false;
    if missions then
        for m_index, subtable in next, missions do
            if arg1 == subtable.missionID then
                found = true
                break
            end
        end
    end
    if not found then
        Breeze:GARRISON_MISSION_NPC_OPENED()
    end
    
    for mission_index, results in next, missions do
        if results.missionID == missionID then
            m = missions[mission_index]
            break
        end
    end

    -- Set up strings
    -- local strMissionNumberName = format("Mission %d/%d", mission_index, #missions)
    -- local strIsRare = m.isRare and " (Rare): " or ": "
     -- local strName = format("%s (lvl %d", m.name, m.level)
    local strIsRare = ""
    local strMissionNumberName = ""
    local strName = string.format("|cFFFE0E89Breeze|r: |c%s|Hgarrmission:%s|h[%s (%s)]|h|r", (m.isRare and "ff0070dd" or "ffffff00"), missionID, m.name, m.level)
    local strItemLevel = (not (m.iLevel == 0)) and tostring(m.iLevel) or ""
    local strSuccess = true and " |cff1eff00OK|r " or " |cFFFF0026FAIL|r "
    local strXP = m.xp and ("|cFF10A608".. m.xp .. "|r BaseXP. ") or ""
    local strRewards = ""

    -- Build rewards string
    strRewards = "Rewards: "
    local rewardCount = 0
    for x, y in next, m.rewards do
        if m.rewards[x].currencyID then
            if m.rewards[x].currencyID == 0 then
                -- Money reward
                strRewards = strRewards .. GetMoneyString(m.rewards[x].quantity) 
            elseif m.rewards[x].currencyID == GARRISON_CURRENCY then
                -- Garrison currency reward (uses materialMultiplier)
                strRewards = strRewards .. GetCurrencyLink(m.rewards[x].currencyID)  .. " x " .. tostring(m.rewards[x].quantity * m.materialMultiplier)
            else
                -- Other currency reward
                strRewards = strRewards .. GetCurrencyLink(m.rewards[x].currencyID)  .. " x " .. tostring(m.rewards[x].quantity)
            end
        elseif m.rewards[x].itemID then
            -- Item reward
            local _, link = GetItemInfo(m.rewards[x].itemID)
            strRewards = strRewards .. (link and tostring(link) or ("item " .. tostring(m.rewards[x].itemID))) .. " x " .. tostring(m.rewards[x].quantity)
        else
            -- Follower XP reward
            strRewards = strRewards .. tostring(m.rewards[x].followerXP) .. " BonusXP"
        end

        -- Find out if we need to stop adding semicolons and spaces to the end
        rewardCount = rewardCount + 1
        if rewardCount < #m.rewards then
            strRewards = strRewards .. "; "
        end
    end

    -- Output
    if Breeze_ChatOutput then
        print(strMissionNumberName .. strIsRare .. strName .. strItemLevel .. strSuccess .. strXP .. strRewards)
    end 
    
    if Breeze_AutoClick then
        C_Timer.After(2, GarrisonMissionCompleteNextButton_OnClick)
    end
end

Breeze:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)
Breeze:RegisterEvent("GARRISON_MISSION_COMPLETE_RESPONSE")
Breeze:RegisterEvent("GARRISON_MISSION_BONUS_ROLL_COMPLETE")
Breeze:RegisterEvent("GARRISON_MISSION_NPC_OPENED")
Breeze:RegisterEvent("GARRISON_MISSION_LIST_UPDATE")
-- unregistering the silly ding animation & sound when you upgrade a followers item level 
GarrisonMissionFrame:UnregisterEvent("GARRISON_FOLLOWER_UPGRADED")