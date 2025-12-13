--[[
    GAME SCRIPT EXAMPLE
    Practical example for game exploits v3.0.0
]]

local VogueLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/yourusername/vogue-hub-ui/main/src/init.lua"))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Window = VogueLib:CreateWindow({
    Title = "Game Hub",
    Size = UDim2.new(0, 580, 0, 420),
    Theme = "Midnight"
})

-- ═══════════════════════════════════════
-- PLAYER TAB
-- ═══════════════════════════════════════
local PlayerTab = Window:CreateTab({Name = "Player", Icon = "👤"})

local MovementSection = PlayerTab:CreateSection("Movement")

MovementSection:CreateSlider({
    Name = "Walk Speed",
    Icon = "🏃",
    Min = 16,
    Max = 200,
    Default = 16,
    Callback = function(Value)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end
    end
})

MovementSection:CreateSlider({
    Name = "Jump Power",
    Icon = "⬆️",
    Min = 50,
    Max = 300,
    Default = 50,
    Callback = function(Value)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = Value
        end
    end
})

MovementSection:CreateToggle({
    Name = "Infinite Jump",
    Icon = "🦘",
    Default = false,
    Callback = function(Value)
        _G.InfiniteJump = Value
    end
})

-- Infinite Jump Handler
game:GetService("UserInputService").JumpRequest:Connect(function()
    if _G.InfiniteJump then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

local CharacterSection = PlayerTab:CreateSection("Character")

CharacterSection:CreateToggle({
    Name = "God Mode",
    Icon = "🛡️",
    Default = false,
    Callback = function(Value)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            if Value then
                LocalPlayer.Character.Humanoid.MaxHealth = math.huge
                LocalPlayer.Character.Humanoid.Health = math.huge
            else
                LocalPlayer.Character.Humanoid.MaxHealth = 100
                LocalPlayer.Character.Humanoid.Health = 100
            end
        end
    end
})

CharacterSection:CreateButton({
    Name = "Reset Character",
    Icon = "💀",
    Callback = function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.Health = 0
        end
    end
})

-- ═══════════════════════════════════════
-- VISUALS TAB
-- ═══════════════════════════════════════
local VisualsTab = Window:CreateTab({Name = "Visuals", Icon = "👁️"})

local ESPSection = VisualsTab:CreateSection("ESP Settings")

local ESPEnabled = false
local ESPColor = Color3.fromRGB(255, 0, 0)

ESPSection:CreateToggle({
    Name = "Enable ESP",
    Icon = "👀",
    Default = false,
    Callback = function(Value)
        ESPEnabled = Value
        -- ESP implementation would go here
        Window:Notify({
            Title = "ESP",
            Content = Value and "ESP Enabled" or "ESP Disabled",
            Duration = 2,
            Type = Value and "success" or "info"
        })
    end
})

ESPSection:CreateColorPicker({
    Name = "ESP Color",
    Icon = "🎨",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(Color)
        ESPColor = Color
    end
})

ESPSection:CreateDropdown({
    Name = "ESP Type",
    Icon = "📋",
    Options = {"Box", "Corner", "Highlight"},
    Default = "Box",
    Callback = function(Value)
        print("ESP Type:", Value)
    end
})

local WorldSection = VisualsTab:CreateSection("World")

WorldSection:CreateToggle({
    Name = "Fullbright",
    Icon = "💡",
    Default = false,
    Callback = function(Value)
        local Lighting = game:GetService("Lighting")
        if Value then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false
        else
            Lighting.Brightness = 1
            Lighting.ClockTime = 14
            Lighting.FogEnd = 10000
            Lighting.GlobalShadows = true
        end
    end
})

-- ═══════════════════════════════════════
-- TELEPORT TAB
-- ═══════════════════════════════════════
local TeleportTab = Window:CreateTab({Name = "Teleport", Icon = "🌀"})

local TeleportSection = TeleportTab:CreateSection("Player Teleport")

local SelectedPlayer = nil

TeleportSection:CreateDropdown({
    Name = "Select Player",
    Icon = "👥",
    Options = (function()
        local names = {}
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                table.insert(names, p.Name)
            end
        end
        return names
    end)(),
    Callback = function(Value)
        SelectedPlayer = Value
    end
})

TeleportSection:CreateButton({
    Name = "Teleport to Player",
    Icon = "🚀",
    Callback = function()
        if SelectedPlayer then
            local target = Players:FindFirstChild(SelectedPlayer)
            if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
                    Window:Notify({
                        Title = "Teleport",
                        Content = "Teleported to " .. SelectedPlayer,
                        Duration = 2,
                        Type = "success"
                    })
                end
            end
        else
            Window:Notify({
                Title = "Error",
                Content = "No player selected!",
                Duration = 2,
                Type = "error"
            })
        end
    end
})

-- ═══════════════════════════════════════
-- SETTINGS TAB
-- ═══════════════════════════════════════
local SettingsTab = Window:CreateTab({Name = "Settings", Icon = "⚙️"})

local UISection = SettingsTab:CreateSection("UI Settings")

UISection:CreateDropdown({
    Name = "Theme",
    Icon = "🎨",
    Options = VogueLib:GetThemes(),
    Default = "Midnight",
    Callback = function(Value)
        Window:SetTheme(Value)
        Window:Notify({
            Title = "Theme",
            Content = "Changed to " .. Value,
            Duration = 2,
            Type = "success"
        })
    end
})

UISection:CreateKeybind({
    Name = "Toggle UI",
    Icon = "⌨️",
    Default = Enum.KeyCode.RightControl,
    Callback = function()
        Window:Toggle()
    end
})

UISection:CreateSeparator()

UISection:CreateButton({
    Name = "Destroy UI",
    Icon = "🗑️",
    Callback = function()
        Window:Destroy()
    end
})

local InfoSection = SettingsTab:CreateSection("Info")
InfoSection:CreateLabel("👤 Player: " .. LocalPlayer.Name)
InfoSection:CreateLabel("🎮 Game: " .. tostring(game.PlaceId))
InfoSection:CreateLabel("📊 Version: 3.0.0")

-- ═══════════════════════════════════════
-- WELCOME
-- ═══════════════════════════════════════
Window:Notify({
    Title = "Game Hub Loaded",
    Content = "Welcome, " .. LocalPlayer.Name .. "!",
    Duration = 4,
    Type = "success"
})
