-- slightly modified blizzard code

local modName, mod = ...

local CLC_HOLY_POWER_FULL = 3;
local CLC_PALADINPOWERBAR_SHOW_LEVEL = 9;

function clcPaladinPowerBar_ToggleHolyRune(self, visible)
	if visible then
		self.deactivate:Play();
	else
		self.activate:Play();
	end
end

function clcPaladinPowerBar_OnUpdate(self, elapsed)
	self.delayedUpdate = self.delayedUpdate - elapsed;
	if ( self.delayedUpdate <= 0 ) then
		self.delayedUpdate = nil;
		self:SetScript("OnUpdate", nil);
		clcPaladinPowerBar_Update(self);
	end
end

function clcPaladinPowerBar_Update(self)
	if ( self.delayedUpdate ) then
		return;
	end
	
	local numHolyPower = UnitPower( "player", SPELL_POWER_HOLY_POWER );
	local maxHolyPower = UnitPowerMax( "player", SPELL_POWER_HOLY_POWER );
	
	-- a little hacky but we want to signify that the bank is being used to replenish holy power
	if ( self.lastPower and self.lastPower > CLC_HOLY_POWER_FULL and numHolyPower == self.lastPower - CLC_HOLY_POWER_FULL ) then
		for i = 1, CLC_HOLY_POWER_FULL do
			clcPaladinPowerBar_ToggleHolyRune(self["rune"..i], true);
		end
		self.lastPower = nil;
		self.delayedUpdate = 0.5;
		self:SetScript("OnUpdate", clcPaladinPowerBar_OnUpdate);
		return;
	end
	
	for i=1,maxHolyPower do
		local holyRune = self["rune"..i];
		local isShown = holyRune:GetAlpha()> 0 or holyRune.activate:IsPlaying();
		local shouldShow = i <= numHolyPower;
		if isShown ~= shouldShow then 
			clcPaladinPowerBar_ToggleHolyRune(holyRune, isShown);
		end
	end

	-- flash the bar if it's full (3 holy power)
	if numHolyPower >= CLC_HOLY_POWER_FULL then
		self.glow.pulse.stopPulse = false;
		self.glow.pulse:Play();
	else
		self.glow.pulse.stopPulse = true;
	end
	
	-- check whether to show bank slots
	if ( maxHolyPower ~= self.maxHolyPower ) then
		if ( maxHolyPower > CLC_HOLY_POWER_FULL ) then
			self.showBankAnim:Play();
		else
			-- there is no way to lose the bank slots once you have them, but just in case
			self.showBankAnim:Stop();
			self.bankBG:SetAlpha(0);
		end
		self.maxHolyPower = maxHolyPower;
	end
	
	self.lastPower = numHolyPower;
end



function clcPaladinPowerBar_OnLoad (self)
	-- Disable frame if not a paladin
	local _, class = UnitClass("player");	
	if ( class ~= "PALADIN" ) then
		self:Hide();
		return;
	elseif UnitLevel("player") < CLC_PALADINPOWERBAR_SHOW_LEVEL then
		self:RegisterEvent("PLAYER_LEVEL_UP");
		self:SetAlpha(0);
	end
	
	self.maxHolyPower = UnitPowerMax("player", SPELL_POWER_HOLY_POWER);
	if ( self.maxHolyPower > CLC_HOLY_POWER_FULL ) then
		self.bankBG:SetAlpha(1);
	end

	self:RegisterEvent("UNIT_POWER");
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self:RegisterEvent("UNIT_DISPLAYPOWER");
	
	self.glow:SetAlpha(0);
	self.rune1:SetAlpha(0);
	self.rune2:SetAlpha(0);
	self.rune3:SetAlpha(0);
	self.rune4:SetAlpha(0);
	self.rune5:SetAlpha(0);
end



function clcPaladinPowerBar_OnEvent (self, event, arg1, arg2)
	if ( (event == "UNIT_POWER") and (arg1 == "player") ) then
		if ( arg2 == "HOLY_POWER" ) then
			clcPaladinPowerBar_Update(self);
		end
	elseif( event ==  "PLAYER_LEVEL_UP" ) then
		local level = arg1;
		if level >= CLC_PALADINPOWERBAR_SHOW_LEVEL then
			self:UnregisterEvent("PLAYER_LEVEL_UP");
			self.showAnim:Play();
			clcPaladinPowerBar_Update(self);
		end
	else
		clcPaladinPowerBar_Update(self);
	end
end