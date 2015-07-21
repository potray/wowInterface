-- thank cremor for all the work done on updating the rotation for wod changes

-- don't load if class is wrong
local _, class = UnitClass("player")
if class ~= "PALADIN" then return end

local _, xmod = ...

xmod.retmodule = {}
xmod = xmod.retmodule

local qTaint = true -- will force queue check

-- thanks cremor
local GetTime, GetSpellCooldown, UnitBuff, UnitAura, UnitPower, UnitSpellHaste, UnitHealth, UnitHealthMax, GetActiveSpecGroup, GetTalentInfoByID, GetGlyphSocketInfo, IsUsableSpell, GetShapeshiftForm, max, min, SPELL_POWER_HOLY_POWER  =
	  GetTime, GetSpellCooldown, UnitBuff, UnitAura, UnitPower, UnitSpellHaste, UnitHealth, UnitHealthMax, GetActiveSpecGroup, GetTalentInfoByID, GetGlyphSocketInfo, IsUsableSpell, GetShapeshiftForm, max, min, SPELL_POWER_HOLY_POWER
local db

-- debug if clcInfo detected
local debug
if clcInfo then debug = clcInfo.debug end

xmod.version = 6000005
xmod.defaults = {
	version = xmod.version,
	
	prio = "es eds5 tv_dp_4s eds5_fv tv5 ds5 eds_4s how cs j emp_sot_exp emp_sor_exp exo emp_sot_return tv4 tv3",
	rangePerSkill = false,

	howclash = 0,  	-- priority time for hammer of wrath
	csclash = 0,		-- priority time for cs
	exoclash = 0, 	-- priority time for exorcism
	ssduration = 0, -- minimum duration on ss buff before suggesting refresh
}

-- @defines
--------------------------------------------------------------------------------
local gcdId 				= 85256 	-- tv for gcd
-- list of spellId
local tvId					= 85256		-- templar's verdict
local fvId					= 157048	-- Final Verdict
local exoId					= 879		-- exorcism
local mexoId				= 122032	-- mass exorcism
local howId 				= 24275		-- hammer of wrath
local empHowId 				= 158392	-- Hammer of Wrath with Empowered Hammer of Wrath perk
local csId 					= 35395		-- crusader strike
local dsId					= 53385		-- divine storm
local jId					= 20271		-- judgement
local esId					= 114157	-- execution sentence
local hprId					= 114165	-- holy prism
local lhId					= 114158	-- light's hammer
local ssId					= 20925		-- sacred shield
-- buffs
local buffDP 		= GetSpellInfo(90174)		-- divine purpose
local buffHA 		= GetSpellInfo(105809)		-- holy avenger
local buffAW 		= GetSpellInfo(31884)		-- avenging wrath
local buffDC 		= GetSpellInfo(144595)		-- Divine Crusader
local buffFV 		= GetSpellInfo(157048)		-- Final Verdict
local buffBC 		= GetSpellInfo(166831)		-- Blazing Contempt (T17 4piece bonus)

-- seal swap of suckage
-- I wanna see a dev perform this shit without addons in a raid setting (GREAT IDEA WITH PRETTY GRAPHICS UNDER FEET)
local sorId					= 20154		-- seal of righteousness
local sotId					= 31801		-- seal of truth
local buffMT		= GetSpellInfo(156990)		-- Maraad's Truth
local buffLR		= GetSpellInfo(156989)		-- Liadrin's Righteousness

-- ss checked in a function since there are 2 buffs with same name
local buffSS = 20925

local t17_items = { 115565, 115566, 115567, 115568, 115569 }

-- status vars
local s1, s2
local s_ctime, s_otime, s_gcd, s_hp, s_dp, s_ha, s_aw, s_ss, s_dc, s_fv, s_bc, s_haste, s_in_execute_range
local s_fv_talent, s_4t17_equipped, s_execute_range_start
local s_emp_talent, s_mt, s_lr, s_emp_active
local s_exoId = exoId

-- the queue
local qn = {}	-- normal queue
local q 		-- working queue

local function GetCooldown(id)
	local start, duration = GetSpellCooldown(id)
	if start == nil then return 100 end
	local cd = start + duration - s_ctime - s_gcd
	if cd < 0 then return 0 end
	return cd
