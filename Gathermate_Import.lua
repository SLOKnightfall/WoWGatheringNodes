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

NodeID_to_GathermateID = {
		[2047] = 208,
		[3729] = 405,
		[181109] = 205,
		[103711] = 202,
		[1619] = 403,
		[1667] = 219,
		[123309] = 211,
		[3763] = 201,
		[1731] = 201,
		[1620] = 404,
		[176586] = 427,
		[2653] = 218,
		[103712] = 203,
		[1621] = 405,
		[176587] = 428,
		[123310] = 207,
		[1733] = 204,
		[1622] = 408,
		[176588] = 429,
		[2054] = 202,
		[176636] = 421,
		[1734] = 205,
		[1623] = 409,
		[176589] = 431,
		[176637] = 424,
		[142141] = 420,
		[1624] = 411,
		[150079] = 206,
		[176638] = 425,
		[103714] = 201,
		[150080] = 205,
		[176639] = 426,
		[1610] = 219,
		[73941] = 210,
		[150081] = 208,
		[176640] = 427,
		[142144] = 423,
		[2040] = 206,
		[150082] = 214,
		[176641] = 428,
		[142145] = 424,
		[1628] = 410,
		[2041] = 412,
		[177388] = 212,
		[176642] = 420,
		[175404] = 215,
		[324] = 214,
		[176643] = 214,
		[181069] = 225,
		[165658] = 217,
		[181068] = 226,
		[2043] = 415,
		[1618] = 401,
		[176644] = 215,
		[3764] = 202,
		[103709] = 202,
		[1732] = 202,
		[2055] = 201,
		[73940] = 209,
		[2044] = 416,
		[142143] = 422,
		[2866] = 417,
		[2042] = 413,
		[3730] = 408,
		[3724] = 401,
		[1617] = 402,
		[1735] = 203,
		[2045] = 407,
		[3725] = 402,
		[176645] = 206,
		[105569] = 204,
		[103710] = 203,
		[3726] = 403,
		[176583] = 425,
		[19903] = 220,
		[2046] = 414,
		[3727] = 404,
		[103713] = 201,
		[181108] = 208,
		[142140] = 418,
		[123848] = 213,
		[176584] = 426,
		[142142] = 421,
	}
--- Parses node data into the format required by Gathermate to be imported
function WoWGatheringNodes:parseGathermateData()
	--local NodeID_to_GathermateID = GenerateGathermateIDs()
	local GM_Node_Ids = GatherMate.nodeIDs
	local id_to_skill = {}
	local WoWGatheringNodesData = WoWGatheringNodes.Data

	local ProcessedData = {
		["HerbDB"] = {},
		["MineDB"] = {},
		["FishDB"] = {},
		["TreasureDB"] = {},
		["ArchaeologyDB"] = {},
		["GasDB"] = {},
		["LoggingDB"] = {},
	}

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

		for id, data in pairs(WoWGatheringNodes.CustomNodesList ) do
			local nodeID = data.NodeID
			local nodeName = data.Name
			id_to_skill[nodeID] = data.Type
			NodeID_to_GathermateID[nodeID] = nodeID
		end
	end

	for MapID, Data in pairs( WoWGatheringNodesData ) do
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
	local GatherMateData = WoWGatheringNodes:parseGathermateData()
	local filter = nil

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
		[1355] = true, -- nazatar
		[1462] = true, --/mechago	
	}

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

	if dbs["Mines"]    then self:MergeData(style ~= "Merge",filter,"Mining",GatherMateData["MineDB"] ) end
	if dbs["Herbs"]    then self:MergeData(style ~= "Merge",filter, "Herb Gathering",GatherMateData["HerbDB"]) end
	if dbs["Fish"]     then self:MergeData(style ~= "Merge",filter, "Fishing", GatherMateData["FishDB"]) end
	if dbs["Treasure"] then self:MergeData(style ~= "Merge",filter, "Treasure", GatherMateData["TreasureDB"]) end
	if dbs["Archaeology"] then self:MergeData(style ~= "Merge",filter, "Archaeology", GatherMateData["ArchaeologyDB"]) end
	if dbs["Gases"] then self:MergeData(style ~= "Merge",filter, "Extract Gas", GatherMateData["GasDB"]) end
	if dbs["Logging"] then self:MergeData(style ~= "Merge",filter, "Logging", GatherMateData["LoggingDB"]) end

	--self:CleanupGathermateImportData()
	GatherMate:SendMessage("WoWGatheringNodesData2Import")
	self.db.profile.GathermateImport = WoWGatheringNodes.generatedVersion
