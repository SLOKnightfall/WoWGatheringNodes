--///////////////////////////////////////////////////////////////////////////////////////////
-- Code to register with Gatherer and import the data 
-- This is modified code taken from DB_WowheadMain.lua from GathererDB WoWHead  (v2.0.2013-06-15)
-- GathererDB WoWHead   is written and maintained by the folks @ http://www.gathereraddon.com/
--///////////////////////////////////////////////////////////////////////////////////////////


if not IsAddOnLoaded("Gatherer") then return end

local WoWGatheringNodes = LibStub("AceAddon-3.0"):GetAddon("WoWGatheringNodes")

local lib = {}
lib.data = {}

lib.isLoading = true

if not Gatherer then lib.isLoading = false
elseif not Gatherer.Api then lib.isLoading = false
elseif not Gatherer.Api.AddGather then lib.isLoading = false
elseif not Gatherer.ZoneTokens then lib.isLoading = false
elseif not Gatherer.Config.AddCallback then
	DEFAULT_CHAT_FRAME:AddMessage("WoWGatheringNodes: Please upgrade to the latest version of Gatherer.")
	lib.isLoading = false
end

if not lib.isLoading then
	DEFAULT_CHAT_FRAME:AddMessage("WoWGatheringNodes: Not loading due to missing or old Gatherer.")
	return
end

local updateFrame
local co
local YIELD_AT = 20


---Parses node data into the format required by Gatherer to be imported
local function parseGathererData()
	local ProcessedData = lib.data
	fuf = WGatheringNodes
	for MapID, NodeData in pairs( WoWGatheringNodes.Data ) do
		ProcessedData[MapID] = ProcessedData[MapID] or {}
		for NodeID, CoordData in pairs( NodeData ) do
			ProcessedData[MapID][NodeID] = ProcessedData[MapID][NodeID] or {}
			--Converts the data into a Gatherer's format
			for _, Coords in ipairs( CoordData) do
				local x , y = WoWGatheringNodes:DecodeLoc(Coords)
				local coords = floor( x * 10 + 0.5 ) * 1000 + floor( y * 10  + 0.5 )
				tinsert(ProcessedData[MapID][NodeID],coords)
			end
		end
	end
end


local function beginImport()
	parseGathererData()
	-- Disable minimap updates for the duration of the update
	local curMini = Gatherer.Config.GetSetting("minimap.enable")
	local curHud = Gatherer.Config.GetSetting("hud.enable")
	Gatherer.Config.SetSetting("minimap.enable", false)
	Gatherer.Config.SetSetting("hud.enable", false)

	-- Count the total number of inserts needed, so that we can do a progress bar!
	local position, total, counter = 0,0,0
	for zone, zdata in pairs(lib.data) do
		for node, ndata in pairs(zdata) do
			total = total + #ndata
		end
	end

	-- Neutralize all of the unvalidated nodes by us from the current database...
	for z, zoneToken in pairs(Gatherer.ZoneTokens.Tokens) do
		if ( type(zoneToken)=='string' and type(z)=='number' ) then
			for node, ntype in pairs(Gatherer.Nodes.Objects) do
				Gatherer.Storage.RemoveGather(zoneToken, node, ntype, "DB:WoWGatheringNodes")
			end
			counter = counter + 1
			if counter > YIELD_AT then
				coroutine.yield()
				counter = 0
			end
		end
	end

	-- Add all the nodes from the current database
	for zone, zdata in pairs(lib.data) do
		for node, ndata in pairs(zdata) do
			for pos, coord in ipairs(ndata) do
				local x = math.floor(coord/1000)/1000
				local y = (coord%1000)/1000
				Gatherer.Storage.MassImportMode = true

				local success = Gatherer.Api.AddGather(node, nil, nil, 'DB:WoWGatheringNodes', nil, nil, false, nil, zone, x, y)
				Gatherer.Storage.MassImportMode = false
				position = position + 1
				counter = counter + 1
				if counter > YIELD_AT then
					updateFrame:SetPct(position/total)
					coroutine.yield()
					counter = 0
				end
			end
		end
	end

	-- Restore the minimap and hud display settings
	Gatherer.Config.SetSetting("minimap.enable", curMini)
	Gatherer.Config.SetSetting("hud.enable", curHud)

	--Clears Db tables from memory
	lib.data = nil

