--[[
    ╔══════════════════════════════════════════════════════════════════════╗
    ║                        VOGUE HUB UI LIBRARY                          ║
    ║                            Version 2.0.1                             ║
    ║                                                                      ║
    ║  Minimalist and elegant UI library for Roblox Luau                  ║
    ║                                                                      ║
    ║  GitHub: https://github.com/yourusername/vogue-hub-ui               ║
    ║  License: MIT                                                        ║
    ║  Author: Your Name                                                   ║
    ║                                                                      ║
    ║  Usage:                                                              ║
    ║  local Lib = loadstring(game:HttpGet("RAW_GITHUB_URL"))()           ║
    ║  local Window = Lib:CreateWindow({Title = "My Hub"})                ║
    ║                                                                      ║
    ╚══════════════════════════════════════════════════════════════════════╝
]]

-- ════════════════════════════════════════════════════════════════════════
-- MAIN MODULE
-- ════════════════════════════════════════════════════════════════════════

local VogueLib = {}
VogueLib.__index = VogueLib
VogueLib.Version = "2.0.1"
VogueLib.Themes = {}

-- ════════════════════════════════════════════════════════════════════════
-- SERVICES
-- ════════════════════════════════════════════════════════════════════════

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- ════════════════════════════════════════════════════════════════════════
-- THEME SYSTEM
-- ════════════════════════════════════════════════════════════════════════

VogueLib.Themes = {
    Dark = {
        Background = Color3.fromRGB(15, 15, 15),
        Secondary = Color3.fromRGB(25, 25, 25),
        Tertiary = Color3.fromRGB(35, 35, 35),
        Accent = Color3.fromRGB(200, 170, 130),
        AccentDark = Color3.fromRGB(160, 130, 100),
        AccentGlow = Color3.fromRGB(255, 220, 180),
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(180, 180, 180),
        TextMuted = Color3.fromRGB(120, 120, 120),
        Divider = Color3.fromRGB(60, 60, 60),
        Success = Color3.fromRGB(100, 200, 100),
        Error = Color3.fromRGB(200, 100, 100),
        Warning = Color3.fromRGB(200, 180, 100),
        GradientStart = Color3.fromRGB(200, 170, 130),
        GradientEnd = Color3.fromRGB(160, 130, 100)
    },
    Light = {
        Background = Color3.fromRGB(245, 245, 245),
        Secondary = Color3.fromRGB(235, 235, 235),
        Tertiary = Color3.fromRGB(225, 225, 225),
        Accent = Color3.fromRGB(180, 140, 100),
        AccentDark = Color3.fromRGB(140, 100, 70),
        AccentGlow = Color3.fromRGB(220, 180, 140),
        Text = Color3.fromRGB(30, 30, 30),
        TextDark = Color3.fromRGB(80, 80, 80),
        TextMuted = Color3.fromRGB(140, 140, 140),
        Divider = Color3.fromRGB(200, 200, 200),
        Success = Color3.fromRGB(80, 180, 80),
        Error = Color3.fromRGB(200, 80, 80),
        Warning = Color3.fromRGB(200, 160, 80),
        GradientStart = Color3.fromRGB(180, 140, 100),
        GradientEnd = Color3.fromRGB(140, 100, 70)
    },
    Ocean = {
        Background = Color3.fromRGB(15, 20, 30),
        Secondary = Color3.fromRGB(25, 35, 50),
        Tertiary = Color3.fromRGB(35, 50, 70),
        Accent = Color3.fromRGB(100, 180, 220),
        AccentDark = Color3.fromRGB(70, 140, 180),
        AccentGlow = Color3.fromRGB(150, 220, 255),
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(180, 190, 200),
        TextMuted = Color3.fromRGB(120, 140, 160),
        Divider = Color3.fromRGB(50, 70, 90),
        Success = Color3.fromRGB(100, 200, 150),
        Error = Color3.fromRGB(220, 100, 120),
        Warning = Color3.fromRGB(220, 180, 100),
        GradientStart = Color3.fromRGB(100, 180, 220),
        GradientEnd = Color3.fromRGB(70, 140, 180)
    },
    Purple = {
        Background = Color3.fromRGB(20, 15, 25),
        Secondary = Color3.fromRGB(35, 25, 45),
        Tertiary = Color3.fromRGB(50, 35, 65),
        Accent = Color3.fromRGB(180, 130, 220),
        AccentDark = Color3.fromRGB(140, 90, 180),
        AccentGlow = Color3.fromRGB(220, 180, 255),
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(190, 180, 200),
        TextMuted = Color3.fromRGB(140, 120, 160),
        Divider = Color3.fromRGB(70, 50, 90),
        Success = Color3.fromRGB(130, 200, 130),
        Error = Color3.fromRGB(220, 100, 130),
        Warning = Color3.fromRGB(220, 180, 100),
        GradientStart = Color3.fromRGB(180, 130, 220),
        GradientEnd = Color3.fromRGB(140, 90, 180)
    },
    Rose = {
        Background = Color3.fromRGB(25, 15, 20),
        Secondary = Color3.fromRGB(40, 25, 35),
        Tertiary = Color3.fromRGB(55, 35, 50),
        Accent = Color3.fromRGB(220, 130, 160),
        AccentDark = Color3.fromRGB(180, 90, 120),
        AccentGlow = Color3.fromRGB(255, 180, 200),
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(200, 180, 190),
        TextMuted = Color3.fromRGB(160, 120, 140),
        Divider = Color3.fromRGB(90, 50, 70),
        Success = Color3.fromRGB(130, 200, 150),
        Error = Color3.fromRGB(220, 100, 100),
        Warning = Color3.fromRGB(220, 180, 100),
        GradientStart = Color3.fromRGB(220, 130, 160),
        GradientEnd = Color3.fromRGB(180, 90, 120)
    }
}

VogueLib.CurrentTheme = "Dark"

-- ════════════════════════════════════════════════════════════════════════
-- UTILITIES
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

local function AddStroke(parent, color, thickness, transparency)
    return Create("UIStroke", {
        Color = color,
        Thickness = thickness or 1,
        Transparency = transparency or 0,
        Parent = parent
    })
end

local function AddGradient(parent, startColor, endColor, rotation)
    return Create("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, startColor),
            ColorSequenceKeypoint.new(1, endColor)
        }),
        Rotation = rotation or 45,
        Parent = parent
    })
end

-- ════════════════════════════════════════════════════════════════════════
-- THEME FUNCTIONS
-- ════════════════════════════════════════════════════════════════════════

function VogueLib:SetTheme(themeName)
    if VogueLib.Themes[themeName] then
        VogueLib.CurrentTheme = themeName
        return true
    end
    return false
end

function VogueLib:GetThemes()
    local themeNames = {}
    for name, _ in pairs(VogueLib.Themes) do
        table.insert(themeNames, name)
    end
    return themeNames
end

function VogueLib:CreateCustomTheme(name, colors)
    VogueLib.Themes[name] = colors
end

-- ════════════════════════════════════════════════════════════════════════
-- CREATE WINDOW FUNCTION
-- ════════════════════════════════════════════════════════════════════════

