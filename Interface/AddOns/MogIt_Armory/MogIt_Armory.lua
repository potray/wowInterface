local MogIt_Armory,a = ...;
local mog = MogIt;
_G.MogIt_Armory = a;

local module = mog:RegisterModule(MogIt_Armory,tonumber(GetAddOnMetadata(MogIt_Armory, "X-MogItModuleVersion")));
a.module = module;

local list = {};
local active;
a.showTabard = true;
a.showShirt = true;

local genders = {[0] = MALE, [1] = FEMALE};

local classColours = RAID_CLASS_COLORS;
local classNames = LOCALIZED_CLASS_NAMES_MALE;
local classes = {
	[8] = "MAGE",
	[5] = "PRIEST",
	[9] = "WARLOCK",
	[11] = "DRUID",
	[10] = "MONK",
	[4] = "ROGUE",
	[3] = "HUNTER",
	[7] = "SHAMAN",
	[6] = "DEATHKNIGHT",
	[2] = "PALADIN",
	[1] = "WARRIOR",
};
local function formatClass(str,class)
	if classColours[class] then
		str = "\124c"..classColours[class].colorStr..str.."\124r";
	end
	return str;
end

local addons = {
	{name = "Cloth", classes = formatClass("Mage","MAGE").." / "..formatClass("Priest","PRIEST").." / "..formatClass("Warlock","WARLOCK")},
	{name = "Leather", classes = formatClass("Druid","DRUID").." / "..formatClass("Monk","MONK").." / "..formatClass("Rogue","ROGUE")},
	{name = "Mail", classes = formatClass("Hunter","HUNTER").." / "..formatClass("Shaman","SHAMAN")},
	{name = "Plate", classes = formatClass("Death Knight","DEATHKNIGHT").." / "..formatClass("Paladin","PALADIN").." / "..formatClass("Warrior","WARRIOR")},
};
for _,addon in ipairs(addons) do
	if select(5,GetAddOnInfo("MogIt_Armory_"..addon.name)) then
		addon.loadable = true;
	end
end

local realms = {};
function a.AddRealm(id,region,realm,name,pvp,rp,lang)
	realms[id] = {
		id = id,
		region = region,
		realm = realm,
		name = name,
		pvp = pvp,
		rp = rp,
		lang = lang,
	};
end

local profiles = {
	Alliance = {
		{label = "Human", id = 1, [0] = {}, [1] = {}},
		{label = "Dwarf", id = 3, [0] = {}, [1] = {}},
		{label = "Night Elf", id = 4, [0] = {}, [1] = {}},
		{label = "Gnome", id = 7, [0] = {}, [1] = {}},
		{label = "Draenei", id = 11, [0] = {}, [1] = {}},
		{label = "Worgen", id = 22, [0] = {}, [1] = {}},
	},
	Horde = {
		{label = "Orc", id = 2, [0] = {}, [1] = {}},
		{label = "Undead", id = 5, [0] = {}, [1] = {}},
		{label = "Tauren", id = 6, [0] = {}, [1] = {}},
		{label = "Troll", id = 8, [0] = {}, [1] = {}},
		{label = "Blood Elf", id = 10, [0] = {}, [1] = {}},
		{label = "Goblin", id = 9, [0] = {}, [1] = {}},
	},
	Other = {
		{label = "Pandaren", id = 24, [0] = {}, [1] = {}},
	},
};

local races = {
	-- Alliance
	[1] = profiles.Alliance[1], -- Human
	[3] = profiles.Alliance[2], -- Dwarf
	[4] = profiles.Alliance[3], -- Night Elf
	[7] = profiles.Alliance[4], -- Gnome
	[11] = profiles.Alliance[5], -- Draenei
	[22] = profiles.Alliance[6], -- Worgen
	
	-- Horde
	[2] = profiles.Horde[1], -- Orc
	[5] = profiles.Horde[2], -- Undead
	[6] = profiles.Horde[3], -- Tauren
	[8] = profiles.Horde[4], -- Troll
	[10] = profiles.Horde[5], -- Blood Elf
	[9] = profiles.Horde[6], -- Goblin

	-- Other
	[24] = profiles.Other[1], -- Pandaren (Neutral)
	[25] = profiles.Other[1], -- Pandaren (Alliance)
	[26] = profiles.Other[1], -- Pandaren (Horde)
};