end

-- TODO	DP tests
-- actions ---------------------------------------------------------------------
local actions = {	
	tv5 = {
		id = tvId,
		GetCD = function()
			if (s_hp >= 5) or (s_hp >= 3 and s_ha > 0) then return 0 end
			return 100
		end,
		UpdateStatus = function()
			s_ctime = s_ctime + s_gcd + 1.5
			if s_dp > 0 then
				s_dp = 0
			else
				s_hp = max(0, s_hp - 3)
			end
			if s_fv_talent then
				s_fv = 30
			end
		end,
		info = "Templar's Verdict or Final Verdict with HP >= 5",
	},
	tv4 = {
		id = tvId,
		GetCD = function()
			if (s_hp >= 4) or (s_hp >= 3 and s_ha > 0) then return 0 end
			return 100
		end,
		UpdateStatus = function()
			s_ctime = s_ctime + s_gcd + 1.5
			if s_dp > 0 then
				s_dp = 0
			else
				s_hp = max(0, s_hp - 3)
			end
			if s_fv_talent then
				s_fv = 30
			end
		end,
		info = "Templar's Verdict or Final Verdict with HP >= 4",
	},
	tv4_aw = {
		id = tvId,
		GetCD = function()
			if ( ((s_hp >= 4) or (s_hp >= 3 and s_ha > 0)) and (s_aw > 0) ) then return 0 end
			return 100
		end,
		UpdateStatus = function()
			s_ctime = s_ctime + s_gcd + 1.5
			if s_dp > 0 then
				s_dp = 0
			else
				s_hp = max(0, s_hp - 3)
			end
			if s_fv_talent then
				s_fv = 30
			end
		end,
		info = "Templar's Verdict or Final Verdict with HP >= 4 and Avenging Wrath up",
	},
	tv3 = {
		id = tvId,
		GetCD = function()
			if s_hp >= 3 then return 0 end
			return 100
		end,
		UpdateStatus = function()
			s_ctime = s_ctime + s_gcd + 1.5
			if s_dp > 0 then
				s_dp = 0
			else
				s_hp = max(0, s_hp - 3)
			end
			if s_fv_talent then
				s_fv = 30
			end
		end,
		info = "Templar's Verdict or Final Verdict with HP >= 3",
	},
	tv_dp = {
		id = tvId,
		GetCD = function()
			if s_dp > 0.1 then return 0 end
			return 100
		end,
		UpdateStatus = function()
			s_ctime = s_ctime + s_gcd + 1.5
			s_dp = 0
			if s_fv_talent then
				s_fv = 30
			end
		end,
		info = "Templar's Verdict or Final Verdict when Divine Purpose procs"
	},
	tv_dp_4s = {
		id = tvId,
		GetCD = function()
			if (s_dp > 0.1) and (s_dp < 4) then return 0 end
			return 100
		end,
		UpdateStatus = function()
			s_ctime = s_ctime + s_gcd + 1.5
			s_dp = 0
			if s_fv_talent then
				s_fv = 30
			end
		end,
		info = "Templar's Verdict or Final Verdict with Divine Purpose < 4s remaining"
	},
	tv_aw = {
		id = tvId,
		GetCD = function()
			if ((s_hp >= 3) or (s_dp > 0.1)) and (s_aw > 0) then return 0 end
			return 100
		end,
		UpdateStatus = function()
			s_ctime = s_ctime + s_gcd + 1.5
			if s_dp > 0 then
				s_dp = 0
			else
				s_hp = max(0, s_hp - 3)
			end
			if s_fv_talent then
				s_fv = 30
			end
		end,
		info = "Templar's Verdict or Final Verdict with HP >= 3 or Divine Purpose during Avenging Wrath",
	},
	tv_aw_exec = {
		id = tvId,
		GetCD = function()
			if ((s_hp >= 3) or (s_dp > 0.1)) and (s_aw > 0 or s_in_execute_range) then return 0 end
			return 100
		end,
		UpdateStatus = function()
			s_ctime = s_ctime + s_gcd + 1.5
			if s_dp > 0 then
				s_dp = 0
			else
				s_hp = max(0, s_hp - 3)
			end
			if s_fv_talent then
				s_fv = 30
			end
		end,
		info = "Templar's Verdict or Final Verdict with HP >= 3 or Divine Purpose during Avenging Wrath or execute range",
	},
	fv = {
		id = fvId,
		GetCD = function()
			if s_hp >= 3 then return 0 end
			return 100
		end,
		UpdateStatus = function()
			s_ctime = s_ctime + s_gcd + 1.5
			if s_dp > 0 then
				s_dp = 0
			else
				s_hp = max(0, s_hp - 3)
			end
			s_fv = 30
		end,
		info = "Final Verdict with HP >= 3",
		reqTalent = 21672,
	},
	fv_dp = {
		id = fvId,
		GetCD = function()
			if s_dp > 0.1 then return 0 end
			return 100
		end,
		UpdateStatus = function()
			s_ctime = s_ctime + s_gcd + 1.5
			s_dp = 0
			s_fv = 30
		end,
		info = "Final Verdict when Divine Purpose procs",
		reqTalent = 21672,
	},
	eds = {
		id = dsId,
		GetCD = function()
			if ( s_dc > 0.1 ) then return 0 end
			return 100
		end,
		UpdateStatus = function()
			s_ctime = s_ctime + s_gcd + 1.5
			s_dc = 0
			s_fv = 0
			-- Using EDS should not consume DP
		end,
		info = "Empowered Divine Storm",
	},
	ds5 = {
		id = dsId,
		GetCD = function()
			if s_hp >= 5 then return 0 end
			return 100
		end,
		UpdateStatus = function()
			s_ctime = s_ctime + s_gcd + 1.5
			s_dc = 0
			s_fv = 0
			s_hp = s_hp - 3
		end,
		info = "Divine Storm with 5HP and no buff/proc",
	},
	eds5 = {
		id = dsId,
		GetCD = function()
			if ( (s_dc > 0.1) and (s_hp >= 5) ) then return 0 end
			return 100
		end,
		UpdateStatus = function()
			s_ctime = s_ctime + s_gcd + 1.5
			s_dc = 0
			s_fv = 0
			-- Using EDS should not consume DP
		end,
		info = "Empowered Divine Storm with 5HP",
	},
	eds_aw = {
		id = dsId,
		GetCD = function()
			if ( (s_dc > 0.1) and (s_aw > 0) ) then return 0 end
			return 100
		end,
		UpdateStatus = function()
			s_ctime = s_ctime + s_gcd + 1.5
			s_dc = 0
			s_fv = 0
			-- Using EDS should not consume DP
		end,
		info = "Empowered Divine Storm during Avenging Wrath",
	},
	eds_aw_exec = {
		id = dsId,
		GetCD = function()
			if ( (s_dc > 0.1) and (s_aw > 0 or s_in_execute_range) ) then return 0 end
			return 100
		end,
		UpdateStatus = function()
			s_ctime = s_ctime + s_gcd + 1.5
			s_dc = 0
			s_fv = 0
			-- Using EDS should not consume DP
		end,
		info = "Empowered Divine Storm during Avenging Wrath or execute range",
	},
	eds_4s = {
		id = dsId,
		GetCD = function()
			if ( (s_dc > 0.1) and (s_dc < 4) ) then return 0 end
			return 100
		end,
		UpdateStatus = function()
			s_ctime = s_ctime + s_gcd + 1.5
			s_dc = 0
			s_fv = 0
			-- Using EDS should not consume DP
		end,
		info = "Empowered Divine Storm < 4s remaining",
	},
	eds_fv = {
		id = dsId,
		GetCD = function()
			if ( ( s_dc > 0.1 ) and (s_fv > 0.1) ) then return 0 end
			return 100
		end,
		UpdateStatus = function()
			s_ctime = s_ctime + s_gcd + 1.5
			s_dc = 0
			s_fv = 0
			-- Using EDS should not consume DP
		end,
		info = "Empowered Divine Storm with Final Verdict buff",
		reqTalent = 21672,
	},
	eds5_fv = {
		id = dsId,
		GetCD = function()
			if ( (s_dc > 0.1) and (s_fv > 0.1) and (s_hp >= 5) ) then return 0 end
			return 100
		end,
		UpdateStatus = function()
			s_ctime = s_ctime + s_gcd + 1.5
			s_dc = 0
			s_fv = 0
			-- Using EDS should not consume DP
		end,
		info = "Empowered Divine Storm with Final Verdict buff and 5HP",
		reqTalent = 21672,
	},
	eds_fv_aw = {
		id = dsId,
		GetCD = function()
			if ( (s_dc > 0.1) and (s_fv > 0.1) and (s_aw > 0) ) then return 0 end
			return 100
		end,
		UpdateStatus = function()
			s_ctime = s_ctime + s_gcd + 1.5
			s_dc = 0
			s_fv = 0
			-- Using EDS should not consume DP
		end,
		info = "Empowered Divine Storm with Final Verdict buff during Avenging Wrath",
		reqTalent = 21672,
	},
	eds_fv_aw_exec = {
		id = dsId,
		GetCD = function()
			if ( (s_dc > 0.1) and (s_fv > 0.1) and (s_aw > 0 or s_in_execute_range) ) then return 0 end
			return 100
		end,
		UpdateStatus = function()
			s_ctime = s_ctime + s_gcd + 1.5
			s_dc = 0
			s_fv = 0
			-- Using EDS should not consume DP
		end,
		info = "Empowered Divine Storm with Final Verdict buff during Avenging Wrath or execute range",
		reqTalent = 21672,
	},
	exo = {
		id = s_exoId,
		GetCD = function()
			if s1 == s_exoId then
				return 100 -- lazy stuff
			else
				return max(0, GetCooldown(s_exoId) - db.exoclash)
			end
		end,
		UpdateStatus = function()
			s_ctime = s_ctime + s_gcd + 1.5 / s_haste
			if (s_ha > 0) or (s_bc > 0) then
				s_hp = min(5, s_hp + 3)
			else
				s_hp = min(5, s_hp + 1)
			end
			s_bc = 0
		end,
		info = "Exorcism",
	},
	exo_aw = {
		id = s_exoId,
		GetCD = function()
			if (s1 ~= s_exoId) and (s_aw > 0) then
				return max(0, GetCooldown(s_exoId) - db.exoclash)
			end
			return 100 -- lazy stuff
		end,
		UpdateStatus = function()
			s_ctime = s_ctime + s_gcd + 1.5 / s_haste
			if (s_ha > 0) or (s_bc > 0) then
				s_hp = min(5, s_hp + 3)
			else
				s_hp = min(5, s_hp + 1)
			end
			s_bc = 0
		end,
		info = "Exorcism during Avenging Wrath",
	},
	exo_bc = {
		id = s_exoId,
		GetCD = function() 
			if (s1 ~= s_exoId) and (s_hp <= 2) and (s_bc > 0.1) then
				return max(0, GetCooldown(s_exoId) - db.exoclash)
			end
			return 100
		end,
		UpdateStatus = function()
			s_ctime = s_ctime + s_gcd + 1.5 / s_haste
			s_hp = min(5, s_hp + 3)
			s_bc = 0
		end,
		info = "Exorcism with Blazing Contempt (T17 4piece bonus) buff",
	},
	how = {
		id = howId,
		GetCD = function()
			if (s1 ~= howId) and IsUsableSpell(howId) then
				return max(0, GetCooldown(howId) - db.howclash)
			end
			return 100 -- lazy stuff
		end,
		UpdateStatus = function()
			s_ctime = s_ctime + s_gcd + 1.5 / s_haste
			if s_ha > 0 then
				s_hp = min(5, s_hp + 3)
			else
				s_hp = min(5, s_hp + 1)
			end
			if s_4t17_equipped then
				s_bc = 20
			end
		end,
		info = "Hammer of Wrath",
	},
	cs = {
		id = csId,
		GetCD = function()
			if s1 == csId then
				return max(0, (4.5 / s_haste - 1.5 - db.csclash))
			else
				return max(0, GetCooldown(csId) - db.csclash)
			end
		end,
		UpdateStatus = function()
			s_ctime = s_ctime + s_gcd + 1.5
			if s_ha > 0 then
				s_hp = min(5, s_hp + 3)
			else
				s_hp = min(5, s_hp + 1)
			end
		end,
		info = "Crusader Strike",
	},
	j = {
		id = jId,
		GetCD = function()
			if s1 ~= jId then
				return GetCooldown(jId)
			end
			return 100 -- lazy stuff
		end,
		UpdateStatus = function()
			s_ctime = s_ctime + s_gcd + 1.5
			if s_ha > 0 then
				s_hp = min(5, s_hp + 3)
			else
				s_hp = min(5, s_hp + 1)
			end

			if (s_emp_talent) then
				local sform = s_emp_active
				if sform == 1 then
					s_mt = 20
				elseif sform == 2 then
					s_lr = 20
				end
			end
		end,
		info = "Judgement",
	},
	j_aw = {
		id = jId,
		GetCD = function()
			if ( (s1 ~= jId) and (s_aw > 0) ) then
				return GetCooldown(jId)
			end
			return 100 -- lazy stuff
		end,
		UpdateStatus = function()
			s_ctime = s_ctime + s_gcd + 1.5
			if s_ha > 0 then
				s_hp = min(5, s_hp + 3)
			else
				s_hp = min(5, s_hp + 1)
			end

			if (s_emp_talent) then
				local sform = s_emp_active
				if sform == 1 then
					s_mt = 20
				elseif sform == 2 then
					s_lr = 20
				end
			end
		end,
		info = "Judgement during Avenging Wrath",
	},
	es = {
		id = esId,
		GetCD = function()
			if s1 ~= esId then
				return GetCooldown(esId)
			end
			return 100 -- lazy stuff
		end,
		UpdateStatus = function()
			s_ctime = s_ctime + s_gcd + 1.5 / s_haste
		end,
		info = "Execution Sentence",
		reqTalent = 17609,
	},
	hpr = {
		id = hprId,
		GetCD = function()
			if s1 ~= hprId then
				return GetCooldown(hprId)
			end
			return 100 -- lazy stuff
		end,
		UpdateStatus = function()
			s_ctime = s_ctime + s_gcd + 1.5 / s_haste
		end,
		info = "Holy Prism",
		reqTalent = 17605,
	},
	lh = {
		id = lhId,
		GetCD = function()
			if s1 ~= lhId then
				return GetCooldown(lhId)
			end
			return 100 -- lazy stuff
		end,
		UpdateStatus = function()
			s_ctime = s_ctime + s_gcd + 1.5 / s_haste
		end,
		info = "Light's Hammer",
		reqTalent = 17607,
	},
	ss = {
		id = ssId,
		GetCD = function()
			if s1 ~= ssId and s_ss <= db.ssduration then
				return 1.5 / s_haste	-- always return the time it would need to cast the skill so it doesn't overlap any dmg ability
			end
			return 100 -- lazy stuff
		end,
		UpdateStatus = function()
			s_ctime = s_ctime + s_gcd + 1.5 / s_haste + 0.1 -- a bit of extra time to reduce flashing
			s_ss = 30
		end,
		info = "Sacred Shield",
		reqTalent = 21098,
	},

	-- seal swaps
	emp_sot_exp = {
		id = sotId,
		GetCD = function()
			if s_emp_active ~= 1 and s_mt < 5 then
				return 0
			end
			return 100
		end,
		UpdateStatus = function()
			s_ctime = s_ctime + s_gcd + 1.5 / s_haste
			s_emp_active = 1
		end,
		info = "Empowered Seals go to Truth when buff has less than 5s left",
		reqTalent = 21201,
	},
	emp_sor_exp = {
		id = sorId,
		GetCD = function()
			if s_emp_active ~= 2 and s_lr < 5 then
				return 0
			end
			return 100
		end,
		UpdateStatus = function()
			s_ctime = s_ctime + s_gcd + 1.5 / s_haste
			s_emp_active = 2
		end,
		info = "Empowered Seals go to Righteousness when buff has less than 5s left",
		reqTalent = 21201,
	},
	emp_sot_return = {
		id = sotId,
		GetCD = function()
			if s_emp_active ~= 1 and s_lr > 10 then
				return 0
			end
			return 100
		end,
		UpdateStatus = function()
			s_ctime = s_ctime + s_gcd + 1.5 / s_haste
			s_emp_active = 1
		end,
		info = "Empowered Seals go back to Truth after casting Righteousness",
		reqTalent = 21201,
	},

}
--------------------------------------------------------------------------------

