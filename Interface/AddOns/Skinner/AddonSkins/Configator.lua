-- This is a Library
local aName, aObj = ...
local _G = _G

function aObj:Configator()
	if self.initialized.Configator then return end
	self.initialized.Configator = true

	-- hook this to skin Slide bars
	local sblib = _G.LibStub("SlideBar", true)
	if sblib and sblib.frame then
		self:applySkin(sblib.frame)
		if self.db.profile.Tooltips.skin then
			if self.db.profile.Tooltips.style == 3 then sblib.tooltip:SetBackdrop(self.Backdrop[1]) end
			self:SecureHook(sblib.tooltip, "Show", function(this)
				self:skinTooltip(sblib.tooltip)
			end)
		end
	end

	local clib, ver = _G.LibStub("Configator", true)
	local function skinHelp()

		aObj:moveObject{obj=clib.help.close, y=-2}
		aObj:skinButton{obj=clib.help.close, cb=true}
		aObj:skinUsingBD{obj=clib.help.scroll.hScroll}
		aObj:skinUsingBD{obj=clib.help.scroll.vScroll}
		aObj:addSkinFrame{obj=clib.help}

	end
	-- hook this to skin Configator frames
	if clib then
		self:RawHook(clib, "Create", function(this, ...)
			local frame = self.hooks[clib].Create(this, ...)
--			self:Debug("Configator_Create: [%s]", frame:GetName())
			if not frame.Backdrop.sknd then
				self:skinButton{obj=frame.Done}
				self:addSkinFrame{obj=frame.Backdrop}
			end

			-- skin the Tooltip
			if self.db.profile.Tooltips.skin then
				if not self:IsHooked(clib.tooltip, "Show") then
					if self.db.profile.Tooltips.style == 3
					or ver == 26
					then
						clib.tooltip:SetBackdrop(self.Backdrop[1])
					end
					self:SecureHook(clib.tooltip, "Show", function(this)
						self:skinTooltip(this)
					end)
				end
			end

			-- skin the Help frame
			if not clib.help.sknd then skinHelp() end

			-- hook this to skin various controls
			self:RawHook(frame, "AddControl", function(this, id, cType, column, ...)
				local control = self.hooks[frame].AddControl(this, id, cType, column, ...)
--	 			self:Debug("Configator_Create_AddControl: [%s, %s, %s, %s, %s]", control, id, cType, column, ...)
				-- skin the sub-frame if required
				if not this.tabs[id].frame.sknd then
					self:addSkinFrame{obj=this.tabs[id].frame}
				end
				-- skin the scroll bars
				if this.tabs[id].scroll and not this.tabs[id].scroll.sknd then
					this.tabs[id].scroll.sknd = true
					self:skinUsingBD{obj=this.tabs[id].scroll.hScroll}
					self:skinUsingBD{obj=this.tabs[id].scroll.vScroll}
				end
				-- skin the DropDown
				if cType == "Selectbox" then
					self:skinDropDown{obj=control, rp=true, y2=-4}
					if not _G.SelectBoxMenu.back.sknd then
						self:addSkinFrame{obj=_G.SelectBoxMenu.back}
					end
				elseif cType == "Text" or cType == "TinyNumber" or cType == "NumberBox" then
					self:skinEditBox{obj=control, regs={9}}
				elseif cType == "NumeriSlider" or cType == "NumeriWide" or cType == "NumeriTiny" then
					self:skinEditBox{obj=control.slave, regs={9}}
				elseif cType == "MoneyFrame" or cType == "MoneyFramePinned" then
					self:skinMoneyFrame{obj=control, noWidth=true, moveSEB=true}
				elseif cType == "Button" then
					self:skinButton{obj=control, as=true} -- just skin it otherwise text is hidden
				end
				return control
			end, true)
			return frame
		end, true)
	end

	-- skin frames already created
	if clib and clib.frames then
		for i = 1, #clib.frames do
			local frame = clib.frames[i]
			if frame then
				self:addSkinFrame{obj=frame}
			end
			if frame.tabs then
				for j = 1, #frame.tabs do
					local tab = frame.tabs[j]
					self:addSkinFrame{obj=tab.frame}
					if tab.frame.ctrls then
						for k = 1, #tab.frame.ctrls do
							local tfc = tab.frame.ctrls[k]
							if tfc.kids then
								for l = 1, #tfc.kids do
									local tfck = tfc.kids[l]
									if tfck.stype then
										if tfck.stype == "EditBox" then
											self:skinEditBox{obj=tfck, regs={9}}
										end
										if tfck.stype == "Slider" and tfck.slave then
											self:skinEditBox{obj=tfck.slave, regs={9}}
										end
										if tfck.stype == "SelectBox" then
											self:keepFontStrings(tfck)
										end
										if tfck.isMoneyFrame then
											self:skinMoneyFrame{obj=tfck, noWidth=true, moveSEB=true}
										end
									end
								end
							end
						end
					end
					if tab.scroll then
						tab.scroll.sknd = true
						self:skinUsingBD{obj=tab.scroll.hScroll}
						self:skinUsingBD{obj=tab.scroll.vScroll}
					end
				end
			end
		end
	end

	-- skin the Tooltip
	if self.db.profile.Tooltips.skin then
		if clib and not self:IsHooked(clib.tooltip, "Show") then
			if self.db.profile.Tooltips.style == 3
			or ver == 26
			then
				clib.tooltip:SetBackdrop(self.Backdrop[1])
			end
			self:SecureHook(clib.tooltip, "Show", function(this)
				self:skinTooltip(this)
			end)
		end
	end

	-- skin the Help frame
	if clib and clib.help then skinHelp() end
	-- skin DropDown menu
	if _G.SelectBoxMenu then self:addSkinFrame{obj=_G.SelectBoxMenu.back}	end

	-- skin ScrollSheets
	local sslib = _G.LibStub("ScrollSheet", true)
	if sslib then
		self:RawHook(sslib, "Create", function(this, parent, ...)
			local sheet = self.hooks[sslib].Create(this, parent, ...)
			self:skinUsingBD{obj=sheet.panel.hScroll}
			self:skinUsingBD{obj=sheet.panel.vScroll}
			self:applySkin{obj=parent} -- just skin it otherwise text is hidden
			return sheet
		end, true)
	end

end
