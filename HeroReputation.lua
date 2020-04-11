
local frame = CreateFrame("Frame");
frame:RegisterEvent("ZONE_CHANGED_NEW_AREA");
frame:RegisterEvent("PLAYER_ENTERING_WORLD");

local zoneReputationMap = {
	["Rade de Tiragarde"] = "Amirauté des Portvaillant",
	["Vallée Chantorage"] = "Sillage des tempêtes",
	["Hautes-terres du Crépuscule"] = "Clan Marteau-Hardi",
}

local function onZoneChange()
	local zoneText = GetZoneText()
	local factionName = zoneReputationMap[zoneText]

	local found = false
	local numFactions = GetNumFactions()
	for factionIndex = 1, GetNumFactions() do
		local name = GetFactionInfo(factionIndex)
		if name == factionName then
			SetWatchedFactionIndex(factionIndex)
			DEFAULT_CHAT_FRAME:AddMessage('Entering zone [' .. zoneText .. '], switching reputation to [' .. factionName .. ']', 0.0, 0.8, 0.0);
			return
		end
	end

	DEFAULT_CHAT_FRAME:AddMessage('Entering zone [' .. zoneText .. '], unknown reputation !', 0.0, 0.8, 0.0);
	SetWatchedFactionIndex(0)
end

frame:SetScript("OnEvent", function(self, event, ...)
	local arg = {...}

	if (event == "ZONE_CHANGED_NEW_AREA") then
		onZoneChange()
	end

	if (event == "PLAYER_ENTERING_WORLD") then
		onZoneChange()
	end

end)