local function UpdateQueue()
	-- normal queue
	qn = {}
	for v in string.gmatch(db.prio, "[^ ]+") do
		if actions[v] then
			table.insert(qn, v)
		else
			print("clcretmodule - invalid action:", v)
		end
	end
	db.prio = table.concat(qn, " ")

	-- force reconstruction for q
	qTaint = true
end

local function GetBuff(buff)
	local left = 0
	local _, expires
	_, _, _, _, _, _, expires = UnitBuff("player", buff, nil, "PLAYER")
	if expires then
		left = max(0, expires - s_ctime - s_gcd)
	end
	return left
end

-- special case for SS
local function GetBuffSS()
	-- parse all buffs and look for id
	local i = 1
	local name, _, _, _, _, _, expires, _, _, _, spellId = UnitAura("player", i, "HELPFUL")
	while name do
		if spellId == buffSS then break end
		i = i + 1
		name, _, _, _, _, _, expires, _, _, _, spellId = UnitAura("player", i, "HELPFUL")
	end
	
	local left = 0
	if name and expires then
		left = max(0, expires - s_ctime - s_gcd)
	end
	s_ss = left
end

-- reads all the interesting data
local function GetStatus()
	-- current time
	s_ctime = GetTime()
	
	-- gcd value
	local start, duration = GetSpellCooldown(gcdId)
	s_gcd = start + duration - s_ctime
	if s_gcd < 0 then s_gcd = 0 end
	
	-- the buffs
	s_dp 	= GetBuff(buffDP)
	s_ha 	= GetBuff(buffHA)
	s_aw 	= GetBuff(buffAW)
	s_dc 	= GetBuff(buffDC)
	s_bc 	= GetBuff(buffBC)

	if s_fv_talent then
		s_fv = GetBuff(buffFV)
	elseif s_emp_talent then
		s_mt = GetBuff(buffMT)
		s_lr = GetBuff(buffLR)
		s_emp_active = GetShapeshiftForm()
	end

	-- special for ss
	GetBuffSS()

	-- client hp and haste
	s_hp = UnitPower("player", SPELL_POWER_HOLY_POWER)
	s_haste = 1 + UnitSpellHaste("player") / 100

	-- execute range: custom health check instead of checking HoW to ensure that 2T17 doesn't cause problems
	s_in_execute_range = (UnitHealth("target") / UnitHealthMax("target")) <= s_execute_range_start
