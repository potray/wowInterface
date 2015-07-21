if ( GetLocale() ~= "koKR" ) then
	return;
end

local L = LibStub("AceLocale-3.0"):NewLocale("Carbonite", "koKR")
if not L then return end

L["reached level"] = "레벨 달성"
L["Monitor Error: All 10 chat channels are in use"] = "모니터링 오류: 10개의 대화 채널을 모두 사용중입니다."
L["This will disable some communication features"] = "몇가지 커뮤니케이션 기능을 비활성합니다."
L["You may free channels using the chat tab"] = "대화 탭을 사용하여 채널을 해제 할 수 있습니다."
L["chat channel(s)!"] = "대화 채널!"
L["Need"] = "필요"
L["Monitored:"] = "모니터:"
L["Druid"] = "드루이드"
L["Hunter"] = "사냥꾼"
L["Mage"] = "마법사"
L["Paladin"] = "성기사"
L["Priest"] = "사제"
L["Rogue"] = "도적"
L["Shaman"] = "주술사"
L["Warlock"] = "흑마법사"
L["Warrior"] = "전사"
L["Deathknight"] = "죽음의기사"
L["Monk"] = "수도사"

L["Com options reset (%f, %f)"] = true
L["ComTest"] = true
L["Disabling com functions!"] = true
L["JoinChan Err %s"] = true
L["SendSecG Error: %s"] = true
L[" %s (pending)"] = true
L["Com %d Bytes sec %d"] = true
