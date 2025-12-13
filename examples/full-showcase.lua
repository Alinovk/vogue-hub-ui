--[[
    FULL SHOWCASE
    Demonstration of all library features v2.0.0
]]

local VogueLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Alinovk/vogue-hub-ui/main/src/init.lua"))()

local Window = VogueLib:CreateWindow({
    Title = "VOGUE HUB SHOWCASE",
    Size = UDim2.new(0, 600, 0, 450),
    Theme = "Dark"
})

-- ═══════════════════════════════════════
-- TAB 1: COMPONENTS
-- ═══════════════════════════════════════
local ComponentsTab = Window:CreateTab({Name = "Components", Icon = "🔧"})

local ButtonSection = ComponentsTab:CreateSection("Buttons")
ButtonSection:CreateButton({
    Name = "Standard Button",
    Icon = "🔘",
    Callback = function()
        Window:Notify({
            Title = "Button",
            Content = "Standard button clicked!",
            Duration = 2,
            Type = "info"
        })
    end
})

ButtonSection:CreateButton({
    Name = "Success Action",
    Icon = "✅",
    Callback = function()
        Window:Notify({
            Title = "Success",
            Content = "Action completed!",
            Duration = 2,
            Type = "success"
        })
    end
})

local ToggleSection = ComponentsTab:CreateSection("Toggles")
local Toggle1 = ToggleSection:CreateToggle({
    Name = "Toggle Feature 1",
    Icon = "⚡",
    Default = false,
    Callback = function(Value)
        print("Feature 1:", Value)
    end
})

ToggleSection:CreateToggle({
    Name = "Toggle Feature 2",
    Icon = "🔥",
    Default = true,
    Callback = function(Value)
        print("Feature 2:", Value)
    end
})

local SliderSection = ComponentsTab:CreateSection("Sliders")
SliderSection:CreateSlider({
    Name = "Slider 1",
    Icon = "📊",
    Min = 0,
    Max = 100,
    Default = 50,
    Callback = function(Value)
        print("Slider 1:", Value)
    end
})

SliderSection:CreateSlider({
    Name = "Precise Slider",
    Icon = "🎯",
    Min = 0,
    Max = 1,
    Default = 0.5,
    Increment = 0.1,
    Callback = function(Value)
        print("Precise:", Value)
    end
})

-- ═══════════════════════════════════════
-- TAB 2: INPUTS
-- ═══════════════════════════════════════
local InputsTab = Window:CreateTab({Name = "Inputs", Icon = "⌨️"})

local DropdownSection = InputsTab:CreateSection("Dropdowns")
local MainDropdown = DropdownSection:CreateDropdown({
    Name = "Select Option",
    Icon = "📋",
    Options = {"Option 1", "Option 2", "Option 3", "Option 4"},
    Default = "Option 1",
    Callback = function(Value)
        print("Selected:", Value)
    end
})

DropdownSection:CreateButton({
    Name = "Add Option 5",
    Callback = function()
        MainDropdown:Refresh({"Option 1", "Option 2", "Option 3", "Option 4", "Option 5"})
        Window:Notify({
            Title = "Dropdown",
            Content = "Option 5 added!",
            Duration = 2,
            Type = "success"
        })
    end
})

local TextBoxSection = InputsTab:CreateSection("Text Inputs")
TextBoxSection:CreateTextBox({
    Name = "Enter Text",
    Icon = "✏️",
    Placeholder = "Type here...",
    Callback = function(Value)
        print("Text entered:", Value)
        Window:Notify({
            Title = "Text Input",
            Content = "You entered: " .. Value,
            Duration = 3,
            Type = "info"
        })
    end
})

local KeybindSection = InputsTab:CreateSection("Keybinds")
KeybindSection:CreateKeybind({
    Name = "Toggle UI",
    Icon = "🎮",
    Default = Enum.KeyCode.RightControl,
    Callback = function()
        print("Keybind pressed!")
        Window:Notify({
            Title = "Keybind",
            Content = "Toggle UI keybind activated!",
            Duration = 2,
            Type = "info"
        })
    end
})

KeybindSection:CreateLabel("Press ESC while listening to clear keybind")

-- ═══════════════════════════════════════
-- TAB 3: NEW COMPONENTS
-- ═══════════════════════════════════════
local NewTab = Window:CreateTab({Name = "New v2.0", Icon = "✨"})