end

-- remove all talents not available and present in rotation
-- adjust for modified skills present in rotation
local function GetWorkingQueue()
	q = {}
	local name, selected, available
	for k, v in pairs(qn) do
		-- see if it has a talent requirement
		if actions[v].reqTalent then
			-- see if the talent is activated
			_, name, _, selected, available = GetTalentInfoByID(actions[v].reqTalent, GetActiveSpecGroup())
			if name and selected and available then
				table.insert(q, v)
			end
		else
			table.insert(q, v)
		end
	end
end

local function GetNextAction()
	-- check if working queue needs updated due to glyph talent changes
	if qTaint then
		GetWorkingQueue()
		qTaint = false
	end

	local n = #q
	
	-- parse once, get cooldowns, return first 0
	for i = 1, n do
		local action = actions[q[i]]
		local cd = action.GetCD()
		if debug and debug.enabled then
			debug:AddBoth(q[i], cd)
		end
		if cd == 0 then
			return action.id, q[i]
		end
		action.cd = cd
	end
	
	-- parse again, return min cooldown
	local minQ = 1
	local minCd = actions[q[1]].cd
	for i = 2, n do
		local action = actions[q[i]]
		if minCd > action.cd then
			minCd = action.cd
			minQ = i
		end
	end
	return actions[q[minQ]].id, q[minQ]
