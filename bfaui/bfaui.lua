ADDON_NAME = "bfaui";
ART_PATH = "Interface\\AddOns\\" .. ADDON_NAME .. "\\art\\";
version = "2.0"

DEFAULT_CHAT_FRAME:AddMessage("BFA UI loaded", 1.0, 1.0, 0.0);

local function null()
	return;
end

-- efficiant way to remove frames (does not work on textures)
local function Kill(frame)
	if type(frame) == "table" and frame.SetScript then
		frame:UnregisterAllEvents()
		frame:SetScript("OnEvent", nil)
		frame:SetScript("OnUpdate", nil)
		frame:SetScript("OnHide", nil)
		frame:Hide()
		frame.SetScript = null
		frame.RegisterEvent = null
		frame.RegisterAllEvents = null
		frame.Show = null
	end
end

local function initMicroMenu()
    MicroMenuArt = CreateFrame('Frame', 'MicroMenuArt', UIParent);
    MicroMenuArt:SetFrameStrata('BACKGROUND');
    MicroMenuArt:SetPoint('BOTTOMRIGHT', UIParent, 'BOTTOMRIGHT', 0, 0);
    MicroMenuArt:SetWidth(512);
    MicroMenuArt:SetHeight(128);
    MicroMenuArt.texture = MicroMenuArt:CreateTexture('MicroMenuArtTexture');
    MicroMenuArt.texture:SetDrawLayer("Background");
    MicroMenuArt.texture:SetTexture(ART_PATH .. "MicroMenuArt");
    MicroMenuArt.texture:SetAllPoints();
    MicroMenuArt:Show();

    MainMenuBarBackpackButton:SetScale(1)
    MainMenuBarBackpackButton:ClearAllPoints();
    MainMenuBarBackpackButton:SetPoint('RIGHT', MicroMenuArt, 'RIGHT', -6.5, 2);

    for i = 0, 3 do
        local bag, previousBag = _G["CharacterBag" .. i .. "Slot"], _G["CharacterBag" .. i - 1 .. "Slot"]
        bag:SetScale(0.75);
        bag:ClearAllPoints();

        if i == 0 then
            bag:SetPoint("BOTTOMRIGHT", MainMenuBarBackpackButton, "BOTTOMLEFT", -9, 1)
        else
            bag:SetPoint("BOTTOMRIGHT", previousBag, "BOTTOMLEFT", -6, 0)
        end
    end

    CharacterMicroButton:ClearAllPoints();
    CharacterMicroButton:SetPoint('CENTER', MicroMenuArt, 'CENTER', 54, -32);

    MainMenuBarPerformanceBarFrame:SetFrameStrata("HIGH");
    MainMenuBarPerformanceBarFrame:SetScale(0.8);
    MainMenuBarPerformanceBar:ClearAllPoints()
    MainMenuBarPerformanceBar:SetPoint('RIGHT', CharacterMicroButton, 'LEFT', 5, -12);
    MainMenuBarPerformanceBarFrameButton:SetAllPoints(MainMenuBarPerformanceBar);
end

local function initActionBars()
    MainMenuBar:SetWidth(1024);
    MainMenuBar:SetHeight(128);

    MainMenuBarTexture0:Hide();
    MainMenuBarTexture1:Hide();
    MainMenuBarTexture2:Hide();
    MainMenuBarTexture3:Hide();

    for i = 0, 3 do -- for loop, hides MainMenuXPBarTexture (0-3)
        _G["MainMenuXPBarTexture" .. i]:Hide();
    end

    for i = 1, 12 do
        _G["ActionButton" .. i .. "HotKey"]:SetAlpha(1)
        _G["MultiBarBottomLeftButton" .. i .. "HotKey"]:SetAlpha(1)
        _G["MultiBarBottomRightButton" .. i .. "HotKey"]:SetAlpha(1)
        _G["MultiBarRightButton" .. i .. "HotKey"]:SetAlpha(1)
        _G["MultiBarLeftButton" .. i .. "HotKey"]:SetAlpha(1)
    end

    MainMenuBar.texture1 = MainMenuBar:CreateTexture("ActionBarTexture1");
    MainMenuBar.texture1:SetDrawLayer("Background");
    MainMenuBar.texture1:SetPoint("TOPLEFT", MainMenuBar,"TOPLEFT", 0, 0);
    MainMenuBar.texture1:SetPoint("BOTTOMRIGHT", MainMenuBar,"BOTTOM", 0, 0);
    MainMenuBar.texture2 = MainMenuBar:CreateTexture('ActionBarTexture2');
    MainMenuBar.texture2:SetDrawLayer("Background");
    MainMenuBar.texture2:SetPoint("TOPLEFT", MainMenuBar,"TOP", 0, 0);
    MainMenuBar.texture2:SetPoint("BOTTOMRIGHT", MainMenuBar,"BOTTOMRIGHT", 0, 0);

    MainMenuExpBar:SetFrameStrata("LOW");
    MainMenuExpBar:SetHeight(10);
    MainMenuExpBar:ClearAllPoints();
    MainMenuExpBar:SetPoint("BOTTOM", MainMenuBar, 0, 0);
    MainMenuBarExpText:ClearAllPoints()
    MainMenuBarExpText:SetPoint("CENTER", MainMenuExpBar, 0, 0)
    MainMenuBarOverlayFrame:SetFrameStrata("HIGH")
    MainMenuExpBar:Show();

    BonusActionBarTexture0:Hide();
    BonusActionBarTexture1:Hide();
