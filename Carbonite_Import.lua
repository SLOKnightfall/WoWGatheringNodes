--///////////////////////////////////////////////////////////////////////////////////////////
-- Handler code for the Carbonite import process
--///////////////////////////////////////////////////////////////////////////////////////////
if not IsAddOnLoaded("Carbonite") then return end

local GatherMate = LibStub("AceAddon-3.0"):GetAddon("Carbonite")
local WoWGatheringNodes = LibStub("AceAddon-3.0"):GetAddon("WoWGatheringNodes")
local L = LibStub("AceLocale-3.0"):GetLocale("Carbonite")

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
							func = function()
								WoWGatheringNodes:GatherImportCarb("NXHerb")
							end,
						},
						CmdImportMine = {
							order = 9,
							type = "execute",
							width = "full",
							name = "Import Mines From WowGatheringNodes",
							func = function()
								WoWGatheringNodes:GatherImportCarb("NXMine")
							end,
						},
						CmdImportMisc = {
							order = 10,
							type = "execute",
							width = "full",
							name = "Import Misc From WowGatheringNodes",
							func = function()
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
	{ 1,	"inv_ore_monalite",WoWGatheringNodes.NodeIdNames[276616]},
	{ 1,	"inv_ore_monalite",WoWGatheringNodes.NodeIdNames[276621]},
	{ 1,	"inv_ore_monalite",WoWGatheringNodes.NodeIdNames[276619]},
	{ 1,	"inv_ore_platinum",WoWGatheringNodes.NodeIdNames[276618]},
	{ 1,	"inv_ore_platinum",WoWGatheringNodes.NodeIdNames[276623]},
	{ 1,	"inv_ore_stormsilver",WoWGatheringNodes.NodeIdNames[276617]},
	{ 1,	"inv_ore_stormsilver",WoWGatheringNodes.NodeIdNames[276622]},
	{ 1,	"inv_ore_stormsilver",WoWGatheringNodes.NodeIdNames[276620]},
	{ 1,	"inv_ore_osmenite",WoWGatheringNodes.NodeIdNames[325875]},
	{ 1,	"inv_ore_osmenite",WoWGatheringNodes.NodeIdNames[325873]},
	{ 1,	"inv_ore_osmenite",WoWGatheringNodes.NodeIdNames[325874]},
}

local H = {
	{ 1,	"inv_misc_herb_akundasbite",WoWGatheringNodes.NodeIdNames[276237]},
	{ 1,	"inv_misc_herb_anchorweed",WoWGatheringNodes.NodeIdNames[276242]},
	{ 1,	"inv_misc_herb_riverbud",WoWGatheringNodes.NodeIdNames[276234]},
	{ 1,	"inv_misc_herb_seastalk",WoWGatheringNodes.NodeIdNames[276240]},
	{ 1,	"inv_misc_herb_pollen",WoWGatheringNodes.NodeIdNames[281869]},
	{ 1,	"inv_misc_herb_starmoss",WoWGatheringNodes.NodeIdNames[281868]},
	{ 1,	"inv_misc_herb_winterskiss",WoWGatheringNodes.NodeIdNames[276238]},
	{ 1,	"inv_misc_herb_zoanthid",WoWGatheringNodes.NodeIdNames[326598]},
}

