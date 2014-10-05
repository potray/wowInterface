local modName, mod = ...

local db

local options = {
	type = "group",
	name = "General",
	args = {
		general = {
			type = "group",
			name = "General",
			order = 1,
			args = {
				clclock = {
					order = 1,
					type = "toggle",
					name = "Lock",
					get = function(info)
						return db.lock
					end,
					set = function(info, val)
						mod.ToggleLock()
					end,
				},
				disableBlizzardBar = {
					order = 2,
					width = "double",
					type = "toggle",
					name = "Disable Blizzard Bar",
					get = function(info)
						return db.disableBlizzardBar
					end,
					set = function(info, val)
						mod.ToggleDisableBlizzardBar()
					end,
				},
				x = {
					order = 11,
					type = "range",
					name = "x",
					min = -2000,
					max = 2000,
					step = 1,
					get = function(info) return db.x end,
					set = function(info, val)
						db.x = val
						mod.UpdateAnchor()
					end,
				},
				y = {
					order =12,
					type = "range",
					name = "y",
					min = -2000,
					max = 2000,
					step = 1,
					get = function(info) return db.y end,
					set = function(info, val)
						db.y = val
						mod.UpdateAnchor()
					end,
				},
				scale = {
					order = 13,
					type = "range",
					name = "Scale",
					min = 0.01,
					max = 3,
					step = 0.01,
					get = function(info) return db.scale end,
					set = function(info, val)
						db.scale = val
						mod.UpdateAnchor()
					end,
				},
				alpha = {
					order = 14,
					type = "range",
					name = "Alpha",
					min = 0,
					max = 1,
					step = 0.01,
					get = function(info) return db.alpha end,
					set = function(info, val)
						db.alpha = val
						mod.UpdateAnchor()
					end,
				},
				anchorPoint = {
					order = 20,
					name = "Anchor Point",
					type = "input",
					get = function(info) return db.anchorFrom end,
				},
				lock = {
					order = 50,
					type = "toggle",
					width = "full",
					name = "Show only in combat",
					get = function(info)
						return db.showCombatOnly
					end,
					set = function(info, val)
						db.showCombatOnly = val
					end,
				},
			},
		},
	},
}

function mod.OptionInit()
		db = mod.db.char
end


local AceConfig = LibStub("AceConfig-3.0")
AceConfig:RegisterOptionsTable("clcppb", options)

local AceConfigDialog = LibStub("AceConfigDialog-3.0")
AceConfigDialog:AddToBlizOptions("clcppb", "clcPaladinPowerBar", nil, "general")