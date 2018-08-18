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

local ID_to_CarboniteID = {
		[209349] = 58,
		[1610] = 7,
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
		[181557] = 10,
		[228573] = 65,
		[1617] = 34,
		[272778] = 51,
		[189973] = 41,
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
		[123310] = 13,
		[253280] = 48,
		[176589] = 3,
		[181275] = 33,
		[190169] = 45,
		[181276] = 14,
		[241743] = 44,
		[1628] = 18,
		[2866] = 13,
		[177388] = 16,
		[190170] = 42,
		[181277] = 37,
		[189979] = 23,
		[276616] = 53,
		[276234] = 80,
		[190171] = 46,
		[181278] = 1,
		[189980] = 24,
		[276618] = 56,
		[190172] = 47,
		[181279] = 27,
		[189981] = 25,
		[276237] = 78,
		[276620] = 60,
		[276238] = 83,
		[221538] = 33,
		[181280] = 29,
		[276622] = 59,
		[221539] = 34,
		[181281] = 25,
		[190175] = 44,
		[244777] = 74,
		[181569] = 15,
		[228510] = 39,
		[142140] = 32,
		[230428] = 40,
		[276623] = 57,
		[221541] = 37,
		[244778] = 76,
		[181570] = 15,
		[243312] = 43,
		[142141] = 2,
		[191133] = 26,
		[209328] = 34,
		[221542] = 58,
		[235376] = 64,
		[243313] = 42,
		[142142] = 36,
		[247999] = 73,
		[1735] = 9,
		[221543] = 59,
		[202751] = 55,
		[202737] = 31,
		[243314] = 41,
		[209329] = 36,
		[142143] = 4,
		[248000] = 73,
		[185557] = 2,
		[221544] = 61,
		[276621] = 54,
		[228493] = 41,
		[243315] = 39,
		[255344] = 45,
		[142144] = 15,
		[248001] = 73,
		[209350] = 61,
		[2653] = 12,
		[232542] = 42,
		[202739] = 28,
		[241726] = 47,
		[181271] = 9,
		[142145] = 19,
		[248002] = 73,
		[209351] = 62,
		[206085] = 44,
		[232543] = 43,
		[202740] = 32,
		[233117] = 64,
		[202736] = 27,
		[237402] = 65,
		[248003] = 73,
		[181555] = 5,
		[237357] = 39,
		[232544] = 41,
		[202741] = 30,
		[235388] = 65,
		[181166] = 5,
		[209353] = 59,
		[248004] = 73,
		[281868] = 82,
		[237358] = 41,
		[232545] = 39,
		[202738] = 29,
		[209354] = 57,
		[123309] = 21,
		[202747] = 51,
		[248005] = 73,
		[1624] = 22,
		[237359] = 42,
		[2040] = 13,
		[181068] = 18,
		[189978] = 22,
		[165658] = 4,
		[2041] = 23,
		[248006] = 73,
		[281872] = 81,
		[237360] = 43,
		[2042] = 11,
		[181069] = 11,
		[276617] = 58,
		[228563] = 42,
		[2043] = 21,
		[248007] = 73,
		[276619] = 55,
		[209311] = 33,
		[2044] = 39,
		[278149] = 9,
		[185877] = 14,
		[228564] = 43,
		[2045] = 35,
		[248008] = 73,
		[252404] = 73,
		[209312] = 35,
		[2046] = 17,
		[190173] = 44,
		[191303] = 49,
		[209330] = 38,
		[2047] = 21,
		[248009] = 73,
		[235391] = 68,
		[209313] = 37,
		[181249] = 20,
		[235387] = 69,
		[244776] = 72,
		[221540] = 38,
		[190176] = 48,
		[248010] = 73,
		[221545] = 57,
		[1731] = 3,
		[237396] = 69,
		[202748] = 52,
		[214510] = 60,
		[1732] = 20,
		[191019] = 43,
		[248011] = 73,
		[221547] = 56,
		[1733] = 17,
		[235390] = 67,
		[202749] = 50,
		[235389] = 66,
		[1734] = 6,
		[324] = 19,
		[248012] = 73,
		[185881] = 28,
		[272768] = 50,
		[237398] = 64,
		[202750] = 53,
		[294125] = 79,
		[123848] = 19,
		[244774] = 71,
		[244775] = 72,
		[244786] = 73,
		[181248] = 3,
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
					convId = ID_to_CarboniteID[nodeId]
				end
				if ntp == "H"  and name then
					convId = ID_to_CarboniteID[nodeId]
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