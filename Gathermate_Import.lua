--///////////////////////////////////////////////////////////////////////////////////////////
-- Handler code for the Gathermate2 import process
-- This is based on code taken from GathermateData.lua from Gathermate2_Data
-- Gathermate2_Data is written and maintained by kagaro, & Nevcairiel and can be found at
--  https://mods.curse.com/addons/wow/gathermate2
--///////////////////////////////////////////////////////////////////////////////////////////

if not IsAddOnLoaded("GatherMate2") then return end

local WoWGatheringNodes = LibStub("AceAddon-3.0"):GetAddon("WoWGatheringNodes")
local GatherMate = LibStub("AceAddon-3.0"):GetAddon("GatherMate2")

local L = LibStub("AceLocale-3.0"):GetLocale("GatherMate2",false)

-------------------------------------------------------------------------------
-- Localized Lua globals.
-------------------------------------------------------------------------------
local _G = getfenv(0)

-- Functions
local pairs = _G.pairs
local ipairs = _G.ipairs


WoWGatheringNodes.generatedVersion = GetAddOnMetadata("WoWGatheringNodes", "X-Gatherer-Plugin-DatabaseID")

local NodeDB = WoWGatheringNodes.GatherMateData

local bcZones = {
	[94] = true,
	[95] = true,
	[97] = true,
	[100] = true,
	[102] = true,
	[103] = true,
	[104] = true,
	[105] = true,
	[106] = true,
	[107] = true,
	[108] = true,
	[109] = true,
	[110] = true,
	[111] = true,
	[122] = true,
}

local wrathZones = {
	[114] = true,
	[115] = true,
	[116] = true,
	[117] = true,
	[118] = true,
	[119] = true,
	[120] = true,
	[121] = true,
	[123] = true,
	[125] = true,
	[126] = true,
	[127] = true,
	[170] = true,
}

local cataZones = {
	[174] = true,
	[175] = true,
	[176] = true,
	[177] = true,
	[178] = true,
	[194] = true,
	[198] = true,
	[203] = true,
	[204] = true,
	[205] = true,
	[207] = true,
	[208] = true,
	[209] = true,
	[217] = true,
	[218] = true,
	[241] = true,
	[244] = true,
	[245] = true,
	[276] = true,
}

local mistsZones = {
	[371] = true,
	[376] = true,
	[379] = true,
	[388] = true,
	[390] = true,
	[418] = true,
	[422] = true,
	[433] = true,
	[504] = true,
	[507] = true,
	[516] = true,
	[554] = true,
}

local wodZones = {
	[525] = true,
	[534] = true,
	[535] = true,
	[539] = true,
	[542] = true,
	[543] = true,
	[550] = true,
	[572] = true,
	[577] = true,
	[582] = true,
	[588] = true,
	[589] = true,
	[590] = true,
	[622] = true,
	[624] = true,
}

local legionZones = {
	[627] = true,
	[628] = true,
	[630] = true,
	[634] = true,
	[641] = true,
	[646] = true,
	[650] = true,
	[680] = true,
	[790] = true,
	[830] = true,
	[882] = true,
	[885] = true,
}

local bfaZones = {
	[862] = true,
	[863] = true,
	[864] = true,
	[895] = true,
	[896] = true,
	[942] = true,
	[1161] = true,
	[1165] = true,
}

