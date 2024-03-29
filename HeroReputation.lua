
local frame = CreateFrame('Frame');
frame:RegisterEvent('ZONE_CHANGED_NEW_AREA');
frame:RegisterEvent('PLAYER_ENTERING_WORLD');

local ZONE_REPUTATION_MAP = {

	-- Shadowlands
	['Revendreth'] = 'Cour des Moissonneurs',
	['Sylvarden'] = 'L’Hallali',
	['Le Bastion'] = 'Transcendés',
	['Maldraxxus'] = 'Armée immortelle',
	['L’Antre'] = 'Ve’nari',
	['Korthia'] = 'Avancée de la mort',

	-- BFA
	['Rade de Tiragarde'] = 'Amirauté des Portvaillant',
	['Vallée Chantorage'] = 'Sillage des tempêtes',
	['Drustvar'] = 'Ordre des Braises',
	['Vol’dun'] = '7e Légion',
	['Nazmir'] = '7e Légion',
	['Zuldazar'] = '7e Légion',
	['Nazjatar'] = 'Ankoïens du Brisant',
	['Île de Mécagone'] = 'Résistance de Mécarouille',

	-- BFA assaults
	['Uldum'] = 'Accord d’Uldum',
	['Val de l’Éternel printemps'] = 'Rajani',

	-- Legion
	['Tornheim'] = 'Valarjar',
	['Haut-Roc'] = 'Tribu de Haut-Roc',
	['Val’sharah'] = 'Tisse-Rêves',
	['Suramar'] = 'Souffrenuit',
	['Azsuna'] = 'Cour de Farondis',

	-- Cataclysm
	['Hautes-terres du Crépuscule'] = 'Clan Marteau-Hardi',
}

local function onZoneChange()
	if (UnitLevel('player') < 50) then
		return
	end

	local zoneText = GetZoneText()
	local factionName = ZONE_REPUTATION_MAP[zoneText]

	local numFactions = GetNumFactions()
	for factionIndex = 1, numFactions do
		local name = GetFactionInfo(factionIndex)
		if name == factionName then
			SetWatchedFactionIndex(factionIndex)
			return
		end
	end

	SetWatchedFactionIndex(0)
end

frame:SetScript('OnEvent', function(self, event, ...)

	if (event == 'ZONE_CHANGED_NEW_AREA') then
		onZoneChange();
	end

	if (event == 'PLAYER_ENTERING_WORLD') then
		onZoneChange();
	end

end)
