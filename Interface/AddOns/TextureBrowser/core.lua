-- FastCall
local GetSpellInfo = GetSpellInfo;
local GetAchievementInfo = GetAchievementInfo;
local GetAchievementCategory = GetAchievementCategory;

-- Addon
local modName = ...;
local core = CreateFrame("Frame",modName,UIParent);

-- Constants
local ITEM_SIZE = 36;
local PREVIEW_SIZE = 128;
local MAX_ENTRIES = 10;
local MAX_FILTERS = 3;
local TEXTURE_PATH = "Interface\\Icons\\";

-- Tables
local filterTags = {};			-- Tags used for filtering. Tags are seperated by underscore in the texture names. Only index 1, 2 and 3 are ever used.
local allTextures = {};			-- Indexed list containing all textures
local textureList = {};			-- just an indexed list of which textures to show based on filters chosen. During OnShow: Counts textures when querying all textures, to avoid duplicate entries getting added to "allTextures".
local filterLists = {};			-- Used to build a list of valid filter strings for the dropdowns
local textureQueryList = {};	-- Table passed to the icon query functions to be filled with valid texture names

local defConfig = {
	filter1 = "all",
	filter2 = "all",
	filter3 = "all",
};

--------------------------------------------------------------------------------------------------------
--                                          Helper Functions                                          --
--------------------------------------------------------------------------------------------------------

-- Is Texture Valid?
local function IsTextureValid(texture,filterCount)
	filterTags[1], filterTags[2], filterTags[3] = ("_"):split(texture:upper());
	-- Does it pass the filters?
	for i = 1, filterCount do
		local filter = cfg["filter"..i];
		if (filter ~= "all" and filter ~= filterTags[i]) then
			return false;
		end
	end
	-- It's valid!
	return true;
end

-- Builds the filter list for display in the dropdowns
local function BuildFilterList(id)
	-- init the specific sub-table for this tag index
	if (not filterLists[id]) then
		filterLists[id] = {};
	end
	local list = filterLists[id];
	wipe(list);
	-- Check Textures
	for index, texture in ipairs(allTextures) do
		if (IsTextureValid(texture,id - 1)) then
			local cat = filterTags[id];
			if (cat) then
				if (cat:len() == 1) then
					cat = cat:upper();
				else
					cat = cat:match("(.)"):upper()..cat:match(".(.+)"):lower();
				end
				list[cat] = (list[cat] or 0) + 1;
			end
		end
	end
	-- Clear
	wipe(filterTags);
end

-- Sort
local function SortTextureListFunc(item1,item2)
	return item1:upper() < item2:upper();
end

-- First Time Initialize
local function FirstTimeInitialize()
	core.dropDown1:InitSelectedItem(cfg.filter1);
	core.dropDown2:InitSelectedItem(cfg.filter2);
	core.dropDown3:InitSelectedItem(cfg.filter3);
	FirstTimeInitialize = nil;
end

--------------------------------------------------------------------------------------------------------
--                                             Update List                                            --
--------------------------------------------------------------------------------------------------------