local NodeID_to_GathermateID = {
		[278477] = 620,
		[211163] = 611,
		[209311] = 241,
		[181270] = 432,
		[209312] = 245,
		[181271] = 433,
		[510] = 510,
		[209313] = 247,
		[2040] = 206,
		[160] = 160,
		[2041] = 412,
		[2042] = 413,
		[123309] = 211,
		[2043] = 415,
		[2044] = 454,
		[235376] = 474,
		[2045] = 407,
		[2046] = 414,
		[2047] = 208,
		[191303] = 451,
		[237357] = 250,
		[181275] = 440,
		[246811] = 618,
		[123310] = 207,
		[179487] = 516,
		[237358] = 249,
		[181276] = 441,
		[246812] = 617,
		[179488] = 515,
		[237295] = 177,
		[237359] = 251,
		[181277] = 434,
		[324] = 214,
		[237360] = 252,
		[202740] = 240,
		[74447] = 505,
		[521] = 521,
		[522] = 522,
		[181279] = 438,
		[241641] = 480,
		[523] = 523,
		[179491] = 516,
		[207724] = 156,
		[184793] = 527,
		[181280] = 439,
		[525] = 525,
		[234105] = 614,
		[175404] = 215,
		[181281] = 437,
		[234106] = 616,
		[179493] = 518,
		[181665] = 520,
		[185881] = 442,
		[244774] = 476,
		[179494] = 517,
		[530] = 530,
		[165] = 165,
		[244775] = 477,
		[532] = 532,
		[244776] = 477,
		[177388] = 212,
		[179496] = 517,
		[134] = 134,
		[235387] = 473,
		[202747] = 457,
		[244777] = 479,
		[536] = 536,
		[235388] = 472,
		[202748] = 458,
		[244778] = 481,
		[179498] = 519,
		[135] = 135,
		[180712] = 110,
		[202749] = 456,
		[539] = 539,
		[540] = 540,
		[235390] = 470,
		[202750] = 459,
		[541] = 541,
		[229067] = 175,
		[272768] = 259,
		[542] = 542,
		[209330] = 248,
		[260494] = 559,
		[543] = 543,
		[243312] = 252,
		[229068] = 173,
		[203071] = 601,
		[207734] = 155,
		[202752] = 461,
		[182951] = 113,
		[243313] = 251,
		[229069] = 172,
		[184740] = 526,
		[189978] = 228,
		[182952] = 119,
		[243314] = 249,
		[229070] = 174,
		[184741] = 517,
		[208311] = 157,
		[189979] = 229,
		[182953] = 118,
		[243315] = 250,
		[229071] = 176,
		[550] = 550,
		[253280] = 255,
		[260498] = 555,
		[182954] = 115,
		[190172] = 447,
		[229072] = 169,
		[278399] = 189,
		[181166] = 436,
		[189981] = 232,
		[244786] = 478,
		[190173] = 452,
		[229073] = 171,
		[278401] = 193,
		[1617] = 402,
		[1618] = 401,
		[278402] = 195,
		[1619] = 403,
		[142140] = 418,
		[1620] = 404,
		[278403] = 194,
		[1621] = 405,
		[252772] = 553,
		[1622] = 408,
		[278404] = 192,
		[1623] = 409,
		[190175] = 452,
		[1624] = 411,
		[278405] = 188,
		[221538] = 241,
		[276617] = 267,
		[276234] = 487,
		[278406] = 190,
		[182958] = 116,
		[142142] = 421,
		[1628] = 410,
		[221539] = 242,
		[276619] = 264,
		[182959] = 114,
		[142143] = 422,
		[276237] = 485,
		[221540] = 248,
		[276621] = 263,
		[276238] = 491,
		[142144] = 423,
		[276239] = 489,
		[181108] = 208,
		[221541] = 247,
		[276623] = 266,
		[294125] = 486,
		[241726] = 253,
		[142145] = 424,
		[181556] = 222,
		[221542] = 466,
		[268450] = 619,
		[181557] = 224,
		[221543] = 467,
		[268451] = 617,
		[243325] = 181,
		[221544] = 465,
		[195036] = 235,
		[273053] = 483,
		[281868] = 490,
		[293749] = 191,
		[221545] = 462,
		[293750] = 196,
		[701] = 701,
		[228572] = 473,
		[120] = 120,
		[702] = 702,
		[703] = 703,
		[281872] = 488,
		[221547] = 463,
		[2653] = 218,
		[228510] = 250,
		[228574] = 471,
		[181278] = 435,
		[221548] = 166,
		[180682] = 107,
		[209] = 209,
		[202741] = 237,
		[528] = 528,
		[165658] = 217,
		[228575] = 470,
		[512] = 512,
		[221549] = 163,
		[209349] = 466,
		[203078] = 607,
		[535] = 535,
		[202736] = 233,
		[533] = 533,
		[228576] = 469,
		[524] = 524,
		[306] = 306,
		[209350] = 465,
		[210] = 210,
		[237406] = 470,
		[610] = 610,
		[268466] = 617,
		[502] = 502,
		[551] = 551,
		[176583] = 425,
		[209351] = 464,
		[191019] = 443,
		[115] = 115,
		[549] = 549,
		[216761] = 136,
		[537] = 537,
		[189973] = 446,
		[176584] = 426,
		[529] = 529,
		[272782] = 484,
		[252404] = 478,
		[273052] = 482,
		[212163] = 158,
		[305] = 305,
		[190176] = 453,
		[202737] = 238,
		[181248] = 201,
		[507] = 507,
		[176589] = 431,
		[545] = 545,
		[546] = 546,
		[236756] = 170,
		[544] = 544,
		[176586] = 427,
		[181249] = 202,
		[307] = 307,
		[2866] = 417,
		[304] = 304,
		[216764] = 108,
		[247999] = 478,
		[538] = 538,
		[176587] = 455,
		[209355] = 463,
		[202776] = 154,
		[514] = 514,
		[232542] = 251,
		[233117] = 474,
		[248000] = 478,
		[547] = 547,
		[176588] = 429,
		[531] = 531,
		[202777] = 153,
		[252408] = 552,
		[232543] = 252,
		[123330] = 508,
		[248001] = 478,
		[534] = 534,
		[237398] = 474,
		[548] = 548,
		[202778] = 149,
		[202751] = 460,
		[232544] = 249,
		[209328] = 242,
		[248002] = 478,
		[181068] = 226,
		[182] = 182,
		[202779] = 151,
		[269887] = 483,
		[212169] = 159,
		[153468] = 509,
		[207187] = 606,
		[237400] = 469,
		[180683] = 105,
		[202780] = 152,
		[179486] = 515,
		[301] = 301,
		[209353] = 467,
		[248004] = 478,
		[207188] = 605,
		[237396] = 473,
		[183] = 183,
		[192050] = 126,
		[206085] = 452,
		[302] = 302,
		[212171] = 161,
		[248005] = 478,
		[207189] = 608,
		[237402] = 472,
		[202738] = 236,
		[192051] = 121,
		[182956] = 117,
		[303] = 303,
		[212172] = 162,
		[248006] = 478,
		[207190] = 609,
		[202655] = 602,
		[184] = 184,
		[192052] = 128,
		[243334] = 475,
		[245324] = 254,
		[181570] = 223,
		[248007] = 478,
		[182957] = 112,
		[237404] = 471,
		[269278] = 482,
		[192053] = 122,
		[181569] = 223,
		[245325] = 257,
		[212174] = 164,
		[248008] = 478,
		[214510] = 468,
		[180684] = 106,
		[185] = 185,
		[192054] = 129,
		[1731] = 201,
		[212175] = 168,
		[1732] = 202,
		[237342] = 178,
		[1733] = 204,
		[202739] = 239,
		[1734] = 205,
		[235391] = 469,
		[1735] = 203,
		[228563] = 251,
		[248010] = 478,
		[125] = 125,
		[278476] = 621,
		[186] = 186,
		[228564] = 252,
		[192049] = 124,
		[228493] = 249,
		[212177] = 167,
		[248011] = 478,
		[226521] = 615,
		[192048] = 123,
		[180751] = 101,
		[192057] = 131,
		[180662] = 133,
		[204282] = 603,
		[228571] = 474,
		[248012] = 478,
		[501] = 501,
		[260493] = 558,
		[187] = 187,
		[260495] = 556,
		[192046] = 130,
		[268440] = 618,
		[255344] = 258,
		[228573] = 472,
		[218950] = 613,
		[268453] = 618,
		[272778] = 260,
		[192059] = 127,
		[272780] = 261,
		[209354] = 462,
		[206836] = 604,
		[209329] = 246,
		[503] = 503,
		[185877] = 227,
		[248003] = 478,
		[220] = 220,
		[181555] = 221,
		[191133] = 230,
		[123848] = 213,
		[211174] = 612,
		[504] = 504,
		[276616] = 262,
		[190169] = 450,
		[241743] = 256,
		[190170] = 449,
		[235389] = 471,
		[180658] = 109,
		[190171] = 448,
		[189980] = 231,
		[252774] = 554,
		[276618] = 265,
		[276620] = 269,
		[276622] = 268,
		[1610] = 219,
		[180655] = 103,
		[260492] = 557,
		[506] = 506,
		[142141] = 420,
		[184845] = 132,
		[214547] = 156,
		[246804] = 619,
		[232545] = 250,
		[181069] = 225,
		[278149] = 203,
		[248009] = 478,
}

