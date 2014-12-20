local mog = MogIt;

local f = mog:CreateFilter("armory_realm");
local searchString;
local realmTypes = {
	PvE = {},
	PvP = {},
};
local regions = {};

f:SetHeight(112);

f.label = f:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall");
f.label:SetPoint("TOPLEFT",f,"TOPLEFT",0,0);
f.label:SetPoint("RIGHT",f,"RIGHT",0,0);
f.label:SetText("Realm:");
f.label:SetJustifyH("LEFT");

f.edit = CreateFrame("EditBox","MogItArmoryFiltersRealm",f,"SearchBoxTemplate");
f.edit:SetHeight(16);
f.edit:SetPoint("TOPLEFT",f.label,"BOTTOMLEFT",8,-5);
f.edit:SetPoint("RIGHT",f.label,"RIGHT",-2,0);
f.edit:SetAutoFocus(false);
f.edit:SetScript("OnEnterPressed",EditBox_ClearFocus);
f.edit:SetScript("OnTextChanged",function(self,user)
	if user then
		searchString = self:GetText()-- or "";
		searchString = searchString:lower();
		mog:BuildList();
	end
end);
function f.edit.clearFunc(self)
	searchString = "";
	mog:BuildList();
end

local function setRegion(self)
	regions[self.value] = self:GetChecked() == 1;
	mog:BuildList();
end

local function setRealmType(self)
	realmTypes[self.pvp][self.rp] = self:GetChecked() == 1;
	mog:BuildList();
end

f.eu = CreateFrame("CheckButton",nil,f,"UICheckButtonTemplate");
f.eu.text:SetText("EU");
f.eu:SetPoint("TOPLEFT",f.label,"BOTTOMLEFT",0,-24);
f.eu.value = "eu";
f.eu:SetScript("OnClick",setRegion);

f.us = CreateFrame("CheckButton",nil,f,"UICheckButtonTemplate");
f.us.text:SetText("US");
f.us:SetPoint("TOPLEFT",f.label,"BOTTOMLEFT",75,-24);
f.us.value = "us";
f.us:SetScript("OnClick",setRegion);

f.normal = CreateFrame("CheckButton",nil,f,"UICheckButtonTemplate");
f.normal.text:SetText("Normal");
f.normal:SetPoint("TOPLEFT",f.label,"BOTTOMLEFT",0,-50);
f.normal.pvp = "PvE";
f.normal.rp = "Normal";
f.normal:SetScript("OnClick",setRealmType);

f.pvp = CreateFrame("CheckButton",nil,f,"UICheckButtonTemplate");
f.pvp.text:SetText("PvP");
f.pvp:SetPoint("TOPLEFT",f.label,"BOTTOMLEFT",75,-50);
f.pvp.pvp = "PvP";
f.pvp.rp = "Normal";
f.pvp:SetScript("OnClick",setRealmType);

f.rp = CreateFrame("CheckButton",nil,f,"UICheckButtonTemplate");
f.rp.text:SetText("RP");
f.rp:SetPoint("TOPLEFT",f.label,"BOTTOMLEFT",0,-76);
f.rp.pvp = "PvE";
f.rp.rp = "RP";
f.rp:SetScript("OnClick",setRealmType);

f.rppvp = CreateFrame("CheckButton",nil,f,"UICheckButtonTemplate");
f.rppvp.text:SetText("RP-PvP");
f.rppvp:SetPoint("TOPLEFT",f.label,"BOTTOMLEFT",75,-76);
f.rppvp.pvp = "PvP";
f.rppvp.rp = "RP";
f.rppvp:SetScript("OnClick",setRealmType);

function f.Filter(realm)
	if regions[realm.region] and realmTypes[realm.pvp][realm.rp] then
		if searchString:trim() == "" then
			return true;
		end
		return realm.name and (realm.name:lower():find(searchString, nil, true));
	end
end

function f.Default()
	searchString = "";
	f.edit:SetText(searchString);
	
	regions.eu = true;
	f.eu:SetChecked(true);
	
	regions.us = true;
	f.us:SetChecked(true);
	
	realmTypes.PvE.Normal = true;
	f.normal:SetChecked(true);
	
	realmTypes.PvP.Normal = true;
	f.pvp:SetChecked(true);
	
	realmTypes.PvE.RP = true;
	f.rp:SetChecked(true);
	
	realmTypes.PvP.RP = true;
	f.rppvp:SetChecked(true);
end
f.Default();