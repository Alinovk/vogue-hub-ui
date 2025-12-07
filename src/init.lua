--[[
    ╔══════════════════════════════════════════════════════════════════════╗
    ║                        VOGUE HUB UI LIBRARY                          ║
    ║                            Version 1.0.0                             ║
    ║                                                                      ║
    ║  Минималистичная и элегантная UI библиотека для Roblox Luau        ║
    ║                                                                      ║
    ║  GitHub: https://github.com/yourusername/vogue-hub-ui               ║
    ║  License: MIT                                                        ║
    ║  Author: Your Name                                                   ║
    ║                                                                      ║
    ║  Использование:                                                      ║
    ║  local Lib = loadstring(game:HttpGet("RAW_GITHUB_URL"))()           ║
    ║  local Window = Lib:CreateWindow({Title = "My Hub"})                ║
    ║                                                                      ║
    ╚══════════════════════════════════════════════════════════════════════╝
]]

-- ════════════════════════════════════════════════════════════════════════
-- ГЛАВНЫЙ МОДУЛЬ
-- ════════════════════════════════════════════════════════════════════════

local VogueLib = {}
VogueLib.__index = VogueLib
VogueLib.Version = "1.0.0"

-- ════════════════════════════════════════════════════════════════════════
-- СЕРВИСЫ
-- ════════════════════════════════════════════════════════════════════════

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- ════════════════════════════════════════════════════════════════════════
-- ЦВЕТОВАЯ СХЕМА
-- ════════════════════════════════════════════════════════════════════════

local Theme = {
    Background = Color3.fromRGB(15, 15, 15),
    Secondary = Color3.fromRGB(25, 25, 25),
    Accent = Color3.fromRGB(200, 170, 130),
    AccentDark = Color3.fromRGB(160, 130, 100),
    Text = Color3.fromRGB(255, 255, 255),
    TextDark = Color3.fromRGB(180, 180, 180),
    Divider = Color3.fromRGB(60, 60, 60),
    Success = Color3.fromRGB(100, 200, 100),
    Error = Color3.fromRGB(200, 100, 100),
    Transparent = Color3.fromRGB(0, 0, 0)
}

-- ════════════════════════════════════════════════════════════════════════
-- УТИЛИТЫ
-- ════════════════════════════════════════════════════════════════════════

local function Create(className, properties)
    local instance = Instance.new(className)
    for prop, value in pairs(properties) do
        if prop ~= "Parent" then
            instance[prop] = value
        end
    end
    if properties.Parent then
        instance.Parent = properties.Parent
    end
    return instance
end

local function Tween(instance, properties, duration, style, direction)
    local tweenInfo = TweenInfo.new(
        duration or 0.2,
        style or Enum.EasingStyle.Quad,
        direction or Enum.EasingDirection.Out
    )
    local tween = TweenService:Create(instance, tweenInfo, properties)
    tween:Play()
    return tween
end

local function AddCorner(parent, radius)
    return Create("UICorner", {
        CornerRadius = UDim.new(0, radius or 6),
        Parent = parent
    })
end

local function AddStroke(parent, color, thickness)
    return Create("UIStroke", {
        Color = color or Theme.Divider,
        Thickness = thickness or 1,
        Parent = parent
    })
end

-- ════════════════════════════════════════════════════════════════════════
-- ФУНКЦИЯ СОЗДАНИЯ ОКНА
-- ════════════════════════════════════════════════════════════════════════

