--///////////////////////////////////////////////////////////////////////////////////////////
--                           WoWGatheringNodes                          --
--           https://mods.curse.com/addons/wow/279801-wowgatheringnodes          --
--                                                                               --
--             An Object Database and injector for Gathermate2 and Gatherer       --
--			  All Rights Reserved					  --
--///////////////////////////////////////////////////////////////////////////////////////////

WoWGatheringNodes = LibStub("AceAddon-3.0"):GetAddon("WoWGatheringNodes")
local L = LibStub("AceLocale-3.0"):GetLocale("WoWGatheringNodes", false)
local GatherMate --= LibStub("AceAddon-3.0"):GetAddon("GatherMate2")
local Profile

-------------------------------------------------------------------------------
-- Localized Lua globals.
-------------------------------------------------------------------------------
local _G = getfenv(0)

-- Functions
local pairs = _G.pairs
local ipairs = _G.ipairs


--Default settings for addon
local defaults = {
	profile = {
		GathermateImport = false,
		GathererImport = false,
		CarboniteImport = false,
		InjectNodes = true,
		AutoClear = false,
		AutoImportGathermate = true,
		AutoImportCarboniteHerbs = true,
		AutoImportCarboniteMines = true,
		CustomNodes = {
			['*'] = true,
		},
	}
}

--Ace GUI Options table
local myOptionsTable = {
	name = "WoWGatheringNodes Options",
	type = "group",
	args = {
		clearData = {
			name = L["Clear Data"],
			desc = L["Clears data from memory if version has already been imported."],
			type = "toggle",
			set = function(info,val) WoWGatheringNodes.db.profile.AutoClear = val end,
			get = function(info) return WoWGatheringNodes.db.profile.AutoClear end,
		},
		customNodes = {
			name = L["Enable Custom Objects"],
			desc = L["Injects new objects into Gatherer/Gathermate2 that are not currently in their data files"],
			type = "toggle",
			set = function(info,val) WoWGatheringNodes.db.profile.InjectNodes = val;WoWGatheringNodes:toggleCustomNodes(not val) end,
			get = function(info) return WoWGatheringNodes.db.profile.InjectNodes end,
		},
		autoImport={
			name = L["Auto Import New Data"],
			type = "group",
			width = "full",
			args={
				GathermateHeader = {
					name = "Gathermate",
					type = "header",
					order = 0, 
				},
				GathermateImport = {
					name = L["Auto Import Data to Gathermate"],
					--desc = L["Automaticaly imports data when updated data is found"],
					type = "toggle",
					set = function(info,val) WoWGatheringNodes.db.profile.AutoImportGathermate = val end,
					get = function(info) return WoWGatheringNodes.db.profile.AutoImportGathermate end,
					disabled = function() return not IsAddOnLoaded("Gathermate2") end,
					order = 1,
					width = "full",
				},
				CarboniteHeader = {
					name = "Carbonite",
					type = "header",
					order = 2,
				},	 
				CarboniteMineImport = {
					name = L["Auto Import to Mine Data to Carbonite"],
					--desc = L["Automaticaly imports data when updated data is found"],
					type = "toggle",
					set = function(info,val) WoWGatheringNodes.db.profile.AutoImportCarboniteMines = val end,
					get = function(info) return WoWGatheringNodes.db.profile.AutoImportCarboniteMines end,
					disabled = function() return not IsAddOnLoaded("Carbonite") end,
					order = 3,
					width = "full",
				},
				CarboniteHerbImport = {
					name = L["Auto Import to Herb Data to Carbonite"],
					--desc = L["Automaticaly imports data when updated data is found"],
					type = "toggle",
					set = function(info,val) WoWGatheringNodes.db.profile.AutoImportCarboniteHerbs = val end,
					get = function(info) return WoWGatheringNodes.db.profile.AutoImportCarboniteHerbs end,
					disabled = function() return not IsAddOnLoaded("Carbonite") end,
					order = 4, 
					width = "full",
				},
			},
		},

		customNodeList={
			name = L["Custom Objects"],
			type = "group",
			width = "full",
			args={
			--args will be auto added later from list of custom items
			},
		},
--[[		manualNodeList={
			name = "Manually Added Objects",
			type = "group",
			width = "full",
			args={
				manualNodeListID={
					name = "Object ID",
					type = "input",
					width = "full",
				},
			},
		},]]--
	},
}

