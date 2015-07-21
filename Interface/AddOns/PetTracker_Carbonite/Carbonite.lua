--[[
Copyright 2015 João Cardoso
PetTracker Carbonite is distributed under the terms of the GNU General Public License (Version 3).
As a special exception, the copyright holders of this addon do not give permission to
redistribute and/or modify it.

This addon is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with the addon. If not, see <http://www.gnu.org/licenses/gpl-3.0.txt>.

This file is part of PetTracker Carbonite.
--]]

local ADDON = ...
local Addon = PetTracker
local Carbonite = Addon:NewModule('Carbonite')
local Journal = Addon.Journal

function Carbonite:TrackingChanged()
	local map = Nx.Map:GetMap(1)
	if map and not map.petTracking then
		local original = map.Frm:GetScript('OnUpdate')

		map.petTracking = true
		map.Frm:SetScript('OnUpdate', function(f, ...)
			self:DrawMap(map.Scale > 1 and Nx.Map:GetCurrentMapId())
			original(f, ...)
		end)
	end

	if Nx.Quest then
		self:UpdateProgress()
	end
end

function Carbonite:DrawMap(zone)
	if self.zone ~= zone then
		local species = Journal:GetSpeciesIn(zone)
		local i = 0

		for specie, floors in pairs(species) do
			for level, spots in pairs(floors) do
				local specie = Addon.Specie:Get(specie)
				local name, portrait, _,_, source = specie:GetInfo()
				local icon = specie:GetTypeIcon()

				local owned = specie:GetOwnedText()
				local owned = owned and (owned .. '|n') or ''
				local tooltip = format('|T%s:20:20:-2:0|t%s\n|r%s%s', portrait, name, owned, Addon:KeepShort(source))

				for x, y in gmatch(spots, '(%w%w)(%w%w)') do 
					local x = tonumber(x, 36) / 10
					local y = tonumber(y, 36) / 10

					Nx.MapAddIcon(ADDON .. tostring(i), zone, x, y, nil, tooltip, icon, 0.79687500, 0.49218750, 0.50390625, 0.65625000)
					i = i + 1
				end
			end
		end

		self.zone = zone
	end
end

function Carbonite:UpdateProgress()
	local progress = Journal:GetCurrentProgress()

	Nx.Quest.Watch:ClearCustom()
	Nx.Quest.Watch:AddCustom(Addon.Locals.BattlePets)

	for quality = 0, Addon.MaxQuality do
		local _,_,_,h = Addon:GetQualityColor(quality)

		for level = 0, Addon.MaxLevel do
			local tag = level > 0 and format(' (%s)', level) or ''

			for i, specie in ipairs(progress[quality][level] or {}) do
				local name, icon = Journal:GetInfo(specie)

				Nx.Quest.Watch:AddCustom(format('|c%s|T%s:13:13:-2:0|t%s%s|r', h, icon, name, tag), Addon.Locals.ShowJournal, function()
					Journal:Display(specie)
				end)
			end
		end
	end
end