end


---Determines the db and settings to use when merging daga
--pram:
--pram:
--pram:
function WoWGatheringNodes:MergeData(clear,zoneFilter,nodeType, DBName)
	if clear then GatherMate:ClearDB(nodeType) end
	for zoneID, node_table in pairs(DBName) do
		if zoneFilter and zoneFilter[zoneID] or not zoneFilter then
			for coord, nodeID in pairs(node_table) do
				GatherMate:InjectNode2(zoneID,coord,nodeType, nodeID)
			end
		end
	end
end


function WoWGatheringNodes:CleanupGathermateImportData()
	--GatherMateData = nil
end

function WoWGatheringNodes:DataUpdate_8_2()

	local updated_ids = {
		--"Mechanized Chest",
		[325659] = 560,
		[325660] = 560,
		[325661] = 560,
		[325662] = 560,
		--325663,
		[325664] = 560,
		[325665] = 560,
		[325666] = 560,
		[325667] = 560,
		[325668] = 560,
		--"Glimmering Chest",
		[322413] = 561,
		[327576] = 561,
		[327577] = 561,
		[327578] = 561,

		[326598] = 492, --Zin'anthid 
		--ore
		[325873] = 271,
		[325874] = 272,
		[325875] = 270,
	}

	local DB_List = {
		GatherMate2HerbDB,
		GatherMate2MineDB,
		GatherMate2TreasureDB,
	}


	for _,DB_Type in ipairs(DB_List) do
		for zone, zone_data in pairs(DB_Type) do
			for coords, node_id in pairs(zone_data) do
				if updated_ids[node_id] then
					if type(updated_ids[node_id] ) == "number" then 
						zone_data[coords] = updated_ids[node_id] 
					else
					end
				end
			end
		end
	end

	WoWGatheringNodesConfig["8.2_Update"] = true
end


--@do-not-package@ 
--Builds a list of nodeIDs with the matching CarboniteID's
function GenerateGathermateIDs()
--GatherMate.nodeIDs
WoWGatheringNodesConfig.gm2 = {}
local gm_ids = {}
local matchedId = {}
local missing = {}
	for type, data in pairs(GatherMate.nodeIDs) do
		for name,id in pairs(data) do
			gm_ids[name] = id
		end
	end

	for id, name in pairs(WoWGatheringNodes.NodeIdNames) do
	--if id == 276242 then print("AW") end
		if gm_ids[name] then 
			matchedId[id] = gm_ids[name]
		else 
		print(name)
			--missing[id] = name
		end

	end

WoWGatheringNodesConfig.gm2 = matchedId
end

function MissingGathermateIDs()
--GatherMate.nodeIDs
WoWGatheringNodesConfig.gm2 = {}
local ids = {}
local matchedId = {}
local missing = {}
	for id, name in pairs(WoWGatheringNodes.NodeIdNames) do		
		ids[name] = id

	end

	for type, data in pairs(GatherMate.nodeIDs) do
		for name,id in pairs(data) do
			if not ids[name] then
				missing[id] = name
			end
		end
	end

WoWGatheringNodesConfig.gm2 = missing
end




function MissingGathermateIDs2()
--GatherMate.nodeIDs
WoWGatheringNodesConfig.gm2 = {}
local WoWGatheringNodesData = WoWGatheringNodes:GetData()
local gm_ids = {}
local dump = {}
local missing = {}
	for type, data in pairs(GatherMate.nodeIDs) do
		for name,id in pairs(data) do
			gm_ids[id] = name
		end
	end

	for map, data in pairs(WoWGatheringNodesData) do
		for id,_ in pairs(data) do
			if gm_ids[id]  and not missing[gm_ids[id]] then
				--tinsert(missing,gm_ids[id] )
				missing[gm_ids[id]] = id
			end

		end
	end
	for name, _ in pairs(missing) do
	tinsert(dump, name)
	end

WoWGatheringNodesConfig.gm2 = dump
end


function mech()
local new_zonee = {}
	local DB_List = {
		GatherMate2HerbDB,
		GatherMate2MineDB,
		GatherMate2TreasureDB,
	}

	for _, DB in ipairs(DB_List) do

		local zone_data = DB[1462]
		print(DB)
		for coord, node_id in pairs(zone_data) do
		local new_cord = coord/100
		new_zonee[node_id] = new_zonee[node_id] or {}
		tinsert(node_id,new_cord)
		end

	end
	WoWGatheringNodesConfig.mecha = new_zonee

end
 --@end-do-not-package@