function VogueLib:CreateWindow(config)
    config = config or {}
    local windowTitle = config.Title or "VOGUE HUB"
    local windowSize = config.Size or UDim2.new(0, 550, 0, 400)
    local themeName = config.Theme or VogueLib.CurrentTheme or "Dark"
    
    -- Get theme colors
    local Theme = VogueLib.Themes[themeName] or VogueLib.Themes.Dark
    
    local Window = {}
    Window.Tabs = {}
    Window.ActiveTab = nil
    Window.Notifications = {}
    Window.Connections = {}
    Window.Theme = Theme
    
    -- Local utility functions that use the window's theme
    local function AddGlow(parent, color, size)
        local glow = Create("ImageLabel", {
            Name = "Glow",
            Size = UDim2.new(1, size or 20, 1, size or 20),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Image = "rbxassetid://5554236805",
            ImageColor3 = color or Theme.AccentGlow,
            ImageTransparency = 0.7,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(23, 23, 277, 277),
            ZIndex = parent.ZIndex - 1,
            Parent = parent
        })
        return glow
    end
    
    local function CreateRipple(parent, position)
        local ripple = Create("Frame", {
            Name = "Ripple",
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0, position.X - parent.AbsolutePosition.X, 0, position.Y - parent.AbsolutePosition.Y),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = Theme.Accent,
            BackgroundTransparency = 0.7,
            BorderSizePixel = 0,
            ZIndex = parent.ZIndex + 1,
            Parent = parent
        })
        AddCorner(ripple, 100)
        
        local maxSize = math.max(parent.AbsoluteSize.X, parent.AbsoluteSize.Y) * 2
        Tween(ripple, {
            Size = UDim2.new(0, maxSize, 0, maxSize),
            BackgroundTransparency = 1
        }, 0.5)
        
        task.delay(0.5, function()
            ripple:Destroy()
        end)
    end
    
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
    -- MAIN FRAME
    -- ════════════════════════════════════════════════════════════════════
    
    local MainFrame = Create("Frame", {
        Name = "MainFrame",
        Size = windowSize,
        Position = UDim2.new(0.5, -windowSize.X.Offset/2, 0.5, -windowSize.Y.Offset/2),
        BackgroundColor3 = Theme.Background,
        BorderSizePixel = 0,
        ClipsDescendants = false,
        Parent = ScreenGui
    })
    AddCorner(MainFrame, 10)
    AddStroke(MainFrame, Theme.Divider, 1)
    
    -- Shadow
    local Shadow = Create("ImageLabel", {
        Name = "Shadow",
        Size = UDim2.new(1, 40, 1, 40),
        Position = UDim2.new(0, -20, 0, -20),
        BackgroundTransparency = 1,
        Image = "rbxassetid://5554236805",
        ImageColor3 = Color3.fromRGB(0, 0, 0),
        ImageTransparency = 0.5,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(23, 23, 277, 277),
        ZIndex = -1,
        Parent = MainFrame
    })
    
    -- Accent line at top
    local AccentLine = Create("Frame", {
        Name = "AccentLine",
        Size = UDim2.new(1, -20, 0, 3),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundColor3 = Theme.Accent,
        BorderSizePixel = 0,
        Parent = MainFrame
    })
    AddCorner(AccentLine, 2)
    AddGradient(AccentLine, Theme.GradientStart, Theme.GradientEnd, 0)

    -- ════════════════════════════════════════════════════════════════════
    -- HEADER
    -- ════════════════════════════════════════════════════════════════════
    
    local Header = Create("Frame", {
        Name = "Header",
        Size = UDim2.new(1, 0, 0, 50),
        Position = UDim2.new(0, 0, 0, 3),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Parent = MainFrame
    })
    
    -- Logo
    local Logo = Create("TextLabel", {
        Name = "Logo",
        Size = UDim2.new(0, 200, 1, 0),
        Position = UDim2.new(0, 20, 0, 0),
        BackgroundTransparency = 1,
        Text = windowTitle,
        TextColor3 = Theme.Accent,
        TextSize = 18,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = Header
    })
    
    -- Header divider
    local HeaderDivider = Create("Frame", {
        Name = "HeaderDivider",
        Size = UDim2.new(1, -40, 0, 1),
        Position = UDim2.new(0, 20, 1, -1),
        BackgroundColor3 = Theme.Divider,
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0,
        Parent = Header
    })
    
    -- Close button
    local CloseButton = Create("TextButton", {
        Name = "CloseButton",
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -40, 0, 10),
        BackgroundColor3 = Theme.Error,
        BackgroundTransparency = 1,
        Text = "×",
        TextColor3 = Theme.TextDark,
        TextSize = 24,
        Font = Enum.Font.GothamBold,
        Parent = Header
    })
    AddCorner(CloseButton, 6)
    
    CloseButton.MouseEnter:Connect(function()
        Tween(CloseButton, {BackgroundTransparency = 0.8, TextColor3 = Theme.Error}, 0.2)
    end)
    
    CloseButton.MouseLeave:Connect(function()
        Tween(CloseButton, {BackgroundTransparency = 1, TextColor3 = Theme.TextDark}, 0.2)
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        for _, conn in pairs(Window.Connections) do
            if conn then conn:Disconnect() end
        end
        Tween(MainFrame, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}, 0.3)
        task.wait(0.3)
        ScreenGui:Destroy()
    end)
    
    -- Minimize button
    local MinimizeButton = Create("TextButton", {
        Name = "MinimizeButton",
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -75, 0, 10),
        BackgroundColor3 = Theme.Warning,
        BackgroundTransparency = 1,
        Text = "—",
        TextColor3 = Theme.TextDark,
        TextSize = 18,
        Font = Enum.Font.GothamBold,
        Parent = Header
    })
    AddCorner(MinimizeButton, 6)
    
    local Minimized = false
    local OriginalSize = windowSize
    
    MinimizeButton.MouseEnter:Connect(function()
        Tween(MinimizeButton, {BackgroundTransparency = 0.8, TextColor3 = Theme.Warning}, 0.2)
    end)
    
    MinimizeButton.MouseLeave:Connect(function()
        Tween(MinimizeButton, {BackgroundTransparency = 1, TextColor3 = Theme.TextDark}, 0.2)
    end)
    
    MinimizeButton.MouseButton1Click:Connect(function()
        Minimized = not Minimized
        if Minimized then
            Tween(MainFrame, {Size = UDim2.new(0, windowSize.X.Offset, 0, 53)}, 0.3, Enum.EasingStyle.Back)
        else
            Tween(MainFrame, {Size = OriginalSize}, 0.3, Enum.EasingStyle.Back)
        end
    end)
    
    -- ════════════════════════════════════════════════════════════════════
    -- TAB BAR
    -- ════════════════════════════════════════════════════════════════════
    
    local TabBar = Create("Frame", {
        Name = "TabBar",
        Size = UDim2.new(1, -40, 0, 35),
        Position = UDim2.new(0, 20, 0, 55),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Parent = MainFrame
    })
    
    local TabList = Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        Padding = UDim.new(0, 5),
        Parent = TabBar
    })
    
    -- Sliding indicator
    local TabIndicator = Create("Frame", {
        Name = "TabIndicator",
        Size = UDim2.new(0, 0, 0, 3),
        Position = UDim2.new(0, 0, 1, -3),
        BackgroundColor3 = Theme.Accent,
        BorderSizePixel = 0,
        ZIndex = 5,
        Parent = TabBar
    })
    AddCorner(TabIndicator, 2)
    AddGradient(TabIndicator, Theme.GradientStart, Theme.GradientEnd, 0)
    
    -- Tab divider
    local TabDivider = Create("Frame", {
        Name = "TabDivider",
        Size = UDim2.new(1, -40, 0, 1),
        Position = UDim2.new(0, 20, 0, 95),
        BackgroundColor3 = Theme.Divider,
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0,
        Parent = MainFrame
    })
    
    -- ════════════════════════════════════════════════════════════════════
    -- CONTENT CONTAINER
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
    -- DRAG FUNCTIONALITY
    -- ════════════════════════════════════════════════════════════════════
    
    local Dragging, DragStart, StartPos
    
    Header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            DragStart = input.Position
            StartPos = MainFrame.Position
        end
    end)
    
    Header.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = false
        end
    end)
    
    local dragConnection = UserInputService.InputChanged:Connect(function(input)
        if Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local Delta = input.Position - DragStart
            MainFrame.Position = UDim2.new(
                StartPos.X.Scale, StartPos.X.Offset + Delta.X,
                StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y
            )
        end
    end)
    table.insert(Window.Connections, dragConnection)
    
    -- ════════════════════════════════════════════════════════════════════
    -- UPDATE INDICATOR FUNCTION
    -- ════════════════════════════════════════════════════════════════════
    
    local function UpdateTabIndicator(tabButton)
        if tabButton then
            Tween(TabIndicator, {
                Size = UDim2.new(0, tabButton.AbsoluteSize.X, 0, 3),
                Position = UDim2.new(0, tabButton.AbsolutePosition.X - TabBar.AbsolutePosition.X, 1, -3)
            }, 0.3, Enum.EasingStyle.Quint)
        end
    end

    -- ════════════════════════════════════════════════════════════════════
    -- CREATE TAB FUNCTION
    -- ════════════════════════════════════════════════════════════════════
    
    function Window:CreateTab(tabConfig)
        tabConfig = tabConfig or {}
        local tabName = tabConfig.Name or "Tab"
        local tabIcon = tabConfig.Icon or ""
        
        local Tab = {}
        Tab.Elements = {}
        
        -- Tab button
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
        
        local displayText = tabIcon ~= "" and (tabIcon .. "  " .. string.upper(tabName)) or string.upper(tabName)
        
        local TabLabel = Create("TextLabel", {
            Name = "Label",
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Text = displayText,
            TextColor3 = Theme.TextDark,
            TextSize = 11,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Center,
            Parent = TabButton
        })
        
        -- Tab content
        local TabContent = Create("ScrollingFrame", {
            Name = tabName .. "Content",
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 4,
            ScrollBarImageColor3 = Theme.Accent,
            ScrollBarImageTransparency = 0.3,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            Visible = false,
            Parent = ContentContainer
        })
        
        local ContentList = Create("UIListLayout", {
            Padding = UDim.new(0, 10),
            Parent = TabContent
        })
        
        local ContentPadding = Create("UIPadding", {
            PaddingTop = UDim.new(0, 5),
            PaddingRight = UDim.new(0, 8),
            PaddingBottom = UDim.new(0, 5),
            Parent = TabContent
        })
        
        ContentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentList.AbsoluteContentSize.Y + 15)
        end)
        
        local function ActivateTab()
            for _, tab in pairs(Window.Tabs) do
                tab.Content.Visible = false
                Tween(tab.Label, {TextColor3 = Theme.TextDark}, 0.2)
            end
            TabContent.Visible = true
            Tween(TabLabel, {TextColor3 = Theme.Text}, 0.2)
            UpdateTabIndicator(TabButton)
            Window.ActiveTab = Tab
        end
        
        TabButton.MouseButton1Click:Connect(function()
            ActivateTab()
            CreateRipple(TabButton, Vector2.new(Mouse.X, Mouse.Y))
        end)
        
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
        
        Tab.Button = TabButton
        Tab.Label = TabLabel
        Tab.Content = TabContent
        table.insert(Window.Tabs, Tab)
        
        if #Window.Tabs == 1 then
            task.defer(ActivateTab)
        end
        
        -- ════════════════════════════════════════════════════════════════
        -- CREATE SECTION
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
            AddCorner(SectionFrame, 8)
            AddStroke(SectionFrame, Theme.Divider, 1, 0.5)
            
            local SectionPadding = Create("UIPadding", {
                PaddingTop = UDim.new(0, 14),
                PaddingBottom = UDim.new(0, 14),
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
            
            local SectionAccent = Create("Frame", {
                Name = "Accent",
                Size = UDim2.new(0, 3, 0, 14),
                Position = UDim2.new(0, -15, 0, 3),
                BackgroundColor3 = Theme.Accent,
                BorderSizePixel = 0,
                Parent = SectionTitle
            })
            AddCorner(SectionAccent, 2)
            
            local SectionContent = Create("Frame", {
                Name = "Content",
                Size = UDim2.new(1, 0, 0, 0),
                Position = UDim2.new(0, 0, 0, 28),
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
                local buttonIcon = buttonConfig.Icon or ""
                local callback = buttonConfig.Callback or function() end
                
                local ButtonFrame = Create("Frame", {
                    Name = buttonName,
                    Size = UDim2.new(1, 0, 0, 38),
                    BackgroundTransparency = 1,
                    Parent = SectionContent
                })
                
                local Button = Create("TextButton", {
                    Name = "Button",
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundColor3 = Theme.Background,
                    BorderSizePixel = 0,
                    Text = "",
                    ClipsDescendants = true,
                    Parent = ButtonFrame
                })
                AddCorner(Button, 6)
                AddStroke(Button, Theme.Divider, 1, 0.5)
                
                local displayText = buttonIcon ~= "" and (buttonIcon .. "  " .. buttonName) or buttonName
                
                local ButtonLabel = Create("TextLabel", {
                    Name = "Label",
                    Size = UDim2.new(1, -40, 1, 0),
                    Position = UDim2.new(0, 12, 0, 0),
                    BackgroundTransparency = 1,
                    Text = displayText,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = Button
                })
                
                local ButtonArrow = Create("TextLabel", {
                    Name = "Arrow",
                    Size = UDim2.new(0, 20, 1, 0),
                    Position = UDim2.new(1, -28, 0, 0),
                    BackgroundTransparency = 1,
                    Text = "→",
                    TextColor3 = Theme.Accent,
                    TextSize = 14,
                    Font = Enum.Font.GothamBold,
                    Parent = Button
                })
                
                Button.MouseEnter:Connect(function()
                    Tween(Button, {BackgroundColor3 = Theme.Tertiary}, 0.2)
                    Tween(ButtonArrow, {Position = UDim2.new(1, -24, 0, 0)}, 0.2)
                end)
                
                Button.MouseLeave:Connect(function()
                    Tween(Button, {BackgroundColor3 = Theme.Background}, 0.2)
                    Tween(ButtonArrow, {Position = UDim2.new(1, -28, 0, 0)}, 0.2)
                end)
                
                Button.MouseButton1Click:Connect(function()
                    CreateRipple(Button, Vector2.new(Mouse.X, Mouse.Y))
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
                local toggleIcon = toggleConfig.Icon or ""
                local default = toggleConfig.Default or false
                local callback = toggleConfig.Callback or function() end
                
                local Toggled = default
                
                local ToggleFrame = Create("Frame", {
                    Name = toggleName,
                    Size = UDim2.new(1, 0, 0, 38),
                    BackgroundColor3 = Theme.Background,
                    BorderSizePixel = 0,
                    Parent = SectionContent
                })
                AddCorner(ToggleFrame, 6)
                AddStroke(ToggleFrame, Theme.Divider, 1, 0.5)
                
                local displayText = toggleIcon ~= "" and (toggleIcon .. "  " .. toggleName) or toggleName
                
                local ToggleLabel = Create("TextLabel", {
                    Name = "Label",
                    Size = UDim2.new(1, -65, 1, 0),
                    Position = UDim2.new(0, 12, 0, 0),
                    BackgroundTransparency = 1,
                    Text = displayText,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = ToggleFrame
                })
                
                local ToggleButton = Create("TextButton", {
                    Name = "Toggle",
                    Size = UDim2.new(0, 44, 0, 22),
                    Position = UDim2.new(1, -54, 0.5, -11),
                    BackgroundColor3 = Toggled and Theme.Accent or Theme.Background,
                    BorderSizePixel = 0,
                    Text = "",
                    Parent = ToggleFrame
                })
                AddCorner(ToggleButton, 11)
                local toggleStroke = AddStroke(ToggleButton, Toggled and Theme.Accent or Theme.Divider, 1)
                
                local ToggleCircle = Create("Frame", {
                    Name = "Circle",
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = Toggled and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8),
                    BackgroundColor3 = Theme.Text,
                    BorderSizePixel = 0,
                    Parent = ToggleButton
                })
                AddCorner(ToggleCircle, 8)
                
                local function UpdateToggle()
                    if Toggled then
                        Tween(ToggleButton, {BackgroundColor3 = Theme.Accent}, 0.2)
                        Tween(ToggleCircle, {Position = UDim2.new(1, -19, 0.5, -8)}, 0.2, Enum.EasingStyle.Back)
                        Tween(toggleStroke, {Color = Theme.Accent}, 0.2)
                    else
                        Tween(ToggleButton, {BackgroundColor3 = Theme.Background}, 0.2)
                        Tween(ToggleCircle, {Position = UDim2.new(0, 3, 0.5, -8)}, 0.2, Enum.EasingStyle.Back)
                        Tween(toggleStroke, {Color = Theme.Divider}, 0.2)
                    end
                end
                
                ToggleButton.MouseButton1Click:Connect(function()
                    Toggled = not Toggled
                    UpdateToggle()
                    callback(Toggled)
                end)
                
                ToggleFrame.MouseEnter:Connect(function()
                    Tween(ToggleFrame, {BackgroundColor3 = Theme.Tertiary}, 0.2)
                end)
                
                ToggleFrame.MouseLeave:Connect(function()
                    Tween(ToggleFrame, {BackgroundColor3 = Theme.Background}, 0.2)
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
                local sliderIcon = sliderConfig.Icon or ""
                local min = sliderConfig.Min or 0
                local max = sliderConfig.Max or 100
                local default = sliderConfig.Default or min
                local increment = sliderConfig.Increment or 1
                local callback = sliderConfig.Callback or function() end
                
                local Value = default
                local SliderDragging = false
                
                local SliderFrame = Create("Frame", {
                    Name = sliderName,
                    Size = UDim2.new(1, 0, 0, 55),
                    BackgroundColor3 = Theme.Background,
                    BorderSizePixel = 0,
                    Parent = SectionContent
                })
                AddCorner(SliderFrame, 6)
                AddStroke(SliderFrame, Theme.Divider, 1, 0.5)
                
                local displayText = sliderIcon ~= "" and (sliderIcon .. "  " .. sliderName) or sliderName
                
                local SliderLabel = Create("TextLabel", {
                    Name = "Label",
                    Size = UDim2.new(1, -70, 0, 20),
                    Position = UDim2.new(0, 12, 0, 8),
                    BackgroundTransparency = 1,
                    Text = displayText,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = SliderFrame
                })
                
                local SliderValue = Create("TextLabel", {
                    Name = "Value",
                    Size = UDim2.new(0, 55, 0, 20),
                    Position = UDim2.new(1, -62, 0, 8),
                    BackgroundColor3 = Theme.Tertiary,
                    BackgroundTransparency = 0.5,
                    Text = tostring(Value),
                    TextColor3 = Theme.Accent,
                    TextSize = 11,
                    Font = Enum.Font.GothamBold,
                    Parent = SliderFrame
                })
                AddCorner(SliderValue, 4)
                
                local SliderBar = Create("Frame", {
                    Name = "Bar",
                    Size = UDim2.new(1, -24, 0, 8),
                    Position = UDim2.new(0, 12, 0, 36),
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0,
                    Parent = SliderFrame
                })
                AddCorner(SliderBar, 4)
                
                local SliderFill = Create("Frame", {
                    Name = "Fill",
                    Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
                    BackgroundColor3 = Theme.Accent,
                    BorderSizePixel = 0,
                    Parent = SliderBar
                })
                AddCorner(SliderFill, 4)
                AddGradient(SliderFill, Theme.GradientStart, Theme.GradientEnd, 0)
                
                local SliderKnob = Create("Frame", {
                    Name = "Knob",
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = UDim2.new((default - min) / (max - min), -8, 0.5, -8),
                    BackgroundColor3 = Theme.Text,
                    BorderSizePixel = 0,
                    ZIndex = 2,
                    Parent = SliderBar
                })
                AddCorner(SliderKnob, 8)
                AddStroke(SliderKnob, Theme.Accent, 2)
                
                local SliderButton = Create("TextButton", {
                    Name = "Button",
                    Size = UDim2.new(1, 0, 1, 10),
                    Position = UDim2.new(0, 0, 0, -5),
                    BackgroundTransparency = 1,
                    Text = "",
                    Parent = SliderBar
                })
                
                local function UpdateSlider(input)
                    local percent = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
                    local rawValue = min + (max - min) * percent
                    Value = math.floor(rawValue / increment + 0.5) * increment
                    Value = math.clamp(Value, min, max)
                    local displayPercent = (Value - min) / (max - min)
                    SliderValue.Text = tostring(Value)
                    Tween(SliderFill, {Size = UDim2.new(displayPercent, 0, 1, 0)}, 0.05)
                    Tween(SliderKnob, {Position = UDim2.new(displayPercent, -8, 0.5, -8)}, 0.05)
                    callback(Value)
                end
                
                SliderButton.MouseButton1Down:Connect(function()
                    SliderDragging = true
                    Tween(SliderKnob, {Size = UDim2.new(0, 20, 0, 20), Position = UDim2.new(SliderKnob.Position.X.Scale, -10, 0.5, -10)}, 0.1)
                end)
                
                local sliderInputEndConn = UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        if SliderDragging then
                            SliderDragging = false
                            local displayPercent = (Value - min) / (max - min)
                            Tween(SliderKnob, {Size = UDim2.new(0, 16, 0, 16), Position = UDim2.new(displayPercent, -8, 0.5, -8)}, 0.1)
                        end
                    end
                end)
                table.insert(Window.Connections, sliderInputEndConn)
                
                local sliderInputChangeConn = UserInputService.InputChanged:Connect(function(input)
                    if SliderDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        UpdateSlider(input)
                    end
                end)
                table.insert(Window.Connections, sliderInputChangeConn)
                
                SliderButton.MouseButton1Click:Connect(function()
                    UpdateSlider({Position = Vector3.new(Mouse.X, 0, 0)})
                end)
                
                SliderFrame.MouseEnter:Connect(function()
                    Tween(SliderFrame, {BackgroundColor3 = Theme.Tertiary}, 0.2)
                end)
                
                SliderFrame.MouseLeave:Connect(function()
                    Tween(SliderFrame, {BackgroundColor3 = Theme.Background}, 0.2)
                end)
                
                local SliderAPI = {}
                function SliderAPI:Set(value)
                    Value = math.clamp(value, min, max)
                    local percent = (Value - min) / (max - min)
                    SliderValue.Text = tostring(Value)
                    Tween(SliderFill, {Size = UDim2.new(percent, 0, 1, 0)}, 0.1)
                    Tween(SliderKnob, {Position = UDim2.new(percent, -8, 0.5, -8)}, 0.1)
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
                local dropdownIcon = dropdownConfig.Icon or ""
                local options = dropdownConfig.Options or {}
                local default = dropdownConfig.Default or (options[1] or "Select...")
                local callback = dropdownConfig.Callback or function() end
                
                local Selected = default
                local Opened = false
                local OptionHeight = 32
                local OptionPadding = 4
                
                local DropdownFrame = Create("Frame", {
                    Name = dropdownName,
                    Size = UDim2.new(1, 0, 0, 38),
                    BackgroundColor3 = Theme.Background,
                    BorderSizePixel = 0,
                    ClipsDescendants = true,
                    ZIndex = 2,
                    Parent = SectionContent
                })
                AddCorner(DropdownFrame, 6)
                AddStroke(DropdownFrame, Theme.Divider, 1, 0.5)
                
                local DropdownHeader = Create("TextButton", {
                    Name = "Header",
                    Size = UDim2.new(1, 0, 0, 38),
                    BackgroundTransparency = 1,
                    Text = "",
                    ZIndex = 2,
                    Parent = DropdownFrame
                })
                
                local displayText = dropdownIcon ~= "" and (dropdownIcon .. "  " .. dropdownName) or dropdownName
                
                local DropdownLabel = Create("TextLabel", {
                    Name = "Label",
                    Size = UDim2.new(0.5, -10, 1, 0),
                    Position = UDim2.new(0, 12, 0, 0),
                    BackgroundTransparency = 1,
                    Text = displayText,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 2,
                    Parent = DropdownHeader
                })
                
                local DropdownSelected = Create("TextLabel", {
                    Name = "Selected",
                    Size = UDim2.new(0.5, -35, 1, 0),
                    Position = UDim2.new(0.5, 0, 0, 0),
                    BackgroundTransparency = 1,
                    Text = Selected,
                    TextColor3 = Theme.Accent,
                    TextSize = 12,
                    Font = Enum.Font.GothamBold,
                    TextXAlignment = Enum.TextXAlignment.Right,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    ZIndex = 2,
                    Parent = DropdownHeader
                })
                
                local DropdownArrow = Create("TextLabel", {
                    Name = "Arrow",
                    Size = UDim2.new(0, 20, 1, 0),
                    Position = UDim2.new(1, -28, 0, 0),
                    BackgroundTransparency = 1,
                    Text = "▼",
                    TextColor3 = Theme.TextDark,
                    TextSize = 10,
                    Font = Enum.Font.Gotham,
                    ZIndex = 2,
                    Parent = DropdownHeader
                })
                
                local DropdownContent = Create("Frame", {
                    Name = "Content",
                    Size = UDim2.new(1, -16, 0, 0),
                    Position = UDim2.new(0, 8, 0, 44),
                    BackgroundTransparency = 1,
                    ZIndex = 2,
                    Parent = DropdownFrame
                })
                
                local DropdownList = Create("UIListLayout", {
                    Padding = UDim.new(0, OptionPadding),
                    Parent = DropdownContent
                })
                
                local function CreateOption(optionName)
                    local Option = Create("TextButton", {
                        Name = optionName,
                        Size = UDim2.new(1, 0, 0, OptionHeight),
                        BackgroundColor3 = Theme.Tertiary,
                        BorderSizePixel = 0,
                        Text = optionName,
                        TextColor3 = optionName == Selected and Theme.Accent or Theme.Text,
                        TextSize = 11,
                        Font = Enum.Font.Gotham,
                        ZIndex = 3,
                        Parent = DropdownContent
                    })
                    AddCorner(Option, 4)
                    
                    Option.MouseEnter:Connect(function()
                        Tween(Option, {BackgroundColor3 = Theme.Accent, TextColor3 = Theme.Background}, 0.2)
                    end)
                    
                    Option.MouseLeave:Connect(function()
                        local textColor = optionName == Selected and Theme.Accent or Theme.Text
                        Tween(Option, {BackgroundColor3 = Theme.Tertiary, TextColor3 = textColor}, 0.2)
                    end)
                    
                    Option.MouseButton1Click:Connect(function()
                        Selected = optionName
                        DropdownSelected.Text = optionName
                        Opened = false
                        Tween(DropdownFrame, {Size = UDim2.new(1, 0, 0, 38)}, 0.2, Enum.EasingStyle.Back)
                        Tween(DropdownArrow, {Rotation = 0}, 0.2)
                        
                        for _, child in pairs(DropdownContent:GetChildren()) do
                            if child:IsA("TextButton") then
                                child.TextColor3 = child.Name == Selected and Theme.Accent or Theme.Text
                            end
                        end
                        
                        callback(optionName)
                    end)
                    
                    return Option
                end
                
                for _, option in ipairs(options) do
                    CreateOption(option)
                end
                
                DropdownHeader.MouseButton1Click:Connect(function()
                    Opened = not Opened
                    if Opened then
                        local contentHeight = #options * (OptionHeight + OptionPadding) + 10
                        Tween(DropdownFrame, {Size = UDim2.new(1, 0, 0, 38 + contentHeight)}, 0.2, Enum.EasingStyle.Back)
                        Tween(DropdownArrow, {Rotation = 180}, 0.2)
                    else
                        Tween(DropdownFrame, {Size = UDim2.new(1, 0, 0, 38)}, 0.2, Enum.EasingStyle.Back)
                        Tween(DropdownArrow, {Rotation = 0}, 0.2)
                    end
                end)
                
                DropdownHeader.MouseEnter:Connect(function()
                    if not Opened then
                        Tween(DropdownFrame, {BackgroundColor3 = Theme.Tertiary}, 0.2)
                    end
                end)
                
                DropdownHeader.MouseLeave:Connect(function()
                    if not Opened then
                        Tween(DropdownFrame, {BackgroundColor3 = Theme.Background}, 0.2)
                    end
                end)
                
                local DropdownAPI = {}
                function DropdownAPI:Set(value)
                    Selected = value
                    DropdownSelected.Text = value
                    for _, child in pairs(DropdownContent:GetChildren()) do
                        if child:IsA("TextButton") then
                            child.TextColor3 = child.Name == Selected and Theme.Accent or Theme.Text
                        end
                    end
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
                    if Opened then
                        local contentHeight = #options * (OptionHeight + OptionPadding) + 10
                        DropdownFrame.Size = UDim2.new(1, 0, 0, 38 + contentHeight)
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
                local textboxIcon = textboxConfig.Icon or ""
                local placeholder = textboxConfig.Placeholder or "Enter text..."
                local default = textboxConfig.Default or ""
                local callback = textboxConfig.Callback or function() end
                
                local TextBoxFrame = Create("Frame", {
                    Name = textboxName,
                    Size = UDim2.new(1, 0, 0, 38),
                    BackgroundColor3 = Theme.Background,
                    BorderSizePixel = 0,
                    Parent = SectionContent
                })
                AddCorner(TextBoxFrame, 6)
                AddStroke(TextBoxFrame, Theme.Divider, 1, 0.5)
                
                local displayText = textboxIcon ~= "" and (textboxIcon .. "  " .. textboxName) or textboxName
                
                local TextBoxLabel = Create("TextLabel", {
                    Name = "Label",
                    Size = UDim2.new(0.4, -10, 1, 0),
                    Position = UDim2.new(0, 12, 0, 0),
                    BackgroundTransparency = 1,
                    Text = displayText,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = TextBoxFrame
                })
                
                local TextBox = Create("TextBox", {
                    Name = "Input",
                    Size = UDim2.new(0.6, -20, 0, 26),
                    Position = UDim2.new(0.4, 0, 0.5, -13),
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0,
                    Text = default,
                    PlaceholderText = placeholder,
                    PlaceholderColor3 = Theme.TextMuted,
                    TextColor3 = Theme.Text,
                    TextSize = 11,
                    Font = Enum.Font.Gotham,
                    ClearTextOnFocus = false,
                    Parent = TextBoxFrame
                })
                AddCorner(TextBox, 4)
                local textBoxStroke = AddStroke(TextBox, Theme.Divider, 1, 0.5)
                
                local TextBoxPadding = Create("UIPadding", {
                    PaddingLeft = UDim.new(0, 10),
                    PaddingRight = UDim.new(0, 10),
                    Parent = TextBox
                })
                
                TextBox.Focused:Connect(function()
                    Tween(TextBox, {BackgroundColor3 = Theme.Secondary}, 0.2)
                    Tween(textBoxStroke, {Color = Theme.Accent, Transparency = 0}, 0.2)
                end)
                
                TextBox.FocusLost:Connect(function(enterPressed)
                    Tween(TextBox, {BackgroundColor3 = Theme.Tertiary}, 0.2)
                    Tween(textBoxStroke, {Color = Theme.Divider, Transparency = 0.5}, 0.2)
                    if enterPressed then
                        callback(TextBox.Text)
                    end
                end)
                
                TextBoxFrame.MouseEnter:Connect(function()
                    Tween(TextBoxFrame, {BackgroundColor3 = Theme.Tertiary}, 0.2)
                end)
                
                TextBoxFrame.MouseLeave:Connect(function()
                    Tween(TextBoxFrame, {BackgroundColor3 = Theme.Background}, 0.2)
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
                    Size = UDim2.new(1, 0, 0, 28),
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
                    TextWrapped = true,
                    Parent = LabelFrame
                })
                
                local LabelAPI = {}
                function LabelAPI:Set(text)
                    Label.Text = text
                end
                function LabelAPI:Get()
                    return Label.Text
                end
                
                return LabelAPI
            end
            
            -- ════════════════════════════════════════════════════════════
            -- KEYBIND
            -- ════════════════════════════════════════════════════════════
            
            function Section:CreateKeybind(keybindConfig)
                keybindConfig = keybindConfig or {}
                local keybindName = keybindConfig.Name or "Keybind"
                local keybindIcon = keybindConfig.Icon or ""
                local default = keybindConfig.Default or Enum.KeyCode.Unknown
                local callback = keybindConfig.Callback or function() end
                
                local CurrentKey = default
                local Listening = false
                
                local KeybindFrame = Create("Frame", {
                    Name = keybindName,
                    Size = UDim2.new(1, 0, 0, 38),
                    BackgroundColor3 = Theme.Background,
                    BorderSizePixel = 0,
                    Parent = SectionContent
                })
                AddCorner(KeybindFrame, 6)
                AddStroke(KeybindFrame, Theme.Divider, 1, 0.5)
                
                local displayText = keybindIcon ~= "" and (keybindIcon .. "  " .. keybindName) or keybindName
                
                local KeybindLabel = Create("TextLabel", {
                    Name = "Label",
                    Size = UDim2.new(1, -85, 1, 0),
                    Position = UDim2.new(0, 12, 0, 0),
                    BackgroundTransparency = 1,
                    Text = displayText,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = KeybindFrame
                })
                
                local KeybindButton = Create("TextButton", {
                    Name = "Button",
                    Size = UDim2.new(0, 65, 0, 26),
                    Position = UDim2.new(1, -75, 0.5, -13),
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0,
                    Text = CurrentKey == Enum.KeyCode.Unknown and "None" or CurrentKey.Name,
                    TextColor3 = Theme.Accent,
                    TextSize = 10,
                    Font = Enum.Font.GothamBold,
                    Parent = KeybindFrame
                })
                AddCorner(KeybindButton, 4)
                local keybindStroke = AddStroke(KeybindButton, Theme.Divider, 1, 0.5)
                
                KeybindButton.MouseButton1Click:Connect(function()
                    Listening = true
                    KeybindButton.Text = "..."
                    Tween(KeybindButton, {BackgroundColor3 = Theme.Accent}, 0.2)
                    Tween(KeybindButton, {TextColor3 = Theme.Background}, 0.2)
                    Tween(keybindStroke, {Color = Theme.Accent}, 0.2)
                end)
                
                local keybindInputConn = UserInputService.InputBegan:Connect(function(input, gameProcessed)
                    if Listening then
                        if input.UserInputType == Enum.UserInputType.Keyboard then
                            if input.KeyCode == Enum.KeyCode.Escape then
                                CurrentKey = Enum.KeyCode.Unknown
                                KeybindButton.Text = "None"
                            else
                                CurrentKey = input.KeyCode
                                KeybindButton.Text = CurrentKey.Name
                            end
                            Listening = false
                            Tween(KeybindButton, {BackgroundColor3 = Theme.Tertiary}, 0.2)
                            Tween(KeybindButton, {TextColor3 = Theme.Accent}, 0.2)
                            Tween(keybindStroke, {Color = Theme.Divider}, 0.2)
                        end
                    elseif input.KeyCode == CurrentKey and not gameProcessed and CurrentKey ~= Enum.KeyCode.Unknown then
                        callback()
                    end
                end)
                table.insert(Window.Connections, keybindInputConn)
                
                KeybindFrame.MouseEnter:Connect(function()
                    Tween(KeybindFrame, {BackgroundColor3 = Theme.Tertiary}, 0.2)
                end)
                
                KeybindFrame.MouseLeave:Connect(function()
                    Tween(KeybindFrame, {BackgroundColor3 = Theme.Background}, 0.2)
                end)
                
                local KeybindAPI = {}
                function KeybindAPI:Set(key)
                    CurrentKey = key
                    KeybindButton.Text = key == Enum.KeyCode.Unknown and "None" or key.Name
                end
                function KeybindAPI:Get()
                    return CurrentKey
                end
                
                return KeybindAPI
            end
            
            -- ════════════════════════════════════════════════════════════
            -- SEPARATOR
            -- ════════════════════════════════════════════════════════════
            
            function Section:CreateSeparator()
                local SeparatorFrame = Create("Frame", {
                    Name = "Separator",
                    Size = UDim2.new(1, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Parent = SectionContent
                })
                
                local SeparatorLine = Create("Frame", {
                    Name = "Line",
                    Size = UDim2.new(1, 0, 0, 1),
                    Position = UDim2.new(0, 0, 0.5, 0),
                    BackgroundColor3 = Theme.Divider,
                    BackgroundTransparency = 0.5,
                    BorderSizePixel = 0,
                    Parent = SeparatorFrame
                })
                
                return SeparatorFrame
            end

            -- ════════════════════════════════════════════════════════════
            -- PROGRESS BAR
            -- ════════════════════════════════════════════════════════════
            
            function Section:CreateProgressBar(progressConfig)
                progressConfig = progressConfig or {}
                local progressName = progressConfig.Name or "Progress"
                local progressIcon = progressConfig.Icon or ""
                local default = progressConfig.Default or 0
                local max = progressConfig.Max or 100
                
                local Value = default
                
                local ProgressFrame = Create("Frame", {
                    Name = progressName,
                    Size = UDim2.new(1, 0, 0, 50),
                    BackgroundColor3 = Theme.Background,
                    BorderSizePixel = 0,
                    Parent = SectionContent
                })
                AddCorner(ProgressFrame, 6)
                AddStroke(ProgressFrame, Theme.Divider, 1, 0.5)
                
                local displayText = progressIcon ~= "" and (progressIcon .. "  " .. progressName) or progressName
                
                local ProgressLabel = Create("TextLabel", {
                    Name = "Label",
                    Size = UDim2.new(1, -60, 0, 20),
                    Position = UDim2.new(0, 12, 0, 8),
                    BackgroundTransparency = 1,
                    Text = displayText,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = ProgressFrame
                })
                
                local ProgressValue = Create("TextLabel", {
                    Name = "Value",
                    Size = UDim2.new(0, 50, 0, 20),
                    Position = UDim2.new(1, -58, 0, 8),
                    BackgroundTransparency = 1,
                    Text = tostring(math.floor(Value / max * 100)) .. "%",
                    TextColor3 = Theme.Accent,
                    TextSize = 11,
                    Font = Enum.Font.GothamBold,
                    TextXAlignment = Enum.TextXAlignment.Right,
                    Parent = ProgressFrame
                })
                
                local ProgressBar = Create("Frame", {
                    Name = "Bar",
                    Size = UDim2.new(1, -24, 0, 8),
                    Position = UDim2.new(0, 12, 0, 34),
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0,
                    Parent = ProgressFrame
                })
                AddCorner(ProgressBar, 4)
                
                local ProgressFill = Create("Frame", {
                    Name = "Fill",
                    Size = UDim2.new(Value / max, 0, 1, 0),
                    BackgroundColor3 = Theme.Accent,
                    BorderSizePixel = 0,
                    Parent = ProgressBar
                })
                AddCorner(ProgressFill, 4)
                AddGradient(ProgressFill, Theme.GradientStart, Theme.GradientEnd, 0)
                
                local ProgressAPI = {}
                function ProgressAPI:Set(value)
                    Value = math.clamp(value, 0, max)
                    local percent = Value / max
                    ProgressValue.Text = tostring(math.floor(percent * 100)) .. "%"
                    Tween(ProgressFill, {Size = UDim2.new(percent, 0, 1, 0)}, 0.3)
                end
                function ProgressAPI:Get()
                    return Value
                end
                function ProgressAPI:Increment(amount)
                    ProgressAPI:Set(Value + (amount or 1))
                end
                
                return ProgressAPI
            end
            
            -- ════════════════════════════════════════════════════════════
            -- IMAGE
            -- ════════════════════════════════════════════════════════════
            
            function Section:CreateImage(imageConfig)
                imageConfig = imageConfig or {}
                local imageName = imageConfig.Name or "Image"
                local imageId = imageConfig.Image or ""
                local imageSize = imageConfig.Size or UDim2.new(1, 0, 0, 100)
                
                local ImageFrame = Create("Frame", {
                    Name = imageName,
                    Size = UDim2.new(1, 0, 0, imageSize.Y.Offset + 10),
                    BackgroundColor3 = Theme.Background,
                    BorderSizePixel = 0,
                    Parent = SectionContent
                })
                AddCorner(ImageFrame, 6)
                AddStroke(ImageFrame, Theme.Divider, 1, 0.5)
                
                local Image = Create("ImageLabel", {
                    Name = "Image",
                    Size = UDim2.new(1, -20, 0, imageSize.Y.Offset),
                    Position = UDim2.new(0, 10, 0, 5),
                    BackgroundTransparency = 1,
                    Image = imageId,
                    ScaleType = Enum.ScaleType.Fit,
                    Parent = ImageFrame
                })
                AddCorner(Image, 4)
                
                local ImageAPI = {}
                function ImageAPI:Set(newImageId)
                    Image.Image = newImageId
                end
                function ImageAPI:Get()
                    return Image.Image
                end
                
                return ImageAPI
            end

            -- ════════════════════════════════════════════════════════════
            -- COLOR PICKER (FIXED)
            -- ════════════════════════════════════════════════════════════
            
            function Section:CreateColorPicker(colorConfig)
                colorConfig = colorConfig or {}
                local colorName = colorConfig.Name or "Color"
                local colorIcon = colorConfig.Icon or ""
                local default = colorConfig.Default or Color3.fromRGB(255, 255, 255)
                local callback = colorConfig.Callback or function() end
                
                local CurrentColor = default
                local Opened = false
                local H, S, V = Color3.toHSV(default)
                
                local ColorFrame = Create("Frame", {
                    Name = colorName,
                    Size = UDim2.new(1, 0, 0, 38),
                    BackgroundColor3 = Theme.Background,
                    BorderSizePixel = 0,
                    ClipsDescendants = true,
                    ZIndex = 3,
                    Parent = SectionContent
                })
                AddCorner(ColorFrame, 6)
                AddStroke(ColorFrame, Theme.Divider, 1, 0.5)
                
                local ColorHeader = Create("TextButton", {
                    Name = "Header",
                    Size = UDim2.new(1, 0, 0, 38),
                    BackgroundTransparency = 1,
                    Text = "",
                    ZIndex = 3,
                    Parent = ColorFrame
                })
                
                local displayText = colorIcon ~= "" and (colorIcon .. "  " .. colorName) or colorName
                
                local ColorLabel = Create("TextLabel", {
                    Name = "Label",
                    Size = UDim2.new(1, -60, 1, 0),
                    Position = UDim2.new(0, 12, 0, 0),
                    BackgroundTransparency = 1,
                    Text = displayText,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 3,
                    Parent = ColorHeader
                })
                
                local ColorPreview = Create("Frame", {
                    Name = "Preview",
                    Size = UDim2.new(0, 40, 0, 22),
                    Position = UDim2.new(1, -52, 0.5, -11),
                    BackgroundColor3 = CurrentColor,
                    BorderSizePixel = 0,
                    ZIndex = 3,
                    Parent = ColorHeader
                })
                AddCorner(ColorPreview, 4)
                AddStroke(ColorPreview, Theme.Divider, 1)
                
                -- Color picker content
                local ColorContent = Create("Frame", {
                    Name = "Content",
                    Size = UDim2.new(1, -16, 0, 130),
                    Position = UDim2.new(0, 8, 0, 44),
                    BackgroundTransparency = 1,
                    ZIndex = 3,
                    Parent = ColorFrame
                })
                
                -- Saturation/Value picker background (the hue color)
                local SVPicker = Create("Frame", {
                    Name = "SVPicker",
                    Size = UDim2.new(1, -40, 0, 100),
                    Position = UDim2.new(0, 0, 0, 0),
                    BackgroundColor3 = Color3.fromHSV(H, 1, 1),
                    BorderSizePixel = 0,
                    ZIndex = 4,
                    Parent = ColorContent
                })
                AddCorner(SVPicker, 4)
                
                -- White gradient (left to right)
                local WhiteOverlay = Create("Frame", {
                    Name = "WhiteOverlay",
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundColor3 = Color3.new(1, 1, 1),
                    BorderSizePixel = 0,
                    ZIndex = 5,
                    Parent = SVPicker
                })
                AddCorner(WhiteOverlay, 4)
                
                Create("UIGradient", {
                    Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 0),
                        NumberSequenceKeypoint.new(1, 1)
                    }),
                    Rotation = 0,
                    Parent = WhiteOverlay
                })
                
                -- Black gradient (top to bottom)
                local BlackOverlay = Create("Frame", {
                    Name = "BlackOverlay",
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundColor3 = Color3.new(0, 0, 0),
                    BorderSizePixel = 0,
                    ZIndex = 6,
                    Parent = SVPicker
                })
                AddCorner(BlackOverlay, 4)
                
                Create("UIGradient", {
                    Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 1),
                        NumberSequenceKeypoint.new(1, 0)
                    }),
                    Rotation = 90,
                    Parent = BlackOverlay
                })
                
                -- Clickable area for SV picker (on top of everything)
                local SVButton = Create("TextButton", {
                    Name = "SVButton",
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text = "",
                    ZIndex = 7,
                    Parent = SVPicker
                })
                
                -- SV Cursor
                local SVCursor = Create("Frame", {
                    Name = "Cursor",
                    Size = UDim2.new(0, 14, 0, 14),
                    Position = UDim2.new(S, -7, 1 - V, -7),
                    BackgroundColor3 = Color3.new(1, 1, 1),
                    BorderSizePixel = 0,
                    ZIndex = 8,
                    Parent = SVPicker
                })
                AddCorner(SVCursor, 7)
                AddStroke(SVCursor, Color3.new(0, 0, 0), 2)
                
                -- Hue slider
                local HueSlider = Create("Frame", {
                    Name = "HueSlider",
                    Size = UDim2.new(0, 25, 0, 100),
                    Position = UDim2.new(1, -25, 0, 0),
                    BackgroundColor3 = Color3.new(1, 1, 1),
                    BorderSizePixel = 0,
                    ZIndex = 4,
                    Parent = ColorContent
                })
                AddCorner(HueSlider, 4)
                
                Create("UIGradient", {
                    Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 1, 1)),
                        ColorSequenceKeypoint.new(0.167, Color3.fromHSV(0.167, 1, 1)),
                        ColorSequenceKeypoint.new(0.333, Color3.fromHSV(0.333, 1, 1)),
                        ColorSequenceKeypoint.new(0.5, Color3.fromHSV(0.5, 1, 1)),
                        ColorSequenceKeypoint.new(0.667, Color3.fromHSV(0.667, 1, 1)),
                        ColorSequenceKeypoint.new(0.833, Color3.fromHSV(0.833, 1, 1)),
                        ColorSequenceKeypoint.new(1, Color3.fromHSV(1, 1, 1))
                    }),
                    Rotation = 90,
                    Parent = HueSlider
                })
                
                -- Hue button
                local HueButton = Create("TextButton", {
                    Name = "HueButton",
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text = "",
                    ZIndex = 5,
                    Parent = HueSlider
                })
                
                -- Hue cursor
                local HueCursor = Create("Frame", {
                    Name = "Cursor",
                    Size = UDim2.new(1, 4, 0, 6),
                    Position = UDim2.new(0, -2, H, -3),
                    BackgroundColor3 = Color3.new(1, 1, 1),
                    BorderSizePixel = 0,
                    ZIndex = 6,
                    Parent = HueSlider
                })
                AddCorner(HueCursor, 2)
                AddStroke(HueCursor, Color3.new(0, 0, 0), 1)
                
                -- RGB display
                local RGBLabel = Create("TextLabel", {
                    Name = "RGB",
                    Size = UDim2.new(1, -40, 0, 20),
                    Position = UDim2.new(0, 0, 0, 108),
                    BackgroundTransparency = 1,
                    Text = string.format("RGB: %d, %d, %d", math.floor(CurrentColor.R * 255), math.floor(CurrentColor.G * 255), math.floor(CurrentColor.B * 255)),
                    TextColor3 = Theme.TextDark,
                    TextSize = 10,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 4,
                    Parent = ColorContent
                })
                
                local SVDragging = false
                local HueDragging = false
                
                local function UpdateColor()
                    CurrentColor = Color3.fromHSV(H, S, V)
                    ColorPreview.BackgroundColor3 = CurrentColor
                    SVPicker.BackgroundColor3 = Color3.fromHSV(H, 1, 1)
                    SVCursor.Position = UDim2.new(S, -7, 1 - V, -7)
                    HueCursor.Position = UDim2.new(0, -2, H, -3)
                    RGBLabel.Text = string.format("RGB: %d, %d, %d", math.floor(CurrentColor.R * 255), math.floor(CurrentColor.G * 255), math.floor(CurrentColor.B * 255))
                    callback(CurrentColor)
                end
                
                local function UpdateSV(input)
                    local relX = math.clamp((input.Position.X - SVPicker.AbsolutePosition.X) / SVPicker.AbsoluteSize.X, 0, 1)
                    local relY = math.clamp((input.Position.Y - SVPicker.AbsolutePosition.Y) / SVPicker.AbsoluteSize.Y, 0, 1)
                    S = relX
                    V = 1 - relY
                    UpdateColor()
                end
                
                local function UpdateHue(input)
                    local relY = math.clamp((input.Position.Y - HueSlider.AbsolutePosition.Y) / HueSlider.AbsoluteSize.Y, 0, 1)
                    H = relY
                    UpdateColor()
                end
                
                SVButton.MouseButton1Down:Connect(function()
                    SVDragging = true
                    UpdateSV({Position = Vector3.new(Mouse.X, Mouse.Y, 0)})
                end)
                
                HueButton.MouseButton1Down:Connect(function()
                    HueDragging = true
                    UpdateHue({Position = Vector3.new(Mouse.X, Mouse.Y, 0)})
                end)
                
                local colorInputEndConn = UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        SVDragging = false
                        HueDragging = false
                    end
                end)
                table.insert(Window.Connections, colorInputEndConn)
                
                local colorInputChangeConn = UserInputService.InputChanged:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        if SVDragging then
                            UpdateSV(input)
                        elseif HueDragging then
                            UpdateHue(input)
                        end
                    end
                end)
                table.insert(Window.Connections, colorInputChangeConn)
                
                ColorHeader.MouseButton1Click:Connect(function()
                    Opened = not Opened
                    if Opened then
                        Tween(ColorFrame, {Size = UDim2.new(1, 0, 0, 185)}, 0.2, Enum.EasingStyle.Back)
                    else
                        Tween(ColorFrame, {Size = UDim2.new(1, 0, 0, 38)}, 0.2, Enum.EasingStyle.Back)
                    end
                end)
                
                ColorHeader.MouseEnter:Connect(function()
                    if not Opened then
                        Tween(ColorFrame, {BackgroundColor3 = Theme.Tertiary}, 0.2)
                    end
                end)
                
                ColorHeader.MouseLeave:Connect(function()
                    if not Opened then
                        Tween(ColorFrame, {BackgroundColor3 = Theme.Background}, 0.2)
                    end
                end)
                
                local ColorAPI = {}
                function ColorAPI:Set(color)
                    CurrentColor = color
                    H, S, V = Color3.toHSV(color)
                    UpdateColor()
                end
                function ColorAPI:Get()
                    return CurrentColor
                end
                
                return ColorAPI
            end
            
            return Section
        end
        
        return Tab
    end

    -- ════════════════════════════════════════════════════════════════════
    -- NOTIFICATIONS (with stacking support)
    -- ════════════════════════════════════════════════════════════════════
    
    function Window:Notify(notifyConfig)
        notifyConfig = notifyConfig or {}
        local title = notifyConfig.Title or "Notification"
        local content = notifyConfig.Content or ""
        local duration = notifyConfig.Duration or 3
        local notifyType = notifyConfig.Type or "info"
        
        local typeColors = {
            info = Theme.Accent,
            success = Theme.Success,
            error = Theme.Error,
            warning = Theme.Warning
        }
        local accentColor = typeColors[notifyType] or Theme.Accent
        
        local notifyIndex = #Window.Notifications + 1
        local yOffset = 20 + (notifyIndex - 1) * 90
        
        local NotifyFrame = Create("Frame", {
            Name = "Notify" .. notifyIndex,
            Size = UDim2.new(0, 300, 0, 0),
            Position = UDim2.new(1, 20, 1, -yOffset),
            AnchorPoint = Vector2.new(0, 1),
            BackgroundColor3 = Theme.Background,
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.Y,
            ClipsDescendants = true,
            Parent = ScreenGui
        })
        AddCorner(NotifyFrame, 8)
        AddStroke(NotifyFrame, accentColor, 1, 0.3)
        
        local NotifyShadow = Create("ImageLabel", {
            Name = "Shadow",
            Size = UDim2.new(1, 20, 1, 20),
            Position = UDim2.new(0, -10, 0, -10),
            BackgroundTransparency = 1,
            Image = "rbxassetid://5554236805",
            ImageColor3 = Color3.fromRGB(0, 0, 0),
            ImageTransparency = 0.6,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(23, 23, 277, 277),
            ZIndex = -1,
            Parent = NotifyFrame
        })
        
        local NotifyAccent = Create("Frame", {
            Name = "Accent",
            Size = UDim2.new(0, 4, 1, -16),
            Position = UDim2.new(0, 8, 0, 8),
            BackgroundColor3 = accentColor,
            BorderSizePixel = 0,
            Parent = NotifyFrame
        })
        AddCorner(NotifyAccent, 2)
        
        local NotifyPadding = Create("UIPadding", {
            PaddingTop = UDim.new(0, 12),
            PaddingBottom = UDim.new(0, 12),
            PaddingLeft = UDim.new(0, 20),
            PaddingRight = UDim.new(0, 15),
            Parent = NotifyFrame
        })
        
        local icons = {
            info = "ℹ",
            success = "✓",
            error = "✕",
            warning = "⚠"
        }
        
        local NotifyIcon = Create("TextLabel", {
            Name = "Icon",
            Size = UDim2.new(0, 20, 0, 20),
            Position = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1,
            Text = icons[notifyType] or "ℹ",
            TextColor3 = accentColor,
            TextSize = 14,
            Font = Enum.Font.GothamBold,
            Parent = NotifyFrame
        })
        
        local NotifyTitle = Create("TextLabel", {
            Name = "Title",
            Size = UDim2.new(1, -30, 0, 18),
            Position = UDim2.new(0, 25, 0, 0),
            BackgroundTransparency = 1,
            Text = string.upper(title),
            TextColor3 = accentColor,
            TextSize = 11,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = NotifyFrame
        })
        
        local NotifyContent = Create("TextLabel", {
            Name = "Content",
            Size = UDim2.new(1, -30, 0, 0),
            Position = UDim2.new(0, 25, 0, 22),
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
        
        local NotifyProgress = Create("Frame", {
            Name = "Progress",
            Size = UDim2.new(1, 0, 0, 3),
            Position = UDim2.new(0, 0, 1, 0),
            AnchorPoint = Vector2.new(0, 1),
            BackgroundColor3 = Theme.Tertiary,
            BorderSizePixel = 0,
            Parent = NotifyFrame
        })
        
        local NotifyProgressFill = Create("Frame", {
            Name = "Fill",
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundColor3 = accentColor,
            BorderSizePixel = 0,
            Parent = NotifyProgress
        })
        AddGradient(NotifyProgressFill, accentColor, Theme.AccentDark, 0)
        
        table.insert(Window.Notifications, NotifyFrame)
        
        NotifyFrame.Position = UDim2.new(1, 20, 1, -yOffset)
        Tween(NotifyFrame, {Position = UDim2.new(1, -320, 1, -yOffset)}, 0.4, Enum.EasingStyle.Back)
        Tween(NotifyProgressFill, {Size = UDim2.new(0, 0, 1, 0)}, duration, Enum.EasingStyle.Linear)
        
        task.spawn(function()
            task.wait(duration)
            Tween(NotifyFrame, {Position = UDim2.new(1, 20, 1, -yOffset)}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
            task.wait(0.3)
            
            local index = table.find(Window.Notifications, NotifyFrame)
            if index then
                table.remove(Window.Notifications, index)
                for i, notif in ipairs(Window.Notifications) do
                    local newYOffset = 20 + (i - 1) * 90
                    Tween(notif, {Position = UDim2.new(1, -320, 1, -newYOffset)}, 0.2)
                end
            end
            
            NotifyFrame:Destroy()
        end)
    end
    
    -- ════════════════════════════════════════════════════════════════════
    -- WINDOW METHODS
    -- ════════════════════════════════════════════════════════════════════
    
    local WindowVisible = true
    
    function Window:Toggle()
        WindowVisible = not WindowVisible
        if WindowVisible then
            MainFrame.Visible = true
            Tween(MainFrame, {
                Size = windowSize,
                Position = UDim2.new(0.5, -windowSize.X.Offset/2, 0.5, -windowSize.Y.Offset/2)
            }, 0.3, Enum.EasingStyle.Back)
        else
            Tween(MainFrame, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}, 0.3)
            task.wait(0.3)
            MainFrame.Visible = false
        end
    end
    
    function Window:Show()
        if not WindowVisible then
            Window:Toggle()
        end
    end
    
    function Window:Hide()
        if WindowVisible then
            Window:Toggle()
        end
    end
    
    function Window:Destroy()
        for _, conn in pairs(Window.Connections) do
            if conn then conn:Disconnect() end
        end
        ScreenGui:Destroy()
    end
    
    -- ════════════════════════════════════════════════════════════════════
    -- WINDOW APPEARANCE ANIMATION
    -- ════════════════════════════════════════════════════════════════════
    
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    Tween(MainFrame, {
        Size = windowSize, 
        Position = UDim2.new(0.5, -windowSize.X.Offset/2, 0.5, -windowSize.Y.Offset/2)
    }, 0.5, Enum.EasingStyle.Back)
    
    return Window
end

-- ════════════════════════════════════════════════════════════════════════
-- MODULE EXPORT
-- ════════════════════════════════════════════════════════════════════════

return VogueLib
