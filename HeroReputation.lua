
local frame = CreateFrame("Frame");
frame:RegisterEvent("ZONE_CHANGED_NEW_AREA");
frame:RegisterEvent("PLAYER_ENTERING_WORLD");

local zoneReputationMap = {
	-- BFA
	["Rade de Tiragarde"] = "Amirauté des Portvaillant",
	["Vallée Chantorage"] = "Sillage des tempêtes",
	["Drustvar"] = "Ordre des Braises",
	["Vol’dun"] = "7e Légion",
	["Nazmir"] = "7e Légion",
	["Zuldazar"] = "7e Légion",

	-- BFA assaults
	["Uldum"] = "Accord d’Uldum",
	["Val de l'Éternel printemps"] = "Rajani",

	-- Legion
	["Tornheim"] = "Valarjar",
	["Haut-Roc"] = "Tribu de Haut-Roc",
	["Val’sharah"] = "Tisse-Rêves",
	["Suramar"] = "Souffrenuit",
	["Azsuna"] = "Cour de Farondis",

	-- Cataclysm
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
			return
		end
	end

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
