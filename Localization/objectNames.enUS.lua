-- Please use the Localization App on WoWAce to Update this
-- https://wow.curseforge.com/projects/wowgatheringnodes/localization

local debug = false
--[===[@debug@
debug = true
--@end-debug@]===]

local WoWGatheringNodes = LibStub("AceAddon-3.0"):NewAddon("WoWGatheringNodes")
local L = LibStub("AceLocale-3.0"):NewLocale("WoWGatheringNodes", "enUS", true, debug)
if not L then return end

L["Clear Data"] = "Clear Data"
L["Clears data from memory if version has already been imported."] = "Clears data from memory if version has already been imported."
L["Custom Objects"] = "Custom Objects"
L["Enable Custom Objects"] = "Enable Custom Objects"
L["Failed to load WoWGatheringNodes due to "] = "Failed to load WoWGatheringNodes due to "
L["Import WoWGatheringNodes"] = "Import WoWGatheringNodes"
L["Inject %s into gathering addons"] = "Inject %s into gathering addons"
L["Injects new objects into Gatherer/Gathermate2 that are not currently in their data files"] = "Injects new objects into Gatherer/Gathermate2 that are not currently in their data files"
L["Load WoWGatheringNodes and import the data to your database."] = "Load WoWGatheringNodes and import the data to your database."
L["Merge will add WoWGatheringNodes to your database. Overwrite will replace your database with the data in WoWGatheringNodes"] = "Merge will add WoWGatheringNodes to your database. Overwrite will replace your database with the data in WoWGatheringNodes"
L["WoWGatheringNodes has been imported."] = "WoWGatheringNodes has been imported."