function VogueLib:CreateWindow(config)
    config = config or {}
    local windowTitle = config.Title or "VOGUE HUB"
    local windowSize = config.Size or UDim2.new(0, 550, 0, 400)
    
    local Window = {}
    Window.Tabs = {}
    Window.ActiveTab = nil
    
    -- ════════════════════════════════════════════════════════════════════
    -- SCREEN GUI
    -- ════════════════════════════════════════════════════════════════════
    
    local ScreenGui = Create("ScreenGui", {
        Name = "VogueHubUI",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent = CoreGui
    })
    
    -- ════════════════════════════════════════════════════════════════════
    -- ГЛАВНЫЙ ФРЕЙМ
    -- ════════════════════════════════════════════════════════════════════
    
    local MainFrame = Create("Frame", {
        Name = "MainFrame",
        Size = windowSize,
        Position = UDim2.new(0.5, -windowSize.X.Offset/2, 0.5, -windowSize.Y.Offset/2),
        BackgroundColor3 = Theme.Background,
        BorderSizePixel = 0,
        Parent = ScreenGui
    })
    AddCorner(MainFrame, 8)
    AddStroke(MainFrame, Theme.Divider, 1)
    
    -- Тень
    local Shadow = Create("ImageLabel", {
        Name = "Shadow",
        Size = UDim2.new(1, 30, 1, 30),
        Position = UDim2.new(0, -15, 0, -15),
        BackgroundTransparency = 1,
        Image = "rbxassetid://5554236805",
        ImageColor3 = Color3.fromRGB(0, 0, 0),
        ImageTransparency = 0.6,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(23, 23, 277, 277),
        ZIndex = -1,
        Parent = MainFrame
    })
    
    -- ════════════════════════════════════════════════════════════════════
    -- HEADER (ШАПКА)
    -- ════════════════════════════════════════════════════════════════════
    
    local Header = Create("Frame", {
        Name = "Header",
        Size = UDim2.new(1, 0, 0, 50),
        BackgroundColor3 = Theme.Background,
        BorderSizePixel = 0,
        Parent = MainFrame
    })
    AddCorner(Header, 8)
    
    -- Логотип
    local Logo = Create("TextLabel", {
        Name = "Logo",
        Size = UDim2.new(0, 150, 1, 0),
        Position = UDim2.new(0, 20, 0, 0),
        BackgroundTransparency = 1,
        Text = windowTitle,
        TextColor3 = Theme.Accent,
        TextSize = 18,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = Header
    })
    
    -- Разделитель
    local HeaderDivider = Create("Frame", {
        Name = "HeaderDivider",
        Size = UDim2.new(1, -40, 0, 1),
        Position = UDim2.new(0, 20, 1, -1),
        BackgroundColor3 = Theme.Divider,
        BorderSizePixel = 0,
        Parent = Header
    })
    
    -- Кнопка закрытия
    local CloseButton = Create("TextButton", {
        Name = "CloseButton",
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -40, 0, 10),
        BackgroundTransparency = 1,
        Text = "×",
        TextColor3 = Theme.TextDark,
        TextSize = 24,
        Font = Enum.Font.GothamBold,
        Parent = Header
    })
    
    CloseButton.MouseEnter:Connect(function()
        Tween(CloseButton, {TextColor3 = Theme.Error}, 0.2)
    end)
    
    CloseButton.MouseLeave:Connect(function()
        Tween(CloseButton, {TextColor3 = Theme.TextDark}, 0.2)
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        Tween(MainFrame, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}, 0.3)
        task.wait(0.3)
        ScreenGui:Destroy()
    end)
    
    -- Кнопка минимизации
    local MinimizeButton = Create("TextButton", {
        Name = "MinimizeButton",
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -70, 0, 10),
        BackgroundTransparency = 1,
        Text = "—",
        TextColor3 = Theme.TextDark,
        TextSize = 18,
        Font = Enum.Font.GothamBold,
        Parent = Header
    })
    
    local Minimized = false
    local OriginalSize = windowSize
    
    MinimizeButton.MouseEnter:Connect(function()
        Tween(MinimizeButton, {TextColor3 = Theme.Accent}, 0.2)
    end)
    
    MinimizeButton.MouseLeave:Connect(function()
        Tween(MinimizeButton, {TextColor3 = Theme.TextDark}, 0.2)
    end)
    
    MinimizeButton.MouseButton1Click:Connect(function()
        Minimized = not Minimized
        if Minimized then
            Tween(MainFrame, {Size = UDim2.new(0, windowSize.X.Offset, 0, 50)}, 0.3)
        else
            Tween(MainFrame, {Size = OriginalSize}, 0.3)
        end
    end)
    
    -- ════════════════════════════════════════════════════════════════════
    -- ПАНЕЛЬ ТАБОВ
    -- ════════════════════════════════════════════════════════════════════
    
    local TabBar = Create("Frame", {
        Name = "TabBar",
        Size = UDim2.new(1, -40, 0, 35),
        Position = UDim2.new(0, 20, 0, 55),
        BackgroundTransparency = 1,
        Parent = MainFrame
    })
    
    local TabList = Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        Padding = UDim.new(0, 5),
        Parent = TabBar
    })
    
    -- Разделитель
    local TabDivider = Create("Frame", {
        Name = "TabDivider",
        Size = UDim2.new(1, -40, 0, 1),
        Position = UDim2.new(0, 20, 0, 95),
        BackgroundColor3 = Theme.Divider,
        BorderSizePixel = 0,
        Parent = MainFrame
    })
    
    -- ════════════════════════════════════════════════════════════════════
    -- КОНТЕЙНЕР КОНТЕНТА
    -- ════════════════════════════════════════════════════════════════════
    
    local ContentContainer = Create("Frame", {
        Name = "ContentContainer",
        Size = UDim2.new(1, -40, 1, -115),
        Position = UDim2.new(0, 20, 0, 105),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Parent = MainFrame
    })
    
    -- ════════════════════════════════════════════════════════════════════
    -- ДРАГ ФУНКЦИОНАЛ
    -- ════════════════════════════════════════════════════════════════════
    
    local Dragging, DragInput, DragStart, StartPos
    
    Header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = true
            DragStart = input.Position
            StartPos = MainFrame.Position
        end
    end)
    
    Header.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local Delta = input.Position - DragStart
            MainFrame.Position = UDim2.new(
                StartPos.X.Scale, StartPos.X.Offset + Delta.X,
                StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y
            )
        end
    end)
    
    -- ════════════════════════════════════════════════════════════════════
    -- ФУНКЦИЯ СОЗДАНИЯ ТАБА
    -- ════════════════════════════════════════════════════════════════════
    
    function Window:CreateTab(tabConfig)
        tabConfig = tabConfig or {}
        local tabName = tabConfig.Name or "Tab"
        local tabIcon = tabConfig.Icon or ""
        
        local Tab = {}
        Tab.Elements = {}
        
        -- Кнопка таба
        local TabButton = Create("TextButton", {
            Name = tabName .. "Tab",
            Size = UDim2.new(0, 0, 1, 0),
            AutomaticSize = Enum.AutomaticSize.X,
            BackgroundTransparency = 1,
            Text = "",
            Parent = TabBar
        })
        
        local TabPadding = Create("UIPadding", {
            PaddingLeft = UDim.new(0, 15),
            PaddingRight = UDim.new(0, 15),
            Parent = TabButton
        })
        
        local TabLabel = Create("TextLabel", {
            Name = "Label",
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Text = string.upper(tabName),
            TextColor3 = Theme.TextDark,
            TextSize = 11,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Center,
            Parent = TabButton
        })
        
        -- Индикатор
        local TabIndicator = Create("Frame", {
            Name = "Indicator",
            Size = UDim2.new(1, 0, 0, 2),
            Position = UDim2.new(0, 0, 1, -2),
            BackgroundColor3 = Theme.Accent,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Parent = TabButton
        })
        AddCorner(TabIndicator, 1)
        
        -- Разделитель
        local TabSeparator = Create("TextLabel", {
            Name = "Separator",
            Size = UDim2.new(0, 10, 1, 0),
            BackgroundTransparency = 1,
            Text = "•",
            TextColor3 = Theme.Divider,
            TextSize = 10,
            Font = Enum.Font.Gotham,
            Parent = TabBar
        })
        
        -- Контент таба
        local TabContent = Create("ScrollingFrame", {
            Name = tabName .. "Content",
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 3,
            ScrollBarImageColor3 = Theme.Accent,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            Visible = false,
            Parent = ContentContainer
        })
        
        local ContentList = Create("UIListLayout", {
            Padding = UDim.new(0, 8),
            Parent = TabContent
        })
        
        local ContentPadding = Create("UIPadding", {
            PaddingTop = UDim.new(0, 5),
            PaddingRight = UDim.new(0, 5),
            Parent = TabContent
        })
        
        -- Авто-размер canvas
        ContentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentList.AbsoluteContentSize.Y + 10)
        end)
        
        -- Переключение табов
        local function ActivateTab()
            for _, tab in pairs(Window.Tabs) do
                tab.Content.Visible = false
                Tween(tab.Label, {TextColor3 = Theme.TextDark}, 0.2)
                Tween(tab.Indicator, {BackgroundTransparency = 1}, 0.2)
            end
            TabContent.Visible = true
            Tween(TabLabel, {TextColor3 = Theme.Text}, 0.2)
            Tween(TabIndicator, {BackgroundTransparency = 0}, 0.2)
            Window.ActiveTab = Tab
        end
        
        TabButton.MouseButton1Click:Connect(ActivateTab)
        
        TabButton.MouseEnter:Connect(function()
            if Window.ActiveTab ~= Tab then
                Tween(TabLabel, {TextColor3 = Theme.Accent}, 0.2)
            end
        end)
        
        TabButton.MouseLeave:Connect(function()
            if Window.ActiveTab ~= Tab then
                Tween(TabLabel, {TextColor3 = Theme.TextDark}, 0.2)
            end
        end)
        
        -- Сохраняем
        Tab.Button = TabButton
        Tab.Label = TabLabel
        Tab.Indicator = TabIndicator
        Tab.Content = TabContent
        table.insert(Window.Tabs, Tab)
        
        -- Активируем первый таб
        if #Window.Tabs == 1 then
            ActivateTab()
        end
        
        -- ════════════════════════════════════════════════════════════════
        -- СОЗДАНИЕ СЕКЦИИ
        -- ════════════════════════════════════════════════════════════════
        
        function Tab:CreateSection(sectionName)
            local Section = {}
            
            local SectionFrame = Create("Frame", {
                Name = sectionName .. "Section",
                Size = UDim2.new(1, -5, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundColor3 = Theme.Secondary,
                BorderSizePixel = 0,
                Parent = TabContent
            })
            AddCorner(SectionFrame, 6)
            AddStroke(SectionFrame, Theme.Divider, 1)
            
            local SectionPadding = Create("UIPadding", {
                PaddingTop = UDim.new(0, 12),
                PaddingBottom = UDim.new(0, 12),
                PaddingLeft = UDim.new(0, 15),
                PaddingRight = UDim.new(0, 15),
                Parent = SectionFrame
            })
            
            local SectionTitle = Create("TextLabel", {
                Name = "Title",
                Size = UDim2.new(1, 0, 0, 20),
                BackgroundTransparency = 1,
                Text = string.upper(sectionName),
                TextColor3 = Theme.Accent,
                TextSize = 11,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = SectionFrame
            })
            
            local SectionContent = Create("Frame", {
                Name = "Content",
                Size = UDim2.new(1, 0, 0, 0),
                Position = UDim2.new(0, 0, 0, 25),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Parent = SectionFrame
            })
            
            local SectionList = Create("UIListLayout", {
                Padding = UDim.new(0, 8),
                Parent = SectionContent
            })
            
            Section.Frame = SectionFrame
            Section.Content = SectionContent
            
            -- ════════════════════════════════════════════════════════════
            -- BUTTON
            -- ════════════════════════════════════════════════════════════
            
            function Section:CreateButton(buttonConfig)
                buttonConfig = buttonConfig or {}
                local buttonName = buttonConfig.Name or "Button"
                local callback = buttonConfig.Callback or function() end
                
                local ButtonFrame = Create("Frame", {
                    Name = buttonName,
                    Size = UDim2.new(1, 0, 0, 35),
                    BackgroundTransparency = 1,
                    Parent = SectionContent
                })
                
                local Button = Create("TextButton", {
                    Name = "Button",
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundColor3 = Theme.Background,
                    BorderSizePixel = 0,
                    Text = "",
                    Parent = ButtonFrame
                })
                AddCorner(Button, 4)
                AddStroke(Button, Theme.Divider, 1)
                
                local ButtonLabel = Create("TextLabel", {
                    Name = "Label",
                    Size = UDim2.new(1, -20, 1, 0),
                    Position = UDim2.new(0, 10, 0, 0),
                    BackgroundTransparency = 1,
                    Text = buttonName,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = Button
                })
                
                local ButtonArrow = Create("TextLabel", {
                    Name = "Arrow",
                    Size = UDim2.new(0, 20, 1, 0),
                    Position = UDim2.new(1, -25, 0, 0),
                    BackgroundTransparency = 1,
                    Text = ">",
                    TextColor3 = Theme.Accent,
                    TextSize = 14,
                    Font = Enum.Font.GothamBold,
                    Parent = Button
                })
                
                Button.MouseEnter:Connect(function()
                    Tween(Button, {BackgroundColor3 = Theme.Secondary}, 0.2)
                end)
                
                Button.MouseLeave:Connect(function()
                    Tween(Button, {BackgroundColor3 = Theme.Background}, 0.2)
                end)
                
                Button.MouseButton1Click:Connect(function()
                    Tween(Button, {BackgroundColor3 = Theme.Accent}, 0.1)
                    task.wait(0.1)
                    Tween(Button, {BackgroundColor3 = Theme.Background}, 0.2)
                    callback()
                end)
                
                return ButtonFrame
            end
            
            -- ════════════════════════════════════════════════════════════
            -- TOGGLE
            -- ════════════════════════════════════════════════════════════
            
            function Section:CreateToggle(toggleConfig)
                toggleConfig = toggleConfig or {}
                local toggleName = toggleConfig.Name or "Toggle"
                local default = toggleConfig.Default or false
                local callback = toggleConfig.Callback or function() end
                
                local Toggled = default
                
                local ToggleFrame = Create("Frame", {
                    Name = toggleName,
                    Size = UDim2.new(1, 0, 0, 35),
                    BackgroundColor3 = Theme.Background,
                    BorderSizePixel = 0,
                    Parent = SectionContent
                })
                AddCorner(ToggleFrame, 4)
                AddStroke(ToggleFrame, Theme.Divider, 1)
                
                local ToggleLabel = Create("TextLabel", {
                    Name = "Label",
                    Size = UDim2.new(1, -60, 1, 0),
                    Position = UDim2.new(0, 10, 0, 0),
                    BackgroundTransparency = 1,
                    Text = toggleName,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = ToggleFrame
                })
                
                local ToggleButton = Create("TextButton", {
                    Name = "Toggle",
                    Size = UDim2.new(0, 40, 0, 20),
                    Position = UDim2.new(1, -50, 0.5, -10),
                    BackgroundColor3 = Toggled and Theme.Accent or Theme.Background,
                    BorderSizePixel = 0,
                    Text = "",
                    Parent = ToggleFrame
                })
                AddCorner(ToggleButton, 10)
                AddStroke(ToggleButton, Toggled and Theme.Accent or Theme.Divider, 1)
                
                local ToggleCircle = Create("Frame", {
                    Name = "Circle",
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = Toggled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8),
                    BackgroundColor3 = Theme.Text,
                    BorderSizePixel = 0,
                    Parent = ToggleButton
                })
                AddCorner(ToggleCircle, 8)
                
                local function UpdateToggle()
                    if Toggled then
                        Tween(ToggleButton, {BackgroundColor3 = Theme.Accent}, 0.2)
                        Tween(ToggleCircle, {Position = UDim2.new(1, -18, 0.5, -8)}, 0.2)
                        ToggleButton:FindFirstChild("UIStroke").Color = Theme.Accent
                    else
                        Tween(ToggleButton, {BackgroundColor3 = Theme.Background}, 0.2)
                        Tween(ToggleCircle, {Position = UDim2.new(0, 2, 0.5, -8)}, 0.2)
                        ToggleButton:FindFirstChild("UIStroke").Color = Theme.Divider
                    end
                end
                
                ToggleButton.MouseButton1Click:Connect(function()
                    Toggled = not Toggled
                    UpdateToggle()
                    callback(Toggled)
                end)
                
                local ToggleAPI = {}
                function ToggleAPI:Set(value)
                    Toggled = value
                    UpdateToggle()
                    callback(Toggled)
                end
                function ToggleAPI:Get()
                    return Toggled
                end
                
                return ToggleAPI
            end
            
            -- ════════════════════════════════════════════════════════════
            -- SLIDER
            -- ════════════════════════════════════════════════════════════
            
            function Section:CreateSlider(sliderConfig)
                sliderConfig = sliderConfig or {}
                local sliderName = sliderConfig.Name or "Slider"
                local min = sliderConfig.Min or 0
                local max = sliderConfig.Max or 100
                local default = sliderConfig.Default or min
                local callback = sliderConfig.Callback or function() end
                
                local Value = default
                
                local SliderFrame = Create("Frame", {
                    Name = sliderName,
                    Size = UDim2.new(1, 0, 0, 50),
                    BackgroundColor3 = Theme.Background,
                    BorderSizePixel = 0,
                    Parent = SectionContent
                })
                AddCorner(SliderFrame, 4)
                AddStroke(SliderFrame, Theme.Divider, 1)
                
                local SliderLabel = Create("TextLabel", {
                    Name = "Label",
                    Size = UDim2.new(1, -60, 0, 20),
                    Position = UDim2.new(0, 10, 0, 5),
                    BackgroundTransparency = 1,
                    Text = sliderName,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = SliderFrame
                })
                
                local SliderValue = Create("TextLabel", {
                    Name = "Value",
                    Size = UDim2.new(0, 50, 0, 20),
                    Position = UDim2.new(1, -55, 0, 5),
                    BackgroundTransparency = 1,
                    Text = tostring(Value),
                    TextColor3 = Theme.Accent,
                    TextSize = 12,
                    Font = Enum.Font.GothamBold,
                    Parent = SliderFrame
                })
                
                local SliderBar = Create("Frame", {
                    Name = "Bar",
                    Size = UDim2.new(1, -20, 0, 6),
                    Position = UDim2.new(0, 10, 0, 32),
                    BackgroundColor3 = Theme.Secondary,
                    BorderSizePixel = 0,
                    Parent = SliderFrame
                })
                AddCorner(SliderBar, 3)
                
                local SliderFill = Create("Frame", {
                    Name = "Fill",
                    Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
                    BackgroundColor3 = Theme.Accent,
                    BorderSizePixel = 0,
                    Parent = SliderBar
                })
                AddCorner(SliderFill, 3)
                
                local SliderButton = Create("TextButton", {
                    Name = "Button",
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text = "",
                    Parent = SliderBar
                })
                
                local Dragging = false
                
                local function UpdateSlider(input)
                    local percent = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
                    Value = math.floor(min + (max - min) * percent)
                    SliderValue.Text = tostring(Value)
                    Tween(SliderFill, {Size = UDim2.new(percent, 0, 1, 0)}, 0.1)
                    callback(Value)
                end
                
                SliderButton.MouseButton1Down:Connect(function()
                    Dragging = true
                end)
                
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        Dragging = false
                    end
                end)
                
                UserInputService.InputChanged:Connect(function(input)
                    if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        UpdateSlider(input)
                    end
                end)
                
                SliderButton.MouseButton1Click:Connect(function()
                    UpdateSlider({Position = Vector3.new(Mouse.X, 0, 0)})
                end)
                
                local SliderAPI = {}
                function SliderAPI:Set(value)
                    Value = math.clamp(value, min, max)
                    local percent = (Value - min) / (max - min)
                    SliderValue.Text = tostring(Value)
                    Tween(SliderFill, {Size = UDim2.new(percent, 0, 1, 0)}, 0.1)
                    callback(Value)
                end
                function SliderAPI:Get()
                    return Value
                end
                
                return SliderAPI
            end
            
            -- ════════════════════════════════════════════════════════════
            -- DROPDOWN
            -- ════════════════════════════════════════════════════════════
            
            function Section:CreateDropdown(dropdownConfig)
                dropdownConfig = dropdownConfig or {}
                local dropdownName = dropdownConfig.Name or "Dropdown"
                local options = dropdownConfig.Options or {}
                local default = dropdownConfig.Default or (options[1] or "Select...")
                local callback = dropdownConfig.Callback or function() end
                
                local Selected = default
                local Opened = false
                
                local DropdownFrame = Create("Frame", {
                    Name = dropdownName,
                    Size = UDim2.new(1, 0, 0, 35),
                    BackgroundColor3 = Theme.Background,
                    BorderSizePixel = 0,
                    ClipsDescendants = true,
                    Parent = SectionContent
                })
                AddCorner(DropdownFrame, 4)
                AddStroke(DropdownFrame, Theme.Divider, 1)
                
                local DropdownHeader = Create("TextButton", {
                    Name = "Header",
                    Size = UDim2.new(1, 0, 0, 35),
                    BackgroundTransparency = 1,
                    Text = "",
                    Parent = DropdownFrame
                })
                
                local DropdownLabel = Create("TextLabel", {
                    Name = "Label",
                    Size = UDim2.new(0.5, -10, 1, 0),
                    Position = UDim2.new(0, 10, 0, 0),
                    BackgroundTransparency = 1,
                    Text = dropdownName,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = DropdownHeader
                })
                
                local DropdownSelected = Create("TextLabel", {
                    Name = "Selected",
                    Size = UDim2.new(0.5, -30, 1, 0),
                    Position = UDim2.new(0.5, 0, 0, 0),
                    BackgroundTransparency = 1,
                    Text = Selected,
                    TextColor3 = Theme.Accent,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Right,
                    Parent = DropdownHeader
                })
                
                local DropdownArrow = Create("TextLabel", {
                    Name = "Arrow",
                    Size = UDim2.new(0, 20, 1, 0),
                    Position = UDim2.new(1, -25, 0, 0),
                    BackgroundTransparency = 1,
                    Text = "▼",
                    TextColor3 = Theme.TextDark,
                    TextSize = 10,
                    Font = Enum.Font.Gotham,
                    Parent = DropdownHeader
                })
                
                local DropdownContent = Create("Frame", {
                    Name = "Content",
                    Size = UDim2.new(1, -10, 0, 0),
                    Position = UDim2.new(0, 5, 0, 40),
                    BackgroundTransparency = 1,
                    Parent = DropdownFrame
                })
                
                local DropdownList = Create("UIListLayout", {
                    Padding = UDim.new(0, 3),
                    Parent = DropdownContent
                })
                
                local function CreateOption(optionName)
                    local Option = Create("TextButton", {
                        Name = optionName,
                        Size = UDim2.new(1, 0, 0, 28),
                        BackgroundColor3 = Theme.Secondary,
                        BorderSizePixel = 0,
                        Text = optionName,
                        TextColor3 = Theme.Text,
                        TextSize = 11,
                        Font = Enum.Font.Gotham,
                        Parent = DropdownContent
                    })
                    AddCorner(Option, 4)
                    
                    Option.MouseEnter:Connect(function()
                        Tween(Option, {BackgroundColor3 = Theme.Accent}, 0.2)
                    end)
                    
                    Option.MouseLeave:Connect(function()
                        Tween(Option, {BackgroundColor3 = Theme.Secondary}, 0.2)
                    end)
                    
                    Option.MouseButton1Click:Connect(function()
                        Selected = optionName
                        DropdownSelected.Text = optionName
                        Opened = false
                        Tween(DropdownFrame, {Size = UDim2.new(1, 0, 0, 35)}, 0.2)
                        Tween(DropdownArrow, {Rotation = 0}, 0.2)
                        callback(optionName)
                    end)
                end
                
                for _, option in ipairs(options) do
                    CreateOption(option)
                end
                
                DropdownHeader.MouseButton1Click:Connect(function()
                    Opened = not Opened
                    if Opened then
                        local contentHeight = #options * 31 + 10
                        Tween(DropdownFrame, {Size = UDim2.new(1, 0, 0, 35 + contentHeight)}, 0.2)
                        Tween(DropdownArrow, {Rotation = 180}, 0.2)
                    else
                        Tween(DropdownFrame, {Size = UDim2.new(1, 0, 0, 35)}, 0.2)
                        Tween(DropdownArrow, {Rotation = 0}, 0.2)
                    end
                end)
                
                local DropdownAPI = {}
                function DropdownAPI:Set(value)
                    Selected = value
                    DropdownSelected.Text = value
                    callback(value)
                end
                function DropdownAPI:Get()
                    return Selected
                end
                function DropdownAPI:Refresh(newOptions)
                    for _, child in pairs(DropdownContent:GetChildren()) do
                        if child:IsA("TextButton") then
                            child:Destroy()
                        end
                    end
                    options = newOptions
                    for _, option in ipairs(options) do
                        CreateOption(option)
                    end
                end
                
                return DropdownAPI
            end
            
            -- ════════════════════════════════════════════════════════════
            -- TEXTBOX
            -- ════════════════════════════════════════════════════════════
            
            function Section:CreateTextBox(textboxConfig)
                textboxConfig = textboxConfig or {}
                local textboxName = textboxConfig.Name or "TextBox"
                local placeholder = textboxConfig.Placeholder or "Enter text..."
                local callback = textboxConfig.Callback or function() end
                
                local TextBoxFrame = Create("Frame", {
                    Name = textboxName,
                    Size = UDim2.new(1, 0, 0, 35),
                    BackgroundColor3 = Theme.Background,
                    BorderSizePixel = 0,
                    Parent = SectionContent
                })
                AddCorner(TextBoxFrame, 4)
                AddStroke(TextBoxFrame, Theme.Divider, 1)
                
                local TextBoxLabel = Create("TextLabel", {
                    Name = "Label",
                    Size = UDim2.new(0.4, -10, 1, 0),
                    Position = UDim2.new(0, 10, 0, 0),
                    BackgroundTransparency = 1,
                    Text = textboxName,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = TextBoxFrame
                })
                
                local TextBox = Create("TextBox", {
                    Name = "Input",
                    Size = UDim2.new(0.6, -15, 0, 25),
                    Position = UDim2.new(0.4, 0, 0.5, -12.5),
                    BackgroundColor3 = Theme.Secondary,
                    BorderSizePixel = 0,
                    Text = "",
                    PlaceholderText = placeholder,
                    PlaceholderColor3 = Theme.TextDark,
                    TextColor3 = Theme.Text,
                    TextSize = 11,
                    Font = Enum.Font.Gotham,
                    ClearTextOnFocus = false,
                    Parent = TextBoxFrame
                })
                AddCorner(TextBox, 4)
                
                local TextBoxPadding = Create("UIPadding", {
                    PaddingLeft = UDim.new(0, 8),
                    PaddingRight = UDim.new(0, 8),
                    Parent = TextBox
                })
                
                TextBox.Focused:Connect(function()
                    Tween(TextBox, {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}, 0.2)
                end)
                
                TextBox.FocusLost:Connect(function(enterPressed)
                    Tween(TextBox, {BackgroundColor3 = Theme.Secondary}, 0.2)
                    if enterPressed then
                        callback(TextBox.Text)
                    end
                end)
                
                local TextBoxAPI = {}
                function TextBoxAPI:Set(value)
                    TextBox.Text = value
                end
                function TextBoxAPI:Get()
                    return TextBox.Text
                end
                
                return TextBoxAPI
            end
            
            -- ════════════════════════════════════════════════════════════
            -- LABEL
            -- ════════════════════════════════════════════════════════════
            
            function Section:CreateLabel(labelText)
                local LabelFrame = Create("Frame", {
                    Name = "Label",
                    Size = UDim2.new(1, 0, 0, 25),
                    BackgroundTransparency = 1,
                    Parent = SectionContent
                })
                
                local Label = Create("TextLabel", {
                    Name = "Text",
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text = labelText or "Label",
                    TextColor3 = Theme.TextDark,
                    TextSize = 11,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = LabelFrame
                })
                
                local LabelAPI = {}
                function LabelAPI:Set(text)
                    Label.Text = text
                end
                
                return LabelAPI
            end
            
            -- ════════════════════════════════════════════════════════════
            -- KEYBIND
            -- ════════════════════════════════════════════════════════════
            
            function Section:CreateKeybind(keybindConfig)
                keybindConfig = keybindConfig or {}
                local keybindName = keybindConfig.Name or "Keybind"
                local default = keybindConfig.Default or Enum.KeyCode.Unknown
                local callback = keybindConfig.Callback or function() end
                
                local CurrentKey = default
                local Listening = false
                
                local KeybindFrame = Create("Frame", {
                    Name = keybindName,
                    Size = UDim2.new(1, 0, 0, 35),
                    BackgroundColor3 = Theme.Background,
                    BorderSizePixel = 0,
                    Parent = SectionContent
                })
                AddCorner(KeybindFrame, 4)
                AddStroke(KeybindFrame, Theme.Divider, 1)
                
                local KeybindLabel = Create("TextLabel", {
                    Name = "Label",
                    Size = UDim2.new(1, -80, 1, 0),
                    Position = UDim2.new(0, 10, 0, 0),
                    BackgroundTransparency = 1,
                    Text = keybindName,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = KeybindFrame
                })
                
                local KeybindButton = Create("TextButton", {
                    Name = "Button",
                    Size = UDim2.new(0, 60, 0, 25),
                    Position = UDim2.new(1, -70, 0.5, -12.5),
                    BackgroundColor3 = Theme.Secondary,
                    BorderSizePixel = 0,
                    Text = CurrentKey.Name or "...",
                    TextColor3 = Theme.Accent,
                    TextSize = 11,
                    Font = Enum.Font.GothamBold,
                    Parent = KeybindFrame
                })
                AddCorner(KeybindButton, 4)
                
                KeybindButton.MouseButton1Click:Connect(function()
                    Listening = true
                    KeybindButton.Text = "..."
                    Tween(KeybindButton, {BackgroundColor3 = Theme.Accent}, 0.2)
                    Tween(KeybindButton, {TextColor3 = Theme.Background}, 0.2)
                end)
                
                UserInputService.InputBegan:Connect(function(input, gameProcessed)
                    if Listening then
                        if input.UserInputType == Enum.UserInputType.Keyboard then
                            CurrentKey = input.KeyCode
                            KeybindButton.Text = CurrentKey.Name
                            Listening = false
                            Tween(KeybindButton, {BackgroundColor3 = Theme.Secondary}, 0.2)
                            Tween(KeybindButton, {TextColor3 = Theme.Accent}, 0.2)
                        end
                    elseif input.KeyCode == CurrentKey and not gameProcessed then
                        callback()
                    end
                end)
                
                local KeybindAPI = {}
                function KeybindAPI:Set(key)
                    CurrentKey = key
                    KeybindButton.Text = key.Name
                end
                function KeybindAPI:Get()
                    return CurrentKey
                end
                
                return KeybindAPI
            end
            
            return Section
        end
        
        return Tab
    end
    
    -- ════════════════════════════════════════════════════════════════════
    -- УВЕДОМЛЕНИЯ
    -- ════════════════════════════════════════════════════════════════════
    
    function Window:Notify(notifyConfig)
        notifyConfig = notifyConfig or {}
        local title = notifyConfig.Title or "Notification"
        local content = notifyConfig.Content or ""
        local duration = notifyConfig.Duration or 3
        
        local NotifyFrame = Create("Frame", {
            Name = "Notify",
            Size = UDim2.new(0, 280, 0, 0),
            Position = UDim2.new(1, -300, 1, -20),
            AnchorPoint = Vector2.new(0, 1),
            BackgroundColor3 = Theme.Background,
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.Y,
            Parent = ScreenGui
        })
        AddCorner(NotifyFrame, 6)
        AddStroke(NotifyFrame, Theme.Accent, 1)
        
        local NotifyPadding = Create("UIPadding", {
            PaddingTop = UDim.new(0, 12),
            PaddingBottom = UDim.new(0, 12),
            PaddingLeft = UDim.new(0, 15),
            PaddingRight = UDim.new(0, 15),
            Parent = NotifyFrame
        })
        
        local NotifyTitle = Create("TextLabel", {
            Name = "Title",
            Size = UDim2.new(1, 0, 0, 18),
            BackgroundTransparency = 1,
            Text = string.upper(title),
            TextColor3 = Theme.Accent,
            TextSize = 12,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = NotifyFrame
        })
        
        local NotifyContent = Create("TextLabel", {
            Name = "Content",
            Size = UDim2.new(1, 0, 0, 0),
            Position = UDim2.new(0, 0, 0, 22),
            BackgroundTransparency = 1,
            Text = content,
            TextColor3 = Theme.Text,
            TextSize = 11,
            Font = Enum.Font.Gotham,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
            AutomaticSize = Enum.AutomaticSize.Y,
            Parent = NotifyFrame
        })
        
        -- Анимация
        NotifyFrame.Position = UDim2.new(1, 20, 1, -20)
        Tween(NotifyFrame, {Position = UDim2.new(1, -300, 1, -20)}, 0.3, Enum.EasingStyle.Back)
        
        -- Авто-скрытие
        task.spawn(function()
            task.wait(duration)
            Tween(NotifyFrame, {Position = UDim2.new(1, 20, 1, -20)}, 0.3)
            task.wait(0.3)
            NotifyFrame:Destroy()
        end)
    end
    
    -- ════════════════════════════════════════════════════════════════════
    -- АНИМАЦИЯ ПОЯВЛЕНИЯ ОКНА
    -- ════════════════════════════════════════════════════════════════════
    
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    Tween(MainFrame, {
        Size = windowSize, 
        Position = UDim2.new(0.5, -windowSize.X.Offset/2, 0.5, -windowSize.Y.Offset/2)
    }, 0.4, Enum.EasingStyle.Back)
    
    return Window
end

-- ════════════════════════════════════════════════════════════════════════
-- ЭКСПОРТ МОДУЛЯ
-- ════════════════════════════════════════════════════════════════════════

return VogueLib
