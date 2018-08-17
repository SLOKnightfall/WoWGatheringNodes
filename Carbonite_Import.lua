--///////////////////////////////////////////////////////////////////////////////////////////
-- Handler code for the Carbonite import process
--///////////////////////////////////////////////////////////////////////////////////////////
if not IsAddOnLoaded("Carbonite") then return end

local GatherMate = LibStub("AceAddon-3.0"):GetAddon("Carbonite")
local WoWGatheringNodes = LibStub("AceAddon-3.0"):GetAddon("WoWGatheringNodes")
local L = LibStub("AceLocale-3.0"):GetLocale("Carbonite")
local imp = {}
local guidegather
local function guidegatherConfig ()
	if not guidegather then
		guidegather = {
			type = "group",
			name = "Import WoWGatheringNode Data",
			childGroups	= "tab",
			args = {
				gatherOpts = {
					order = 2,
					type = "group",
					name = "Import",
					args = {
						spacer2 = {
							order = 7,
							type = "description",
							name = "\n",
						},
						CmdImportHerb = {
							order = 8,
							type = "execute",
							width = "full",
							name = "Import Herbs From WowGatheringNodes",
							func = function ()
								imp:GatherImportCarb ("NXHerb")
							end,
						},
						CmdImportMine = {
							order = 9,
							type = "execute",
							width = "full",
							name = "Import Mines From WowGatheringNodes",
							func = function ()
								imp:GatherImportCarb ("NXMine")
							end,
						},
						CmdImportMisc = {
							order = 10,
							type = "execute",
							width = "full",
							name = "Import Misc From WowGatheringNodes",
							func = function ()
								Nx.Opts:NXCmdImportCarbMisc()
							end,
							hidden = true,
						},
					},
				},

			},
		}
	end
	return guidegather
end

Nx:AddToConfig("WoWGatheringNodes Import", guidegatherConfig(),"WoWGatheringNodes Import")

local GatherMateData = {}
local GatherMateSkilltoDB = {
	["mining-nodes"] = "MineDB",
	["herb-objects"] = "HerbDB",
}
local ProcessedData = {}
local NodeID_to_GathermateID = {} 
--- Parses node data into the format required by Gathermate to be imported
local function parseData()
	foo = missing_Nodes
	ProcessedData = GatherMateData
	ProcessedData.HerbDB = {}
	ProcessedData.MineDB = {}
	ProcessedData.FishDB = {}
	ProcessedData.TreasureDB = {}
	ProcessedData.ArchaeologyDB = {}
	ProcessedData.GasDB = {}
	ProcessedData.LoggingDB = {}

	for MapID, Data in pairs( WoWGatheringNodes.Data ) do
		for NodeID, Data in pairs( Data ) do
			if WoWGatheringNodes.ID_to_Catagories[NodeID] then
				local placement = GatherMateSkilltoDB[WoWGatheringNodes.ID_to_Catagories[NodeID]] or "MiscDB"
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

--Adds nodes not currently in Carbonite
local M={
	{ 1,	"inv_ore_monalite","Monelite Deposit"},
	{ 1,	"inv_ore_monalite","Rich Monelite Deposit"},
	{ 1,	"inv_ore_monalite","Monelite Seam"},
	{ 1,	"inv_ore_platinum","Platinum Deposit"},
	{ 1,	"inv_ore_platinum","Rich Platinum Deposit"},
	{ 1,	"inv_ore_stormsilver","Storm Silver Deposit"},
	{ 1,	"inv_ore_stormsilver","Rich Storm Silver Deposit"},
	{ 1,	"inv_ore_stormsilver","Storm Silver Seam"},
}

local H = {
	{ 1,	"inv_misc_herb_akundasbite","Akunda's Bite"},
	{ 1,	"inv_misc_herb_anchorweed","Anchor Weed"},
	{ 1,	"inv_misc_herb_riverbud","Riverbud"},
	{ 1,	"inv_misc_herb_seastalk","Sea Stalks"},
	--{ 700,	"inv_ore_platinum","Siren's Sting"},
	{ 1,	"inv_misc_herb_starmoss","Star Moss"},
	{ 1,	"inv_misc_herb_winterskiss","Winter's Kiss"},
}

--Adds new nodes to carbonite
function injectnode()
	for _,data in ipairs(M) do	
		local name = data[3]
			if not Nx:MineNameToId (name) then
			tinsert(Nx.GatherInfo["M"],data) 
			Nx.db.profile.Guide.ShowMines[Nx:MineNameToId (name)] = true
		end
	end

	for _,data in ipairs(H) do
		local name = data[3]
			if not Nx:HerbNameToId (name) then
			tinsert(Nx.GatherInfo["H"],data) 
			Nx.db.profile.Guide.ShowHerbs[Nx:HerbNameToId (name)] = true
		end
	end

end

injectnode()


function imp:GatherImportCarb (nodeType)
	if nodeType == "NXMine" then
		if not ProcessedData.MineDB then
			Nx.prt ("WowGatheringNodes Not Loaded!")
			return
		end
	end

	if nodeType == "NXHerb" then
		if not ProcessedData.HerbDB then
			Nx.prt ("WowGatheringNodes Not Loaded!")
			return
		end
	end

	local srcT = nil
	local ntp = nil
	local car_id = nil

	if nodeType == "NXMine" then
		srcT = ProcessedData.MineDB
		ntp = "M"
	elseif nodeType == "NXHerb" then
		srcT =  ProcessedData.HerbDB
		ntp = "H"
	end

	local cnt = 0
	if srcT then
		for mapId, zoneT in pairs (srcT) do
			for coords, nodeId in pairs(zoneT) do
				local nx, ny = Nx:GatherConvert(coords)
				local name = WoWGatheringNodes.NodeIdNames[nodeId]
				local convId = nil
				if ntp == "M"  and name then
					convId = Nx:MineNameToId(name) or 99999
				end
				if ntp == "H"  and name then
					convId = Nx:HerbNameToId(name) or 99999
				end
				
				if nx and ny and convId then
					Nx:Gather (nodeType, convId, mapId, nx * 100, ny * 100)
					cnt = cnt + 1
				end
			end
		end

		Nx.prt ("Imported" .. " %s " .. "nodes from WowGatheringNodes", cnt, nodeType)
	end
end

parseData()