end

local function onUpdateActionBars()
    local texture = "ActionBarArtSmall";
    local xpBarWidth = 550;
    local actionBarPos = 245;
    local pageBtnPos = 758;
    local pageNbPos = 266;
    local capPos = 140;
--    local shapebarRef = MultiBarBottomLeft;
--    local shapebarPos = 1;
    local shapebarRef = ActionButton1;
    local shapebarPos = 10;

    MultiBarBottomRight:ClearAllPoints();
    MultiBarBottomRightButton7:ClearAllPoints();

    if MultiBarBottomLeft:IsShown() then
        shapebarRef =  MultiBarBottomLeft;
        shapebarPos = 10;
    end

    -- large mode
	--if MultiBarBottomRight:IsShown() and compact == 0 then
	if MultiBarBottomRight:IsShown() then
        xpBarWidth = 794;
        texture = 'ActionBarArtLarge';
        actionBarPos = 118;
        pageBtnPos = 632;
        pageNbPos = 138;
        capPos = 12;

        MultiBarBottomRight:SetPoint("LEFT", MultiBarBottomLeft, "RIGHT", 43, 0);
        MultiBarBottomRightButton7:SetPoint("LEFT", MultiBarBottomRight, 0, -54);
    end

    MainMenuBar.texture1:SetTexture(ART_PATH .. texture .. '1');
    MainMenuBar.texture2:SetTexture(ART_PATH .. texture .. '2');
    MainMenuExpBar:SetWidth(xpBarWidth);

    ActionButton1:ClearAllPoints();
    ActionButton1:SetPoint("BOTTOMLEFT", MainMenuBar, "BOTTOMLEFT", actionBarPos, 14);

    BonusActionButton1:ClearAllPoints();
    BonusActionButton1:SetPoint("BOTTOMLEFT", MainMenuBar, "BOTTOMLEFT", actionBarPos, 15);

    ShapeshiftButton1:ClearAllPoints();
    ShapeshiftButton1:SetPoint("BOTTOMLEFT", shapebarRef, "TOPLEFT", 50, shapebarPos);
    PetActionButton1:ClearAllPoints();
    PetActionButton1:SetPoint("BOTTOMLEFT", shapebarRef, "TOPLEFT", 64, shapebarPos);

    ActionBarUpButton:SetPoint("CENTER", MainMenuBar, "TOPLEFT", pageBtnPos, -86.5);
    ActionBarDownButton:SetPoint("CENTER", MainMenuBar, "TOPLEFT", pageBtnPos, -106);
    MainMenuBarPageNumber:SetPoint("CENTER", MainMenuBar, pageNbPos, -31);

    MainMenuBarLeftEndCap:ClearAllPoints();
    MainMenuBarLeftEndCap:SetPoint("LEFT", MainMenuBar, "LEFT", capPos, 0);
    MainMenuBarRightEndCap:ClearAllPoints();
    MainMenuBarRightEndCap:SetPoint("RIGHT", MainMenuBar, "RIGHT", -capPos, 0);

    ShapeshiftBarLeft:Hide();
    ShapeshiftBarMiddle:Hide();
    ShapeshiftBarRight:Hide();
end

BfaUiVarsDefault = {
}

local function initVars()
    if (not BfaUiVars) then
        BfaUiVars = {}
    end

    -- copy defaults to conf if key not exists
    for k, v in pairs(BfaUiVarsDefault) do
        if (not BfaUiVars[k]) then
            BfaUiVars[k] = BfaUiVarsDefault[k];
        end
    end
end

local function onLoad()
    Kill(MainMenuBarMaxLevelBar)

    initVars();
    initMicroMenu();
    initActionBars();

    hooksecurefunc(MultiBarBottomRight, 'Show', onUpdateActionBars);
    hooksecurefunc(MultiBarBottomRight, 'Hide', onUpdateActionBars);
    hooksecurefunc(MultiBarBottomLeft, 'Show', onUpdateActionBars);
    hooksecurefunc(MultiBarBottomLeft, 'Hide', onUpdateActionBars);

    onUpdateActionBars();
end

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("UI_SCALE_CHANGED")
f:SetScript("OnEvent", function()
	if (event == "ADDON_LOADED" and arg1 == ADDON_NAME) then
    end

    if (event == "PLAYER_ENTERING_WORLD") then
        onLoad();
    end

    if (event == "UI_SCALE_CHANGED") then
    end
end)

SLASH_BFAUI1 = '/bfa';

local function cmdHelp()
    DEFAULT_CHAT_FRAME:AddMessage('===== BFA UI v' .. version);
end

SlashCmdList['BFAUI'] = function(msg)
    msg = string.lower(msg);

    local _, _, cmd, args = string.find(msg, '%s?(%w+)%s?(.*)');

    if (cmd == 'help' or not cmd) then
        cmdHelp();
    end
end