--Map for nodeID to CarboniteID
local ID_to_CarboniteID = {
		[209349] = 58,
		[202751] = 55,
		[181108] = 21,
		[237400] = 68,
		[202752] = 54,
		[228571] = 64,
		[176583] = 16,
		[175404] = 16,
		[181556] = 1,
		[228572] = 69,
		[176584] = 8,
		[241641] = 75,
		[181270] = 12,
		[237402] = 65,
		[228573] = 65,
		[1617] = 34,
		[272778] = 51,
		[209353] = 59,
		[1618] = 30,
		[228574] = 66,
		[176586] = 26,
		[1619] = 10,
		[272780] = 52,
		[237404] = 66,
		[1620] = 24,
		[228575] = 67,
		[176587] = 31,
		[1621] = 6,
		[272782] = 77,
		[209355] = 56,
		[1622] = 7,
		[243334] = 70,
		[228576] = 68,
		[176588] = 20,
		[1623] = 38,
		[237406] = 67,
		[1624] = 22,
		[253280] = 48,
		[176589] = 3,
		[181275] = 33,
		[190169] = 45,
		[181276] = 14,
		[241743] = 44,
		[1628] = 18,
		[2866] = 13,
		[165658] = 4,
		[190170] = 42,
		[181277] = 37,
		[189979] = 23,
		[276616] = 53,
		[281079] = 82,
		[190171] = 46,
		[276617] = 58,
		[189980] = 24,
		[276618] = 56,
		[276236] = 82,
		[190172] = 47,
		[181279] = 27,
		[189981] = 25,
		[276237] = 78,
		[276620] = 60,
		[276238] = 83,
		[190173] = 44,
		[244775] = 72,
		[276622] = 59,
		[276240] = 81,
		[221539] = 34,
		[244776] = 72,
		[276242] = 79,
		[221540] = 38,
		[244777] = 74,
		[181569] = 15,
		[142140] = 32,
		[221541] = 37,
		[244778] = 76,
		[181570] = 15,
		[243312] = 43,
		[142141] = 2,
		[191133] = 26,
		[221542] = 58,
		[181248] = 3,
		[202736] = 27,
		[243313] = 42,
		[230428] = 40,
		[142142] = 36,
		[247999] = 73,
		[276623] = 57,
		[221543] = 59,
		[241726] = 47,
		[202737] = 31,
		[243314] = 41,
		[181281] = 25,
		[142143] = 4,
		[248000] = 73,
		[185557] = 2,
		[221544] = 61,
		[190175] = 44,
		[202738] = 29,
		[206085] = 44,
		[202750] = 53,
		[142144] = 15,
		[248001] = 73,
		[244774] = 71,
		[221545] = 57,
		[185877] = 14,
		[202739] = 28,
		[1735] = 9,
		[221538] = 33,
		[142145] = 19,
		[248002] = 73,
		[232542] = 42,
		[276234] = 80,
		[232543] = 43,
		[202740] = 32,
		[233117] = 64,
		[2653] = 12,
		[181557] = 10,
		[248003] = 73,
		[191019] = 43,
		[237357] = 39,
		[232544] = 41,
		[202741] = 30,
		[281867] = 82,
		[209354] = 57,
		[228493] = 41,
		[248004] = 73,
		[281868] = 82,
		[237358] = 41,
		[232545] = 39,
		[202749] = 50,
		[252404] = 73,
		[221547] = 56,
		[190176] = 48,
		[248005] = 73,
		[281870] = 80,
		[237359] = 42,
		[244786] = 73,
		[181068] = 18,
		[189978] = 22,
		[202748] = 52,
		[2041] = 23,
		[248006] = 73,
		[281872] = 81,
		[237360] = 43,
		[2042] = 11,
		[181069] = 11,
		[276621] = 54,
		[228563] = 42,
		[2043] = 21,
		[248007] = 73,
		[235376] = 64,
		[209311] = 33,
		[2044] = 39,
		[185881] = 28,
		[2045] = 35,
		[228564] = 43,
		[181166] = 5,
		[248008] = 73,
		[243315] = 39,
		[209312] = 35,
		[2046] = 17,
		[181278] = 1,
		[191303] = 49,
		[189973] = 41,
		[2047] = 21,
		[248009] = 73,
		[202747] = 51,
		[209313] = 37,
		[181271] = 9,
		[235387] = 69,
		[181280] = 29,
		[228510] = 39,
		[235391] = 68,
		[248010] = 73,
		[181249] = 20,
		[1731] = 3,
		[237396] = 69,
		[235388] = 65,
		[214510] = 60,
		[1732] = 20,
		[2040] = 13,
		[248011] = 73,
		[1610] = 7,
		[1733] = 17,
		[209351] = 62,
		[235389] = 66,
		[276619] = 55,
		[1734] = 6,
		[324] = 19,
		[248012] = 73,
		[209350] = 61,
		[272768] = 50,
		[237398] = 64,
		[235390] = 67,
		[294125] = 79,
		[255344] = 45,
		[209328] = 34,
		[209329] = 36,
		[209330] = 38,
		[181555] = 5,
	}


--Adds new nodes to carbonite
local function injectCarboniteNodes()
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

	--Fix for missing mageroyal icon
	Nx.GatherInfo["H"][24][2] = "Inv_jewelry_talisman_03"
end

injectCarboniteNodes()

function WoWGatheringNodes:GatherImportCarb(nodeType)
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
	local count = 0
		for mapId, zoneT in pairs (srcT) do
			for coords, nodeId in pairs(zoneT) do
			count = count+ 1
				local nx, ny = Nx:GatherConvert(coords)
				local name = WoWGatheringNodes.NodeIdNames[nodeId]
				--print(name)
				local convId = nil
				if ntp == "M"  and name then
					convId = ID_to_CarboniteID[nodeId]
				end
				if ntp == "H"  and name then
					convId = ID_to_CarboniteID[nodeId]
				end
				--if nodeId == 175404 then print("RTT") end
				if nx and ny and convId then
					Nx:Gather (nodeType, convId, mapId, nx * 100, ny * 100)
					cnt = cnt + 1
				else 
				--print(name)
				end
			end
		end

		Nx.prt ("Imported" .. " %s " .. "nodes from WowGatheringNodes", cnt, nodeType)
		self.db.profile.CarboniteImport = WoWGatheringNodes.generatedVersion
	end
end

parseData()

--@do-not-package@ 
--Builds a list of nodeIDs with the matching CarboniteID's
function GenerateIDs()
	WoWGatheringNodesConfig.carb = {}
	local carbid = {}
	local gmid = {}

	for index, data in ipairs(Nx.GatherInfo["H"]) do

		local name = data[3]
		local id = data[1]
		--print(name)
		carbid[name] = index


	end

	for index, data in ipairs(Nx.GatherInfo["M"]) do

		local name = data[3]
		local id = data[1]
		--print(index)
		carbid[name] = index


	end

	for id, name in pairs(WoWGatheringNodes.NodeIdNames) do
		if carbid[name] then 
			gmid[id] = carbid[name]
		else 
		--print(name)

		end

	end
WoWGatheringNodesConfig.carb = gmid


end
 --@end-do-not-package@