--local icon_path = "Interface\\AddOns\\GatherMate2\\Artwork\\"
local icon_path = "Interface\\Worldmap\\TreasureChest_64"
-- Table with hard coded custom object data
WoWGatheringNodes.CustomNodesList = {
	[271227] = {
		["Name"] = WoWGatheringNodes.NodeIdNames[271227], --"Hidden Wyrmtongue Cache",
		["Icon"] = icon_path,--.."Treasure\\footlocker.tga",
		["Type"] = "Treasure",
		["NodeID"] = 271227,
		["IconID"] = 19291,
	},
	--BfA
	[277336] = {
		["Name"] = WoWGatheringNodes.NodeIdNames[277336], --"Treasure Chest",
		["Icon"] = "Interface\\AddOns\\GatherMate2\\Artwork\\Treasure\\treasure.tga",--.."Treasure\\footlocker.tga",
		["Type"] = "Treasure",
		["NodeID"] = 277336,
		["IconID"] = 1125255,
	},
	[290135] = {
		["Name"] = WoWGatheringNodes.NodeIdNames[290135], --"War Supply Chest",
		["Icon"] = icon_path,--.."Treasure\\footlocker.tga",
		["Type"] = "Treasure",
		["NodeID"] = 290135,
		["IconID"] = 19291,
	},
		[273900] = {
		["Name"] = WoWGatheringNodes.NodeIdNames[273900], --"Small Treasure Chest",
		["Icon"] = "Interface\\AddOns\\GatherMate2\\Artwork\\Treasure\\treasure.tga",--.."Treasure\\footlocker.tga",
		["Type"] = "Treasure",
		["NodeID"] = 273900,
		["IconID"] = 1125255,
	},

}

--- Adds custom object to the options menu
--pram: objectData table containing custom object information
function WoWGatheringNodes:addCustomNodesToOptions(objectData)
	myOptionsTable.args.customNodeList.args[objectData.Name] = {
		name = objectData.Name,
		desc = (L["Inject %s into gathering addons"]):format(objectData.Name),
		type = "toggle",	
		width = "full",
		set = function(info,val) Profile.CustomNodes[objectData.Name] = val; WoWGatheringNodes:toggleCustomNodes() end,
		get = function(info) return Profile.CustomNodes[objectData.Name] end,
	}
end


--- Ace Initilizer
function WoWGatheringNodes:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("WoWGatheringNodesConfig", defaults, true)
	WoWGatheringNodes.generatedVersion = GetAddOnMetadata("WoWGatheringNodes", "X-Gatherer-Plugin-DatabaseID")
	--myOptionsTable.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	LibStub("AceConfig-3.0"):RegisterOptionsTable("WoWGatheringNodesConfig", myOptionsTable)
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("WoWGatheringNodesConfig", "WoWGatheringNodes")
	Profile = WoWGatheringNodes.db.profile

	--Adds custom objects to the options table
	for nodeID, objectData in pairs(WoWGatheringNodes.CustomNodesList ) do
		WoWGatheringNodes:addCustomNodesToOptions(objectData)
	end
end


