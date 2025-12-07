--[[
    FULL SHOWCASE
    Демонстрация всех возможностей библиотеки
]]

local VogueLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/yourusername/vogue-hub-ui/main/src/init.lua"))()

local Window = VogueLib:CreateWindow({
    Title = "VOGUE HUB SHOWCASE",
    Size = UDim2.new(0, 600, 0, 450)
})

-- ═══════════════════════════════════════
-- TAB 1: COMPONENTS
-- ═══════════════════════════════════════
local ComponentsTab = Window:CreateTab({Name = "Components"})

local ButtonSection = ComponentsTab:CreateSection("Buttons")
ButtonSection:CreateButton({
    Name = "Standard Button",
    Callback = function()
        Window:Notify({
            Title = "Button",
            Content = "Standard button clicked!",
            Duration = 2
        })
    end
})

ButtonSection:CreateButton({
    Name = "Another Button",
    Callback = function()
        print("Another button clicked!")
    end
})

local ToggleSection = ComponentsTab:CreateSection("Toggles")
local Toggle1 = ToggleSection:CreateToggle({
    Name = "Toggle Feature 1",
    Default = false,
    Callback = function(Value)
        print("Feature 1:", Value)
    end
})

ToggleSection:CreateToggle({
    Name = "Toggle Feature 2",
    Default = true,
    Callback = function(Value)
        print("Feature 2:", Value)
    end
})

local SliderSection = ComponentsTab:CreateSection("Sliders")
SliderSection:CreateSlider({
    Name = "Slider 1",
    Min = 0,
    Max = 100,
    Default = 50,
    Callback = function(Value)
        print("Slider 1:", Value)
    end
})

SliderSection:CreateSlider({
    Name = "Slider 2",
    Min = 1,
    Max = 10,
    Default = 5,
    Callback = function(Value)
        print("Slider 2:", Value)
    end
})

-- ═══════════════════════════════════════
-- TAB 2: INPUTS
-- ═══════════════════════════════════════
local InputsTab = Window:CreateTab({Name = "Inputs"})

local DropdownSection = InputsTab:CreateSection("Dropdowns")
DropdownSection:CreateDropdown({
    Name = "Select Option",
    Options = {"Option 1", "Option 2", "Option 3", "Option 4"},
    Default = "Option 1",
    Callback = function(Value)
        print("Selected:", Value)
    end
})

local TextBoxSection = InputsTab:CreateSection("Text Inputs")
TextBoxSection:CreateTextBox({
    Name = "Enter Text",
    Placeholder = "Type here...",
    Callback = function(Value)
        print("Text entered:", Value)
        Window:Notify({
            Title = "Text Input",
            Content = "You entered: " .. Value,
            Duration = 3
        })
    end
})

local KeybindSection = InputsTab:CreateSection("Keybinds")
KeybindSection:CreateKeybind({
    Name = "Toggle UI",
    Default = Enum.KeyCode.RightControl,
    Callback = function()
        print("Keybind pressed!")
        Window:Notify({
            Title = "Keybind",
            Content = "Toggle UI keybind activated!",
            Duration = 2
        })
    end
})

-- ═══════════════════════════════════════
-- TAB 3: LABELS
-- ═══════════════════════════════════════
local LabelsTab = Window:CreateTab({Name = "Labels"})

local InfoSection = LabelsTab:CreateSection("Information")
InfoSection:CreateLabel("📊 Version: 1.0.0")
InfoSection:CreateLabel("👤 User: " .. game.Players.LocalPlayer.Name)
InfoSection:CreateLabel("🎮 Game: " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)
InfoSection:CreateLabel("⏰ Time: " .. os.date("%H:%M:%S"))

local StatusSection = LabelsTab:CreateSection("Status")
local StatusLabel = StatusSection:CreateLabel("Status: Idle")

StatusSection:CreateButton({
    Name = "Update Status",
    Callback = function()
        StatusLabel:Set("Status: Active ✓")
        Window:Notify({
            Title = "Status",
            Content = "Status updated!",
            Duration = 2
        })
    end
})

-- ═══════════════════════════════════════
-- TAB 4: API DEMO
-- ═══════════════════════════════════════
local APITab = Window:CreateTab({Name = "API Demo"})

local APISection = APITab:CreateSection("Component API")

local DemoToggle = APISection:CreateToggle({
    Name = "Demo Toggle",
    Default = false,
    Callback = function(Value)
        print("Demo Toggle:", Value)
    end
})

local DemoSlider = APISection:CreateSlider({
    Name = "Demo Slider",
    Min = 0,
    Max = 100,
    Default = 0,
    Callback = function(Value)
        print("Demo Slider:", Value)
    end
})

APISection:CreateButton({
    Name = "Set Toggle ON",
    Callback = function()
        DemoToggle:Set(true)
    end
})

APISection:CreateButton({
    Name = "Set Toggle OFF",
    Callback = function()
        DemoToggle:Set(false)
    end
})

APISection:CreateButton({
    Name = "Set Slider to 100",
    Callback = function()
        DemoSlider:Set(100)
    end
})

APISection:CreateButton({
    Name = "Get Slider Value",
    Callback = function()
        local value = DemoSlider:Get()
        Window:Notify({
            Title = "Slider Value",
            Content = "Current value: " .. tostring(value),
            Duration = 3
        })
    end
})

-- ═══════════════════════════════════════
-- NOTIFICATIONS
-- ═══════════════════════════════════════
Window:Notify({
    Title = "Showcase Loaded",
    Content = "All components have been loaded successfully!",
    Duration = 4
})