end

-- exposed functions

-- this function should be called from addons
function xmod.Init()
	db = xmod.db
	UpdateQueue()
end

function xmod.GetActions()
	return actions
end

function xmod.Update()
	UpdateQueue()
end

function xmod.Rotation()
	s1 = nil
	GetStatus()
	if debug and debug.enabled then
		debug:Clear()
		debug:AddBoth("ctime", s_ctime)
		debug:AddBoth("gcd", s_gcd)
		debug:AddBoth("hp", s_hp)
		debug:AddBoth("haste", s_haste)
		debug:AddBoth("s_mt", s_mt)
		debug:AddBoth("s_lr", s_lr)
	end
	local action
	s1, action = GetNextAction()
	if debug and debug.enabled then
		debug:AddBoth("s1", action)
		debug:AddBoth("s1Id", s1)
	end
	-- 
	s_otime = s_ctime -- save it so we adjust buffs for next
	actions[action].UpdateStatus()
	
	-- adjust buffs
	s_otime = s_ctime - s_otime
	s_dp = max(0, s_dp - s_otime)
	s_ha = max(0, s_ha - s_otime)
	s_ss = max(0, s_ss - s_otime)
	s_aw = max(0, s_aw - s_otime)
	s_dc = max(0, s_dc - s_otime)
	s_bc = max(0, s_bc - s_otime)

	if s_fv_talent then
		s_fv = max(0, s_fv - s_otime)
	elseif s_emp_talent then
		s_mt = max(0, s_mt - s_otime)
		s_lr = max(0, s_lr - s_otime)
	end

	
	if debug and debug.enabled then
		debug:AddBoth("ctime", s_ctime)
		debug:AddBoth("otime", s_otime)
		debug:AddBoth("gcd", s_gcd)
		debug:AddBoth("hp", s_hp)
		debug:AddBoth("haste", s_haste)
		debug:AddBoth("s_mt", s_mt)
		debug:AddBoth("s_lr", s_lr)
	end
	s2, action = GetNextAction()
	if debug and debug.enabled then
		debug:AddBoth("s2", action)
	end

	return s1, s2