--- Cycles through the custom node list and injects data into Gatherer
function WoWGatheringNodes:OnEnable()
	--Delays registration of the import untill after Gatherer has time to finish loading the plugin data
	if IsAddOnLoaded("Gatherer") then
		hooksecurefunc(Gatherer.Plugins,"LoadPluginData", function()
			Gatherer.Plugins.RegisterDatabaseImport("WoWGatheringNodes", WoWGatheringNodes.PerformGathererImport)
		end)

		if Profile.InjectNodes then
				WoWGatheringNodes:AddCustomGathererNodes()
		end

		if Profile.GathererImport ~= WoWGatheringNodes.generatedVersion and Profile.AutoImport then
		else
		end
	end

	if IsAddOnLoaded("Gathermate2") then
		GatherMate = LibStub("AceAddon-3.0"):GetAddon("GatherMate2")
		if Profile.InjectNodes then
			WoWGatheringNodes:AddCustomGathermateNodes()
			--local filterOptions = LibStub("AceDBOptions-3.0"):GetOptionsTable("GM2/Filter")
			--for x,y in pairs(filterOptions) do
			--print(x)
			--end

		end

		--if datafile matches last import version, no need to import
		if Profile.GathermateImport ~= WoWGatheringNodes.generatedVersion and Profile.AutoImportGathermate then
			WoWGatheringNodes:ImportGathermate()
		--else
		end
	end

	if IsAddOnLoaded("Carbonite") then
		if Profile.CarboniteImport ~= WoWGatheringNodes.generatedVersion  then
		
			if Profile.AutoImportCarboniteHerbs then
				WoWGatheringNodes:GatherImportCarb("NXHerb")
			end
			
			if Profile.AutoImportCarboniteMines then
				WoWGatheringNodes:GatherImportCarb("NXMine")
				
			end
		end
	end

	if ((Profile.GathermateImport == WoWGatheringNodes.generatedVersion
			or Profile.GathererImport == WoWGatheringNodes.generatedVersion)
			and Profile.AutoClear)
		or (not IsAddOnLoaded("Gathermate2") and not IsAddOnLoaded("Gatherer") and not IsAddOnLoaded("Carbonite")) then

		--No gathering addons loaded so there is no need for tables.
		--WoWGatheringNodes.Data = {}
		--WoWGatheringNodes.NodeIdNames = {}
	end
end


--- Decodes coord data from a long block
--pram: id  coord block to decode
--return:  x, y   the x & y values of the coord
function WoWGatheringNodes:DecodeLoc(id)
	return math.floor(id/10000)/100, math.floor(id % 10000)/100
end


--- Toggle function to add/remove custom data
--pram: reset  reset param to be passed to the actual injection functions
function WoWGatheringNodes:toggleCustomNodes(reset)
 	if IsAddOnLoaded("Gathermate2") then
		WoWGatheringNodes:AddCustomGathermateNodes(reset)
	end
	if IsAddOnLoaded("Gatherer") then
		WoWGatheringNodes:AddCustomGathererNodes(reset)
	end
end


--- Cycles through the custom node list and injects data into Gethermate2
--pram: reset  If true, removes the injected data
function WoWGatheringNodes:AddCustomGathermateNodes(reset)
	
	for nodeID, data in pairs(WoWGatheringNodes.CustomNodesList ) do
		local nodeName = WoWGatheringNodes.NodeIdNames[nodeID] --data.Name
		local nodeType = data.Type
		local NL = LibStub("AceLocale-3.0"):GetLocale("GatherMate2Nodes")

		if reset or not Profile.CustomNodes[nodeName] then
			--print("clearing")
			GatherMate.nodeTextures[nodeType][nodeID] = nil
			GatherMate.nodeIDs[nodeType][nodeName] = nil
			GatherMate.reverseNodeIDs[nodeType][nodeID] = nil
			NL[nodeName] = nil
		else
			GatherMate.nodeTextures[nodeType][nodeID] = data.Icon or GetItemIcon(data.IconID)
			GatherMate.nodeIDs[nodeType][nodeName] = nodeID
			GatherMate.reverseNodeIDs[nodeType][nodeID] = nodeName
			--print(("inj: %s"):format(nodeName))
			NL[nodeName] = true
			
			--print("injecting "..nodeName)
		end
	end
	if reset then 

		WoWGatheringNodes:RoutesHook(false)
	else
		WoWGatheringNodes:RoutesHook(true)
	end
end