WoWGatheringNodes.NodeIdNames = {
	[181069] =  "Large Obsidian Chunk",
	[2040] =  "Mithril Deposit",
	[2041] =  "Liferoot",
	[209330] =  "Rich Trillium Vein",
	[2043] =  "Khadgar's Whisker",
	[2044] =  "Dragon's Teeth",
	[2045] =  "Stranglekelp",
	[2046] =  "Goldthorn",
	[2047] =  "Truesilver Deposit",
	[201914] =  "Moonleaf",
	[216620] =  "Jungle Hops",
	[182606] =  "Dragonspine",
	[218539] =  "Large Swarm of Migrated Reef Octopus",
	[209460] =  "Rattan Switch",
	[233117] =  "Frostweed",
	[182095] =  "Burstcap Mushroom",
	[188489] =  "Ruby Lilac",
	[2084] =  "Musquash Root",
	[209461] =  "Rattan Switch",
	[123848] =  "Ooze Covered Thorium Vein",
	[208311] =  "Deepsea Sagefish School",
	[209462] =  "Rattan Switch",
	[247697] =  "Odious Felslate Outcropping",
	[209974] =  "Barrel of Slickies",
	[209463] =  "Rattan Switch",
	[247698] =  "Shattered Felslate Seam",
	[253069] =  "Blacker Lotus",
	[247699] =  "Primordial Felslate Deposit",
	[246804] =  "Highmountain Tauren Archaeology Find",
	[203071] =  "Night Elf Archaeology Find",
	[208442] =  "Blueroot Vine",
	[237342] =  "Savage Piranha Pool",
	[190540] =  "Chunk of Saronite",
	[247956] =  "Brimstone Destroyer Core",
	[247957] =  "Brimstone Destroyer Core",
	[273412] =  "Ancient Eredar Cache",
	[208828] =  "Corpse Worm Mound",
	[203969] =  "Prickly Pear Fruit",
	[13891] =  "Serpentbloom",
	[188113] =  "Frostberry Bush",
	[273415] =  "Ancient Eredar Cache",
	[247959] =  "Brimstone Destroyer Core",
	[3239] =  "Benedict's Chest",
	[185557] =  "Ancient Gem Vein",
	[260492] =  "Glowing Tome",
	[247961] =  "Brimstone Destroyer Core",
	[260493] =  "Mana-Infused Gem",
	[211517] =  "Snarlvine",
	[246811] =  "Highborne Archaeology Find",
	[247962] =  "Brimstone Destroyer Core",
	[203078] =  "Nerubian Archaeology Find",
	[260494] =  "Twice-Fortified Arcwine",
	[211518] =  "Snarlvine",
	[216761] =  "Mixed Ocean School",
	[208833] =  "Stillwater Lily",
	[246812] =  "Demonic Archaeology Find",
	[247963] =  "Brimstone Destroyer Core",
	[184793] =  "Primitive Chest",
	[247964] =  "Brimstone Destroyer Core",
	[234154] =  "Misplaced Scrolls",
	[247965] =  "Brimstone Destroyer Core",
	[234155] =  "Relics of the Outcasts",
	[209987] =  "Dreamleaf Bush",
	[247966] =  "Brimstone Destroyer Core",
	[260498] =  "Leypetal Blossom",
	[247967] =  "Brimstone Destroyer Core",
	[209349] =  "Green Tea Leaf",
	[211779] =  "Mao-Willow",
	[175207] =  "Beached Sea Creature",
	[212163] =  "Emperor Salmon School",
	[209350] =  "Silkweed",
	[190169] =  "Tiger Lily",
	[185182] =  "Nethervine Crystal",
	[247969] =  "Brimstone Destroyer Core",
	[209351] =  "Snow Lily",
	[190170] =  "Talandra's Rose",
	[202702] =  "Stonebloom",
	[247075] =  "Secreted Wax Glob",
	[190171] =  "Lichbloom",
	[237357] =  "Rich True Iron Deposit",
	[202703] =  "Bitterblossom",
	[244774] =  "Aethril",
	[203982] =  "Okra",
	[209353] =  "Rain Poppy",
	[190172] =  "Icethorn",
	[237358] =  "True Iron Deposit",
	[244775] =  "Dreamleaf",
	[209354] =  "Golden Lotus",
	[17282] =  "Bathran's Hair",
	[190173] =  "Frozen Herb",
	[237359] =  "Blackrock Deposit",
	[244776] =  "Dreamleaf",
	[209355] =  "Fool's Cap",
	[237360] =  "Rich Blackrock Deposit",
	[244777] =  "Fjarnskaggl",
	[212169] =  "Giant Mantis Shrimp Swarm",
	[225596] =  "Prickly Nopal",
	[180712] =  "Stonescale Eel Swarm",
	[190175] =  "Frozen Herb",
	[244778] =  "Starlight Rose",
	[177388] =  "Ooze Covered Rich Thorium Vein",
	[190176] =  "Frost Lotus",
	[212171] =  "Jade Lungfish School",
	[195036] =  "Pure Saronite Deposit",
	[212172] =  "Krasarang Paddlefish School",
	[218950] =  "Mantid Archaeology Find",
	[212174] =  "Reef Octopus Swarm",
	[207187] =  "Orc Archaeology Find",
	[247340] =  "Crude Leystone Seam",
	[212175] =  "Tiger Gourami School",
	[207188] =  "Draenei Archaeology Find",
	[211025] =  "Goldenfire Orchid",
	[207189] =  "Vrykul Archaeology Find",
	[212177] =  "Spinefish School",
	[207190] =  "Tol'vir Archaeology Find",
	[182127] =  "Corrupted Flower",
	[244786] =  "Felwort",
	[251181] =  "Azure Ore",
	[203228] =  "Needles Iron Pyrite",
	[269887] =  "Fel-Encrusted Herb Cluster",
	[181108] =  "Truesilver Deposit",
	[247987] =  "Brilliant Leystone Seam",
	[184689] =  "Draenethyst Mine Crystal",
	[218576] =  "Large Tangled Mantis Shrimp Cluster",
	[226888] =  "Aruunem Berry Bush",
	[211160] =  "Pristine Crane Egg",
	[218577] =  "Tangled Mantis Shrimp Cluster",
	[247605] =  "Flourishing Aethril",
	[247989] =  "Wild Leystone Seam",
	[184691] =  "Shadowmoon Tuber",
	[141853] =  "Violet Tragan",
	[247606] =  "Flourishing Dreamleaf",
	[273222] =  "Eredar War Supplies",
	[272455] =  "Eredar War Supplies",
	[267596] =  "Tar-Covered Fish",
	[2714] =  "Alterac Granite",
	[272456] =  "Eredar War Supplies",
	[211163] =  "Pandaren Archaeology Find",
	[247352] =  "Hard Leystone Deposit",
	[247608] =  "Flourishing Starlight Rose",
	[241726] =  "Leystone Deposit",
	[205538] =  "Thorny Stankroot",
	[247865] =  "Aqueous Aethril",
	[229068] =  "Fat Sleeper School",
	[229069] =  "Blind Lake Sturgeon School",
	[181372] =  "Hellfire Spineleaf",
	[229070] =  "Fire Ammonite School",
	[229071] =  "Sea Scorpion School",
	[208867] =  "Shiny Stones",
	[184443] =  "Ivory Bell",
	[74447] =  "Large Iron Bound Chest",
	[229072] =  "Abyssal Gulper School",
	[229073] =  "Blackwater Whiptail School",
	[181248] =  "Copper Vein",
	[208997] =  "Eternal Sunfruit",
	[247999] =  "Felwort",
	[181249] =  "Tin Vein",
	[248000] =  "Felwort",
	[2866] =  "Firebloom",
	[152094] =  "Hyacinth Mushroom",
	[211684] =  "Volatile Blooms",
	[234446] =  "Relics of the Outcasts",
	[208999] =  "Eternal Lunar Pear",
	[248001] =  "Felwort",
	[152095] =  "Moonpetal Lily",
	[211174] =  "Mogu Archaeology Find",
	[181891] =  "Blood Mushroom",
	[248003] =  "Felwort",
	[187902] =  "Bloodspore Carpel",
	[181892] =  "Aquatic Stinkhorn",
	[268901] =  "Felslate Spike",
	[178184] =  "Sapphire of Aku'Mai",
	[248004] =  "Felwort",
	[181893] =  "Ruinous Polyspore",
	[207724] =  "Shipwreck Debris",
	[208875] =  "Mulgore Pine Cone",
	[248005] =  "Felwort",
	[247366] =  "Rough Leystone Outcropping",
	[234451] =  "Relics of the Outcasts",
	[126049] =  "Magenta Cap Clusters",
	[248006] =  "Felwort",
	[210539] =  "Eternal Blossom",
	[203762] =  "Juicy Apple",
	[248007] =  "Felwort",
	[202740] =  "Rich Pyrite Deposit",
	[228571] =  "Frostweed",
	[221538] =  "Ghost Iron Deposit",
	[181897] =  "Ysera's Tear",
	[268911] =  "Blood of Sargeras",
	[234454] =  "Relics of the Outcasts",
	[241743] =  "Felslate Deposit",
	[248009] =  "Felwort",
	[221539] =  "Rich Ghost Iron Deposit",
	[247370] =  "Brimstone Destroyer Core",
	[165658] =  "Dark Iron Deposit",
	[206706] =  "Crying Violet",
	[234455] =  "Relics of the Outcasts",
	[228573] =  "Gorgrond Flytrap",
	[221540] =  "Rich Trillium Vein",
	[207346] =  "Moonpetal Lily",
	[245325] =  "Rich Felslate Deposit",
	[273519] =  "Legion War Supplies",
	[248011] =  "Felwort",
	[181644] =  "Azure Snapdragon",
	[237398] =  "Frostweed",
	[206836] =  "Fossil Archaeology Find",
	[273521] =  "Legion War Supplies",
	[248012] =  "Felwort",
	[221542] =  "Green Tea Leaf",
	[273523] =  "Legion War Supplies",
	[228576] =  "Talador Orchid",
	[221543] =  "Rain Poppy",
	[180751] =  "Floating Wreckage",
	[273524] =  "Legion War Supplies",
	[205559] =  "Rotberry Bush",
	[237400] =  "Talador Orchid",
	[209907] =  "Meadow Marigold",
	[221544] =  "Silkweed",
	[204281] =  "Worm Mound",
	[207734] =  "Pool of Fire",
	[206839] =  "The Light of Souls",
	[232542] =  "Blackrock Deposit",
	[221545] =  "Golden Lotus",
	[204282] =  "Dwarf Archaeology Find",
	[273528] =  "Legion War Supplies",
	[237402] =  "Gorgrond Flytrap",
	[202748] =  "Stormvine",
	[232543] =  "Rich Blackrock Deposit",
	[202749] =  "Azshara's Veil",
	[232544] =  "True Iron Deposit",
	[248017] =  "Wispy Foxflower",
	[221547] =  "Fool's Cap",
	[237404] =  "Starflower",
	[202750] =  "Heartblossom",
	[232545] =  "Rich True Iron Deposit",
	[248018] =  "Bushy Foxflower",
	[221548] =  "Jewel Danio School",
	[240346] =  "Olive Sprig",
	[202751] =  "Twilight Jasmine",
	[273535] =  "Legion War Supplies",
	[272768] =  "Empyrium Deposit",
	[221549] =  "Redbelly Mandarin School",
	[237406] =  "Nagrand Arrowbloom",
	[202752] =  "Whiptail",
	[248020] =  "Iridescent Aethril",
	[11713] =  "Death Cap",
	[235105] =  "Sun-Touched Cache",
	[142140] =  "Purple Lotus",
	[181270] =  "Felweed",
	[142141] =  "Arthas' Tears",
	[188432] =  "Black Blood of Yogg-Saron",
	[248022] =  "Bushy Aethril",
	[1610] =  "Incendicite Mineral Vein",
	[142142] =  "Sungrass",
	[248023] =  "Lively Dreamleaf",
	[1618] =  "Peacebloom",
	[1619] =  "Earthroot",
	[1620] =  "Mageroyal",
	[142143] =  "Blindweed",
	[171938] =  "Cactus Apple",
	[1623] =  "Wild Steelbloom",
	[1624] =  "Kingsblood",
	[272778] =  "Rich Empyrium Deposit",
	[185877] =  "Nethercite Deposit",
	[1628] =  "Grave Moss",
	[123309] =  "Ooze Covered Truesilver Deposit",
	[235365] =  "Admiral Taylor's Coffer",
	[247897] =  "Singed Fjarnskaggl",
	[272780] =  "Empyrium Seam",
	[142145] =  "Gromsblood",
	[181275] =  "Ragveil",
	[205060] =  "Plague Tangle",
	[211454] =  "Kafa'kota Bush",
	[123310] =  "Ooze Covered Mithril Deposit",
	[181276] =  "Flame Cap",
	[248027] =  "Brambly Fjarnskaggl",
	[247388] =  "Flourishing Foxflower",
	[181277] =  "Terocone",
	[248028] =  "Prickly Fjarnskaggl",
	[185881] =  "Netherdust Bush",
	[206597] =  "Twilight's Hammer Crate",
	[201738] =  "Budding Flower",
	[268440] =  "Highborne Archaeology Find",
	[248029] =  "Pungent Fjarnskaggl",
	[181279] =  "Netherbloom",
	[248030] =  "Lively Starlight Rose",
	[209284] =  "Darkblossom",
	[181280] =  "Nightmare Vine",
	[248031] =  "Iridescent Starlight Rose",
	[181281] =  "Mana Thistle",
	[247904] =  "Bright Leystone Deposit",
	[248032] =  "Sparkling Starlight Rose",
	[181665] =  "Burial Chest",
	[247905] =  "Warm Leystone Deposit",
	[188699] =  "Strange Ore",
	[273052] =  "Fel-Encrusted Herb",
	[189978] =  "Cobalt Deposit",
	[273053] =  "Fel-Encrusted Herb Cluster",
	[247906] =  "Fiery Leystone Deposit",
	[179493] =  "Mossy Footlocker",
	[189979] =  "Rich Cobalt Deposit",
	[268451] =  "Demonic Archaeology Find",
	[241641] =  "Foxflower",
	[247907] =  "Massive Leystone Deposit",
	[179494] =  "Dented Footlocker",
	[189980] =  "Saronite Deposit",
	[268453] =  "Highborne Archaeology Find",
	[211719] =  "Violet Citron",
	[235376] =  "Frostweed",
	[247908] =  "Glowing Leystone Deposit",
	[1723] =  "Mudsnout Blossom",
	[237295] =  "Oily Sea Scorpion School",
	[247909] =  "Smooth Leystone Deposit",
	[175404] =  "Rich Thorium Vein",
	[253280] =  "Leystone Seam",
	[1731] =  "Copper Vein",
	[1732] =  "Tin Vein",
	[1733] =  "Silver Vein",
	[1734] =  "Gold Vein",
	[1735] =  "Iron Deposit",
	[247910] =  "Fine Leystone Deposit",
	[184740] =  "Wicker Chest",
	[247911] =  "Charged Leystone Deposit",
	[179498] =  "Scarlet Footlocker",
	[184741] =  "Dented Footlocker",
	[182951] =  "Pure Water",
	[243564] =  "Basket of Dried Herbs",
	[247912] =  "Exquisite Leystone Deposit",
	[218629] =  "Glowing Jade Lungfish",
	[182952] =  "Steam Pump Flotsam",
	[252772] =  "Ancient Mana Chunk",
	[247913] =  "Magnificent Leystone Deposit",
	[218630] =  "Large Pool of Glowing Jade Lungfish",
	[182953] =  "Sporefish School",
	[210958] =  "Chrysoberyl Outcropping",
	[268466] =  "Demonic Archaeology Find",
	[186662] =  "Reagent Pouch",
	[218631] =  "Swarm of Panicked Paddlefish",
	[182954] =  "Brackish Mixed School",
	[252774] =  "Ancient Mana Crystal",
	[210959] =  "Chrysoberyl Outcropping",
	[247915] =  "Striking Leystone Deposit",
	[218632] =  "Large Swarm of Panicked Paddlefish",
	[243312] =  "Rich Blackrock Deposit",
	[210960] =  "Chrysoberyl Outcropping",
	[247916] =  "Ancient Leystone Deposit",
	[218633] =  "Brew Frenzied Emperor Salmon",
	[243313] =  "Blackrock Deposit",
	[181166] =  "Bloodthistle",
	[203800] =  "Barrel of Canal Fish",
	[247917] =  "Dark Leystone Deposit",
	[180655] =  "Floating Debris",
	[218634] =  "Large Pool of Brew Frenzied Emperor Salmon",
	[243314] =  "True Iron Deposit",
	[202778] =  "Albino Cavefish School",
	[247918] =  "Stormy Leystone Deposit",
	[211474] =  "Suncrawler",
	[243315] =  "Rich True Iron Deposit",
	[235387] =  "Fireweed",
	[202779] =  "Blackbelly Mudfish School",
	[181680] =  "Drycap Mushroom",
	[218636] =  "Large Pool of Tiger Gourami Slush",
	[182959] =  "Bluefish School",
	[235388] =  "Gorgrond Flytrap",
	[202780] =  "Fathom Eel Swarm",
	[180658] =  "School of Deviate Fish",
	[194213] =  "Winter Hyacinth",
	[235389] =  "Starflower",
	[175928] =  "Incendia Agave",
	[235390] =  "Nagrand Arrowbloom",
	[277637] =  "Void-Seeped Cache",
	[181555] =  "Fel Iron Deposit",
	[273443] =  "Void-Seeped Cache",
	[214547] =  "Shipwreck Debris",
	[235135] =  "Smuggled Apexis Artifacts",
	[273527] =  "Legion War Supplies",
	[202655] =  "Troll Archaeology Find",
	[2653] =  "Lesser Bloodstone Deposit",
	[247923] =  "Darkened Felslate Deposit",
	[181556] =  "Adamantite Deposit",
	[260495] =  "Leypetal Powder",
	[191019] =  "Adder's Tongue",
	[271554] =  "Veiled Wyrmtongue Chest",
	[273533] =  "Legion War Supplies",
	[273538] =  "Legion War Supplies",
	[271227] =  "Hidden Wyrmtongue Cache",
	[247924] =  "Burning Felslate Deposit",
	[181557] =  "Khorium Vein",
	[180662] =  "Schooner Wreckage",
	[272771] =  "Eredar War Supplies",
	[272770] =  "Eredar War Supplies",
	[246518] =  "Waterlogged Chest",
	[271849] =  "Eredar War Supplies",
	[268450] =  "Highmountain Tauren Archaeology Find",
	[247925] =  "Heavy Felslate Deposit",
	[252408] =  "Ancient Mana Shard",
	[273439] =  "Ancient Eredar Cache",
	[273407] =  "Ancient Eredar Cache",
	[208540] =  "Magmolia",
	[273301] =  "Ancient Eredar Cache",
	[273414] =  "Ancient Eredar Cache",
	[192556] =  "Cave Mushroom",
	[186648] =  "Hazlek's Trunk",
	[233715] =  "Goldtoe's Plunder",
	[247968] =  "Brimstone Destroyer Core",
	[153468] =  "Large Mithril Bound Chest",
	[179496] =  "Dented Footlocker",
	[20691] =  "Cozzle's Footlocker",
	[179491] =  "Waterlogged Footlocker",
	[176189] =  "Skeletal Sea Turtle",
	[179488] =  "Battered Footlocker",
	[205089] =  "Stabthistle Seed",
	[255344] =  "Felslate Seam",
	[192046] =  "Musselback Sculpin School",
	[179487] =  "Waterlogged Footlocker",
	[179486] =  "Battered Footlocker",
	[205367] =  "Wolfsbane",
	[180685] =  "Waterlogged Wreckage",
	[218635] =  "Tiger Gourami Slush",
	[184845] =  "Strange Pool",
	[181278] =  "Ancient Lichen",
	[252404] =  "Felwort",
	[243325] =  "Felmouth Frenzy School",
	[192051] =  "Borean Man O' War School",
	[228572] =  "Fireweed",
	[248019] =  "Lively Aethril",
	[248010] =  "Felwort",
	[237396] =  "Fireweed",
	[209311] =  "Ghost Iron Deposit",
	[192048] =  "Dragonfin Angelfish School",
	[208544] =  "Magmolia",
	[209952] =  "Jademoon",
	[181271] =  "Dreaming Glory",
	[182956] =  "School of Darter",
	[228493] =  "True Iron Deposit",
	[248026] =  "Fragrant Dreamleaf",
	[209312] =  "Kyparite Deposit",
	[192049] =  "Fangtooth Herring School",
	[206085] =  "Frozen Herb",
	[247958] =  "Brimstone Destroyer Core",
	[212902] =  "Solidified Amber",
	[186423] =  "Witchbane",
	[210080] =  "Mulberry Barrel",
	[2042] =  "Fadeleaf",
	[209313] =  "Trillium Vein",
	[192050] =  "Glacial Salmon School",
	[205099] =  "Ferocious Doomweed",
	[202736] =  "Obsidium Deposit",
	[209825] =  "Tidemist Cap",
	[321] =  "Tear of Tilloa",
	[191303] =  "Firethorn",
	[210209] =  "Imperial Lotus",
	[202737] =  "Pyrite Deposit",
	[218649] =  "Large Pool of Crowded Redbelly Mandarin",
	[248025] =  "Bushy Dreamleaf",
	[228575] =  "Nagrand Arrowbloom",
	[202738] =  "Elementium Vein",
	[228991] =  "Frostblossom",
	[209059] =  "Blood Nettle",
	[235391] =  "Talador Orchid",
	[202739] =  "Rich Obsidium Deposit",
	[192052] =  "Imperial Manta Ray School",
	[236169] =  "Harvestable Precious Crystal",
	[183385] =  "Sanguine Hibiscus",
	[324] =  "Small Thorium Vein",
	[229067] =  "Jawless Skulker School",
	[205423] =  "Banshee's Bells",
	[202747] =  "Cinderbloom",
	[202741] =  "Rich Elementium Vein",
	[192053] =  "Deep Sea Monsterbelly School",
	[206503] =  "Prayerbloom",
	[214510] =  "Sha-Touched Herb",
	[188345] =  "Shimmering Snowcaps",
	[176589] =  "Black Lotus",
	[202776] =  "Mountain Trout School",
	[189973] =  "Goldclover",
	[234105] =  "Arakkoa Archaeology Find",
	[194100] =  "Bear's Paw",
	[218648] =  "Crowded Redbelly Mandarin",
	[234106] =  "Ogre Archaeology Find",
	[210537] =  "Eternal Blossom",
	[191543] =  "Scarlet Onslaught Trunk",
	[247936] =  "Coarse Leystone Outcropping",
	[181569] =  "Rich Adamantite Deposit",
	[218651] =  "Large Pool of Sha-Touched Spinefish",
	[269278] =  "Fel-Encrusted Herb",
	[208551] =  "Lucifern",
	[218653] =  "Large Pool of Glimmering Jewel Danio",
	[218650] =  "Sha-Touched Spinefish",
	[210538] =  "Eternal Blossom",
	[247937] =  "Luminous Leystone Outcropping",
	[181570] =  "Rich Adamantite Deposit",
	[176583] =  "Golden Sansam",
	[218652] =  "Glimmering Jewel Danio Pool",
	[243334] =  "Withered Herb",
	[243562] =  "Crate of Khadgar's Whiskers",
	[208878] =  "\"Magic\" Mushroom",
	[190399] =  "Muddlecap Fungus",
	[247938] =  "Gleaming Leystone Outcropping",
	[202619] =  "Flame Blossom",
	[176584] =  "Dreamfoil",
	[192057] =  "Nettlefish School",
	[226967] =  "Lagoon Pool",
	[123330] =  "Buccaneer's Strongbox",
	[182957] =  "Highland Mixed School",
	[209328] =  "Rich Ghost Iron Deposit",
	[247939] =  "Radiant Leystone Outcropping",
	[245324] =  "Rich Leystone Deposit",
	[186729] =  "Mana Berry Bush",
	[216610] =  "Krasari Iron",
	[176753] =  "Doom Weed",
	[248024] =  "Iridescent Dreamleaf",
	[206764] =  "Emerald Shimmercap",
	[186463] =  "Wyrmtail",
	[247940] =  "Hardened Leystone Outcropping",
	[216227] =  "Brittle Root",
	[176586] =  "Mountain Silversage",
	[192059] =  "Glassfin Minnow School",
	[247914] =  "Superior Leystone Deposit",
	[180901] =  "Bloodsail Wreckage",
	[189981] =  "Rich Saronite Deposit",
	[1617] =  "Silverleaf",
	[247941] =  "Dense Leystone Outcropping",
	[192827] =  "Wild Mustard",
	[176587] =  "Sorrowmoss",
	[228563] =  "Blackrock Deposit",
	[272782] =  "Astral Glory",
	[1621] =  "Briarthorn",
	[1622] =  "Bruiseweed",
	[191133] =  "Titanium Vein",
	[247942] =  "Primal Leystone Outcropping",
	[192828] =  "Crystalsong Carrot",
	[176588] =  "Icecap",
	[228564] =  "Rich Blackrock Deposit",
	[201737] =  "Budding Flower",
	[182958] =  "Mudfish School",
	[209836] =  "Freshly Fallen Petals",
	[226521] =  "Draenor Clans Archaeology Find",
	[247943] =  "Malevolent Felslate Outcropping",
	[182599] =  "Telaari Frond",
	[175566] =  "Gloom Weed",
	[142144] =  "Ghost Mushroom",
	[221541] =  "Trillium Vein",
	[271850] =  "Eredar War Supplies",
	[211721] =  "Violet Citron",
	[247988] =  "Raw Leystone Seam",
	[201975] =  "Tarblossom",
	[182600] =  "Marshberry",
	[180682] =  "Oily Blackmouth School",
	[208816] =  "Sewer Cap",
	[202421] =  "Xavren's Thorn",
	[247607] =  "Flourishing Fjarnskaggl",
	[234449] =  "Relics of the Outcasts",
	[181894] =  "Fel Cone Fungus",
	[228574] =  "Starflower",
	[182601] =  "Olemba Root",
	[180683] =  "Firefin Snapper School",
	[248002] =  "Felwort",
	[202422] =  "Marrowpetal Stalk",
	[13874] =  "Serpentbloom",
	[187333] =  "Bloodberry Bush",
	[202754] =  "Juniper Berries",
	[235095] =  "Misplaced Scroll",
	[236756] =  "Oily Abyssal Gulper School",
	[180684] =  "Greater Sagefish School",
	[206387] =  "Water Bucket",
	[216764] =  "Sagefish School",
	[181068] =  "Small Obsidian Chunk",
	[202777] =  "Highland Guppy School",
	[230428] =  "Smoldering True Iron Deposit",
	[228510] =  "Rich True Iron Deposit",
	[192818] =  "Infused Mushroom",
	[209329] =  "Rich Kyparite Deposit",
	[248008] =  "Felwort",
	[192054] =  "Moonglow Cuttlefish School",
	[247960] =  "Brimstone Destroyer Core",
	--BfA
	[273900] =  "Small Treasure Chest",
	[276234] =  "Riverbud",
	[276238] =  "Winter's Kiss",
	[278476] =  "Zandalari Archaeology Find",
	[293880] =  "Buried Treasure Chest",
	[278477] =  "Drust Archaeology Find",
	[278149] =  "Iron Deposit",
	[293800] =  "Evermoss",
	[276616] =  "Monelite Deposit",
	[281252] =  "Hearthbloom",
	[278404] =  "Redtail Loach School",
	[276622] =  "Rich Storm Silver Deposit",
	[284627] =  "Beached Sea Creature",
	[276237] =  "Akunda's Bite",
	[278399] =  "Great Sea Catfish School",
	[278402] =  "Tiragarde Perch School",
	[276623] =  "Rich Platinum Deposit",
	[273537] =  "Gravebloom",
	[290135] =  "War Supply Chest",
	[281494] =  "Frosty Treasure Chest",
	[289647] =  "Weathered Treasure Chest",
	[278401] =  "Sand Shifter School",
	[277336] =  "Treasure Chest",
	[276239] =  "Siren's Sting",
	[288646] =  "Prickly Pear",
	[293749] =  "Rasboralus School",
	[281872] =  "Sea Stalks",
	[294125] =  "Anchor Weed",
	[276618] =  "Platinum Deposit",
	[293750] =  "U'taka School",
	[276621] =  "Rich Monelite Deposit",
	[281397] =  "Cutwater Treasure Chest",
	[278406] =  "Lane Snapper School",
	[278403] =  "Slimy Mackerel School",
	[281868] =  "Star Moss",
	[278405] =  "Frenzied Fangtooth School",
	[276619] =  "Monelite Seam",
	[276617] =  "Storm Silver Deposit",
	[276620] =  "Storm Silver Seam",
}