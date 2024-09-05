--///////////////////////////////////////////////////////////////////////////////////////////
-- Code to create ACE3 config menue for Gathermate2 
-- This is based on code from Gathermate_ImportConfig.lua from Gathermate2
-- Gathermate2 is written and maintained by the  kagaro, Nevcairiel, Xinhuan and can be found at
--  https://mods.curse.com/addons/wow/gathermate2
--///////////////////////////////////////////////////////////////////////////////////////////

if not C_AddOns.IsAddOnLoaded("GatherMate2") then return end

local GatherMate = LibStub("AceAddon-3.0"):GetAddon("GatherMate2")
local WoWGatheringNodes = LibStub("AceAddon-3.0"):GetAddon("WoWGatheringNodes")
local Config = GatherMate:GetModule("Config")

local L = LibStub("AceLocale-3.0"):GetLocale("GatherMate2", false)
local LL = LibStub("AceLocale-3.0"):GetLocale("WoWGatheringNodes", false)

local db = GatherMate.db.profile
local imported = {}
-- setup the options, we need to reference GatherMate for this

local function get(k) return db[k.arg] end
local function set(k, v) db[k.arg] = v; Config:UpdateConfig(); end

local ImportHelper = {}

ImportHelper.db_options = {
	["Merge"] = L["Merge"],
	["Overwrite"] = L["Overwrite"]
}
ImportHelper.db_tables = {
	["Herbs"] = L["Herbalism"],
	["Mines"] = L["Mining"],
	["Gases"] = L["Gas Clouds"],
	["Fish"] = L["Fishing"],
	["Treasure"] = L["Treasure"],
	["Archaeology"] = L["Archaeology"],
	["Logging"] = "Timber",
}
ImportHelper.expac_data = {
	["TBC"] = L["The Burning Crusades"],
	["WRATH"] = L["Wrath of the Lich King"],
	["CATACLYSM"] = L["Cataclysm"],
	["MISTS"] = L["Mists of Pandaria"],
	["WOD"] = L["Warlords of Draenor"],
	["LEGION"] = L["Legion"],
	["BFA"] = "Battle For Azeroth",
	["TWW"] = "The War Within",
}

imported["WoWGatheringNodes_Data"] = false


WoWGatheringNodes_Op = {
	type = "group",
	name = "WoWGatheringNodes", -- addon name to import from, don't localize
	handler = ImportHelper,
	args = {
		desc = {
			order = 0,
			type = "description",
			name = L["Importing_Desc"],
		},
		loadType = {
			order = 1,
			name = L["Import Style"],
			desc = LL["Merge will add WoWGatheringNodes to your database. Overwrite will replace your database with the data in WoWGatheringNodes"],
			type = "select",
			values = ImportHelper.db_options,
			set = function(info,k,state) db["importers"][info.arg].Style = k end,
			get = function(info,k) return db["importers"][info.arg].Style end,
			arg = "WoWGatheringNodes",
		},
		loadDatabase = {
			order = 2,
			name = L["Databases to Import"],
			desc = L["Databases you wish to import"],
			type = "multiselect",
			values = ImportHelper.db_tables,
			set = function(info,k,state) db["importers"][info.arg].Databases[k] = state end,
			get = function(info,k)	return db["importers"][info.arg].Databases[k] end,
			arg = "WoWGatheringNodes",
		},
		stylebox = {
			order = 4,
			type = "group",
			name = L["Import Options"],
			inline = true,
			args = {
				loadExpacToggle = {
					order = 4,
					name = L["Expansion Data Only"],
					type = "toggle",
					get = function(info,k) return db["importers"][info.arg].expacOnly end,
					set = function(info,state) db["importers"][info.arg].expacOnly = state end,
					arg = "WoWGatheringNodes"
				},
				loadExpansion = {
					order = 4,
					name = L["Expansion"],
					desc = L["Only import selected expansion data from WoWhead"],
					type = "select",
					get  = function(info,k) return db["importers"][info.arg].expac end,
					set  = function(info,state) db["importers"][info.arg].expac = state end,
					values = ImportHelper.expac_data,
					arg  = "WoWGatheringNodes",
				},
				loadAuto = {
					order = 5,
					name = L["Auto Import"],
					desc = L["Automatically import when ever you update your data module, your current import choice will be used."],
					type = "toggle",
					get = function(info, k)	return db["importers"][info.arg].autoImport end,
					set = function(info,state) db["importers"][info.arg].autoImport = state end,
					arg = "WoWGatheringNodes",
				},
			}
		},
		loadData = {
			order = 8,
			name = LL["Import WoWGatheringNodes"],
			desc = LL["Load WoWGatheringNodes and import the data to your database."],
			type = "execute",
			func = function()
				WoWGatheringNodes:ImportGathermate()
			end,
			disabled = function()
				if  not WoWGatheringNodes.runautoimport then 
					local cm = 0
					if db["importers"]["WoWGatheringNodes"].Databases["Mines"] then cm = 1 end
					if db["importers"]["WoWGatheringNodes"].Databases["Herbs"] then cm = 1 end
					if db["importers"]["WoWGatheringNodes"].Databases["Gases"] then cm = 1 end
					if db["importers"]["WoWGatheringNodes"].Databases["Fish"] then cm = 1 end
					if db["importers"]["WoWGatheringNodes"].Databases["Treasure"] then cm = 1 end
					if db["importers"]["WoWGatheringNodes"].Databases["Archaeology"] then cm = 1 end
					if db["importers"]["WoWGatheringNodes"].Databases["Logging"] then cm = 1 end
					return imported["WoWGatheringNodes"] or (cm == 0 and not imported["WoWGatheringNodes"])
				end
				WoWGatheringNodes.runautoimport = false
			end,
		}
	},
}

Config:RegisterImportModule("WoWGatheringNodes", WoWGatheringNodes_Op)

function WoWGatheringNodes:ImportGathermate()
	local loaded, reason = C_AddOns.LoadAddOn("WoWGatheringNodes")
	--print(LoadAddOn("WoWGatheringNodes"))
	local WoWGatheringNodes = LibStub("AceAddon-3.0"):GetAddon("WoWGatheringNodes")
	if loaded and WoWGatheringNodes.generatedVersion then
		local dataVersion = tonumber(WoWGatheringNodes.generatedVersion:match("%d+"))
		local filter = nil
		if db.importers["WoWGatheringNodes"].expacOnly then
			filter = db.importers["WoWGatheringNodes"].expac
		end
		WoWGatheringNodes:PerformMerge(db.importers["WoWGatheringNodes"].Databases,db.importers["WoWGatheringNodes"].Style,filter)
		WoWGatheringNodes:CleanupGathermateImportData()
		print(LL["WoWGatheringNodes has been imported."])
		Config:SendMessage("GatherMate2ConfigChanged")
		db["importers"]["WoWGatheringNodes"]["lastImport"] = dataVersion
		imported["WoWGatheringNodes"] = true
		GatherMate:RemoveDepracatedNodes()
		WoWGatheringNodes:DataUpdate_8_2()
	else
		print(LL["Failed to load WoWGatheringNodes due to "]..reason)
	end
end