function a.AddProfile(realm,name,class,race,gender,guild,transmog,tabard,shirt,featured)
	table.insert(races[race][gender],{
		realm = realm,
		name = name,
		class = class,
		race = race,
		gender = gender,
		guild = guild,
		transmog = transmog,
		tabard = tabard,
		shirt = shirt,
		featured = featured,
	});
end

function module.DropdownTier1(self)
	if not self.value.loaded then
		LoadAddOn(self.value.name);
	end
end

function module.DropdownLoadData(self)
	LoadAddOn("MogIt_Armory_"..self.value.name);
	self.value.loaded = true; -- replace with addon_loaded and reshow dropdown
	if mog:GetActiveModule() == module then
		mog:BuildList(true);
	end
end

function module.DropdownViewProfile(self)
	local str;
	if self.value == "all" then
		active = self.value;
		str = " - All";
		mog.displayRace = mog.playerRace;
		mog.displayGender = mog.playerGender;
	elseif self.value == 0 then
		active = "male";
		str = " - Male";
		mog.displayRace = mog.playerRace;
		mog.displayGender = 0;
	elseif self.value == 1 then
		active = "female";
		str = " - Female";
		mog.displayRace = mog.playerRace;
		mog.displayGender = 1;
	else
		active = self.value[self.arg1];
		str = " - "..genders[self.arg1].." - "..self.value.label;
		mog.displayRace = self.value.id;
		mog.displayGender = self.arg1;
	end
	
	mog.posX = 0;
	mog.posY = 0;
	mog.posZ = 0;
	for _,model in ipairs(mog.models) do
		model:ResetModel();
	end
	
	mog:SetModule(module,module.label..str);
	CloseDropDownMenus();
end

function module.Dropdown(module,tier)
	if tier == 1 then
		local info;
		info = UIDropDownMenu_CreateInfo();
		info.text = module.label..(module.loaded and "" or " \124cFFFFFFFF("..L["Click to load addon"]..")");
		info.value = module;
		info.colorCode = "\124cFF"..(module.loaded and "00FF00" or "FF0000");
		info.hasArrow = module.loaded;
		info.keepShownOnClick = true;
		info.notCheckable = true;
		info.func = module.DropdownTier1;
		UIDropDownMenu_AddButton(info,tier);
	elseif tier == 2 then
		local info;
		info = UIDropDownMenu_CreateInfo();
		info.text = "Load Data";
		info.isTitle = true;
		info.notCheckable = true;
		info.justifyH = "CENTER";
		UIDropDownMenu_AddButton(info,tier);
		
		for _,addon in ipairs(addons) do
			info = UIDropDownMenu_CreateInfo();
			if addon.loaded then
				info.text = addon.name.." profiles loaded";
				info.disabled = true;
			elseif addon.loadable then
				info.text = addon.name.." ("..addon.classes..")";
			else
				info.text = addon.name.." addon not found";
				info.disabled = true;
			end
			info.value = addon;
			--info.keepShownOnClick = true;
			info.notCheckable = true;
			info.func = module.DropdownLoadData;
			UIDropDownMenu_AddButton(info,tier);
		end
		
		info = UIDropDownMenu_CreateInfo();
		info.isTitle = true;
		info.notCheckable = true;
		UIDropDownMenu_AddButton(info,tier);
		
		info = UIDropDownMenu_CreateInfo();
		info.text = "View Profiles";
		info.isTitle = true;
		info.notCheckable = true;
		info.justifyH = "CENTER";
		UIDropDownMenu_AddButton(info,tier);
		
		info = UIDropDownMenu_CreateInfo();
		info.text = "All";
		info.value = "all";
		info.func = module.DropdownViewProfile;
		info.notCheckable = true;
		UIDropDownMenu_AddButton(info,tier);
		
		info = UIDropDownMenu_CreateInfo();
		info.text = "Male";
		info.value = 0;
		info.func = module.DropdownViewProfile;
		info.notCheckable = true;
		info.hasArrow = true;
		UIDropDownMenu_AddButton(info,tier);
		
		info = UIDropDownMenu_CreateInfo();
		info.text = "Female";
		info.value = 1;
		info.func = module.DropdownViewProfile;
		info.notCheckable = true;
		info.hasArrow = true;
		UIDropDownMenu_AddButton(info,tier);
	elseif tier == 3 then
		local gender = UIDROPDOWNMENU_MENU_VALUE;
		for _,race in ipairs(profiles.Alliance) do
			info = UIDropDownMenu_CreateInfo();
			info.text = race.label.." \124cffffd200("..#race[gender]..")\124r";
			info.value = race;
			info.arg1 = gender;
			info.func = module.DropdownViewProfile;
			info.notCheckable = true;
			UIDropDownMenu_AddButton(info,tier);
		end

		info = UIDropDownMenu_CreateInfo();
		info.isTitle = true;
		info.notCheckable = true;
		UIDropDownMenu_AddButton(info,tier);

		for _,race in ipairs(profiles.Horde) do
			info = UIDropDownMenu_CreateInfo();
			info.text = race.label.." \124cffffd200("..#race[gender]..")\124r";
			info.value = race;
			info.arg1 = gender;
			info.func = module.DropdownViewProfile;
			info.notCheckable = true;
			UIDropDownMenu_AddButton(info,tier);
		end
		
		info = UIDropDownMenu_CreateInfo();
		info.isTitle = true;
		info.notCheckable = true;
		UIDropDownMenu_AddButton(info,tier);

		for _,race in ipairs(profiles.Other) do
			info = UIDropDownMenu_CreateInfo();
			info.text = race.label.." \124cffffd200("..#race[gender]..")\124r";
			info.value = race;
			info.arg1 = gender;
			info.func = module.DropdownViewProfile;
			info.notCheckable = true;
			UIDropDownMenu_AddButton(info,tier);
		end
	end
