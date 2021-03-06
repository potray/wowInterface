local aName, aObj = ...
-- This is a Library
local _G = _G

function aObj:LibExtraTip()
	if not self.db.profile.Tooltips.skin or self.initialized.LibExtraTip then return end
	self.initialized.LibExtraTip = true

	local lib = _G.LibStub("LibExtraTip-1")

	-- hook this to skin extra tooltips
	self:RawHook(lib, "GetFreeExtraTipObject", function(this)
		local ttip = self.hooks[lib].GetFreeExtraTipObject(this)
		self:skinTooltip(ttip)
		if not ttip.sknd then
			ttip.sknd = true
			if self.db.profile.Tooltips.style == 3 then ttip:SetBackdrop(self.Backdrop[1]) end
			self:HookScript(ttip, "OnShow", function(this)
				self:skinTooltip(this)
			end)
		end
		return ttip
	end, true)

end
