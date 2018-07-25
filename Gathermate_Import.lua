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
	[464] = true,
	[476] = true,
	[471] = true,
	[462] = true,
	[463] = true,
	[499] = true,
	[480] = true,
	[475] = true,
	[465] = true,
	[477] = true,
	[479] = true,
	[473] = true,
	[481] = true,
	[478] = true,
	[467] = true,
}

local wrathZones = {
	[486] = true,
	[510] = true,
	[504] = true,
	[488] = true,
	[490] = true,
	[491] = true,
	[541] = true,
	[492] = true,
	[493] = true,
	[495] = true,
	[501] = true,
	[496] = true,
}

local cataZones = {
	[606] = true,
	[684] = true,
	[685] = true,
	[615] = true,
	[708] = true,
	[709] = true,
	[700] = true,
	[613] = true,
	[614] = true,
	[640] = true,
	[605] = true,
	[544] = true,
	[737] = true,
}

local mistsZones = {
	[806] = true,
	[807] = true,
	[808] = true,
	[809] = true,
	[810] = true,
	[811] = true,
	[857] = true,
	[858] = true,
	[873] = true,
	[903] = true,
	[905] = true,
}

local wodZones = {
	[962] = true,
	[978] = true,
	[941] = true,
	[976] = true,
	[971] = true,
	[950] = true,
	[947] = true,
	[948] = true,
	[1009] = true,
	[946] = true,
	[945] = true,
	[907] = true,
	[1011] = true,
}

local legionZones = {
	[1014] = true,
	[1015] = true,
	[1017] = true,
	[1018] = true,
	[1021] = true,
	[1024] = true,
	[1033] = true,
	[1096] = true,
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