-- Update List
function core:UpdateList()
	FauxScrollFrame_Update(core.scroll,#textureList,MAX_ENTRIES,ITEM_SIZE);
	local index = core.scroll.offset;
	local mouseFocus = GetMouseFocus();
	-- Loop Entries
	for i = 1, MAX_ENTRIES do
		index = (index + 1);
		local btn = core.entries[i];
		if (textureList[index]) then
			btn.texture:SetTexture(TEXTURE_PATH..textureList[index]);
			btn.path:SetText(textureList[index]);
			if (btn == mouseFocus) then
				btn:GetScript("OnEnter")(btn);
			end
			btn:Show();
		else
			btn:Hide();
		end
	end
end

-- Build List, Sort and Update
function core:BuildTextureList()
	wipe(textureList);
	-- Check Textures
	for index, texture in ipairs(allTextures) do
		if (IsTextureValid(texture,MAX_FILTERS)) then
			textureList[#textureList + 1] = texture;
		end
	end
	wipe(filterTags);
	-- Sort & Update
	sort(textureList,SortTextureListFunc);
	core.header:SetFormattedText("Texture Browser (|cffffff20%d|r)",#textureList);
	self:UpdateList();
end

--------------------------------------------------------------------------------------------------------
--                                         DropDown - Filters                                         --
--------------------------------------------------------------------------------------------------------

local function SortMenuItemsFunc(item1,item2)
	if (item1.value == "all") or (item2.value == "all") then
		return (item1.value == "all");
	else
		return item1.text < item2.text;
	end;
end

local function DropDown_Init(self,list)
	list[1].text = "|cff00ff00Show All"; list[1].value = "all";
	BuildFilterList(self.id);
	local index = 2;
	for prefix, count in next, filterLists[self.id] do
		list[index].text = "|cffffff00"..prefix.." |cffc0c0c0("..count..")|r"; list[index].value = prefix:upper();
		index = (index + 1);
	end
	sort(list,SortMenuItemsFunc);
end

local function DropDown_SelectValue(self,entry,index)
	cfg["filter"..self.id] = entry.value;
	core:BuildTextureList();
end

core.dropDown1 = AzDropDown.CreateDropDown(core,133,true,DropDown_Init,DropDown_SelectValue);
core.dropDown1:SetPoint("BOTTOMLEFT",13,13);
core.dropDown1.label:SetText("Display Mode...");
core.dropDown1.id = 1;

core.dropDown2 = AzDropDown.CreateDropDown(core,133,true,DropDown_Init,DropDown_SelectValue);
core.dropDown2:SetPoint("LEFT",core.dropDown1,"RIGHT",10,0);
core.dropDown2.label:SetText("Display Mode...");
core.dropDown2.id = 2;

core.dropDown3 = AzDropDown.CreateDropDown(core,133,true,DropDown_Init,DropDown_SelectValue);
core.dropDown3:SetPoint("LEFT",core.dropDown2,"RIGHT",10,0);
core.dropDown3.label:SetText("Display Mode...");
core.dropDown3.id = 3;

--------------------------------------------------------------------------------------------------------
--                                           Frame Functions                                          --
--------------------------------------------------------------------------------------------------------

-- Add Texture -- Some icons appear more than once, this makes sure each unique icon is only added once to the full list
local function AddTexture(texture)
	--texture = texture:sub(TEXTURE_PATH:len() + 1,-1);	-- MoP: given texture paths no longer have "Interface\\Icons\\" prefixed.
	local textureUpper = texture:upper();
	local count = (textureList[textureUpper] or 0);
	textureList[textureUpper] = (count + 1);
	if (count == 0) then
		allTextures[#allTextures + 1] = texture;
	end
end

-- OnShow
local function OnShow(self)
	wipe(textureList);	-- Az: no need to call this here? already empty initially and cleared during OnHide()?
	-- Macro & Item Textures -- Az: MoP OBSOLETE CODE
--	for i = 1, GetNumMacroIcons() do
--		AddTexture(GetMacroIconInfo(i));
--	end
--	for i = 1, GetNumMacroItemIcons() do
--		AddTexture(GetMacroItemIconInfo(i));
--	end
	-- Az: MoP Use GetMacroIcons() and GetMacroItemIcons() now -- Unsure if these functions will clear the supplied list, or just fill it from the last index? That is why it's done twice, in this "safe" way.
	GetMacroIcons(textureQueryList);
	for _, texture in ipairs(textureQueryList) do
		AddTexture(texture);
	end
	wipe(textureQueryList);
	GetMacroItemIcons(textureQueryList);
	for _, texture in ipairs(textureQueryList) do
		AddTexture(texture);
	end
	wipe(textureQueryList);
	-- Achievement Textures -- Az: Achievement Statistic is not used, as it doesn't provide any additional textures
	for i = 1, GetCategoryNumAchievements(-1) do
		local _, _, _, _, _, _, _, _, _, icon = GetAchievementInfo(-1,i);
		if (icon and icon ~= "") then
			AddTexture(icon);
		end
	end
	-- Achievement Feats of Strength Textures
	for i = 1, 10000 do
		local success, id, _, _, _, _, _, _, _, _, icon = pcall(GetAchievementInfo,i);
		if (success and id) and (GetAchievementCategory(id) == 81) then
			AddTexture(icon);
		end
	end
	-- Spells
	for i = 1, 150000 do
		local _, _, icon = GetSpellInfo(i);
		if (icon) then
			AddTexture(icon);
		end

	end
	-- Build Texture List
	self:BuildTextureList();
end

-- OnHide -- Do an extreme cleanup here, we want to free up as much memory when done
local function OnHide(self)
	self.texture:SetTexture(nil);
	for i = 1, MAX_ENTRIES do
		local btn = core.entries[i];
		btn.texture:SetTexture(nil);
		btn.path:SetText(nil);
	end
	wipe(allTextures);
	wipe(textureList);
	for i = 1, MAX_FILTERS do
		if (filterLists[i]) then
			wipe(filterLists[i]);
		end
	end
	wipe(filterLists);
	collectgarbage();
end

-- Event
function core:VARIABLES_LOADED(event)
	if (not TextureBrowser_Config) then
		TextureBrowser_Config = {};
	end
	cfg = setmetatable(TextureBrowser_Config,{ __index = defConfig });
end
core:RegisterEvent("VARIABLES_LOADED");

--------------------------------------------------------------------------------------------------------
--                                          Initialize Frame                                          --
--------------------------------------------------------------------------------------------------------

core:SetWidth(444);
core:SetHeight(MAX_ENTRIES * ITEM_SIZE + 66 + 30);
core:SetPoint("CENTER");
core:SetBackdrop({ bgFile = "Interface\\ChatFrame\\ChatFrameBackground", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16, insets = { left = 3, right = 3, top = 3, bottom = 3 } });
core:SetBackdropColor(0.1,0.22,0.35,1);
core:SetBackdropBorderColor(0.1,0.1,0.1,1);
core:EnableMouse(1);
core:SetMovable(1);
core:SetToplevel(1);
core:SetClampedToScreen(1);
core:Hide();

core:SetScript("OnShow",OnShow);
core:SetScript("OnHide",OnHide);
core:SetScript("OnEvent",function(self,event,...) self[event](self,event,...) end);
core:SetScript("OnMouseDown",core.StartMoving);
core:SetScript("OnMouseUp",core.StopMovingOrSizing);

core.outline = CreateFrame("Frame",nil,core);
core.outline:SetBackdrop({ bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16, insets = { left = 4, right = 4, top = 4, bottom = 4 } });
core.outline:SetBackdropColor(0.1,0.1,0.2,1);
core.outline:SetBackdropBorderColor(0.8,0.8,0.9,0.4);
core.outline:SetPoint("TOPLEFT",12,-38);
core.outline:SetPoint("BOTTOMRIGHT",-12,42);

core.close = CreateFrame("Button",nil,core,"UIPanelCloseButton");
core.close:SetPoint("TOPRIGHT",-4,-4);
core.close:SetScript("OnClick",function(self,button,down) core:Hide(); end);

core.header = core:CreateFontString(nil,"ARTWORK","GameFontHighlight");
core.header:SetPoint("TOPLEFT",12,-12);
core.header:SetFont(core.header:GetFont(),26,"THICKOUTLINE");

core.texture = core:CreateTexture("ARTWORK",nil);
core.texture:SetPoint("TOPLEFT",core,"TOPRIGHT",4,0)
core.texture:SetWidth(PREVIEW_SIZE);
core.texture:SetHeight(PREVIEW_SIZE);
core.texture:SetTexCoord(0.07,0.93,0.07,0.93);

--------------------------------------------------------------------------------------------------------
--                                               Entries                                              --
--------------------------------------------------------------------------------------------------------

core.entries = {};

-- OnClick
local function Entry_OnClick(self,button)
	local editBox = ChatEdit_GetActiveWindow();
	if (IsModifiedClick("CHATLINK")) and (editBox) and (editBox:IsVisible()) then
		editBox:Insert(self.texture:GetTexture():gsub("\\","\\\\"));
	end
end

-- OnEnter
local function Entry_OnEnter(self)
	core.texture:SetTexture(self.texture:GetTexture());
end

-- OnLeave
local function Entry_OnLeave(self)
	core.texture:SetTexture(nil);
end

-- Make Entries
for i = 1, MAX_ENTRIES do
	local btn = CreateFrame("Button",nil,core);
	btn:SetHeight(ITEM_SIZE);

	btn:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestLogTitleHighlight");
	btn:GetHighlightTexture():SetVertexColor(0.1,0.22,0.35);
	btn:SetScript("OnClick",Entry_OnClick);
	btn:SetScript("OnEnter",Entry_OnEnter);
	btn:SetScript("OnLeave",Entry_OnLeave);

	btn.texture = btn:CreateTexture(nil,"ARTWORK");
	btn.texture:SetPoint("TOPLEFT",2,-2);
	btn.texture:SetPoint("BOTTOMLEFT",2,2);
	btn.texture:SetWidth(ITEM_SIZE - 4);
	btn.texture:SetTexCoord(0.07,0.93,0.07,0.93);

	btn.path = btn:CreateFontString(nil,"ARTWORK","GameFontHighlight");
	btn.path:SetPoint("LEFT",btn.texture,"RIGHT",4,0);
	btn.path:SetTextColor(1,1,1);

	if (i == 1) then
		btn:SetPoint("TOPLEFT",18,-46);
		btn:SetPoint("TOPRIGHT",-12,-46);
	else
		btn:SetPoint("TOPLEFT",core.entries[#core.entries],"BOTTOMLEFT");
		btn:SetPoint("TOPRIGHT",core.entries[#core.entries],"BOTTOMRIGHT");
	end

	core.entries[i] = btn;
end

-- Scroll
core.scroll = CreateFrame("ScrollFrame",modName.."Scroll",core,"FauxScrollFrameTemplate");
core.scroll:SetPoint("TOPLEFT",core.entries[1]);
core.scroll:SetPoint("BOTTOMRIGHT",core.entries[#core.entries],-28,-1);
core.scroll:SetScript("OnVerticalScroll",function(self,offset) local func = core.UpdateList; FauxScrollFrame_OnVerticalScroll(self,offset,ITEM_SIZE,func); end);
FauxScrollFrame_Update(core.scroll,#core.entries,MAX_ENTRIES,ITEM_SIZE);

--------------------------------------------------------------------------------------------------------
--                                           Slash Handling                                           --
--------------------------------------------------------------------------------------------------------

_G["SLASH_"..modName.."1"] = "/tb";
_G["SLASH_"..modName.."2"] = "/texturebrowser";
SlashCmdList[modName] = function(cmd)
	-- Show/Hide Dialog
	if (core:IsVisible()) then
		core:Hide();
	else
		core:Show();
		if (FirstTimeInitialize) then
			FirstTimeInitialize();
		end
	end
end