end

-- event frame
local ef = CreateFrame("Frame", "clcRetModuleEventFrame") -- event frame
ef:Hide()
local function OnEvent()
	qTaint = true
	
	local count = 0
	for i, v in ipairs(t17_items) do
		if IsEquippedItem(v) then
			count = count + 1
		end
	end
	s_4t17_equipped = count >= 4

	-- check for how perk
	if IsPlayerSpell(157496) then
		s_execute_range_start = 0.35
		howId = empHowId
		actions['how'].id = howId
	else
		s_execute_range_start = 0.20
	end
	-- fv talent
	local _, name, _, selected, available = GetTalentInfoByID(21672, GetActiveSpecGroup())
	if name and selected and available then
		s_fv_talent = selected
	end
	_, name, _, selected, available = GetTalentInfoByID(21201, GetActiveSpecGroup())
	if name and selected and available then
		s_emp_talent = selected
	end

	-- adjust exo depending on glyph
	local glyphSpellId
	local mexo = false
	for i = 1, 3 do
		-- major glyphs are 2, 4, 6
		_, _, _, glyphSpellId = GetGlyphSocketInfo(i*2)
		if glyphSpellId == 122028 then
			mexo = true
			break
		end
	end

	if mexo then
		-- mass exorcism glyph detected
		-- switch spellid for actions
		actions["exo"].id = mexoId
		actions["exo_aw"].id = mexoId
		actions["exo_bc"].id = mexoId
		s_exoId = mexoId
	else
		actions["exo"].id = exoId
		actions["exo_aw"].id = exoId
		actions["exo_bc"].id = exoId
		s_exoId = exoId
	end
end

ef:SetScript("OnEvent", OnEvent)
ef:RegisterEvent("PLAYER_ENTERING_WORLD")
ef:RegisterEvent("PLAYER_TALENT_UPDATE")
ef:RegisterEvent("PLAYER_LEVEL_UP")
ef:RegisterEvent("GLYPH_ADDED")
ef:RegisterEvent("GLYPH_UPDATED")
ef:RegisterEvent("GLYPH_REMOVED")
ef:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")