end

local slots = {
	"HeadSlot",
	"ShoulderSlot",
	"BackSlot",
	"ChestSlot",
	"WristSlot",
	"HandsSlot",
	"WaistSlot",
	"LegsSlot",
	"FeetSlot",
	"MainHandSlot",
	"SecondaryHandSlot",
};

function module.FrameUpdate(module,self,value)
	self.data.profile = value;
	self.data.items = {};
	for i,item in pairs(self.data.profile.transmog) do
		self.data.items[slots[i]] = item;
	end
	if a.showTabard and value.tabard then
		self.data.items.TabardSlot = value.tabard;
	end
	if a.showShirt and value.shirt then
		self.data.items.ShirtSlot = value.shirt;
	end
	self.data.name = formatClass(value.name,classes[value.class]).." - "..realms[value.realm].name.." ("..realms[value.realm].region:upper()..")";
	
	if self.indicators.label then
		self.indicators.label:SetText();
	end
	
	mog.Set_FrameUpdate(self,self.data);
	
	if value.featured then
		self:ShowIndicator("armory_featured");
		self:ShowIndicator("armory_website");
		--self.bg:SetTexture(1,0.82,0,0.1); (0.8,0.3,0.8,0.1); (0.3,0.3,0.3,0.2);
	end
end

function module.OnEnter(module,self,value)
	local profile = self.data.profile;
	mog.ShowSetTooltip(self,self.data.items,self.data.name);
	
	GameTooltip:AddLine(" ");
	GameTooltip:AddDoubleLine("Gender:",genders[profile.gender],nil,nil,nil,1,1,1);
	GameTooltip:AddDoubleLine("Race:",races[profile.race].label,nil,nil,nil,1,1,1);
	GameTooltip:AddDoubleLine("Class:",classNames[classes[profile.class]],nil,nil,nil,1,1,1);
	
	if profile.guild then
		GameTooltip:AddDoubleLine("Guild:",profile.guild,nil,nil,nil,1,1,1);
	end
	
	GameTooltip:Show();
end

local url = "http://%s.battle.net/wow/en/character/%s/%s/";
mog.url["Battle.net"].character = function(profile)
	return url:format(realms[profile.realm].region,realms[profile.realm].realm,profile.name);
end

function module.OnClick(module,self,btn,value)
	if btn == "LeftButton" and (not (IsShiftKeyDown() or IsControlKeyDown())) then
		mog:ShowURL(self.data.profile,"character","Battle.net");
	elseif btn == "LeftButton" and IsShiftKeyDown() then
		ChatEdit_InsertLink(mog:SetToLink(self.data.items,mog.displayRace,mog.displayGender));
	elseif btn == "RightButton" and IsControlKeyDown() then
		local preview = mog:GetPreview();
		preview.data.displayRace = mog.displayRace;
		preview.data.displayGender = mog.displayGender;
		preview.model:ResetModel();
		preview.model:Undress();
		mog:AddToPreview(self.data.items, preview);
	else
		mog.Set_OnClick(self,btn,self.data);
	end
