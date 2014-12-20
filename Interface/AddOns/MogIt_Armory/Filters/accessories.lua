local mog = MogIt;
local _,a = ...;

local f = mog:CreateFilter("armory_accessories");

f:SetHeight(62);

f.label = f:CreateFontString(nil,nil,"GameFontHighlightSmall");
f.label:SetPoint("TOPLEFT");
f.label:SetPoint("RIGHT");
f.label:SetText("Accessories:");
f.label:SetJustifyH("LEFT");

f.tabard = CreateFrame("CheckButton",nil,f,"UICheckButtonTemplate");
f.tabard.text:SetText("Show tabards");
f.tabard:SetPoint("TOPLEFT",f.label,"BOTTOMLEFT");
f.tabard:SetScript("OnClick",function(self)
	a.showTabard = self:GetChecked() == 1;
	mog.scroll:update();
end);

f.shirt = CreateFrame("CheckButton",nil,f,"UICheckButtonTemplate");
f.shirt.text:SetText("Show shirts");
f.shirt:SetPoint("TOPLEFT",f.label,"BOTTOMLEFT",0,-26);
f.shirt:SetScript("OnClick",function(self)
	a.showShirt = self:GetChecked() == 1;
	mog.scroll:update();
end);

function f.Filter()
	return true;
end

function f.Default()
	a.showTabard = true;
	f.tabard:SetChecked(true);
	
	a.showShirt = true;
	f.shirt:SetChecked(true);
end
f.Default();