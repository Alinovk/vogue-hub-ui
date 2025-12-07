--[[
    GAME SCRIPT EXAMPLE
    Пример скрипта для использования в игре
]]

local VogueLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/yourusername/vogue-hub-ui/main/src/init.lua"))()

local Window = VogueLib:CreateWindow({
    Title = "GAME HUB",
    Size = UDim2.new(0, 550, 0, 420)
})

-- ═══════════════════════════════════════
-- PLAYER TAB
-- ═══════════════════════════════════════
local PlayerTab = Window:CreateTab({Name = "Player"})
local MovementSection = PlayerTab:CreateSection("Movement")

local WalkSpeed = 16
local JumpPower = 50
local InfiniteJump = false

MovementSection:CreateSlider({
    Name = "Walk Speed",
    Min = 16,
    Max = 200,
    Default = 16,
    Callback = function(Value)
        WalkSpeed = Value
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})

MovementSection:CreateSlider({
    Name = "Jump Power",
    Min = 50,
    Max = 200,
    Default = 50,
    Callback = function(Value)
        JumpPower = Value
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end
})

MovementSection:CreateToggle({
    Name = "Infinite Jump",
    Default = false,
    Callback = function(Value)
        InfiniteJump = Value
    end
})

game:GetService("UserInputService").JumpRequest:Connect(function()
    if InfiniteJump then
        game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
    end
end)

local MiscSection = PlayerTab:CreateSection("Miscellaneous")

MiscSection:CreateButton({
    Name = "Reset Character",
    Callback = function()
        game.Players.LocalPlayer.Character.Humanoid.Health = 0
    end
})

MiscSection:CreateButton({
    Name = "Respawn",
    Callback = function()
        game.Players.LocalPlayer:LoadCharacter()
    end
})

-- ═══════════════════════════════════════
-- COMBAT TAB
-- ═══════════════════════════════════════
local CombatTab = Window:CreateTab({Name = "Combat"})
local CombatSection = CombatTab:CreateSection("Features")

CombatSection:CreateToggle({
    Name = "Auto Click",
    Default = false,
    Callback = function(Value)
        _G.AutoClick = Value
        while _G.AutoClick do
            mouse1click()
            wait(0.01)
        end
    end
})

CombatSection:CreateSlider({
    Name = "Click Speed",
    Min = 1,
    Max = 100,
    Default = 20,
    Callback = function(Value)
        _G.ClickSpeed = Value
    end
})

-- ═══════════════════════════════════════
-- TELEPORT TAB
-- ═══════════════════════════════════════
local TeleportTab = Window:CreateTab({Name = "Teleport"})
local TeleportSection = TeleportTab:CreateSection("Locations")

local function TeleportTo(position)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(position)
end

TeleportSection:CreateButton({
    Name = "Spawn",
    Callback = function()
        TeleportTo(Vector3.new(0, 50, 0))
        Window:Notify({
            Title = "Teleport",
            Content = "Teleported to Spawn!",
            Duration = 2
        })
    end
})

-- ═══════════════════════════════════════
-- SETTINGS TAB
-- ═══════════════════════════════════════
local SettingsTab = Window:CreateTab({Name = "Settings"})
local ConfigSection = SettingsTab:CreateSection("Configuration")

ConfigSection:CreateKeybind({
    Name = "Toggle UI",
    Default = Enum.KeyCode.RightControl,
    Callback = function()
        -- Toggle UI visibility
        Window:Notify({
            Title = "UI",
            Content = "UI toggled!",
            Duration = 1
        })
    end
})

ConfigSection:CreateButton({
    Name = "Destroy UI",
    Callback = function()
        game:GetService("CoreGui"):FindFirstChild("VogueHubUI"):Destroy()
    end
})

-- Load notification
Window:Notify({
    Title = "Game Hub",
    Content = "All features loaded successfully!",
    Duration = 3
})