--GatherMate.nodeIDs = node_ids
local GM_Node_Ids = GatherMate.nodeIDs
local missing_Nodes = {}
local id_to_skill = {}  --persist
local GatherMateData = {}
local GatherMateSkilltoDB = {
	["Fishing"] = "FishDB",
	["Mining"] = "MineDB",
	["Herb Gathering"] = "HerbDB",
	["Treasure"] = "TreasureDB",
	["Archaeology"] = "ArchaeologyDB",
	["Extract Gas"] = "GasDB",
	["Logging"] = "LoggingDB",
}


for skill, data in pairs(GM_Node_Ids) do
	for nodeName, gathermate_id in pairs(data) do
		id_to_skill[gathermate_id] = skill
	end

	for id, data in pairs(CustomNodesList) do
		local nodeID = data.NodeID
		local nodeName = data.Name
		id_to_skill[nodeID] = data.Type
		NodeID_to_GathermateID[nodeID] = nodeID
	end
end

--- Parses node data into the format required by Gathermate to be imported
function WoWGatheringNodes:parseGathermateData()
	foo = missing_Nodes
	local ProcessedData = {} --GatherMateData
	ProcessedData.HerbDB = {}
	ProcessedData.MineDB = {}
	ProcessedData.FishDB = {}
	ProcessedData.TreasureDB = {}
	ProcessedData.ArchaeologyDB = {}
	ProcessedData.GasDB = {}
	ProcessedData.LoggingDB = {}

	for MapID, Data in pairs( WoWGatheringNodes.Data ) do
		for NodeID, Data in pairs( Data ) do
			--Only deal with data that Gathermate has id's for
			if NodeID_to_GathermateID[NodeID] then
			 	local NodeID = NodeID_to_GathermateID[NodeID]
			 	--Determines which sill Gathermate classifies the node
			 	if id_to_skill[NodeID] then
				 	local placement = GatherMateSkilltoDB[id_to_skill[NodeID]]
				 	--if not placement then print(type(NodeID))end
				 	--Converts the data into a Gathermate's format
					for _, Coords in ipairs( Data) do
						local x ,y = WoWGatheringNodes:DecodeLoc(Coords)
						local coords = floor( x * 100 + 0.5 ) *1000000 + floor( y * 100 + 0.5 ) *100
						ProcessedData[placement] = ProcessedData[placement] or {}
						ProcessedData[placement][MapID] = ProcessedData[placement][MapID] or {}
						ProcessedData[placement][MapID][coords] = NodeID
					end
				end
			end
		end
	end

	return ProcessedData
