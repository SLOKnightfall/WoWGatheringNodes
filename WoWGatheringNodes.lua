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
		InjectNodes = true,
		AutoClear = false,
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
CustomNodesList = {
	[271227] = {
		["Name"] = WoWGatheringNodes.NodeIdNames[271227], --"Hidden Wyrmtongue Cache",
		["Icon"] = icon_path,--.."Treasure\\footlocker.tga",
		["Type"] = "Treasure",
		["NodeID"] = 271227,
		["IconID"] = 19291,
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
	for nodeID, objectData in pairs(CustomNodesList) do
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
		end

	if IsAddOnLoaded("Gathermate2") then
		GatherMate = LibStub("AceAddon-3.0"):GetAddon("GatherMate2")

		if Profile.InjectNodes then
			WoWGatheringNodes:AddCustomGathermateNodes()
		end

			--if datafile matches last import version, no need to import
		if Profile.GathermateImport ~= WoWGatheringNodes.generatedVersion then
		else
		end
	end

	if ((Profile.GathermateImport == WoWGatheringNodes.generatedVersion
			or Profile.GathererImport == WoWGatheringNodes.generatedVersion)
			and Profile.AutoClear)
		or (not IsAddOnLoaded("Gathermate2") and not IsAddOnLoaded("Gatherer")) then

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
	for nodeID, data in pairs(CustomNodesList) do
		local nodeName = WoWGatheringNodes.NodeIdNames[nodeID] --data.Name
		local nodeType = data.Type

		if reset or not Profile.CustomNodes[nodeName] then
			--print("clearing")
			GatherMate.nodeTextures[nodeType][nodeID] = nil
			GatherMate.nodeIDs[nodeType][nodeName] = nil
			GatherMate.reverseNodeIDs[nodeType][nodeID] = nil
		else

			GatherMate.nodeTextures[nodeType][nodeID] = GetItemIcon(data.IconID)
			GatherMate.nodeIDs[nodeType][nodeName] = nodeID
			GatherMate.reverseNodeIDs[nodeType][nodeID] = nodeName
			--print("injecting "..nodeName)
		end
	end
end


--- Cycles through the custom node list and injects data into Gatherer
--pram: reset  If true, removes the injected data
function WoWGatheringNodes:AddCustomGathererNodes(reset)
	for nodeID, data in pairs(CustomNodesList) do
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