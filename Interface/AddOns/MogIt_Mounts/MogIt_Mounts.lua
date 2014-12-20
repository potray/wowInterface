local MogIt_Mounts,m = ...;
local mog = MogIt;

local module = mog:RegisterModule(MogIt_Mounts,tonumber(GetAddOnMetadata(MogIt_Mounts, "X-MogItModuleVersion")));
local mounts = {
	Ground = {},
	Flying = {},
	Aquatic = {},
};
local list = {};
local data = {
	item = {},
	spell = {},
	lvl = {},
	class = {},
	race = {},
};

local function AddData(display,spell,item,lvl,class,race)
	data.item[display] = item;
	data.spell[display] = spell;
end

function m.AddGround(display,...)
	tinsert(mounts.Ground,display);
	AddData(display,...);
end

function m.AddFlying(display,...)
	tinsert(mounts.Flying,display);
	AddData(display,...);
end

function m.AddAquatic(display,...)
	tinsert(mounts.Aquatic,display);
	AddData(display,...);
end

local function DropdownTier2(self)
	self.arg1.active = self.value;
	mog:SetModule(self.arg1,"Mounts - "..self.value);
	CloseDropDownMenus();
end

function module.Dropdown(module,tier)
	local info;
	if tier == 1 then
		info = UIDropDownMenu_CreateInfo();
		info.text = module.label;
		info.value = module;
		info.colorCode = "\124cFF00FF00";
		info.hasArrow = true;
		info.keepShownOnClick = true;
		info.notCheckable = true;
		UIDropDownMenu_AddButton(info,tier);
	elseif tier == 2 then
		for k,v in pairs(mounts) do
			info = UIDropDownMenu_CreateInfo();
			info.text = k;
			info.value = k;
			info.notCheckable = true;
			info.func = DropdownTier2;
			info.arg1 = module;
			UIDropDownMenu_AddButton(info,tier);
		end
	end
end

function module.FrameUpdate(module,self,value)
	self.data.display = value;
	self.data.spell = data.spell[value];
	self.data.item = data.item[value];
	self.model:SetDisplayInfo(value);
end

function module.OnEnter(module,self)
	if not self or not self.data.display then return end;
	GameTooltip:SetOwner(self,"ANCHOR_RIGHT");
	GameTooltip[mog] = true;

	local name,_,icon = GetSpellInfo(self.data.spell);
	local link = GetSpellLink(self.data.spell);
	GameTooltip:AddLine("\124T"..icon..":18\124t "..(link or name),0,1,0);
	if self.data.item then
		local _,link = mog:GetItemInfo(self.data.item,"ModelOnEnter");
		if link then
			GameTooltip:AddDoubleLine("Item:",link);
		end
	end

	GameTooltip:Show();
end

function module.OnClick(module,self,btn)
	if btn == "LeftButton" then
		if IsShiftKeyDown() then
			local link = GetSpellLink(self.data.spell);
			if link then
				ChatEdit_InsertLink(link);
			end
		elseif IsControlKeyDown() then
			if self.data.item then
				local _,link = GetItemInfo(self.data.item);
				if link then
					ChatEdit_InsertLink(link);
				end
			end
		end
	elseif btn == "RightButton" then
		if IsShiftKeyDown() then
			mog:ShowURL(self.data.spell,"spell");
		elseif IsControlKeyDown() then
			if self.data.item then
				mog:ShowURL(self.data.item);
			end
		end
	end
end

function module.Unlist(module)
	wipe(list);
	for k,v in ipairs(mog.models) do
		v.model:SetUnit("PLAYER");
	end
end

function module.BuildList(module)
	wipe(list);
	for k,v in ipairs(mounts[module.active]) do
		tinsert(list,v);
	end
	return list;
end

module.Help = {

	"Shift-left click to link spell",
	"Shift-right click for spell URL",
	"Ctrl-left click to link item",
	"Ctrl-right click for item URL",
};
