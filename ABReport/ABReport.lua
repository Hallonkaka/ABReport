-- CONFIG START

local ABReport_ReportTime = 1.5; -- delay in seconds before message is posted

-- CONFIG END

SLASH_AR1= "/AR";

BINDING_HEADER_ABREPORT_HEADER = "ABReport";
BINDING_NAME_ABREPORT = "Report Incoming";
BINDING_NAME_ABSAFE = "Report Safe";

local ABReport_LastClickTime = 0;
local ABReport_Enemies = 0;
local ABReport_DoReport = false;

SlashCmdList["AR"] = function(args)
	ABReport_DoClick();
end;

function ABReport_DoClick()
	ABReport_LastClickTime = time();
	ABReport_Enemies = ABReport_Enemies + 1;
	ABReport_DoReport = true;
end

function ABReport_DoSafe()
	SendChatMessage("[ABr] "..GetSubZoneText().." is currently safe!", "BATTLEGROUND");
end

function ABReport_OnUpdate()
	if ABReport_DoReport and ABReport_LastClickTime + ABReport_ReportTime <= time()
	then
		SendChatMessage("[ABr] Reporting  "..ABReport_Enemies.." enemies at "..GetSubZoneText().."!", "BATTLEGROUND");
		ABReport_Enemies = 0;
		ABReport_DoReport = false;
	end
end

function ABReport_OnEvent()
	
end

ABReport_frame = CreateFrame("FRAME", "ABReport_frame");
ABReport_frame:SetScript("OnUpdate", function() ABReport_OnUpdate() end);
ABReport_frame:SetScript("OnEvent", function() ABReport_OnEvent(event, arg1, arg2, arg3, arg4) end);
ABReport_frame:RegisterEvent("ADDON_LOADED");