--- Cycles through the custom node list and injects data into Gatherer
--pram: reset  If true, removes the injected data
function WoWGatheringNodes:AddCustomGathererNodes(reset)
	for nodeID, data in pairs(WoWGatheringNodes.CustomNodesList ) do
		local icon_path = data.Icon
		local nodeName = WoWGatheringNodes.NodeIdNames[nodeID] --data.Name
		local nodeType = data.Type
		local stubName = data.Name

		if nodeType == "Treasure" then
			stubName = "TREASURE_"..stubName
			nodeType = "OPEN"
		elseif nodeType == "Herb" then
			stubName = "HERB"..stubName
			nodeType = "HERB"
		elseif nodeType == "Mine" then
			stubName = "MINE"..stubName
			nodeType = "MINE"

		end
		--GatherMate.nodeTextures[nodeType][nodeID] = icon_path
		--GatherMate.nodeIDs[nodeType][nodeName] = nodeID
		--GatherMate.reverseNodeIDs[nodeType][nodeID] = nodeName

		if reset or not Profile.CustomNodes[nodeName] then
			Gatherer.Nodes.Objects[nodeID] = nil
			Gatherer.Nodes.Names[nodeName] = nil
			Gatherer.Categories.ObjectCategories[nodeID] = nil
			Gatherer.Categories.CategoryNames[stubName] = nil
			Gatherer.Icons[nodeID] = nil
			--print("clear")
		else
			Gatherer.Nodes.Objects[nodeID] = "OPEN"
			Gatherer.Nodes.Names[nodeName] = nodeID
			Gatherer.Categories.ObjectCategories[nodeID] = stubName
			Gatherer.Categories.CategoryNames[stubName] = nodeName
			Gatherer.Nodes.PrimaryItems[nodeID] = data.IconID --Item number to be used for the icon
			--print("inject")
		end
	end

	--Cycles though the Gatherer name table to rebuild the local nodeNames table to include injected data.
	local nodeNames = {}

	for name, objectID in pairs(Gatherer.Nodes.Names) do
		nodeNames[objectID] = name
	end

	--Overwrites the standard gatherer function to use the new table with injected names, should really hook-redirect
	function Gatherer.Util.GetNodeName(objectID)
		return nodeNames[objectID] or ("Unknown: "..objectID)
	end
end


--Fix for routes issue where it does not recognize ijected items
local translate_db_type = {
	["Herb Gathering"] = "Herbalism",
	["Mining"] = "Mining",
	["Fishing"] = "Fishing",
	["Extract Gas"] = "ExtractGas",
	["Treasure"] = "Treasure",
	["Archaeology"] = "Archaeology",
	["Logging"] = "Logging",
}

local function Gathermate_AppendNodes(node_list, zone, db_type, node_type)
	--return hook.hooks[Routes.plugins["GatherMate2"]]["AppendNodes"](node_list, zone, db_type, node_type)
	--node_type = tonumber(node_type)
	--local english_node, localized_node, type = hook.hooks[Routes.plugins["GatherMate2"]]["AppendNodes"](node_list, zone, db_type, node_type)
	local english_node, localized_node, type = Routes_hook(node_list, zone, db_type, node_type)
	node_type = tonumber(node_type)
	if WoWGatheringNodes.CustomNodesList[node_type] then 
	
		english_node = WoWGatheringNodes.NodeIdNames[node_type]
		localized_node = WoWGatheringNodes.NodeIdNames[node_type]
		type = translate_db_type[db_type]
	end

	return english_node, localized_node, type

end

local Routes_hook 

if IsAddOnLoaded("Routes") then 
	Routes_hook = Routes.plugins["GatherMate2"]["AppendNodes"]
end

function WoWGatheringNodes:RoutesHook(reset)
	if not IsAddOnLoaded("Routes") then return end
	if reset then 
		Routes.plugins["GatherMate2"]["AppendNodes"] = Routes_hook
	else
		Routes.plugins["GatherMate2"]["AppendNodes"] = Gathermate_AppendNodes
	end
end