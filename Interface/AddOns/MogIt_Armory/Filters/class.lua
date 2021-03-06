local mog = MogIt;

local f = mog:CreateFilter("armory_class");
local coords = CLASS_ICON_TCOORDS;
local colours = RAID_CLASS_COLORS;
local classes = {};
local num;
local all;

f:SetHeight(41);

f.class = f:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall");
f.class:SetPoint("TOPLEFT",f,"TOPLEFT",0,0);
f.class:SetPoint("RIGHT",f,"RIGHT",0,0);
f.class:SetText(CLASS..":");
f.class:SetJustifyH("LEFT");

f.dd = CreateFrame("Frame","MogItArmoryFiltersClassDropdown",f,"UIDropDownMenuTemplate");
f.dd:SetPoint("TOPLEFT",f.class,"BOTTOMLEFT",-16,-2);
UIDropDownMenu_SetWidth(f.dd,125);
UIDropDownMenu_SetButtonWidth(f.dd,140);
UIDropDownMenu_JustifyText(f.dd,"LEFT");

function f.dd.SelectAll(self)
	num = 0;
	class = 0;
	for k,v in pairs(LOCALIZED_CLASS_NAMES_MALE) do
		classes[k] = all;
		num = num + (all and 1 or 0);
	end
	all = not all;
	UIDropDownMenu_SetText(f.dd,("%d selected"):format(num));
	ToggleDropDownMenu(1,nil,f.dd);
	mog:BuildList();
end

function f.dd.Tier1(self)
	if classes[self.value] and (not self.checked) then
		num = num - 1;
	elseif (not classes[self.value]) and self.checked then
		num = num + 1;
	end
	classes[self.value] = self.checked;
	UIDropDownMenu_SetText(f.dd,("%d selected"):format(num));
	mog:BuildList();
end

function f.dd.initialize(self)
	local info;
	info = UIDropDownMenu_CreateInfo();
	info.text =	all and "Select All" or "Select None";
	info.func = f.dd.SelectAll;
	info.notCheckable = true;
	UIDropDownMenu_AddButton(info);
	
	for k,v in pairs(LOCALIZED_CLASS_NAMES_MALE) do
		info = UIDropDownMenu_CreateInfo();
		info.text =	v;
		info.value = k;
		info.colorCode = "\124c"..colours[k].colorStr;
		info.func = f.dd.Tier1;
		info.keepShownOnClick = true;
		info.isNotRadio = true;
		info.checked = classes[k];
		info.icon = "Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes";
		info.tCoordLeft = coords[k][1];
		info.tCoordRight = coords[k][2];
		info.tCoordTop = coords[k][3];
		info.tCoordBottom = coords[k][4];
		UIDropDownMenu_AddButton(info);
	end
end

function f.Filter(input)
	return (not input) or classes[input]; 
end

function f.Default()
	num = 0;
	for k,v in pairs(LOCALIZED_CLASS_NAMES_MALE) do
		classes[k] = true;
		num = num + 1;
	end
	all = nil;
	UIDropDownMenu_SetText(f.dd,("%d selected"):format(num));
end
f.Default();