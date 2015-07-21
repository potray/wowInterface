if ( GetLocale() ~= "esES" ) then
	return;
end

local L = LibStub("AceLocale-3.0"):NewLocale("Carbonite", "esES")
if not L then return end

-- All WoWHead translations might need corrections (scenarios names in particular - used the names from the map's image where different)
L["A Brewing Storm"] = "Cervezas y Truenos"				-- http://es.wowhead.com/zone=6101
L["A Little Patience"] = "Templanza"					-- http://es.wowhead.com/zone=6616
L["Abyssal Depths"] = "Profundidades Abisales"
L["Ahn'kahet: The Old Kingdom"] = "Ahn'kahet: El Antiguo Reino"
L["Temple of Ahn'Qiraj"] = "Ahn'Qiraj"					-- http://es.wowhead.com/zone=3428
L["Ahn'Qiraj: The Fallen Kingdom"] = "Ahn'Qiraj: El Reino Caído"
L["Alterac Mountains"] = true
L["Alterac Valley"] = "Valle de Alterac"
L["Ammen Vale"] = "Valle Ammen"
L["Arathi Basin"] = "Cuenca de Arathi"
L["Arathi Highlands"] = "Tierras Altas de Arathi"
L["Arena of Annihilation"] = "Arena de la Aniquilación"			-- http://es.wowhead.com/zone=6219
L["Ashenvale"] = "Vallefresno"
L["Ashran"] = "Ashran"							-- http://es.wowhead.com/zone=6941
L["Assault on Zan'vess"] = "Asalto a Zan'vess"				-- http://es.wowhead.com/zone=6328
L["Auchenai Crypts"] = "Criptas Auchenai"
L["Auchindoun"] = "Auchindoun"						-- http://es.wowhead.com/zone=6912
L["Azjol-Nerub"] = "Azjol-Nerub"					-- http://es.wowhead.com/zone=4277
L["Azshara"] = "Azshara"						-- http://es.wowhead.com/zone=16
L["Azuremyst Isle"] = "Isla Bruma Azur"
L["Badlands"] = "Tierras Inhóspitas"
L["Baradin Hold"] = "Bastión de Baradin"
L["Theramore's Fall (A)"] = "Marjal Revolcafango"			-- Replaces Battle of Theramore http://es.wowhead.com/zone=6500
L["Theramore's Fall (H)"] = "Marjal Revolcafango"			-- Replaces Battle of Theramore http://es.wowhead.com/zone=6040
L["Battle on the High Seas"] = "Batalla en Alta Mar"			-- http://es.wowhead.com/zone=6567
L["Black Temple Scenario"] = true
L["Black Temple"] = "Templo Oscuro"
L["Blackfathom Deeps"] = "Cavernas de Brazanegra"
L["Blackrock Caverns"] = "Cavernas Roca Negra"
L["Blackrock Depths"] = "Profundidades de Roca Negra"
L["Blackrock Foundry"] = "Fundición Roca Negra"				-- http://es.wowhead.com/zone=6967
L["Blackrock Spire"] = "Cumbre de Roca Negra"
L["Blackwing Descent"] = "Descenso de Alanegra"
L["Blackwing Lair"] = "Guarida de Alanegra"
L["Blade's Edge Arena"] = "Arena Filospada"
L["Blade's Edge Mountains"] = "Montañas Filospada"
L["Blasted Lands"] = "Las Tierras Devastadas"
L["Blood in the Snow"] = "Sangre en la Nieve"				-- http://es.wowhead.com/zone=6678
L["Bloodmaul Slag Mines"] = "Minas Machacasangre"			-- http://es.wowhead.com/zone=6874
L["Bloodmyst Isle"] = "Isla Bruma de Sangre"
L["Bonetown Scenario"] = true						-- is this needed (from zhTW)
L["Borean Tundra"] = "Tundra Boreal"
L["Brawl'gar Arena"] = true
L["Brewmoon Festival"] = "Festival de la Cerveza Lunar"			-- http://es.wowhead.com/zone=6426
L["Burning Steppes"] = "Las Estepas Ardientes"
L["Camp Narache"] = "Campamento Narache"
L["Celestial Tournament"] = "Torneo Celestial"				-- http://es.wowhead.com/zone=6771
L["Coldridge Valley"] = "Valle de Crestanevada"
L["Crypt of Forgotten Kings"] = "Cripta de los Reyes Olvidados"		-- http://es.wowhead.com/zone=6208
L["Crystalsong Forest"] = "Bosque Canto de Cristal"
L["Dagger in the Dark"] = "Una Daga en la Oscuridad"			-- http://es.wowhead.com/zone=6565
L["Dalaran Underbelly"] = true
L["Dalaran"] = "Dalaran"						-- http://es.wowhead.com/zone=4395
L["Dark Heart of Pandaria"] = "Valle de la Flor Eterna"			-- http://es.wowhead.com/zone=6733
L["Darkmoon Island"] = "Isla Luna Negra"				-- http://es.wowhead.com/zone=5861
L["Darkshore"] = "Costa Oscura"
L["Darnassus"] = "Darnassus"						-- http://es.wowhead.com/zone=1657
L["Deadwind Pass"] = "Paso de la Muerte"
L["Deathknell"] = "Camposanto"
L["Deepholm"] = "Infralar"
L["Deeprun Tram"] = "Tranvía Subterráneo"
L["Deepwind Gorge"] = "Cañón del Céfiro"				-- http://es.wowhead.com/zone=6665
L["Desolace"] = "Desolace"						-- http://es.wowhead.com/zone=405
L["Dire Maul"] = "La Masacre"
L["Domination Point"] = "Punto de Dominio"				-- http://es.wowhead.com/zone=6615
L["Draenor"] = "Draenor"
L["Dragon Soul"] = "Alma de Dragón"					-- http://es.wowhead.com/zone=5892
L["Dragonblight"] = "Cementerio de Dragones"
L["Drak'Tharon Keep"] = "Fortaleza de Drak'Tharon"
L["Dread Wastes"] = "Desierto del Pavor"
L["Dun Morogh"] = "Dun Morogh"						-- http://es.wowhead.com/zone=1
L["Durotar"] = "Durotar"						-- http://es.wowhead.com/zone=14
L["Duskwood"] = "Bosque del Ocaso"
L["Dustwallow Marsh"] = "Marjal Revolcafango"
L["Eastern Kingdoms"] = "Reinos del Este"				-- please verify
L["Eastern Plaguelands"] = "Tierras de la Peste del Este"
L["Echo Isles"] = "Islas del Eco"
L["Elwynn Forest"] = "Bosque de Elwynn"
L["End Time"] = "Fin de los Días"					-- http://es.wowhead.com/zone=5789
L["Eversong Woods"] = "Bosque Canción Eterna"
L["Eye of the Storm"] = "Ojo de la Tormenta"
L["Felwood"] = "Frondavil"
L["Feralas"] = "Feralas"						-- http://es.wowhead.com/zone=357
L["Firelands"] = "Tierras de Fuego"
L["Frostfire Ridge"] = "Cresta Fuego Glacial"				-- http://es.wowhead.com/zone=6720
L["Frostwall"] = "Muro de Hielo"					-- http://es.wowhead.com/zone=7004
L["Gate of the Setting Sun"] = "Puerta del Sol Poniente"		-- http://es.wowhead.com/zone=5976
L["Ghostlands"] = "Tierras Fantasma"
L["Gilneas City"] = "Ciudad de Gilneas"
L["Gilneas"] = "Gilneas"						-- http://es.wowhead.com/zone=4714
L["Gnomeregan"] = "Gnomeregan"						-- http://es.wowhead.com/zone=721
L["Gorgrond"] = "Gorgrond"						-- http://es.wowhead.com/zone=6721
L["Greenstone Village"] = "Aldea Verdemar"				-- http://es.wowhead.com/zone=6209
L["Grim Batol"] = "Grim Batol"						-- http://es.wowhead.com/zone=4950
L["Grimrail Depot"] = "Terminal Malavía"				-- http://es.wowhead.com/zone=6984
L["Grizzly Hills"] = "Colinas Pardas"
L["Gruul's Lair"] = "Guarida de Gruul"
L["Gundrak"] = "Gundrak"						-- http://es.wowhead.com/zone=4416
L["Halls of Lightning"] = "Cámaras de Relámpagos"
L["Halls of Origination"] = "Cámaras de los Orígenes"
L["Halls of Reflection"] = "Cámaras de Reflexión"
L["Halls of Stone"] = "Cámaras de Piedra"
L["Heart of Fear"] = "Corazón del Miedo"				-- http://es.wowhead.com/zone=6297
L["Hellfire Peninsula"] = "Península del Fuego Infernal"
L["Hellfire Ramparts"] = "Murallas del Fuego Infernal"
L["Highmaul"] = "Ogrópolis"						-- http://es.wowhead.com/zone=6996
L["Hillsbrad Foothills"] = "Laderas de Trabalomas"
L["Hour of Twilight"] = "Hora del Crepúsculo"				-- http://es.wowhead.com/zone=5844
L["Howling Fjord"] = "Fiordo Aquilonal"
L["Hrothgar's Landing"] = "Desembarco de Hrothgar"
L["Hyjal Summit"] = "La Cima Hyjal"
L["Icecrown Citadel"] = "Ciudadela de la Corona de Hielo"
L["Icecrown"] = "Corona de Hielo"
L["Iron Docks"] = "Puerto de Hierro"					-- http://es.wowhead.com/zone=6951
L["Ironforge"] = "Forjaz"
L["Isle of Conquest"] = "Isla de la Conquista"
L["Isle of Giants"] = "Isla de los Gigantes"
L["Isle of Quel'Danas"] = "Isla de Quel'Danas"
L["Isle of Thunder Scenario"] = true
L["Isle of Thunder"] = "Isla del Trueno"
L["Kalimdor"] = "Kalimdor"
L["Karazhan"] = "Karazhan"						-- http://es.wowhead.com/zone=3457
L["Kelp'thar Forest"] = "Bosque Kelp'thar"
L["Kezan"] = "Kezan"							-- http://es.wowhead.com/zone=4737
L["Krasarang Wilds"] = "Espesura Krasarang"
L["Kun-Lai Summit"] = "Cima Kun-Lai"
L["Lion's Landing"] = "Desembarco del León"				-- http://es.wowhead.com/zone=6575
L["Loch Modan"] = "Loch Modan"						-- http://es.wowhead.com/zone=38
L["Lost City of the Tol'vir"] = "Ciudad Perdida de los Tol'vir"
L["Lunarfall"] = "Bajaluna"						-- http://es.wowhead.com/zone=7078
L["Magisters' Terrace"] = "Bancal del Magister"
L["Magtheridon's Lair"] = "Guarida de Magtheridon"
L["Mana-Tombs"] = "Tumbas de Maná"
L["Maraudon"] = "Maraudon"						-- http://es.wowhead.com/zone=6514
L["Mogu'shan Palace"] = "Palacio Mogu'shan"				-- http://es.wowhead.com/zone=6182
L["Mogu'shan Vaults"] = "Cámaras Mogu'shan"				-- http://es.wowhead.com/zone=6125
L["Molten Front"] = "Frente de Magma"					-- http://es.wowhead.com/zone=5733
L["Moonglade"] = "Claro de la Luna"
L["Mount Hyjal"] = "Monte Hyjal"
L["Mulgore"] = "Mulgore"						-- http://es.wowhead.com/zone=215
L["Nagrand Arena"] = "Arena de Nagrand"
L["Nagrand"] = "Nagrand"						-- http://es.wowhead.com/zone=3518 & http://es.wowhead.com/zone=6755
L["Naxxramas"] = "Naxxramas"						-- http://es.wowhead.com/zone=3456
L["Netherstorm"] = "Tormenta Abisal"
L["New Tinkertown"] = "Nueva Ciudad Manitas"
L["Northern Barrens"] = "Los Baldíos del Norte"
L["Northern Stranglethorn"] = "Norte de la Vega de Tuercespina"
L["Northrend"] = "Rasganorte"
L["Northshire"] = "Villanorte"
L["Old Hillsbrad Foothills"] = "Antiguas Laderas de Trabalomas"
L["Onyxia's Lair"] = "Guarida de Onyxia"
L["Orgrimmar"] = "Orgrimmar"						-- http://es.wowhead.com/zone=1637
L["Outland"] = "Terrallende"
L["Pandaria" ] = "Pandaria"
L["Pit of Saron"] = "Foso de Saron"
L["Plaguelands: The Scarlet Enclave"] = "Tierras de la Peste: El Enclave Escarlata"
L["Ragefire Chasm"] = "Sima Ígnea"
L["Razorfen Downs"] = "Zahúrda Rajacieno"
L["Razorfen Kraul"] = "Horado Rajacieno"
L["Redridge Mountains"] = "Montañas Crestagrana"
L["Ruins of Ahn'Qiraj"] = "Ruinas de Ahn'Qiraj"
L["Ruins of Gilneas City"] = "Ruinas de la Ciudad de Gilneas"
L["Ruins of Gilneas"] = "Ruinas de Gilneas"
L["Ruins of Lordaeron"] = "Ruinas de Lordaeron"
L["Scarlet Halls"] = "Cámaras Escarlata"				-- http://es.wowhead.com/zone=6052
L["Scarlet Monastery"] = "Monasterio Escarlata"
L["Scholomance"] = "Scholomance"					-- http://es.wowhead.com/zone=6066
L["Searing Gorge"] = "La Garganta de Fuego"
L["Serpentshrine Cavern"] = "Caverna Santuario Serpiente"
L["Sethekk Halls"] = "Salas Sethekk"
L["Shado-Pan Monastery"] = "Monasterio del Shadopan"			-- http://es.wowhead.com/zone=5918
L["Shadow Labyrinth"] = "Laberinto de las Sombras"
L["Shadowfang Keep"] = "Castillo de Colmillo Oscuro"
L["Shadowglen"] = "Cañada Umbría"
L["Shadowmoon Burial Grounds"] = "Cementerio de Sombraluna"		-- http://es.wowhead.com/zone=6932
L["Shadowmoon Valley"] = "Valle Sombraluna"
L["Shattrath City"] = "Ciudad de Shattrath"
L["Shimmering Expanse"] = "Extensión Bruñida"
L["Sholazar Basin"] = "Cuenca de Sholazar"
L["Shrine of Seven Stars"] = "Santuario de las Siete Estrellas"
L["Shrine of Two Moons"] = "Santuario de las Dos Lunas"
L["Siege of Niuzao Temple"] = "Asedio del Templo de Niuzao"		-- http://es.wowhead.com/zone=6214
L["Siege of Orgrimmar"] = "Asedio de Orgrimmar"				-- http://es.wowhead.com/zone=6738
L["Silithus"] = "Silithus"						-- http://es.wowhead.com/zone=1377
L["Silvermoon City"] = "Ciudad de Lunargenta"
L["Silverpine Forest"] = "Bosque de Argénteos"
L["Silvershard Mines"] = "Minas Lonjaplata"				-- http://es.wowhead.com/zone=6126
L["Skyreach"] = "Trecho Celestial"					-- http://es.wowhead.com/zone=6988
L["Southern Barrens"] = "Los Baldíos del Sur"
L["Spires of Arak"] = "Cumbres de Arak"					-- http://es.wowhead.com/zone=6722
L["Stonetalon Mountains"] = "Sierra Espolón"
L["Stormshield"] = "Escudo de Tormenta"					-- http://es.wowhead.com/zone=7332
L["Stormstout Brewery"] = "Cervecería del Trueno"			-- http://es.wowhead.com/zone=5963
L["Stormwind City"] = "Ciudad de Ventormenta"
L["The Stockade"] = "Las Mazmorras"					-- Replaces Stormwind Stockade http://es.wowhead.com/zone=717
L["Strand of the Ancients"] = "Playa de los Ancestros"
L["Stranglethorn Vale"] = "Vega de Tuercespina"
L["Stratholme"] = "Stratholme"						-- http://es.wowhead.com/zone=2017
L["Sunstrider Isle"] = "Isla del Caminante del Sol"
L["Sunwell Plateau"] = "Meseta de La Fuente del Sol"
L["Swamp of Sorrows"] = "Pantano de las Penas"
L["Talador"] = "Talador"						-- http://es.wowhead.com/zone=6662
L["Tanaan Jungle"] = "Selva de Tanaan"					-- http://es.wowhead.com/zone=7025
L["Tanaris"] = "Tanaris"						-- http://es.wowhead.com/zone=440
L["Tarren Mill vs Southshore"] = "Laderas de Trabalomas"		-- http://es.wowhead.com/zone=7107
L["Teldrassil"] = "Teldrassil"						-- http://es.wowhead.com/zone=141
L["The Eye"] = "El Ojo"							-- Replaces Tempest Keep http://wow.zamimg.com/images/wow/maps/eses/zoom/3845-1.jpg
L["Temple of Kotmogu"] = "Templo de Kotmogu"				-- http://es.wowhead.com/zone=6051
L["Temple of the Jade Serpent"] = "Templo del Dragón de Jade"		-- http://es.wowhead.com/zone=5956
L["Terokkar Forest"] = "Bosque de Terokkar"
L["Terrace of Endless Spring"] = "Veranda de la Primavera Eterna"	-- http://es.wowhead.com/zone=6067
L["The Arcatraz"] = "El Arcatraz"
L["The Bastion of Twilight"] = "El Bastión del Crepúsculo"
L["The Battle for Gilneas"] = "La Batalla por Gilneas"
L["The Black Morass"] = "La Ciénaga Negra"
L["The Blood Furnace"] = "El Horno de Sangre"
L["The Botanica"] = "El Invernáculo"
L["The Cape of Stranglethorn"] = "El Cabo de Tuercespina"
L["The Culling of Stratholme"] = "La Matanza de Stratholme"
L["The Deadmines"] = "Las Minas de la Muerte"
L["The Everbloom"] = "El Vergel Eterno"					-- http://es.wowhead.com/zone=7109
L["The Exodar"] = "El Exodar"
L["The Eye of Eternity"] = "El Ojo de la Eternidad"
L["The Forge of Souls"] = "La Forja de Almas"
L["The Hinterlands"] = "Tierras del Interior"
L["The Jade Forest"] = "El Bosque de Jade"
L["The Lost Isles"] = "Las Islas Perdidas"
L["The Maelstrom"] = "La Vorágine"
L["The Mechanar"] = "El Mechanar"
L["Molten Core"] = "Núcleo de Magma"					-- Replaces The Molten Core http://es.wowhead.com/zone=2717
L["The Nexus"] = "El Nexo"
L["The Obsidian Sanctum"] = "El Sagrario Obsidiana"
L["The Oculus"] = "El Oculus"
L["The Ruby Sanctum"] = "El Sagrario Rubí"
L["The Secrets of Ragefire"] = "Los Secretos de Sima Ígnea"		-- http://es.wowhead.com/zone=6731
L["The Shattered Halls"] = "Las Salas Arrasadas"
L["The Slave Pens"] = "Recinto de los Esclavos"
L["The Steamvault"] = "La Cámara de Vapor"
L["The Stonecore"] = "El Núcleo Pétreo"
L["The Storm Peaks"] = "Las Cumbres Tormentosas"
L["The Temple of Atal'Hakkar"] = "El Templo de Atal'Hakkar"
L["The Underbog"] = "La Sotiénaga"
L["The Veiled Stair"] = "La Escalera Velada"
L["The Violet Hold"] = "El Bastión Violeta"
L["The Vortex Pinnacle"] = "La Cumbre del Vórtice"
L["The Wandering Isle"] = "La Isla Errante"				-- http://es.wowhead.com/zone=5736
L["Thousand Needles"] = "Las Mil Agujas"
L["Throne of the Four Winds"] = "Trono de los Cuatro Vientos"
L["Throne of the Tides"] = "Trono de las Mareas"
L["Throne of Thunder"] = "Solio del Trueno"				-- http://es.wowhead.com/zone=6622
L["Thunder Bluff"] = "Cima del Trueno"
L["Thunder King's Citadel"] = "Ciudadela del Rey del Trueno"		-- http://es.wowhead.com/zone=6716
L["Tigers Peak Arena"] = "La Cima del Tigre"				-- Is this one corect? http://es.wowhead.com/zone=6732
L["Timeless Isle"] = "Isla Intemporal"
L["Tirisfal Glades"] = "Claros de Tirisfal"
L["Tol Barad Peninsula"] = "Península de Tol Barad"
L["Tol Barad"] = "Tol Barad"						-- http://es.wowhead.com/zone=5095
L["Tol'vir Proving Grounds"] = true
L["Townlong Steppes"] = "Estepas de Tong Long"
L["Trial of the Champion"] = "Prueba del Campeón"
L["Trial of the Crusader"] = "Prueba del Cruzado"
L["Twilight Highlands"] = "Tierras Altas Crepusculares"
L["Twin Peaks"] = "Cumbres Gemelas"
L["Uldaman"] = "Uldaman"						-- http://es.wowhead.com/zone=1337
L["Ulduar"] = "Ulduar"							-- http://es.wowhead.com/zone=4273
L["Uldum"] = "Uldum"							-- http://es.wowhead.com/zone=5034
L["Undercity"] = "Entrañas"
L["Unga Ingoo"] = "Unga Ingoo"						-- http://es.wowhead.com/zone=6309
L["Un'Goro Crater"] = "Cráter de Un'Goro"
L["Unknown Zone"] = true
L["Upper Blackrock Spire"] = "Cumbre de Roca Negra Superior"		-- http://es.wowhead.com/zone=7307
L["Utgarde Keep"] = "Fortaleza de Utgarde"
L["Utgarde Pinnacle"] = "Pináculo de Utgarde"
L["Vale of Eternal Blossoms"] = "Valle de la Flor Eterna"
L["Valley of the Four Winds"] = "Valle de los Cuatro Vientos"
L["Valley of Trials"] = "Valle de los Retos"
L["Vashj'ir"] = "Vashj'ir"						-- http://es.wowhead.com/zone=5146
L["Vault of Archavon"] = "La Cámara de Archavon"
L["Wailing Caverns"] = "Cuevas de los Lamentos"
L["Warsong Gulch"] = "Garganta Grito de Guerra"
L["Warspear"] = "Lanza de Guerra"					-- http://es.wowhead.com/zone=7333
L["Well of Eternity"] = "Pozo de la Eternidad"				-- http://es.wowhead.com/zone=5788
L["Western Plaguelands"] = "Tierras de la Peste del Oeste"
L["Westfall"] = "Páramos de Poniente"
L["Wetlands"] = "Los Humedales"
L["Wintergrasp"] = "Conquista del Invierno"
L["Winterspring"] = "Cuna del Invierno"
L["Zangarmarsh"] = "Marisma de Zangar"
L["Zul'Aman"] = "Zul'Aman"						-- http://es.wowhead.com/zone=3805
L["Zul'Drak"] = "Zul'Drak"						-- http://es.wowhead.com/zone=66
L["Zul'Farrak"] = "Zul'Farrak"						-- http://es.wowhead.com/zone=1176
L["Zul'Gurub"] = "Zul'Gurub"						-- http://es.wowhead.com/zone=1977

L["Cantrips & Crows"] = true
L["Circle of Wills"] = true
L["The Black Market"] = "El Mercado Negro"				-- http://es.wowhead.com/npc=62943
L["The Underbelly"] = "Los Bajos Fondos"				-- please verify http://es.wowhead.com/object=193610
