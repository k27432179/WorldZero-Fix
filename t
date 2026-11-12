if not game:IsLoaded() then game.Loaded:Wait() end

-- || CHECK IF IN WORLD ZERO ||
if tostring(game.GameId) ~= "985731078" then -- set to string or obfuscation can mess it up
    game:Shutdown()
end

if _G.ScriptRunning then
    warn("[WZF] Startup blocked: script is already marked running. Previous step:", tostring(_G.ScriptStep))
    return
end
_G.ScriptRunning = true -- prevent script from being loaded twice
print("[WZF] E1-combat-workers-retry-3s startup:", game.PlaceId, "job:", game.JobId)
-- Read-only startup watchdog: leaves gameplay and settings unchanged.
task.delay(15, function()
    if _G.ScriptRunning and _G.ScriptStep ~= "end" then
        warn("[WZF] Startup has not finished after 15 seconds. Step:", tostring(_G.ScriptStep))
    end
end)

local ScriptLoadingStart = os.clock()
-- || CHECK STEP || - turn on to see scripts loading progress
do
    local TrackProgress = false
    if TrackProgress then
        task.spawn(function()
            repeat
                print(_G.ScriptStep)                            
                task.wait(1)
            until _G.ScriptStep == "end"
            print("loaded everything")
        end)
    end
end

local GlobalCount = 0
local function SetGlobal(Text)
    if GlobalCount == 5 then
        task.wait()
    end

    _G.ScriptStep = Text
    GlobalCount += 1
end

-- || CREATE GUI ELEMENTS ||
local function MakeGuiElement(Type, ...)
    local NewUI = Instance.new(Type)
    local GuiTable = ...
    for Element, Data in GuiTable do
        NewUI[Element] = Data
    end
    return NewUI
end

-- || CREATE GUI FOR SCRIPT ERRORS ||
SetGlobal("error gui")
local EF = {}
local function MakeErrorGui(MessageTitle, Message, Extra)

    if not Extra or Extra == "" or Extra == "nil" then
        Extra = "Extra: <font color='#ff3333'>no extra info</font>"
    else
        Extra = string.format("Extra: <font color='#ff3333'>%*</font>", Extra)
    end

  local obj1 = Instance.new("ScreenGui")
    obj1.IgnoreGuiInset = true
    obj1.Name = "Script_Error"
    obj1.Parent = EF.HideGui() or game:GetService("CoreGui")

    local obj2 = Instance.new("Frame")
        obj2.Size = UDim2.new(1, 0, 1, 0)
        obj2.BackgroundTransparency = 1
        obj2.Position = UDim2.new(0.5, 0, 0.5, 0)
        obj2.Name = "Script_Error"
        obj2.AnchorPoint = Vector2.new(0.5, 0.5)
        obj2.Parent = obj1

        local obj3 = Instance.new("Frame")
            obj3.BackgroundColor3 = Color3.fromHex("e2e2ff")
            obj3.Size = UDim2.new(0.459500968, 0, 0.488323361, 0)
            obj3.Position = UDim2.new(0.5, 0, 0.5, 0)
            obj3.Name = "Error_Frame"
            obj3.AnchorPoint = Vector2.new(0.5, 0.5)
            obj3.Parent = obj2

            local obj4 = Instance.new("UICorner")
                obj4.Name = "UICorner"
                obj4.CornerRadius = UDim.new(0.0500000007, 0)
                obj4.Parent = obj3

            local obj5 = Instance.new("TextLabel")
                obj5.TextWrapped = true
                obj5.Size = UDim2.new(0.421533257, 0, 0.112499997, 0)
                obj5.BackgroundTransparency = 1
                obj5.Position = UDim2.new(0.0144872097, 0, 0.0152609488, 0)
                obj5.Name = "Error_Occurred"
                obj5.TextScaled = true
                obj5.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                obj5.Text = "腳本發生錯誤"
                obj5.TextSize = 37
                obj5.Parent = obj3

            local obj6 = Instance.new("ImageButton")
                obj6.BackgroundColor3 = Color3.fromHex("5650f6")
                obj6.Image = ""
                obj6.Size = UDim2.new(0.25, 0, 0.150000006, 0)
                obj6.Position = UDim2.new(0.739221275, 0, 0.828954279, 0)
                obj6.Name = "Join_Button"
                obj6.Selectable = true
                obj6.Parent = obj3

                local obj7 = Instance.new("UICorner")
                    obj7.Name = "UICorner"
                    obj7.CornerRadius = UDim.new(0.25, 0)
                    obj7.Parent = obj6

                local obj8 = Instance.new("TextLabel")
                    obj8.TextWrapped = true
                    obj8.Size = UDim2.new(1, 0, 1, 0)
                    obj8.BackgroundTransparency = 1
                    obj8.Position = UDim2.new(0.5, 0, 0.5, 0)
                    obj8.RichText = true
                    obj8.Name = "Join"
                    obj8.TextScaled = true
                    obj8.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                    obj8.AnchorPoint = Vector2.new(0.5, 0.5)
                    obj8.TextColor3 = Color3.fromHex("e2e2e2")
                    obj8.Text = "加入 Discord"
                    obj8.TextSize = 35
                    obj8.Parent = obj6

                local obj9 = Instance.new("UIPadding")
                    obj9.PaddingTop = UDim.new(0.174999997, 0)
                    obj9.PaddingLeft = UDim.new(0.150000006, 0)
                    obj9.Name = "UIPadding"
                    obj9.PaddingBottom = UDim.new(0.174999997, 0)
                    obj9.PaddingRight = UDim.new(0.150000006, 0)
                    obj9.Parent = obj6

            local obj10 = Instance.new("ImageButton")
                obj10.BackgroundColor3 = Color3.fromHex("919191")
                obj10.Image = ""
                obj10.Size = UDim2.new(0.25, 0, 0.150000006, 0)
                obj10.BackgroundTransparency = 0.75
                obj10.Position = UDim2.new(0.466563225, 0, 0.828954279, 0)
                obj10.Name = "Close_Button"
                obj10.Selectable = true
                obj10.ImageColor3 = Color3.fromHex("ff3333")
                obj10.Parent = obj3

                local obj11 = Instance.new("UICorner")
                    obj11.Name = "UICorner"
                    obj11.CornerRadius = UDim.new(0.25, 0)
                    obj11.Parent = obj10

                local obj12 = Instance.new("TextLabel")
                    obj12.TextWrapped = true
                    obj12.Size = UDim2.new(1, 0, 1, 0)
                    obj12.BackgroundTransparency = 1
                    obj12.Position = UDim2.new(0.5, 0, 0.5, 0)
                    obj12.Name = "Close"
                    obj12.TextScaled = true
                    obj12.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                    obj12.AnchorPoint = Vector2.new(0.5, 0.5)
                    obj12.Text = "關閉"
                    obj12.TextSize = 25
                    obj12.Parent = obj10

                local obj13 = Instance.new("UIPadding")
                    obj13.PaddingTop = UDim.new(0.174999997, 0)
                    obj13.PaddingLeft = UDim.new(0.150000006, 0)
                    obj13.Name = "UIPadding"
                    obj13.PaddingBottom = UDim.new(0.174999997, 0)
                    obj13.PaddingRight = UDim.new(0.150000006, 0)
                    obj13.Parent = obj10

            local obj14 = Instance.new("Frame")
                obj14.BackgroundColor3 = Color3.fromHex("d0d0eb")
                obj14.Size = UDim2.new(0.45655039, 0, 0.114407644, 0)
                obj14.BackgroundTransparency = 0.25
                obj14.Position = UDim2.new(0.5, 0, 0.16990459, 0)
                obj14.Name = "Error_Location"
                obj14.AnchorPoint = Vector2.new(0.5, 0.5)
                obj14.Parent = obj3

                local obj15 = Instance.new("TextLabel")
                    obj15.TextWrapped = true
                    obj15.Size = UDim2.new(1.00000012, 0, 1.00000024, 0)
                    obj15.BackgroundTransparency = 1
                    obj15.Position = UDim2.new(0.50000006, 0, 0.500000119, 0)
                    obj15.RichText = true
                    obj15.Name = "Location"
                    obj15.TextScaled = true
                    obj15.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                    obj15.AnchorPoint = Vector2.new(0.5, 0.5)
                    obj15.TextColor3 = Color3.fromHex("ff3333")
                    obj15.Text = MessageTitle
                    obj15.TextSize = 35
                    obj15.Parent = obj14

                local obj16 = Instance.new("UICorner")
                    obj16.Name = "UICorner"
                    obj16.CornerRadius = UDim.new(0.200000003, 0)
                    obj16.Parent = obj14

                local obj17 = Instance.new("UIPadding")
                    obj17.PaddingTop = UDim.new(0.100000001, 0)
                    obj17.PaddingLeft = UDim.new(0.100000001, 0)
                    obj17.Name = "UIPadding"
                    obj17.PaddingBottom = UDim.new(0.100000001, 0)
                    obj17.PaddingRight = UDim.new(0.100000001, 0)
                    obj17.Parent = obj14

            local obj18 = Instance.new("Frame")
                obj18.BackgroundColor3 = Color3.fromHex("d0d0eb")
                obj18.Size = UDim2.new(0.899999857, 0, 0.566264868, 0)
                obj18.BackgroundTransparency = 0.25
                obj18.Position = UDim2.new(0.5, 0, 0.525351286, 0)
                obj18.Name = "Error_Text"
                obj18.AnchorPoint = Vector2.new(0.5, 0.5)
                obj18.Parent = obj3

                local obj19 = Instance.new("TextLabel")
                    obj19.TextWrapped = true
                    obj19.Size = UDim2.new(0.995358765, 0, 0.876286268, 0)
                    obj19.BackgroundTransparency = 1
                    obj19.Position = UDim2.new(0.502320588, 0, 0.438143224, 0)
                    obj19.RichText = true
                    obj19.Name = "Error_Main"
                    obj19.TextScaled = true
                    obj19.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                    obj19.AnchorPoint = Vector2.new(0.5, 0.5)
                    obj19.TextColor3 = Color3.fromHex("ff3333")
                    obj19.Text = Message
                    obj19.TextSize = 35
                    obj19.Parent = obj18

                local obj20 = Instance.new("UICorner")
                    obj20.Name = "UICorner"
                    obj20.CornerRadius = UDim.new(0.0500000007, 0)
                    obj20.Parent = obj18

                local obj21 = Instance.new("TextLabel")
                    obj21.TextWrapped = true
                    obj21.Size = UDim2.new(1.00000012, 0, 0.11999999, 0)
                    obj21.BackgroundTransparency = 1
                    obj21.Position = UDim2.new(0.5, 0, 0.936286449, 0)
                    obj21.RichText = true
                    obj21.Name = "Error_Extra"
                    obj21.TextScaled = true
                    obj21.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                    obj21.AnchorPoint = Vector2.new(0.5, 0.5)
                    obj21.Text = Extra
                    obj21.TextSize = 35
                    obj21.Parent = obj18

                local obj22 = Instance.new("UIPadding")
                    obj22.PaddingTop = UDim.new(0.00999999978, 0)
                    obj22.PaddingLeft = UDim.new(0.00999999978, 0)
                    obj22.Name = "UIPadding"
                    obj22.PaddingBottom = UDim.new(0.00999999978, 0)
                    obj22.PaddingRight = UDim.new(0.00999999978, 0)
                    obj22.Parent = obj18

        local obj23 = Instance.new("Frame")
            obj23.ZIndex = -1
            obj23.Size = UDim2.new(0.459500939, 0, 0.488323361, 0)
            obj23.BackgroundTransparency = 1
            obj23.Position = UDim2.new(0.5, 0, 0.5, 0)
            obj23.Name = "Gui_Glow"
            obj23.AnchorPoint = Vector2.new(0.5, 0.5)
            obj23.Parent = obj2

            local obj24 = Instance.new("ImageButton")
                obj24.ZIndex = -1
                obj24.BackgroundColor3 = Color3.fromHex("e2e2ff")
                obj24.ImageTransparency = 0.5
                obj24.Image = "rbxassetid://136878391730807"
                obj24.Size = UDim2.new(1.09508789, 0, 1.11842096, 0)
                obj24.BackgroundTransparency = 1
                obj24.Position = UDim2.new(0.5, 0, 0.5, 0)
                obj24.Name = "Glow_Image"
                obj24.Selectable = true
                obj24.ImageColor3 = Color3.fromHex("e2e2ff")
                obj24.AnchorPoint = Vector2.new(0.5, 0.5)
                obj24.Parent = obj23

	local Error_Blur = MakeGuiElement("BlurEffect", {
		Size = 50,
		Parent = game:GetService("Lighting")
	})

    pcall(function()
        if sethiddenproperty then
            sethiddenproperty(obj1, "OnTopOfCoreBlur", true)
        elseif setscriptable then
            setscriptable(obj1, "OnTopOfCoreBlur", true)
            obj1.OnTopOfCoreBlur = Enabled
            setscriptable(obj1, "OnTopOfCoreBlur", false)
        end
    end)

    local ErrorGuiDiscordButton = obj6.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard("https://discord.gg/bNWWpqFZbP")
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "已複製！",
                Text = "Discord 邀請連結已複製到剪貼簿！",
                Duration = 5,
                Icon = "rbxasset://textures/ui/LuaApp/ExternalSite/discord@3x.png",
                DisplayOrder = math.huge
            })
        end
    end)

    local ErrorGuiClosed
	obj10.MouseButton1Click:Once(function()
		Error_Blur:Destroy()
        Error_Blur = nil
		obj1:Destroy()
        obj1 = nil
        ErrorGuiDiscordButton:Disconnect()
        ErrorGuiDiscordButton = nil
        ErrorGuiClosed = true
	end)

    repeat
        task.wait()
    until ErrorGuiClosed
end

-- || EXECUTOR FUNCTIONS ||
SetGlobal("getting executor references")
EF.GetExecutor = identifyexecutor or getexecutorname or nil
EF.ExecutorName, EF.ExecutorVersion, EF.ExecutorBuild = EF.GetExecutor()
EF.SendRequest = http_request or request or (EF.ExecutorName and EF.ExecutorName.request) or (EF.ExecutorName and EF.ExecutorName.http_request) or (http and http.request) or nil
EF.Hook = hookfunc or hookfunction or nil
EF.ClearHook = restorefunc or restorefunction or nil
EF.Queue = queue_on_teleport or queueonteleport or queue_on_tp or queueontp or queueteleport or nil
EF.ClearQueue = clear_teleport_queue or clearqueueonteleport or clearteleportqueue or clear_tp_queue or cleartpqueue or clear_queue_on_teleport or nil
EF.RaknetFunction = rnet or raknet or RakNet or nil
EF.Desync = (EF.RaknetFunction and EF.RaknetFunction.desync) or nil
EF.HideGui = get_hidden_gui or gethui or gethiddengui or get_hidden_ui or gethiddenui or nil
EF.NewClosure = newcclosure or nil
EF.CloneRef = cloneref or clonereference or nil
EF.CheckHook = ishooked or isfunctionhooked or is_hooked or is_function_hooked or nil
EF.ASDFG = gethwid or get_hwid or get_device_id or getsystemid or "unknown"

-- || RETURN SERVICE ||
SetGlobal("return things for the script")
local function ReturnService(Service)
    local ReturnService = game:GetService(Service)
    if ReturnService then
        return EF.CloneRef(ReturnService)
    else
        warn("Unable to get service", Service)
    end
end

-- || RETURN ATTRIBUTE ||
local function WaitForAttribute(Parent, Attribute)
    repeat task.wait() until Parent:GetAttribute(Attribute)
    return Parent:GetAttribute(Attribute)
end

-- || ROBLOX SERVICES ||
SetGlobal("getting Service paths")
local Workspace = ReturnService("Workspace")
local Players = ReturnService("Players")
local CoreGui = ReturnService("CoreGui")
local StarterGui = ReturnService("StarterGui")
local ReplicatedStorage = ReturnService("ReplicatedStorage")
local HttpService = ReturnService("HttpService")
local VirtualUser = ReturnService("VirtualUser")
local RunService = ReturnService("RunService")
local MarketplaceService = ReturnService("MarketplaceService")
local TeleportService = ReturnService("TeleportService")
local TweenService = ReturnService("TweenService")

-- || RETURN CHILD ||
SetGlobal("getting ReplicatedStorage paths")
local function ReturnChild(Parent, Child)
    return EF.CloneRef(Parent:WaitForChild(Child, math.huge))
end

local Shared = ReturnChild(ReplicatedStorage, "Shared")
local SharedAssets = ReturnChild(ReplicatedStorage, "SharedAssets")
local Remotes = ReturnChild(ReplicatedStorage, "Remotes")
local Client = ReturnChild(ReplicatedStorage, "Client")

-- || GAME SCRIPTS ||
SetGlobal("getting ReplicatedStorage child paths")
local function GetShared(Script)
    return EF.CloneRef(Shared:WaitForChild(Script, math.huge))
end

local function GetSharedAsset(Script)
    return EF.CloneRef(SharedAssets:WaitForChild(Script, math.huge))
end
local Battlepass = GetShared("Battlepass")
local Charms = GetShared("Charms")
local Chests = GetShared("Chests")
local Drops = GetShared("Drops")
local Effects = GetShared("Effects")
local Health = GetShared("Health")
local Inventory = GetShared("Inventory")
local Items = GetShared("Items")
local Missions = GetShared("Missions")
local SMobs = GetShared("Mobs")
local ModelProvider = GetShared("ModelProvider")
local Party = GetShared("Party")
local Pets = GetShared("Pets")
local Quests = GetShared("Quests")
local Shop = GetSharedAsset("Shop")
local Skills = GetShared("Skills")
local Teleport = GetShared("Teleport")
local WalkspeedManager = GetShared("WalkspeedManager")

-- || GAME VARIABLES ||
SetGlobal("getting Workspace child paths")
local Camera = ReturnChild(Workspace, "Camera")
local Mobs = ReturnChild(Workspace, "Mobs")
local MissionObjects

-- || SCRIPT VARIABLES ||
SetGlobal("setting up script dependencies")
local Library
local SaveManager
local Options
local Toggles
local ScriptUnloaded
local SV = {}
SV.Drops = {}
local ISV = {}
ISV.MobTable = {}
local ConnectionTable = {}
local AvoidMobs = {}
local TeleportParts = {}
local StatTotals = {}
local AntiCheatNumber = 67
local Class
local ClassSkills
local PetSkills
local LocalPlayer = Players.LocalPlayer
local PlayerName = LocalPlayer.Name
local PlayerID = LocalPlayer.UserId
local PlayerGui = ReturnChild(LocalPlayer, "PlayerGui")
local PlayerPing = 0
local PlayerProfile
local ProfileInventory
local PlayerCharacter
local PlayerCollider
local PlayerRoot
local AddedDelay = 0
local Xdistance = 0
local Ydistance = 0
local TempStop
local HoldForRealTime
local RestartAtFloor = 200
local CurrentMob
local IsMobCamera
local KillSwitch
local KeepTier = 5
local SellItemCheck = 0
local OffsetMax = 0
local EquipInProgress = 0
local MobRotationSpeed = 20
local DelayPetAttacks
local IsAliveMobs = 0
local DiscordPingType = "@everyone"
local TeleportMob
local StuckDelay = 60
local DelayAttacks
local IsBoss
local EventOverride
local CanTarget = true
local PingMultiplier = 1
local PlayerStandPart = nil
local StandPartHeight = nil

do
    local function BindCharacter(Character)
        PlayerCharacter = Character
        PlayerRoot = nil
        PlayerCollider = nil
        task.spawn(function()
            local Root = Character:WaitForChild("HumanoidRootPart", math.huge)
            local Collider = Character:WaitForChild("Collider", math.huge)
            if PlayerCharacter == Character and LocalPlayer.Character == Character then
                PlayerRoot = Root
                PlayerCollider = Collider
                print("[WZF][CHAR] ready; job:", game.JobId)
            end
        end)
    end
    ConnectionTable["ConnectNewCharacter"] = LocalPlayer.CharacterAdded:Connect(BindCharacter)
    ConnectionTable["WZFCharacterRemoving"] = LocalPlayer.CharacterRemoving:Connect(function(Character)
        if PlayerCharacter == Character then
            PlayerCharacter, PlayerRoot, PlayerCollider = nil, nil, nil
        end
    end)
    if LocalPlayer.Character then BindCharacter(LocalPlayer.Character) end
end

SetGlobal("setting up auto execute")
if EF.Queue then
    local FileName = "JDRS/AutoExecute"
    if isfile(FileName) then
        EF.Queue([[loadstring(game:HttpGet("https://raw.githubusercontent.com/k27432179/WorldZero-Fix/wzf-test/t"))()]])
        SV.AlreadyQueued = true
    end
end

SetGlobal("identify bad executor")
if (EF.ExecutorName == "Xeno" or EF.ExecutorName == "Solara" or EF.ExecutorName == "Velocity") then
    SV.BadExecutor = true
end

SetGlobal("checking for tabs to skip loading")
do
    local FileName = "JDRS/SkipTabs"
    if isfile(FileName) and isfile("JDRS/saved_configs/settings/autoload.txt") then
        for Index, Tab in pairs(HttpService:JSONDecode(readfile(FileName))) do
            SV[Tab] = true
        end
    end
end

-- || IDENTIFY LOCATION ||
SetGlobal("setting up location identifier")
local StringPlaceID = tostring(game.PlaceId)
local IsWorld = false
local IsMainMenu = false
local IsDungeon = false
local IsTower = false

local Locations = {
    MainMenu = {
        ["2727067538"] = true -- main menu
    },
    WorldHubs = {
        ["4310463616"] = true, -- world 1
        ["4310463940"] = true, -- world 2
        ["4465987684"] = true, -- world 3
        ["4646472003"] = true, -- world 4
        ["5703355191"] = true, -- world 5
        ["6075083204"] = true, -- world 6
        ["6847035264"] = true, -- world 7
        ["9944262922"] = true, -- world 8
        ["10651517727"] = true, -- world 9
        ["14914684761"] = true, -- world 10
        ["7499964980"] = true, -- market
        ["6510868181"] = true, -- pvp
        ["139316833473171"] = true, -- guild hub
        ["105045973347410"] = true, -- guild hall
        ["87656507991995"] = true, -- valentines hub
        ["100868012981049"] = true, -- easter hub
        ["18567064955"] = true, -- vane hub
        ["125645867930579"] = true, -- kraken hub
        ["5862275930"] = true, -- halloween hub
        ["4526768266"] = true, -- holiday hub
        ["111346137875750 "] = true, -- market house
        ["73832225581864"] = true, -- w1 house
        ["84106607802351"] = true, -- w2 house
        ["136326194224398"] = true, -- w3 house
        ["73334696605120"] = true, -- w7 house
        ["104886402902960"] = true -- og world 1
    },
    Dungeons = {
        ["107701891477606"] = 49, -- 1-1 tutorial
        ["83712338696299"] = 54, -- chad tutorial
        ["2978696440"] = 1, -- 1-1
        ["4310476380"] = 3, -- 1-2
        ["4310464656"] = 2, -- 1-3
        ["4310478830"] = 4, -- 1-4
        ["3383444582"] = 6, -- 1-5
        ["3885726701"] = 11, -- 2-1
        ["3994953548"] = 12, -- 2-2
        ["4050468028"] = 13, -- 2-3
        ["3165900886"] = 7, -- 2-4
        ["4465988196"] = 14, -- 3-1
        ["4465989351"] = 15, -- 3-2
        ["4465989998"] = 16, -- 3-3
        ["4646473427"] = 20, -- 4-1
        ["4646475342"] = 19, -- 4-2
        ["4646475570"] = 18, -- 4-3
        ["6386112652"] = 24, -- 5-1
        ["11466514043"] = 35, -- 5-2
        ["6510862058"] = 25, -- 6-1
        ["11533444995"] = 36, -- 6-2
        ["6847034886"] = 26,  -- 7-1
        ["11644048314"] = 37, -- 7-2
        ["9944263348"] = 30, -- 8-1
        ["10014664329"] = 31, -- 8-2
        ["10651527284"] = 32, -- 9-1
        ["10727165164"] = 33, -- 9-2
        ["14914700740"] = 41, -- 10-1
        ["14914855930"] = 42, -- 10-2
        ["128961185668563"] = 53 -- heavenly raid
    },
    EventDungeons = {
        ["93889085342251"] = 51, -- graffiti beach
        ["102111805987017"] = 47, -- hunt 2025
        ["81373988789544"] = 46, -- cupid arena
        ["109614960834199"] = 50, -- alien invasion arena
        ["138178936582742"] = 48, -- zero arena
        ["110769392907898"] = 52, -- easter arena
        ["75540798045662"] = 45, -- kraken arena
        ["18567068844"] = 44, -- vane arena
        ["5862277651"] = 22, -- fallen anrea
        ["4526768588"] = 17 -- klaus arena
    },
    Towers = {
        ["5703353651"] = 21, -- tower 1
        ["6075085184"] = 23, -- tower 2
        ["7071564842"] = 27, -- tower 3
        ["10089970465"] = 29, -- tower 4
        ["10795158121"] = 34, -- tower 5
        ["15121292578"] = 43, -- tower 6
        ["14400549310"] = 39, -- celestial tower
        ["13988110964"] = 38 -- infinite tower
        --["130171241672058"] = 56 -- og tower
    }
}
if Locations.MainMenu[StringPlaceID] then
    IsMainMenu = true
    print("JDRS: player in main menu")
elseif Locations.WorldHubs[StringPlaceID] then
    IsWorld = true
    print("JDRS: player in lobby")
elseif Locations.Dungeons[StringPlaceID] then
    IsDungeon = true
    print("JDRS: player in dungeon")
elseif Locations.Towers[StringPlaceID] then
    IsDungeon = true
    IsTower = true
    print("JDRS: player in tower")
elseif Locations.EventDungeons[StringPlaceID] then
    IsEventDungeon = true
    IsDungeon = true
    print("JDRS: player is in event dungeon")
else
    IsWorld = true
    print("JDRS: cannot determine where player is located... placeid: " ..StringPlaceID)
end

-- || FIND CURRENT DUNGEON AND DELETE TABLE ||
if not (IsWorld or IsMainMenu) then
    ISV.CurrentDungeonID = Locations.EventDungeons[StringPlaceID] or Locations.Dungeons[StringPlaceID] or Locations.Towers[StringPlaceID] or nil
end
Locations = nil

SetGlobal("request message")
local function RequestMessage(WebsiteLink, MessageContent, HighRiskRequest)
    if not WebsiteLink and not HighRiskRequest then
        warn("No webhook link provided")
        return
    end
    if not EF.SendRequest then
        return
    end
    EF.SendRequest({
        Url = WebsiteLink,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = HttpService:JSONEncode(MessageContent)
    })
end

SetGlobal("save error to file")
local function SaveErrorToFile(ErrorLocation, ErrorMessage, ExtraInfo)
    if ISV.TeleportingToAnotherServer then
        return
    end
    ErrorLocation = tostring(ErrorLocation)
    ErrorMessage = tostring(ErrorMessage)
    ExtraInfo = tostring(ExtraInfo)
    local ErrorFileName = "JDRS_script_error.txt"
    appendfile(ErrorFileName, string.format(
        "Error: %*\nLocation: %*Extra info: %*\nDate: %*\n\n",
        ErrorMessage, ErrorLocation, ExtraInfo, os.date()
    ))
    MakeErrorGui(ErrorLocation, ErrorMessage, ExtraInfo, nil)
end

SetGlobal("identifying executor")
do
    local Success, Result = pcall(function()
        print("JDRS: player is using", EF.ExecutorName, EF.ExecutorVersion)
    end)
    if not Success then
        if not EF.GetExecutor then
            print("JDRS: couldn't identify executor, identity function missing.")
        else
            print("JDRS: couldn't identify executor,", Result)
        end
    end
end

SetGlobal("setting up ignore file download dates")
do
    local Success, Result = pcall(function()
        local FileName = "JDRS/ignore/DD"
        if not isfile(FileName) then
            writefile(FileName, HttpService:JSONEncode(
                {
                    P = { T = os.clock(), V = 0 },
                    L = { T = os.clock(), V = 0 },
                    C = { T = os.clock(), V = 0 },
                    S = { T = os.clock(), V = 0 }
                }
            ))
        end
    end)
    if not Success then
        SaveErrorToFile("FILE DATA", Result)
    end
end

SetGlobal("save script to files")
local function SaveScriptToFiles(Link, File, Version, DeleteFile)
    local FileData
    local Success, Result = pcall(function()
        if isfile and writefile and readfile then
            local DownloadDates = HttpService:JSONDecode(readfile("JDRS/ignore/DD"))
            local FileName = "JDRS/ignore/" ..File
            if DeleteFile and isfile(FileName) then
                delfile(FileName)
            end

            if not isfile(FileName) then
                repeat
                    local Downloaded, DownloadError = pcall(function()
                        writefile(FileName, game:HttpGet(Link))
                    end)
                    if not DownloadError then
                        DownloadDates[File].T = os.time()+86400
                        DownloadDates[File].V = Version
                        writefile("JDRS/ignore/DD", HttpService:JSONEncode(DownloadDates))
                        break
                    end
                    warn("writefile() failed or data was corrupted, trying again in 2 seconds\nReason: " ..tostring(DownloadError))
                    task.wait(2)
                until ScriptUnloaded or KillSwitch
            end

            if isfile(FileName) then
                local FileReference = DownloadDates[File]
                if FileReference.T > os.time() and FileReference.V == Version then
                    local Downloaded, DownloadError = pcall(function()
                        FileData = loadstring(readfile(FileName))()
                    end)
                    if not FileData or (FileData and (FileData == "")) then
                        warn("failed to read file, possibly corrupted. Redownloading\nReason: " ..tostring(DownloadError))
                        FileData = SaveScriptToFiles(Link, File, Version, true)
                    end
                else
                    FileData = SaveScriptToFiles(Link, File, Version, true)
                end
            end
        else
            FileData = loadstring(game:HttpGet(Link))()
        end
    end)
    if not Success then
        SaveErrorToFile("FILE MANAGER", Result, File)
    end
    task.wait()
    return FileData
end

SetGlobal("creating script tables")
SV.DungeonPartList = {
    { "MissionStart", DescendantCheck = true },
    DeleteParts = {
        { "MissionObjects", "DamageDroppers" }, { "TeleportSystem", MultipleExists = true }, { "MissionObjects", "FallAreas" }
    }
}
SV.WheelItems = {
    "WebbedWings", "WispLantern", "CrowKing", "CrowQueen", "CastingShadow",
    "AstralHorns", "DreamCatcherHalo", "SpiderCrown"
}
SV.SpecialHexColors = {
	"ffffff", "000000", "e6e6e6", "1e1e1e", "d4af37",
    "ff1337", "11ccee", "ffaabb", "ddeadd", "dec0de",
    "b00000", "bbaadd", "c0aa11", "00bdae", "55eeaa",
    "ffaded", "beeeee", "ffaaee", "ac11dd", "acce55",
    "ff0011", "decade", "deeeed", "deeee1", "b1a2ed",
    "aaaaaa"
}
SV.EggList = {
    'StarEgg', 'JungleEgg', 'CrystalEgg', 'ChristmasEgg', 'DesertEgg',
    'MoltenEgg', 'OceanEgg', 'SkyEgg', 'CatEgg', 'CatEggHalloween',
    'AlligatorEgg', 'FairyEgg', 'AetherEgg', 'CabbageEgg', 'SkeletonEgg',
    'CupidEgg', 'SlimeEgg', 'TeddyEgg', 'SantaEgg', 'ArcaneEgg',
    'GhostEgg', 'PenguinEgg', 'RobloxEventEggHatchable', 'GoldenEgg', 'MiseryEgg',
    'BunnyEgg', 'RheaEgg', "SuperCrystalEgg", "SuperDesertEgg", "SuperFairyEgg",
    "SuperStarEgg", "SuperMoltenEgg", "VoidEgg", "SuperArcaneEgg", "EasterPetEgg",
    "SuperSkyEgg", "SuperAlligatorEgg", "SuperOceanEgg", "SuperJungleEgg"
}
SV.TowerEggList = {
    ["MoltenEgg"] = true,
    ["OceanEgg"] = true,
    ["SkyEgg"] = true,
    ["AlligatorEgg"] = true,
    ["FairyEgg"] = true,
    ["ArcaneEgg"] = true
}
SV.DungeonListTable = {
    { Level = 175, DungeonName = "Nightmare Portal", DungeonDelay = 60, DungeonID = 1005 },
    { Level = 135, DungeonName = "Astral Academy", DungeonDelay = 135, DungeonID = 42, SpecialPerk = true },
    { Level = 130, DungeonName = "Crystal Chaos", DungeonDelay = 115, DungeonID = 41, SpecialPerk = true },
    { Level = 120, DungeonName = "Aether Fortress", DungeonDelay = 45, DungeonID = 33 },
    { Level = 115, DungeonName = "Treetop Trouble", DungeonDelay = 90, DungeonID = 32 },
    { Level = 105, DungeonName = "Ruin Rush", DungeonDelay = 65, DungeonID = 31, SpecialPerk = true },
    { Level = 100, DungeonName = "Rescue in the Ruins", DungeonDelay = 78, DungeonID = 30, SpecialPerk = true },
    { Level = 95, DungeonName = "The Labyrinth", DungeonDelay = 20, DungeonID = 37 },
    { Level = 90, DungeonName = "The Underworld", DungeonDelay = 85, DungeonID = 26 },
    { Level = 80, DungeonName = "Treasure Hunt", DungeonDelay = 36, DungeonID = 36, SpecialPerk = true },
    { Level = 75, DungeonName = "Rough Waters", DungeonDelay = 55, DungeonID = 25, SpecialPerk = true },
    { Level = 65, DungeonName = "Konoh Inferno", DungeonDelay = 40, DungeonID = 35 },
    { Level = 60, DungeonName = "Konoh Heartlands", DungeonDelay = 45, DungeonID = 24 },
    { Level = 55, DungeonName = "Pyramid Dungeon", DungeonDelay = 40, DungeonID = 18 },
    { Level = 50, DungeonName = "Deserted Burrowmine", DungeonDelay = 40, DungeonID = 19 },
    { Level = 45, DungeonName = "Scrap Canyon", DungeonDelay = 50, DungeonID = 20 },
    { Level = 40, DungeonName = "Winter Dungeon", DungeonDelay = 60, DungeonID = 16, SpecialPerk = true },
    { Level = 35, DungeonName = "Winter Cavern", DungeonDelay = 20, DungeonID = 15, SpecialPerk = true },
    { Level = 30, DungeonName = "Mountain Pass", DungeonDelay = 35, DungeonID = 14, SpecialPerk = true },
    { Level = 26, DungeonName = "Volcano Dungeon", DungeonDelay = 40, DungeonID = 7, SpecialPerk = true },
    { Level = 22, DungeonName = "Volcano's Shadow", DungeonDelay = 59, DungeonID = 13, SpecialPerk = true },
    { Level = 18, DungeonName = "Mama Trauma", DungeonDelay = 35, DungeonID = 12, SpecialPerk = true },
    { Level = 15, DungeonName = "Temble of Ruin", DungeonDelay = 33, DungeonID = 11, SpecialPerk = true },
    { Level = 12, DungeonName = "Gravetower Dungeon", DungeonDelay = 45, DungeonID = 6 },
    { Level = 10, DungeonName = "Kingslayer", DungeonDelay = 32, DungeonID = 4 },
    { Level = 7, DungeonName = "Dire Problem", DungeonDelay = 15, DungeonID = 2 },
    { Level = 4, DungeonName = "Scarecrow Defense", DungeonDelay = 20, DungeonID = 3 },
    { Level = 1, DungeonName = "Crabby Crusade", DungeonDelay = 20, DungeonID = 1 },
    { Level = 0, DungeonName = "Celestial Tower", DungeonDelay = 580, DungeonID = 39 },
    { Level = 0, DungeonName = "Arcane Tower", DungeonDelay = 320, DungeonID = 43 },
    { Level = 0, DungeonName = "Aether Tower", DungeonDelay = 270, DungeonID = 34 },
    { Level = 0, DungeonName = "Oasis Tower", DungeonDelay = 280, DungeonID = 29 },
    { Level = 0, DungeonName = "Mezuvian Tower", DungeonDelay = 270, DungeonID = 27 },
    { Level = 0, DungeonName = "Atlantis Tower", DungeonDelay = 279, DungeonID = 23 },
    { Level = 0, DungeonName = "Prison Tower", DungeonDelay = 240, DungeonID = 21 },
    { Level = 0, DungeonName = "Infinite Tower", DungeonDelay = 0, DungeonID = 38 }
}

SetGlobal("creating script function")

SetGlobal("check for character")
local function CheckForCharacter(TimeStarted)
    if not PlayerCharacter then
        repeat task.wait() until PlayerCharacter
    end
    if not PlayerRoot then
        repeat task.wait() until PlayerRoot
    end
    if not PlayerCollider then
        repeat task.wait() until PlayerCollider
    end
    return TimeStarted
end

local function CombatCharacterReady()
    return PlayerCharacter ~= nil and LocalPlayer.Character == PlayerCharacter
        and PlayerRoot ~= nil and PlayerRoot.Parent == PlayerCharacter
        and PlayerCollider ~= nil and PlayerCollider.Parent == PlayerCharacter
end
SetGlobal("format number")
local function FormatNumber(n)
    n = tostring(n)
    return n:reverse():gsub("...","%0,",math.floor((#n-1)/3)):reverse()
end

SetGlobal("format decimal")
local function FormatDecimal(decimal)
	return tonumber(string.format("%.2f", decimal))
end

SetGlobal("get percentage")
local function GetPercentage(initial, current)
	return (current/initial)*100
end

SetGlobal("seconds to string")
local function SecondsToString(seconds)
    local StartingSeconds = seconds
    local days = math.floor(seconds / 86400)
    local hours = math.floor(seconds % 86400 / 3600)
    local minutes = math.floor(seconds % 3600 / 60)
    seconds = math.floor(seconds % 60)
    if StartingSeconds < 60 then
        return tostring(math.floor(StartingSeconds)).. "s"
    elseif StartingSeconds < 3600 then
        return string.format("%d:%02d", minutes, seconds)
    elseif StartingSeconds < 86400 then
        return string.format("%d:%02d:%02d", hours, minutes, seconds)
    else
        return string.format("%d:%02d:%02d:%02d", days, hours, minutes, seconds)
    end
end

SetGlobal("is mission over")
local function IsMissionOver()
    return Workspace:GetAttribute("MissionCleared") or false
end

SetGlobal("check for avoid mobs")
local function CheckForAvoidMobs()
    if IsDungeon and not SV.CanRequire then
        local Success, Result = pcall(function()
            local GetPartyData = Remotes:WaitForChild("Party_GetPartyData", math.huge):InvokeServer()
            SV.PartyRaidID = GetPartyData.RaidID.Value
            if SV.PartyRaidID == 1 then AvoidMobs["BOSSDireBoarwolf"] = true; AvoidMobs["BOSSTreeEnt"] = true end -- World 1
            if SV.PartyRaidID == 20 then AvoidMobs["BOSSAnubis"] = true; AvoidMobs["BOSSHogRider"] = true end -- World 4
            if SV.PartyRaidID == 22 then AvoidMobs["BOSSFallenKing"] = true end -- The Fallen Throne
            if SV.PartyRaidID == 24 then AvoidMobs["CorruptedGreaterTree"] = true end -- World 5
            if SV.PartyRaidID == 25 then AvoidMobs["BOSSKrakenMain"] = true; AvoidMobs["DavyJones"] = true; AvoidMobs["Nautilus"] = true; AvoidMobs["PirateCrab"] = true end -- World 6
            if SV.PartyRaidID == 26 then AvoidMobs["HadesCerberus"] = true; AvoidMobs["SentryOfCerberus"] = true; AvoidMobs["MinotaurDungeonBoss"] = true end -- World 7
            if SV.PartyRaidID == 28 then AvoidMobs["BOSSEvilSanta"] = true end -- North Pole 
            if SV.PartyRaidID == 32 then AvoidMobs["RustyCommander"] = true; AvoidMobs["AetherKing"] = true end -- World 9
            if SV.PartyRaidID == 41 then AvoidMobs["MiniBossCrystalWeaver"] = true; AvoidMobs["DungeonBOSSCrystalWolf"] = true; AvoidMobs["BOSSKandrix"] = true end -- World 10
            if SV.PartyRaidID == 44 then AvoidMobs["EVENTBOSSVane"] = true; AvoidMobs["BOSSDarkriseDarkDragon"] = true end -- Vane's Lair
            if SV.PartyRaidID == 45 then AvoidMobs["EVENTBOSSKraken"] = true; AvoidMobs["EVENTBOSSDavyJones"] = true end -- The Depths
            if SV.PartyRaidID == 46 then AvoidMobs["EVENTBOSSCupid"] = true end -- Cradle of Hearts
        end)
        if not Success then
            SaveErrorToFile("BOSS MOBS", Result)
        end
    else
        AvoidMobs = nil
    end
end

SetGlobal("check player ping")
local function CheckPlayerPing()
    local Success, Result = pcall(function()
        while not KillSwitch do
            if PingMultiplier ~= 0 then
                PlayerPing = LocalPlayer:GetNetworkPing() * PingMultiplier
            else
                PlayerPing = 0
            end
            task.wait(1)
        end
    end)
    if not Success then
        SaveErrorToFile("PLAYER PING", Result)
    end
end

SetGlobal("create hook on function")
local function CreateHookOnFunction(Function, Enabled)
    if Enabled then
        EF.Hook(Function, EF.NewClosure(function()
            return
        end))
    else
        if EF.CheckHook(Function) then
            EF.ClearHook(Function)
        end
    end
end

SetGlobal("mob scanner")
local function MobScanner()
    SV.WZFScannerState = "waiting-character"
    CheckForCharacter()
    SV.WZFScannerState = "initializing"
    if not IsMainMenu then
        if SV.CanRequire and EF.Hook and EF.NewClosure then
            local PlayerRemover = require(SMobs:WaitForChild("PlayerRemover", math.huge))
            CreateHookOnFunction(PlayerRemover.AddMobToSearch, true)
            for Index, Mob in Mobs:GetChildren() do
                PlayerRemover:RemoveMobFromSearch(Mob)
            end
        end
    end
    if IsDungeon then
        local Success, Result = pcall(function()
            local FakeSpawnParts = {
                ["DireBridgeSpawn"] = true,
                ["DireBoulderSpawn"] = true,
                ["DireCaveSpawn"] = true,
                ["FakeKingSpawn"] = true,
                ["BridgeMama"] = true,
                ["CerberusSpawn1"] = true,
                ["CerberusSpawn2"] = true,
                ["FakeBoss"] = true,
                ["FakeBossSpawn"] = true
            }
            local FakeMobs = {
                ["Fake"] = true
            }
            local PriorityMobs = {
                ["EVENTBOSSEasterBunny"] = true,
                ["EVENTBOSSEasterBunnyEnraged"] = true,
                ["BabyWinterfall"] = true,
                ["BabyIgnis"] = true,
                ["BOSSSeraphiel"] = true
            }
            local ShrinkCollider = {
                ["CorruptedGreaterTree"] = Vector3.new(1, 1, 1),
                ["BOSSCrystalGolem"] = Vector3.new(52, 30, 52),
                ["EVENTBOSSZeroGuardian"] = Vector3.new(52, 30, 52),
                ["Crystal"] = Vector3.new(25, 20, 25),
                ["KrakenArm"] = Vector3.new(17, 25, 17),
                ["EVENTBOSSKrakenArm-Arm#1"] = Vector3.new(17, 25, 17),
                ["EVENTBOSSKrakenArm-Arm#2"] = Vector3.new(17, 25, 17),
                ["EVENTBOSSKrakenArm-Arm#3"] = Vector3.new(17, 25, 17),
                ["EVENTBOSSKrakenArm-Arm#4"] = Vector3.new(17, 25, 17),
                ["EVENTBOSSKrakenArm-Arm#5"] = Vector3.new(17, 25, 17),
                ["EVENTBOSSKrakenArm-Arm#6"] = Vector3.new(17, 25, 17),
                ["EVENTBOSSKrakenArm-Arm#7"] = Vector3.new(17, 25, 17),
                ["EVENTBOSSKrakenArm-Arm#8"] = Vector3.new(17, 25, 17)
            }
            local DelayBosses = {
                ["BOSSTreeEnt"] = true,
                ["HadesCerberus"] = true,
                ["EVENTBOSSEasterBunny"] = true
            }
            local DontAttackBosses = {
                ["BOSSKrakenMain"] = true,
                ["AlienMothership"] = true,
                ["AlienUFO"] = true
            }
            local Summons = {
                ["SummonerSummonWeak"] = true,
                ["SummonerSUmmonStrong"] = true,
                ["NecromancerSummon"] = true,
                ["EvilClown"] = true
            }
            local Blockers = {
                ["Pillar1"] = true, -- 1-5 blocker
                ["Pillar2"] = true, -- 1-5 blocker
                ["Pillar3"] = true, -- 1-5 blocker
                ["IceBarricade"] = true, -- 3-2 blocker
                ["Blocker1"] = true, -- 3-3 blocker
                ["Blocker2"] = true, -- 3-3 blocker
                ["Blocker3"] = true, -- 3-3 blocker
                ["Model"] = true, -- 4-1 blockers
                ["Crystal"] = true, -- tower 6 blockers
                ["EasterGiantEgg"] = true, -- easter boss blocker
                ["1"] = true, -- chad tutorial 
                ["AngelSculpture"] = true, -- heavenly boss heal
                ["SwordOfDecree"] = true, -- heavenly boss sword
                ["FallenClock"] = true -- falllen queen thing

            }
            ConnectionTable["MobInvincibilityUpdate"] = Remotes:WaitForChild("Mobs_InvincibilityUpdated", math.huge).OnClientEvent:Connect(function(Mob, Value)
                local UpdateInvincibility
                local AllocatedLoadTime = time() + 5
                repeat
                    if time() > AllocatedLoadTime then
                        break
                    end
                    UpdateInvincibility = ISV.MobTable[Mob]
                    task.wait()
                until UpdateInvincibility
                if UpdateInvincibility then
                    if Value then
                        UpdateInvincibility.Invincible = true
                    else
                        UpdateInvincibility.Invincible = false
                    end
                end
            end)
            if SV.CanRequire then
                local rMob = require(SMobs)
                local BigNumber = math.huge
                local function ValidMob(Mob, MobName)
                    local IsDebug = ISV.Debug
                    IsAliveMobs += 1
                    if Mob.Parent and Mob.Parent == Workspace.Characters then
                        if IsDebug then
                            warn("JDRS:", Mob, "(is a player)")
                        end
                        IsAliveMobs -= 1
                        return
                    end
                    if not MobName then
                        MobName = Mob.Name
                    end
                    if FakeMobs[MobName] then
                        if IsDebug then
                            warn("JDRS:", Mob, "(fake mob)")
                        end
                        IsAliveMobs -= 1
                        return
                    end
                    if Blockers[MobName] then
                        local BlockerHitbox = Mob:FindFirstChild("Part") or Mob:FindFirstChild("Base") or Mob:FindFirstChild("hitbox") or Mob:FindFirstChild("Hitbox") or Mob:FindFirstChild("EasterGiantEgg") or Mob:FindFirstChild("Collider") or Mob:FindFirstChild("HumanoidRootPart")
                        if not BlockerHitbox then
                            if IsDebug then
                                warn("JDRS:", MobName, "(blocker has no target part)")
                            end
                            IsAliveMobs -= 1
                            return
                        end
                        BlockerHitbox.Name = "Collider"
                        ISV.MobTable[Mob] = {IsBlocker = true}
                        if IsDebug then
                            print("JDRS:", MobName, "(added, blocker)")
                        end
                        return
                    end
                    if Mob.Parent then
                        local MobData
                        local AllocatedLoadTime = time()+5
                        repeat
                            if time() > AllocatedLoadTime then
                                if ISV.Debug then
                                    warn("JDRS:", MobName, "(exceeded load time)")
                                end
                                break
                            end
                            MobData = rMob:GetMobData(Mob)
                            task.wait()
                        until MobData

                        if MobData and (MobData.IsHunterPet or MobData.CanAttackMobs or MobData.CanAttackEntities) then
                            if IsDebug then
                                warn("JDRS:", MobName, "(familiar or summon)")
                            end
                            IsAliveMobs -= 1
                            return
                        end

                        if SV.IsRanged then
                            if MobData then
                                MobData.Collider.Size = MobData.Collider.Size/2
                            else
                                local MobCollider = Mob:WaitForChild("Collider", 5)
                                if MobCollider then
                                    MobCollider.Size = MobCollider.Size/2
                                end
                            end
                        end

                        if DelayBosses[MobName] then
                            if IsDebug then
                                print("JDRS:", MobName, "(prevent stuck)")
                            end
                            task.wait(1)
                        end

                        if PriorityMobs[MobName] then
                            ISV.MobTable[Mob] = {Priority = true}
                            if IsDebug then
                                print("JDRS:", MobName, "(added, priority)")
                            end
                            return
                        end
                        if MobData then
                            if MobData.Invincible then
                                ISV.MobTable[Mob] = {Invincible = true}
                                if IsDebug then
                                    print("JDRS:", MobName, "(added, invincible)")
                                end
                            else
                                ISV.MobTable[Mob] = {}
                                if IsDebug then
                                    print("JDRS:", MobName, "(added)")
                                end
                            end
                        else
                            ISV.MobTable[Mob] = {NoData = true}
                            if IsDebug then
                                print("JDRS:", MobName, "(added, no mob data)")
                            end
                        end
                    else
                        if IsDebug then
                            warn("JDRS:", MobName, "(didn't add, no parent)")
                        end
                        IsAliveMobs -= 1
                        return
                    end
                end
                ConnectionTable["ConnectMobCreated"] = Remotes:WaitForChild("Health_InstanceAdded").OnClientEvent:Connect(function(Mob)
                    repeat task.wait() until Mob.Parent ~= ReplicatedStorage
                    ValidMob(Mob)
                end)
                ConnectionTable["ConnectMobDied"] = Remotes:WaitForChild("Mobs_MobDied", math.huge).OnClientEvent:Connect(function(Name, Mob)
                    local CheckTable = ISV.MobTable[Mob]
                    if CheckTable then
                        ISV.MobTable[Mob] = nil
                        IsAliveMobs -= 1
                        if ISV.Debug then
                            warn("JDRS:", Name, "(died)")
                        end
                    end
                end)
                for Index, Mob in Mobs:GetChildren() do
                    ValidMob(Mob)
                end
                SV.WZFScannerState = "running"
                while not KillSwitch do
                    SV.WZFScannerTick = os.clock()
                    if not CombatCharacterReady() then
                        CurrentMob, TeleportMob = nil, nil
                        task.wait(.1)
                        continue
                    end
                    if not CanTarget then
                        CurrentMob = nil
                        task.wait()
                        continue
                    end

                    local TableReference = ISV.MobTable
                    local ClosestMob = nil
                    local ClosestMobDistance = BigNumber
                    local ClosestAvoidMob = nil
                    local ClosestAvoidDistance = BigNumber
                    local ClosestNoData = nil
                    local MobPriority = nil
                    for Mob, AddedTable in TableReference do
                        if not Mob then
                            continue
                        end
                        if not Mob.Parent then
                            if ISV.Debug then
                                warn("JDRS:", Mob.Name, "(no parent)")
                            end
                            TableReference[Mob] = nil
                            IsAliveMobs -= 1
                            continue
                        end
                        local HealthProperties = Mob:FindFirstChild("HealthProperties")
                        local Health = HealthProperties and HealthProperties:FindFirstChild("Health")
                        if Health and Health.Value == 0 then
                            if ISV.Debug then
                                warn("JDRS:", Mob.Name, "(zero health)")
                            end
                            TableReference[Mob] = nil
                            IsAliveMobs -= 1
                            continue
                        end
                        if AddedTable.IsBlocker then
                            ClosestMob = Mob
                            break
                        end
                        local MobData = rMob:GetMobData(Mob)
                        if AddedTable.NoData then
                            if MobData then
                                AddedTable.NoData = nil
                            else
                                ClosestNoData = Mob
                            end
                        end
                        if AddedTable.Priority then
                            if MobData and not MobData.Invincible then
                                MobPriority = true
                                ClosestMob = Mob
                                continue
                            else
                                continue
                            end
                        end
                        if MobPriority then
                            continue
                        end
                        if not MobData then
                            local MobCollider = Mob:FindFirstChild("Collider")
                            if MobCollider then
                                MobData = {Collider = MobCollider}
                            else
                                continue
                            end
                        end
                        if not MobData.Invincible then
                            local Root = PlayerRoot
                            local Collider = MobData.Collider or Mob:FindFirstChild("Collider")
                            if not CombatCharacterReady() or not Collider or not Collider.Parent then continue end
                            local MobDistance = (Collider.Position - Root.Position).Magnitude
                            if not MobData.BossTag then
                                if MobDistance < ClosestMobDistance then
                                    ClosestMob = Mob
                                    ClosestMobDistance = MobDistance
                                end
                            else
                                if MobDistance < ClosestAvoidDistance then
                                    ClosestAvoidMob = Mob
                                    ClosestAvoidDistance = MobDistance
                                end
                            end
                        end
                    end
                    TeleportMob = ClosestMob or ClosestAvoidMob or ClosestNoData
                    if ClosestMob then
                        IsBoss = false
                        CurrentMob = ClosestMob
                    elseif ClosestAvoidMob then
                        IsBoss = true
                        CurrentMob = ClosestAvoidMob
                    elseif ClosestNoData then
                        CurrentMob = ClosestNoData
                    else
                        CurrentMob = nil
                    end
                    task.wait()
                end
            else
                PriorityMobs["BOSSSeraphiel"] = nil
                for _, CheckForRuins in SV.Parties:GetChildren() do
                    if CheckForRuins:WaitForChild("RaidID").Value == 30 then
                        FakeSpawnParts["Part"] = true
                    end
                end
                local function ValidMob(Mob, MobName)
                    local IsDebug = ISV.Debug
                    IsAliveMobs += 1
                    if Mob.Parent and Mob.Parent == Workspace.Characters then
                        if IsDebug then
                            warn("JDRS:", Mob, "(is a player)")
                        end
                        IsAliveMobs -= 1
                        return
                    end
                    if not MobName then
                        MobName = Mob.Name
                    end
                    if FakeMobs[MobName] then
                        if IsDebug then
                            warn("JDRS:", Mob, "(fake mob)")
                        end
                        IsAliveMobs -= 1
                        return
                    end
                    if Blockers[MobName] then
                        local BlockerHitbox = Mob:FindFirstChild("Part") or Mob:FindFirstChild("Base") or Mob:FindFirstChild("hitbox") or Mob:FindFirstChild("Hitbox") or Mob:FindFirstChild("EasterGiantEgg") or Mob:FindFirstChild("Collider")
                        if not BlockerHitbox then
                            return
                        end
                        BlockerHitbox.Name = "Collider"
                        ISV.MobTable[Mob] = {IsBlocker = true}
                        if IsDebug then
                            print("JDRS:", MobName, "(added, blocker)")
                        end
                        return
                    end
                    if Mob.Parent then
                        if Summons[MobName] then
                            if IsDebug then
                                warn("JDRS:", MobName, "(summon)")
                            end
                            IsAliveMobs -= 1
                            return
                        end
                        if DontAttackBosses[MobName] then
                            if IsDebug then
                                warn("JDRS:", MobName, "(bad boss)")
                            end
                            IsAliveMobs -= 1
                            return
                        end
                        local FromSpawnPart = Mob:WaitForChild("FromSpawnPart", 2)
                        if FromSpawnPart and FromSpawnPart.Value and FakeSpawnParts[tostring(FromSpawnPart.Value)] then
                            if IsDebug then
                                warn("JDRS:", MobName, "(fake mob)")
                            end
                            IsAliveMobs -= 1
                            return
                        end
                        local MobProperties = Mob:WaitForChild("MobProperties", 2)
                        local Owner = MobProperties and MobProperties:WaitForChild("Owner", 2)
                        if Owner and Owner.Value then
                            if IsDebug then
                                warn("JDRS:", MobName, "(familiar)")
                            end
                            IsAliveMobs -= 1
                            return
                        end
                        local ShrinkMob = ShrinkCollider[MobName]
                        if ShrinkMob then
                            local MobCollider = Mob:WaitForChild("Collider", 2)
                            if MobCollider then
                                MobCollider.Size = ShrinkMob
                            end
                        end
                        if DelayBosses[MobName] then
                            task.wait(1)
                        end
                        if PriorityMobs[MobName] then
                            ISV.MobTable[Mob] = {Priority = true}
                            if IsDebug then
                                print("JDRS:", MobName, "(priority)")
                            end
                            return
                        end
                        ISV.MobTable[Mob] = {}
                        if IsDebug then
                            print("JDRS:", MobName, "(added)")
                        end
                    end
                end
                ConnectionTable["ConnectMobCreated"] = Remotes:WaitForChild("Health_InstanceAdded").OnClientEvent:Connect(function(Mob)
                    repeat task.wait() until Mob.Parent ~= ReplicatedStorage
                    ValidMob(Mob)
                end)
                ConnectionTable["ConnectMobDied"] = Remotes:WaitForChild("Mobs_MobDied", math.huge).OnClientEvent:Connect(function(Name, Mob)
                    local CheckTable = ISV.MobTable[Mob]
                    if CheckTable then
                        ISV.MobTable[Mob] = nil
                        IsAliveMobs -= 1
                        if ISV.Debug then
                            warn("JDRS:", Name, "(died)")
                        end
                    end
                end)
                for Index, Mob in Mobs:GetChildren() do
                    task.spawn(function()
                        ValidMob(Mob)
                    end)
                end
                SV.WZFScannerState = "running"
                while not KillSwitch do
                    SV.WZFScannerTick = os.clock()
                    if not CombatCharacterReady() then
                        CurrentMob, TeleportMob = nil, nil
                        task.wait(.1)
                        continue
                    end
                    if not CanTarget then
                        CurrentMob = nil
                        task.wait()
                        continue
                    end
                    local TableReference = ISV.MobTable
                    local ClosestMob = nil
                    local ClosestMobDistance = math.huge
                    local ClosestAvoidMob = nil
                    local ClosestAvoidDistance = math.huge
                    local MobPriority = nil

                    for Mob, AddedTable in TableReference do
                        if not Mob.Parent then
                            TableReference[Mob] = nil
                            IsAliveMobs -= 1
                            if ISV.Debug then
                                warn("JDRS:", Mob.Name, "(no parent)")
                            end
                            continue
                        end
                        local MobHealthProperties = Mob:FindFirstChild("HealthProperties")
                        local MobHealth = MobHealthProperties and MobHealthProperties:FindFirstChild("Health")
                        if MobHealth and MobHealth.Value == 0 then
                            TableReference[Mob] = nil
                            IsAliveMobs -= 1
                            if ISV.Debug then
                                warn("JDRS:", Mob.Name, "(zero health)")
                            end
                            continue
                        end
                        if AddedTable.Invincible then
                            continue
                        end
                        local MobCollider = Mob:FindFirstChild("Collider")
                        if not MobCollider then
                            continue
                        end
                        if AddedTable.IsBlocker then
                            ClosestMob = Mob
                            break
                        end
                        if AddedTable.Priority then
                            MobPriority = true
                            ClosestMob = Mob
                            continue
                        end
                        if MobPriority then
                            continue
                        end
                        if not CombatCharacterReady() then continue end
                        local MobDistance = (PlayerCollider.Position - MobCollider.Position).Magnitude
                        if AvoidMobs[Mob.Name] then
                            if MobDistance < ClosestAvoidDistance then
                                ClosestAvoidDistance = MobDistance
                                ClosestAvoidMob = Mob
                            end
                        else
                            if MobDistance < ClosestMobDistance then
                                ClosestMobDistance = MobDistance
                                ClosestMob = Mob
                            end
                        end
                    end
                    TeleportMob = ClosestMob or ClosestAvoidMob
                    if ClosestMob and ClosestMobDistance then
                        IsBoss = false
                        CurrentMob = ClosestMob
                    elseif not ClosestMob and ClosestAvoidMob and ClosestAvoidDistance then
                        IsBoss = true
                        CurrentMob = ClosestAvoidMob
                    else
                        CurrentMob = nil
                    end
                    task.wait()
                end
            end
        end)
        if not Success then
            SV.WZFScannerState = "error"
            warn("[WZF][SCANNER] failed:", tostring(Result), "job:", game.JobId)
            SaveErrorToFile("MOB SCANNER", Result)
        end
    end
end

SetGlobal("ping once unlocked")
local function PingOnceUnlocked(UnlockedClass)
    local Success, Result = pcall(function()
        local MessageContent = {
            ["username"] = "Mastery tracker",
            ["content"] = string.format(
                "Unlocked class %s on %s\n-#%s",
                UnlockedClass, PlayerName, DiscordPingType
            )
        }
        RequestMessage(SV.DiscordWebhookLink, MessageContent, false)
    end)
end

SetGlobal("ping for cap")
local function PingForCap(PingThing)
    local Success, Result = pcall(function()
        local MessageContent = {
            ["username"] = "Limit tracker",
            ["content"] = string.format(
                "%s clear limit reached on %s\n-#%s",
                PingThing, PlayerName, DiscordPingType
            )
        }
        RequestMessage(SV.DiscordWebhookLink, MessageContent, false)
    end)
end

SetGlobal("get difficulty")
local function GetDifficulty()
    return Remotes:WaitForChild("Missions_GetDifficulty", math.huge):InvokeServer()
end

SetGlobal("get lives")
local function GetLives()
    return Remotes:WaitForChild("Missions_GetCurrentLives", math.huge):InvokeServer()
end

SetGlobal("party leader check")
local function PartyLeaderCheck()
    if SV.Parties then
        local PartyLeader = Remotes:WaitForChild("Party_GetPartyData", math.huge):InvokeServer().Leader.Value
        if PlayerName == PartyLeader then
            return true
        else
            return
        end
    end
end

SetGlobal("replay dungeon loop")
local function ReplayDungeonLoop(Mission, Difficulty)
    -- One destination per transition. At most one delayed automatic resend.
    -- A local send is not confirmation that the server accepted the request.
    if type(Mission) ~= "number" or Mission ~= Mission or Mission <= 0 or Mission == math.huge then
        warn("[WZF] Invalid mission ID for replay:", tostring(Mission))
        return false
    end
    if Mission == 49 then
        Mission = 1
    end
    if not SV or ScriptUnloaded then
        return false
    end
    if SV.TransitionPending then
        warn("[WZF] Duplicate dungeon transition blocked. Pending:",
            tostring(SV.TransitionMission), tostring(SV.TransitionDifficulty),
            "new:", tostring(Mission), tostring(Difficulty))
        return false
    end

    -- B3-test: identify which reload callback requested this transition.
    if debug and type(debug.traceback) == "function" then
        warn(debug.traceback("[WZF] Transition caller; job: " .. game.JobId, 2))
    end

    -- Set the lock before WaitForChild (which may yield).
    SV.TransitionPending = true
    SV.TransitionMission = Mission
    SV.TransitionDifficulty = Difficulty
    SV.TransitionUnconfirmed = false
    SV.WZFTransitionAttempt = (SV.WZFTransitionAttempt or 0) + 1
    local Attempt = SV.WZFTransitionAttempt
    SV.WZFTeleportStarted = false
    SV.WZFAutoRetryCount = 0

    local Success, Result = pcall(function()
        local Remote = Remotes and Remotes:WaitForChild("Teleport_StartRaid", 10)
        assert(Remote, "Teleport_StartRaid not available")
        Remote:FireServer(Mission, Difficulty)
    end)
    if not Success then
        warn("[WZF] Dungeon transition request failed:", tostring(Result))
        if type(SaveErrorToFile) == "function" then
            SaveErrorToFile("REPLAY DUNGEON", Result)
        end
        -- A local send failure may be retried manually.
        SV.TransitionPending = false
        SV.TransitionMission = nil
        SV.TransitionDifficulty = nil
        return false
    end

    print("[WZF][D3] initial request sent:", Mission, tostring(Difficulty), "job:", game.JobId)
    local SourceJob = game.JobId
    local function StillOwnsRequest()
        return not ScriptUnloaded and SV and SV.TransitionPending
            and SV.WZFTransitionAttempt == Attempt and game.JobId == SourceJob
            and SV.TransitionMission == Mission and SV.TransitionDifficulty == Difficulty
    end
    task.delay(3, function()
        if not StillOwnsRequest() then return end
        if SV.WZFTeleportStarted then
            SV.TransitionUnconfirmed = true
            warn("[WZF][D3] teleport has started; automatic resend skipped; job:", SourceJob)
            return
        end
        -- Keep the original lock and captured destination. Never re-run selection.
        SV.WZFAutoRetryCount = 1
        local RetryOK, RetryError = pcall(function()
            local Remote = Remotes and Remotes:FindFirstChild("Teleport_StartRaid")
            assert(Remote, "Teleport_StartRaid no longer available")
            Remote:FireServer(Mission, Difficulty)
        end)
        if not StillOwnsRequest() then return end
        if not RetryOK then
            SV.TransitionUnconfirmed = true
            warn("[WZF][D3] automatic resend failed; stopped;", tostring(RetryError), "job:", SourceJob)
            return
        end
        print("[WZF][D3] automatic retry 1/1 sent; same destination:", Mission, tostring(Difficulty), "job:", SourceJob)
        task.delay(3, function()
            if not StillOwnsRequest() then return end
            SV.TransitionUnconfirmed = true
            warn("[WZF][D3] retry budget exhausted; no further automatic resend; mission:", Mission, "job:", SourceJob)
            if Library and not Library.Unloaded then
                Library:Notify("傳送仍未完成，自動重試已停止。請查看主控台或使用強制重開地下城。", 15)
            end
        end)
    end)
    return true
end

-- Do not resend after Roblox has reported that this client is teleporting.
ConnectionTable["WZFTeleportState"] = LocalPlayer.OnTeleport:Connect(function(State)
    if ScriptUnloaded or not SV or not SV.TransitionPending then return end
    print("[WZF][D3] teleport state:", tostring(State), "job:", game.JobId)
    if State == Enum.TeleportState.Started or State == Enum.TeleportState.WaitingForServer
        or State == Enum.TeleportState.InProgress then
        SV.WZFTeleportStarted = true
    end
end)
-- Observe explicit teleport failures without stopping workers on request submission.
ConnectionTable["WZFTeleportInitFailed"] = TeleportService.TeleportInitFailed:Connect(function(Player, Result, Message, PlaceId)
    if Player ~= LocalPlayer or ScriptUnloaded or not SV or not SV.TransitionPending then return end
    warn("[WZF][D2] teleport initialization failed:", tostring(Result), tostring(Message), "place:", PlaceId, "job:", game.JobId)
    SV.TransitionPending = false
    SV.WZFTeleportStarted = false
    SV.TransitionMission = nil
    SV.TransitionDifficulty = nil
    -- Await manual action after a confirmed failure; avoid the stuck monitor sending us to hub.
    SV.TransitionUnconfirmed = true
end)
SetGlobal("rejoin last dungeon")
local function RejoinLastDungeon(DoRejoin)
    if DoRejoin and (SV.RestartSelecting or SV.TransitionPending or SV.TransitionUnconfirmed) then
        warn("[WZF][D2] recovery-to-hub suppressed during unresolved transition; job:", game.JobId)
        return
    end
    if SV.CreatingRejoinFile then
        return
    end
    local Success, Result = pcall(function()
        local RejoinFileName = "JDRS/" ..PlayerName.. "_Rejoin"
        if isfile(RejoinFileName) then
            SV.CreatingRejoinFile = true
            local RejoinData = nil
            pcall(function()
                RejoinData = HttpService:JSONDecode(readfile(RejoinFileName))
            end)
            if RejoinData and RejoinData ~= "" then
                local RejoinDungeon = RejoinData.Dungeon
                local RejoinDifficulty = RejoinData.RejoinDifficulty
                local RejoinTime = RejoinData.DisconnectedTime
                delfile(RejoinFileName)
                if type(RejoinTime) == "number" and RejoinTime <= os.time() and RejoinTime + 300 > os.time() then
                    -- A recovery ticket must never override a dungeon already entered.
                    -- Recovery initiated below uses only this specific hub as its waypoint.
                    if IsDungeon then
                        print("[WZF][REJOIN] ticket discarded; keeping entered dungeon; saved:",
                            tostring(RejoinDungeon), tostring(RejoinDifficulty),
                            "current:", tostring(ISV.MissionId), "place:", game.PlaceId, "job:", game.JobId)
                    elseif IsWorld and StringPlaceID == "4310463616" then
                        print("[WZF][REJOIN] recovery waypoint; requesting saved destination:",
                            tostring(RejoinDungeon), tostring(RejoinDifficulty), "job:", game.JobId)
                        if ReplayDungeonLoop(RejoinDungeon, RejoinDifficulty) then
                            KillSwitch = true
                        else
                            warn("[WZF][REJOIN] request not sent; KillSwitch unchanged; mission:", tostring(RejoinDungeon))
                        end
                    else
                        print("[WZF][REJOIN] ticket discarded outside recovery waypoint; place:", game.PlaceId, "job:", game.JobId)
                    end
                end
            else
                delfile(RejoinFileName)
                warn("[WZF] Invalid rejoin ticket discarded; destination was not inferred")
            end
        end
        if DoRejoin then
            SV.CreatingRejoinFile = true
            local Difficulty = ISV.LoggedDifficulty
            if IsTower then
                Difficulty = nil
            end
            DungeonData = {
                Dungeon = ISV.MissionId,
                RejoinDifficulty = Difficulty,
                DisconnectedTime = os.time()
            }
            writefile(RejoinFileName, HttpService:JSONEncode(DungeonData))
            TeleportService:Teleport(tonumber("4310463616"), LocalPlayer)
            task.wait(5)
            TeleportService:Teleport(tonumber(StringPlaceID), LocalPlayer)
        end
    end)
    if not Success then
        SaveErrorToFile("REJOIN LAST DUNGEON", Result)
    end
end

SetGlobal("wait for game crash")
do
    CoreGui:WaitForChild("RobloxPromptGui", math.huge):WaitForChild("promptOverlay", math.huge).ChildAdded:Once(function()
        RejoinLastDungeon(true)
    end)
end

SetGlobal("restart dungeon")
local function RestartDungeon(RestartBypass)
    if SV.RestartSelecting or SV.TransitionPending then return end
    SV.RestartSelecting = true
    local Success, Result = pcall(function()
    if SV.TransitionPending then
        return -- A destination has already been requested in this client.
    end
    if not (SV.ReplayMission or SV.DoingGuildDungeon or RestartBypass) then 
        return
    end
    if SV.TowerChestDelay then
        task.wait(6)
    end
    local Difficulty = GetDifficulty()
    if not PartyLeaderCheck() then
        Remotes:WaitForChild("Missions_LeaveChoice", math.huge):FireServer(true)
        Remotes:WaitForChild("Missions_NotifyReadyToLeave", math.huge):FireServer()
        return
    end
    Library:Notify("Teleporting...", SV.RestartDungeonDelay)
    task.wait(SV.RestartDungeonDelay)
    if IsTower then
        Difficulty = nil
    end
    if GetLives() == 0 then
        return ReplayDungeonLoop(ISV.MissionId, Difficulty)
    end
    if SV.DoingGuildDungeon and not SV.IsNightmareDungeon then
        if not (ISV.MissionId == 42 and Difficulty == 5) then
            if Difficulty == 1 and not IsTower then
                Library:Notify("Moving to challenge mode", 1)
                return ReplayDungeonLoop(ISV.MissionId, 5)
            else
                local NextDungeon
                for DungeonIndex, Dungeon in SV.DungeonListTable do
                    if Dungeon.DungeonID == ISV.MissionId then
                        NextDungeon = DungeonIndex - 1
                        break
                    end
                end
                local NextDungeonReference = SV.DungeonListTable[NextDungeon]
                Library:Notify("Moving to " ..NextDungeonReference.DungeonName, 1)
                if NextDungeonReference.Level > 0 then
                    return ReplayDungeonLoop(NextDungeonReference.DungeonID, 1)
                else
                    return ReplayDungeonLoop(NextDungeonReference.DungeonID, nil)
                end
            end
        else
            local RestartChoice = Options.DoAllDropdown.Value
            if RestartChoice == "Stop" then
                Library:Notify("Finished doing all dungeons", 9999999999999999)
                return
            elseif RestartChoice == "Loop" then
                return ReplayDungeonLoop(38, nil)
            elseif RestartChoice == "Loop w/o inf" then
                return ReplayDungeonLoop(21, nil)
            elseif RestartChoice == "Loop w/o towers" then
                return ReplayDungeonLoop(1, 1)
            elseif RestartChoice == "Play nightmare dungeons" then
                return ReplayDungeonLoop(1005, 6)
            end
        end
    end
    if SV.IsNightmareDungeon and SV.PrioNmDCount and ISV.PlayerLevel == 175 then
        local GetCurrentDailyDungeon = Remotes:WaitForChild("Missions_GetCurrentDailyDungeon", math.huge):InvokeServer()
        local SelectedDungeon = ISV.MissionId
        local SelectedDungeonSpecialPerk
        local SelectedDungeonLength = 9999
        for Index, Data in GetCurrentDailyDungeon do
            local InternalID = Data.InternalID
            for DungeonIndex in Options.PrioNmDropdown.Value do
                local DungeonData = SV.PrioritizedNightmareDungeons[DungeonIndex]
                if InternalID == DungeonData.ID then
                    if DungeonData.SpecialPerk then
                        if not SelectedDungeonSpecialPerk then
                            SelectedDungeonSpecialPerk = true
                            SelectedDungeon = Data.ID
                            SelectedDungeonLength = DungeonData.Length
                        elseif DungeonData.Length < SelectedDungeonLength then
                            SelectedDungeon = Data.ID
                            SelectedDungeonLength = DungeonData.Length
                        end
                    elseif not SelectedDungeonSpecialPerk and DungeonData.Length < SelectedDungeonLength then
                        SelectedDungeon = Data.ID
                        SelectedDungeonLength = DungeonData.Length
                    end
                end
            end
        end
        return ReplayDungeonLoop(SelectedDungeon, Difficulty)
    end
    if SV.AutoLeveling and not IsEventDungeon then
        local CheckPartySize = Players:GetChildren()
        local LowestLevel = math.huge
        if #CheckPartySize > 1 then
            for Index, Player in CheckPartySize do
                local MemberLevel = Player:GetAttribute("Level")
                if MemberLevel and MemberLevel < LowestLevel then
                    LowestLevel = MemberLevel
                end
            end
        else
            LowestLevel = LocalPlayer:GetAttribute("Level")
        end
        for Index, AutoLevelingDungeon in SV.DungeonListTable do
            if LowestLevel >= AutoLevelingDungeon.Level then
                if AutoLevelingDungeon.DungeonID == ISV.MissionId then
                    Library:Notify("Replaying: " ..AutoLevelingDungeon.DungeonName, 2)
                else
                    Library:Notify("Moving to: " ..AutoLevelingDungeon.DungeonName, 2)
                end
                return ReplayDungeonLoop(AutoLevelingDungeon.DungeonID, 5)
            end
        end
    end
    if SV.RandomNightmareDungeon and SV.IsNightmareDungeon then
        return ReplayDungeonLoop(SV.RandomNightmareDungeon, Difficulty)
    end
    return ReplayDungeonLoop(ISV.MissionId, Difficulty)
    end)
    SV.RestartSelecting = false
    if not Success then
        warn("[WZF][D2] restart selection failed:", tostring(Result), "job:", game.JobId)
    end
    return Success and Result
end

SetGlobal("collect chests")
local function CollectChests()
    local ExtraChestCheck = true
    local ChestDrops = {}
    local rItems = false
    local Success, Result = pcall(function()
        if SV.CanRequire then
            rItems = require(Items)
        end
        local Success1, Result1 = pcall(function()
            ExtraChestCheck = MarketplaceService:UserOwnsGamePassAsync(PlayerID, 8136250)
        end)
        if not Success1 then
            warn("unable to check if user owns extra chest gamepass")
        end
        local MissionPrize = Remotes:WaitForChild("Missions_GetMissionPrize", math.huge)
        for ChestIndex = 1, 4 do
            if ChestIndex == 4 and not ExtraChestCheck then
                break
            end

            if ScriptUnloaded or KillSwitch then break end
            if ChestIndex > 1 then
                local ChestDelay = tonumber(SV.CollectChestsDelay) or 0.1
                if ChestDelay ~= ChestDelay then ChestDelay = 0.1 end
                task.wait(math.clamp(ChestDelay, 0.01, 5))
            end
            if ScriptUnloaded or KillSwitch then break end
            local ChestPrize
            print("[WZF][D2-CHEST] request:", ChestIndex, "job:", game.JobId)
            if ChestIndex == 1 then
                ChestPrize = MissionPrize:InvokeServer(true)
            else
                ChestPrize = MissionPrize:InvokeServer()
            end

            print("[WZF][D2-CHEST] returned:", ChestIndex, "type:", typeof(ChestPrize), "truthy:", not not ChestPrize, "job:", game.JobId)
            if ChestPrize then
                if rItems then
                    ChestPrize = rItems[tostring(ChestPrize)].DisplayKey
                end
                if Library then
                    Library:Notify("Chest reward: " ..tostring(ChestPrize), 1)
                end
                table.insert(ChestDrops, ChestPrize)
            end
        end
        task.wait(.5)
    end)
    if not Success then
        SaveErrorToFile("COLLECT DUNGEON CHESTS", Result)
    end
    return ChestDrops
end

SetGlobal("collect tower chests")
local function CollectTowerChests()
    CheckForCharacter()
    if IsTower then
        local Success, Result = pcall(function()
            local OpenChest = Remotes:WaitForChild("Chests_OpenChest", math.huge)
            if SV.CanRequire and debug and getupvalue then
                local ChestScript = debug.getupvalue(require(Chests).Start, 12)
                for ChestKey, ChestPath in ChestScript do
                    OpenChest:FireServer(ChestKey)
                end
            else
                local ChestNames = {
                    "RaidChestBlue", "RaidChestGold", "RaidChestSilver", "HeavenlyRaidChest"
                }
                for Index, ChestName in ChestNames do
                    local Chest = Workspace:FindFirstChild(ChestName)
                    if Chest and Chest.Parent then
                        task.spawn(function()
                            while Chest.Parent do
                                Chest:PivotTo(CFrame.new(PlayerRoot.Position))
                                task.wait()
                            end
                        end)
                    end
                end
            end
        end)
        if not Success then
            SaveErrorToFile("COLLECT TOWER CHEST", Result)
        end
    end
end

SetGlobal("claim all quests")
local function ClaimAllQuests()
    local Success, Result = pcall(function()
        local ProfileQuests = PlayerProfile:WaitForChild("Quests", math.huge)
        local Active = ProfileQuests:WaitForChild("Active", math.huge)
        if SV.ClaimGuildQuests then
            local GetDailyGuildQuests = require(Quests):GetDailyGuildQuests()
            for Difficulty, Data in GetDailyGuildQuests do
                local QuestID = Data.ID
                if not Remotes:WaitForChild("Quests_GuildDailyIsClaimed", math.huge):InvokeServer(QuestID) then
                    if Active:FindFirstChild(QuestID) then
                        for i = 1, 2 do
                            Remotes:WaitForChild("Quests_ClaimDailyGuildQuest", math.huge):FireServer(QuestID)
                        end
                        task.wait(1.5)
                    end
                end
            end
        end
        local ClaimQuest = Remotes:WaitForChild("Quests_ClaimQuest", math.huge)
        if ClaimQuest then
            for _, ActiveQuest in Active:GetChildren() do
                ClaimQuest:FireServer(tonumber(ActiveQuest.Name))
            end
        end
    end)
    if not Success then
        local ExtraMessage
        if Result:find("IsSeasonActive") then
            ExtraMessage = "\"IsSeasonActive\" is a in-game error not caused by the script"
        end
        SaveErrorToFile("CLAIM QUESTS", Result, ExtraMessage)
    end
end

SetGlobal("getting current dungeon")
local function GetDungeonImage()
    local Success, Result = pcall(function()
        if not SV.CanRequire then
            ISV.DungeonImage = ""
            return
        end
        local ImageURL = ""
        local GetCurrentMissionData = require(Missions):GetCurrentMissionData() 
        local ImageID = GetCurrentMissionData.DungeonID or GetCurrentMissionData.ImageID or "3815150377"
        ImageID = tostring(ImageID):match("%d+")
        if ISV.MissionId == 43 then
            ImageID = tonumber("15046578670")
        end
        local ImageFile = "JDRS/DungeonImages"
        if not isfile(ImageFile) then
            local ReturnedImage = game:HttpGet(("https://thumbnails.roblox.com/v1/assets?assetIds="..ImageID.."&size=420x420&format=Png"))
            ReturnedImage = HttpService:JSONDecode(ReturnedImage).data[1]
            writefile(ImageFile, HttpService:JSONEncode({Images = { [tostring(ImageID)] = {ReturnedImage.imageUrl, os.time()+604800}}}))
            ImageURL= ReturnedImage.imageUrl
        else
            local ReadImageFile = HttpService:JSONDecode(readfile(ImageFile)).Images
            local ImageCached = ReadImageFile[ImageID]
            if not ImageCached or ImageCached[2] <= os.time() or string.find(tostring(ImageCached[1]), "token") then
                local RemakeTable = {}
                for i, o in ReadImageFile do
                    RemakeTable[i] = {table.unpack(o)}
                end
                local ReturnedImage = game:HttpGet(("https://thumbnails.roblox.com/v1/assets?assetIds="..ImageID.."&size=420x420&format=Png"))
                ReturnedImage = HttpService:JSONDecode(ReturnedImage).data[1]
                RemakeTable[tostring(ImageID)] = { ReturnedImage.imageUrl, os.time()+604800}
                writefile(ImageFile, HttpService:JSONEncode({Images = RemakeTable}))
                ImageURL= ReturnedImage.imageUrl
            else
                ImageURL = ImageCached[1]
            end
        end
        if string.find(tostring(ImageURL), "token") then
            ImageURL = ""
        end
        ISV.DungeonImage = ImageURL
    end)
    if not Success then
         ISV.DungeonImage = ""
    end
end

SetGlobal("connect mission finished")
local function ConnectMissionFinished()
    if IsDungeon then
        local MissionFinished = Remotes:WaitForChild("Missions_MissionFinished", math.huge)
        ConnectionTable["MissionFinished"] = MissionFinished.OnClientEvent:Once(function(EndTime, PlayersInDungeon, Lost)
            SV.DungeonCompletionTime = SecondsToString(EndTime)
            if SV.ShowTime then
                Library:Notify("Completed in " ..SV.DungeonCompletionTime)
            end
            if ISV.Debug then
                print("AutoLeveling check")
            end
            if SV.AutoLeveling then
                ClaimAllQuests()
            end
            if ISV.Debug then
                print("Collect chest check")
            end
            local ChestDrops = {"none"}
            if SV.CollectDungeonChest then
                ChestDrops = CollectChests()
            end
            if SV.DungeonPing then
                local EmbedColor = 65280
                local CompletionStatus = "completed"
                local DungeonName = "unknown"
                local PlayersInDungeon = Players:GetChildren()
                if Lost then
                    EmbedColor = 16711680
                    CompletionStatus = "failed"
                end
                if SV.CanRequire then
                    DungeonName = require(Missions):GetCurrentMissionData().NameTag
                else
                    DungeoName = DungeonName.. "(missing require())"
                end
                if Toggles.ShowPlayersToggle.Value then
                    local PlayerTable = {}
                    for Index, Player in PlayersInDungeon do
                        table.insert(PlayerTable, Player.Name)
                    end
                    PlayersInDungeon = table.concat(PlayerTable, "`, `")
                else
                    PlayersInDungeon = #PlayersInDungeon
                end
                if not ISV.DungeonImage then
                    GetDungeonImage()
                end
                local MessageContent = {
                    ["username"] = "Dungeon logger",
                    ["embeds"] = {
                        {
                            ["description"] = string.format(
                                "**Dungeon** `%s`\n**Time:** `%s`\n**Party size:** `%*`\n**Chest drops:** `%*`",
                                DungeonName, SV.DungeonCompletionTime, PlayersInDungeon, table.concat(ChestDrops, "`, `")
                            ),
                            ["type"] = "rich",
                            ["color"] = EmbedColor,
                            ["thumbnail"] = { url = ISV.DungeonImage },
                        }
                    }
                }
                RequestMessage(SV.DiscordWebhookLink, MessageContent, false)
            end
            repeat
                task.wait(1)
                if ISV.Debug then
                    print(string.format(
                        "Sell check: %d, Equip check: %d",
                        SellItemCheck, EquipInProgress
                    ))
                end
            until SellItemCheck == 0 and EquipInProgress == 0
            print("[WZF][D2] completion reached restart; sell:", SellItemCheck, "equip:", EquipInProgress, "job:", game.JobId)
            RestartDungeon()
        end)
    end
end

SetGlobal("connect tower finished")
local function ConnectTowerFinished()
    local TowerFinished 
    if ISV.MissionId == 39 then
        TowerFinished = ReplicatedStorage:WaitForChild("MissionScripts", math.huge):WaitForChild("39", math.huge):WaitForChild("TowerFinished", math.huge)
    elseif ISV.MissionId == 56 then
        TowerFinished = ReplicatedStorage:WaitForChild("MissionScripts", math.huge):WaitForChild("56", math.huge):WaitForChild("TowerFinished", math.huge)
    else
        TowerFinished = Remotes:WaitForChild("Towers_TowerFinished", math.huge)
    end
    ConnectionTable["TowerFinished"] = TowerFinished.OnClientEvent:Once(function(Countdown, EndTime)
        SV.DungeonCompletionTime = SecondsToString(EndTime)
        if SV.ShowTime then
            Library:Notify("Completed in " ..SV.DungeonCompletionTime)
        end
        if SV.DungeonPing then
            local EmbedColor = 65280
            local CompletionStatus = "completed"
            local DungeonName = "unknown"
            local PlayersInDungeon = Players:GetChildren()
            if Lost then
                EmbedColor = 16711680
                CompletionStatus = "failed"
            end
            if SV.CanRequire then
                DungeonName = require(Missions):GetCurrentMissionData().NameTag
            else
                DungeoName = DungeonName.. "(missing require())"
            end
            if Toggles.ShowPlayersToggle.Value then
                local PlayerTable = {}
                for Index, Player in PlayersInDungeon do
                    table.insert(PlayerTable, Player.Name)
                end
                PlayersInDungeon = table.concat(PlayerTable, "`, `")
            else
                PlayersInDungeon = #PlayersInDungeon
            end
            if not ISV.DungeonImage then
                GetDungeonImage()
            end
            local MessageContent = {
                ["username"] = "Dungeon logger",
                ["embeds"] = {
                    {
                        ["description"] = string.format(
                            "**Dungeon** `%s`\n**Time:** `%s`\n**Party size:** `%*`",
                            DungeonName, SV.DungeonCompletionTime, PlayersInDungeon
                        ),
                        ["type"] = "rich",
                        ["color"] = EmbedColor,
                        ["thumbnail"] = { url = ISV.DungeonImage },
                    }
                }
            }
            RequestMessage(SV.DiscordWebhookLink, MessageContent, false)
        end
        RestartDungeon()
    end)
end

SetGlobal("get rarity")
local function GetRarity(Item)
    if SV.Items then
        local ItemRef = SV.Items[Item.Name]
        if ItemRef.Type and (ItemRef.Type == "Pet" or ItemRef.Type == "Weapon" or ItemRef.Type == "Armor" or ItemRef.Type == "Charm") then
            local ItemRarity
            if ItemRef.Type == "Pet" then
                ItemRarity = ItemRef.Variants[Item:WaitForChild("Variant", 10).Value][4]
            else
                ItemRarity = ItemRef.Rarity
            end
            if ItemRef.Type == "Charm" then
                if ItemRarity == 5 then
                    return 5, 1
                else
                    return 4
                end
            end
            if ItemRarity == 7 then
                return 7
            elseif ItemRarity == 5 then
                return 5, 3
            elseif ItemRarity == 4 then 
                return 4, 2
            elseif ItemRarity == 3 then
                return 3, 1
            else
                return 2
            end
        else
            return "NotEquipment"
        end
    else
        task.wait(1.5)
        local Upgrade = Item:FindFirstChild("UpgradeLimit")
        if (Upgrade and Upgrade.Value == 20) then
            return 7
        elseif Item:FindFirstChild("Perk3") then
            return 5, 3
        elseif Item:FindFirstChild("Perk2") then
            return 4, 2
        elseif Item:FindFirstChild("Perk1") then
            return 3, 1
        elseif Uograde then
            return 2
        else
            return "NotEquipment"
        end
    end
end

SetGlobal("equip new item added")
local function EquipNewItemAdded()
    local Success, Result = pcall(function()
        local ScanInventory = ProfileInventory:WaitForChild("Items")
        local EquipSlots = {
            "Armor", "Primary", "Offhand"
        }
        local PlayerEquips = ReplicatedStorage.PlayerEquips[LocalPlayer.Name]
        local EquipItem = Remotes:WaitForChild("Inventory_EquipItem", math.huge)
        ConnectionTable["ConnectEquipNewItems"] = ScanInventory.ChildAdded:Connect(function(NewItem)
            EquipInProgress = EquipInProgress + 1
            local Success1, Result1 = pcall(function()
                task.wait(1)
                if ISV.Debug then
                    print("Checking equip: ", NewItem)
                end
                if not NewItem:FindFirstChild("Level") then
                    return
                end
                for Index, Slot in EquipSlots do
                    if NewItem and NewItem.Parent and NewItem.Parent.Name ~= "Items" then
                        return  
                    end
                    local CheckSlot = PlayerEquips[Slot]
                    local NewItemLevel = NewItem:FindFirstChild("Level")
                    local OldItem = CheckSlot:FindFirstChildWhichIsA("Folder")
                    if NewItemLevel and OldItem then
                        OldItemLevel = OldItem:FindFirstChild("Level")
                        if OldItemLevel and (NewItemLevel.Value >= OldItemLevel.Value) then
                            if NewItemLevel.Value == OldItemLevel.Value then
                                local NewItemRarity = GetRarity(NewItem)
                                local OldItemRarity = GetRarity(OldItem)
                                if typeof(NewItemRarity) == "number" and typeof(OldItemRarity) == "number" and NewItemRarity > OldItemRarity then
                                    EquipItem:FireServer(NewItem, CheckSlot)
                                    continue
                                else
                                    continue
                                end
                            end
                            EquipItem:FireServer(NewItem, CheckSlot)
                        end
                    end
                end
                task.wait(1)
            end)
            -- Release once on normal completion, early return, or protected error.
            EquipInProgress = math.max(0, EquipInProgress - 1)
            if not Success1 then
                warn("[WZF][D4] equip error; counter released:", tostring(Result1), "job:", game.JobId)
                SaveErrorToFile("SCAN ITEM TO EQUIP", tostring(Result1), NewItem)
            end
        end)
    end)
    if not Success then
        SaveErrorToFile("EQUIP NEW ITEM", Result)
    end
end

SetGlobal("get player size")
local function GetPlayerSize()
    return PlayerCollider.Size.Y / 2 or 0
end

SetGlobal("collect coins")
local function CollectCoins()
    CheckForCharacter()
    if SV.CanRequire and debug and getupvalue then
        local Success, Result = pcall(function()
            local rDrops = debug.getupvalue(require(Drops).Start, 6)
            local CoinEvent = Remotes:WaitForChild("Drops_CoinEvent", math.huge)
            for DropIndex, CoinDrop in rDrops do
                CoinDrop.model:Destroy()
                CoinDrop.followPart:Destroy()
                CoinEvent:FireServer(CoinDrop.id)
            end
        end)
        if not Success then
            SaveErrorToFile("COLLECT DROP", Result)
        end
    else
        local Success, Result = pcall(function()
            local CoinFolder = Workspace:WaitForChild("Coins", math.huge)
            local PlayerSize = GetPlayerSize()
            for _, CoinChild in CoinFolder:GetChildren() do
                if CoinChild:IsA("Part") then
                    while CoinChild.Parent do
                        CoinChild.CanCollide = false
                        CoinChild.Anchored = true
                        CoinChild.CFrame = CFrame.new(PlayerRoot.Position.X, PlayerRoot.Position.Y-GetPlayerSize(), PlayerRoot.Position.Z)
                        task.wait(0.1)
                    end
                end
            end
        end)
        if not Success then
            SaveErrorToFile("COLLECT DROP FALLBACK", Result)
        end
    end
end

SetGlobal("get guild")
local function GetGuild(Player)
    return Player:GetAttribute("GuildTag") or "❌"
end

local function IsTowerEgg(Item)
    if Item and Item.Name and SV.TowerEggList and SV.TowerEggList[Item.Name] then
        return true
    end
end

SetGlobal("sell item")
local function SellItem(Item, SellContext)
    if ISV.Debug then
        if SellContext then
            warn(SellContext)
        else
            warn("Selling item: ", Item.Name)
        end
    end
    local Success, Result = pcall(function()
        Remotes:WaitForChild("Drops_SellItems", math.huge):InvokeServer({Item})
        if Library then
            Library:Notify("<font color='#FCCE7E'>Sold item:</font> " ..tostring(Item), 1)
        end
        SellItemCheck = SellItemCheck - 1
    end)
    if not Success then
        SaveErrorToFile("SELL", Result)
    end
end

SetGlobal("buy from local shop")
local function BuyFromLocalShop(ShopData, PurchaseData)
    local IsDebug = ISV.Debug
    if not PurchaseData then
        Library:Notify("No item selected")
        return
    end
    local Currency = ShopData.ShopInfo.Currency
    local ShopName = ShopData.ShopInfo.ShopName
    local Item = PurchaseData.InternalName
    local ItemName = PurchaseData.VisualName
    local ItemPrice = PurchaseData.CoinPrice
    if IsDebug then
        print(string.format(
            "JDRS: attempting to buy %* (%*) for %*",
            ItemName, Item, ItemPrice
        ))
    end
    if not (Item and ItemPrice and ItemName) then
        if IsDebug then
            warn(string.format(
                "JDRS: purchase failed, do these variables exist?\nItem name: %*\nInternal name: %*\nItem price: %*",
                    ItemName, Item, ItemPrice
            ))
        end
        return
    end
    local BuyLocal = Remotes:FindFirstChild("CoinShop_Buy")
    local Coins = ProfileInventory:WaitForChild("Items", math.huge):FindFirstChild(Currency)
    if not (Coins and BuyLocal) then
        if IsDebug then
            warn(string.format(
                "JDRS: purchase failed, do these variables exist?\nRemote path: %*\nCurrency path: %*",
                    BuyLocal and BuyLocal:GetFullName() or nil,
                    Coins and string.gsub(Coins:GetFullName(), PlayerName, "LocalPlayer") or "does player have currency "..tostring(Currency).."?"
            ))
        end
        return
    end
    local CoinCount = Coins and Coins:FindFirstChild("Count")
    if not (CoinCount and tonumber(CoinCount.Value) >= ItemPrice) then
        if IsDebug then
            warn(string.format(
                "JDRS: player doesn't have enough for %* (%*).\nItem costs %*, but player has %*",
                ItemName, Item, ItemPrice, CoinCount and CoinCount.Value or nil
            ))
        end
        return
    end
    local Success, Result = pcall(function()
        BuyLocal:InvokeServer(ShopName, Shop.LocalShops[ShopName].Items[Item])
    end)
    if not Success then
        SaveErrorToFile("BUY FROM LOCAL SHOP", Result)
        return
    end
    Library:Notify("Purchased " ..ItemName.. "!", 1)
    task.wait(0.6)
    return true
end

SetGlobal("buy from egg shop")
local function BuyFromEggShop(Currency, Egg, EggPrice, EggName)
    if ISV.Debug then
        print("Buy egg with data: ", Currency, Egg, EggPrice, EggName)
    end
    local BuyEgg = Remotes:FindFirstChild("Pets_BuyEgg")
    if Currency == "Gold" then
        local ProfileCurrency = PlayerProfile:FindFirstChild("Currency")
        if not (BuyEgg and ProfileCurrency) then
            return
        end
        local Gold = ProfileCurrency and ProfileCurrency:FindFirstChild("Gold")
        if not (Gold and tonumber(Gold.Value) >= EggPrice) then
            return
        end
    elseif Currency == "Crystal" then
        local GetCrystals = Remotes:WaitForChild("Crystals_GetCrystals", math.huge):InvokeServer()
        if not (GetCrystals and GetCrystals >= EggPrice) then
            return
        end
    end
    BuyEgg:FireServer(Egg, Currency)
    Library:Notify("Purchased " ..EggName.. "!", 1)
    return true
end

SetGlobal("open menu")
local function OpenMenu(Menu)
    local Success, Result = pcall(function()
        require(Client.Gui):Get(Menu):Open(true)
    end)
    if not Success then
        Library:Notify("Function is unsupported by your executor", 5)
    end
end

SetGlobal("upgrade to max")
local function UpgradeToMax(Slot)
    if IsDungeon or IsWorld then
        local pUpgrade, pUpgradeFail = pcall(function()
            local EquipmentPiece = ReplicatedStorage.PlayerEquips[PlayerName][Slot]:FindFirstChildWhichIsA("Folder")
            local ItemUpgradePath = Remotes:FindFirstChild("ItemUpgrade_Upgrade")
            if not (EquipmentPiece and ItemUpgradePath) then
                return
            end
            if ISV.Debug then
                print("upgrading: ", EquipmentPiece)
            end
            for i = 1, 150 do
                ItemUpgradePath:FireServer(EquipmentPiece, false)
            end
            Library:Notify(Slot.. " has been upgraded", 1)
        end)
        if not pUpgrade then
            SaveErrorToFile("UPGRADE", tostring(pUpgradeFail))
        end
    end
end

SetGlobal("expand part size")
local function ExpandPartSize(Part)
    if ISV.Debug then
        print("Expanding part: ", Part.Name)
    end
    local PreviousTriggerSize = Part.Size
    Part.Size = Vector3.new(2048, 2048, 2048)
    task.wait(1)
    Part.Size = PreviousTriggerSize
end

SetGlobal("find part")
local function FindPart(Location, PartData)
    local MainParent
    local DeleteOnceFound
    if not Location then
        MainParent = MissionObjects
    elseif Location == "CheckpointGates" then
        MainParent = MissionObjects:WaitForChild("CheckpointGates", math.huge)
    elseif Location == "NoParent" then
        MainParent = Workspace
    elseif Location == "BossRoom" then
        MainParent = MissionObjects:WaitForChild("BossRoom", math.huge)
    elseif Location == "DeleteParts" then
        MainParent = Workspace
        DeleteOnceFound = true
    end


    for _, PartName in PartData do
        if type(PartName) == "string" then
            MainParent = MainParent:WaitForChild(PartName, math.huge)
        end
    end

    if DeleteOnceFound then
        MainParent:Destroy()
        MainParent = nil
        if PartData.MultipleExists then
            FindPart(Location, PartData)
        end
        return
    end

    local TouchInterest
    if PartData.DescendantCheck then
        for Index, Part in MainParent:GetDescendants() do
            if Part.ClassName == "TouchTransmitter" then
                MainParent = Part.Parent
                TouchInterest = Part
                break
            end
        end
    else 
        TouchInterest = MainParent:WaitForChild("TouchInterest", math.huge)
    end

    local StartingPartSize = MainParent.Size
    local StartingPartCollision = MainParent.CanCollide
    local StartingPosition = MainParent.Position
    if SV and SV.Autofarm then
        MainParent.Size = Vector3.new(1, 1, 1)
        MainParent.CanCollide = false
    end
    if SV then
        TeleportParts[MainParent] = {
            TouchPart = TouchInterest,
            OriginalLocation = StartingPosition,
            OriginalSize = StartingPartSize,
            OriginalCollision = StartingPartCollision,
            Regenerates = PartData.Regenerates or nil,
            AutoTouchTimer = PartData.AutoTouch and time()+1.5 or nil,
            DontTeleport = PartData.DontTeleport or nil
        }
        if PartData.Regenerates then
            while not KillSwitch do
                repeat
                    task.wait(0.5)
                until not TouchInterest.Parent or not TouchInterest.Parent and TouchInterest.Parent
                TouchInterest = MainParent:WaitForChild("TouchInterest", math.huge)
                if SV and SV.Autofarm then
                    MainParent.Size = Vector3.new(1, 1, 1)
                end
                MainParent.CanCollide = false
                TeleportParts[MainParent] = {
                    TouchPart = TouchInterest,
                    OriginalLocation = StartingPosition,
                    OriginalSize = StartingPartSize,
                    OriginalCollision = StartingPartCollision,
                    Regenerates = PartData.Regenerates or nil,
                    AutoTouchTimer = PartData.AutoTouch and time()+1.5 or nil,
                    DontTeleport = PartData.DontTeleport or nil
                }
                task.wait()
            end
        end
    end
end

SetGlobal("disconnect variables")
local function DisconnectVariable(Connection)
    if ConnectionTable[Connection] then
        ConnectionTable[Connection]:Disconnect()
        ConnectionTable[Connection] = nil
    end
end

SetGlobal("teleport stand part")
local function TeleportStandPart()
    if not CombatCharacterReady() or not StandPartHeight then return end
    if PlayerStandPart then
        PlayerStandPart.CFrame = CFrame.new(PlayerCollider.Position.X, (PlayerCollider.Position.Y-StandPartHeight), PlayerCollider.Position.Z)
    end
end

SetGlobal("dodge current attack")
local function DodgeCurrentAttack(DelayBeforeDodge, DodgeLength, AttackName, AdjustZ)
    if EventOverride or not CombatCharacterReady() then return end
    SV.WZFDodgeGeneration = (SV.WZFDodgeGeneration or 0) + 1
    local Generation = SV.WZFDodgeGeneration
    local Root = PlayerRoot
    local Character = PlayerCharacter
    local PreviousStop, PreviousTarget = TempStop, CanTarget
    local Success, Result = pcall(function()
        SV.DodgingAttack = true
        task.wait(DelayBeforeDodge)
        if ScriptUnloaded or KillSwitch or EventOverride or not CombatCharacterReady()
            or PlayerRoot ~= Root or PlayerCharacter ~= Character or SV.WZFDodgeGeneration ~= Generation then return end
        if SV.SafeKillaura then CanTarget = false end
        local DodgeStart = time() + DodgeLength
        local DodgePosition = Root.Position + Vector3.new(0, 200, AdjustZ or 0)
        Library:Notify("Dodging attack: " .. (AttackName or "[no name for attack given]"), DodgeLength)
        while time() < DodgeStart and not EventOverride do
            if ScriptUnloaded or KillSwitch or not CombatCharacterReady() or PlayerRoot ~= Root
                or SV.WZFDodgeGeneration ~= Generation then break end
            TempStop = true
            Root.CFrame = CFrame.new(DodgePosition)
            TeleportStandPart()
            task.wait()
        end
    end)
    if SV and SV.WZFDodgeGeneration == Generation then
        TempStop, CanTarget = PreviousStop, PreviousTarget
        SV.DodgingAttack = nil
    end
    if not Success and not ScriptUnloaded then SaveErrorToFile("DODGING ATTACK", Result) end
end

SetGlobal("teleport to orb")
local function TeleportToOrb(Orb)
    CheckForCharacter()
    local Success, Result = pcall(function()
        while SV.DodgingAttack do
            task.wait()
        end

        local OrbPart = Orb:WaitForChild("Particles", 5) or false
        if not OrbPart then
            print("Unable to locate orb part")
            return
        end

        if SV.SafeKillaura then
            CanTarget = false
        end

        local TeleportStart = time() + 0.5
        while time() < TeleportStart do
            TempStop = true
            PlayerRoot.CFrame = CFrame.new(OrbPart.Position)
            TeleportStandPart()
            task.wait()
        end
        CanTarget = true
        TempStop = false
    end)
    if not Success then
        SaveErrorToFile("TELEPORT TO ORB", Result)
    end
end

SetGlobal("build attacks")
local function BuildAttackData(TargetTable, TargetIndex)
    TargetIndex = tostring(TargetIndex)
    local AttackSkills = TargetTable[TargetIndex].Skills
    if not AttackSkills then
        TargetTable[TargetIndex].Skills = {}
        for SkillIndex, SkillInfo in TargetTable[TargetIndex].SkillInfo do
            local NumberOfAttacks = SkillInfo[1]
            local AttackName = SkillInfo[2]
            local AttackCooldown = SkillInfo[3]
            local AttackType = SkillInfo[4]
            local AttackDistance = SkillInfo[5]
            local SkipFirst = SkillInfo.SkipFirst
            local FormatSkill = SkillInfo.FormatSkill
            local IncrementDistance = SkillInfo.IncrementD
            local AddCooldown = SkillInfo.AddCd
            local Rollback = SkillInfo.Rollback
            local BuiltAttackData = {}
            local AddedAttackDistance = 0
            local IsAttackTable = if type(AttackName) == "table" then true else false
            local IsCooldownTable = if type(AttackCooldown) == "table" then true else false
            local IsDistanceTable = if type(AttackDistance) == "table" then true else false

            for Count = 1, NumberOfAttacks do
                local StartingCount = Count
                local SkillName = if IsAttackTable then AttackName[Count] else AttackName
                local SkillCooldown = if IsCooldownTable then if #AttackCooldown == 1 then AttackCooldown[1] else AttackCooldown[Count] else AttackCooldown
                local SkillDistance = if IsDistanceTable then AttackDistance[Count] else AttackDistance

                if Rollback then
                    Count -= 1
                end

                if not IsAttackTable and NumberOfAttacks > 1 then
                    if Count <= 1 and SkipFirst then
                        if Rollback then
                            if Count == 0 then
                                Count = ""
                            end
                        else
                            Count = ""
                        end
                    end
                else
                    Count = ""
                end

                if typeof(SkillName) ~= "Instance" then
                    if not FormatSkill then
                        SkillName = SkillName..Count
                    else
                        SkillName = string.gsub(SkillName, "*", Count)
                    end
                end

                if IncrementDistance and StartingCount >= IncrementDistance[1] then
                    AddedAttackDistance += IncrementDistance[2]
                    SkillDistance += AddedAttackDistance
                end

                if AddCooldown and StartingCount >= AddCooldown[1] then
                    SkillCooldown += AddCooldown[2]
                end

                table.insert(TargetTable[TargetIndex].Skills, {Skill = SkillName, Cooldown = SkillCooldown, Type = AttackType, Distance = SkillDistance})
            end
        end
        TargetTable[TargetIndex].SkillInfo = nil
    end

    return TargetTable[TargetIndex]
end

SetGlobal("get player pet")
local function GetPlayerPet(IsCancelled)
    local function Cancelled() return ScriptUnloaded or KillSwitch or (IsCancelled and IsCancelled()) end
    while not Cancelled() and not CombatCharacterReady() do task.wait(.1) end
    if Cancelled() then return end
    local rPets = require(Pets)
    while not Cancelled() do
        local PetData = PlayerCharacter and PlayerCharacter:FindFirstChild("PetData")
        if PetData and PetSkills then
            task.wait(.5)
            if Cancelled() then return end
            if not CombatCharacterReady() or PetData.Parent ~= PlayerCharacter then continue end
            local ItemName = PetData:GetAttribute("ItemName")
            if not ItemName or string.find(tostring(ItemName), "Egg") then
                task.wait(1)
                continue
            end
            local PetName = ReplicatedStorage.PlayerEquips[PlayerName].Pet:FindFirstChild(ItemName)
            if not PetName then
                task.wait(1)
                continue
            end
            local PetRef = rPets:GetPetSkillFromPetRef(PetName)
            if not PetRef then
                task.wait(1)
                continue
            end
            return BuildAttackData(PetSkills, PetRef)
        end
        task.wait(1)
    end
end

SetGlobal("get player class")
local function GetPlayerClass()
    SV.PlayerClass = WaitForAttribute(LocalPlayer, "Class")
    if ConnectionTable.ClassConnection then
        DisconnectVariable("ClassConnection")
    end
    task.spawn(function()
        if SV.PlayerClass == "Summoner" then
            local OnCollected = Remotes:WaitForChild("Effect_SoulObject_OnCollected", math.huge)
            ConnectionTable["ClassConnection"] = OnCollected.OnClientEvent:Connect(function(a, b, GUID, d, e)
                OnCollected:FireServer(GUID)
            end)
        elseif SV.PlayerClass == "Necromancer" then
            local OnCollected = Remotes:WaitForChild("Effect_SoulObjectNecromancer_OnCollected", math.huge)
            ConnectionTable["ClassConnection"] = OnCollected.OnClientEvent:Connect(function(a, b, GUID, d, e)
                OnCollected:FireServer(GUID)
            end)
        elseif SV.PlayerClass == "Dragoon" then
            local EnemyMarked = Remotes:WaitForChild("Combat_EnemyMarked", math.huge)
            local LastCombo = 0
            ConnectionTable["ClassConnection"] = EnemyMarked.OnClientEvent:Connect(function(Marked, b, c, d)
                if time() < LastCombo then
                    return
                end
                Remotes:WaitForChild("Skillset_Dragoon_InfinityStrikeStart", math.huge):FireServer()
                task.wait(0.2)
                Remotes:WaitForChild("Skillset_Dragoon_InfinityStrike", math.huge):FireServer()
                task.wait(0.2)
                Remotes:WaitForChild("Skillset_Dragoon_MultiStrike", math.huge):FireServer()
                task.wait(0.2)
                Remotes:WaitForChild("Skillset_Dragoon_DragonSlam", math.huge):FireServer()
                LastCombo = time()+9
            end)
        elseif SV.PlayerClass == "Demon" then
            local LifeSteal = Remotes:WaitForChild("Skillset_Demon_LifeSteal", math.huge)
            while SV.PlayerClass == "Demon" do
                if KillSwitch then
                    break
                end
                repeat
                    task.wait()
                until CurrentMob
                LifeSteal:FireServer({CurrentMob, CurrentMob, CurrentMob})
                task.wait(8.1)
            end
        end
    end)
    if ClassSkills then
        if ClassSkills[SV.PlayerClass].Distance == "Ranged" then
            SV.IsRanged = true
        else
            SV.IsRanged = nil
        end

        return BuildAttackData(ClassSkills, SV.PlayerClass)
    else
        SaveErrorToFile("PLAYER CLASS", "Unable to identify players class. Attack data does not exist.", SV.PlayerClass)
    end
end

SetGlobal("build shop values")
local function BuildShopValues(TargetDropdown, TargetShop)
    if type(TargetShop) == "table" then
        local ShopDisplay = {}
        local ShopReal = {}
        for Index, Data in TargetShop do
            local DisplayName = Data.VisualName.." (" .. FormatNumber(Data.CoinPrice) .. ", " ..Data.CurrencyType.. ")"
            table.insert(ShopDisplay, DisplayName)
            ShopReal[DisplayName] = { InternalName = Data.InternalName, VisualName = Data.VisualName, CoinPrice = Data.CoinPrice, CurrencyType = Data.CurrencyType}
        end
        table.sort(ShopDisplay, function(a, b)
            return ShopReal[a].CoinPrice < ShopReal[b].CoinPrice
        end)

        Options[TargetDropdown]:SetValues(ShopDisplay)
        return ShopReal
    end
    local rItems
    if SV.CanRequire then
        rItems = require(Items)
    end
    local FoundShopName = TargetShop
    local FoundShop = Shop.LocalShops:FindFirstChild(TargetShop) or nil
    if not FoundShop then
        warn("Shop \"" ..TargetShop.. "\" does not exist")
        return
    end

    local CurrencyItem = FoundShop:FindFirstChild("CurrencyItem") or nil
    if not CurrencyItem then
        warn("Could not find currency for shop \"" ..TargetShop.. "\"")
    end

    FoundShop = FoundShop:FindFirstChild("Items") or nil
    if not FoundShop then
        warn("Could not find items for \"" ..TargetShop.. "\"")
        return
    end

    local ShopDisplay = {}
    local ShopReal = {}
    for Index, Item in FoundShop:GetChildren() do
        local ItemPrice = Item.AskingPrice.Value
        local ItemName
        if rItems then
            ItemName = rItems[Item.Name].DisplayKey
        else
            ItemName = Item.Name
        end
        if #ItemName > 20 then
            ItemName = string.sub(ItemName, 1, 20):gsub("%s+$", "") .. "..."
        end
        local DisplayName = ItemName.." (" .. FormatNumber(ItemPrice) .. ")"
        table.insert(ShopDisplay, DisplayName)
        ShopReal[DisplayName] = { InternalName = Item.Name, VisualName = ItemName, CoinPrice = ItemPrice }
    end

    table.sort(ShopDisplay, function(a, b)
        return ShopReal[a].CoinPrice < ShopReal[b].CoinPrice
    end)

    ShopReal.ShopInfo = { ShopName = FoundShopName, Currency = CurrencyItem.Value }

    Options[TargetDropdown]:SetValues(ShopDisplay)
    return ShopReal
end

SetGlobal("mass item sell")
-- Per-exact-color retention. No sale/recycle is triggered by changing the toggle.
local HexRetention = {}

function HexRetention.Decode(Data)
    if Data == nil then return nil, true end
    if type(Data) ~= "table" then return nil, false end
    local RGB = {}
    for Index, Channel in ipairs({"r", "g", "b"}) do
        local Value = rawget(Data, Channel)
        if type(Value) == "string" then
            if #Value > 128 then return nil, false end
            local Text = Value:match("^%s*(.-)%s*$")
            if Text == "" or Text:find("[^%d%.eE%+%-]") then return nil, false end
            Value = tonumber(Text)
        end
        if type(Value) ~= "number" or Value ~= Value or Value < 0 or Value > 1 then
            return nil, false
        end
        RGB[Index] = Value
    end
    return Color3.new(RGB[1], RGB[2], RGB[3]):ToHex():lower(), true
end

function HexRetention.Patterns()
    local Patterns = {}
    for _, Hex in ipairs(SV.SpecialHexColors) do table.insert(Patterns, Hex:lower()) end
    local Input = Options.SaveUserHexesInput and Options.SaveUserHexesInput.Value or ""
    for Pattern in tostring(Input):lower():gsub("#", ""):gmatch("[^,]+") do
        Pattern = Pattern:match("^%s*(.-)%s*$")
        if Pattern ~= "" then
            if not pcall(string.match, "000000", "^" .. Pattern) then return nil end
            table.insert(Patterns, Pattern)
        end
    end
    return Patterns
end

-- Count only selected items. Unselected items never consume their retention quota.
function HexRetention.Plan(Records, Limited)
    table.sort(Records, function(A, B)
        local RankA = A.Protected and 1 or (not A.Selected and 2 or 3)
        local RankB = B.Protected and 1 or (not B.Selected and 2 or 3)
        if RankA ~= RankB then return RankA < RankB end
        return A.UUID < B.UUID
    end)
    local Counts, Plan = {}, {}
    local SpecialExcess, Ordinary, KeptSpecial, ProtectedSelected = 0, 0, 0, 0
    for _, Record in ipairs(Records) do
        local Keep = Record.Protected or not Record.Selected
        if Record.Special and Record.Selected then
            Counts[Record.Hex] = (Counts[Record.Hex] or 0) + 1
            Keep = Keep or not Limited or Counts[Record.Hex] <= 10
            if Keep then KeptSpecial = KeptSpecial + 1 end
        end
        if Record.Selected and Record.Protected then ProtectedSelected = ProtectedSelected + 1 end
        if Record.Selected and not Keep then
            table.insert(Plan, {UUID = Record.UUID, Name = Record.Name})
            if Record.Special then SpecialExcess = SpecialExcess + 1 else Ordinary = Ordinary + 1 end
        end
    end
    -- Enforce retention independently of the running quota before exposing a plan.
    local Planned, SelectedByHex, RemainingByHex = {}, {}, {}
    for _, Item in ipairs(Plan) do Planned[Item.UUID] = true end
    for _, Record in ipairs(Records) do
        if Record.Selected and Record.Special then
            SelectedByHex[Record.Hex] = (SelectedByHex[Record.Hex] or 0) + 1
            if not Planned[Record.UUID] then
                RemainingByHex[Record.Hex] = (RemainingByHex[Record.Hex] or 0) + 1
            end
        end
    end
    for Hex, Total in pairs(SelectedByHex) do
        local Minimum = Limited and math.min(10, Total) or Total
        if (RemainingByHex[Hex] or 0) < Minimum then
            error("retention invariant failed")
        end
    end
    return Plan, SpecialExcess, Ordinary, KeptSpecial, ProtectedSelected
end

function HexRetention.Run(Method, SelectedItems, PreviewOnly)
    if Method ~= "Recycle" and Method ~= "Gold" then return end
    if type(SelectedItems) ~= "table" or type(SV.RealCosmeticTable) ~= "table" then
        Library:Notify("請先掃描外觀，再選取要處理的外觀。", 5)
        return
    end
    if not SV.CanRequire then
        Library:Notify("此環境不支援讀取物品資料，已停止操作。", 5)
        return
    end
    local Patterns = HexRetention.Patterns()
    if not Patterns then Library:Notify("輸入的色碼規則無效，已停止操作。", 5); return end
    local Allowed, SelectedCount = {}, 0
    for VisualName, Group in pairs(SV.RealCosmeticTable) do
        if SelectedItems[VisualName] then
            for _, Item in pairs(Group) do
                if type(Item.UUID) ~= "string" or type(Item.Name) ~= "string" then
                    Library:Notify("掃描資料異常，請重新掃描。", 5)
                    return
                end
                Allowed[Item.UUID] = Item.Name
                SelectedCount = SelectedCount + 1
            end
        end
    end
    if SelectedCount == 0 then Library:Notify("請先掃描並選取至少一種外觀。", 5); return end
    local Definitions = require(Items)
    if type(Definitions) ~= "table" then Library:Notify("物品資料異常，已停止操作。", 5); return end
    local ById = {}
    for Name, Definition in pairs(Definitions) do
        if type(Definition) == "table" and Definition.ID ~= nil
            and Definition.Type ~= "Emote" and Definition.Type ~= "Title"
            and Definition.Type ~= "Furniture" and Definition.Type ~= "Consumable" then
            if ById[Definition.ID] then Library:Notify("物品資料重複，已停止操作。", 5); return end
            ById[Definition.ID] = tostring(Name)
        end
    end
    -- Always plan from a fresh read; the scan is only the explicit allowed selection.
    local LiveInventory = Remotes.Profile_GetCosmetics:InvokeServer()
    if type(LiveInventory) ~= "table" then Library:Notify("無法讀取最新背包，已停止操作。", 5); return end
    local Records, Seen = {}, {}
    for _, Item in pairs(LiveInventory) do
        if type(Item) ~= "table" then Library:Notify("背包物品資料異常，已停止操作。", 5); return end
        local Hex, ColorOk = HexRetention.Decode(rawget(Item, "d"))
        if not ColorOk then
            Library:Notify("背包色碼資料無法確認，已停止操作，沒有出售或回收。", 7)
            return
        end
        local Name = ById[Item.id]
        if Name then
            if type(Item.uuid) ~= "string" or Item.uuid == "" or Seen[Item.uuid] then
                Library:Notify("背包物品資料異常，已停止操作。", 5)
                return
            end
            Seen[Item.uuid] = true
            local Special = false
            if Hex then
                for _, Pattern in ipairs(Patterns) do
                    if Hex:match("^" .. Pattern) then Special = true; break end
                end
            end
            -- Preserve the base's lock/favourite protection. Also honour explicit equip flags.
            local Protected = not not (Item.lock or Item.fav or Item.equipped or Item.equip)
            table.insert(Records, {UUID = Item.uuid, Name = Name, Hex = Hex,
                Special = Special, Protected = Protected, Selected = Allowed[Item.uuid] == Name})
        end
    end
    local Limited = Toggles.KeepTenPerSpecialHex and Toggles.KeepTenPerSpecialHex.Value == true
    local Plan, SpecialExcess, Ordinary, KeptSpecial, ProtectedSelected = HexRetention.Plan(Records, Limited)
    local Mode = Limited and "每色保留10件" or "特殊色全部保留"
    if PreviewOnly then
        local Planned, Stats = {}, {}
        for _, Item in ipairs(Plan) do Planned[Item.UUID] = true end
        for _, Record in ipairs(Records) do
            local Color = Record.Hex or "<無染色>"
            local Row = Stats[Color]
            if not Row then
                Row = {Selected = 0, Keep = 0, Remove = 0, Special = Record.Special, Other = 0}
                Stats[Color] = Row
            end
            if Record.Selected then
                Row.Selected = Row.Selected + 1
                if Planned[Record.UUID] then Row.Remove = Row.Remove + 1 else Row.Keep = Row.Keep + 1 end
            else
                Row.Other = Row.Other + 1
            end
        end
        warn("[WZF][KEEP10] 預覽版本 selected-v3；模式:", Mode)
        local Colors = {}
        for Color, Row in pairs(Stats) do
            if Row.Selected > 0 then table.insert(Colors, Color) end
        end
        table.sort(Colors)
        for Index, Color in ipairs(Colors) do
            if Index > 50 then warn("[WZF][KEEP10] 其餘色碼省略；本次未實際處理。"); break end
            local Row = Stats[Color]
            warn("[WZF][KEEP10] 色碼:", Color, "辨識為特殊色:", Row.Special,
                "選取件數:", Row.Selected, "選取中預計保留:", Row.Keep,
                "選取中預計處理:", Row.Remove, "其他同色件數:", Row.Other)
        end
        Library:Notify("預覽（" .. Mode .. "）：特殊色超額 " .. SpecialExcess
            .. " 件；一般色／無色 " .. Ordinary .. " 件；合計待處理 " .. #Plan
            .. " 件。選取中受保護 " .. ProtectedSelected .. " 件。沒有出售或回收。", 12)
        return
    end
    if #Plan == 0 then
        Library:Notify("沒有需要處理的物品（" .. Mode .. "）。", 5)
        return
    end
    -- No yielding wait between the completed plan validation and the send.
    local Remote = Remotes:FindFirstChild(Method == "Recycle" and "Recycler_Recycle" or "Drops_SellItems")
    if not Remote then Library:Notify("找不到處理功能，已停止操作。", 5); return end
    if Method == "Recycle" then
        Remote:FireServer(Plan)
    else
        Remote:InvokeServer(Plan)
    end
    Library:Notify("已送出" .. (Method == "Recycle" and "回收" or "出售") .. "請求，共 " .. #Plan
        .. " 件。請重新掃描確認實際結果。", 8)
end

local function RecycleFromInventory(Method, SelectedItems, PreviewOnly)
    if HexRetention.Busy then Library:Notify("正在讀取或處理背包，請稍候。", 5); return end
    HexRetention.Busy = true
    local Ok = pcall(HexRetention.Run, Method, SelectedItems, PreviewOnly == true)
    HexRetention.Busy = false
    if not Ok then
        -- Do not retry destructive requests: an interrupted response can already be applied.
        Library:Notify("處理中斷，請先檢查背包並重新掃描；不要連續重試。", 7)
    end
end

SetGlobal("item sell check")
local function ItemSellCheck(NewItem, ManualSell) -- only called NewItem because I didn't want to change it all
    local IsDebug = ISV.Debug
    local Success, Result = pcall(function()
        SellItemCheck = SellItemCheck + 1
        if IsDebug then
            print(string.format(
                "Sending item %s through sell process",
                NewItem and NewItem.Name or "[UNABLE TO GET NAME, ITEM DOES NOT EXIST?]"
            ))
        end

        if SV.CanRequire then
            if not SV.Charms then
                SV.Charms = require(Charms:WaitForChild("Charms"))
            end
            if not SV.Items then
                SV.Items = require(Items)
            end
        end

        if EquipInProgress ~= 0 then
            repeat task.wait() until EquipInProgress == 0
            if not NewItem or not NewItem.Parent or not NewItem.Parent.Name then
                SellItemCheck = SellItemCheck - 1
                return
            end
            if NewItem.Parent.Name ~= "Items" then
                SellItemCheck = SellItemCheck - 1
                return
            end
        end

        local Count = NewItem:FindFirstChild("Count")
        local Locked = NewItem:FindFirstChild("Locked")
        local Favorited = NewItem:FindFirstChild("Favorited")
        local GiftWrap = NewItem:FindFirstChild("GiftWrap")
        if Count or Locked or Favorited or GiftWrap then
            if IsDebug then
                print(string.format(
                    "JDRS: Didn't sell %*, %*",
                    NewItem, Count or Locked or Favorited or GiftWrap
                ))
            end
            SellItemCheck = SellItemCheck - 1
            return
        end

        if not NewItem or not NewItem.Name then
            if IsDebug then
                print("JDRS: item had no name")
            end
            SellItemCheck = SellItemCheck - 1
            return
        end

        local NewItemName = tostring(NewItem.Name)
        local XP  = NewItem:FindFirstChild("XP") or string.find(NewItemName, "Pet")
        if XP and not SV.IncludePets then
            if IsDebug then
                print(string.format(
                    "JDRS: didn't sell %*, pet",
                    NewItem
                ))
            end
            SellItemCheck = SellItemCheck - 1
            return
        end

        local IsCharm
        if SV.Charms and SV.Charms[NewItem.Name] then
            IsCharm = true
            if not SV.IncludeCharms then
                if IsDebug then
                    print(string.format(
                        "JDRS: didn't sell %*, charm",
                        NewItem
                    ))
                end
                SellItemCheck = SellItemCheck - 1
                return
            end
        end

        local KeepItem = false
        local ItemRarity, AmountOfPerks = GetRarity(NewItem)
        if not IsCharm and tostring(ItemRarity) ~= "NotEquipment" then
            if ItemRarity == 7 then
                if IsDebug then
                    print(string.format(
                        "JDRS: didn't sell %*, Zero Gear",
                        NewItem
                    ))
                end
                return
            elseif not KeepTier then
                SellItem(NewItem, string.format(
                    "Selling %* because no tier is selected to be saved (%*)",
                    NewItem, KeepTier
                ))
                return
            elseif ItemRarity < KeepTier then
                SellItem(NewItem, string.format(
                    "Selling %* because it is tier %* and tier %* or above is selected",
                    NewItem, ItemRarity, KeepTier
                ))
                return
            end
            KeepItem = true
        end

        if SV.SellTowerEggs and IsTowerEgg(NewItem) then
            SellItem(NewItem, string.format(
                "Selling %* because it is listed as a tower egg",
                NewItem
            ))
            return
        end

        local Egg = table.find(SV.EggList, NewItemName) or false
        local SavedPerkName = false
        local SavedPerkValue = false
        local FoundPerfectPerk = false
        local ItemPerks = {}
        if not Egg and AmountOfPerks and AmountOfPerks > 0 then
            if SV.KeepPerks and SV.SelectedPerks then
                for PerkNumber = 1, AmountOfPerks do
                    if FoundPerfectPerk then break end
                    local PerkString = "Perk" ..tostring(PerkNumber)
                    local PerkName = NewItem:WaitForChild(PerkString, 10)
                    if PerkName then
                        repeat 
                            task.wait()
                        until PerkName.Value and PerkName.Value ~= ""
                        local PerkValue = PerkName:WaitForChild("PerkValue", 10)
                        if PerkValue then
                            repeat 
                                task.wait()
                            until PerkValue.Value and PerkValue.Value ~= ""
                            PerkValue = FormatDecimal(PerkValue.Value)
                            if IsDebug then
                                table.insert(ItemPerks, string.sub(PerkName.Value, 1, 7) .. ": " ..PerkValue)
                            end

                            local IsSelectedPerk = SV.SelectedPerks[PerkName.Value]
                            if IsSelectedPerk then
                                local PerkPercentage = IsSelectedPerk.PerkValue
                                local PetPerkPercentage = IsSelectedPerk.PetPerkValue or nil
                                if IsSelectedPerk.LowerMax then
                                    PerkPercentage = FormatDecimal(PerkPercentage + OffsetMax)
                                    if PetPerkPercentage then
                                        PetPerkPercentage = FormatDecimal(PetPerkPercentage + OffsetMax)
                                    else
                                        PetPerkPercentage = PerkPercentage
                                    end
                                else
                                    PerkPercentage = FormatDecimal(PerkPercentage - OffsetMax)
                                    if PetPerkPercentage then
                                        PetPerkPercentage = FormatDecimal(PetPerkPercentage - OffsetMax)
                                    else
                                        PetPerkPercentage = PerkPercentage
                                    end
                                end

                                --print(IsSelectedPerk.PerkName, PerkName.Value, PerkName.Value == IsSelectedPerk.PerkName, PerkValue, PerkPercentage, PerkValue >= PerkPercentage)
                                local PerkMatches = (not IsSelectedPerk.LowerMax and PerkValue >= PerkPercentage) or (IsSelectedPerk.LowerMax and PerkValue <= PerkPercentage)
                                local PetPerkMatches = (XP or IsCharm) and (not IsSelectedPerk.LowerMax and PerkValue >= PetPerkPercentage) or (IsSelectedPerk.LowerMax and PerkValue <= PetPerkPercentage)
                                if PerkMatches or PetPerkMatches then
                                    SavedPerkName = IsSelectedPerk.VisualName
                                    SavedPerkValue = math.round(PerkValue * 100)
                                    FoundPerfectPerk = true
                                    KeepItem = true
                                    break
                                else
                                    KeepItem = nil
                                end
                            else
                                KeepItem = nil
                            end
                        end
                    else
                        SaveErrorToFile("UNABLE TO FIND PERK", string.format(
                            "Waiting for perk #%d exceeded maximum allowed time of 10 seconds, does %s, have %d perks?",
                            PerkNumber, NewItemName, AmountOfPerks
                        ), string.format(
                            "Item is tier %d and was flagged as having %d perks",
                            ItemRarity, AmountOfPerks
                        ))
                    end
                end
            end
        end

        if not (Egg or KeepItem or FoundPerfectPerk) then
            SellItem(NewItem, string.format(
                "Selling %*, %*",
                NewItem, ItemPerks and #ItemPerks > 0 and table.concat(ItemPerks, ", ") or "item type not defined in script"
            ))
            return
        else
            if not ManualSell then
                Library:Notify("<font color='#80FF80'>Kept item:</font> " ..NewItemName, 1)
            end
            SellItemCheck = SellItemCheck - 1
        end

        if ManualSell then
            return
        end

        Egg = table.find({ "AetherEgg", "CupidEgg", "SkeletonEgg", "SantaEgg" }, NewItemName) or false
        if Egg or FoundPerfectPerk and SV.DiscordWebhookLink and SV.PerkPing then
            local Message
            if Egg then
                Message = "Kept item **" ..NewItemName.. "**! " ..DiscordPingType
            elseif FoundPerfectPerk then
                Message = "Kept **" ..NewItemName.. "** because **" ..tostring(SavedPerkName).. " " ..tostring(SavedPerkValue).. "%** was found!" ..DiscordPingType
            end
            pcall(function()
                local MessageContent = {
                    ["username"] = "Drop Logger",
                    ["content"] = Message
                }
                RequestMessage(SV.DiscordWebhookLink, MessageContent, false)
            end)
            return
        end
    end)
    if not Success then
        local ExtraMessage
        if not SV then
            ExtraMessage = "script unloaded before an item could be sold"
        end
        SaveErrorToFile("FAILURE TO SELL ITEM", Result, ExtraMessage)
    end
end

SetGlobal("check score")
local function GetLeaderboardScore(Leaderboard, TotalLabel, DailyLabel, TotalAllowed, DailyAllowed, EventBoss)
    local SelectedLeaderboard = tostring(Leaderboard)
    if EventBoss then
        local Date = os.date("*t")
        local Year = Date["year"]
        SelectedLeaderboard = SelectedLeaderboard.. tostring(Year)
    end

    local GetScore = Remotes:WaitForChild("LeaderboardHookup_GetScore", math.huge)
    LeaderboardData = GetScore:InvokeServer(SelectedLeaderboard, 1)
    if not LeaderboardData then
        LeaderboardData = GetScore:InvokeServer(SelectedLeaderboard, 5)
    end

    if not LeaderboardData then
        TotalLabel:SetText("Total: NO DATA")
        DailyLabel:SetText("Daily: NO DATA")
        return
    end
    local TotalScore = tonumber(LeaderboardData[1])
    local DailyScore = tonumber(LeaderboardData[2])

    TotalLabel:SetText("Total: " ..FormatNumber(TotalScore))
    DailyLabel:SetText("Daily: " ..FormatNumber(DailyScore))

    if (TotalAllowed and TotalScore and TotalScore >= TotalAllowed) or (DailyAllowed and DailyScore and DailyScore >= DailyAllowed) then
        Library:Notify("Limit reached, if you update the limit please restart the dungeon to continue.")
        return true
    end
end

SetGlobal("create toggles")
local function CreateToggles(ToggleTable)
    for Index, Data in ToggleTable do
        local FunctionValue = Data.FunctionValue or nil
        local DataTable = {
            Text = Data.Text,
            Default = if Data.Button then nil else false,
            Tooltip = Data.Tooltip or nil
        }
        if Data.AttachedFunction then
            if not Data.Button then
                DataTable.Callback = function(ChangedValue)
                    Data.AttachedFunction(ChangedValue, FunctionValue)
                end
            else
                DataTable.Func = function(ChangedValue)
                    Data.AttachedFunction(FunctionValue, ChangedValue)
                end
            end
        end

        if not Data.Button then
            Data.Tab:AddToggle(tostring(Data[1]), DataTable)
        else
            Data.Tab:AddButton(DataTable)
        end
    end
end

SetGlobal("getting obsidian Library")
if SV.BadExecutor then
    Library = SaveScriptToFiles("https://raw.githubusercontent.com/justdoingrandomstuff/old_obsidian_library/main/old_library", "L", 1)
else
    Library = SaveScriptToFiles("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/Library.lua", "L", 1)
end

Options = Library.Options
Toggles = Library.Toggles

SetGlobal("creating window")
local Window = Library:CreateWindow({
    Title = "World Zero",
    Footer = "大哥，阿成，揚，99，有米，八八八，哲，洛克，June，宸宸 版本號:V1.1.4 2026/11/13",
    Icon = 17210785932,
    NotifySide = "Right",
    AutoShow = false,
    ShowCustomCursor = false,
    ToggleKeybind = Enum.KeyCode.Zero,
    EnableCompacting = true
})
Window:SetCornerRadius(20)

if not SV.GeneralTab then -- for unloaded general tab
SetGlobal("creating general tab")
local GenTab = Window:AddTab({
    Name = "主要",
    Icon = "rbxassetid://9671045892"
})
if IsMainMenu or IsWorld then
    GenTab:UpdateWarningBox({
        Title = "提醒",
        Text = "在地下城以外的區域，多數功能將受到限制；為避免異常，已停用大部分功能。",
        IsNormal = false,
        Visible = true,
        LockSize = true
    })
end
local LeftTab = GenTab:AddLeftTabbox("Left Tabbox")
    local FirstTab = LeftTab:AddTab("主要")
    local SecondTab = LeftTab:AddTab("設定")
local RightTab = GenTab:AddRightTabbox("Right Tabbox")
    local ThirdTab = RightTab:AddTab("額外")
    local FourthTab = RightTab:AddTab("設定")

local function ToggleKillaura(ChangedValue)
    if ChangedValue then
        Toggles.KillauraToggle:SetDisabled(true)
        Toggles.KillauraToggle:SetText("<font color='#FF3333'>殺戮光環</font>")
    else
        Toggles.KillauraToggle:SetDisabled(false)
        Toggles.KillauraToggle:SetText("<font color='#ffffff'>殺戮光環</font>")
    end
end
local function ToggleSafeKillaura(ChangedValue)
    if ChangedValue then
        Toggles.SafeKillauraToggle:SetDisabled(true)
        Toggles.SafeKillauraToggle:SetText("<font color='#FF3333'>安全殺戮光環</font>")
    else
        Toggles.SafeKillauraToggle:SetDisabled(false)
        Toggles.SafeKillauraToggle:SetText("<font color='#ffffff'>安全殺戮光環</font>")
    end
end

CreateToggles({
    { "KillauraToggle", Text = "殺戮光環", Tab = FirstTab, AttachedFunction = ToggleSafeKillaura },
    { "SafeKillauraToggle", Text = "安全殺戮光環", Tab = FirstTab, AttachedFunction = ToggleKillaura },
    { "AutoProgressToggle", Text = "自動跟隨怪物", Tab = FirstTab },
    { "CollectDropToggle", Text = "自動收集掉落物", Tab = ThirdTab },
    { "PetKillauraToggle", Text = "寵物殺戮光環", Tooltip = "容易被反作弊系統偵測到！使用風險自負！", Tab = ThirdTab },
    { "RestartStuckToggle", Text = "卡住自動重啟", Tooltip = "如果你長時間停止造成傷害，這個開關會認為你被困住了，並嘗試重新開始地牢。", Tab = ThirdTab },
    { "DodgeLethalToggle", Text = "躲避致命傷害", Tooltip = "限近戰職業。即使關閉此功能，部分攻擊仍可能自動閃避。", Tab = ThirdTab },
    { "AutoPrestigeToggle", Text = "自動轉生", Tooltip = "當你達到 160 級時，腳本會將你傳送到世界 1，進行聲望提升，然後進入螃蟹十字軍。", Tab = ThirdTab }
})
SecondTab:AddLabel("帳戶延遲", true)
SecondTab:AddSlider("PingSlider", {
    Text = "延遲 (Ping)",
    Suffix = "%",
    Default = 100,
    Min = 0,
    Max = 200,
    Rounding = 0,
    Compact = true,
    Tooltip = "根據您的網路延遲，增加每次攻擊的延遲時間。這可能有助於減少被踢出遊戲的情況。 \n不適用於安全殺戮光環",
    Callback = function(ChangedValue)
        PingMultiplier = ChangedValue / 100
    end
})
SecondTab:AddLabel("殺戮光環攻擊延遲", true)
SecondTab:AddSlider("AttackDelaySlider", {
    Text = "秒數",
    Default = 0,
    Min = 0,
    Max = 2,
    Rounding = 2,
    Compact = true,
    Tooltip = "增加每次攻擊的延遲時間。 \n不適用於安全殺戮光環",
    Callback = function(ChangedValue)
        AddedDelay = ChangedValue
    end
})
SecondTab:AddLabel("攻擊間隔", true)
SecondTab:AddSlider("DelayAttackSlider", {
    Text = "秒數",
    Default = 0,
    Min = 0,
    Max = 0.5,
    Rounding = 2,
    Compact = true,
    Tooltip = "添加時間後，腳本將在執行攻擊之間等待設置的時間。當與 Boss 戰鬥時，這個設定會被完全忽略。",
    Callback = function(ChangedValue)
        if ChangedValue == 0 then
            DelayAttacks = false
        else
            DelayAttacks = ChangedValue
        end
    end
})
SecondTab:AddLabel("怪物傳送旋轉速度", true)
SecondTab:AddSlider("MobRotationSpeedSliderNew", {
    Text = "距離 (Studs)",
    Default = 20,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Compact = true,
    Tooltip = "控制角色傳送至怪物附近時旋轉的速度。如果設定得太快，且你使用的是近戰職業，腳本可能無法有效地對怪物造成傷害。",
    Callback = function(ChangedValue)
        MobRotationSpeed = ChangedValue
    end
})
FourthTab:AddLabel("寵物殺戮光環延遲", true)
FourthTab:AddSlider("DelayPetAttackSlider", {
    Text = "秒數",
    Default = 0,
    Min = 0,
    Max = 2,
    Rounding = 2,
    Compact = true,
    Tooltip = "控制使用「寵物殺戮光環」開關時寵物攻擊之間的延遲。",
    Callback = function(ChangedValue)
        if ChangedValue == 0 then
            DelayPetAttacks = false
        else
            DelayPetAttacks = ChangedValue
        end
    end
})
FourthTab:AddLabel("錯誤延遲重新加入", true)
FourthTab:AddSlider("RestartStuckSlider", {
    Text = "秒數",
    Default = StuckDelay,
    Min = 30,
    Max = 120,
    Rounding = 0,
    Compact = true,
    Tooltip = "控制當地牢或腳本中的某些東西損壞或產生Bug導致你無法完成地牢時，腳本重新加入地牢所需的時間。",
    Callback = function(ChangedValue)
        StuckDelay = ChangedValue
    end
})
end -- for unloaded general tab

if not SV.EventTab then -- for unloaded event tab
SetGlobal("event tab")
local EventTabIconTable = {
    [1] = "rbxassetid://8202463897",
    [2] = "rbxassetid://8723477744",
    [3] = "rbxassetid://8723477744",
    [4] = "rbxassetid://9299343400",
    [5] = "rbxassetid://9299343400",
    [6] = "rbxassetid://11582306327",
    [7] = "rbxassetid://11582306327",
    [8] = "rbxassetid://124707423544340",
    [9] = "rbxassetid://124707423544340",
    [10] = "rbxassetid://5763863934",
    [11] = "rbxassetid://81638085579862",
    [12] = "rbxassetid://8202463897"
}
local EventTab = Window:AddTab({
    Name = "活動",
    Icon = EventTabIconTable[os.date("*t").month]
})
local LeftTab = EventTab:AddLeftTabbox("Left Tabbox")
    local FirstTab = LeftTab:AddTab("Boss 戰鬥")
    local SecondTab = LeftTab:AddTab("進階")
local RightTab = EventTab:AddRightTabbox("Right Tabbox")
    local ThirdTab = RightTab:AddTab("轉盤")
    local FourthTab = RightTab:AddTab("通行證")
    local FifthTab = RightTab:AddTab("其他")

FirstTab:AddToggle("CollectBuffToggle", {
    Text = "自動拾取選定增益",
    Default = false,
    Tooltip = "從下方選單指定要自動拾取的增益效果。"
})
FirstTab:AddDropdown("OrbBuffDropdown", {
    Values = {
        DamageBuffOrb = "傷害提升",
        UltChargeBuffOrb = "終極技能充能",
        HealthBuffOrb = "治療",
        DefenseBuffOrb = "護盾"
    },
    Multi = true,
    AllowNull = true,
    Default = "",
    MaxVisibleDropdownItems = 5,
    Searchable = true,
    Callback = function(ChangedValue)
        if IsDungeon and Options.OrbBuffDropdown:GetActiveValues(true) > 0 then
            SV.SelectedOrbs = ChangedValue
        else
            SV.SelectedOrbs = nil
        end
    end
})
local TotalLabel, TotalAllowed
local DailyLabel, DailyAllowed
SecondTab:AddDropdown("EventBossDropdown", {
    Values = {
        CUPID_KILLS_ = "Cupid",
        EASTERBUNNY_KILLS_ = "Easter Bunny",
        KRAKEN_KILLS_ = "Kraken",
        VANE_KILLS_ = "Vane",
        FALLENKING_KILLS_ = "Fallen King",
        SANTA_KILLS_ = "Korrupted Klaus"
    },
    Multi = false,
    AllowNull = false,
    Default = "",
    Text = "選擇活動 Boss",
    Searchable = true,
    Callback = function(ChangedValue)
        if IsWorld or IsDungeon and ChangedValue then
            task.wait(1)
            if GetLeaderboardScore(ChangedValue, TotalLabel, DailyLabel, TotalAllowed, DailyAllowed, true) then
                Library:Notify("活動 Boss 次數已達上限。", 999999999)
                local TempStop = true
                local CanTarget = false
            end
        end
    end
})
TotalLabel = SecondTab:AddLabel("累計：？", false)
SecondTab:AddInput("TotalEventInput", {
    Text = "累計擊殺達 X 次停止",
    Default = "",
    Placeholder = "請輸入數字",
    Callback = function(ChangedValue)
        if IsDungeon then
            TotalAllowed = ChangedValue
        end
    end
})
    SecondTab:AddDivider({Margin = -5})
DailyLabel = SecondTab:AddLabel("今日：？", false)
SecondTab:AddInput("DailyEventInput", {
    Text = "今日擊殺達 X 次停止",
    Default = "",
    Placeholder = "請輸入數字",
    Callback = function(ChangedValue)
        if IsDungeon then
            DailyAllowed = ChangedValue
        end
    end
})
local CoinSpinLabel = ThirdTab:AddLabel("金幣花費：5", true)
local SpinCount = 1
ThirdTab:AddInput("WheelSpinInput", {
    Text = "轉盤次數",
    Default = 1,
    Placeholder = "1",
    Tooltip = "如果輸入的轉盤次數超過現有金幣可負擔的次數，腳本會嘗試執行可負擔的最大次數。",
    Callback = function(ChangedValue)
        -- Obsidian inputs may return the text "10000" rather than number 10000.
        local raw = tostring(ChangedValue)
        local cleaned = raw:gsub(",", "")
        local amount = tonumber(cleaned)

        if amount and amount >= 1 and amount < math.huge and amount % 1 == 0 then
            SpinCount = amount
            local totalCost = amount * 5
            CoinSpinLabel:SetText("金幣花費：" .. FormatNumber(totalCost))
        else
            SpinCount = 0
            CoinSpinLabel:SetText("金幣花費：<font color=\"rgb(255, 0, 0)\">無效數字</font>")
        end
    end
})
ThirdTab:AddButton({
    Text = "開始轉盤",
    Tooltip = "大量連續轉盤可能導致卡頓，請謹慎使用。",
    DoubleClick = true,
    Func = function()
        local JoinQueue = Remotes:FindFirstChild("EventSpinner_JoinQueue")
        for Spin = 1, SpinCount do
            JoinQueue:FireServer(LocalPlayer)
            task.wait()
        end
    end
})
    ThirdTab:AddDivider({Margin = -5})
local RecyclingItems
ThirdTab:AddButton({
    Text = "回收轉盤物品",
    Tooltip = "回收未上鎖且沒有特殊色碼的轉盤物品。\n\n<font color=\"rgb(255, 0, 0)\">物品過多可能造成遊戲崩潰；重新加入後物品可能已完成回收。</font>",
    DoubleClick = true,
    Func = function()
        if IsMainMenu or RecyclingItems then
            return
        end
        RecyclingItems = true
        if not SV.CanRequire then
            Library:Notify("執行環境不支援此功能（缺少 require()）", 5)
            return
        end

        local Profile_GetCosmetics = Remotes.Profile_GetCosmetics:InvokeServer()
        local rItems = require(Items)
        local ItemTable = {}
        local RealItemTable = {}
        local ScannedItems = {}
        local SelectedItems = {}

        -- create the table to look up items by their id's
        for Index, Item in SV.WheelItems do
            local ItemData = rItems[Item]
            if ItemData then
                ItemTable[ItemData.ID] = {
                    VisualName = tostring(ItemData.DisplayKey),
                    InternalName = tostring(Item)
                }
                SelectedItems[ItemData.DisplayKey] = true
            end
        end

        for Index, ItemData in Profile_GetCosmetics do
            local ScanHex, ScanColorOk
            if type(ItemData) == "table" then
                ScanHex, ScanColorOk = HexRetention.Decode(ItemData.d)
            end
            if not ScanColorOk then
                SV.RealCosmeticTable = nil
                RecyclingItems = nil
                Library:Notify("色碼資料無法確認，已停止掃描，沒有出售或回收。", 7)
                return
            end
            if ItemData.lock or ItemData.fav then
                continue
            end
            local ItemRef = ItemTable[ItemData.id]
            if not ItemRef then
                continue
            end
            local VisualName = ItemRef.VisualName
            if not ScannedItems[VisualName] then
                ScannedItems[VisualName] = true
                RealItemTable[VisualName] = {}
            end
            if not ItemData.d then
                table.insert(RealItemTable[VisualName], {
                    UUID = ItemData.uuid,
                    Name = ItemRef.InternalName
                })
            else
                table.insert(RealItemTable[VisualName], {
                    UUID = ItemData.uuid,
                    Name = ItemRef.InternalName,
                    Dye = ScanHex
                })
            end
        end

        SV.RealCosmeticTable = RealItemTable
        RecycleFromInventory("Recycle", SelectedItems)
        RecyclingItems = nil
    end
})
FourthTab:AddToggle("AutoClaimBattlepass", {
    Text = "自動領取通行證獎勵",
    Default = false,
    Tooltip = "此功能只會在啟用時嘗試領取一次。通行證升級後，請等待下次傳送或關閉再開啟。"
})
do
    local Success, Result = pcall(function()
        if EF.Desync and EF.RaknetFunction and EF.RaknetFunction.is_enabled() then
            FifthTab:AddLabel("可隱形傳送： <font color='#33ff33'>是</font>", false)
        else
            FifthTab:AddLabel("可隱形傳送： <font color='#ff3333'>否</font>", false)
        end
    end)
    if not Success then
        FifthTab:AddLabel("可隱形傳送： <font color='#ff3333'>錯誤</font>", false)
    end
end
    FifthTab:AddDivider({Margin = -5})
local FindingHidden
local DailyESP
FifthTab:AddLabel("每日獎勵", false)
FifthTab:AddButton({
    Text = "傳送",
    Tooltip = "傳送到活動中心的每日獎勵位置，包括障礙關卡終點、每日獎勵與三個隱藏物件。\n若無法隱形傳送，角色會直接移動到各個位置。",
    Func = function()
        local Success, Result = pcall(function()
            if FindingHidden or IsMainMenu then
                return
            end
            local EventFinderReward = Workspace:FindFirstChild("EventFinderReward", true)
            if not EventFinderReward then
                Library:Notify("請先前往活動中心（若目前有開放）。", 5)
                return
            end
            FindingHidden = true
            CheckForCharacter()
            local DailiesToTeleportTo = {}

            if EventFinderReward then
                for Index, Object in EventFinderReward.Models:GetChildren() do
                    table.insert(DailiesToTeleportTo, Object.PrimaryPart)
                end
            end

            local EventObbyReward = Workspace:FindFirstChild("EventObbyReward", true)
            if EventObbyReward then
                table.insert(DailiesToTeleportTo, EventObbyReward.Base)
            end
            
            local EventDailyReward = Workspace:FindFirstChild("EventDailyReward", true)
            if EventDailyReward then
                table.insert(DailiesToTeleportTo, EventDailyReward.Base)
            end
            
            if EF.Desync and EF.RaknetFunction.is_enabled() then
                EF.Desync(true)
                Remotes:WaitForChild("Health_Reset", math.huge):FireServer()
                task.wait(1)
                Remotes:WaitForChild("Health_Reset", math.huge):FireServer()
                LocalPlayer.CharacterAdded:Wait()
                task.wait(1)
            end

            Remotes:WaitForChild("SetMounted", math.huge):FireServer(true)
            task.wait(1)
            for Index, Object in DailiesToTeleportTo do
                PlayerRoot.CFrame = CFrame.new(Vector3.new(Object.Position.X, Object.Position.Y + (Object.Size.Y / 2), Object.Position.Z))
                task.wait(0.5)
            end

            local Spawn = Workspace:FindFirstChild("Spawn")
            local SpawnSize = Spawn.Size.Y / 2
            local SpawnPosition = Vector3.new(Spawn.Position.X, Spawn.Position.Y+SpawnSize, Spawn.Position.Z)
            PlayerRoot.CFrame = CFrame.new(SpawnPosition)
            task.wait(1)
            Remotes:WaitForChild("SetMounted", math.huge):FireServer(false)
            if EF.Desync and EF.RaknetFunction.is_enabled() then
                EF.Desync(false)
            end
            CollectCoins()
            FindingHidden = nil
        end)
        if not Success then
            SaveErrorToFile("TELEPORT DAILY REWARDS", Result)
        end
    end
}):AddButton({
    Text = "高亮標示 (ESP)",
    Tooltip = "若活動中心有隱藏每日獎勵，將在其周圍顯示高亮標記。",
    Func = function()
        local EventFinderReward = Workspace:FindFirstChild("EventFinderReward", true)
        if not EventFinderReward then
            Library:Notify("請先前往活動中心（若目前有開放）。", 5)
            return
        end
        if DailyESP then
            return
        end

        DailyESP = true
        local DailiesToESP = {}
        if EventFinderReward then
            for Index, Object in EventFinderReward.Models:GetChildren() do
                table.insert(DailiesToESP, Object)
            end
        end

        local EventObbyReward = Workspace:FindFirstChild("EventObbyReward", true)
        if EventObbyReward then
            table.insert(DailiesToESP, EventObbyReward.Base)
        end
        
        local EventDailyReward = Workspace:FindFirstChild("EventDailyReward", true)
        if EventDailyReward then
            table.insert(DailiesToESP, EventDailyReward.Base)
        end
        for i, o in DailiesToESP do
            if o.ClassName == "Model" then
                for Index, Descendant in o:GetDescendants() do
                    if Descendant.ClassName == "Highlight" and Descendant.Name ~= "ESP" then
                        Descendant:Destroy()
                        Descendant = nil
                        continue
                    end
                end
            end
            if not o:FindFirstChild("ESP") then
                local Highlight = Instance.new("Highlight")
                Highlight.FillTransparency = 0
                Highlight.Name = "ESP"
                Highlight.Parent = o
            else
                if o.ESP.Enabled then
                    o.ESP.Enabled = false
                else
                    o.ESP.Enabled = true
                end
            end
        end
        DailyESP = nil
    end
})
local TeleportingHoops
FifthTab:AddLabel("飛行光圈收集", false)
FifthTab:AddButton({
    Text = "傳送光圈",
    Tooltip = "若活動中心有飛行光圈，將光圈移至角色附近後再放回原位。",
    Func = function()
        if TeleportingHoops or IsMainMenu then
            return
        end
        TeleportingHoops = 0
        CheckForCharacter()
        local Hoops = Workspace:FindFirstChild("Hoops")
        if Hoops then
            for Index, Hoop in Hoops:GetChildren() do
                TeleportingHoops = TeleportingHoops + 1
                task.spawn(function()
                    local PreviousPosition = Hoop:GetPivot()
                    Hoop:PivotTo(CFrame.new(PlayerRoot.Position))
                    task.wait(.1)
                    Hoop:PivotTo(PreviousPosition)
                    TeleportingHoops = TeleportingHoops - 1
                end)
            end
        else
            Library:Notify("請先前往活動中心（若目前有開放）。", 5)
        end
        TeleportingHoops = nil
    end
})
local FindingEggs
local EggESP
FifthTab:AddLabel("尋寶活動", false)
FifthTab:AddButton({
    Text = "傳送",
    Tooltip = "若目前世界有尋寶活動，會將角色傳送到隱藏物件位置。\n若執行環境支援，可能先重置角色，再進行隱形傳送。",
    Func = function()
        local Success, Result = pcall(function()
            if not IsWorld or FindingEggs then
                return
            end
            local ScavengerHunts = Workspace:FindFirstChild("ScavengerHunts")
            if not ScavengerHunts then return end
            local EggHunt = ScavengerHunts:FindFirstChild("EggHunt")
            if not EggHunt then return end
            local Spawns = EggHunt:FindFirstChild("Spawns")
            if not Spawns then return end
            FindingEggs = true
            CheckForCharacter()
            if EF.Desync and EF.RaknetFunction.is_enabled() then
                EF.Desync(true)
                Remotes:WaitForChild("Health_Reset", math.huge):FireServer()
                task.wait(1)
                Remotes:WaitForChild("Health_Reset", math.huge):FireServer()
                LocalPlayer.CharacterAdded:Wait()
                task.wait(1)
            end
            Remotes:WaitForChild("SetMounted", math.huge):FireServer(true)
            task.wait(1)
            for Index, EggSpawn in Spawns:GetChildren() do
                local EggPosition = Vector3.new(EggSpawn.Position.X, EggSpawn.Position.Y+GetPlayerSize(), EggSpawn.Position.Z)
                PlayerRoot.CFrame = CFrame.new(EggPosition)
                task.wait(.5)
            end
            local Spawn = Workspace:FindFirstChild("Spawn")
            if not Spawn then return end
            local SpawnSize = Spawn.Size.Y / 2
            local SpawnPosition = Vector3.new(Spawn.Position.X, Spawn.Position.Y+SpawnSize, Spawn.Position.Z)
            PlayerRoot.CFrame = CFrame.new(SpawnPosition)
            task.wait(1)
            Remotes:WaitForChild("SetMounted", math.huge):FireServer(false)
            if EF.Desync and EF.RaknetFunction.is_enabled() then
                EF.Desync(false)
            end
            CollectCoins()
            FindingEggs = nil
        end)
        if not Success then
            SaveErrorToFile("FIND ALL EGGS", Result)
        end
    end
}):AddButton({
    Text = "高亮標示 (ESP)",
    Tooltip = "若目前世界有尋寶活動，會高亮標示所有尋寶物件。",
    Func = function()
        local Success, Result = pcall(function()
            if EggESP then return end
            local ScavengerHunts = Workspace:FindFirstChild("ScavengerHunts")
            if not ScavengerHunts then return end
            local EggHunt = ScavengerHunts:FindFirstChild("EggHunt")
            if not EggHunt then return end
            local HuntContainer = EggHunt:FindFirstChild("_ScavengerHuntContainer")
            if not HuntContainer then return end
            EggESP = true
            for i, o in HuntContainer:GetChildren() do
                local Highlight = o:FindFirstChild("ESP Highlight")
                if not Highlight then
                    local NewHighlight = Instance.new("Highlight")
                    NewHighlight.Name = "ESP Highlight"
                    NewHighlight.FillTransparency = 0
                    NewHighlight.Parent = o
                elseif Highlight then
                    if Highlight.Enabled then
                        Highlight.Enabled = false
                    else
                        Highlight.Enabled = true
                    end
                end
            end
            EggESP = nil
        end)
        if not Success then
            SaveErrorToFile("FIND ALL EGGS", Result)
        end
    end
})
end -- for unloaded event tab

if not SV.TradingTab then -- for unloaded trading tab
SetGlobal("trading tab")
local TradeTab = Window:AddTab({
    Name = "交易",
    Icon = "rbxassetid://9671046601"
})
local LeftTab = TradeTab:AddLeftTabbox("Left Tabbox")
    local FirstTab = LeftTab:AddTab("玩家商店")
local RightTab = TradeTab:AddRightTabbox("Right Tabbox")
    local SecondTab = RightTab:AddTab("交易功能")

FirstTab:AddToggle("PlacePlayerShopToggle", {
    Text = "自動擺設玩家商店",
    Default = false,
    Tooltip = "關閉此功能後，會自動撤除玩家商店。",
    Callback = function(ChangedValue)
        if ChangedValue then
            local CheckForShopSpots = Workspace:FindFirstChild("ShopLocations")
            if CheckForShopSpots then
                for _, ShopSpots in CheckForShopSpots:GetChildren() do
                    if ShopSpots.PlayerOwner.Value == nil then
                        Remotes:WaitForChild("Shop_ClaimShop", math.huge):FireServer(ShopSpots)
                        Library:Notify("已擺設商店！", 2)
                    end
                end
            end
        else
            Remotes:WaitForChild("Shop_StopShop", math.huge):FireServer()
        end
    end
})
FirstTab:AddDropdown("PlayerShopDropdown", {
    Values = {},
    Default = "",
    Multi = false,
    Text = "開啟選定玩家商店",
    Callback = function(ChangedValue)
        if ChangedValue and IsWorld and SV.CanRequire then
            local rShop = require(Client.Gui):Get("Shop")
            rShop:Close()
            rShop:Open(Players[tostring(ChangedValue)])
        end
    end
})
FirstTab:AddButton({
    Text = "掃描玩家商店",
    Func = function()
        local ActivePlayerShops = {}
        local ShopLocations = Workspace:FindFirstChild("ShopLocations")
        if not ShopLocations then
            return
        end
        for Index, Descendant in ShopLocations:GetDescendants() do
            if Descendant:IsA("ObjectValue") then
                if Descendant.Name == "PlayerOwner" then
                    if Descendant.Value == PlayerName then
                        continue
                    end
                    table.insert(ActivePlayerShops, Descendant.Value)
                end
            end
        end
        Options.PlayerShopDropdown:SetValues(ActivePlayerShops)
    end
})
SecondTab:AddButton({
    Text = "檢查交易重複物品",
    Func = function()
        if SV.CheckingTrade or IsMainMenu then
            return
        end

        SV.CheckingTrade = true

        local Success, Result = pcall(function()
            local pItems = ProfileInventory.Items
            local PlayerEquips = ReplicatedStorage.PlayerEquips:FindFirstChild(PlayerName)
            local CurrentTrade = nil
            local DupedItemCount = 0
            local ItemsToCheck = 0
            local StoredID = {}

            local function MarkItem(DupedItem)
                local NewFolder = Instance.new("Folder")
                    NewFolder.Name = "Explo".."ited"
                    NewFolder.Parent = DupedItem
                return
            end

            local function CheckForDupe(ItemToCheck)
                local ItemID = ItemToCheck.ID.Value
                for Index, CheckID in StoredID do
                    if CheckID.ID.Value == ItemToCheck.ID.Value then
                        MarkItem(CheckID)
                        Library:Notify("發現重複物品：" ..CheckID.Name, 3)
                        DupedItemCount = DupedItemCount + 1
                        return
                    end
                end
                return
            end

            for Index, Trades in ReplicatedStorage:FindFirstChild("Trades"):GetChildren() do
                if Trades:FindFirstChild(PlayerName) then
                    CurrentTrade = Trades
                    break
                end
            end

            if not CurrentTrade then
                Library:Notify("目前沒有進行交易", 3)
                SV.CheckingTrade = nil
                return
            end

            for Index, Players in CurrentTrade:GetChildren() do
                if Players.Name == LocalPlayer.Name then
                    continue
                end
                for Index, Descendant in Players:GetDescendants() do
                    if Descendant.Name == "ID" then
                        ItemsToCheck = ItemsToCheck + 1
                        table.insert(StoredID, Descendant.Parent)
                    end
                end
            end

            if ItemsToCheck == 0 then
                Library:Notify("沒有可檢查的物品", 3)
                SV.CheckingTrade = nil
                return
            end

            for Index, Descendant in pItems:GetDescendants() do
                if Descendant.Name =="ID" then
                    CheckForDupe(Descendant.Parent)
                end
            end

            for Index, Descendant in PlayerEquips:GetDescendants() do
                if Descendant.Name =="ID" then
                    CheckForDupe(Descendant.Parent)
                end
            end

            if DupedItemCount == 0 then
                Library:Notify("沒有發現重複物品", 3)
                SV.CheckingTrade = nil
                return
            end
        end)
        if not Success then
            SaveErrorToFile("SCAN TRADE FOR DUPE", Result)
        end
        SV.CheckingTrade = nil
    end
})
SecondTab:AddButton({
    Text = "與上一位玩家交易",
    Func = function()
        if SV.PlayerBeingTraded ~= nil then
            local TradeAccept = Remotes:WaitForChild("Trade_Accept")
            TradeAccept:FireServer(Players[SV.PlayerBeingTraded])
            SendTrade()
        else
            Library:Notify("找不到上一筆交易。你是否已收到並接受交易邀請？", 5)
        end
    end
})
end -- for unloaded trading tab

if not SV.ClassesTab then -- for unloaded classes tab
SetGlobal("creating class tab")
local ClassTab = Window:AddTab({
    Name = "職業",
    Icon = "rbxassetid://9671047048"
})
LeftTab = ClassTab:AddLeftTabbox("Left Tabbox")
    FirstTab = LeftTab:AddTab("主要")
RightTab = ClassTab:AddRightTabbox("Right Tabbox")
    SecondTab = RightTab:AddTab("其他")

CreateToggles({
    { "GeneralClassBuffToggle", Text = "職業增益", Tooltip = "提供雙持者與守護者的職業增益。", Tab = FirstTab },
    { "MoLBarrierToggle", Text = "光法護盾 (MoL)", Tooltip = "為遊戲中的其他玩家提供護盾，而不只是自己。\n僅光之法師可使用。", Tab = SecondTab },
    { "DemonBloodBindingToggle", Text = "惡魔血之束縛", Tooltip = "啟用惡魔的血之束縛技能，消耗生命值來提高傷害。\n僅惡魔職業可使用。", Tab = SecondTab },
    { "StormcallerSuperchargeToggle", Text = "風暴使超充能", Tooltip = "啟用風暴使的超充能技能，消耗生命值提高傷害，造成超充能狀態時可回復少量生命。\n僅風暴使可使用。", Tab = SecondTab },
})

local RangedClassLabel = FirstTab:AddLabel("遠程職業攻擊距離", false)
FirstTab:AddSlider("ChangedRangedXSlider", {
    Text = "X",
    Default = 25,
    Min = -100,
    Max = 100,
    Rounding = 0,
    Compact = true,
    Tooltip = "前後方向。\n預設值：20",
    Callback = function(ChangedValue)
        if Class and Class.Distance == "Ranged" then
            Xdistance = ChangedValue
        end
    end
})
FirstTab:AddSlider("ChangedRangedYSlider", {
    Text = "Y",
    Default = 55,
    Min = -100,
    Max = 100,
    Rounding = 0,
    Compact = true,
    Tooltip = "上下方向。\n預設值：50",
    Callback = function(ChangedValue)
        if Class and Class.Distance == "Ranged" then
            Ydistance = ChangedValue
        end
    end
})
    FirstTab:AddDivider({Margin = -5})
local MeleeClassLabel = FirstTab:AddLabel("近戰職業攻擊距離", false)
FirstTab:AddSlider("ChangedMeleeXSlider", {
    Text = "X",
    Default = 13,
    Min = -50,
    Max = 50,
    Rounding = 0,
    Compact = true,
    Tooltip = "前後方向。\n預設值：15",
    Callback = function(ChangedValue)
        if Class and Class.Distance == "Melee" then
            Xdistance = ChangedValue
        end
    end
})
FirstTab:AddSlider("ChangedMeleeYSlider", {
    Text = "Y",
    Default = 8,
    Min = -50,
    Max = 50,
    Rounding = 0,
    Compact = true,
    Tooltip = "上下方向。\n預設值：8",
    Callback = function(ChangedValue)
        if Class and Class.Distance == "Melee" then
            Ydistance = ChangedValue
        end
    end
})
end -- for unloaded classes tab

if not SV.InventoryTab then -- for unloaded inventory tab
SetGlobal("creating inventory tab")
local InventoryTab = Window:AddTab({
    Name = "背包存貨",
    Icon = "rbxassetid://9671046778"
})
local LeftTab = InventoryTab:AddLeftTabbox("Left Tabbox")
    local FirstTab = LeftTab:AddTab("背包")
    local SecondTab = LeftTab:AddTab("設定")
    local ThirdTab = LeftTab:AddTab("裝備")
local RightTab = InventoryTab:AddRightTabbox("Right Tabbox")
    local FourthTab = RightTab:AddTab("外觀")
    local FifthTab = RightTab:AddTab("特殊色碼")

local function ToggleValue(ChangedValue, ToggleValue)
    if ChangedValue and not IsMainMenu then
        SV[tostring(ToggleValue)] = true
    else
        SV[tostring(ToggleValue)] = nil
    end
end

CreateToggles({
    { "AutoSellToggle", Text = "自動出售物品", Tooltip = "只處理新取得的物品，不會出售寵物蛋。", Tab = FirstTab },
    { "SellPetToggle", Text = "出售寵物", Tooltip = "將寵物也納入自動出售範圍。", Tab = SecondTab, AttachedFunction = ToggleValue, FunctionValue = "IncludePets" },
    { "SellTowerEggToggle", Text = "出售高塔寵物蛋", Tooltip = "若可取得高塔寵物蛋，將自動出售。", Tab = SecondTab, AttachedFunction = ToggleValue, FunctionValue = "SellTowerEggs" },
    { "SellCharmToggle", Text = "出售護符", Tooltip = "將符合條件的護符納入自動出售範圍。", Tab = SecondTab, AttachedFunction = ToggleValue, FunctionValue = "IncludeCharms" },
    { Button = true, Text = "升級主武器", Tab = ThirdTab, AttachedFunction = UpgradeToMax, FunctionValue = "Primary" },
    { Button = true, Text = "升級副手", Tab = ThirdTab, AttachedFunction = UpgradeToMax, FunctionValue = "Offhand" },
    { Button = true, Text = "升級防具", Tab = ThirdTab, AttachedFunction = UpgradeToMax, FunctionValue = "Armor" }
})
    FirstTab:AddDivider()
FirstTab:AddDropdown("AutoSellDropdown", {
    Values = {
        ["0"] = "none",
        ["3"] = "3-5",
        ["4"] = "4-5",
        ["5"] = "5"
    },
    Multi = false,
    Text = "保留的品質",
    AllowNull = false,
    Default = "5",
    Callback = function(ChangedValue)
        ChangedValue = tonumber(ChangedValue)
        if ChangedValue and not IsMainMenu and ChangedValue > 0 then
            KeepTier = ChangedValue
        else
            KeepTier = nil
        end
    end
})
    FirstTab:AddDivider()
CreateToggles({
    { "KeepSelectedPerkToggle", Text = "保留選定詞條", Tooltip = "預設只保留 S+ 品質的詞條。", Tab = FirstTab, AttachedFunction = ToggleValue, FunctionValue = "KeepPerks" }
})
local SavePerkTable = {
    ["Gold Hoarder"] = { PerkValue = 0.2, PetPerkValue = 0.2, PerkName = "GoldDrop" },
    ["Lucky Looter"] = { PerkValue = 0.1, PetPerkValue = 0.1, PerkName = "PetFoodDrop" },
    ["Energized"] = { PerkValue = 0.15, PetPerkValue = 0.15, PerkName = "UltCharge" },
    ["HP UP"] = { PerkValue = 0.12, PetPerkValue = 0.07, PerkName = "BonusHP" },
    ["Attack Up"] = { PerkValue = 0.08, PetPerkValue = 0.05, PerkName = "BonusAttack" },
    ["Agility"] = { PerkValue = 0.1, PetPerkValue = 0.1, PerkName = "BonusWalkspeed" },
    ["Burn Resistance"] = { PerkValue = 0.9, PetPerkValue = 0.9, PerkName = "ResistBurn" },
    ["Poison Resistance"] = { PerkValue = 0.9, PetPerkValue = 0.9, PerkName = "ResistPoison" },
    ["Frost Resistance"] = { PerkValue = 0.9, PetPerkValue = 0.9, PerkName = "ResistFrost" },
    ["Knockdown Resistance"] = { PerkValue = 0.9, PetPerkValue = 0.9, PerkName = "ResistKockdown" },
    ["Untouchable"] = { PerkValue = 0.2, PerkName = "DodgeChance" },
    ["Rough Skin"] = { PerkValue = 0.1, PerkName = "RoughSkin" },
    ["Damage Reduction"] = { PerkValue = 0.08, PerkName = "DamageReduction" },
    ["Life Drain"] = { PerkValue = 0.06, PerkName = "LifeDrain" },
    ["Burn Chance"] = { PerkValue = 0.15, PerkName = "BurnChance" },
    ["Frost Chance"] = { PerkValue = 0.15, PerkName = "FrostChance" },
    ["Poison Chance"] = { PerkValue = 0.15, PerkName = "PoisonChance" },
    ["Crit Stack"] = { PerkValue = 0.15, PerkName = "CritStack" },
    ["Poisonous Thorns"] = { PerkValue = 0.6, PerkName = "PoisonThorns" },
    ["Elemental Resistance"] = { PerkValue = 0.4, PetPerkValue = 0.15, PerkName = "Elemental" },
    ["Ferocious"] = { PerkValue = 0.4, PetPerkValue = 0.15, PerkName = "Ferocious" },
    ["Vampiric"] = { PerkValue = 0.15, PetPerkValue = 0.05, PerkName = "Vampiric" },
    ["Boss Bane"] = { PerkValue = 0.3, PetPerkValue = 0.1, PerkName = "TestTier5" },
    ["Mob Slayer"] = { PerkValue = 0.3, PetPerkValue = 0.1, PerkName = "MobBoss" },
    ["Elite Assassin"] = { PerkValue = 0.3, PetPerkValue = 0.1, PerkName = "EliteBoss" },
    ["Opening Strike"] = { PerkValue = 0.25, PerkName = "OpeningStrike" },
    ["Self Destruct"] = { PerkValue = 0.5, PerkName = "Destruction" },
    ["Fortress"] = { PerkValue = 0.4, PerkName = "Fortress" },
    ["Glass"] = { PerkValue = 1, PerkName = "Glass" },
    ["Master Thief"] = { PerkValue = 0.35, PerkName = "MasterThief" },
    ["Oblivion"] = { PerkValue = 0.05, PetPerkValue = 0.05, PerkName = "Oblivion" },
    ["Reckless"] = { PerkValue = 0.25, PetPerkValue = 0.25, PerkName = "Reckless" },
    ["Comeback"] = { PerkValue = 0.3, PerkName = "Comeback" },
    ["Relentless"] = { PerkValue = 0.15, PerkName = "Relentless" },
    ["Duelist"] = { PerkValue = 0.3, PerkName = "Duelist" },
    ["Unstoppable"] = { PerkValue = 0.15, PerkName = "Unstoppable" },
    ["Survivor"] = { PerkValue = 0.2, PerkName = "Survivor" },
    ["Executioner"] = { PerkValue = 0.5, PetPerkValue = 0.5, PerkName = "Executioner" },
    ["Adrenaline"] = { PerkValue = 0.3, PerkName = "Adrenaline" },
    ["Cooldown Reduction"] = { PerkValue = 0.1, PerkName = "CooldownReduction" },
    ["Attack Speed"] = { PerkValue = 0.15, PerkName = "AttackSpeed" },
    ["Water Bubble"] = { PerkValue = 0.4, PerkName = "WaterBubble", LowerMax = true },
    ["Blessing"] = { PerkValue = 0.3, PerkName = "Blessing" },
    ["Deaths Door"] = { PerkValue = 0.5, PerkName = "DeathsDoor" },
    ["Protector"] = { PerkValue = 0.1, PerkName = "Protector" }
}
FirstTab:AddDropdown("PerkListDropdown", {
    Values = {},
    Text = "要保留的詞條",
    Multi = true,
    AllowNull = true,
    Default = "",
    MaxVisibleDropdownItems = 5,
    Searchable = true,
    Callback = function(ChangedValue)
        if not IsMainMenu and Options.PerkListDropdown:GetActiveValues(true) > 0 then
            if not SV.SelectedPerks then
                SV.SelectedPerks = {}
            else
                table.clear(SV.SelectedPerks)
            end
            for Key in ChangedValue do
                local PerkData = SavePerkTable[Key]
                PerkData.VisualName = tostring(Key)
                SV.SelectedPerks[PerkData.PerkName] = PerkData
            end
        else
            if SV.SelectedPerks then
                table.clear(SV.SelectedPerks)
            end
        end
    end
})
local DropdownReference = {}
for Key in SavePerkTable do
    table.insert(DropdownReference, tostring(Key))
end
table.sort(DropdownReference, function(a,b)
    return a < b
end)
Options.PerkListDropdown:SetValues(DropdownReference)
FirstTab:AddButton({
    Text = "出售背包物品",
    DoubleClick = true,
    Tooltip = "出售背包物品時，也會套用詞條與其他篩選條件。",
    Func = function()
        local pItems = ProfileInventory:WaitForChild("Items")
        for Index, NewItem in pItems:GetChildren() do
            ItemSellCheck(NewItem, true)
        end
    end
})
SecondTab:AddLabel("完美詞條容許差值", true)
SecondTab:AddSlider("PerkPercentSlider", {
    Text = "差值",
    Default = 0,
    Min = 0,
    Max = 5,
    Rounding = 0,
    Compact = true,
    Tooltip = "放寬保留詞條的容許差值。例如想同時保留攻擊提升 7% 與 8%，可將差值設為 1。",
    Callback = function(ChangedValue)
        if not ChangedValue then
            ChangedValue = 0
        end
        OffsetMax = FormatDecimal(ChangedValue / 100)
    end
})
FourthTab:AddDropdown("CosmeticDropdown", {
    Values = {},
    Text = "外觀",
    Multi = true,
    AllowNull = true,
    Default = "",
    MaxVisibleDropdownItems = 5,
    Searchable = true
})
FourthTab:AddButton({
    Text = "清除選取",
    DoubleClick = true,
    Func = function()
        Options.CosmeticDropdown:SetValue(nil)
    end
})
FourthTab:AddButton({
    Text = "掃描外觀",
    Func = function()
        if IsDungeon or IsWorld then
            if not SV.CanRequire then
                Library:Notify("執行環境不支援此功能（缺少 require()）", 5)
                return
            end

            local Profile_GetCosmetics = Remotes.Profile_GetCosmetics:InvokeServer()
            local rItems = require(Items)
            local ItemTable = {}
            local VisualItemTable = {}
            local RealItemTable = {}
            local ScannedItems = {}

            -- create the table to look up items by their id's
            for Index, ItemData in rItems do
                if ItemData.Type == "Emote" or ItemData.Type == "Title" or ItemData.Type == "Furniture" or ItemData.Type == "Consumable" then
                    continue
                end
                ItemTable[ItemData.ID] = {
                    VisualName = tostring(ItemData.DisplayKey),
                    InternalName = tostring(Index)
                }
            end

            for Index, ItemData in Profile_GetCosmetics do
                local ScanHex, ScanColorOk
                if type(ItemData) == "table" then
                    ScanHex, ScanColorOk = HexRetention.Decode(ItemData.d)
                end
                if not ScanColorOk then
                    SV.RealCosmeticTable = nil
                    Library:Notify("色碼資料無法確認，已停止掃描，沒有出售或回收。", 7)
                    return
                end
                if ItemData.lock or ItemData.fav then
                    continue
                end
                local ItemRef = ItemTable[ItemData.id]
                if not ItemRef then
                    continue
                end
                local VisualName = ItemRef.VisualName
                if not ScannedItems[VisualName] then
                    ScannedItems[VisualName] = true
                    RealItemTable[VisualName] = {}
                    table.insert(VisualItemTable, VisualName)
                end
                if not ItemData.d then
                    table.insert(RealItemTable[VisualName], {
                        UUID = ItemData.uuid,
                        Name = ItemRef.InternalName
                    })
                else
                    table.insert(RealItemTable[VisualName], {
                        UUID = ItemData.uuid,
                        Name = ItemRef.InternalName,
                        Dye = ScanHex
                    })
                end
            end
            
            Options.CosmeticDropdown:SetValues(VisualItemTable)
            SV.RealCosmeticTable = RealItemTable
        end
    end
})
    FourthTab:AddDivider()
FourthTab:AddLabel("以下按鈕會嘗試回收或出售上方已選取的所有外觀物品。", true)
FourthTab:AddButton({
    Text = "回收",
    DoubleClick = true,
    Func = function()
        if IsDungeon or IsWorld then
            local SelectedItems = {}
            for Key in Options.CosmeticDropdown.Value do
                SelectedItems[Key] = true
            end
            RecycleFromInventory("Recycle", SelectedItems)
        end
    end
}):AddButton({
    Text = "出售",
    DoubleClick = true,
    Func = function()
        if IsDungeon or IsWorld then
            local SelectedItems = {}
            for Key in Options.CosmeticDropdown.Value do
                SelectedItems[Key] = true
            end
            RecycleFromInventory("Gold", SelectedItems)
        end
    end
})
FifthTab:AddLabel("<font color='#FF3333'>請使用逗號分隔每個色碼</font>\n輸入範例：\n<font color='#33FF33'>00ff00, a.a.b., [a-b].[1-2].e</font>", true)
    FifthTab:AddDivider()
FifthTab:AddToggle("KeepTenPerSpecialHex", {
    Text = "選取物品中：每個特殊色碼保留 10 件",
    Default = false,
    Tooltip = "關閉：特殊色全部保留。開啟：只在你選取的物品中，每色各留10件；未選取物品不占名額。開關本身不會處理物品。"
})
FifthTab:AddLabel("關閉＝特殊色全部保留。\n開啟＝選取物品中，每色至少留10件。\n不足10件全留；未選取物品不占名額。\n上鎖、收藏不處理，可能保留超過10件。\n\n例如：同色25件，留10件、處理15件。\n同色只有8件，就8件全部保留。\n每種完整色碼分開算，不是全部合計10件。\n不同外觀若同色，在選取範圍內一起算。\n\n先到「外觀」掃描並選取物品。\n再按下方「預覽」確認處理數量。\n確認後，才回「外觀」按回收或出售。\n只切換開關，不會自動處理物品。\n\n內建特殊色與輸入的保留色碼都適用。\n一般色／無色仍會依原規則列入處理。\n\n1. 切記：建議一次只選一種服裝／皮膚回收。\n2. 同時選多種服裝／皮膚時，\n相同特殊色碼合計只保留10件，\n不是每種服裝／皮膚各保留10件。\n3. 回收完務必回到「外觀」按「清除選取」。", true)
FifthTab:AddButton({
    Text = "預覽處理數量（不回收）",
    Func = function()
        if not (IsDungeon or IsWorld) then return end
        local SelectedItems = {}
        local Selection = Options.CosmeticDropdown.Value
        if type(Selection) == "table" then
            for Key, Value in pairs(Selection) do
                if Value then SelectedItems[Key] = true end
            end
        end
        RecycleFromInventory("Recycle", SelectedItems, true)
    end
})
FifthTab:AddDivider()
local NumberOfEnteredHexes = FifthTab:AddLabel("已儲存色碼數量：" ..FormatNumber(#SV.SpecialHexColors))
local UserEnteredHexes = FifthTab:AddLabel("已保留的色碼：\n無\n＋（所有特殊色碼）", true)
    FifthTab:AddDivider()
FifthTab:AddInput("SaveUserHexesInput", {
    Text = "輸入要保留的色碼",
    Default = "",
    ClearTextOnFocus = false,
    Placeholder = "請輸入色碼",
    Callback = function(ChangedValue)
        if IsWorld or IsDungeon then
            ChangedValue = tostring(ChangedValue)
            ChangedValue = string.lower(ChangedValue)
            if ChangedValue == "" or ChangedValue == " " then
                NumberOfEnteredHexes:SetText("已儲存色碼數量：" ..FormatNumber(#SV.SpecialHexColors))
                UserEnteredHexes:SetText("已保留的色碼：\n無\n＋（所有特殊色碼）")
                return
            end
            local StandardizeCommas = string.gsub(Options.SaveUserHexesInput.Value, ", ", ",")
            local RemoveHashTags = string.gsub(StandardizeCommas, "#", "")
            local SplitHexes = string.split(RemoveHashTags, ",")
            NumberOfEnteredHexes:SetText("已儲存色碼數量：" ..FormatNumber(#SV.SpecialHexColors + #SplitHexes))
            UserEnteredHexes:SetText("已保留的色碼：\n<font color='#33FF33'>" ..ChangedValue.. "</font>\n＋（所有特殊色碼）")
            return
        end
    end
})
end -- for unloaded inventory tab

SetGlobal("creating dungeon tab")

if not SV.DungeonsTab then -- for unloaded classes tab
local DungeonTab = Window:AddTab({
    Name = "地下城",
    Icon = "rbxassetid://18739736091"
})
local LeftTab = DungeonTab:AddLeftTabbox("Left Tabbox")
    local FirstTab = LeftTab:AddTab("主要")
    local SecondTab = LeftTab:AddTab("設定")
local RightTab = DungeonTab:AddRightTabbox("Right Tabbox")
    local ThirdTab = RightTab:AddTab("進階\n（夢魘挑戰）")

local function ToggleNightmare(ChangedValue, FunctionValue)
    if ChangedValue and IsDungeon then
        SV[tostring(FunctionValue)] = math.random(1005, 1007)
    else
        SV[tostring(FunctionValue)] = nil
    end
end

CreateToggles({
    { "ReplayMissionToggle", Text = "自動重開副本", Tab = FirstTab },
    { "CollectChestToggle", Text = "收集寶箱", Tab = FirstTab },
    { "HighestDungeonToggle", Text = "挑戰可進入的最高等級地下城", Tooltip = "適合練等：自動選擇可進入的最高等級地下城，並裝備等級更高的新裝備。", Tab = FirstTab },
    { "RandomNightmareDungeonToggle", Text = "隨機夢魘地下城", Tooltip = "不重複目前的地下城，改為隨機選擇夢魘地下城。", Tab = FirstTab, AttachedFunction = ToggleNightmare, FunctionValue = "RandomNightmareDungeon" },
    { "ReplayInfiniteTowerToggle", Text = "設定無限塔重置樓層", Tooltip = "達到指定樓層時自動重新開始無限塔。", Tab = FirstTab }
})
SV.RestartDungeonDelay = 3
SecondTab:AddLabel("地下城重開延遲", true)
SecondTab:AddSlider("ReplayMissionSlider", {
    Text = "重開延遲",
    Default = 3,
    Min = 1,
    Max = 60,
    Rounding = 0,
    Compact = true,
    Tooltip = "調整啟用「自動重開副本」時的等待秒數。",
    Callback = function(ChangedValue)
        SV.RestartDungeonDelay = ChangedValue
    end
})
SV.CollectChestsDelay = 0.1
SecondTab:AddLabel("寶箱收集延遲", true)
SecondTab:AddSlider("ChestDelaySlider", {
    Text = "寶箱收集延遲",
    Default = 0.1,
    Min = 0.01,
    Max = 5,
    Rounding = 2,
    Compact = true,
    Tooltip = "調整每次收集寶箱之間的等待時間。",
    Callback = function(ChangedValue)
        SV.CollectChestsDelay = ChangedValue
    end
})
SecondTab:AddLabel("無限塔重置樓層", true)
SecondTab:AddSlider("InfResetSlider", {
    Text = "樓層",
    Default = 200,
    Min = 155,
    Max = 400,
    Rounding = 0,
    Compact = true,
    Tooltip = "設定啟用無限塔重置功能後，在哪一層重新開始。",
    Callback = function(ChangedValue)
        RestartAtFloor = ChangedValue
    end
})
SecondTab:AddLabel("優先選擇夢魘地下城", true)
SecondTab:AddDropdown("PrioNmDropdown", {
    Values = {},
    Multi = true,
    AllowNull = true,
    Default = nil,
    MaxVisibleDropdownItems = 5,
    Searchable = true,
    Callback = function(ChangedValue)
        if not IsMainMenu and Options.PrioNmDropdown:GetActiveValues(true) > 0 then
            SV.PrioNmDCount = true
        else
            SV.PrioNmDCount = nil
        end
    end
})
SV.PrioritizedNightmareDungeons = {}
local NMDisplayValues = {}
for Index, Data in SV.DungeonListTable do
    if Data.Level > 0 and Data.Level < 175 then
        SV.PrioritizedNightmareDungeons[Data.DungeonName] = { ID = Data.DungeonID, Length = Data.DungeonDelay, SpecialPerk = Data.SpecialPerk or nil }
        table.insert(NMDisplayValues, Data.DungeonName)
    end
end
Options["PrioNmDropdown"]:SetValues(NMDisplayValues)
NMDisplayValues = nil
SV.TotalNightmareLabel = ThirdTab:AddLabel("夢魘累計通關：？", false)
ThirdTab:AddInput("TotalNightmareInput", {
    Text = "累計通關 X 次後停止",
    Default = "",
    Placeholder = "請輸入數字",
    Callback = function(ChangedValue)
        if IsDungeon then
            SV.StopAfterTotalNightmare = ChangedValue
        end
    end
})
    ThirdTab:AddDivider({Margin = -5})
SV.DailyNightmareLabel = ThirdTab:AddLabel("夢魘今日通關：？", false)
ThirdTab:AddInput("DailyNightmareInput", {
    Text = "今日通關 X 次後停止",
    Default = "",
    Placeholder = "請輸入數字",
    Callback = function(ChangedValue)
        if IsDungeon then
            SV.StopAfterDailyNightmare = ChangedValue
        end
    end
})
end -- for unloaded classes tab

if not SV.InventoryTab then
SetGlobal("equipment tab function")
if IsWorld or IsDungeon then
    Toggles.AutoSellToggle:OnChanged(function(ChangedValue) -- auto sell
        if ChangedValue then
            local Success, Result = pcall(function()
                local pItems = ProfileInventory:WaitForChild("Items")
                ConnectionTable["ConnectInventory"] = pItems.ChildAdded:Connect(function(NewItem)
                    ItemSellCheck(NewItem)
                end)
            end)
            if not Success then
                SaveErrorToFile("AUTO SELL", Result)
            end
        else
            DisconnectVariable("ConnectInventory")
            SellItemCheck = 0
        end
    end)
end
end -- for unloaded inventory tab

if not SV.GuildTab then -- for unloaded guild tab
SetGlobal("creating guild tab")
local GuildTab = Window:AddTab({
    Name = "公會",
    Icon = "rbxassetid://9671046895"
})
local GuildTabLeft = GuildTab:AddLeftTabbox("Left Tabbox")
    local FirstTab = GuildTabLeft:AddTab("主要")
    local SecondTab = GuildTabLeft:AddTab("設定")
local GuildTabRight = GuildTab:AddRightTabbox("Right Tabbox")
    local ThirdTab = GuildTabRight:AddTab("進階")
    local FourthTab = GuildTabRight:AddTab("公會資訊")

CreateToggles({
    { "WaitTimeToggle", Text = "等待正常通關時間", Tooltip = "進入地下城後先等待指定時間，再繼續完成地下城。", Tab = FirstTab },
    { "DoAllDungeonsToggle", Text = "依序挑戰所有地下城", Tooltip = "從目前地下城開始，通關後依序前往下一座，不會回頭挑戰之前的地下城。\n\n順序：無限塔 → 高塔 1～6 → 天界塔 → 其他地下城", Tab = FirstTab },
    { "DelayInfFloorToggle", Text = "延遲無限塔換層", Tooltip = "挑戰無限塔時，不立即前往下一層，而是等待遊戲原本的倒數傳送。", Tab = FirstTab },
    { "GuildQuestToggle", Text = "自動領取公會任務", Tab = FirstTab }
})

    FirstTab:AddDivider({Margin = -5})
FirstTab:AddDropdown("DoAllDropdown", {
    Values = {
        "Stop",
        "Loop",
        "Loop w/o inf",
        "Loop w/o towers",
        "Play nightmare dungeons"
    },
    Multi = false,
    Text = "完成後的動作",
    AllowNull = false,
    Default = "Stop"
})
SecondTab:AddLabel("額外等待時間", true)
SecondTab:AddSlider("AddExtraTimeSlider", {
    Text = "秒數",
    Default = 0,
    Min = 0,
    Max = 180,
    Rounding = 0,
    Compact = true,
    Tooltip = "增加「等待正常通關時間」的額外秒數。",
    Callback = function(ChangedValue)
        SV.AddedGuildTime = ChangedValue
    end
})
SecondTab:AddLabel("無限塔逐層增加延遲", true)
SecondTab:AddSlider("IncrementInfiniteSlider", {
    Text = "秒數",
    Default = 0,
    Min = 0,
    Max = 10,
    Rounding = 0,
    Compact = true,
    Tooltip = "啟用無限塔換層延遲時，每完成一個 Boss 樓層，就逐步延長等待時間。",
    Callback = function(ChangedValue)
        SV.IncrementInfiniteDelay = ChangedValue
    end
})
SV.TotalGuildPointLabel = ThirdTab:AddLabel("公會累計積分：？", false)
ThirdTab:AddInput("TotalKillInput", {
    Text = "累計積分達 X 時停止",
    Default = "",
    Placeholder = "請輸入數字",
    Callback = function(ChangedValue)
        if IsDungeon then
            SV.StopAfterTotalPoints = ChangedValue
        end
    end
})
    ThirdTab:AddDivider({Margin = -5})
SV.DailyGuildPointLabel = ThirdTab:AddLabel("公會今日積分：？", false)
ThirdTab:AddInput("DailyKillInput", {
    Text = "今日積分達 X 時停止",
    Default = "",
    Placeholder = "請輸入數字",
    Callback = function(ChangedValue)
        if IsDungeon then
            SV.StopAfterDailyPoints = ChangedValue
        end
    end
})
local SpyOnGuild = FourthTab:AddLabel("尚未選擇要查看的公會", true)
    FourthTab:AddDivider()
local StoredPoints
local StoredChatLogs
local StoredDescription
local function ClipboardCheck(Copy, Data)
    if IsMainMenu then
        return true
    end

    if not Options.GuildNamesDropdown.Value then
        SpyOnGuild:SetText("尚未選擇公會")
        return true
    end

    if Copy and Data then
        setclipboard(Data)
        return true
    end
end
local function GetGuildPoints(Copy)
    if ClipboardCheck(Copy, StoredPoints) then
        return
    end

    local GetCache = Remotes:WaitForChild("Guilds_GetCache", math.huge)
    local CachedGuild = GetCache:InvokeServer(string.upper(Options.GuildNamesDropdown.Value))
    local CachedMembers = CachedGuild and CachedGuild.Members
    if not CachedMembers then
        SV.SpyOnGuild:SetText("此公會資料已無法取得")
    end

    local PlayerPoints = {}
    local TotalPoints = 0
    for Index, Data in CachedMembers do
        table.insert(PlayerPoints, string.format(
            "%* - %s",
            Data.UserName, FormatNumber(Data.Points)
        ))
        TotalPoints += tonumber(Data.Points)
    end
    StoredPoints = string.format(
        "Total guild points: %s\n%*",
        FormatNumber(TotalPoints), table.concat(PlayerPoints, "\n")
    )
    if not Copy then
        SpyOnGuild:SetText(StoredPoints)
    else
        setclipboard(StoredPoints)
    end
end
local function GetGuildDescription(Copy)
    if ClipboardCheck(Copy, StoredDescription) then
        return
    end

    local GetCache = Remotes:WaitForChild("Guilds_GetCache", math.huge)
    local CachedGuild = GetCache:InvokeServer(string.upper(Options.GuildNamesDropdown.Value))
    local CachedDescription = CachedGuild and CachedGuild.Description
    if not CachedDescription then
        SpyOnGuild:SetText("此公會資料已無法取得")
    end
    if not Copy then
        SpyOnGuild:SetText(CachedDescription)
        StoredDescription = CachedDescription
    else
        setclipboard(CachedDescription)
    end
end
FourthTab:AddDropdown("GuildNamesDropdown", {
    Values = {},
    Text = "公會列表",
    Multi = false,
    AllowNull = true,
    Default = "",
    MaxVisibleDropdownItems = 5,
    Searchable = true,
    Callback = function()
        StoredPoints = nil
        StoredDescription = nil
        StoredChatLogs = nil
    end
})
FourthTab:AddButton({
    Text = "掃描公會",
    Func = function()
        local ScannedGuilds = {}
        local UniqueGuilds = {}
        for Index, Player in Players:GetChildren() do
            local PlayersGuild = GetGuild(Player)
            if PlayersGuild ~= "❌" and not ScannedGuilds[PlayersGuild] then
                ScannedGuilds[PlayersGuild] = true
                table.insert(UniqueGuilds, PlayersGuild)
            end
        end
        Options.GuildNamesDropdown:SetValues(UniqueGuilds)
    end
})
FourthTab:AddButton({
    Text = "玩家積分",
    Func = function()
        GetGuildPoints()
    end
}):AddButton({
    Text = "複製到剪貼簿",
    Func = function()
        GetGuildPoints(true)
    end
})
FourthTab:AddButton({
    Text = "說明",
    Func = function()
        GetGuildDescription()
    end
}):AddButton({
    Text = "複製到剪貼簿",
    Func = function()
        GetGuildDescription(true)
    end
})
end -- for unloaded guild tab

if not SV.ShopsTab then -- for unloaded shops tab
SetGlobal("creating shop tab")
local ShopTab = Window:AddTab({
    Name = "商店",
    Icon = "rbxassetid://12281229733"
})
local LeftTab = ShopTab:AddLeftTabbox("Left Tabbox")
    local FirstTab = LeftTab:AddTab("寵物蛋")
    local SecondTab = LeftTab:AddTab("夢魘")
    local ThirdTab = LeftTab:AddTab("PVP")
local RightTab = ShopTab:AddRightTabbox("Left Tabbox")
    local FourthTab = RightTab:AddTab("公會")
    local FifthTab = RightTab:AddTab("活動")

local BuyEggList = {
    { InternalName = "StarEgg", VisualName = "Star egg", CoinPrice = 2000, CurrencyType = "Gold" },
    { InternalName = "JungleEgg", VisualName = "Jungle egg", CoinPrice = 5000, CurrencyType = "Gold" },
    { InternalName = "CrystalEgg", VisualName = "Crystal egg", CoinPrice = 7500, CurrencyType = "Gold" },
    { InternalName = "DesertEgg", VisualName = "Pharaoh's egg", CoinPrice = 10000, CurrencyType = "Gold" },
    { InternalName = "ChristmasEgg", VisualName = "Holiday egg", CoinPrice = 400, CurrencyType = "Crystal" }
}
FirstTab:AddDropdown("EggShopDropdown", {
    Values = {},
    Multi = false,
    Text = "寵物蛋（價格）",
    AllowNull = true,
    Default = nil,
    Searchable = true,
    Callback = function(ChangedValue)
        if ChangedValue and IsWorld or IsDungeon then
            SV.SelectedEggItem = BuyEggList[ChangedValue]
        else
            SV.SelectedEggItem = nil
        end
    end
})
BuyEggList = BuildShopValues("EggShopDropdown", BuyEggList)
FirstTab:AddButton({
    Text = "購買寵物蛋",
    Func = function()
        local TableReference = SV.SelectedEggItem
        if not TableReference then
            Library:Notify("尚未選擇寵物蛋", 3)
            return
        end
        if not BuyFromEggShop(TableReference.CurrencyType, TableReference.InternalName, TableReference.CoinPrice, TableReference.VisualName) then
            Library:Notify("金幣不足", 3)
        end
    end
})
CreateToggles({
    { "AutoHatchEggToggle", Text = "自動孵化選定寵物蛋", Tooltip = "建議在獨立地下城中使用，較不易受到其他玩家干擾，也能減少卡頓。", Tab = FirstTab },
    { "AutoHatchInventoryEggToggle", Text = "孵化背包中的蛋", Tooltip = "孵化背包中的蛋", Tab = FirstTab}
})
FirstTab:AddSlider("EggHatchDelaySlider", {
    Text = "孵化間隔",
    Default = 0,
    Min = 0,
    Max = 10,
    Rounding = 0,
    Callback = function(ChangedValue)
        if IsWorld or IsDungeon then
            SV.HatchDelay = ChangedValue
        end
    end
})
for Dropdown, Info in ipairs{
    { "NightmareShopDropdown", ShopList = "NightmarePortals", Currency = "Nightmare", RequiredWorld = "14914684761", ReqName = "world 10", ToggleName = "AutoNightmareToggle", Tab = SecondTab },
    { "PVPShopDropdown", ShopList = "PVPShop", Currency = "PvP", RequiredWorld = "6510868181", ReqName = "pvp arena", ToggleName = "AutoPvpToggle", Tab = ThirdTab },
    { "GuildShopDropdown", ShopList = "GuildShop", Currency = "Guild", RequiredWorld = "139316833473171", ReqName = "guild hub", ToggleName = "AutoGuildToggle", Tab = FourthTab },
    { "EventShopDropdown", ShopList = "Halloween2026", Currency = "Halloween", RequiredWorld = "5862275930", ReqName = "event hub", ToggleName = "AutoEventToggle", Tab = FifthTab }
} do
    local SelectedItem
    Info.Tab:AddDropdown(tostring(Info[1]), {
        Values = {},
        Multi = false,
        Text = "物品名稱（"..Info.Currency.." 貨幣）",
        AllowNull = true,
        Default = nil,
        MaxVisibleDropdownItems = 5,
        Searchable = true,
        Callback = function(ChangedValue)
            if ChangedValue and IsWorld then
                SelectedItem = Info.ShopList[ChangedValue]
            else
                SelectedItem = nil
            end
        end
    })
    Info.ShopList = BuildShopValues(tostring(Info[1]), Info.ShopList)
    Info.Tab:AddButton({
        Text = "購買物品",
        Func = function()
            if Info.RequiredWorld then
                if StringPlaceID ~= Info.RequiredWorld then
                    Library:Notify(string.format(
                        "Go to %* to do this",
                        Info.ReqName
                    ), 5)
                    return
                end
            end
            BuyFromLocalShop(Info.ShopList, SelectedItem)
        end
    })
    local AutoBuy
    Info.Tab:AddToggle(Info.ToggleName, {
        Text = "大量購買選定物品",
        Default = false,
        Callback = function(ChangedValue)
            if ChangedValue and (IsWorld or IsDungeon) and StringPlaceID == Info.RequiredWorld then
                AutoBuy = true
                local Success, Result = pcall(function()
                    repeat
                        BuyFromLocalShop(Info.ShopList, SelectedItem)
                        task.wait()
                    until not AutoBuy
                end)
                if not Success then
                    SaveErrorToFile(Info.Currency, Result)
                end
            else
                AutoBuy = nil
            end
        end
    })
end
end -- for unloaded shops tab

if not SV.QuickMenusTab then -- for unloaded quick menus tab
SetGlobal("creating quick menu tab")
local OpenMenuTab = Window:AddTab({
    Name = "快速選單",
    Icon = "rbxassetid://13534579488"
})
local LeftTab = OpenMenuTab:AddLeftTabbox("Left Tabbox")
    local FirstTab = LeftTab:AddTab("主要")
local RightTab = OpenMenuTab:AddRightTabbox("Left Tabbox")
    local SecondTab = RightTab:AddTab("其他")

CreateToggles({
    { Button = true, Text = "傳送選單（舊版）", Tab = FirstTab, AttachedFunction = OpenMenu, FunctionValue = "HubTeleport" },
    { Button = true, Text = "銀行", Tab = FirstTab, AttachedFunction = OpenMenu, FunctionValue = "Bank" },
    { Button = true, Text = "裝備升級台", Tab = FirstTab, AttachedFunction = OpenMenu, FunctionValue = "ItemUpgrade" },
    { Button = true, Text = "販售台", Tab = FirstTab, AttachedFunction = OpenMenu, FunctionValue = "Sell" },
    { Button = true, Text = "Zero 祭壇", Tab = FirstTab, AttachedFunction = OpenMenu, FunctionValue = "Fusion" },
    { Button = true, Text = "寵物融合", Tab = FirstTab, AttachedFunction = OpenMenu, FunctionValue = "FusePets" },
    { Button = true, Text = "造型沙龍", Tab = SecondTab, AttachedFunction = OpenMenu, FunctionValue = "NewCharacterCustomizer" },
    { Button = true, Text = "回收站", Tab = SecondTab, AttachedFunction = OpenMenu, FunctionValue = "Recycler" },
    { Button = true, Text = "家具商店", Tab = SecondTab, AttachedFunction = OpenMenu, FunctionValue = "FurnitureShop" },
    { Button = true, Text = "寵物探險", Tab = SecondTab, AttachedFunction = OpenMenu, FunctionValue = "PetExpeditions" },
})
end -- for unloaded quick menus tab

if not SV.MiscellaneousTab then -- for unloaded miscellaneous
local MiscTab = Window:AddTab({
    Name = "額外進階功能",
    Icon = "rbxassetid://4801326994"
})
local LeftTab = MiscTab:AddLeftTabbox("Left Tabbox")
    local FirstTab = LeftTab:AddTab("主要")
    local SecondTab = LeftTab:AddTab("隱藏介面")
local RightTab = MiscTab:AddRightTabbox("Right Tabbox")
    local ThirdTab = RightTab:AddTab("其他")
    local FourthTab = RightTab:AddTab("效能")

local function ToggleMenu(ChangedValue, FirstMenu)
    local Success, Result = pcall(function()
        local FoundMenu = PlayerGui:FindFirstChild(FirstMenu)
        if FoundMenu and ChangedValue then
            FoundMenu.Enabled = false
        elseif FoundMenu and not ChangedValue then
            FoundMenu.Enabled = true
        end
    end)
    if not Success then
        SaveErrorToFile("MENU TOGGLE", Result)
    end
end
ThirdTab:AddInput("JoinPlayerInput", {
    Text = "輸入玩家名稱",
    Default = "",
    Placeholder = "玩家帳號名稱",
    Tooltip = "輸入玩家的真實帳號名稱（不是顯示名稱），若對方在線上且不在地下城中，可嘗試加入。",
})
ThirdTab:AddButton({
    Text = "加入玩家",
    Tooltip = "嘗試加入上方輸入的玩家所在伺服器。",
    Func = function()
        if not Options.JoinPlayerInput.Value or IsMainMenu or Options.JoinPlayerInput.Value == "" then
            return
        end
        if SV.CanRequire then
            local rTeleport = require(Teleport)
            rTeleport:TeleportToPlayer(LocalPlayer, Players:GetUserIdFromNameAsync(Options.JoinPlayerInput.Value), nil, true)
            Library:Notify("正在嘗試加入玩家：" ..Options.JoinPlayerInput.Value, 5)
        else
            Library:Notify("目前執行環境不支援此功能", 5)
        end
    end
})
    ThirdTab:AddDivider({Margin = -5})
CreateToggles({
    { "MobCameraToggle", Text = "鏡頭跟隨怪物", Tooltip = "讓鏡頭跟隨目前鎖定的怪物。", Tab = FirstTab },
    { "DamageNumbersToggle", Text = "隱藏傷害數字", Tooltip = "不再顯示傷害數字。", Tab = FirstTab },
    { "DamageFlashToggle", Text = "隱藏受擊紅光", Tooltip = "隱藏怪物受傷時的紅色閃光。", Tab = FirstTab },
    { "DeathEffectToggle", Text = "隱藏死亡特效", Tooltip = "不再顯示死亡特效。", Tab = FirstTab },
    { "KnockdownToggle", Text = "停用擊倒效果", Tooltip = "避免角色受到擊倒狀態影響；其他玩家仍可能看到狀態變化。", Tab = FirstTab },
    { "ShowEndTimeToggle", Text = "顯示通關時間", Tooltip = "通關地下城後顯示完成時間。", Tab = FirstTab },
    { "WaystoneToggle", Text = "最近的傳送石", Tooltip = "隱藏最近傳送石的圖示。", Tab = SecondTab },
    { "MissionObjectiveToggle", Text = "任務目標", Tooltip = "隱藏畫面上的任務目標提示。", Tab = SecondTab, AttachedFunction = ToggleMenu, FunctionValue = "MissionObjective" },
    { "BossBarToggle", Text = "Boss 血條", Tooltip = "隱藏 Boss 血條。", Tab = SecondTab, AttachedFunction = ToggleMenu, FunctionValue = "BossHealthbar" },
    { "PlayerHotbarToggle", Text = "快捷技能列", Tooltip = "隱藏生命值與技能快捷列。", Tab = SecondTab, AttachedFunction = ToggleMenu, FunctionValue = "Hotbar" },
    { "MobilePlayerSkills", Text = "手機技能按鈕", Tooltip = "隱藏手機版技能按鈕。", Tab = SecondTab, AttachedFunction = ToggleMenu, FunctionValue = "TouchInput" },
    { "MainGuiToggle", Text = "活動圖示", Tooltip = "隱藏活動圖示。", Tab = SecondTab, AttachedFunction = ToggleMenu, FunctionValue = "MainGui" },
    { "HideMenuToggle", Text = "遊戲選單", Tooltip = "隱藏遊戲內的選單介面。", Tab = SecondTab, AttachedFunction = ToggleMenu, FunctionValue = "Menu" },
    { "DevKickToggle", Text = "開發者加入時離開", Tooltip = "開發人員加入伺服器時，自動離開遊戲。", Tab = ThirdTab },
    { "ProfilerToggle", Text = "顯示帳號資訊", Tooltip = "顯示目前帳號的基本資訊。", Tab = ThirdTab },
    { "AFKToggle", Text = "防止閒置斷線", Tooltip = "避免長時間閒置被踢出；部分執行環境可能不支援。", Tab = ThirdTab },
    { "MainMenuPlay", Text = "自動點擊開始", Tooltip = "在主選單自動點擊「開始遊戲」。", Tab = ThirdTab },
    { "AutoJoinDungeon", Text = "自動加入地下城", Tooltip = "有可加入的夢魘地下城時自動加入。", Tab = ThirdTab },
    { "MobESPToggle", Text = "怪物高亮 (ESP)", Tooltip = "高亮標示怪物。", Tab = ThirdTab },
    { "NoclipCameraToggle", Text = "鏡頭穿牆", Tooltip = "允許鏡頭穿過牆面。", Tab = ThirdTab },
    { "DisableAutoJumpToggle", Text = "停用自動跳躍", Tooltip = "在手機裝置停用自動跳躍。", Tab = ThirdTab },
    { "RemoveOtherPlayersToggle", Text = "隱藏其他玩家", Tooltip = "在本機隱藏其他玩家與寵物。", Tab = FourthTab },
    { "DisableRenderingToggle", Text = "關閉 3D 畫面渲染", Tooltip = "停用 3D 畫面渲染，以大幅降低顯示卡負載。", Tab = FourthTab },
    { "PreventEffectsToggle", Text = "不顯示新特效", Tooltip = "停止渲染新出現的特效（例如投射物）！\n正常遊玩時請勿啟用。", Tab = FourthTab },
    { "PreventMobToggle", Text = "不顯示新模型", Tooltip = "停止顯示大部分尚未載入的新模型。", Tab = FourthTab }
})
    FirstTab:AddDivider({Margin = -5})
local rWalkspeedManager
FirstTab:AddSlider("WalkspeedSlider", {
    Text = "修改移動速度",
    Default = 28,
    Min = 28,
    Max = 200,
    Rounding = 0,
    Tooltip = "變更角色的移動速度。",
    Callback = function(ChangedValue)
        if SV.CanRequire then
            if not rWalkspeedManager then
                rWalkspeedManager = require(rWalkspeedManager)
            end
            rWalkspeedManager:SetBaseSpeed(tonumber(ChangedValue))
        end
    end
})
    ThirdTab:AddDivider({Margin = -5})
ThirdTab:AddInput("ChangeClassColor", {
    Text = "修改職業技能顏色",
    Default = "",
    Placeholder = "FFFFFF",
    Tooltip = "只變更自己畫面上職業攻擊的顏色。",
    Callback = function(ChangedValue)
        if IsDungeon or IsWorld then
            LocalPlayer:SetAttribute("ClassColor", ChangedValue)
        end
    end
})
    FourthTab:AddDivider({Margin = -5})
FourthTab:AddSlider("FPSSlider", {
    Text = "調整 FPS 上限",
    Default = 60,
    Min = 20,
    Max = 240,
    Rounding = 0,
    Callback = function(ChangedValue)
        if setfpscap then
            setfpscap(tonumber(ChangedValue))
        end
    end
})
end -- for unloaded miscellaneous

if not SV.DiscordTab then -- for unloaded discord tab
local DiscTab = Window:AddTab({
    Name = "Discord 社群",
    Icon = "rbxasset://textures/ui/LuaApp/ExternalSite/discord@3x.png"
})
local LeftTab = DiscTab:AddLeftTabbox("Left Tabbox")
    local FirstTab = LeftTab:AddTab("主要")
    local SecondTab = LeftTab:AddTab("設定")
local RightTab = DiscTab:AddRightTabbox("Right Tabbox")
    local ThirdTab = RightTab:AddTab("加入 Discord")

FirstTab:AddInput("WebhookLinkInput", {
    Text = "Webhook 網址",
    Default = "",
    Placeholder = "https://discord.com/api/webhooks/",
    Callback = function(ChangedValue)
        if string.find(ChangedValue, "https://discord.com/api/webhooks/") then
            SV.DiscordWebhookLink = ChangedValue
        else
            SV.DiscordWebhookLink = nil
        end
    end
})

local function ToggleValue(ChangedValue, ToggleValue)
    if ChangedValue and not IsMainMenu then
        SV[tostring(ToggleValue)] = true
    else
        SV[tostring(ToggleValue)] = nil
    end
end

CreateToggles({
    { "DungeonLoggerToggle", Text = "記錄地下城", Tooltip = "地下城結束時，將通關資訊傳送到設定的 Webhook。", Tab = FirstTab, AttachedFunction = ToggleValue, FunctionValue = "DungeonPing" },
    { "PerkPingToggle", Text = "詞條掉落時通知", Tooltip = "獲得含有指定保留詞條的物品時，傳送 Webhook 通知。", Tab = FirstTab, AttachedFunction = ToggleValue, FunctionValue = "PerkPing" },
    { "ClassPingToggle", Text = "職業精通時通知", Tooltip = "解鎖目前職業的精通職業後，傳送 Webhook 通知。", Tab = FirstTab },
    { "NightmarePingToggle", Text = "夢魘次數達上限時通知", Tooltip = "夢魘地下城通關次數達上限時，傳送 Webhook 通知。", Tab = FirstTab, AttachedFunction = ToggleValue, FunctionValue = "NightmarePing" },
    { "GuildPingToggle", Text = "公會積分達上限時通知", Tooltip = "公會積分達到上限時，傳送 Webhook 通知。", Tab = FirstTab, AttachedFunction = ToggleValue, FunctionValue = "GuildPing" },
    { "EventBossPingToggle", Text = "活動 Boss 次數達上限時通知", Tooltip = "活動 Boss 擊殺次數達上限時，傳送 Webhook 通知。", Tab = FirstTab, AttachedFunction = ToggleValue, FunctionValue = "EventPing" },
    { "ShowPlayersToggle", Text = "顯示隊伍成員詳情", Tooltip = "顯示隊伍中每位成員的資訊，而不只是人數。", Tab = SecondTab }
})
SecondTab:AddDropdown("PingDropdown", {
    Values = {
        [""] = "none",
        ["@here"] = "@here",
        ["@everyone"] = "@everyone"
    },
    Multi = false,
    Text = "通知提及方式",
    AllowNull = false,
    Default = "@everyone",
    Callback = function(ChangedValue)
        DiscordPingType = tostring(ChangedValue)
    end
})
SecondTab:AddButton({
    Text = "傳送測試訊息",
    Tooltip = "確認所填入的 Webhook 是否能正常運作。",
    DoubleClick = true,
    Func = function()
        if not request then
            Library:Notify("目前執行環境不允許發送請求", 5)
        end
        pcall(function()
            local MessageContent = {
                ["username"] = "test",
                ["content"] = "test " ..DiscordPingType
            }
            RequestMessage(SV.DiscordWebhookLink, MessageContent, false)
        end)
    end
})
ThirdTab:AddLabel("想了解腳本的<font color='#33FF33'>更新</font>與<font color='#33FF33'>變動</font>，或<font color='#ff3333'>回報問題</font>，歡迎加入作者的 <font color='#5650F6'>Discord</font>！", true)
ThirdTab:AddButton({
    Text = "複製 Discord 邀請連結",
    Tooltip = "邀請連結會複製到裝置剪貼簿。",
    Func = function()
        local Success, Result = pcall(function()
            setclipboard("https://discord.gg/bNWWpqFZbP")
        end)
        if not Success then
            Library:Notify("執行環境不允許此操作", 5)
        end
    end
})
end -- for unloaded discord tab

if not SV.ConfigurationTab then -- for unloaded config tab
SetGlobal("creating config tab")
ConfigTab = Window:AddTab({
    Name = "設定",
    Icon = "rbxassetid://9671045892"
})
local LeftTab = ConfigTab:AddLeftTabbox("Left Tabbox")
    local FirstTab = LeftTab:AddTab("主要")
    local SecondTab = LeftTab:AddTab("除錯")

CreateToggles({
    { "HideGuiToggle", Text = "執行後隱藏選單", Tab = FirstTab },
    { "AutoScriptToggle", Text = "自動執行腳本", Tab = FirstTab }
})

    FirstTab:AddDivider({Margin = -5})
local LastUpdated
FirstTab:AddDropdown("UnloadTabDropdown", {
    Values = {
        ["GeneralTab"] = "主要",
        ["EventTab"] = "活動",
        ["TradingTab"] = "交易",
        ["ClassesTab"] = "職業",
        ["InventoryTab"] = "背包",
        ["DungeonsTab"] = "地下城",
        ["GuildTab"] = "公會",
        ["ShopsTab"] = "商店",
        ["QuickMenusTab"] = "快速選單",
        ["MiscellaneousTab"] = "額外進階功能",
        ["DiscordTab"] = "Discord 社群"
    },
    Multi = true,
    AllowNull = true,
    Default = "",
    MaxVisibleDropdownItems = 5,
    Searchable = true,
    Tooltip = "選取的分頁及其功能，下次執行時將不會載入；取消選取後，下次才會重新載入。\n<font color=\'#ff3333\'>注意：被排除的分頁將<u>完全不載入</u>。若設定檔原本包含這些分頁，之後儲存其他設定時，可能無法保留它們的設定內容。</font>",
    Text = "下次不載入的分頁",
    Callback = function(ChangedValue)
        if ChangedValue then
            local LastChanged = time()+2
            LastUpdated = LastChanged
            if LastChanged == LastUpdated then
                local TabsToUnload = {}
                for Tab in ChangedValue do
                    table.insert(TabsToUnload, tostring(Tab))
                end
                writefile("JDRS/SkipTabs", HttpService:JSONEncode(TabsToUnload))
            end
            LastUpdated = nil
        end
    end
})
    FirstTab:AddDivider({Margin = -5})
FirstTab:AddButton({
    Text = "停止下次自動執行",
    Func = function()
        print("running delete")
        local FileName = "JDRS/AutoExecute"
        if isfile(FileName) then
            delfile(FileName)
        end
        if EF.ClearQueue then
            Library:Notify("腳本在下次傳送時將不會自動執行。希望你使用愉快、沒有遇到問題！\n -JDRS", 10)
            EF.ClearQueue()
        end
    end
})
FirstTab:AddButton({
    Text = "<font color='#ff3333'>終止腳本</font>",
    Tooltip = "卸載腳本並清理記憶體；執行後若主控台出現相關錯誤，可先忽略。",
    DoubleClick = true,
    Func = function()
        KillSwitch = true
        CleanUpScript(true)
        print("JDRS: script has been unloaded")
    end
})
        SecondTab:AddLabel("以下為問題回報及開發除錯用途，一般使用者不需要操作。", true)
        SecondTab:AddDivider({Margin = -5})
        SecondTab:AddToggle("MobDebugToggle", {
            Text = "輸出偵錯訊息",
            Tooltip = "顯示怪物生成時的腳本處理資訊。",
            Default = false,
            Callback = function(ChangedValue)
                if ChangedValue and (IsDungeon or IsWorld) then
                    ISV.Debug = true
                    Library:Notify("偵錯資訊將輸出到 F9 主控台")
                else
                    ISV.Debug = nil
                end
            end
        })
        SecondTab:AddButton({
            Text = "顯示目前目標怪物",
            Tooltip = "輸出目前正在鎖定的怪物。",
            Func = function()
                if not IsDungeon then
                    warn("No mobs are being targeted, not in dungeon.")
                    return
                end
                local TargetMob = CurrentMob
                if not TargetMob then
                    print("JDRS: no mob is a target")
                    return
                end
                local TargetMobReference = ISV.MobTable[TargetMob]
                local MobString = "JDRS: current target is " .. TargetMob.Name
                if TargetMobReference then
                    if TargetMobReference.Invincible then
                        MobString = MobString .. " (invincible)"
                    end
                    if TargetMobReference.IsBlocker then
                        MobString = MobString .. " (blocker, highest priority)"
                    end
                    if TargetMobReference.Priority then
                        MobString = MobString .. " (priority)"
                    end
                    if TargetMobReference.NoData then
                        MobString = MobString .. " (no data)"
                    end
                    MobString = MobString .. " Path: " ..tostring(TargetMob:GetFullName())
                end
                print(MobString)
                Library:Notify("目前目標已輸出到主控台")
            end
        })
        SecondTab:AddButton({
            Text = "顯示所有目標怪物",
            Tooltip = "輸出目前所有鎖定的怪物。",
            Func = function()
                if not IsDungeon then
                    warn("No mobs are being targeted, not in dungeon.")
                    return
                end
                local MobString = "JDRS current mobs: " ..tostring(IsAliveMobs).. "\n"
                for Mob, Info in ISV.MobTable do
                    MobString = MobString .. tostring(Mob)
                    if Info.Invincible then
                        MobString = MobString .. " (invincible)"
                    end
                    if Info.IsBlocker then
                        MobString = MobString .. " (blocker, highest priority)"
                    end
                    if Info.Priority then
                        MobString = MobString .. " (priority)"
                    end
                    if Info.NoData then
                        MobString = MobString .. " (no data)"
                    end
                    MobString = MobString .. " Path: " .. tostring(Mob:GetFullName())
                    if Mob == CurrentMob then
                        MobString = MobString .. " (current target)"
                    end
                    MobString = MobString .."\n"
                end
                print(MobString)
                Library:Notify("目標怪物已輸出到主控台")
            end
        })
        SecondTab:AddButton({
            Text = "顯示傳送目標物件",
            Tooltip = "輸出腳本正在嘗試傳送的物件。",
            Func = function()
                if not IsDungeon then
                    warn("No objects are being teleported, not in dungeon.")
                    return
                end
                local ObjString = "JDRS current objects:\n"
                for Part, Info in TeleportParts do
                    ObjString = ObjString .. string.format(
                        "%* %*Path: %*\n",
                        Part, Info and Info.Regenerates and "(regenerates) " or "", Part:GetFullName()
                    ) 
                end
                print(ObjString)
                Library:Notify("目標物件已輸出到主控台")
            end
        })
        SecondTab:AddButton({
            Text = "開啟主控台",
            Tooltip = "不方便透過聊天開啟時，可直接開啟 Roblox 主控台。",
            Func = function()
                StarterGui:SetCore("DevConsoleVisible", true)
            end
        })
        SecondTab:AddButton({
            Text = "遠端事件檢視 (Remote Spy)",
            Tooltip = "載入遠端事件／函式檢視工具。\n（關閉工具可能造成崩潰）\n\n<font color=\'#FCCE7E\'>工具作者：</font> upio、deivid",
            Func = function()
                Library:Notify("正在載入 Cobalt")
                loadstring(game:HttpGet("https://gitlab.com/upio/cobalt/-/releases/permalink/latest/downloads/Cobalt.luau"))()
            end
        })
        SecondTab:AddButton({
            Text = "物件檢視器 (Dex)",
            Tooltip = "載入遊戲場景物件檢視工具。\n\n<font color=\'#FCCE7E\'>工具作者：</font> chillz",
            Func = function()
                Library:Notify("正在載入 Dex")
                loadstring(game:HttpGet("https://github.com/AZYsGithub/DexPlusPlus/releases/latest/download/out.lua"))()
            end
        })
        SecondTab:AddButton({
            Text = "強制重開地下城",
            DoubleClick = true,
            Func = function()
                if IsDungeon then
                    if SV.RestartSelecting then return end
                    if SV.TransitionPending or SV.TransitionUnconfirmed then
                        warn("[WZF][D2] user requested manual retry; previous request may still complete; job:", game.JobId)
                        SV.TransitionPending = false
                        SV.TransitionUnconfirmed = false
                    end
                    ReplayDungeonLoop(ISV.MissionId, ISV.LoggedDifficulty)
                end
            end
        })
        CompatibilityButton = SecondTab:AddButton({
            Text = "檢查執行環境相容性",
            Tooltip = "將此按鈕替換為多個檢查項目，顯示執行環境是否支援重要函式。",
            Func = function()
                    SecondTab:AddDivider({Margin = -5})
                local RequireLabel = SecondTab:AddLabel("require: ?", true)
                local HookfunctionLabel = SecondTab:AddLabel("hookfunction: ?", true)
                local RestorefunctionLabel = SecondTab:AddLabel("restorefunction: ?", true)
                local UpvalueLabel = SecondTab:AddLabel("getupvalue: ?", true)
                local NewcclosureLabel = SecondTab:AddLabel("newcclosure: ?", true)
                local AutoInjectLabel = SecondTab:AddLabel("queueonteleport: ?", false)
                local RequestLabel = SecondTab:AddLabel("request: ?", true)
                local InvisTeleportLabel = SecondTab:AddLabel("隱形傳送：？", true)
                if SV.CanRequire then
                    RequireLabel:SetText("require: <font color='#33ff33'>是</font>")
                else
                    RequireLabel:SetText("require: <font color='#ff3333'>否</font>")
                end

                if EF.Hook then
                    HookfunctionLabel:SetText("hookfunction: <font color='#33ff33'>是</font>")
                else
                    HookfunctionLabel:SetText("hookfunction: <font color='#ff3333'>否</font>")
                end

                if EF.ClearHook then
                    RestorefunctionLabel:SetText("restorefunction: <font color='#33ff33'>是</font>")
                else
                    RestorefunctionLabel:SetText("restorefunction: <font color='#ff3333'>否</font>")
                end

                if debug and debug.getupvalue then
                    UpvalueLabel:SetText("getupvalue: <font color='#33ff33'>是</font>")
                else
                    UpvalueLabel:SetText("getupvalue: <font color='#ff3333'>否</font>")
                end

                if EF.NewClosure then
                    NewcclosureLabel:SetText("newcclosure: <font color='#33ff33'>是</font>")
                else
                    NewcclosureLabel:SetText("newcclosure: <font color='#ff3333'>否</font>")
                end

                if EF.Queue then
                    AutoInjectLabel:SetText("queueonteleport: <font color='#33ff33'>是</font>")
                else
                    AutoInjectLabel:SetText("queueonteleport: <font color='#ff3333'>否</font>")
                end

                if EF.SendRequest then
                    RequestLabel:SetText("request: <font color='#33ff33'>是</font>")
                else
                    RequestLabel:SetText("request: <font color='#ff3333'>否</font>")
                end

                if EF.Desync and EF.RaknetFunction.is_enabled() then
                    InvisTeleportLabel:SetText("可隱形傳送： <font color='#33ff33'>是</font>", false)
                else
                    InvisTeleportLabel:SetText("可隱形傳送： <font color='#ff3333'>否</font>")
                end
                CompatibilityButton:Destroy()
                CompatibilityButton = nil
            end
        })
end -- for unloaded config tab
-- Worker epochs survive yielding callbacks; disabling never waits for a character.
local Perf = { Epoch = {}, Errors = {} }
function Perf.Alive(Key, Epoch)
    return Perf.Epoch[Key] == Epoch and not ScriptUnloaded and not KillSwitch
        and Library and not Library.Unloaded
end
function Perf.Begin(Key)
    Perf.Epoch[Key] = (Perf.Epoch[Key] or 0) + 1
    return Perf.Epoch[Key]
end
function Perf.Wait(Key, Epoch, Enabled, Stamp)
    if not Enabled then return Stamp end
    while Perf.Alive(Key, Epoch) and not CombatCharacterReady() do task.wait(.1) end
    return Perf.Alive(Key, Epoch) and Stamp or nil
end
function Perf.Target(Mob)
    if not Mob or not Mob.Parent or not CombatCharacterReady() then return nil end
    local Flags = ISV.MobTable[Mob]
    if (Flags and Flags.Invincible) or Mob:GetAttribute("Invincible") == true then return nil end
    local HP = Mob:FindFirstChild("HealthProperties")
    local Health = HP and HP:FindFirstChild("Health")
    if Health and Health.Value <= 0 then return nil end
    local Collider = Mob:FindFirstChild("Collider")
    if Collider and Collider:IsA("BasePart") and Collider.Parent then return Collider end
end
function Perf.Send(Attack, Callback, Position)
    -- Reserve the original cooldown on every attempt, including a failed send.
    Attack.LastUsed = time()
    local OK, Error = pcall(Callback, Attack.Skill, Position)
    if not OK then
        local Key = tostring(Attack.Skill)
        if not Perf.Errors[Key] or os.clock() - Perf.Errors[Key] > 10 then
            Perf.Errors[Key] = os.clock()
            warn("[WZF][E1] attack failed; worker continues:", Key, tostring(Error))
        end
    end
    return OK
end
function Perf.CancelTween()
    if Perf.Tween then Perf.Tween:Cancel() Perf.Tween = nil end
end
SetGlobal("creating UI functions")

if not SV.GeneralTab then
SetGlobal("general tab functions")
if IsDungeon then
    local KillauraChanged
    Toggles.KillauraToggle:OnChanged(function(ChangedValue) -- killaura
        local Epoch = Perf.Begin("aura")
        if not ChangedValue then SV.Killaura = nil end
        local TimeActivated = os.clock()
        KillauraChanged = Perf.Wait("aura", Epoch, ChangedValue, TimeActivated)
        if TimeActivated ~= KillauraChanged or Perf.Epoch.aura ~= Epoch then
            return
        end
        
        if ChangedValue then
            if not Class then
                Library:Notify("CLASS NOT YET SUPPORTED", 9999999999999999)
                return
            end
            SV.Killaura = true
            local Success, Result = pcall(function()
                DisconnectVariable("ConnectClass")
                ConnectionTable["ConnectClass"] = LocalPlayer:GetAttributeChangedSignal("Class"):Connect(function()
                    if not Perf.Alive("aura", Epoch) then return end
                    local Updated = GetPlayerClass()
                    if Perf.Alive("aura", Epoch) then Class = Updated end
                end)
                if SV.CanRequire then
                    pcall(function()
                        local Actions = require(Client:WaitForChild("Actions", math.huge))
                        if Perf.Epoch.aura ~= Epoch then return end
                        Actions:SetSkillDisabled("Primary", true)
                        Actions:SetSkillDisabled("Skill1", true)
                        Actions:SetSkillDisabled("Skill2", true)
                        Actions:SetSkillDisabled("Skill3", true)
                        Actions:SetSkillDisabled("Ultimate", true)
                    end)
                end
                local LowerAttack = Vector3.new(0, 3, 0)
                local CAttack = Remotes:WaitForChild("Combat_Attack", math.huge)
                local AttackArgs = {
                    Ranged = function(Skill, AttackPosition)
                        if SV.IsRanged then
                            AttackPosition = AttackPosition - LowerAttack
                        end
                        CAttack:FireServer(Skill, AttackPosition, nil, AntiCheatNumber)
                    end,
                    Melee = function(Skill, AttackPosition)
                        CAttack:FireServer(Skill, PlayerRoot.Position, (AttackPosition - PlayerRoot.Position).Unit, AntiCheatNumber)
                    end,
                    ShadowChain = function(Skill)
                        Skill:FireServer{CurrentMob, CurrentMob, CurrentMob, CurrentMob, CurrentMob}
                    end,
                    TableRemote = function(Skill)
                        Skill:FireServer(CurrentMob)
                    end,
                    Remote = function(Skill)
                        Skill:FireServer()
                    end,
                    GuardianRemote = function(Skill)
                        Skill:FireServer(1, PlayerRoot.Position)
                    end,
                    HunterRemote = function(Skill)
                        Skill:FireServer(PlayerRoot.Position, 50)
                    end,
                    HunterTrapRemote = function(Skill, AttackPosition)
                        Skill:FireServer("BearTrap", AttackPosition)
                    end,
                    PlayerPositionRemote = function(Skill)
                        Skill:FireServer(PlayerRoot.Position)
                    end,
                    MobPositionRemote = function(Skill, AttackPosition)
                        Skill:FireServer(AttackPosition)
                    end,
                    CFrameRemote = function(Skill)
                        Skill:FireServer(PlayerRoot.CFrame)
                    end,
                    PlayerRemote = function(Skill)
                        Skill:FireServer(LocalPlayer)
                    end,
                    StarbreakerWaves = function(Skill, AttackPosition)
                        task.spawn(function()
                            if not Perf.Alive("aura", Epoch) or not SV.Killaura or not CombatCharacterReady() then return end
                            if IsBoss then
                                local Status = PlayerCharacter:FindFirstChild("Status")
                                if Status and Status:FindFirstChild("Starforge") then
                                    for Swing = 1, 5 do
                                        for Hit = 1, 10 do
                                            CAttack:FireServer("StarbreakerWaveSwing" ..tostring(Swing).. "Hit" ..tostring(Hit), PlayerRoot.Position, (AttackPosition - PlayerRoot.Position).Unit, AntiCheatNumber)
                                        end
                                    end
                                end
                            end
                        end)
                    end
                }
                local Cursor = 1
                while Perf.Alive("aura", Epoch) and SV.Killaura do
                    local Target, Root = CurrentMob, PlayerRoot
                    local Collider = Perf.Target(Target)
                    local Skills = Class and Class.Skills
                    if Collider and Skills and #Skills > 0 and not SV.DodgingAttack and not SV.TransitionPending then
                        local MobSurface = Collider:GetClosestPointOnSurface(Root.Position)
                        local Distance = (Root:GetClosestPointOnSurface(Collider.Position) - MobSurface).Magnitude
                        local Count = #Skills
                        -- Round-robin only among ready, in-range skills; do not shorten cooldowns.
                        for Visit = 1, Count do
                            if not Perf.Alive("aura", Epoch) or not SV.Killaura then break end
                            local Index = ((Cursor + Visit - 2) % Count) + 1
                            local Attack = Skills[Index]
                            if time() - (Attack.LastUsed or 0) >= Attack.Cooldown + AddedDelay + PlayerPing
                                and Distance <= Attack.Distance then
                                local TpTime = Target:GetAttribute("T")
                                if SV.Autofarm and IsBoss and not (TpTime and TpTime + .2 < time()) then break end
                                local Handler = AttackArgs[Attack.Type]
                                if Handler then
                                    Perf.Send(Attack, Handler, MobSurface)
                                    Cursor = Index % Count + 1
                                    if DelayAttacks and not IsBoss then task.wait(DelayAttacks) end
                                    break -- Recompute target geometry after each dispatch/yield.
                                else
                                    Attack.LastUsed = time()
                                    warn("[WZF][E1] unsupported attack type:", tostring(Attack.Type))
                                end
                            end
                        end
                    end
                    task.wait()
                end
            end)
            if not Success then
                SaveErrorToFile("KILLAURA", Result, SV.PlayerClass)
            end
        else
            if SV.CanRequire then
                pcall(function()
                    local Actions = require(Client:WaitForChild("Actions", math.huge))
                        if Perf.Epoch.aura ~= Epoch then return end
                    Actions:SetSkillDisabled("Primary", false)
                    Actions:SetSkillDisabled("Skill1", false)
                    Actions:SetSkillDisabled("Skill2", false)
                    Actions:SetSkillDisabled("Skill3", false)
                    Actions:SetSkillDisabled("Ultimate", false)
                end)
            end
            if Perf.Epoch.aura == Epoch then
                DisconnectVariable("ConnectClass")
                SV.Killaura = nil
            end
        end
    end)
    Toggles.SafeKillauraToggle:OnChanged(function(ChangedValue) -- killaura
        local Epoch = Perf.Begin("safe")
        SV.SafeKillaura = ChangedValue and true or nil
        if SV.CanRequire and EF.Hook and EF.ClearHook and EF.NewClosure and EF.CheckHook then
            local Success, Result = pcall(function()
                local Actions = require(Client.Actions)
                if Perf.Epoch.safe ~= Epoch then return end
                if ChangedValue then
                    SV.SafeKillaura = true
                    if SV.IsRanged then
                        Library:Notify("adjust class distances in the \"Classes\" tab if you are too far from the mobs to do damage.", 10)
                    end
                    CreateHookOnFunction(Actions.IsBusy, true)

                    local SkillNames = {
                        "Primary", "Skill1", "Skill2", "Skill3", "Ultimate"
                    }
                    local AttackCount = 1
                    for Index, Skill in SkillNames do
                        if AttackCount == 1 then
                            task.spawn(function()
                                repeat
                                    if Perf.Alive("safe", Epoch) and CombatCharacterReady() and Perf.Target(CurrentMob) and not SV.TransitionPending then
                                        pcall(Actions.UseSkill, Actions, Skill)
                                    end
                                    task.wait()
                                until not SV.SafeKillaura or not Perf.Alive("safe", Epoch)
                            end)
                        else
                            task.spawn(function()
                                repeat
                                    if Perf.Alive("safe", Epoch) and CombatCharacterReady() and Perf.Target(CurrentMob) and not SV.TransitionPending then
                                        pcall(Actions.UseSkill, Actions, Skill)
                                    end
                                    task.wait(.2)
                                until not SV.SafeKillaura or not Perf.Alive("safe", Epoch)
                            end)
                        end
                        AttackCount = AttackCount + 1
                    end
                    while SV.SafeKillaura and Perf.Alive("safe", Epoch) do
                        if CombatCharacterReady() and Actions:IsSheathed() then
                            Actions:UseSkill("Sheath")
                        end
                        task.wait(1)
                    end
                else
                    SV.SafeKillaura = nil
                    CreateHookOnFunction(Actions.IsBusy, false)
                end
            end)
            if not Success then
                SaveErrorToFile("SAFE KILLAURA", Result)
            end
        elseif mouse1click and keyclick then
            local Success, Result = pcall(function()
                if ChangedValue then
                    while SV.SafeKillaura and Perf.Alive("safe", Epoch) do
                        mouse1click(1, 1)
                        keyclick(Enum.KeyCode.E)
                        keyclick(Enum.KeyCode.R)
                        keyclick(Enum.KeyCode.F)
                        keyclick(Enum.KeyCode.X)
                        task.wait()
                    end
                else
                    SV.SafeKillaura = nil
                end
            end)
            if not Success then
                SaveErrorToFile("SAFE KILLAURA FALLBACK", Result)
            end
        else
            Library:Notify("Your executor doesn't support this", 5)
        end
    end)
    local function ReleaseShield()
        if Perf.Shield then
            TempStop, CanTarget = Perf.Shield.Stop, Perf.Shield.Target
            Perf.Shield = nil
        end
    end
    Toggles.AutoProgressToggle:OnChanged(function(Enabled)
        local Epoch = Perf.Begin("farm")
        Perf.CancelTween()
        ReleaseShield()
        SV.Autofarm = Enabled and true or nil
        print("[WZF][E1] farm:", Enabled, "epoch:", Epoch)
        if not Enabled then
            if PlayerRoot then PlayerRoot.CanCollide = true end
            for Part, Data in TeleportParts do
                if Part.Parent then
                    Part.Size, Part.CanCollide, Part.Position = Data.OriginalSize, Data.OriginalCollision, Data.OriginalLocation
                end
            end
            local Camera = Workspace.CurrentCamera
            if Camera then Camera.CameraSubject = (SV.PlayerCamera and SV.PlayerCamera.Parent and SV.PlayerCamera)
                or (PlayerCharacter and PlayerCharacter:FindFirstChildOfClass("Humanoid")) end
            SV.WZFMoverState = "toggle-off"
            return
        end
        if not Perf.Wait("farm", Epoch, true, true) then return end
        task.spawn(function()
            local LastRoot, LastCollider, LastGoal
            local LastUpdate, Angle = 0, 0
            local OK, Error = pcall(function()
                SV.WZFMoverState = "running"
                while Perf.Alive("farm", Epoch) and SV.Autofarm do
                    SV.WZFMoverTick = os.clock()
                    if not CombatCharacterReady() or TempStop or HoldForRealTime or EventOverride then
                        Perf.CancelTween()
                        LastRoot, LastCollider, LastGoal = nil, nil, nil
                        task.wait(.1)
                        continue
                    end
                    local Root, Mob = PlayerRoot, TeleportMob
                    Root.CanCollide = false
                    local Collider = Mob and Mob.Parent and Mob:FindFirstChild("Collider")
                    if Collider and Collider:IsA("BasePart") then
                        Root.AssemblyLinearVelocity = Vector3.zero
                        local Offset = Xdistance + Collider.Size.X / 2
                        if math.abs(Offset) < .1 then Offset = .1 end
                        Angle += MobRotationSpeed / Offset
                        local Goal = CFrame.new(Collider.Position) * CFrame.Angles(0, math.rad(Angle), 0) * CFrame.new(Offset, Ydistance, 0)
                        Goal = CFrame.lookAt(Goal.Position, Vector3.new(Collider.Position.X, Goal.Position.Y, Collider.Position.Z))
                        local Distance = (Root.Position - Collider.Position).Magnitude
                        if Root ~= LastRoot or Collider ~= LastCollider or Distance > 200 then
                            Perf.CancelTween()
                            Root.CFrame = Goal
                            LastRoot, LastCollider, LastGoal, LastUpdate = Root, Collider, Goal, os.clock()
                        elseif os.clock() - LastUpdate >= .12 and (not LastGoal or (Goal.Position - LastGoal.Position).Magnitude >= .75
                            or Goal.LookVector:Dot(LastGoal.LookVector) < .995) then
                            Perf.CancelTween()
                            Perf.Tween = TweenService:Create(Root, TweenInfo.new(math.clamp(Distance / 70, .08, 1), Enum.EasingStyle.Linear), {CFrame = Goal})
                            Perf.Tween:Play()
                            LastGoal, LastUpdate = Goal, os.clock()
                        end
                        if IsBoss and not Mob:GetAttribute("T") then Mob:SetAttribute("T", time()) end
                        local Camera = Workspace.CurrentCamera
                        if IsMobCamera and Camera and Camera.CameraSubject ~= Mob then Camera.CameraSubject = Mob end
                    else
                        Perf.CancelTween()
                        LastCollider, LastGoal = nil, nil
                    end
                    TeleportStandPart()
                    task.wait()
                end
            end)
            if Perf.Epoch.farm == Epoch then
                Perf.CancelTween()
                SV.WZFMoverState = OK and "stopped" or "error"
                if not OK then warn("[WZF][E1] mover failed:", tostring(Error)) end
            end
        end)
        task.spawn(function()
            local BusyParts = {}
            while Perf.Alive("farm", Epoch) and SV.Autofarm do
                if CombatCharacterReady() then
                    for Part, Data in TeleportParts do
                        if not Perf.Alive("farm", Epoch) then break end
                        if Part.Parent then Part.Size = Vector3.one Part.CanCollide = false end
                        if not SV.StopTeleportingParts and not Data.DontTeleport and Part.Parent and Data.TouchPart and Data.TouchPart.Parent and not BusyParts[Part] then
                            BusyParts[Part] = true
                            task.spawn(function()
                                pcall(function()
                                    if not Perf.Alive("farm", Epoch) or not CombatCharacterReady() then return end
                                    Part.Position = PlayerRoot.Position
                                    task.wait(.1)
                                    if Perf.Alive("farm", Epoch) and Part.Parent then Part.Position = Data.OriginalLocation end
                                end)
                                BusyParts[Part] = nil
                            end)
                        elseif not Part.Parent and not Data.Regenerates then TeleportParts[Part] = nil end
                    end
                end
                task.wait(.1)
            end
        end)
        task.spawn(function()
            if not table.find({16, 21, 38, 44, 52}, ISV.MissionId) and SV.PartyRaidID ~= 14 then return end
            local OK, Error = pcall(function()
                while Perf.Alive("farm", Epoch) and SV.Autofarm do
                    for _, Name in {"IceWall", "IgnisShield", "ZeroShield", "ShieldEgg", "EggShield"} do
                        local Shield = Workspace:FindFirstChild(Name)
                        if Shield then
                            if Name == "ShieldEgg" or Name == "EggShield" then
                                local Rename = Shield:WaitForChild("ShieldEgg", 1) or Shield:WaitForChild("Blade", 1)
                                if Rename then Rename.Name = "Ring" end
                            end
                            local Ring = Shield:WaitForChild("Ring", 5)
                            if not Perf.Alive("farm", Epoch) or not SV.Autofarm then return end
                            if Ring and Ring.Parent and CombatCharacterReady() then
                                Perf.Shield = {Stop = TempStop, Target = CanTarget}
                                TempStop, CanTarget = true, false
                                while Shield.Parent and Perf.Alive("farm", Epoch) and SV.Autofarm do
                                    if not CombatCharacterReady() then break end
                                    PlayerRoot.CFrame = CFrame.new(Ring.Position + Vector3.new(0, GetPlayerSize() + Ring.Size.Y / 2, 0))
                                    task.wait()
                                end
                                if Perf.Epoch.farm == Epoch then ReleaseShield() end
                            end
                        end
                    end
                    task.wait(.5)
                end
            end)
            if Perf.Epoch.farm == Epoch then ReleaseShield() end
            if not OK then warn("[WZF][E1] shield worker failed:", tostring(Error)) end
        end)
    end)
end
if not IsMainMenu then
    Toggles.CollectDropToggle:OnChanged(function(ChangedValue) -- collect drops
        if StringPlaceID == "6510868181" then
            return
        end
        if ChangedValue then
            SV.CollectDrops = true
            if SV.CanRequire and EF.Hook and EF.NewClosure then
                local rDrops = require(Drops)
                CreateHookOnFunction(rDrops.DropStarterpassExp, true)
                CreateHookOnFunction(rDrops.DropBattlepassExp, true)
                CreateHookOnFunction(rDrops.DropHealthOrb, true)
                CreateHookOnFunction(rDrops.SpawnCoinsLocal, true)
            end
            for CoinID, SpawnTime in SV.Drops do
                if time() < SpawnTime+120 then
                    Remotes:WaitForChild("Drops_CoinEvent", math.huge):FireServer(CoinID)
                end
            end
            table.clear(SV.Drops)
            CollectCoins()
        else
            SV.CollectDrops = false
            if SV.CanRequire and EF.Hook and EF.NewClosure then
                local rDrops = require(Drops)
                CreateHookOnFunction(rDrops.DropStarterpassExp, false)
                CreateHookOnFunction(rDrops.DropBattlepassExp, false)
                CreateHookOnFunction(rDrops.DropHealthOrb, false)
                CreateHookOnFunction(rDrops.SpawnCoinsLocal, false)
            end
        end
    end)
end
if IsDungeon then
    local PetKillaura
    local PetKillauraChanged
    Toggles.PetKillauraToggle:OnChanged(function(ChangedValue) -- use pet skill
        local Epoch = Perf.Begin("pet")
        if not ChangedValue then PetKillaura = nil end
        local TimeActivated = os.clock()
        PetKillauraChanged = Perf.Wait("pet", Epoch, ChangedValue, TimeActivated)
        if TimeActivated ~= PetKillauraChanged or Perf.Epoch.pet ~= Epoch then
            return
        end

        if ChangedValue then
            PetKillaura = true
            if SV.CanRequire then
                local Success, Result = pcall(function()
                    local UseSkill = Remotes:WaitForChild("PetSkills_UseSkill", math.huge)
                    local PetSkill = GetPlayerPet(function() return not Perf.Alive("pet", Epoch) or not PetKillaura end)
                    if not Perf.Alive("pet", Epoch) then return end
                    local PetCharacter = PlayerCharacter

                    DisconnectVariable("ConnectCharacter")
                    ConnectionTable["ConnectCharacter"] = PlayerCharacter.ChildAdded:Connect(function(NewChild)
                        if NewChild.Name == "PetData" then
                            local Updated = GetPlayerPet(function() return not Perf.Alive("pet", Epoch) end)
                            if Perf.Alive("pet", Epoch) then PetSkill = Updated end
                        end
                    end)

                    local CAttack = Remotes:WaitForChild("Combat_Attack", math.huge)
                    local AttackArgs = {
                        Ranged = function(Skill, AttackPosition)
                            CAttack:FireServer(Skill, AttackPosition, nil, AntiCheatNumber)
                        end,
                        Self = function()
                            local Root = PlayerRoot
                            if not Root or not Root.Parent or not PlayerCharacter or Root.Parent ~= PlayerCharacter then return end
                            UseSkill:FireServer(PlayerCharacter, Root.Position)
                        end,
                        MobPosition = function(Skill, AttackPosition)
                            UseSkill:FireServer(PlayerCharacter, AttackPosition)
                        end
                    }
                    while PetKillaura and Perf.Alive("pet", Epoch) and not KillSwitch and not ScriptUnloaded do
                        if CombatCharacterReady() and PetCharacter ~= PlayerCharacter then
                            DisconnectVariable("ConnectCharacter")
                            PetCharacter = PlayerCharacter
                            PetSkill = GetPlayerPet(function() return not Perf.Alive("pet", Epoch) end)
                            if not Perf.Alive("pet", Epoch) then return end
                            ConnectionTable["ConnectCharacter"] = PetCharacter.ChildAdded:Connect(function(Child)
                                if Child.Name == "PetData" then
                                    local Updated = GetPlayerPet(function() return not Perf.Alive("pet", Epoch) end)
                                    if Perf.Alive("pet", Epoch) then PetSkill = Updated end
                                end
                            end)
                        end
                        if not PlayerRoot or not PlayerRoot.Parent or not PlayerCharacter
                            or PlayerRoot.Parent ~= PlayerCharacter or not PetSkill or not PetSkill.Skills then
                            task.wait(.1)
                            continue
                        end
                        for _, Attack in PetSkill.Skills do
                            if not Perf.Alive("pet", Epoch) then break end
                            -- A previous skill may yield; refresh references for every attack.
                            local ActiveRoot = PlayerRoot
                            local Target = CurrentMob
                            if not Perf.Target(Target) or not ActiveRoot or not ActiveRoot.Parent or ActiveRoot.Parent ~= PlayerCharacter
                                or not Target or not Target.Parent then continue end
                            if CurrentMob then
                                local AttackCooldown = Attack.Cooldown
                                if tick() - (Attack.LastUsed or 0) >= AttackCooldown+AddedDelay then
                                    local AttackType = Attack.Type
                                    local MobCollider = Target:FindFirstChild("Collider")
                                    if MobCollider then
                                        local AttackDistance = Attack.Distance
                                        local PlayerSurface = ActiveRoot:GetClosestPointOnSurface(MobCollider.Position)
                                        local MobSurface = MobCollider:GetClosestPointOnSurface(ActiveRoot.Position)
                                        local Distance = (PlayerSurface - MobSurface).Magnitude
                                        if Distance <= AttackDistance then
                                            local TpTime = Target:GetAttribute("T")
                                            if SV.Autofarm and IsBoss and not (TpTime and TpTime+0.2 < time()) then
                                                break
                                            end
                                            local FindAttackType = AttackArgs[AttackType]
                                            if FindAttackType then
                                                Perf.Send(Attack, FindAttackType, MobSurface)
                                            else
                                                SV.PetKillaura = nil
                                                SaveErrorToFile("PET ATTACK TYPE", "invalid attack type or attack type not supported", AttackType)
                                                break
                                            end
                                            Attack.LastUsed = tick()
                                            if DelayPetAttacks then
                                                task.wait(DelayPetAttacks)
                                            end
                                        end
                                    end
                                end
                            end
                        end
                        task.wait(.1)
                    end
                end)
                if not Perf.Alive("pet", Epoch) then return end
                if not Success then
                    local PetData = PlayerCharacter and PlayerCharacter:FindFirstChild("PetData")
                    if PetData and PetSkills and SV.CanRequire then
                        task.wait(.5)
                        local rPets = require(Pets)
                        local ItemName = PetData:GetAttribute("ItemName")
                        local PetName = ReplicatedStorage.PlayerEquips[PlayerName].Pet[ItemName]
                        local PetRef = rPets:GetPetSkillFromPetRef(PetName)
                        local SkillExists = PetSkills[tostring(PetRef)]
                        if SkillExists then
                            SkillExists = "pet skill is supported."
                        else
                            SkillExists = "skill data for " ..tostring(PetRef).. " was not found, skill not supported"
                        end
                        SaveErrorToFile("PET KILLAURA", Result, SkillExists)
                        return
                    end
                    SaveErrorToFile("PET KILLAURA", Result)
                end
            else
                local Success, Result = pcall(function()
                    local UseSkill = Remotes:WaitForChild("PetSkills_UseSkill", math.huge)
                    while PetKillaura and Perf.Alive("pet", Epoch) and not KillSwitch do
                        if CurrentMob then
                            local MobCollider = CurrentMob:FindFirstChild("Collider", true)
                            if MobCollider then
                                UseSkill:FireServer(CurrentMob, MobCollider.Position)
                            end
                        end
                        task.wait(1)
                    end
                end)
                if not Perf.Alive("pet", Epoch) then return end
                if not Success then
                    SaveErrorToFile("PET KILLAURA FALLBACK", Result)
                end
            end
        else
            DisconnectVariable("ConnectCharacter")
            PetKillaura = nil
        end
    end)
    local CheckForRejoin
    local RestartChanged
    Toggles.RestartStuckToggle:OnChanged(function(ChangedValue) -- stuck restart
        local TimeActivated = (RestartChanged or 0) + 1
        RestartChanged = TimeActivated
        CheckForCharacter()
        if TimeActivated ~= RestartChanged then
            return
        end
        if ChangedValue then
            local Success, Result = pcall(function()
                ISV.LoggedDifficulty = GetDifficulty()
                CheckForRejoin = true
                RejoinLastDungeon(false)
                local CombatTimer = 0
                repeat
                    if not CombatCharacterReady() or SV.RestartSelecting or SV.TransitionPending or SV.TransitionUnconfirmed
                        or IsMissionOver() or TempStop or SV.DodgingAttack
                        or not (SV.Autofarm or SV.Killaura or SV.SafeKillaura) then
                        CombatTimer = 0
                    elseif not HoldForRealTime then
                        local Character = PlayerCharacter
                        task.wait(1)
                        if ScriptUnloaded or KillSwitch or TimeActivated ~= RestartChanged or not CheckForRejoin then break end
                        if not CombatCharacterReady() or PlayerCharacter ~= Character then
                            CombatTimer = 0
                            continue
                        end
                        local Healthproperties = Character:FindFirstChild("HealthProperties", true)
                        local OutOfCombat = Healthproperties and Healthproperties:FindFirstChild("OutOfCombat", true)
                        if Healthproperties and OutOfCombat then
                            if OutOfCombat.Value == 0 then
                                CombatTimer += 1
                            else
                                CombatTimer = 0
                            end
                        end
                        if CombatCharacterReady() and PlayerCharacter == Character and CombatTimer >= StuckDelay
                            and not (SV.RestartSelecting or SV.TransitionPending or SV.TransitionUnconfirmed
                                or IsMissionOver() or TempStop or SV.DodgingAttack)
                            and (SV.Autofarm or SV.Killaura or SV.SafeKillaura) then
                            KillSwitch = true
                            task.wait(2)
                            task.spawn(function()
                                RejoinLastDungeon(true)
                            end)
                            break
                        end
                    end
                    task.wait(.1)
                until not CheckForRejoin or TimeActivated ~= RestartChanged or ScriptUnloaded or KillSwitch
            end)
            if not Success then
                SaveErrorToFile("RESTART STUCK", Result)
            end
        else
            CheckForRejoin = nil
        end
    end)
    local DodgeAttacks
    local DodgeChanged
    Toggles.DodgeLethalToggle:OnChanged(function(ChangedValue) -- dodge lethal damage
        local TimeActivated = os.clock()
        DodgeChanged = CheckForCharacter(TimeActivated)
        if TimeActivated ~= DodgeChanged then
            return
        end
        if ChangedValue and Class.Distance == "Melee" then
            DodgeAttacks = true 
            local Success, Result = pcall(function()
                local LingeringMobAttacks = {
                    "FireBase", "FireRings", "PoisonRings", "PoisonMeteorSpecialMedium", "MeteorSpecialSuper"
                }
                local LethalAttacks = {
                    ["DownwardIceFire"] = {AttackLength = 5.9, Delay = 1.5, AttackName = "downward ice"},
                    ["JumpAttack"] = {AttackLength = 2.5, Delay = 2, AttackName = "jump"},
                    ["Howl"] = {AttackLength = 4.2, Delay = 3.5, AttackName = "howl"},
                    ["DarkOrbAttack"] = {AttackLength = 8.2, Delay = 7.5, AttackName = "dark orb"},
                    ["WingFlap"] = {AttackLength = 6, Delay = 1, AttackName = "wing flap"},
                    ["Flyby"] = {AttackLength = 15, Delay = 0, AttackName = "flyby"},
                    ["FlybyX3"] = {AttackLength = 23, Delay = 0, AttackName = "long flyby"},
                    ["EggBomb"] = {AttackLength = 10, Delay = 3, AttackName = "egg bombs"},
                    ["SlamJump"] = {AttackLength = 5, Delay = 1, AttackName = 'slam jump'},
                    ["PrismSlam"] = {AttackLength = 3, Delay = 2, AttackName = "prism slam" }
                }
                while DodgeAttacks and not KillSwitch do
                    if CurrentMob then
                        local MobProperties = CurrentMob:FindFirstChild("MobProperties")
                        if MobProperties then
                            local CurrentAttack = MobProperties and MobProperties:FindFirstChild("CurrentAttack")
                            if (CurrentAttack and CurrentAttack.Value ~= "") then
                                local AttackToDodge = LethalAttacks[CurrentAttack.Value] or false
                                if AttackToDodge then
                                    DodgeCurrentAttack(AttackToDodge.Delay, AttackToDodge.AttackLength-AttackToDodge.Delay, AttackToDodge.AttackName)
                                end
                            end
                        end
                    end
                    for Index, LingeringAttack in LingeringMobAttacks do
                        local CheckAttack = Workspace:FindFirstChild(LingeringAttack)
                        if CheckAttack then
                            if Workspace:FindFirstChild("AnubisRing") or Workspace:FindFirstChild("AnubisRingPurple") then
                                break
                            end
                            local IsVane = Mobs:FindFirstChild("VaneAetherDragon") or Mobs:FindFirstChild("EVENTBOSSVane")
                            local SafeDistance = Vector3.new(PlayerRoot.Position.X+1000, PlayerRoot.Position.Y+1000, PlayerRoot.Position.Z)
                            if IsVane then
                                SafeDistance = Vector3.new(PlayerRoot.Position.X, PlayerRoot.Position.Y+1000, PlayerRoot.Position.Z)
                            end
                            TempStop = true
                            repeat
                                PlayerRoot.CFrame = CFrame.new(SafeDistance)
                                TeleportStandPart()
                                if not CheckAttack.Parent then
                                    break
                                end 
                                task.wait()
                            until not DodgeAttacks or KillSwitch
                            TempStop = false
                        end
                    end
                    task.wait(.1)
                end
            end)
            if not Success then
                SaveErrorToFile("DODGE LETHAL DAMAGE", Result)
            end
        else
            DodgeAttacks = nil
        end
    end)
end
if not IsMainMenu then
    Toggles.AutoPrestigeToggle:OnChanged(function(ChangedValue)
        if ChangedValue then
            if ISV.PlayerLevel >= 160 and ISV.PlayerPrestige < 4 then
                local Successm, Result = pcall(function()
                    KillSwitch = true
                    Library:Notify("Prestiging...", 5)
                    task.wait(5)
                    local PrestigeFile = "JDRS/" ..LocalPlayer.Name.. "_Prestige.txt"
                    if isfile(PrestigeFile) and StringPlaceID == "4310463616" and not IsDungeon then
                        delfile(PrestigeFile)
                        Remotes:WaitForChild("Profile_Prestige"):FireServer()
                        task.wait(1)
                        ReplayDungeonLoop(1, 5)
                    else
                        if not isfile(PrestigeFile) then
                            writefile(PrestigeFile, "haha txt file")
                        end
                        Remotes:WaitForChild("Teleport_TeleportToHub", math.huge):FireServer(13)
                    end
                end)
            end
        end
    end)
end
end -- for unloaded general tab
if not SV.EventTab then -- for unloaded event tab
SetGlobal("event stuff")
if IsDungeon then
    local CollectBuffs
    Toggles.CollectBuffToggle:OnChanged(function(ChangedValue)
        if ChangedValue then
            CollectBuffs = true
            while CollectBuffs and not KillSwitch do
                if SV.SelectedOrbs then
                    for Index, Orb in SV.SelectedOrbs do
                        if not Orb then
                            continue
                        end
                        local FoundOrb = Workspace:FindFirstChild(Orb)
                        if FoundOrb then
                            TeleportToOrb(FoundOrb)
                        end
                        task.wait()
                    end
                end
                task.wait(1)
            end
        else
            CollectBuffs = nil
        end
    end)
end
if not IsMainMenu then
    local ClaimingBattlepass = false
    Toggles.AutoClaimBattlepass:OnChanged(function(ChangedValue)
        if ChangedValue then
            if SV.CanRequire then
                if ClaimingBattlepass then
                    return
                else
                    ClaimingBattlepass = true
                end
                local rBattlepass = require(Battlepass)
                local RedeemedItem = Remotes:WaitForChild("Battlepass_RedeemedItem", math.huge)
                local RedeemItem = Remotes:WaitForChild("Battlepass_RedeemItem", math.huge)
                local HasPremiumTrack = Remotes:WaitForChild("Battlepass_HasPremium", math.huge):InvokeServer()

                local FreeClaimed, PaidClaimed = false
                local LastFree, LastPaid = -1

                if not HasPremiumTrack then
                    PaidClaimed = true
                end

                local function ClaimRank(Rank, Paid)
                    local ClaimStart = time() + 3
                    if not Paid then
                        repeat
                            if time() > ClaimStart then
                                break
                            end
                            RedeemItem:FireServer(Rank)
                            task.wait()
                        until RedeemedItem:InvokeServer(Rank)
                    else
                        repeat
                            if time() > ClaimStart then
                                break
                            end
                            RedeemItem:FireServer(Rank, true)
                            task.wait()
                        until RedeemedItem:InvokeServer(Rank, true)
                    end
                end

                repeat
                    local Tracks = { Remotes:WaitForChild("Battlepass_GetItemRanks", math.huge):InvokeServer() }
                    for Track = 1, #Tracks do
                        local Rank = Tracks[Track]
                        local NextTier = rBattlepass:FindNextItemTier(Tracks[Track])
                        if Track == 1 and not FreeClaimed then
                            if Rank == 0 or Rank ~= LastFree then
                                ClaimRank(NextTier)
                                LastFree = Rank
                            else
                                FreeClaimed = true
                            end
                        end
                        if Track == 2 and not PaidClaimed then
                            if Rank == 0 or Rank ~= LastPaid then
                                ClaimRank(NextTier, true)
                                LastPaid = Rank
                            else
                                PaidClaimed = true
                            end
                        end
                        task.wait()
                    end
                    task.wait()
                until FreeClaimed and PaidClaimed
                ClaimingBattlepass = false
            else
                Library:Notify("Your executor doesn't support this option")
            end
        end
    end)
end
end -- for unloaded event tab

if not SV.ClassesTab then -- for unloaded classes tab
SetGlobal("class tab functions")
if IsDungeon then
    local ClassBuffs
    Toggles.GeneralClassBuffToggle:OnChanged(function(ChangedValue) -- general class buffs
        if ChangedValue then
            ClassBuffs = true
            local AttackBuff = Remotes:WaitForChild("Skillset_DualWielder_AttackBuff", math.huge)
            local AggroDraw = Remotes:WaitForChild("Skillset_Guardian_AggroDraw", math.huge)
            while ClassBuffs and not KillSwitch do
                if IsAliveMobs > 0 then
                    AttackBuff:FireServer()
                    AggroDraw:FireServer()
                end
                task.wait(1)
            end
        else
            ClassBuffs = nil
        end
    end)
    local MolBuff
    Toggles.MoLBarrierToggle:OnChanged(function(ChangedValue) -- mol barrier
        if ChangedValue then
            local Success, Result = pcall(function()
                if SV.PlayerClass == "MageOfLight" then
                    MolBuff = true
                    local Barrier = Remotes:WaitForChild("Skillset_MageOfLight_Barrier")
                    while MolBuff do
                        if KillSwitch then
                            break
                        end
                        local AllPlayers = Players:GetChildren()
                        for _, BarrierAllPlayers in AllPlayers do
                            if BarrierAllPlayers.Name ~= PlayerName then
                                Barrier:FireServer(BarrierAllPlayers)
                            end
                            task.wait()
                        end
                        task.wait(2)
                    end
                end
            end)
            if not Success then
                SaveErrorToFile("MAGE OF LIGHT BARRIER", Result)
            end
        else
            MolBuff = nil
        end
    end)
    local DemonBuff
    Toggles.DemonBloodBindingToggle:OnChanged(function(ChangedValue) -- demon blood binding
        if ChangedValue then
            local Success, Result = pcall(function()
                if SV.PlayerClass == "Demon" then
                    DemonBuff = true
                    local BloodBinding = Remotes:WaitForChild("Skillset_Demon_BloodBinding")
                    while DemonBuff do
                        if KillSwitch then
                            break
                        end
                        if IsAliveMobs > 0 and CurrentMob then
                            BloodBinding:FireServer()
                            task.wait(7)
                        end
                        task.wait(.5)
                    end
                end
            end)
            if not Success then
                SaveErrorToFile("DEMON BLOOD BINDING", Result)
            end
        else
            DemonBuff = nil
        end
    end)
    local StormcallerBuff
    Toggles.StormcallerSuperchargeToggle:OnChanged(function(ChangedValue) -- stormcaller supercharge
        if ChangedValue then
            local Success, Result = pcall(function()
                if SV.PlayerClass == "Stormcaller" then
                    StormcallerBuff = true
                    local Supercharge = Remotes:WaitForChild("Skillset_Stormcaller_Supercharge", math.huge)
                    while StormcallerBuff do
                        if KillSwitch then
                            break
                        end
                        if IsAliveMobs > 0 then
                            Supercharge:FireServer()
                            task.wait(8)
                        end
                        task.wait(.5)
                    end
                end
            end)
            if not Success then
                SaveErrorToFile("STORMCALLER SUPERCHARGE", Result)
            end
        else
            StormcallerBuff = true
        end
    end)
end
end -- for unloaded classes tab

if not SV.DungeonsTab then -- for unloaded dungeons tab
SetGlobal("dungeon tab functions")
if IsDungeon then
    Toggles.CollectChestToggle:OnChanged(function(ChangedValue) -- collect chests
        if ChangedValue then
            if IsMissionOver() then
                CollectChests()
                return
            end
            if IsTower then
                SV.TowerChestDelay = true
                SV.CollectChests = true
                local OpenChest = Remotes:WaitForChild("Chests_OpenChest", math.huge)
                local CheckChest = Remotes:WaitForChild("Chests_CheckCondition", math.huge)
                for _, ChestID in SV.Chests do
                    if CheckChest:InvokeServer(ChestID) then
                        OpenChest:FireServer(ChestID)
                    end
                end
                table.clear(SV.Chests)
                CollectTowerChests()
            else
                SV.CollectDungeonChest = true
            end
        else
            DisconnectVariable("ConnectChests")
            SV.CollectDungeonChest = nil
            SV.TowerChestDelay = nil
        end
    end)
    Toggles.HighestDungeonToggle:OnChanged(function(ChangedValue)
        if ChangedValue then
            task.spawn(EquipNewItemAdded)
            SV.AutoLeveling = true
            if IsMissionOver() then
                ClaimAllQuests()
            end
        else
            DisconnectVariable("ConnectEquipNewItems")
            EquipInProgress = 0
            SV.AutoLeveling = nil
        end
    end)
    Toggles.ReplayMissionToggle:OnChanged(function(ChangedValue) -- replay dropdown
        if ChangedValue then
            SV.ReplayMission = true
            if IsMissionOver() then
                RestartDungeon()
                return
            end
        else
            SV.ReplayMission = nil
        end
    end)
    Toggles.ReplayInfiniteTowerToggle:OnChanged(function(ChangedValue) -- replay inf tower
        if ChangedValue then
            local ReplicateTowerFloor = ReplicatedStorage:FindFirstChild("ReplicateTowerFloor")
            if ReplicateTowerFloor then
                ConnectionTable["ConnectInfTower"] = ReplicateTowerFloor.Changed:Connect(function(NewFloor)
                    if (NewFloor >= RestartAtFloor+1) then
                        Library:Notify("Sending restart")
                        RestartDungeon(true)
                    end
                end)
            end
            if GetLives() == 0 then
                RestartDungeon(true)
            end
        else
            DisconnectVariable("ConnectInfTower")
        end
    end)
end
end -- for unloaded dungeons tab

if not SV.GuildTab then
SetGlobal("guild tab functions")
if IsDungeon then
    local GuildWait
    local PreviousWaitPosition
    local WaitNotification
    local WaitChanged
    Toggles.WaitTimeToggle:OnChanged(function(ChangedValue) -- wait for legit time
        local TimeActivated = os.clock()
        WaitChanged = CheckForCharacter(TimeActivated)
        if TimeActivated ~= WaitChanged then
            return
        end

        if ChangedValue then
            GuildWait = true
            local GuildTimePassed = 0
            local Success, Result = pcall(function()
                local DungeonWaitTime = 120
                for DungeonIndex, Dungeon in SV.DungeonListTable do
                    if Dungeon.DungeonID == ISV.MissionId then
                        DungeonWaitTime = Dungeon.DungeonDelay
                        break
                    end
                end

                local MissionStart = Workspace:FindFirstChild("MissionStart", true)
                local StartGateTime = 0
                if MissionStart then
                    MissionStart:PivotTo(CFrame.new(PlayerRoot.Position))
                    StartGateTime = 5
                end

                HoldForRealTime = true
                task.wait(.2)
                local GuildWaitPosition = Vector3.new(PlayerRoot.Position.X+25000, PlayerRoot.Position.Y+25000, PlayerRoot.Position.Z)
                local PreviousWaitPosition = PlayerRoot.Position
                PlayerRoot.CFrame = CFrame.new(GuildWaitPosition)
                TeleportStandPart()
                local TimeToWait = DungeonWaitTime + (SV.AddedGuildTime or 0) + StartGateTime
                WaitNotification = Library:Notify("Waiting for legit time", TimeToWait)

                local StartTime = time() + TimeToWait
                while GuildWait do
                    if KillSwitch then
                        break
                    end
                    if time() >= StartTime then
                        HoldForRealTime = false
                        PlayerRoot.CFrame = CFrame.new(PreviousWaitPosition)
                        TeleportStandPart()
                        PreviousWaitPosition = nil
                        break
                    end
                    PlayerRoot.CFrame = CFrame.new(GuildWaitPosition)
                    TeleportStandPart()
                    task.wait(.1)
                end
            end)
            if not Success then
                SaveErrorToFile("WAIT FOR LEGIT TIME", Result)
            end
        else
            GuildWait = nil
            HoldForRealTime = false
            if WaitNotification then
                WaitNotification:Destroy()
                WaitNotification = nil
            end
            if PreviousWaitPosition then
                PlayerRoot.CFrame = CFrame.new(PreviousWaitPosition)
            end
            TeleportStandPart()
        end
    end)
    Toggles.DoAllDungeonsToggle:OnChanged(function(ChangedValue) -- do all dungeons
        if ChangedValue then
            Library:Notify("Doing all dungeons", 10)
            SV.DoingGuildDungeon = true
        else
            SV.DoingGuildDungeon = nil
        end
    end)
    local InfNotification
    local InfDelay
    local InfWait
    local InfChanged
    Toggles.DelayInfFloorToggle:OnChanged(function(ChangedValue) -- delay inf tower
        local TimeActivated = os.clock()
        InfChanged = CheckForCharacter(TimeActivated)
        if TimeActivated ~= InfChanged then
            return
        end

        if ChangedValue then
            InfWait = true
            InfDelay = InfDelay or 25
            local Success, Result = pcall(function()
                if ISV.MissionId == 38 then
                    local DungeonScript = ReplicatedStorage:WaitForChild("MissionScripts", math.huge):FindFirstChildWhichIsA("ModuleScript")
                    if DungeonScript then
                        local IsBossFloor
                        ConnectionTable["UpdateMobTracker"] = DungeonScript:WaitForChild("UpdateMobTracker", math.huge).OnClientEvent:Connect(function(KilledMobs, TotalMobs)
                            if TotalMobs < 10 then
                                IsBossFloor = true
                            else
                                IsBossFloor = false
                                return
                            end
                            if KilledMobs == TotalMobs then
                                InfDelay = InfDelay + SV.IncrementInfiniteDelay
                                IsBossFloor = false
                            end
                        end)
                        ConnectionTable["UpdateTowerFloor"] = DungeonScript:WaitForChild("UpdateTowerFloor", math.huge).OnClientEvent:Connect(function(CurrentFloor)
                            HoldForRealTime = true
                            local GuildWaitPosition = Vector3.new(PlayerRoot.Position.X+25000, PlayerRoot.Position.Y+25000, PlayerRoot.Position.Z)
                            local PreviousPosition = PlayerRoot.Position
                            InfNotification = Library:Notify("Delaying floor", InfDelay)

                            local StartTime = time() + InfDelay
                            while InfWait do
                                if KillSwitch then
                                    break
                                end
                                if IsBossFloor or time() >= StartTime then
                                    if InfNotification then
                                        InfNotification:Destroy()
                                        InfNotification = nil
                                    end
                                    HoldForRealTime = false
                                    PlayerRoot.CFrame = CFrame.new(PreviousPosition)
                                    TeleportStandPart()
                                    break
                                end
                                PlayerRoot.CFrame = CFrame.new(GuildWaitPosition)
                                TeleportStandPart()
                                task.wait(.1)
                            end
                            HoldForRealTime = false
                        end)
                    end
                end
            end)
            if not Success then
                SaveErrorToFile("DELAY INF TOWER FLOORS", Result)
            end
        else
            if InfNotification then
                InfNotification:Destroy()
                InfNotification = nil
            end
            InfWait = nil
            DisconnectVariable("UpdateMobTracker")
            DisconnectVariable("UpdateTowerFloor")
        end
    end)
    Toggles.GuildQuestToggle:OnChanged(function(ChangedValue) -- claim guild quests
        if ChangedValue then
            if not SV.CanRequire then
                Library:Notify("Your executor doesn't support claiming guild quests", 3)
                return
            end
            SV.ClaimGuildQuests = true
        else
            SV.ClaimGuildQuests = nil
        end
    end)
end
end -- for unloaded guild tab

if not SV.ShopsTab then -- for unloaded shops tab
SetGlobal("shop tab functions")
if not IsMainMenu then
    local AutoHatch
    Toggles.AutoHatchEggToggle:OnChanged(function(ChangedValue) -- auto hatch eggs
        if ChangedValue then
            AutoHatch = true
            local Success, Result = pcall(function()
                local PetSlot = ReplicatedStorage.PlayerEquips[PlayerName].Pet
                local EquipItem = Remotes:WaitForChild("Inventory_EquipItem", math.huge)
                local Hatch = Remotes:WaitForChild("Pets_Hatch", math.huge)
                local pItems = ProfileInventory.Items
                repeat
                    local TableReference = SV.SelectedEggItem
                    if not TableReference then
                        Library:Notify("No egg is selected", 3)
                        task.wait(3)
                        if not AutoHatch then
                            break
                        end
                        continue
                    end
                    local CurrentPet = PetSlot:FindFirstChildWhichIsA("Folder")
                    if CurrentPet and string.find(CurrentPet.Name, "Egg") then
                        task.wait(.1)
                        continue
                    end
                    task.wait(SV.HatchDelay)
                    if not BuyFromEggShop(TableReference.CurrencyType, TableReference.InternalName, TableReference.CoinPrice, TableReference.VisualName) then
                        Library:Notify("You do not have enough gold", 3)
                        task.wait(3)
                        if not AutoHatch then
                            break
                        end
                        continue
                    else
                        local BoughtEgg = pItems:WaitForChild(TableReference.InternalName, 5)
                        if BoughtEgg then
                            EquipItem:FireServer(BoughtEgg, PetSlot)
                            repeat
                                task.wait()
                            until PetSlot:FindFirstChild(TableReference.InternalName)
                            Hatch:FireServer()
                        end
                    end
                    task.wait()
                until not AutoHatch
            end)
            if not Success then
                SaveErrorToFile("AUTO HATCH", Result)
            end
        else
            AutoHatch = nil
        end
    end)
    local AutoHatchInventory
    Toggles.AutoHatchInventoryEggToggle:OnChanged(function(ChangedValue) -- auto hatch inventory  eggs
        if ChangedValue then
            AutoHatchInventory = true
            local Success, Result = pcall(function()
                local EggTable = {}
                for Index, Egg in SV.EggList do
                    EggTable[Egg] = true
                end
                local PetSlot = ReplicatedStorage.PlayerEquips[PlayerName].Pet
                local EquipItem = Remotes:WaitForChild("Inventory_EquipItem", math.huge)
                local Hatch = Remotes:WaitForChild("Pets_Hatch", math.huge)
                local pItems = ProfileInventory.Items
                repeat
                    local CurrentPet = PetSlot:FindFirstChildWhichIsA("Folder")
                    if CurrentPet and CurrentPet.Parent and EggTable[CurrentPet.Name] then
                        task.wait(.1)
                        continue
                    end
                    local HatchingPet = false
                    for Index, Item in pItems:GetChildren() do
                        if Item and Item.Parent and EggTable[Item.Name] then
                            task.wait(SV.HatchDelay)
                            EquipItem:FireServer(Item, PetSlot)
                            local EquippedEgg = PetSlot:WaitForChild(Item.Name, 5)
                            if EquippedEgg then
                                task.wait(.5)
                                Hatch:FireServer()
                                task.wait(5)
                                HatchingPet = true
                                break
                            end
                        end
                    end
                    if not HatchingPet then
                        task.wait(5)
                    end
                    task.wait()
                until not AutoHatchInventory
            end)
            if not Success then
                SaveErrorToFile("INVENTORY HATCH", Result)
            end
        else
            AutoHatchInventory = nil
        end
    end)
end
end -- for unloaded shops tab
task.wait()

if not SV.MiscellaneousTab then -- for unloaded miscellaneous tab
SetGlobal("misc tab functions")
if IsDungeon then
    SV.PlayerCamera = Camera.CameraSubject
    local CameraChanged
    Toggles.MobCameraToggle:OnChanged(function(ChangedValue) -- mob camera
        local TimeActivated = os.clock()
        CameraChanged = CheckForCharacter(TimeActivated)
        if TimeActivated ~= CameraChanged then
            return
        end

        if ChangedValue then
            task.spawn(function()
                Toggles.NoclipCameraToggle:SetValue(true)
            end)
            IsMobCamera = true
        else
            IsMobCamera = false
            task.wait(.1)
            if SV.PlayerCamera and SV.PlayerCamera.Parent and PlayerRoot == SV.PlayerCamera.Parent then
                workspace.CurrentCamera.CameraSubject = SV.PlayerCamera
            else
                workspace.CurrentCamera.CameraSubject = PlayerRoot:WaitForChild("Part", math.huge)
            end
        end
    end)
end
if not IsMainMenu then
    Toggles.DamageNumbersToggle:OnChanged(function(ChangedValue) -- remove damage numbers
        if SV.CanRequire and EF.Hook and EF.ClearHook and EF.NewClosure and EF.CheckHook then
            local Success, Result = pcall(function()
                local RenderDamageNumber = require(Effects).RenderDamageNumber
                if ChangedValue then
                    CreateHookOnFunction(RenderDamageNumber, true)
                else
                    CreateHookOnFunction(RenderDamageNumber, false)
                end
            end)
            if not Success then
                SaveErrorToFile("REMOVE DAMAGE NUMBERS", Result)
            end
        else
            local Success, Result = pcall(function()
                local DamageNumbers = Remotes:FindFirstChild("Effects_RenderDamageNumber")
                if ChangedValue and DamageNumbers then
                    SV.RemovedDamageNumbers = true
                    DamageNumbers:Destroy()
                    DamageNumbers = nil
                else
                    if SV.RemovedDamageNumbers then
                        Library:Notify("Rejoin to see damage numbers", 5)
                    end
                end
            end)
            if not Success then
                SaveErrorToFile("REMOVE DAMAGE NUMBERS FALLBACK", Result)
            end
        end
    end)
    Toggles.DamageFlashToggle:OnChanged(function(ChangedValue) -- hide damage flash
        if ChangedValue then
            SharedAssets.Combat.HitHighlight.Enabled = false
        else
            SharedAssets.Combat.HitHighlight.Enabled = true
        end
    end)
    Toggles.DeathEffectToggle:OnChanged(function(ChangedValue) -- hide damage flash
        if SV.CanRequire and EF.Hook and EF.ClearHook and EF.NewClosure and EF.CheckHook then
            local Success, Result = pcall(function()
                local DoEffect = require(Effects).DoEffect
                if ChangedValue then
                    local OldFunction
                    OldFunction = EF.Hook(DoEffect, EF.NewClosure(function(a, Effect, ...)
                        if Effect == "DeathEffect" then
                            return
                        else
                            return OldFunction(a, Effect, ...)
                        end
                    end))
                else
                    CreateHookOnFunction(DoEffect, false)
                end
            end)
            if not Success then
                SaveErrorToFile("REMOVE DEATH EFFECTS", Result)
            end
        else
            local Success, Result = pcall(function()
                if ChangedValue then
                    SV.RemovedDeathEffects = true
                    local DeathEffect = Effects.EffectScripts:FindFirstChild("DeathEffect")
                    if DeathEffect then
                        DeathEffect:Destroy()
                        DeathEffect = nil
                    end
                else
                    if SV.RemovedDeathEffects then
                        Library:Notify("Rejoin to see death effects", 5)
                    end
                end
            end)
            if not Success then
                SaveErrorToFile("REMOVE DEATH EFFECTS FALLBACK", Result)
            end
        end
    end)
    Toggles.KnockdownToggle:OnChanged(function(ChangedValue) -- stops player from being knocked down
        if SV.CanRequire and EF.Hook and EF.ClearHook and EF.NewClosure and EF.CheckHook then
            local Success, Result = pcall(function()
                local Knockdown = require(Client.Actions).Knockdown
                if ChangedValue then
                    CreateHookOnFunction(Knockdown, true)
                else
                    CreateHookOnFunction(Knockdown, false)
                end
            end)
            if not Success then
                SaveErrorToFile("DISABLE KNOCKDOWN", Result)
            end
        end
    end)
end
if IsWorld then
    Toggles.WaystoneToggle:OnChanged(function(ChangedValue)
        local Success, Result = pcall(function()
            if ChangedValue then
                SV.WaystonesHidden = true
                ConnectionTable["ConnectWaystones"] = PlayerGui.ChildAdded:Connect(function(AddedChild)
                    if AddedChild.Parent and AddedChild.Name == "WaystoneDiscoveryIcon" then
                        AddedChild.PlayerToHideFrom = LocalPlayer
                    end
                end)
                for Index, Gui in PlayerGui:GetChildren() do
                    if Gui.Name == "WaystoneDiscoveryIcon" then
                        Gui.PlayerToHideFrom = LocalPlayer
                    end
                end
            else
                if SV.WaystonesHidden then
                    DisconnectVariable("ConnectWaystones")
                    for Index, Gui in PlayerGui:GetChildren() do
                        if Gui.Parent and Gui.Name == "WaystoneDiscoveryIcon" then
                            Gui.PlayerToHideFrom = nil
                        end
                    end
                    SV.WaystonesHidden = nil
                end
            end
        end)
        if not Success then
            SaveErrorToFile("HIDE WAYSTONES", Result)
        end
    end)
end
if IsDungeon then
    Toggles.ShowEndTimeToggle:OnChanged(function(ChangedValue) -- display end time
        if ChangedValue then
            SV.ShowTime = true
            if IsMissionOver() then
                Library:Notify("Completed in " ..SV.DungeonCompletionTime)
            end
        else
            SV.ShowTime = nil
        end
    end)
end
if IsDungeon then
    local ProfilerGui
    local ShowAccountInfo
    Toggles.ProfilerToggle:OnChanged(function(ChangedValue) -- show account information
        if ChangedValue then
            ShowAccountInfo = true
            ProfilerGui = Library:AddDraggableLabel("account info")
            ProfilerGui:SetVisible(true)
            local Gold = PlayerProfile:WaitForChild("Currency"):WaitForChild("Gold")
            local Success, Result = pcall(function()
                repeat
                    ProfilerGui:SetText(string.format(
                        "Account: %*\nClass: %*\nGold %*\nCrystals: %*\nGuild: %*",
                        LocalPlayer.Name.. " ("..LocalPlayer.DisplayName..")",
                        ClassSkills[SV.PlayerClass].DisplayName,
                        FormatNumber(Gold.Value),
                        FormatNumber(Remotes.Crystals_GetCrystals:InvokeServer()),
                        GetGuild(LocalPlayer)
                    ))
                    task.wait(5)
                until not ShowAccountInfo
            end)
            if not Success then
                local GuildLog = GetGuild(LocalPlayer)
                if GuildLog ~= "❌" then
                    GuildLog = "Yes"
                else
                    GuildLog = "No"
                end
                SaveErrorToFile("DISPLAY ACCOUNT INFO", Result, string.format(
                    "P: %*, C: %*, G: %*, C: %*, G: %*",
                    string.gsub(LocalPlayer:GetFullName(), PlayerName, "LocalPlayer"),
                    ClassSkills[SV.PlayerClass].DisplayName,
                    FormatNumber(Gold.Value),
                    FormatNumber(Remotes.Crystals_GetCrystals:InvokeServer()),
                    GuildLog
                ))
            end
        else
            if ProfilerGui then
                ProfilerGui:Destroy()
                ProfilerGui = nil
            end
            ShowAccountInfo = nil
        end
    end)
end
local PreventAfk
Toggles.AFKToggle:OnChanged(function(ChangedValue) -- anti afk
    if ChangedValue then
        PreventAfk = true
        while PreventAfk do
            if KillSwitch then
                break
            end
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new(0, 0))
            task.wait(10)
        end
    else
        PreventAfk = nil
    end
end)
if IsMainMenu then
    Toggles.MainMenuPlay:OnChanged(function(ChangedValue)
        if ChangedValue then
            if firesignal then
                local PlayButton = PlayerGui:WaitForChild("MainMenuGui", math.huge):WaitForChild("Main", math.huge):WaitForChild("Play", math.huge):WaitForChild("Play", math.huge)
                if not ChangedValue then
                    return
                end
                while not (KillSwitch or ScriptUnloaded) do
                    firesignal(PlayButton.MouseButton1Click)
                    task.wait(.5)
                end
            else
                Library:Notify("Your executor doesn't support this option")
            end
        end
    end)
end
if IsWorld then
    Toggles.AutoJoinDungeon:OnChanged(function(ChangedValue)
        if ChangedValue and ISV.PlayerLevel == 175 then
            ReplayDungeonLoop(1005, 6)
        end
    end)
end
if not IsMainMenu then
    Toggles.RemoveOtherPlayersToggle:OnChanged(function(ChangedValue) -- remove other players
        if ChangedValue then
            local CharacterFolder = Workspace:FindFirstChild("Characters")
            for _, CheckCharacters in CharacterFolder:GetChildren() do
                if CheckCharacters.Name == PlayerName then continue end

                CheckCharacters:Destroy()
                CheckCharacters = nil
            end
            ConnectionTable["ConnectCharacterFolder"] = CharacterFolder.ChildAdded:Connect(function(AddedCharacter)
                task.wait(0.1)
                if AddedCharacter.Name == PlayerName then return end
                
                AddedCharacter:Destroy()
                AddedCharacter = nil
            end)
        else
            DisconnectVariable("ConnectCharacterFolder")
        end
    end)
    Toggles.MobESPToggle:OnChanged(function(ChangedValue) -- mob esp
        if ChangedValue then
            for _, Mob in Mobs:GetChildren() do
                if Mob then
                    local Highlight = Instance.new("Highlight")
                    Highlight.FillTransparency = 0
                    Highlight.Parent = Mob
                end
            end
            ConnectionTable["ConnectMobFolder"] = Mobs.ChildAdded:Connect(function(NewMob)
                if NewMob then
                    local Highlight = Instance.new("Highlight")
                    Highlight.FillTransparency = 0
                    Highlight.Parent = NewMob
                end
            end)
        else
            DisconnectVariable("ConnectMobFolder")
            for _, MobFolder in Mobs:GetChildren() do
                local MobHighlight = MobFolder and MobFolder:FindFirstChild("Highlight", true)
                if MobHighlight then
                    MobHighlight:Destroy()
                    MobHighlight = nil
                end
            end
        end
    end)
    Toggles.NoclipCameraToggle:OnChanged(function(ChangedValue) -- noclip camera
        if ChangedValue then
            LocalPlayer.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Invisicam
        else
            LocalPlayer.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Zoom
        end
    end)
    local JumpChanged
    Toggles.DisableAutoJumpToggle:OnChanged(function(ChangedValue) -- disable auto jump
        local TimeActivated = os.clock()
        JumpChanged = CheckForCharacter(TimeActivated)
        if TimeActivated ~= JumpChanged then
            return
        end
        if ChangedValue then
            PlayerCharacter.Humanoid.AutoJumpEnabled = false
        end
    end)
    ISV.RenderingScreen = MakeGuiElement("ScreenGui", {
        IgnoreGuiInset = true,
        DisplayOrder = -1,
    })
        MakeGuiElement("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            Size = UDim2.new(1, 0, 2, 0),
            Parent = ISV.RenderingScreen
        })
        MakeGuiElement("TextLabel", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            BackgroundTransparency = 1,
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            Size = UDim2.new(0.5, 0, 0.1, 0),
            TextColor3 = Color3.new(255, 255, 255),
            FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json"),
            Text = "3d rendering disabled",
            TextScaled = true,
            Parent = ISV.RenderingScreen
        })
    Toggles.DisableRenderingToggle:OnChanged(function(ChangedValue) -- disable rendering
        if IsDungeon then
            local Success, Result = pcall(function()
                if ChangedValue then
                    RunService:Set3dRenderingEnabled(false)
                    ISV.RenderingScreen.Parent = EF.HideGui() or CoreGui
                else
                    RunService:Set3dRenderingEnabled(true)
                    ISV.RenderingScreen.Parent = nil
                end
            end)
            if not Success then
                SaveErrorToFile("DISABLE RENDERING", Result)
            end
        end
    end)
    local SetUpFakeModel
    Toggles.PreventMobToggle:OnChanged(function(ChangedValue) -- stop rendering new things
        if SV.CanRequire and EF.Hook and EF.ClearHook and EF.NewClosure and EF.CheckHook then
            local Success, Result = pcall(function()
                local GetModel = require(ModelProvider).GetModel
                if ChangedValue then
                    local Shockball = SharedAssets.Effects.Models.Shockball
                    if not SetUpFakeModel then
                        if not Shockball:FindFirstChild("HumanoidRootPart") then
                            Shockball.Part.Color = Color3.fromRGB(255, 0, 0)
                            Shockball.Part.Material = "Neon"
                            Shockball.Part.Transparency = 0.7
                            Shockball.Part.Name = "HumanoidRootPart"
                        end
                        SetUpFakeModel = true
                    end

                    local ModelHook
                    ModelHook = EF.Hook(GetModel, EF.NewClosure(function(self, model)
                        if not string.find(model, "Pet") then
                            return Shockball:Clone()
                        else
                            return ModelHook(self, model)
                        end
                    end))
                else
                    CreateHookOnFunction(GetModel, false)
                end
            end)
            if not Success then
                SaveErrorToFile("PREVENT MODELS FROM LOADING", Result)
            end
        else
            local Success, Result = pcall(function()
                local GetModel = Remotes:FindFirstChild("ModelProvider_GetModel")
                if ChangedValue and GetModel then
                    SV.RemovedModels = true
                    GetModel:Destroy()
                    GetModel = nil
                else
                    if SV.RemovedModels then
                        Library:Notify("Rejoin to see assets", 5)
                    end
                end
            end)
            if not Success then
                SaveErrorToFile("PREVENT MODELS FROM LOADING FALLBACK", Result)
            end
        end
    end)
    Toggles.PreventEffectsToggle:OnChanged(function(ChangedValue)
        if SV.CanRequire and EF.Hook and EF.ClearHook and EF.NewClosure and EF.CheckHook then
            local Success, Result = pcall(function()
                local rEffects = require(Effects)
                if ChangedValue then
                    CreateHookOnFunction(rEffects.MakeProjectile, true)
                    CreateHookOnFunction(rEffects.DoEffect, true)
                    CreateHookOnFunction(rEffects.PlayAt, true)
                    CreateHookOnFunction(rEffects.EmitAt, true)
                else
                    CreateHookOnFunction(rEffects.MakeProjectile, false)
                    CreateHookOnFunction(rEffects.DoEffect, false)
                    CreateHookOnFunction(rEffects.PlayAt, false)
                    CreateHookOnFunction(rEffects.EmitAt, false)
                end
            end)
            if not Success then
                SaveErrorToFile("PREVENT NEW EFFECTS", Result)
            end
        else
            Library:Notify("Your executor doesn't support this option", 5)
        end
    end)
end
end -- for unloaded miscellaneous tab

if not SV.DiscordTab then
SetGlobal("discord ping type")
if IsDungeon then
    Toggles.ClassPingToggle:OnChanged(function(ChangedValue)
        if ChangedValue then
            local Success, Result = pcall(function()
                local MasteryClassTable = {
                    ["IcefireMage"] = { MasteryRequirement = 400, MasteryDisplayName = "Stormcaller" },
                    ["MageOfLight"] = { MasteryRequirement = 350, MasteryDisplayName = "Mage of Shadows" },
                    ["Archer"] = { MasteryRequirement = 200, MasteryDisplayName = "Hunter" },
                    ["Dragoon"] = { MasteryRequirement = 10000, MasteryDisplayName = "Leviathan" },
                    ["Guardian"] = { MasteryRequirement = 7500, MasteryDisplayName = "Starbreaker" },
                    ["Demon"] = { MasteryRequirement = 150, MasteryDisplayName = "Necromancer" }
                }
                local Masteries = PlayerProfile:FindFirstChild("Masteries")
                if Masteries then
                    local CurrentClass = Masteries:FindFirstChild(SV.PlayerClass)
                    local MasteryClass = MasteryClassTable[SV.PlayerClass]
                    if (CurrentClass and MasteryClass and CurrentClass.Value >= MasteryClass.MasteryRequirement) then
                        PingOnceUnlocked(MasteryClass.MasteryDisplayName)
                        TempStop = true
                        SV.Killaura = nil
                    end
                end
            end)
            if not Success then
                SaveErrorToFile("MASTERY CLASS UNLOCK", Result)
            end
        end
    end)
end
end -- for unloaded discord tab

if not SV.ConfigurationTab then -- for unloaded config tab
Toggles.AutoScriptToggle:OnChanged(function(ChangedValue) -- inject script
    local FileName = "JDRS/AutoExecute"
    if ChangedValue then
        if not isfile(FileName) then
            writefile(FileName, "")
        end
        if not SV.AlreadyQueued then
            if EF.Queue then
                EF.Queue([[loadstring(game:HttpGet("https://raw.githubusercontent.com/k27432179/WorldZero-Fix/wzf-test/t"))()]])
                SV.AlreadyQueued = true
            end
        end
    else
        EF.ClearQueue()
        SV.AlreadyQueued = false
    end
end)
end -- for unloaded config tab

SetGlobal("getting mission id")
if IsDungeon then
    MissionObjects = Workspace:WaitForChild("MissionObjects", math.huge)
    ISV.MissionId = WaitForAttribute(Workspace, "MissionId")
end 

SetGlobal("nightmare dungeon check")
do
    if IsDungeon and (ISV.MissionId > 1004 and ISV.MissionId < 1008 ) then
        SV.IsNightmareDungeon = true
    end
end

SetGlobal("get attack data")
if IsDungeon and not KillSwitch then
    local Success, Result = pcall(function()
        ClassSkills = SaveScriptToFiles("https://raw.githubusercontent.com/k27432179/WorldZero-Fix/main/c", "C", 5.5)
        PetSkills = SaveScriptToFiles("https://raw.githubusercontent.com/k27432179/WorldZero-Fix/main/p", "P", 4.6)
        if ClassSkills and PetSkills then
            Class = GetPlayerClass()
            if Class ~= nil then
                local ClassRange = Class.Distance
                if ClassRange == "Ranged" then
                    Xdistance = 20
                    Ydistance = 50
                elseif ClassRange == "Melee" then
                    Xdistance = 13
                    Ydistance = 8
                end
            end
        else
            warn(string.format(
                "JDRS: Unable to get skill data. Check variables below\nClass data: %*\nPet data: %*",
                ClassSkills and "Yes" or "No", PetSkills and "Yes" or "No"
            ))
        end
    end)
    if not Success then
        SaveErrorToFile("ATTACK DATA", Result, SV.PlayerClass)
    end
end

SetGlobal("require() check")
if not IsMainMenu then
    local Success, Result = pcall(function()
        require(LocalPlayer:WaitForChild("PlayerScripts", math.huge):WaitForChild("PlayerModule", math.huge))
    end)
    if not Success then
        SV.CanRequire = nil
        print("JDRS: executor doesn't support require(). Applying fixes.")
    else
        SV.CanRequire = true
    end
end

SetGlobal("removing purchase prompt")
task.spawn(function()
    pcall(function()
        if IsDungeon and CoreGui and CoreGui:FindFirstChild("PurchasePromptApp") then
            CoreGui:FindFirstChild("PurchasePromptApp"):Destroy()
        end
    end)
end)

SetGlobal("dungeon specific checks")
if IsDungeon then
    task.spawn(function()
        CheckForCharacter()
        task.spawn(function()
            local Success, Result = pcall(function()
                local SaveRemote = {
                    ["Mob_EVENTBOSSCupidZeus_ButtonSmash"] = true,
                    ["Mob_EVENTBOSSEasterBunny_ChallengeFloorPattern"] = true,
                    ["Mob_EVENTBOSSEasterBunny_RequestGiantEggChallengeFloorIntro"] = true,
                    ["Mob_EVENTBOSSEasterBunny_DoGiantEgg"] = true,
                    ["Mob_EVENTBOSSUndeadVane_ResurrectShake"] = true,
                    ["Mob_FallenKingMinion_OnCureFountain"] = true
                }
                for Index, Descednant in Remotes:GetChildren() do
                    if Descednant:IsA("RemoteEvent") and string.find(Descednant.Name, "Mob_") then
                        if SaveRemote[Descednant.Name] then
                            continue
                        end
                        local CloneRemote = Descednant:Clone()
                        CloneRemote.Parent = Descednant.Parent
                        Descednant:Destroy()
                        Descednant = nil
                    end
                end
            end)
            if not Success then
                SaveErrorToFile("CLIENT SIDE DAMAGE", Result)
            end
        end)
        task.spawn(function()
            if ISV.MissionId == 49 then
                local Success, Result = pcall(function()
                    if SV.CanRequire and debug and getupvalue then
                        local ChestScript = debug.getupvalue(require(Chests).Start, 12)
                        local OpenChest = Remotes:WaitForChild("Chests_OpenChest", math.huge)
                        repeat
                            for ChestKey, Useless in ChestScript do
                                OpenChest:FireServer(ChestKey)
                            end
                            task.wait(.1)
                        until KillSwitch
                    else
                        local ChestNames = {
                            "RaidChestBlue", "RaidChestGold", "RaidChestSilver"
                        }
                        repeat
                            for Index, ChestName in ChestNames do
                                local Chest = Workspace:FindFirstChild(ChestName)
                                if Chest and Chest.Parent then
                                    Chest:PivotTo(CFrame.new(PlayerRoot.Position))
                                end
                                task.wait()
                            end
                            task.wait(.1)
                        until KillSwitch
                    end
                end)
                if not Success then
                    SaveErrorToFile("STARTER DUNGEON CHESTS", Result)
                end
            end
        end)
        task.spawn(function()
            if ISV.MissionId == 54 then
                local IntroDone = Remotes:WaitForChild("Tutorial_IntroDone", math.huge)
                repeat
                    IntroDone:FireServer()
                    task.wait()
                until KillSwitch
            end
            if ISV.MissionId == 53 then
                task.spawn(function()
                    local ObbyEnd = MissionObjects:WaitForChild("Room2", math.huge):WaitForChild("ObbyEnd", math.huge):WaitForChild("VFX", math.huge).Position
                    local Teleporting
                    local ObjectiveMessage = ReplicatedStorage:WaitForChild("ObjectiveMessage", math.huge)
                    local MaxJudgementThreshold = 40
                    if not SV.IsRanged then
                        MaxJudgementThreshold = 60
                    end
                    ConnectionTable["ConnectObjectiveMessage"] = ObjectiveMessage.Changed:Connect(function(NewString)
                        if Teleporting then
                            return
                        end
                        if not string.find(NewString, "together") then
                            return
                        end
                        Teleporting = true
                        task.wait(0.5)
                        local Sword = MissionObjects:WaitForChild("Room1", math.huge):WaitForChild("Sword", math.huge):WaitForChild("Blade", math.huge).Position
                        if Sword then
                            local TeleportTimer = time() + 1
                            repeat
                                PlayerRoot.CFrame = CFrame.new(Sword)
                                task.wait()
                            until time() > TeleportTimer or not SV.Autofarm
                        end
                        local TweenPlaying
                        repeat
                            local TetherPartner = LocalPlayer:GetAttribute("TetherPartner")
                            local Judgement = PlayerCharacter:GetAttribute("Judgment")
                            if Judgement and tonumber(Judgement) >= MaxJudgementThreshold and TetherPartner then
                                local Partner = Workspace:WaitForChild("Characters", math.huge):FindFirstChild(TetherPartner)
                                if Partner then
                                    local PartnerHealth = Partner:WaitForChild("HealthProperties", math.huge):WaitForChild("Health", math.huge)
                                    if PartnerHealth and PartnerHealth.Value > 0 then
                                        local PartnerCollider = Partner:WaitForChild("Collider", math.huge)
                                        TempStop = true
                                        if TweenPlaying then
                                            TweenPlaying:Cancel()
                                        end
                                        repeat
                                            if SV.Autofarm then
                                                PlayerRoot.CFrame = CFrame.new(PartnerCollider.Position + Vector3.new(0, 2, 0))
                                                TeleportStandPart()
                                            end
                                            task.wait()
                                        until (KillSwitch or not string.find(tostring(ObjectiveMessage.Value), "together") or not Partner.Parent)
                                        TempStop = false
                                    end
                                end
                            else
                                if SV.Autofarm then
                                    local EndPos = { CFrame = CFrame.new(ObbyEnd.X, ObbyEnd.Y+6, ObbyEnd.Z)}
                                    local Distance = (PlayerRoot.Position - ObbyEnd).Magnitude / 100
                                    local tweenInfo = TweenInfo.new(Distance, Enum.EasingStyle.Linear)
                                    local tween = TweenService:Create(PlayerRoot, tweenInfo, EndPos)
                                    PlayerRoot.Velocity = Vector3.new()
                                    TeleportStandPart()
                                    TweenPlaying = tween:Play()
                                end
                            end
                            task.wait()
                        until (KillSwitch or not string.find(tostring(ObjectiveMessage.Value), "together"))
                        DisconnectVariable("ConnectObjectiveMessage")
                    end)
                end)
            
                task.spawn(function()
                    local HeavenGuardianGold = Mobs:WaitForChild("HeavenGuardianGold", math.huge)
                    local GoldHealthProperties = HeavenGuardianGold:WaitForChild("HealthProperties", math.huge)
                    local GoldMaxHealth = GoldHealthProperties:WaitForChild("MaxHealth", math.huge).Value
                    local GoldPercentage = 100
                
                    local HeavenGuardianBlue = Mobs:WaitForChild("HeavenGuardianBlue", math.huge)
                    local BlueHealthProperties = HeavenGuardianBlue:WaitForChild("HealthProperties", math.huge)
                    local BlueMaxHealth = BlueHealthProperties:WaitForChild("MaxHealth", math.huge).Value
                    local BluePercentage = 100
                
                    ConnectionTable["GoldGuardian"] = GoldHealthProperties:WaitForChild("Health", math.huge).Changed:Connect(function(CurrentHealth)
                        local CurrentPercentage = GetPercentage(GoldMaxHealth, CurrentHealth)
                        if CurrentPercentage then
                            if SV.Autofarm then
                                if (CurrentPercentage + 3) <= BluePercentage then
                                    GoldPercentage = CurrentPercentage
                                    local BlueIndex = ISV.MobTable[HeavenGuardianBlue]
                                    local GoldIndex = ISV.MobTable[HeavenGuardianGold]
                                    if BlueIndex and GoldIndex then
                                        GoldIndex.Priority = nil
                                        BlueIndex.Priority = true
                                    end
                                end
                            end
                            if CurrentPercentage == 0 then
                                DisconnectVariable("GoldGuardian")
                            end
                        end
                    end)
                
                    ConnectionTable["BlueGuardian"] = BlueHealthProperties:WaitForChild("Health", math.huge).Changed:Connect(function(CurrentHealth)
                        local CurrentPercentage = GetPercentage(BlueMaxHealth, CurrentHealth)
                        if CurrentPercentage then
                            if SV.Autofarm then
                                if (CurrentPercentage + 3) <= GoldPercentage then
                                    BluePercentage = CurrentPercentage
                                    local BlueIndex = ISV.MobTable[HeavenGuardianBlue]
                                    local GoldIndex = ISV.MobTable[HeavenGuardianGold]
                                    if BlueIndex and GoldIndex then
                                        BlueIndex.Priority = nil
                                        GoldIndex.Priority = true
                                    end
                                end
                            end
                            if CurrentPercentage == 0 then
                                DisconnectVariable("BlueGuardian")
                            end
                        end
                    end)
                    if not SV.IsRanged then
                        repeat
                            MobRotationSpeed = 25.5
                            task.wait(0.1)
                        until not (HeavenGuardianGold.Parent and HeavenGuardianBlue.Parent) or KillSwitch
                        MobRotationSpeed = Options.MobRotationSpeedSliderNew.Value or 20
                    end
                end)
                
                task.spawn(function()
                    local BossRoomTrigger = MissionObjects:WaitForChild("BossRoom", math.huge):WaitForChild("BossDoorTrigger", math.huge)
                    local TouchTransmitter = BossRoomTrigger:WaitForChild("TouchInterest", math.huge)
                    BossRoomTrigger = BossRoomTrigger.Position
                    TempStop = true
                    repeat
                        if SV.Autofarm then
                            local EndPos = { CFrame = CFrame.new(BossRoomTrigger.X, BossRoomTrigger.Y, BossRoomTrigger.Z)}
                            local Distance = (PlayerRoot.Position - BossRoomTrigger).Magnitude / 100
                            local tweenInfo = TweenInfo.new(Distance, Enum.EasingStyle.Linear)
                            local tween = TweenService:Create(PlayerRoot, tweenInfo, EndPos)
                            PlayerRoot.Velocity = Vector3.new()
                            TeleportStandPart()
                            tween:Play()
                        end
                        task.wait()
                    until not TouchTransmitter.Parent or KillSwitch
                    TempStop = false
                end)
                
                task.spawn(function()
                    if SV.CanRequire and EF.Hook and EF.NewClosure then
                        local Success, Result = pcall(function()
                            SV.HeavenDisplayHook = require(Client.Gui):Get("LootReceived")._DisplayItem
                            CreateHookOnFunction(SV.HeavenDisplayHook, true)
                        end)
                        if not Success then
                            print("JDRS: executor can't disable loot screen")
                        end
                    end
                    local SpawnChest = Remotes:WaitForChild("Chests_SpawnChest", math.huge)
                    local OpenChest = Remotes:WaitForChild("Chests_OpenChest", math.huge)
                    ConnectionTable["ConnectChests"] = SpawnChest.OnClientEvent:Connect(function(a, b, GUID, d, e)
                        OpenChest:FireServer(GUID)
                        CreateHookOnFunction(SV.HeavenDisplayHook, false)
                    end)
                end)

                local BOSSSeraphiel = Mobs:WaitForChild("BOSSSeraphiel", math.huge)
                if BOSSSeraphiel then
                    local ArenaCenter = MissionObjects:WaitForChild("BossRoom", math.huge):WaitForChild("ArenaCenter", math.huge)
                    local RotationAroundCenter = math.random(0, 360)
                    local ArenaRotationSpeed = 30
                    task.spawn(function()
                        repeat
                            local DistanceFromCenter = 75 + (ArenaCenter.Size.X/2)
                            RotationAroundCenter = RotationAroundCenter + (ArenaRotationSpeed / DistanceFromCenter)
                            if not CurrentMob and SV.Autofarm then
                                PlayerRoot.CFrame = CFrame.new(ArenaCenter.Position) * CFrame.Angles(0, math.rad(RotationAroundCenter), 0) * CFrame.new(DistanceFromCenter, 25, 0)
                                PlayerRoot.CFrame = CFrame.new(PlayerRoot.Position, Vector3.new(ArenaCenter.Position.X, PlayerRoot.Position.Y, ArenaCenter.Position.Z))
                                TeleportStandPart()
                            end
                            task.wait()
                        until KillSwitch
                    end)
                    task.spawn(function()
                        repeat
                            local BossRef = Mobs:WaitForChild("BOSSSeraphiel", math.huge)
                            local function GetBossAttack()
                                return Mobs:WaitForChild("BOSSSeraphiel", math.huge):WaitForChild("MobProperties", math.huge):WaitForChild("CurrentAttack", math.huge)
                            end
                            ConnectionTable["HEAVENRAIDBOSS"] = GetBossAttack().Changed:Connect(function(CurrentAttack)
                                if CurrentAttack and SV.Autofarm then
                                    if CurrentAttack == "JudgmentWalls" then
                                        DodgeCurrentAttack(1.5, 11.5, "judgment walls")
                                    elseif CurrentAttack == "BurdenOfLight" then
                                        local CharacterCheck = Workspace:WaitForChild("Characters", math.huge):GetChildren()
                                        if #CharacterCheck > 1 then
                                            CanTarget = false
                                            TeleportMob = nil
                                            task.wait(5)
                                            CanTarget = true
                                        end
                                    end
                                end
                            end)
                            repeat
                                task.wait(0.5)
                            until not BossRef.Parent or KillSwitch
                            DisconnectVariable("HEAVENRAIDBOSS")
                            GetBossAttack = nil
                        until KillSwitch
                    end)
                end
            end
            if ISV.MissionId == 22 then
                ConnectionTable["CuringWell"] = Remotes:WaitForChild("Mob_FallenKingMinion_OnCureFountain").OnClientEvent:Connect(function()
                    local Status = PlayerCharacter:WaitForChild("Status", math.huge)
                    local DeathMark = Status:WaitForChild("DeathMark", math.huge)
                    local Fountain = Workspace:WaitForChild("CureFountainFallenKing", math.huge)
                    local FountainTeleport = Fountain:WaitForChild("ArcanePanel", math.huge)
                    TempStop = true
                    repeat
                        TeleportStandPart()
                        PlayerRoot:PivotTo(CFrame.new(FountainTeleport.Position))
                        task.wait()
                    until not DeathMark.Parent
                    Fountain:Destroy()
                    Fountain = nil
                    TempStop = false
                end)
                ConnectionTable["FALLEN_KING_ATTACKS"] = Mobs:WaitForChild("BOSSFallenKing", math.huge):WaitForChild("MobProperties", math.huge):WaitForChild("CurrentAttack", math.huge).Changed:Connect(function(CurrentAttack)
                    if not SV.Autofarm or (SV.IsRanged and not SV.SafeKillaura) then
                        return
                    end
                    if CurrentAttack == "DarkOrbAttack" then
                        DodgeCurrentAttack(6, 1, "dark orb")
                    elseif CurrentAttack == "FistSlam" then
                        DodgeCurrentAttack(0, 1, "stomp")
                    end
                end)
                repeat
                    local FallenPrince = Mobs:WaitForChild("BOSSFallenPrince", math.huge):WaitForChild("MobProperties", math.huge):WaitForChild("CurrentAttack", math.huge)
                    ConnectionTable["FALLEN_PRINCE"] = FallenPrince.Changed:Connect(function(CurrentAttack)
                        if not SV.Autofarm or (SV.IsRanged and not SV.SafeKillaura) then
                            return
                        end
                        if CurrentAttack == "Spikes" then
                            DodgeCurrentAttack(3, 1, "spikes")
                        elseif CurrentAttack == "Swing1" then
                            DodgeCurrentAttack(0.25, 1, "slash")
                        end
                    end)
                    repeat task.wait() until not FallenPrince.Parent or KillSwitch
                    DisconnectVariable("FALLEN_PRINCE")
                    FallenPrince = nil
                    task.wait()
                until KillSwitch
            end
        end)
    end)
end

SetGlobal("removing mission remotes")
do
    if IsDungeon then
        local BadRemotes = {
            ["FireDart"] = true,
            ["HammerHit"] = true,
            ["CreateBolder"] = true,
            ["ToxinTrigger"] = true,
            ["RollingBoulder"] = true
        }
        local MissionScript = ReplicatedStorage:WaitForChild("MissionScripts", math.huge):FindFirstChildWhichIsA("ModuleScript")
        if MissionScript then
            for Index, Remote in MissionScript:GetChildren() do
                if Remote and Remote.Parent then
                    if BadRemotes[Remote.Name] then
                        Remote:Destroy()
                        Remote = nil
                    end
                end
            end
        end
        MissionObjects = Workspace:WaitForChild("MissionObjects", math.huge)
        ISV.MissionId = WaitForAttribute(Workspace, "MissionId")
    end
end

SetGlobal("looking for teleport parts")
if IsDungeon then
    local Success, Result = pcall(function()
        local FindDungeonParts = {
            ["49"] = { -- tutorial
                { "CutsceneTrigger" }, { "MinibossTrigger" }, { "Cabbages", "1", "Main" }, { "Cabbages", "2", "Main" }, { "CaveTrigger" }, { "ChadCaveTrigger" }
            },
            ["54"] = { -- chad tutorial
                { "Markers", "ChadIntroTrigger" }, { "Markers", "Area2StartTrigger" }, { "Markers", "Area2_Blockage" }, { "Markers", "Area3StartTrigger" }, { "BossTrigger" }
            },
            ["47"] = { -- returning player dungeon
                { "BossTrigger" }
            },
            ["1"] = { -- Crabby crusade
                { "CutsceneTrigger" }, { "Cabbages", "1", "Main" }, { "Cabbages", "2", "Main" }, { "CaveTrigger" }
            },
            ["3"] = {}, -- Scarecrown defense 
            ["2"] = { -- Dire problem
                { "TownTalkPart" }, { "BridgeTrigger" }, { "CaveTrigger" }, { "BoulderTrigger" }, { "BoulderStopTrigger" }, { "BossIntroTrigger" }
            },
            ["4"] = { -- Kingslayer
                { "CannonTrigger" }, { "CastleTrigger" },
                NoParent = {
                    { "Cage2Marker", "Collider" }, { "Cage1Marker", "Collider" }
                }
            },
            ["6"] = {}, -- Gravetower dungeon
            ["11"] = { -- Temple of ruin
                { "Room1Trigger" }, { "Room2Trigger" }, { "Room3Trigger" }, { "Room4Trigger" }, { "WallsTrigger" }, { "WallsFinalTrigger" },
                NoParent = {
                    { "TreasureMarker", "Collider" }
                }
            },
            ["12"] = { -- Mama trauma
                { "PreBridgeTrigger" }, { "BridgeTrigger" }, { "CaveSpawnTrigger" }, { "CliffsideEndTrigger"},
                DeleteParts = {
                    { "CheckpointTriggers" }, { "MissionObjects", "TempleTrigger" }
                }
            },
            ["13"] = { -- Volcanos shadow
                { "VineRoomTrigger" }, { "CheckpointTrigger" }, { "CannonTrigger" }, { "ObbyTrigger" }, { "BossTrigger" },
                DeleteParts = {
                    { "MissionObjects", "LavaTriggers" }, { "MissionObjects", "LavaTrigger" }
                }
            },
            ["7"] = {}, -- Volcano dungeon
            ["14"] = { -- Mountain pass
                { "CaveTrigger" }, { "DropTrigger" }
            },
            ["15"] = { -- Winter cavern
                { "BossTrigger" }
            },
            ["16"] = { -- Winter dungeon
                { "CastleGateTrigger" }, { "BossTrigger" }
            },
            ["20"] = { -- Scrap canyon
                { "SceneTrigger" }
            },
            ["19"] = {}, -- Deserted burrowmine
            ["18"] = { -- Pyramid dungeon
                { "OutsideBossTrigger" }, { "BossTrigger" },
                DeleteParts = {
                    { "MissionObjects", "WaterKillPart" }, { "MissionObjects", "BossKillPart" }
                }
            },
            ["24"] = {}, -- Konoh heartlands
            ["35"] = {}, -- Konoh inferno
            ["21"] = { -- Prison tower
                { "WaveStarter", Regenerates = true }, { "WaveExit"}, { "BossDoorTrigger" }
            },
            ["25"] = { -- Rough waters
                { "Area1Trigger" }, 
                CheckpointGates = {
                    { "Checkpoint4", "VentButton", "FinishRing" }
                }
            },
            ['36'] = { -- Treasure hunt
                CheckpointGates = {
                    { "Checkpoint1", "FinishRing" }, { "Checkpoint3", "TriggerObjective" }, { "Checkpoint3", "ObbyTrigger" }, { "Checkpoint7", "ObbyTrigger" }
                },
                { "StartWaveDefense" },
                DeleteParts = {
                    { "MissionObjects", "DamageCeiling" }
                }
            },
            ["23"] = { -- Atlantis tower
                { "WaveStarter", Regenerates = true }, { "WaveExit"}, { "BossDoorTrigger" }
            },
            ["26"] = { -- The underworld
                { "Trigger1" }, { "Trigger2" }, { "Trigger3" }
            },
            ["37"] = { -- The labyrinth
                CheckpointGates = {
                    { "Checkpoint5", "ObbyTrigger" }
                },
                { "BossCutsceneTrigger" }
            },
            ["27"] = { -- Mexuvian tower
                { "WaveStarter", Regenerates = true }, { "WaveExit"}, { "BossDoorTrigger" }
            },
            ["30"] = { --Rescue in the ruin
                { "FloorTrigger" }, { "Trigger1" }, { "BottomElevatorTrigger" }, { "MiddleElevatorTrigger" }, { "TopElevatorTrigger" }
            },
            ["31"] = {}, -- Ruin rush
            ["29"] = { -- Oasis tower
                { "WaveStarter", Regenerates = true }, { "WaveExit"}, { "BossDoorTrigger" }
            },
            ["32"] = { -- Treetop trouble
                { "ObbyTrigger5" }
            },
            ["33"] = {
                CheckpointGates = { -- Aether fortress
                    { "Checkpoint3", "ObbyTrigger" }, { "Checkpoint7", "ObbyTrigger" }
                }
            },
            ["34"] = { -- Aether tower
                { "WaveStarter", Regenerates = true }, { "WaveExit"}, { "BossDoorTrigger" }
            },
            ["41"] = { -- Crystal chaos
                CheckpointGates = {
                    { "Checkpoint3", "ObbyTrigger" }, { "Checkpoint5", "EnterArena" }, { "Checkpoint6", "ObbyTrigger" }
                },
                { "BossTrigger" }
            },
            ["42"] = { -- Crystal academy
                CheckpointGates = {
                    { "Checkpoint3", "ObbyTrigger" }, { "Checkpoint6", "ObbyTrigger" }
                },
                { "BossTrigger" }
            },
            ["43"] = { -- Arcane tower
                { "WaveStarter", Regenerates = true }, { "WaveExit"}, { "BossDoorTrigger" }
            },
            ["39"] = { -- Celestial tower
                NoParent = {
                    { "LobbyTeleport", "Interaction" }, { "Boss_Gate", "Interactions", "Bounds" }
                }
            },
            ["38"] = { -- Infinite tower
                NoParent = {
                    { "LobbyTeleport", "Interaction" }, { "Boss_Gate", "Interactions", "Bounds" }
                }
            },
            ["53"] = {}, -- heavenly raid
            ["45"] = {}, -- kraken raid
            ["56"] = {
                { "BackTeleporter" }, { "Teleporter", AutoTouch = true }, { "BossDoorTrigger" }, { "MinibossExit" }
            },
            ["22"] = {} -- fallen throne
        }

        local CurrentDungeon = FindDungeonParts[tostring(ISV.CurrentDungeonID)]
        if not CurrentDungeon then
            SaveErrorToFile("DUNGEON UNSUPPORTED", "an update to the script is required for this dungeon to work", "if this is a new dungeon please wait until I can update the script")
            return
        end

        for Index, Parts in CurrentDungeon do
            if type(Index) == "number" then
                table.insert(SV.DungeonPartList, Parts)
            else
                SV.DungeonPartList[Index] = {}
                for _, Part in Parts do
                    table.insert(SV.DungeonPartList[Index], Part)
                    task.wait()
                end
            end
            task.wait()
        end

        FindDungeonParts = nil

        for Index, Parts in SV.DungeonPartList do
            if type(Index) == "number" then
                task.spawn(function()
                    FindPart(nil, Parts)
                end)
            else
                for TableRef, Part in Parts do
                    task.spawn(function()
                        FindPart(tostring(Index), Part)
                    end)
                    task.wait()
                end
            end
            task.wait()
        end
        SV.DungeonPartList = nil
        if IsTower then
            task.spawn(function()
                if ISV.MissionId ~= 56 then
                    local WaveExitPart = nil
                    ConnectionTable["ConnectTower"] = Remotes:WaitForChild("Towers_UpdateChests", math.huge).OnClientEvent:Connect(function(RandomTable, KilledMobs, TotalMobs, Progress, RandomBoolean)
                        if WaveExitPart then
                            if KilledMobs == TotalMobs then
                                TeleportParts[WaveExitPart].DontTeleport = nil
                            else
                                TeleportParts[WaveExitPart].DontTeleport = true
                            end
                        end
                    end)
                    ConnectionTable["ConnectTowerPrint"] = Remotes:WaitForChild("Towers_Print").OnClientEvent:Connect(function(Text)
                        if WaveExitPart then
                            if string.find(Text, "false") then
                                DisconnectVariable("ConnectTower")
                                TeleportParts[WaveExitPart].DontTeleport = true
                                DisconnectVariable("ConnectTowerPrint")
                            end
                        end
                    end)
                    WaveExitPart = MissionObjects:WaitForChild("WaveExit", math.huge)
                end
            end)
        end
    end)
    if not Success then
        SaveErrorToFile("FIND TELEPORT PARTS", Result)
    end
end

--SetGlobal("waiting for character")
--if not IsMainMenu then
--    local IsDead = false
--    local AlreadyCheckingLives = false
--    repeat
--        if IsDungeon then
--            task.spawn(function()
--                if AlreadyCheckingLives then
--                    return
--                end
--                AlreadyCheckingLives = true
--                if GetLives() == 0 then
--                    IsDead = true
--                    LoadingStep(true)
--                    RejoinLastDungeon(false)
--                    RestartDungeon(true)
--                    return
--                end
--                AlreadyCheckingLives = false
--            end)
--        elseif IsWorld then
--            RejoinLastDungeon(false)
--        end
--        task.wait(0.2)
--    until LocalPlayer.Character
--    if IsDead then
--        return
--    end
--    PlayerCharacter = LocalPlayer.Character
--    PlayerCollider = PlayerCharacter:WaitForChild("Collider")
--    PlayerRoot = PlayerCharacter:WaitForChild("HumanoidRootPart")
--    print("JDRS: local player character found")
--end

SetGlobal("prevent falling part")
if IsDungeon then
    task.spawn(function()
        CheckForCharacter()
        PlayerStandPart = Instance.new("Part")
        PlayerStandPart.Size = Vector3.new(3, 1, 3)
        PlayerStandPart.Parent = Workspace
        PlayerStandPart.Anchored = true
        PlayerStandPart.Transparency = 1
        PlayerStandPart.CanCollide = true
        PlayerStandPart.CanTouch = false
        PlayerStandPart.CanQuery = false
        StandPartHeight = GetPlayerSize() + PlayerStandPart.Size.Y/2.75
    end)
end

SetGlobal("spawning function")
if not IsMainMenu then
    SV.Parties = ReturnChild(ReplicatedStorage, "Parties") -- ready before MobScanner can use it
    SpawnFunctions = {
        CheckForAvoidMobs, MobScanner, CheckPlayerPing,
        ConnectMissionFinished, ConnectTowerFinished,
    }
    for _, SpawnFunction in SpawnFunctions do
        task.spawn(function()
            SpawnFunction()
        end)
    end
end

SetGlobal("getting class variables")
if not IsMainMenu then
    ISV.PlayerClass = WaitForAttribute(LocalPlayer, "Class")
    ISV.PlayerLevel = WaitForAttribute(LocalPlayer, "Level")
    ISV.PlayerPrestige = WaitForAttribute(LocalPlayer, "Prestige")
    PlayerProfile = ReturnChild(PlayerGui, "Profile")
    ProfileInventory = ReturnChild(PlayerProfile, "Inventory")
    SV.Parties = ReturnChild(ReplicatedStorage, "Parties")
end

SetGlobal("equipment pop up screen")
if IsTower and SV.CanRequire and EF.Hook and EF.NewClosure then
    local Success, Result = pcall(function()
        local DisplayItem = require(Client.Gui):Get("LootReceived")._DisplayItem
        CreateHookOnFunction(DisplayItem, true)
    end)
    if not Success then
        print("JDRS: executor can't disable loot screen")
    end
end

SetGlobal("connecting drops/chests")
do
    local CoinEvent = Remotes:WaitForChild("Drops_CoinEvent", math.huge)
    ConnectionTable["CollectDrops"] = CoinEvent.OnClientEvent:Connect(function(DropData)
        if SV.CollectDrops then
            CoinEvent:FireServer(DropData.id)
        else
            SV.Drops[DropData.id] = time()
        end
    end)
    local SpawnChest = Remotes:WaitForChild("Chests_SpawnChest", math.huge)
    local OpenChest = Remotes:WaitForChild("Chests_OpenChest", math.huge)
    ConnectionTable["ConnectChests"] = SpawnChest.OnClientEvent:Connect(function(ChestName, Location, GUID, d, e)
        if SV.CollectChests then
            OpenChest:FireServer(GUID)
        else
            table.insert(SV.Chests, GUID)
        end
    end)
end

SetGlobal("clean up script")
function CleanUpScript()
    ScriptUnloaded = true
    warn("[WZF][CLEANUP] invoked; job:", game.JobId)
    for Index in Toggles do
        local StringIndex = tostring(Index)
        if not string.find(StringIndex, "AutoScriptToggle") then
            Toggles[tostring(Index)]:SetValue(false) -- safely turn off all toggles
        end
    end
    for Index in Options do
        local StringIndex = tostring(Index)
        if string.find(StringIndex, "Dropdown") and not string.find(StringIndex, "UnloadTabDropdown") then
            Options[StringIndex]:SetValue({}) -- safely erase all dropdowns to turn attached functions off
        end
    end
    ISV.TeleportingToAnotherServer = true
    if not IsMainMenu and SV.CanRequire and EF.Hook and EF.CheckHook and EF.ClearHook and EF.NewClosure then
        local rPlayerRemover = require(SMobs:WaitForChild("PlayerRemover", math.huge))
        CreateHookOnFunction(rPlayerRemover.AddMobToSearch, false)
        for Index, Mob in Mobs:GetChildren() do
            rPlayerRemover:AddMobToSearch(Mob)
        end
        if SV.IsRanged then
            for Mob, MobData in ISV.MobTable do
                local MobCollider = Mob:WaitForChild("Collider", 5)
                if MobCollider then
                    MobCollider.Size = MobCollider.Size*2
                end
            end
        end
        rPlayerRemover = nil
        local rDrops = require(Drops)
        CreateHookOnFunction(rDrops.DropStarterpassExp, false)
        CreateHookOnFunction(rDrops.DropBattlepassExp, false)
        CreateHookOnFunction(rDrops.DropHealthOrb, false)
        CreateHookOnFunction(rDrops.SpawnCoinsLocal, false)
        rDrops = nil
        local rModelProvider = require(ModelProvider)
        CreateHookOnFunction(rModelProvider.GetModel, false)
        rModelProvider = nil
        local rEffects = require(Effects)
        CreateHookOnFunction(rEffects.RenderDamageNumber, false)
        CreateHookOnFunction(rEffects.MakeProjectile, false)
        CreateHookOnFunction(rEffects.DoEffect, false)
        CreateHookOnFunction(rEffects.PlayAt, false)
        CreateHookOnFunction(rEffects.EmitAt, false)
        rEffects = nil
        local rGui = require(Client.Gui)
        CreateHookOnFunction(rGui:Get("LootReceived")._DisplayItem, false)
        rGui = nil
        local rActions = require(Client.Actions)
        rActions:SetSkillDisabled("Primary", false)
        rActions:SetSkillDisabled("Skill1", false)
        rActions:SetSkillDisabled("Skill2", false)
        rActions:SetSkillDisabled("Skill3", false)
        rActions:SetSkillDisabled("Ultimate", false)
        CreateHookOnFunction(rActions.IsBusy, false)
        CreateHookOnFunction(rActions.Knockdown, false)
        rActions = nil
    end
    if DC then
        if EF.Queue then
            local FileName = "JDRS/AutoExecute"
            if isfile(FileName) then
                delfile(FileName)
                EF.ClearQueue()
            end
        end
        if IsDungeon then
            if SV.PlayerCamera and SV.PlayerCamera.Parent and PlayerRoot == SV.PlayerCamera.Parent then
                Workspace.CurrentCamera.CameraSubject = SV.PlayerCamera
            else
                Workspace.CurrentCamera.CameraSubject = PlayerRoot:WaitForChild("Part", math.huge)
            end
        end
        if SV.WalkspeedManager then
            if ISV.IsMobile then
                SV.WalkspeedManager:SetBaseSpeed(28)
            else
                SV.WalkspeedManager:SetBaseSpeed(20)
            end
        end
        if ISV.RenderingScreen then
            ISV.RenderingScreen:Destroy()
            ISV.RenderingScreen = nil
            RunService:Set3dRenderingEnabled(true)
        end
        for Key in ISV do
            ISV[Key] = nil
        end
        for Key in EF do
            EF[Key] = nil
        end
        ISV = nil
        if PlayerRoot then
            PlayerRoot.CanCollide = true
        end
        for Part, PartData in TeleportParts do
            if Part and Part.Parent then
                Part.Size = PartData.OriginalSize
                Part.CanCollide = PartData.OriginalCollision
                Part.Position = PartData.OriginalLocation
            end
        end
        ScriptUnloaded, Remotes, SetGlobal,
        RequestMessage = nil
    end
    for Key in SV do
        SV[Key] = nil
    end
    for Index, Connection in ConnectionTable do
        Connection:Disconnect()
        ConnectionTable[Index] = nil
    end
    _G.Is_Script_Running = nil
    Library:Unload()
    SaveErrorToFile = function()
        return
    end
    if PlayerStandPart then
        PlayerStandPart:Destroy()
    end
    Library, SaveManager, MakeGuiElement, MakeErrorGui, ReturnService,
    GetShared, ReturnChild, WaitForAttribute, Workspace, Players,
    CoreGui, StarterGui, ReplicatedStorage, HttpService, VirtualUser,
    RunService, MarketplaceService, TeleportService, Shared, Battlepass,
    Charms, Chests, Drops, Effects, Health,
    Inventory, Items, Missions, SMobs, ModelProvider,
    Party, Pets, Quests, Shop, Skills,
    Teleport, Camera, Mobs, MissionObjects, LocalPlayer,
    PlayerName, PlayerID, PlayerGui, PlayerPing, PlayerProfile,
    ProfileInventory, PlayerCharacter, PlayerCollider, PlayerRoot, AddedDelay,
    Xdistance, Ydistance, TempStop, HoldForRealTime, RestartAtFloor,
    CurrentMob, IsMobCamera, KeepTier, SellItemCheck, OffsetMax,
    EquipInProgress, MobRotationSpeed, DelayPetAttacks, IsAliveMobs, DiscordPingType,
    TeleportMob, StuckDelay, DelayAttacks, IsBoss, EventOverride,
    CanTarget, PingMultiplie, StringPlaceID, IsWorld, IsMainMenu,
    IsDungeon, IsTower, SaveScriptToFiles, AvoidMobs, TeleportParts,
    FormatNumber, FormatDecimal, GetPercentage, SecondsToString, IsMissionOver,
    CheckForAvoidMobs, CheckPlayerPing, MobScanner, PingOnceUnlocked, PingForCap,
    GetDifficulty, GetLives, PartyLeaderCheck, ReplayDungeonLoop, RejoinLastDungeon,
    RestartDungeon, CollectChests, ClaimAllQuests, GetDungeonImage, ConnectMissionFinished,
    ConnectTowerFinished, GetRarity, EquipNewItemAdded, StatTotals, CollectTowerChests,
    CollectCoins, GetGuild, IsTowerEgg, SellItem, BuyFromLocalShop,
    BuyFromEggShop, OpenMenu, UpgradeToMax, ExpandPartSize, FindPart,
    ToggleMenu, DodgeCurrentAttack, TeleportToOrb, BuildAttackData, GetPlayerPet,
    GetPlayerClass, BuildShopValues, DisconnectVariable, TeleportStandPart, GetPlayerSize,
    PlayerStandPart, StandPartHeight, CreateHookOnFunction, Class, ClassSkills,
    PetSkills, ItemSellCheck, RecycleFromInventory = nil
    _G.ScriptRunning = nil
end

SetGlobal("obsidian save manager")
SaveManager = SaveScriptToFiles("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/SaveManager.lua", "S", 1)

print("Script took", FormatDecimal(os.clock() - ScriptLoadingStart), "seconds to fully load from execution time")
ScriptLoadingStart = nil

-- Independent observation only: never restarts workers or sends transitions.
task.spawn(function()
    while not ScriptUnloaded and _G.ScriptRunning do
        task.wait(10)
        if ScriptUnloaded or not SV then break end
        local Count = 0
        if ISV and ISV.MobTable then for _ in ISV.MobTable do Count += 1 end end
        print("[WZF][HEARTBEAT]", "job", game.JobId,
            "step", tostring(_G.ScriptStep), "toggle", tostring(Toggles and Toggles.AutoProgressToggle and Toggles.AutoProgressToggle.Value),
            "autofarm", tostring(SV.Autofarm), "kill", tostring(KillSwitch),
            "character", PlayerCharacter ~= nil, "root", PlayerRoot ~= nil, "collider", PlayerCollider ~= nil,
            "scanner", tostring(SV.WZFScannerState), "scanAge", SV.WZFScannerTick and os.clock()-SV.WZFScannerTick or -1,
            "mover", tostring(SV.WZFMoverState), "moveAge", SV.WZFMoverTick and os.clock()-SV.WZFMoverTick or -1,
            "tempStop", tostring(TempStop), "hold", tostring(HoldForRealTime), "event", tostring(EventOverride),
            "canTarget", tostring(CanTarget), "cachedMobs", Count, "folderMobs", Mobs and #Mobs:GetChildren() or -1,
            "target", tostring(TeleportMob), "mission", tostring(ISV and ISV.MissionId),
            "transition", tostring(SV.TransitionPending))
    end
end)
SetGlobal("loading configs")
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ "MenuKeybind" })
SaveManager:SetFolder("JDRS/saved_configs")
SaveManager:BuildConfigSection(ConfigTab)
-- B3-test: config parsers may run after LoadAutoloadConfig returns.
-- Listen to the setting itself, without waiting for long-running farm callbacks.
do
    local function ApplyMenuVisibility()
        if ScriptUnloaded or not Library or Library.Unloaded then return end
        local HideOnStart = Toggles.HideGuiToggle and Toggles.HideGuiToggle.Value == true
        local ShouldShowMenu = not HideOnStart
        if type(Library.Toggle) == "function" and type(Library.Toggled) == "boolean" then
            if Library.Toggled ~= ShouldShowMenu then
                Library:Toggle()
            end
            print("[WZF] Menu visibility applied; hidden:", HideOnStart, "job:", game.JobId)
        else
            warn("[WZF] Could not determine current menu visibility")
        end
    end
    if Toggles.HideGuiToggle then
        Toggles.HideGuiToggle:OnChanged(ApplyMenuVisibility)
    end
    SaveManager:LoadAutoloadConfig()
    task.defer(ApplyMenuVisibility)
end

do
    SetGlobal("checking platform")
    local GetPlatform = game:GetService("UserInputService"):GetPlatform()
    if GetPlatform ~= Enum.Platform.Android and GetPlatform ~= Enum.Platform.IOS then
        Library:Notify("You can press 0 (zero key) to open/close the menu", 10)
    else
        ISV.IsMobile = true
    end
end

SetGlobal("checking for old obsidian")
-- The window already uses ToggleKeybind = Enum.KeyCode.Zero.
-- Do not wait forever for a second GUI or register a duplicate key handler.
print("[WZF] Legacy Obsidian input handler skipped")

SetGlobal("leaderboard info set up")
if IsWorld or IsDungeon then
    task.spawn(function()
        local Success, Result = pcall(function()
            local GetScore = Remotes:WaitForChild("LeaderboardHookup_GetScore", math.huge)
            if not SV.DungeonsTab then
                if GetLeaderboardScore("C_NP1", SV.TotalNightmareLabel, SV.DailyNightmareLabel, SV.StopAfterTotalNightmare, SV.StopAfterDailyNightmare) then
                    Library:Notify("Nightmare portal clear limit reached.", 999999999)
                    local TempStop = true
                    local CanTarget = false
                    if SV.NightmarePing then
                        PingForCap("Nightmare portal")
                    end
                end
            end -- for unloaded dungeons tan
            if not SV.GuildTab then
                local TotalPointData = GetScore:InvokeServer("G_POINTS22", 1)
                local DailyPointData = Remotes:WaitForChild("Profile_GetOwnCollectionValue", math.huge):InvokeServer("GuildPointsEarnedToday")
                local GuildPointTotal = TotalPointData[1]
                local GuildPointTotalLimit = tonumber(SV.StopAfterTotalPoints)
                local GuildPointDaily = DailyPointData
                local GuildPointDailyLimit = tonumber(SV.StopAfterDailyPoints)
                SV.TotalGuildPointLabel:SetText("Total Guild Points: " ..FormatNumber(GuildPointTotal))
                SV.DailyGuildPointLabel:SetText("Daily Guild Points: " ..FormatNumber(GuildPointDaily))
                if (GuildPointTotalLimit and (GuildPointTotal >= GuildPointTotalLimit)) or (GuildPointDailyLimit and (GuildPointDaily >= GuildPointDailyLimit)) then
                    Library:Notify("Guild point limit reached.", 999999999)
                    CanTarget = false
                    TempStop = true
                    if SV.GuildPing then
                        PingForCap("Guild Point")
                    end
                end
            end -- for unloaded guild tab
        end)
        if not Success then
            print(Result)
        end
    end)
end

-- Event dungeons may report zero lives without being a failed run.
-- Their completion/failure event remains responsible for automatic replay.
if IsDungeon and not IsEventDungeon then
    local StartupLives = GetLives()
    print("[WZF] Startup lives check:", tostring(StartupLives), "job:", game.JobId)
    if StartupLives == 0 then
        RestartDungeon()
    end
elseif IsEventDungeon then
    print("[WZF] Event startup lives replay skipped; waiting for mission result; job:", game.JobId)
end

SetGlobal("end")
