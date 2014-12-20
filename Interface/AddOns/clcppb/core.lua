local modName, mod = ...

local defaults = {
	char = {
		x = 0,
		y = 0,
		anchorFrom = "CENTER",
		anchorTo = "CENTER",
		lock = true,
		scale = 1,
		alpha = 1,
		disableBlizzardBar = false,
		showCombatOnly = false,
	},
}
local db

mod.ace = LibStub("AceAddon-3.0"):NewAddon("clcppb")
mod.acereg = LibStub("AceConfigRegistry-3.0")
local ace = mod.ace

local function OnDragStop(self)
	self:StopMovingOrSizing()
	db.anchorFrom, _, db.anchorTo, db.x, db.y = self:GetPoint()
	mod.acereg:NotifyChange("clcppb")
end

local function AFOnEvent(self, event)
	if event == "PLAYER_REGEN_DISABLED" then
		mod.af:Show()
	elseif event == "PLAYER_REGEN_ENABLED" and db.showCombatOnly then
		mod.af:Hide()
	end
end

function ace:OnInitialize()
	mod.db = LibStub("AceDB-3.0"):New("clcppbDB", defaults)
	db = mod.db.char
	db.lock = true -- reset the lock

	-- anchor frame
	mod.af = CreateFrame("Frame", "clcppbAnchorFrame", UIParent)
	mod.af:SetWidth(120)
	mod.af:SetHeight(50)

	-- background
	mod.af.bg = mod.af:CreateTexture(nil, "BACKGROUND")
	mod.af.bg:SetAllPoints()
	mod.af.bg:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
	mod.af.bg:SetVertexColor(1, 1, 1, 1)
	mod.af.bg:Hide()

	-- movement settings
	mod.af:EnableMouse(false)
	mod.af:SetMovable(true)
	mod.af:RegisterForDrag("LeftButton")
	mod.af:SetScript("OnDragStart", function(self) self:StartMoving() end)
	mod.af:SetScript("OnDragStop", OnDragStop)

	mod.af:SetUserPlaced(false)

	-- attach the bar to it
	clcPaladinPowerBar:SetParent("clcppbAnchorFrame")
	clcPaladinPowerBar:SetPoint("CENTER", "clcppbAnchorFrame")

	-- register events for leaving/entering combat
	mod.af:RegisterEvent("PLAYER_REGEN_ENABLED")
	mod.af:RegisterEvent("PLAYER_REGEN_DISABLED")
	mod.af:SetScript("OnEvent", AFOnEvent)
	-- hide if not in combat and setting on
	if (UnitAffectingCombat("player") == false) and db.showCombatOnly then
		mod.af:Hide()
	end


	mod.UpdateAnchor()
	mod.OptionInit()

	-- do the disable
	db.disableBlizzardBar = not db.disableBlizzardBar
	mod.ToggleDisableBlizzardBar()
end

function mod.UpdateAnchor()
	mod.af:ClearAllPoints()
	mod.af:SetPoint(db.anchorFrom, "UIParent", db.anchorTo, db.x / db.scale, db.y / db.scale)
	mod.af:SetScale(db.scale)
	mod.af:SetAlpha(db.alpha)
end

function mod.ToggleLock()
	if db.lock then
		-- unlock
		mod.af:EnableMouse(true)
		mod.af.bg:Show()
	else
		-- lock
		mod.af:EnableMouse(false)
		mod.af.bg:Hide()
	end
	db.lock = not db.lock
end

function mod.ToggleDisableBlizzardBar()
	if db.disableBlizzardBar then
		-- enable it
		PaladinPowerBar:SetScript("OnShow", nil)
		PaladinPowerBar:Show()
		PaladinPowerBar_OnLoad(PaladinPowerBar)
		PaladinPowerBar_Update(PaladinPowerBar)
	else
		-- disable it
		PaladinPowerBar:Hide()
		PaladinPowerBar:UnregisterAllEvents()
		PaladinPowerBar:SetScript("OnShow", function(self) self:Hide() end)
	end
	db.disableBlizzardBar = not db.disableBlizzardBar
end



