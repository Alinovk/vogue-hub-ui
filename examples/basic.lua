--[[
    BASIC EXAMPLE
    Простой пример использования VOGUE HUB UI Library
]]

-- Загрузка библиотеки
local VogueLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/yourusername/vogue-hub-ui/main/src/init.lua"))()

-- Создание окна
local Window = VogueLib:CreateWindow({
    Title = "BASIC EXAMPLE",
    Size = UDim2.new(0, 500, 0, 350)
})

-- Создание таба
local MainTab = Window:CreateTab({
    Name = "Main"
})

-- Создание секции
local Section = MainTab:CreateSection("Simple Elements")

-- Кнопка
Section:CreateButton({
    Name = "Print Message",
    Callback = function()
        print("Hello from VOGUE HUB!")
        Window:Notify({
            Title = "Button",
            Content = "Message printed to console!",
            Duration = 2
        })
    end
})

-- Toggle
Section:CreateToggle({
    Name = "Enable Feature",
    Default = false,
    Callback = function(Value)
        print("Toggle state:", Value)
    end
})

-- Slider
Section:CreateSlider({
    Name = "Value",
    Min = 0,
    Max = 100,
    Default = 50,
    Callback = function(Value)
        print("Slider value:", Value)
    end
})

-- Label
Section:CreateLabel("This is a simple label")

-- Приветственное уведомление
Window:Notify({
    Title = "Welcome",
    Content = "Basic example loaded successfully!",
    Duration = 3
})