end

function module.Unlist(module)
	wipe(list);
end

local function defaultSort(a,b)
	if a.featured and (not b.featured) then
		return true;
	elseif b.featured and (not a.featured) then
		return false;
	else
		if a.name == b.name then
			return a.realm < b.realm;
		else
			return a.name < b.name;
		end
	end
end

local function addToList(tbl)
	for _,profile in ipairs(tbl) do
		if mog:CheckFilters(module,profile) then
			table.insert(list,profile);
		end
	end
end

function module.BuildList(module)
	wipe(list);
	
	if active then
		if active == "all" or active == "male" then
			for faction,races in pairs(profiles) do
				for _,race in ipairs(races) do
					addToList(race[0]);
				end
			end
		end
		if active == "all" or active == "female" then
			for faction,races in pairs(profiles) do
				for _,race in ipairs(races) do
					addToList(race[1]);
				end
			end
		end
		if type(active) == "table" then
			addToList(active);
		end
		table.sort(list,defaultSort);
	end
	
	return list;
end

module.Help = {
	"Left click for character URL",
	"Right click for additional options",
	"Shift-left click to link",
	"Shift-right click for set URL",
	"Ctrl-left click to try on in dressing room",
	"Ctrl-right click to preview with MogIt",
};

function module.GetFilterArgs(filter,profile)
	if filter == "armory_player" then
		return profile.name;
	elseif filter == "armory_guild" then
		return profile.guild;
	elseif filter == "armory_realm" then
		return realms[profile.realm];
	elseif filter == "armory_class" then
		return classes[profile.class];
	end
end

module.filters = {
	"armory_player",
	"armory_guild",
	"armory_realm",
	"armory_class",
	"armory_accessories",
};

mog:CreateIndicator("armory_featured", function(model)
	local featured = model:CreateTexture(nil, "BACKGROUND");
	featured:SetTexture("Interface\\AddOns\\MogIt_Armory\\Images\\featured_stripe");
	featured:SetSize(128,128);
	featured:SetPoint("TOPLEFT", 0, 0);
	return featured;
end);

local function websiteOnClick(self,btn)
	local profile = self.model.data.profile;
	StaticPopup_Show("MOGIT_ARMORY_URL",profile.featured[1],nil,profile.featured[2]);
end

local function websiteOnEnter(self)
	local profile = self.model.data.profile;
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	
	GameTooltip:AddLine(profile.featured[1]);
	GameTooltip:AddLine("Click here for a link",1,1,1);

	GameTooltip:Show()
end

local function websiteOnLeave(self)
	GameTooltip:Hide();
end

mog:CreateIndicator("armory_website", function(model)
	local website = CreateFrame("Button",nil,model);
	website.model = model:GetParent();
	website:SetSize(70,70);
	website:SetPoint("TOPLEFT", 1, 1);
	website:SetScript("OnClick",websiteOnClick);
	website:SetScript("OnEnter",websiteOnEnter);
	website:SetScript("OnLeave",websiteOnLeave);
	return website;
end);

StaticPopupDialogs["MOGIT_ARMORY_URL"] = {
	text = "%s",
	button1 = CLOSE,
	hasEditBox = 1,
	maxLetters = 512,
	editBoxWidth = 260,
	OnShow = function(self,url)
		self.editBox:SetText(url);
		self.editBox:SetFocus();
		self.editBox:HighlightText();
	end,
	EditBoxOnEnterPressed = function(self)
		self:GetParent():Hide();
	end,
	EditBoxOnEscapePressed = function(self)
		self:GetParent():Hide();
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1
};

--[=[
local frame = CreateFrame("Frame");
frame:SetScript("OnEvent",function(self,event,arg1,...)
	if event == "ADDON_LOADED" then
		local addon = arg1:match("^MogIt_Armory_(.+)");
		if addon then
			if mog.menu.active == mog.menu.modules and mog.IsDropdownShown(mog.menu) then
				--HideDropDownMenu(1);
				--ToggleDropDownMenu(level, value, dropDownFrame, anchorName, xOffset, yOffset, menuList, button, autoHideDelay)
			end
		end
	end
end);
frame:RegisterEvent("ADDON_LOADED");
--]=]