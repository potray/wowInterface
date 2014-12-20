local MogIt_Pets,p = ...;
local mog = MogIt;

do
	local f=mog:CreateFilter("PetFamily");
	local selected;
	local num;
	local all;

	f:SetHeight(41);

	f.family = f:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall");
	f.family:SetPoint("TOPLEFT",f,"TOPLEFT",0,0);
	f.family:SetPoint("RIGHT",f,"RIGHT",0,0);
	f.family:SetText("Family:");
	f.family:SetJustifyH("LEFT");

	f.dd = CreateFrame("Frame","MogIt_Pets_FamilyDropdown",f,"UIDropDownMenuTemplate");
	f.dd:SetPoint("TOPLEFT",f.family,"BOTTOMLEFT",-16,-2);
	UIDropDownMenu_SetWidth(f.dd,125);
	UIDropDownMenu_SetButtonWidth(f.dd,140);
	UIDropDownMenu_JustifyText(f.dd,"LEFT");
	function f.dd.initialize(self)
		local info;
		info = UIDropDownMenu_CreateInfo();
		info.text =	all and "Select All" or "Select None";
		info.func = function(self)
			num = 0;
			for k,v in pairs(p.family.name) do
				selected[k] = all;
				num = num + (all and 1 or 0);
			end
			all = not all;
			UIDropDownMenu_SetText(f.dd,("%d selected"):format(num));
			ToggleDropDownMenu(1,nil,f.dd);
			mog:BuildList();
		end
		info.notCheckable = true;
		UIDropDownMenu_AddButton(info);
		
		local tbl = {};
		for k,v in pairs(p.family.name) do
			table.insert(tbl,k);
		end
		table.sort(tbl,function(a,b)
			return p.family.name[a] < p.family.name[b];
		end);
		for k,v in ipairs(tbl) do
			info = UIDropDownMenu_CreateInfo();
			info.text =	p.family.name[v];
			info.value = v;
			info.func = function(self)
				if selected[self.value] and (not self.checked) then
					num = num - 1;
				elseif (not selected[self.value]) and self.checked then
					num = num + 1;
				end
				selected[self.value] = self.checked;
				UIDropDownMenu_SetText(f.dd,("%d selected"):format(num));
				mog:BuildList();
			end
			info.keepShownOnClick = true;
			info.isNotRadio = true;
			info.checked = selected[v];
			UIDropDownMenu_AddButton(info);
		end
	end

	function f.Filter(family)
		return (not family) or selected[family];
	end

	function f.Default()
		selected = {};
		num = 0;
		all = nil;
		for k,v in pairs(p.family.name) do
			selected[k] = true;
			num = num + 1;
		end
		UIDropDownMenu_SetText(f.dd,("%d selected"):format(num));
	end
	f.Default();
end

do
	local f = mog:CreateFilter("PetExotic");
	local yes;
	local no;

	f:SetHeight(69);

	f.exotic = f:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall");
	f.exotic:SetPoint("TOPLEFT",f,"TOPLEFT",0,0);
	f.exotic:SetPoint("RIGHT",f,"RIGHT",0,0);
	f.exotic:SetText("Exotic:");
	f.exotic:SetJustifyH("LEFT");

	f.yes = CreateFrame("CheckButton","MogIt_Pets_ExoticYes",f,"UICheckButtonTemplate");
	MogIt_Pets_ExoticYesText:SetText("Exotic Pets");
	f.yes:SetPoint("TOPLEFT",f.exotic,"BOTTOMLEFT",0,0);
	f.yes:SetScript("OnClick",function(self)
		yes = self:GetChecked();
		mog:BuildList();
	end);

	f.no = CreateFrame("CheckButton","MogIt_Pets_ExoticNo",f,"UICheckButtonTemplate");
	MogIt_Pets_ExoticNoText:SetText("Non-Exotic Pets");
	f.no:SetPoint("TOPLEFT",f.yes,"BOTTOMLEFT",0,0);
	f.no:SetScript("OnClick",function(self)
		no = self:GetChecked();
		mog:BuildList();
	end);

	function f.Filter(value)
		if value then
			return yes;
		else
			return no;
		end
	end

	function f.Default()
		yes = true;
		f.yes:SetChecked(yes);
		no = true;
		f.no:SetChecked(no);
	end
	f.Default();
end

do
	local f = mog:CreateFilter("PetRare");
	local yes;
	local no;

	f:SetHeight(69);

	f.rare = f:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall");
	f.rare:SetPoint("TOPLEFT",f,"TOPLEFT",0,0);
	f.rare:SetPoint("RIGHT",f,"RIGHT",0,0);
	f.rare:SetText("Rare:");
	f.rare:SetJustifyH("LEFT");

	f.yes = CreateFrame("CheckButton","MogIt_Pets_RareYes",f,"UICheckButtonTemplate");
	MogIt_Pets_RareYesText:SetText("Rare Pets");
	f.yes:SetPoint("TOPLEFT",f.rare,"BOTTOMLEFT",0,0);
	f.yes:SetScript("OnClick",function(self)
		yes = self:GetChecked();
		mog:BuildList();
	end);

	f.no = CreateFrame("CheckButton","MogIt_Pets_RareNo",f,"UICheckButtonTemplate");
	MogIt_Pets_RareNoText:SetText("Non-Rare Pets");
	f.no:SetPoint("TOPLEFT",f.yes,"BOTTOMLEFT",0,0);
	f.no:SetScript("OnClick",function(self)
		no = self:GetChecked();
		mog:BuildList();
	end);

	function f.Filter(value)
		if value then
			return yes;
		else
			return no;
		end
	end

	function f.Default()
		yes = true;
		f.yes:SetChecked(yes);
		no = true;
		f.no:SetChecked(no);
	end
	f.Default();
end