local ColorSection = NewTab:CreateSection("Color Picker")
local MyColor = ColorSection:CreateColorPicker({
    Name = "Pick Color",
    Icon = "🎨",
    Default = Color3.fromRGB(200, 170, 130),
    Callback = function(Color)
        print("Color:", Color)
    end
})

ColorSection:CreateButton({
    Name = "Set Red",
    Callback = function()
        MyColor:Set(Color3.fromRGB(255, 0, 0))
    end
})

local ProgressSection = NewTab:CreateSection("Progress Bar")
local MyProgress = ProgressSection:CreateProgressBar({
    Name = "Loading Progress",
    Icon = "📈",
    Default = 0,
    Max = 100
})

ProgressSection:CreateButton({
    Name = "Simulate Loading",
    Callback = function()
        for i = 0, 100, 5 do
            MyProgress:Set(i)
            task.wait(0.1)
        end
        Window:Notify({
            Title = "Complete",
            Content = "Loading finished!",
            Duration = 2,
            Type = "success"
        })
    end
})

ProgressSection:CreateButton({
    Name = "Reset Progress",
    Callback = function()
        MyProgress:Set(0)
    end
})

local SeparatorSection = NewTab:CreateSection("Separators & Labels")
SeparatorSection:CreateLabel("📊 Version: 2.0.0")
SeparatorSection:CreateSeparator()
SeparatorSection:CreateLabel("👤 User: " .. game.Players.LocalPlayer.Name)
SeparatorSection:CreateSeparator()
SeparatorSection:CreateLabel("🎮 Game: " .. tostring(game.PlaceId))

-- ═══════════════════════════════════════
-- TAB 4: THEMES
-- ═══════════════════════════════════════
local ThemesTab = Window:CreateTab({Name = "Themes", Icon = "🎭"})

local ThemeSection = ThemesTab:CreateSection("Theme Selection")
ThemeSection:CreateLabel("Note: Theme changes apply to new windows")
ThemeSection:CreateSeparator()

local themes = VogueLib:GetThemes()
ThemeSection:CreateDropdown({
    Name = "Select Theme",
    Icon = "🎨",
    Options = themes,
    Default = "Dark",
    Callback = function(Value)
        VogueLib:SetTheme(Value)
        Window:Notify({
            Title = "Theme",
            Content = "Theme set to " .. Value .. ". Create new window to see changes.",
            Duration = 3,
            Type = "info"
        })
    end
})

-- ═══════════════════════════════════════
-- TAB 5: NOTIFICATIONS
-- ═══════════════════════════════════════
local NotifyTab = Window:CreateTab({Name = "Notifications", Icon = "🔔"})

local NotifySection = NotifyTab:CreateSection("Notification Types")

NotifySection:CreateButton({
    Name = "Info Notification",
    Icon = "ℹ️",
    Callback = function()
        Window:Notify({
            Title = "Information",
            Content = "This is an info notification",
            Duration = 3,
            Type = "info"
        })
    end
})

NotifySection:CreateButton({
    Name = "Success Notification",
    Icon = "✅",
    Callback = function()
        Window:Notify({
            Title = "Success",
            Content = "Operation completed successfully!",
            Duration = 3,
            Type = "success"
        })
    end
})

NotifySection:CreateButton({
    Name = "Warning Notification",
    Icon = "⚠️",
    Callback = function()
        Window:Notify({
            Title = "Warning",
            Content = "Please be careful with this action",
            Duration = 3,
            Type = "warning"
        })
    end
})

NotifySection:CreateButton({
    Name = "Error Notification",
    Icon = "❌",
    Callback = function()
        Window:Notify({
            Title = "Error",
            Content = "Something went wrong!",
            Duration = 3,
            Type = "error"
        })
    end
})

NotifySection:CreateSeparator()

NotifySection:CreateButton({
    Name = "Stack Multiple",
    Icon = "📚",
    Callback = function()
        Window:Notify({Title = "First", Content = "Notification 1", Duration = 4, Type = "info"})
        task.wait(0.3)
        Window:Notify({Title = "Second", Content = "Notification 2", Duration = 4, Type = "success"})
        task.wait(0.3)
        Window:Notify({Title = "Third", Content = "Notification 3", Duration = 4, Type = "warning"})
    end
})

-- ═══════════════════════════════════════
-- WELCOME NOTIFICATION
-- ═══════════════════════════════════════
Window:Notify({
    Title = "Showcase Loaded",
    Content = "All components have been loaded successfully!",
    Duration = 4,
    Type = "success"
})

