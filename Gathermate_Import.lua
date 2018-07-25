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


--GatherMate.nodeIDs = node_ids
local GM_Node_Ids = GatherMate.nodeIDs
local missing_Nodes = {}

--Builds tables so help convert to Gathermate id
id_to_skill = {}  --persist
NodeID_to_GathermateID = {}  --persist
local NodeName_to_GathermateID = {}
local NodeIdNames = WoWGatheringNodes.NodeIdNames

for skill, data in pairs(GM_Node_Ids) do
	for nodeName, gathermate_id in pairs(data) do
		id_to_skill[gathermate_id] = skill
		NodeName_to_GathermateID[nodeName] = gathermate_id
	end

	for id, data in pairs(CustomNodesList) do
		local nodeID = data.NodeID
		local nodeName = data.Name
		id_to_skill[nodeID] = data.Type
		NodeName_to_GathermateID[nodeName] = nodeID
	end
end
local reverseNaeme = {}

local NamestoID = {}

--creats a way to find what gathermate used for a node's id
for nodeID, nodeName in pairs(NodeIdNames) do
	NamestoID[nodeName] = nodeID
	local GatherMateID = NodeName_to_GathermateID[nodeName] or NodeName_to_GathermateID[nodeName.." Pool"]
	if GatherMateID then
		
		NodeID_to_GathermateID[nodeID] = NodeName_to_GathermateID[nodeName]
	else
		--print(nodeName.." not found")
		--tinsert(missing_Nodes,nodeName)

	end
end


for nodeName, nodeID  in pairs(NodeName_to_GathermateID) do
	if not NamestoID[nodeName] then
	--print(nodeName.." "..nodeID.." not found")
	WoWGatheringNodes.NodeIdNames[nodeID] = nodeName
	NamestoID[nodeName] = nodeID
	NodeID_to_GathermateID[nodeID] = nodeID
	--tinsert(missing_Nodes,nodeID)
	end
end



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


--- Parses node data into the format required by Gathermate to be imported
local function parseGathermateData()
	foo = missing_Nodes
	local ProcessedData = GatherMateData
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
end


---Determines the db and settings to use when merging daga
--pram: dbs  database to use
--pram: syle  "Merge" will combine new data with current data,  any other value will overwrite
--pram:  zoneFilter  determines if only sdata from pecific zones are to be used
function WoWGatheringNodes:PerformMerge(dbs ,style, zoneFilter)
	parseGathermateData()
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
		end
	end
	if dbs["Mines"]    then self:MergeData(style ~= "Merge",filter,"Mining","MineDB" ) end
	if dbs["Herbs"]    then self:MergeData(style ~= "Merge",filter, "Herb Gathering","HerbDB") end
	if dbs["Fish"]     then self:MergeData(style ~= "Merge",filter, "Fishing", "FishDB") end
	if dbs["Treasure"] then self:MergeData(style ~= "Merge",filter, "Treasure", "TreasureDB") end
	if dbs["Archaeology"] then self:MergeData(style ~= "Merge",filter, "Archaeology", "ArchaeologyDB") end
	if dbs["Gases"] then self:MergeData(style ~= "Merge",filter, "Extract Gas", "GasDB") end
	if dbs["Logging"] then self:MergeData(style ~= "Merge",filter, "Logging", "LoggingDB") end


	self:CleanupImportData()
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


function WoWGatheringNodes:CleanupImportData()
	GatherMateData = nil
end