end


---Determines the db and settings to use when merging daga
--pram: dbs  database to use
--pram: syle  "Merge" will combine new data with current data,  any other value will overwrite
--pram:  zoneFilter  determines if only sdata from pecific zones are to be used
function WoWGatheringNodes:PerformMerge(dbs ,style, zoneFilter)
	GatherMateData = WoWGatheringNodes:parseGathermateData()
	local filter = nil
	if zoneFilter and type(zoneFilter) == "string" then
		if zoneFilter == "TBC" then
			filter = bcZones
		elseif zoneFilter == "WRATH" then
			filter = wrathZones
		elseif zoneFilter == "CATACLYSM" then
			filter = cataZones
		elseif zoneFilter == "MISTS" then
			filter = mistsZones
		elseif zoneFilter == "WOD" then
			filter = wodZones
		elseif zoneFilter == "LEGION" then
			filter = legionZones
		elseif zoneFilter == "BFA" then
			filter = bfaZones
		end
	end

	if dbs["Mines"]    then self:MergeData(style ~= "Merge",filter,"Mining","MineDB" ) end
	if dbs["Herbs"]    then self:MergeData(style ~= "Merge",filter, "Herb Gathering","HerbDB") end
	if dbs["Fish"]     then self:MergeData(style ~= "Merge",filter, "Fishing", "FishDB") end
	if dbs["Treasure"] then self:MergeData(style ~= "Merge",filter, "Treasure", "TreasureDB") end
	if dbs["Archaeology"] then self:MergeData(style ~= "Merge",filter, "Archaeology", "ArchaeologyDB") end
	if dbs["Gases"] then self:MergeData(style ~= "Merge",filter, "Extract Gas", "GasDB") end
	if dbs["Logging"] then self:MergeData(style ~= "Merge",filter, "Logging", "LoggingDB") end

	self:CleanupGathermateImportData()
	GatherMate:SendMessage("WoWGatheringNodesData2Import")
	self.db.profile.GathermateImport = WoWGatheringNodes.generatedVersion
end


---Determines the db and settings to use when merging daga
--pram:
--pram:
--pram:
function WoWGatheringNodes:MergeData(clear,zoneFilter,nodeType, DBName)
	if clear then GatherMate:ClearDB(nodeType) end
	for zoneID, node_table in pairs(GatherMateData[DBName]) do
		if zoneFilter and zoneFilter[zoneID] or not zoneFilter then
			for coord, nodeID in pairs(node_table) do
				GatherMate:InjectNode2(zoneID,coord,nodeType, nodeID)
			end
		end
	end
end


function WoWGatheringNodes:CleanupGathermateImportData()
	GatherMateData = nil
end