﻿---------------------------------------------------------------------------------------
-- NxInfo - Information window
-- Copyright 2008-2012 Carbon Based Creations, LLC
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
-- Carbonite - Addon for World of Warcraft(tm)
-- Copyright 2007-2012 Carbon Based Creations, LLC
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
---------------------------------------------------------------------------------------

--------

CarboniteInfo = LibStub("AceAddon-3.0"):NewAddon("Carbonite.Info","AceEvent-3.0", "AceComm-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("Carbonite.Quest", true)

Nx.VERSIONINFO			= .24				-- Info win data
Nx.Info = {}
Nx.InfoStats = {}

local defaults = {
	profile = {
		Info = {		    
			ListCol = "0|0|0|0.4",
			Lock = false,
			InfoFont = "Arial",
			InfoFontSize = 11,
			InfoFontSpacing = 0,
			
		},	   
	},
}
local options

local function createOptions() 
	if not options then
		options = {
			type = "group",
			name = "Info Options",
			args = {	
				InfoLock = {
					order = 1,
					type = "toggle",
					width = "full",
					name = "Lock Info Windows",
					desc = "Locks the location of your info windows",
					get = function()
						return Nx.idb.profile.Info.Lock
					end,
					set = function()
						Nx.idb.profile.Info.Lock = not Nx.idb.profile.Info.Lock						
						Nx.Info:OptionsUpdate()
					end,				
				},
				InfoBGCol = {
					order = 2,
					type = "color",
					width = "full",
					name = "Info Window Background Color",
					hasAlpha = true,
					get = function()
						local arr = { strsplit("|",Nx.idb.profile.Info.ListCol) }
						local r = arr[1]
						local g = arr[2]
						local b = arr[3]
						local a = arr[4]
						return r,g,b,a
					end,
					set = function(_,r,g,b,a)
						Nx.idb.profile.Info.ListCol = r .. "|" .. g .. "|" .. b .. "|" .. a
						Nx.Info:OptionsUpdate()
					end,						
				},
				InfoFont = {
					order = 3,
					type	= "select",
					name	= "Info Font",
					desc	= "Sets the font to be used for info windows",
					get	= function()
						local vals = Nx.Opts:CalcChoices("FontFace","Get")
						for a,b in pairs(vals) do
						  if (b == Nx.idb.profile.Info.InfoFont) then
							 return a
						  end
						end
						return ""
					end,
					set	= function(info, name)
						local vals = Nx.Opts:CalcChoices("FontFace","Get")
						Nx.idb.profile.Info.InfoFont = vals[name]						
						Nx.Opts:NXCmdFontChange()
					end,
					values	= function()
						return Nx.Opts:CalcChoices("FontFace","Get")
					end,					
				},
				InfoFontSize = {
					order = 4,
					type = "range",							
					name = "Info Font Size",						
					desc = "Sets the size of the info font",
					min = 6,
					max = 14,
					step = 1,
					bigStep = 1,
					get = function()
						return Nx.idb.profile.Info.InfoFontSize
					end,
					set = function(info,value)
						Nx.idb.profile.Info.InfoFontSize = value
						Nx.Opts:NXCmdFontChange()
					end,				
				},		
				InfoFontSpacing = {
					order = 5,
					type = "range",							
					name = "Info Font Spacing",						
					desc = "Sets the spacing of the info font",
					min = -10,
					max = 20,
					step = 1,
					bigStep = 1,
					get = function()
						return Nx.idb.profile.Info.InfoFontSpacing
					end,
					set = function(info,value)
						Nx.idb.profile.Info.InfoFontSpacing = value
						Nx.Opts:NXCmdFontChange()
					end,				
				},					
			},
		}
	end
	return options
end

function CarboniteInfo:OnInitialize()
	if not Nx.Initialized then
		CarbInfoInit = Nx:ScheduleTimer(CarboniteInfo.OnInitialize,1)
		return
	end
	Nx.idb = LibStub("AceDB-3.0"):New("NXInfo",defaults, true)
	Nx.idb:SetProfile(Nx.db:GetCurrentProfile())
	tinsert(Nx.dbs,Nx.idb)
	Nx.Font:ModuleAdd("Info.InfoFont",{ "NxFontI", "GameFontNormal","idb" })	
	Nx.Info:Init()	
	CarboniteInfo:PLAYER_LOGIN()
	local function func ()
		Nx.Info:ToggleShow()
	end
	Nx.NXMiniMapBut.Menu:AddItem(0, "Show Info 1 2", func, Nx.NXMiniMapBut)		
	CarboniteInfo:RegisterEvent("PLAYER_LOGIN")
	tinsert(Nx.BrokerMenuTemplate,{ text = "Toggle Info Windows", func = function() Nx.Info:ToggleShow()end })
end

function CarboniteInfo:PLAYER_LOGIN()
	local ch = Nx.CurCharacter
	Nx.InfoStats["ArenaPts"] = ch["ArenaPts"]
	Nx.InfoStats["Honor"] = ch["Honor"]
	Nx.InfoStats["XPRest%"] = ch["XPRest"] / ch["XPMax"] * 100  
end


function Nx.Info:Init()	
	local info = Nx.idb.profile.InfoData

	if not info or info.Version < Nx.VERSIONINFO then
		if info then
			Nx.prt ("Reset old info data %f", info.Version)
		end
		info = {}
		Nx.idb.profile.InfoData = info
		info.Version = Nx.VERSIONINFO
	end

	local cls = Nx:GetUnitClass()

	if cls == "Death Knight" or cls == "Warrior" then
		self.ManaInvert = true
	end

	if cls == "Death Knight" then
		self.DeathKnight = true
	end

	self.DKRunes = {
		{ 1, "|cffff8080" },			-- Blood
		{ 2, "|cffff8080", true },
		{ 5, "|cff8080ff" },			-- Frost
		{ 6, "|cff8080ff", true },
		{ 3, "|cff80ff80" },			-- Unholy
		{ 4, "|cff80ff80" },
	}

	self.Vars = {}		-- Variables

	self.Infos = {}	-- Remember all created info windows

	self.ItemFuncs = {
		["BarH%"] = self.CalcBarHPercent,
		["Cast"] = self.CalcCast,
		["Combo"] = self.CalcComboPoints,
		["Cooldown"] = self.CalcCooldown,
		["Dur"] = self.CalcDur,
		["FPS"] = self.CalcFPS,
		["Health"] = self.CalcHealth,
		["Health%"] = self.CalcHealthPercent,
		["HealthChange"] = self.CalcHealthChange,
		["IfBG"] = self.CalcIfBG,
		["IfCombat"] = self.CalcIfCombat,
		["IfF"] = self.CalcIfFalse,
		["IfLT"] = self.CalcIfLT,
		["IfLTOrCombat"] = self.CalcIfLTOrCombat,
		["IfMana"] = self.CalcIfMana,
		["IfT"] = self.CalcIfTrue,
		["LvlTime"] = self.CalcLvlTime,
		["Mana"] = self.CalcMana,
		["Mana%"] = self.CalcManaPercent,
		["ManaChange"] = self.CalcManaChange,
		["BGQueue"] = self.CalcBGQueue,
		["BGStart"] = self.CalcBGStart,
		["BGDuration"] = self.CalcBGDuration,
		["BGHonor"] = self.CalcBGHonor,
		["BGStats"] = self.CalcBGStats,
		["BGWingWait"] = self.CalcBGWingWait,
		["Stat"] = self.CalcStat,
		["THealth"] = self.CalcTargetHealth,
		["THealth%"] = self.CalcTargetHealthPercent,
--		["THealthChange"] = self.CalcTargetHealthChange,
		["Threat%"] = self.CalcThreatPercent,
		["TMana"] = self.CalcTargetMana,
		["TMana%"] = self.CalcTargetManaPercent,
--		["TManaChange"] = self.CalcTargetManaChange,
		["Time"] = self.CalcTime,
	}	
	
	local dinfo = Nx.idb.profile.InfoData
	self:OnTimer()
--	self:Create (1)

	for n = 1, 10 do

		local info = dinfo[n]

		if info then			
			self:Create (n)
		end
	end

	self:CreateMenu()
	Nx:AddToConfig("Info Module",createOptions(),"Info Module")
	self:OptionsUpdate()
end

--------
-- Update all info windows

function Nx.Info:OnTimer()

	local vars = self.Vars

	self.NeedDurability = false

	local h = UnitHealth ("player")
	local m = UnitMana ("player")
	if UnitIsDeadOrGhost ("player") then
		h = 0
		m = 0
	end
	vars["Health"] = h
	vars["Mana"] = m

	vars["HealthMax"] = UnitHealthMax ("player")
	vars["ManaMax"] = UnitManaMax ("player")

	vars["Health%"] = h / vars["HealthMax"]
	vars["Mana%"] = m / vars["ManaMax"]

	local h = 0
	local m = -1

	local tarName = UnitName ("target")
	vars["TName"] = tarName

	if tarName then

		m = UnitManaMax ("target") > 0 and 0 or -1
		if not UnitIsDeadOrGhost ("target") then
			h = UnitHealth ("target")
			m = UnitManaMax ("target") > 0 and UnitMana ("target") or -1
		end

		vars["THealthMax"] = max (UnitHealthMax ("target"), 1)
		vars["TManaMax"] = max (UnitManaMax ("target"), 1)
	end
	vars["THealth"] = h
	vars["TMana"] = m

	vars["InBG"] = Nx.InBG

	for i, info in pairs (self.Infos) do
		if info.Data then		-- Not deleted?
			info:Update (n)
		end
	end

	return .1
end

--------

function Nx.Info:OptionsUpdate()	
	local lock = Nx.idb.profile.Info.Lock

	for i, info in pairs (self.Infos) do

		local win = info.Win
		if win then

			win:SetBGAlpha (0, 1)
			if lock then
				win:Lock (true, true)
			else
				win:Lock (false, true)
			end
			info.List:Lock (lock)
			local arr = { strsplit("|",Nx.idb.profile.Info.ListCol) }
			local cr = arr[1]
			local cg = arr[2]
			local cb = arr[3]
			local ca = arr[4]
			info.List:SetBGColor (cr, cg, cb, ca, true)
		end
	end
end

--------

function Nx.Info:New()

	local dinfo = Nx.idb.profile.InfoData

	for n = 1, 10 do

		if not dinfo[n] then
			self:Create (n)
			self.Infos[n].Win:ResetLayout()
			break
		end
	end

	self:OptionsUpdate()
end

--------
-- Delete the info window

function Nx.Info:Delete (index)

	Nx.idb.profile.InfoData[index] = nil

	local info = self.Infos[index]
	if info then
		info.Win:Show (false)
	end

	info.Data = nil

	Nx.Window:ClrSaveData ("NxInfo" .. index)
end

--------
-- Create shared menu

function Nx.Info:CreateMenu()

	local menu = Nx.Menu:Create (UIParent, 160)
	self.Menu = menu

	self.MenuITitle = menu:AddItem (0, "?", nil, self)

	local item = menu:AddItem (0, "Close", self.Menu_OnClose, self)
	self.MenuIEdit = menu:AddItem (0, "?", self.Menu_OnEdit, self)
	menu:AddItem (0, "Edit Item", self.Menu_OnEditItem, self)
	menu:AddItem (0, "", nil, self)

	-- Create show sub menu

	local showMenu = Nx.Menu:Create (UIParent)
	menu:AddSubMenu (showMenu, "Show...")

	self.MenuIShow = {}

	for n = 1, 10 do
		local function func (self, item)
--			Nx.prt ("%s", n)
			Nx.Info.Infos[n].Win:Show()
		end
		self.MenuIShow[n] = showMenu:AddItem (0, "#" .. n, func, self)
	end

	--

	menu:AddItem (0, "", nil, self)
	local item = menu:AddItem (0, "New Info Window", self.Menu_OnNew, self)
	local item = menu:AddItem (0, "Delete This Window", self.Menu_OnDelete, self)

	--

	menu:AddItem (0, "", nil, self)

	local function func()
		Nx.Opts:Open ("Info Windows")
	end

	menu:AddItem (0, "Options...", func)

end

--------
-- Create menu

function Nx.Info:OpenMenu (info)

	self.CurMenuInfo = info

	self.MenuITitle:SetText (format ("-- Info %d --", info.Index))
	self.MenuIEdit:SetText (info.Editing and "Stop Edit" or "Edit View")

	for n = 1, 10 do
		local info = self.Infos[n]
		local b = info and info.Data and not self.Infos[n].Win:IsShown()
		self.MenuIShow[n]:Show (b == true)
	end

	self.Menu:Open()
end

--------

function Nx.Info:Menu_OnClose()
	self.CurMenuInfo.Win:Show (false)
end

function Nx.Info:Menu_OnEdit()
	local info = self.CurMenuInfo

	local editing = not info.Editing
	info.Editing = editing

--	info.Win:SetTitleLineH (editing and 18 or 0)
end

function Nx.Info:Menu_OnEditItem()

	local info = self.CurMenuInfo

	local function func (str, self)
		str = gsub (str, "||", "|")
		self.Data["Items"][self.SelItemIndex] = str
	end

	if info.SelItemIndex then
		local s = info.Data["Items"][info.SelItemIndex] or ""
		s = gsub (s, "|", "||")
		Nx:ShowEditBox ("Change Text", s, info, func)
	end
end

function Nx.Info:Menu_OnNew (item)
	self:New()
end

function Nx.Info:Menu_OnDelete (item)

	local function func()
		Nx.Info:Delete (Nx.Info.CurMenuInfo.Index)
	end

	Nx:ShowMessage ("Delete Info Window #" .. self.CurMenuInfo.Index .. "?", "Delete", func, "Cancel")
end

--------
-- Create info window

function Nx.Info:Create (index)

--	Nx.prt ("Info: create %s", index)

	local info = self.Infos[index] or {}

	self.Infos[index] = info
	
	setmetatable (info, self)	
	self.__index = self

	info:Create2 (index)
end

--------
-- Create info window
-- self = instance

function Nx.Info:Create2 (index)

--PAIDS!

	self.Index = index

	self.Data = Nx.idb.profile.InfoData[index] or {}
	Nx.idb.profile.InfoData[index] = self.Data
	
	--

	local items = self.Data["Items"]

--	items = nil		-- DEBUG

	if not items then
		items = {}
		self.Data["Items"] = items

		if index == 1 then
			tinsert (items, "<IfLTOrCombat;1;Health%><Health><c>HP <t> <HealthChange><c><t> <IfCombat>|cffff4040* <Threat%;player><c><t>")
			tinsert (items, "<IfLTOrCombat;1;Health%>     <Health%><c><t>%<BarH%;G;Health%><t>")
			tinsert (items, "<IfMana><Mana><c>MP <t> <ManaChange><c><t>")
			tinsert (items, "<IfMana>     <Mana%><c><t>%<BarH%;B;Mana%><t>")
			tinsert (items, "<Combo><c><t>")
			tinsert (items, "<Cooldown><c><t>")
			tinsert (items, "<Cast><c><t>")
		elseif index == 2 then
			tinsert (items, "<THealth><c>HP <t>")
			tinsert (items, "     <THealth%><c><t>%<BarH%;G;THealth%><t>")
			tinsert (items, "<TMana><c>MP <t>")
			tinsert (items, "     <TMana%><c><t>%<BarH%;B;TMana%><t>")
			tinsert (items, "<Cast;target><c><t>")
		elseif index == 3 then
			tinsert (items, "<Dur><c>Durability <t>%")
			tinsert (items, "<LvlTime><c>Lvl <t> hours")
			tinsert (items, "")
		elseif index == 4 then
			tinsert (items, "<BGQueue;1><c><t>")
			tinsert (items, "<BGQueue;2><c><t>")
			tinsert (items, "<BGQueue;3><c><t>")
			tinsert (items, "<BGStart><c>BG start <t>")
			tinsert (items, "<BGDuration><c>BG duration <t>")
			tinsert (items, "<IfF;InBG><BGWingWait><c>Wing <t>")
			tinsert (items, "<IfBG><BGHonor><c>Honor <t>")
			tinsert (items, "<BGStats><c>Stats <t>")
		elseif index == 5 then
			tinsert (items, "<Time;%a %m/%d %I:%M %p><c><t>")
			tinsert (items, "<FPS><t>")
			tinsert (items, "")
		elseif index == 6 then
			tinsert (items, "<Stat;XPRest%><c>Rest <t>%")
			tinsert (items, "")
			tinsert (items, "")
		end
	end

	self.HealthLast = UnitHealth ("player")
	self.HealthLastVal = 0
	self.ManaLast = UnitMana ("player")
	self.ManaLastVal = 0

	-- Show if it exists

--	Nx.Window:ClrSaveData ("NxInfo" .. index)

	if self.Win then
		self.Win:Show()
		return
	end

	-- Create Window

	local layouts = {
		[0] = { -.72, -.2, 100, 41 },
		{ 200000, -.20, 110, 80, 1.1 },
		{ 300040, -.20, 120, 80, 1.1 },
	}

	Nx.Window:SetCreateFade (1, 0)

	local win = Nx.Window:Create ("NxInfo" .. index, 50, 20, nil, 1, nil, nil, true)
	self.Win = win
	win.Frm.NxInst = self

--	win:CreateButtons (true)
	win:SetTitleLineH (3)

	local layout = layouts[index] or layouts[0]

--	Nx.prt ("#%s %s %s %s %s", index, layout[1], layout[2], layout[3], layout[4])

	local i = index <= 2 and 0 or index - 3

	local scale = layout[5] or 1
	local x = layout[3] + scale * layout[4] - layout[4]

	win:InitLayoutData (nil, layout[1], layout[2] - i * .06, x, layout[4], nil, layout[5])
	win.Frm:SetToplevel (true)

	-- Buttons

	local bw, bh = win:GetBorderSize()

--	local but = Nx.Button:Create (win.Frm, "Txt64", "Up", nil, bw, -bh, "TOPLEFT", 44, 20, self.But_OnUp, self)
--	local but = Nx.Button:Create (but.Frm, "Txt64", "Down", nil, 46, 0, "TOPLEFT", 44, 20, self.But_OnDown, self)

	-- List

	Nx.List:SetCreateFont ("Info.InfoFont", 11)

	local list = Nx.List:Create (false, 0, 0, 1, 1, win.Frm, false, true)
	self.List = list

	list:SetUser (self, self.OnListEvent)
	list:SetLineHeight (0, 0)

	list:ColumnAdd ("", 1, 900)

--	list:SetBGColor (0, 0, 0, .1)

	win:Attach (list.Frm, 0, 1, 0, 1)

	--

	self.Frms = {}		-- For health bars
	self.Frms.Next = 1

	--
	self:Update()
	self.List:FullUpdate()
--PAIDE!
end

--------
-- Show or hide

--function Nx:NXInfoKeyToggleShow()
--	Nx.Info:ToggleShow()
--end

--------
-- Show or hide window

function Nx.Info:ToggleShow()

	for n = 1, 2 do

		local info = self.Infos[n]

		if not info or not info.Data then		-- Deleted?
			self:Create (n)
		else
			info.Win:Show (not info.Win:IsShown())
		end
	end
end

--------
-- On list events

function Nx.Info:OnListEvent (eventName, sel, val2, click)

--	Nx.prt ("Guide list event "..eventName)

	if eventName == "update"  then

		local listF = self.List.Frm
		local lvl = listF:GetFrameLevel() - 1

		local data = sel
		local y = val2

		local t = { strsplit ("&", data) }

		for _, str in ipairs (t) do

--			Nx.prt ("info %s", str)

			local v1, v2, v3 = strsplit ("^", str)

			local f = Nx.List:GetFrame (self.List, "Info")
			f:ClearAllPoints()

			f:SetPoint ("TOPLEFT", listF, "TOPLEFT", 0, y)
			f:SetFrameLevel (lvl)
			f.texture:SetTexture (v1)
			f:SetWidth (tonumber (v2) or 0)
			f:SetHeight (tonumber (v3) or 0)
			f:SetAlpha (.8)
			f:Show()
		end

		return
	end

	local data = self.List:ItemGetData (sel)

	if eventName == "select" or eventName == "mid" or eventName == "menu" then

		if eventName == "menu" then
			self.SelItemIndex = data
			Nx.Info:OpenMenu (self)
		end

		self:Update()
	end
end

function Nx.Info:Update()

	local Nx = Nx

	if not self.Win or not self.Win:IsVisible() then
		return
	end

	-- List

	local list = self.List

	list:Empty()

	self:UpdateItems()

	list:Update()

end

--PAIDS!

function Nx.Info:UpdateItems()

	local funcs = self.ItemFuncs

	local list = self.List
	local ch = Nx.CurCharacter

	local items = self.Data["Items"]

	for index, val in ipairs (items) do

		local data = strsplit ("^", val)

		local str = ""
		local pos = 1

		local color, text

		while true do
--			local s1, s2, cap, extra = strfind (data, "<(%a+%%?)([^>]*)>", pos)
			local s1, s2, cap = strfind (data, "<([^>]+)>", pos)
			if s1 then
				if s1 > pos then
					str = str .. strsub (data, pos, s1 - 1)
				end

--				Nx.prtCtrl ("item cap %s", cap)

				if #cap == 1 then
					if cap == "c" and color then
						str = str .. color
					elseif cap == "t" and text then
						str = str .. text
					end

				else
					local cmd, v1, v2, v3, v4 = strsplit (";", cap)	-- FIX for multiple params!					
					local func = self.ItemFuncs[cmd]
					if func then
						color, text = func (self, v1, v2, v3, v4)
						if not text then
							break
						end
					end
				end

				pos = s2 + 1
			else

				str = str .. strsub (data, pos)	-- Grab end
				break
			end
		end

		if self.Editing then
			str = format ("#%d %s = ", index, gsub (data, "|", "||")) .. str
		end

		if #str > 0 then

--			Nx.prtStrHex ("Info:", str)

			list:ItemAdd (index)

			local str, extra = strsplit ("~", str)

			if extra then
				list:ItemSetFrame ("Info~" .. extra)
			end

			list:ItemSet (1, str)
		end
	end
end

--PAIDE!

--------

function Nx.Info:CalcBarHPercent (color, perName, w, h)

	w = tonumber (w) or 50
	h = tonumber (h) or 10

	local barW = (self.Vars[perName] or 0) * w		-- perNamemax (0, min ((self.Val1 or 0) / (self.Val2 or 1), 1))

	local xo = w

	if barW >= 1 then
		return "|cffc0c0c0", format ("~Interface\\Addons\\Carbonite\\Gfx\\Skin\\InfoBarBG^%d^%d^0&Interface\\Addons\\Carbonite\\Gfx\\Skin\\InfoBar%s^%d^%d^%d", w, h, color, barW, h, xo)
--		return "|cffc0c0c0", format ("|TInterface\\Addons\\Carbonite\\Gfx\\Skin\\InfoBarBG:%d:%d|t^Interface\\Addons\\Carbonite\\Gfx\\Skin\\InfoBar%s~%d~%d~%d", h, w, color, barW, h, xo)
--		return "|cffc0c0c0", format ("|TInterface\\Addons\\Carbonite\\Gfx\\Skin\\InfoBarBG:%d:%d|t|TInterface\\Addons\\Carbonite\\Gfx\\Skin\\InfoBar%s:%d:%d:-%d|t", h, w, color, h, barW, xo)
	end

	return "|cffc0c0c0", format ("~Interface\\Addons\\Carbonite\\Gfx\\Skin\\InfoBarBG^%d^%d^0", w, h)
--	return "|cffc0c0c0", format ("|TInterface\\Addons\\Carbonite\\Gfx\\Skin\\InfoBarBG:%d:%d|t", h, w)
end

function Nx.Info:CalcCast (target, w, h)

	target = target or "player"

	w = tonumber (w) or 50
	h = tonumber (h) or 10

	local spell, rank, name, icon, startTime, endTime = UnitCastingInfo (target)

	if not name then
		spell, rank, name, icon, startTime, endTime = UnitChannelInfo (target)
	end

	if name then
		local remain = endTime / 1000 - GetTime()
		local per = remain * 1000 / (endTime - startTime)
		return "|cffc0c0f0", format ("|T%s:16|t %.1f |TInterface\\BUTTONS\\gradblue:%d:%d|t", icon, remain, h, max (per * w, 1))
	end
end

function Nx.Info:CalcFPS()
	return "|cffc0c0c0", format ("%.0f", GetFramerate())
end

function Nx.Info:CalcHealth()
	return "|cffc0c0c0", format ("%d", self.Vars["Health"])
end

function Nx.Info:CalcHealthPercent()
	return "|cffe0e0e0", format ("%d", self.Vars["Health%"] * 100)
end

function Nx.Info:CalcHealthChange()

	local i = self.Vars["Health"] - self.HealthLast
	self.HealthLast = self.Vars["Health"]

	if i == 0 then
		i = self.HealthLastVal
		if i > 0 then
			return "|cff205f20", format ("+%d", i)
		end
		return "|cff5f2020", format ("%d", i)
	else
		self.HealthLastVal = i
		if i > 0 then
			return "|cff20ff20", format ("+%d", i)
		end
		return "|cffff2020", format ("%d", i)
	end
end

function Nx.Info:CalcMana()
	return "|cffc0c0c0", format ("%d", self.Vars["Mana"])
end

function Nx.Info:CalcManaPercent()
	return "|cffe0e0e0", format ("%d", self.Vars["Mana%"] * 100)
end

function Nx.Info:CalcManaChange()

	local i = self.Vars["Mana"] - self.ManaLast
	self.ManaLast = self.Vars["Mana"]

	if i == 0 then
		i = self.ManaLastVal
		if i > 0 then
			return "|cff205f20", format ("+%d", i)
		end
		return "|cff5f2020", format ("%d", i)
	else
		self.ManaLastVal = i
		if i > 0 then
			return "|cff20ff20", format ("+%d", i)
		end
		return "|cffff2020", format ("%d", i)
	end
end

function Nx.Info:CalcCooldown()

	if UnitCastingInfo ("player") or UnitChannelInfo ("player") then
		return
	end

	local GetActionCooldown = GetActionCooldown

	for n = 1, 120 do
		local start, dur = GetActionCooldown (n)
		if dur > 0 and dur <= 1.5 then
			local low = dur - (GetTime() - start)
			return "|cffc0c020", string.rep (".", low * 10)
		end
	end
end

function Nx.Info:CalcComboPoints()

	if self.DeathKnight then

		if self.Vars["TName"] then

			local s = ""

			for _, data in ipairs (self.DKRunes) do

				local n = data[1]
				s = s .. (GetRuneType (n) ~= 4 and data[2] or "|cff606060")
				local start, duration, ready = GetRuneCooldown (n)
				s = s .. (ready and "+" or "-")

				if data[3] then
					s = s .. " "
				end
			end

			return "|cffff8080", s
		end

	else
		local i = GetComboPoints ("player")
		if i > 0 then
			return "|cffff8080", string.rep ("*", i)
		end
	end
end

function Nx.Info:CalcTargetHealth()

	if self.Vars["TName"] then
		return "|cffc0c0c0", format ("%d", self.Vars["THealth"])
	end
end

function Nx.Info:CalcTargetHealthPercent()

	if self.Vars["TName"] then
		self.Vars["THealth%"] = self.Vars["THealth"] / self.Vars["THealthMax"]
		return "|cffe0e0e0", format ("%d", self.Vars["THealth%"] * 100)
	end
end

function Nx.Info:CalcTargetMana()

	if self.Vars["TMana"] >= 0 then
		return "|cffc0c0c0", format ("%d", self.Vars["TMana"])
	end
end

function Nx.Info:CalcTargetManaPercent()

	if self.Vars["TMana"] >= 0 then
		self.Vars["TMana%"] = self.Vars["TMana"] / self.Vars["TManaMax"]
		return "|cffe0e0e0", format ("%d", self.Vars["TMana%"] * 100)
	end
end

function Nx.Info:CalcTargetCast (w, h)

	w = tonumber (w) or 50
	h = tonumber (h) or 10

	local spell, rank, name, icon, startTime, endTime = UnitCastingInfo ("target")

	if not name then
		spell, rank, name, icon, startTime, endTime = UnitChannelInfo ("target")
	end

	if name then
		local remain = endTime / 1000 - GetTime()
		local per = remain * 1000 / (endTime - startTime)
		return "|cffc0c0f0", format ("|T%s:16|t %.1f |TInterface\\BUTTONS\\gradblue:%d:%d|t", icon, remain, h, max (per * w, 1))
	end
end

function Nx.Info:CalcThreatPercent (unit)

	local isTanking, status, threatpct, rawthreatpct, threatvalue = UnitDetailedThreatSituation (unit, "target")

--	if status then	Nx.prt ("%s %s %s %s %s %s", unit, isTanking and "T" or "t", status, threatpct, rawthreatpct, threatvalue) end

	if threatpct then
		return "|cffc0c0c0", format ("%d%%", threatpct)
	end
end

function Nx.Info:CalcDur()

	Nx.Info.NeedDurability = true

	local dur = Nx.CurCharacter["DurLowPercent"]

	if dur then	-- Can be nil on login
		if dur >= 30 then
			return "|cffa0a0a0", format ("%d", dur)
		end
		return "|cffff2020", format ("%d", dur)
	end
end

function Nx.Info:CalcLvlTime()

	local ch = Nx.CurCharacter

	local lvl = tonumber (ch["Level"] or 0)

	if lvl < MAX_PLAYER_LEVEL then

		local lvlHours = difftime (time(), ch["LvlTime"]) / 3600
		local xp = max (1, ch["XP"] - ch["LXP"])
		local lvlTime = (ch["XPMax"] - ch["XP"]) / (xp / lvlHours)

		if lvlTime < 100 then
			return "", format ("%.1f", lvlTime)
		end
		return "|cff808080", "?"
	end
end

function Nx.Info:CalcBGQueue (num)

--	Nx.prtVar ("BGQ", num)

	local n = tonumber (num) or 1
	local status, name = GetBattlefieldStatus (n)

	if status == "queued" then

		name = gsub (name, "%U", "")	-- Remove all non uppercase
		local i = (GetBattlefieldEstimatedWaitTime (n) - GetBattlefieldTimeWaited (n)) / 1000
		if i >= 0 then
			return "", format ("%s ETA %d:%02d", name, i / 60 % 60, i % 60)
		else
			return "|cffff0000", format ("%s ETA -%d:%02d", name, -i / 60 % 60, -i % 60)
		end

	elseif status == "confirm" then

		name = gsub (name, "%U", "")	-- Remove all non uppercase
		local i = GetBattlefieldPortExpiration (n)
		return "|cff00ff00", format ("%s cancel %d:%02d", name, i / 60 % 60, i % 60)
	end
end

function Nx.Info:CalcBGStart()

	local info = Nx.Info

	if Nx.InBG and info.BGStartTime then

		local i = info.BGStartSecs - (GetTime() - info.BGStartTime)
		if i >= 0 then
			return "|cff8080ff", format ("%d:%02d", i / 60 % 60, i % 60)
		else
			info.BGStartTime = nil
		end
	else
		info.BGStartTime = nil
	end
end

function Nx.Info:CalcBGDuration()

	if Nx.InBG then
		local i = GetBattlefieldInstanceRunTime() / 1000
		if i > 0 then
			return "", format ("%d:%02d", i / 60 % 60, i % 60)
		end
	end
end

function Nx.Info:CalcBGWingWait()

	local s, s2

	local _, name, active, canQueue, i, canEnter = GetWorldPVPAreaInfo (1)	-- 1 Wintergrasp

--	local i = GetWintergraspWaitTime()
	if not active and i and i > 0 then
		i = i / 60
		s = ""
		s2 = format ("%d:%02d", i / 60 % 60, i % 60)
	end

	local _, name, active, canQueue, i, canEnter = GetWorldPVPAreaInfo (2)	-- 2 Tol Barad

	if not active and i and i > 0 then
		i = i / 60
		if s2 then
			s2 = s2 .. format (", TB %d:%02d", i / 60 % 60, i % 60)
		else
			s = ""
			s2 = format ("TB %d:%02d", i / 60 % 60, i % 60)
		end
	end

	return s, s2
end

function Nx.Info:CalcIfBG()
	if Nx.InBG then
		return "", ""
	end
end

function Nx.Info:CalcIfCombat()
	if Nx.InCombat then
		return "", ""
	end
end

function Nx.Info:CalcIfTrue (varName)
	if self.Vars[varName] then
		return "", ""
	end
end

function Nx.Info:CalcIfFalse (varName)
	if not self.Vars[varName] then
		return "", ""
	end
end

function Nx.Info:CalcIfLT (val, varName)
	if (self.Vars[varName] or 0) < (tonumber (val) or 1) then
		return "", ""
	end
end

function Nx.Info:CalcIfLTOrCombat (val, varName)
	if Nx.InCombat or (self.Vars[varName] or 0) < (tonumber (val) or 1) then
		return "", ""
	end
end

function Nx.Info:CalcIfMana (val)

	if self.ManaInvert then
		if self.Vars["Mana%"] > 1 - (tonumber (val) or 1) then
			return "", ""
		end
	else
		if self.Vars["Mana%"] < (tonumber (val) or 1) then
			return "", ""
		end
	end
end

function Nx.Info:CalcBGHonor()
	local _, honor = GetCurrencyInfo (392)		--V4
	return "|cffa0a0ff", format ("%d", honor)
end

function Nx.Info:CalcBGStats()
	if Nx.InBG then
		local cb = Nx.Combat
		return "|cffa0a0a0", format ("%d %d %d +%d", cb.KBs, cb.Deaths, cb.HKs, cb.Honor)
	end
end

function Nx.Info:CalcStat (val)
	return "|cffa0a0a0", format ("%s", Nx.InfoStats[val] or "?")
end

function Nx.Info:CalcTime (str)
--	Nx.prtVar ("", str)
	local ok, s = pcall (date, str ~= "" and str or nil)
	return "|cffa0a0a0", ok and s or "?"
end

--------

function Nx.Info:SetBGStartTime (secs)

	self.BGStartSecs = secs
	self.BGStartTime = GetTime()
end

-------------------------------------------------------------------------------

function Nx.Info:CreateFrame (parent)

	local f = CreateFrame ("Frame", nil, parent)

	local t = f:CreateTexture()
	f.texture = t
	t:SetAllPoints (f)

	return f
end

function Nx.Info:ResetFrames()

	local frms = self.Frms
	frms.Used = frms.Next - 1		-- Save last frame used
	frms.Next = 1
end

------
-- Hide extra frames

function Nx.Map:HideExtraFrames()

	local frms = self.Frms

	for n = frms.Next, frms.Used do		-- Hide up to last frames used amount
		frms[n]:Hide()
	end
end

------
-- Get next available frame or create one
-- ret: frame

function Nx.Info:GetFrame()

	local frms = self.Frms
	local pos = frms.Next

	local f = frms[pos]
	if not f then

		f = CreateFrame ("Frame", "NxInfo"..pos, self.Frm)
		frms[pos] = f

		local t = f:CreateTexture()
		f.texture = t
		t:SetAllPoints (f)
	end

--	f:SetFrameLevel (self.Level + (levelAdd or 0))

	frms.Next = pos + 1

	return f
end

-------------------------------------------------------------------------------

--------
-- Create info editor window
-- self = instance

function Nx.Info:EditorCreate (index)

--PAIDS!

	self.Index = index
	self.Data = Nx.idb.profile.InfoData[index]

	-- Create Window

	if self.Win then
		self.Win:Show()
		return
	end

--	Nx.Window:SetCreateFade (1, 0)

	local win = Nx.Window:Create ("NxInfoEdit", 50, 20, nil, 1)
	self.Win = win
	win.Frm.NxInst = self

	win:CreateButtons (true, true)
	win:SetTitleLineH (18)

	win:InitLayoutData (nil, -.3, -.2, -.5, -.6)
	win.Frm:SetToplevel (true)

	-- Buttons

	local bw, bh = win:GetBorderSize()

--	local but = Nx.Button:Create (win.Frm, "Txt64", "Up", nil, bw, -bh, "TOPLEFT", 44, 20, self.But_OnUp, self)
--	local but = Nx.Button:Create (but.Frm, "Txt64", "Down", nil, 46, 0, "TOPLEFT", 44, 20, self.But_OnDown, self)

	-- List

	Nx.List:SetCreateFont ("Font.Medium", 16)

	local list = Nx.List:Create (false, 0, 0, 1, 1, win.Frm, false, true)
	self.List = list

	list:SetUser (self, self.EditorOnListEvent)
	list:SetLineHeight (0, 0)

	list:ColumnAdd ("", 1, 900)

--	list:SetBGColor (0, 0, 0, .1)

	win:Attach (list.Frm, 0, 1, 0, 1)

	--

	self:Update()

	self.List:FullUpdate()

--PAIDE!
end

--------
-- On list events

function Nx.Info:EditorOnListEvent (eventName, sel, val2, click)

--	Nx.prt ("Guide list event "..eventName)

	local data = self.List:ItemGetData (sel)
--[[
	if eventName == "select" or eventName == "mid" or eventName == "menu" then

		if eventName == "menu" then
			self.SelItemIndex = data
			Nx.Info:OpenMenu (self)
		end

		self:Update()
	end
--]]
end

function Nx:OnChat_msg_bg_system_neutral (event, arg1, arg2, arg3)

	-- AB: The Battle begins in 2 minutes!
	-- AB: The Battle begins in 1 minute!
	-- AB: The Battle begins in 30 seconds!
	-- AV: 1 minute until the battle for...
	-- AV: 30 seconds until the battle for...
	-- EOS: The battle begins in 30 seconds!
	-- WG: ...Warsong Gulch begins in 30 seconds.  Pre...
	-- Arena: Thirty seconds until the Arena battle begins!
	-- Arena: Fifteen seconds until the Arena battle begins!

	if Nx.Info then

		local s1, s2, secs

		if strfind (arg1, "One minute until the Arena") then
			secs = 60
		end
		if strfind (arg1, "Thirty seconds until the Arena") then
			secs = 30
		end
		if strfind (arg1, "Fifteen seconds until the Arena") then
			secs = 15
		end

		if not secs then
			s1, s2, secs = strfind (arg1, " begins? in (%d+) ")
			if not secs then
				s1, s2, secs = strfind (arg1, "(%d+) minutes? until the battle")
			end
		end

		if secs then
			secs = tonumber (secs)
			if secs then
				if secs <= 3 then	-- Minutes?
					secs = secs * 60
				end

				Nx.Info:SetBGStartTime (secs)
			end
		end
	end
end

-------------------------------------------------------------------------------
-- EOF