end

function WoWGatheringNodes:PerformGathererImport()
	if not updateFrame then
		updateFrame = CreateFrame("Frame", nil, UIParent)
		updateFrame:SetPoint("CENTER", UIParent, "CENTER")
		updateFrame:SetFrameStrata("TOOLTIP")
		updateFrame:SetWidth("320")
		updateFrame:SetHeight("50")
		updateFrame:SetScript("OnUpdate", function()
			if not coroutine.resume(co) then
				updateFrame:Hide()
			end
		end)

		updateFrame.text = updateFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
		updateFrame.text:SetPoint("TOPLEFT", updateFrame, "TOPLEFT", 10,-5)
		updateFrame.text:SetHeight(16)
		updateFrame.text:SetJustifyH("LEFT")
		updateFrame.text:SetJustifyV("TOP")
		updateFrame.text:SetText("Importing WoWGatheringNodes database:")

		updateFrame.back = updateFrame:CreateTexture(nil, "BACKGROUND")
		updateFrame.back:SetPoint("TOPLEFT")
		updateFrame.back:SetPoint("BOTTOMRIGHT")
		updateFrame.back:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")

		updateFrame.bar = updateFrame:CreateTexture(nil, "BORDER")
		updateFrame.bar:SetTexture(1,1,1)
		updateFrame.bar:SetPoint("BOTTOMLEFT", updateFrame, "BOTTOMLEFT", 10, 5)
		updateFrame.bar:SetPoint("BOTTOMRIGHT", updateFrame, "BOTTOMRIGHT", -10, 5)
		updateFrame.bar:SetHeight(18)
		updateFrame.bar:SetAlpha(0.2)

		updateFrame.bar.pct = updateFrame:CreateTexture(nil, "ARTWORK")
		updateFrame.bar.pct:SetTexture(1,1,1)
		updateFrame.bar.pct:SetGradientAlpha("Vertical", 0,0,0.4, 1, 0,0,0.7, 1)
		updateFrame.bar.pct:SetPoint("BOTTOMLEFT", updateFrame.bar, "BOTTOMLEFT")
		updateFrame.bar.pct:SetPoint("TOPLEFT", updateFrame.bar, "TOPLEFT")

		updateFrame.bar.text = updateFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
		updateFrame.bar.text:SetPoint("TOPLEFT", updateFrame.bar, "TOPLEFT", 0,0)
		updateFrame.bar.text:SetPoint("BOTTOMRIGHT", updateFrame.bar, "BOTTOMRIGHT", 0,0)
		updateFrame.bar.text:SetJustifyH("CENTER")
		updateFrame.bar.text:SetJustifyV("CENTER")

		updateFrame.bar.text:SetText("0%")

		function updateFrame:SetPct(pct)
			pct = math.max(0, math.min((tonumber(pct) or 0), 1))

			local width = updateFrame:GetWidth() - 20
			updateFrame.bar.pct:SetWidth(width * pct)
			updateFrame.bar.text:SetText(("%0.1f%%"):format(pct*100))
		end
	end
	updateFrame:Show()

	co = coroutine.create(beginImport)
end

local misingIDs = {}
local missingData = {}

function comp2()
	 for name, data in pairs(Gatherer.Nodes.Names) do


	 if not WoWGatheringNodes.NodeIdNames[data] then print("missing "..name); misingIDs[data] = true end


	end
	for Map, data in pairs(GathererDB.Wowhead.data) do

		for object, coords in pairs(data) do
			if misingIDs[object] then
				Mapid = Gatherer.ZoneTokens.GetZoneMapIDAndFloor(Map)
				missingData[Mapid] = missingData[Mapid] or {}

				local textcord = ""
				for i, cord in ipairs(coords) do
				local x = math.floor(cord/1000)
				local y = (cord%1000)
				print(x)
				print(y)
				local poss = math.floor( x  ) * 100000 + math.floor( y   )*10
				--print(poss)
				textcord = textcord..poss..", "
			end
							missingData[Mapid][object] = textcord
			end

		end
	end

foo = missingData
end