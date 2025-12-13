--[[
    BASIC EXAMPLE
    Simple example of using VOGUE HUB UI Library v2.0.0
]]

-- Load library
local VogueLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Alinovk/vogue-hub-ui/main/src/init.lua"))()

-- Create window
local Window = VogueLib:CreateWindow({
    Title = "BASIC EXAMPLE",
    Size = UDim2.new(0, 500, 0, 350),
    Theme = "Dark"
})

-- Create tab with icon
local MainTab = Window:CreateTab({
    Name = "Main",
    Icon = "🏠"
})

-- Create section
local Section = MainTab:CreateSection("Simple Elements")

-- Button with ripple effect
Section:CreateButton({
    Name = "Print Message",
    Icon = "📝",
    Callback = function()
        print("Hello from VOGUE HUB!")
        Window:Notify({
            Title = "Button",
            Content = "Message printed to console!",
            Duration = 2,
            Type = "success"
        })
    end
})

-- Toggle with glow
Section:CreateToggle({
    Name = "Enable Feature",
    Icon = "⚡",
    Default = false,
    Callback = function(Value)
        print("Toggle state:", Value)
    end
})

-- Slider with knob
Section:CreateSlider({
    Name = "Value",
    Icon = "📊",
    Min = 0,
    Max = 100,
    Default = 50,
    Callback = function(Value)
        print("Slider value:", Value)
    end
})

-- Separator
Section:CreateSeparator()

-- Label
Section:CreateLabel("This is a simple label")

-- Welcome notification
Window:Notify({
    Title = "Welcome",
    Content = "Basic example loaded successfully!",
    Duration = 3,
    Type = "info"
})
