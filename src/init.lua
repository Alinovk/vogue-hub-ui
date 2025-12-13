--[[
    ╔══════════════════════════════════════════════════════════════════════╗
    ║                        VOGUE HUB UI LIBRARY                          ║
    ║                            Version 2.1.0                             ║
    ║                                                                      ║
    ║  Minimalist and elegant UI library for Roblox Luau                  ║
    ║                                                                      ║
    ║  GitHub: https://github.com/yourusername/vogue-hub-ui               ║
    ║  License: MIT                                                        ║
    ║                                                                      ║
    ║  Usage:                                                              ║
    ║  local Lib = loadstring(game:HttpGet("RAW_GITHUB_URL"))()           ║
    ║  local Window = Lib:CreateWindow({Title = "My Hub"})                ║
    ║                                                                      ║
    ╚══════════════════════════════════════════════════════════════════════╝
]]

local VogueLib = {}
VogueLib.__index = VogueLib
VogueLib.Version = "2.1.0"

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Theme Definitions
local Themes = {
    Dark = {
        Background = Color3.fromRGB(15, 15, 15),
        Secondary = Color3.fromRGB(25, 25, 25),
        Tertiary = Color3.fromRGB(35, 35, 35),
        Accent = Color3.fromRGB(200, 170, 130),
        AccentDark = Color3.fromRGB(160, 130, 100),
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(180, 180, 180),
        TextMuted = Color3.fromRGB(120, 120, 120),
        Divider = Color3.fromRGB(60, 60, 60),
        Success = Color3.fromRGB(100, 200, 100),
        Error = Color3.fromRGB(200, 100, 100),
        Warning = Color3.fromRGB(200, 180, 100)
    },
    Light = {
        Background = Color3.fromRGB(245, 245, 245),
        Secondary = Color3.fromRGB(235, 235, 235),
        Tertiary = Color3.fromRGB(220, 220, 220),
        Accent = Color3.fromRGB(180, 140, 100),
        AccentDark = Color3.fromRGB(140, 100, 70),
        Text = Color3.fromRGB(30, 30, 30),
        TextDark = Color3.fromRGB(80, 80, 80),
        TextMuted = Color3.fromRGB(140, 140, 140),
        Divider = Color3.fromRGB(200, 200, 200),
        Success = Color3.fromRGB(80, 180, 80),
        Error = Color3.fromRGB(200, 80, 80),
        Warning = Color3.fromRGB(200, 160, 80)
    },
    Ocean = {
        Background = Color3.fromRGB(15, 20, 30),
        Secondary = Color3.fromRGB(25, 35, 50),
        Tertiary = Color3.fromRGB(35, 50, 70),
        Accent = Color3.fromRGB(100, 180, 220),
        AccentDark = Color3.fromRGB(70, 140, 180),
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(180, 190, 200),
        TextMuted = Color3.fromRGB(120, 140, 160),
        Divider = Color3.fromRGB(50, 70, 90),
        Success = Color3.fromRGB(100, 200, 150),
        Error = Color3.fromRGB(220, 100, 120),
        Warning = Color3.fromRGB(220, 180, 100)
    },
    Purple = {
        Background = Color3.fromRGB(20, 15, 25),
        Secondary = Color3.fromRGB(35, 25, 45),
        Tertiary = Color3.fromRGB(50, 35, 65),
        Accent = Color3.fromRGB(180, 130, 220),
        AccentDark = Color3.fromRGB(140, 90, 180),
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(190, 180, 200),
        TextMuted = Color3.fromRGB(140, 120, 160),
        Divider = Color3.fromRGB(70, 50, 90),
        Success = Color3.fromRGB(130, 200, 130),
        Error = Color3.fromRGB(220, 100, 130),
        Warning = Color3.fromRGB(220, 180, 100)
    },
    Rose = {
        Background = Color3.fromRGB(25, 15, 20),
        Secondary = Color3.fromRGB(40, 25, 35),
        Tertiary = Color3.fromRGB(55, 35, 50),
        Accent = Color3.fromRGB(220, 130, 160),
        AccentDark = Color3.fromRGB(180, 90, 120),
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(200, 180, 190),
        TextMuted = Color3.fromRGB(160, 120, 140),
        Divider = Color3.fromRGB(90, 50, 70),
        Success = Color3.fromRGB(130, 200, 150),
        Error = Color3.fromRGB(220, 100, 100),
        Warning = Color3.fromRGB(220, 180, 100)
    }
}

-- Utility Functions
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
    local tween = TweenService:Create(
        instance,
        TweenInfo.new(duration or 0.2, style or Enum.EasingStyle.Quad, direction or Enum.EasingDirection.Out),
        properties
    )
    tween:Play()
    return tween
end

local function AddCorner(parent, radius)
    return Create("UICorner", {CornerRadius = UDim.new(0, radius or 6), Parent = parent})
end

local function AddStroke(parent, color, thickness)
    return Create("UIStroke", {Color = color, Thickness = thickness or 1, Parent = parent})
end

local function AddPadding(parent, top, bottom, left, right)
    return Create("UIPadding", {
        PaddingTop = UDim.new(0, top or 0),
        PaddingBottom = UDim.new(0, bottom or 0),
        PaddingLeft = UDim.new(0, left or 0),
        PaddingRight = UDim.new(0, right or 0),
        Parent = parent
    })
end

-- Library Functions
function VogueLib:GetThemes()
    local names = {}
    for name in pairs(Themes) do
        table.insert(names, name)
    end
    return names
end

function VogueLib:AddTheme(name, colors)
    Themes[name] = colors
end

-- ════════════════════════════════════════════════════════════════════════
-- CREATE WINDOW
-- ════════════════════════════════════════════════════════════════════════

function VogueLib:CreateWindow(config)
    config = config or {}
    local windowTitle = config.Title or "VOGUE HUB"
    local windowSize = config.Size or UDim2.new(0, 550, 0, 400)
    local themeName = config.Theme or "Dark"
    
    local Theme = Themes[themeName] or Themes.Dark
    
    local Window = {
        Tabs = {},
        ActiveTab = nil,
        Notifications = {},
        Connections = {},
        ThemeObjects = {} -- Store objects that need theme updates
    }
    
    -- Function to update theme dynamically
    function Window:SetTheme(newThemeName)
        local newTheme = Themes[newThemeName]
        if not newTheme then return false end
        
        Theme = newTheme
        
        -- Update all stored theme objects
        for _, obj in pairs(self.ThemeObjects) do
            if obj.Instance and obj.Instance.Parent then
                if obj.Property and obj.ThemeKey then
                    obj.Instance[obj.Property] = Theme[obj.ThemeKey]
                end
            end
        end
        
        return true
    end
    
    local function RegisterThemeObject(instance, property, themeKey)
        table.insert(Window.ThemeObjects, {
            Instance = instance,
            Property = property,
            ThemeKey = themeKey
        })
    end
    
    -- Screen GUI
    local ScreenGui = Create("ScreenGui", {
        Name = "VogueHubUI",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent = CoreGui
    })
    
    -- Main Frame
    local MainFrame = Create("Frame", {
        Name = "MainFrame",
        Size = windowSize,
        Position = UDim2.new(0.5, -windowSize.X.Offset/2, 0.5, -windowSize.Y.Offset/2),
        BackgroundColor3 = Theme.Background,
        BorderSizePixel = 0,
        Parent = ScreenGui
    })
    AddCorner(MainFrame, 10)
    local mainStroke = AddStroke(MainFrame, Theme.Divider, 1)
    RegisterThemeObject(MainFrame, "BackgroundColor3", "Background")
    RegisterThemeObject(mainStroke, "Color", "Divider")
    
    -- Shadow
    Create("ImageLabel", {
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
    
    -- Accent Line
    local AccentLine = Create("Frame", {
        Name = "AccentLine",
        Size = UDim2.new(1, -20, 0, 3),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundColor3 = Theme.Accent,
        BorderSizePixel = 0,
        Parent = MainFrame
    })
    AddCorner(AccentLine, 2)
    RegisterThemeObject(AccentLine, "BackgroundColor3", "Accent")
    
    -- Header
    local Header = Create("Frame", {
        Name = "Header",
        Size = UDim2.new(1, 0, 0, 50),
        Position = UDim2.new(0, 0, 0, 3),
        BackgroundTransparency = 1,
        Parent = MainFrame
    })
    
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
    RegisterThemeObject(Logo, "TextColor3", "Accent")
    
    -- Header Divider
    local HeaderDivider = Create("Frame", {
        Size = UDim2.new(1, -40, 0, 1),
        Position = UDim2.new(0, 20, 1, -1),
        BackgroundColor3 = Theme.Divider,
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0,
        Parent = Header
    })
    RegisterThemeObject(HeaderDivider, "BackgroundColor3", "Divider")
    
    -- Close Button
    local CloseButton = Create("TextButton", {
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -40, 0, 10),
        BackgroundTransparency = 1,
        Text = "×",
        TextColor3 = Theme.TextDark,
        TextSize = 24,
        Font = Enum.Font.GothamBold,
        Parent = Header
    })
    AddCorner(CloseButton, 6)
    RegisterThemeObject(CloseButton, "TextColor3", "TextDark")
    
    CloseButton.MouseEnter:Connect(function()
        Tween(CloseButton, {TextColor3 = Theme.Error}, 0.2)
    end)
    CloseButton.MouseLeave:Connect(function()
        Tween(CloseButton, {TextColor3 = Theme.TextDark}, 0.2)
    end)
    CloseButton.MouseButton1Click:Connect(function()
        for _, conn in pairs(Window.Connections) do
            if conn then conn:Disconnect() end
        end
        Tween(MainFrame, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}, 0.3)
        task.wait(0.3)
        ScreenGui:Destroy()
    end)
    
    -- Minimize Button
    local MinimizeButton = Create("TextButton", {
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -75, 0, 10),
        BackgroundTransparency = 1,
        Text = "—",
        TextColor3 = Theme.TextDark,
        TextSize = 18,
        Font = Enum.Font.GothamBold,
        Parent = Header
    })
    AddCorner(MinimizeButton, 6)
    RegisterThemeObject(MinimizeButton, "TextColor3", "TextDark")
    
    local Minimized = false
    MinimizeButton.MouseEnter:Connect(function()
        Tween(MinimizeButton, {TextColor3 = Theme.Accent}, 0.2)
    end)
    MinimizeButton.MouseLeave:Connect(function()
        Tween(MinimizeButton, {TextColor3 = Theme.TextDark}, 0.2)
    end)
    MinimizeButton.MouseButton1Click:Connect(function()
        Minimized = not Minimized
        Tween(MainFrame, {Size = Minimized and UDim2.new(0, windowSize.X.Offset, 0, 53) or windowSize}, 0.3, Enum.EasingStyle.Back)
    end)
    
    -- Tab Bar
    local TabBar = Create("Frame", {
        Name = "TabBar",
        Size = UDim2.new(1, -40, 0, 35),
        Position = UDim2.new(0, 20, 0, 55),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Parent = MainFrame
    })
    
    Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0, 5),
        Parent = TabBar
    })
    
    -- Tab Indicator
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
    RegisterThemeObject(TabIndicator, "BackgroundColor3", "Accent")
    
    -- Tab Divider
    local TabDivider = Create("Frame", {
        Size = UDim2.new(1, -40, 0, 1),
        Position = UDim2.new(0, 20, 0, 95),
        BackgroundColor3 = Theme.Divider,
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0,
        Parent = MainFrame
    })
    RegisterThemeObject(TabDivider, "BackgroundColor3", "Divider")
    
    -- Content Container
    local ContentContainer = Create("Frame", {
        Name = "ContentContainer",
        Size = UDim2.new(1, -40, 1, -115),
        Position = UDim2.new(0, 20, 0, 105),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Parent = MainFrame
    })
    
    -- Drag
    local Dragging, DragStart, StartPos
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
    
    local dragConn = UserInputService.InputChanged:Connect(function(input)
        if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local Delta = input.Position - DragStart
            MainFrame.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + Delta.X, StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y)
        end
    end)
    table.insert(Window.Connections, dragConn)

    -- ════════════════════════════════════════════════════════════════════
    -- CREATE TAB
    -- ════════════════════════════════════════════════════════════════════
    
    function Window:CreateTab(tabConfig)
        tabConfig = tabConfig or {}
        local tabName = tabConfig.Name or "Tab"
        local tabIcon = tabConfig.Icon or ""
        
        local Tab = {Elements = {}}
        
        local TabButton = Create("TextButton", {
            Name = tabName,
            Size = UDim2.new(0, 0, 1, 0),
            AutomaticSize = Enum.AutomaticSize.X,
            BackgroundTransparency = 1,
            Text = "",
            Parent = TabBar
        })
        AddPadding(TabButton, 0, 0, 15, 15)
        
        local displayText = tabIcon ~= "" and (tabIcon .. "  " .. string.upper(tabName)) or string.upper(tabName)
        local TabLabel = Create("TextLabel", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Text = displayText,
            TextColor3 = Theme.TextDark,
            TextSize = 11,
            Font = Enum.Font.GothamBold,
            Parent = TabButton
        })
        RegisterThemeObject(TabLabel, "TextColor3", "TextDark")
        
        local TabContent = Create("ScrollingFrame", {
            Name = tabName,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 4,
            ScrollBarImageColor3 = Theme.Accent,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            Visible = false,
            Parent = ContentContainer
        })
        RegisterThemeObject(TabContent, "ScrollBarImageColor3", "Accent")
        
        local ContentList = Create("UIListLayout", {Padding = UDim.new(0, 10), Parent = TabContent})
        AddPadding(TabContent, 5, 5, 0, 8)
        
        ContentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentList.AbsoluteContentSize.Y + 15)
        end)
        
        local function ActivateTab()
            for _, t in pairs(Window.Tabs) do
                t.Content.Visible = false
                t.Label.TextColor3 = Theme.TextDark
            end
            TabContent.Visible = true
            TabLabel.TextColor3 = Theme.Text
            Tween(TabIndicator, {
                Size = UDim2.new(0, TabButton.AbsoluteSize.X, 0, 3),
                Position = UDim2.new(0, TabButton.AbsolutePosition.X - TabBar.AbsolutePosition.X, 1, -3)
            }, 0.3, Enum.EasingStyle.Quint)
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
                Name = sectionName,
                Size = UDim2.new(1, -5, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundColor3 = Theme.Secondary,
                BorderSizePixel = 0,
                Parent = TabContent
            })
            AddCorner(SectionFrame, 8)
            local sectionStroke = AddStroke(SectionFrame, Theme.Divider, 1)
            sectionStroke.Transparency = 0.5
            AddPadding(SectionFrame, 14, 14, 15, 15)
            RegisterThemeObject(SectionFrame, "BackgroundColor3", "Secondary")
            RegisterThemeObject(sectionStroke, "Color", "Divider")
            
            local SectionTitle = Create("TextLabel", {
                Size = UDim2.new(1, 0, 0, 20),
                BackgroundTransparency = 1,
                Text = string.upper(sectionName),
                TextColor3 = Theme.Accent,
                TextSize = 11,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = SectionFrame
            })
            RegisterThemeObject(SectionTitle, "TextColor3", "Accent")
            
            local SectionAccent = Create("Frame", {
                Size = UDim2.new(0, 3, 0, 14),
                Position = UDim2.new(0, -15, 0, 3),
                BackgroundColor3 = Theme.Accent,
                BorderSizePixel = 0,
                Parent = SectionTitle
            })
            AddCorner(SectionAccent, 2)
            RegisterThemeObject(SectionAccent, "BackgroundColor3", "Accent")
            
            local SectionContent = Create("Frame", {
                Size = UDim2.new(1, 0, 0, 0),
                Position = UDim2.new(0, 0, 0, 28),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Parent = SectionFrame
            })
            Create("UIListLayout", {Padding = UDim.new(0, 8), Parent = SectionContent})
            
            Section.Frame = SectionFrame
            Section.Content = SectionContent

            -- ════════════════════════════════════════════════════════════
            -- BUTTON
            -- ════════════════════════════════════════════════════════════
            
            function Section:CreateButton(cfg)
                cfg = cfg or {}
                local name = cfg.Name or "Button"
                local icon = cfg.Icon or ""
                local callback = cfg.Callback or function() end
                
                local Frame = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 38),
                    BackgroundTransparency = 1,
                    Parent = SectionContent
                })
                
                local Button = Create("TextButton", {
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundColor3 = Theme.Background,
                    BorderSizePixel = 0,
                    Text = "",
                    ClipsDescendants = true,
                    Parent = Frame
                })
                AddCorner(Button, 6)
                local btnStroke = AddStroke(Button, Theme.Divider, 1)
                btnStroke.Transparency = 0.5
                RegisterThemeObject(Button, "BackgroundColor3", "Background")
                RegisterThemeObject(btnStroke, "Color", "Divider")
                
                local displayText = icon ~= "" and (icon .. "  " .. name) or name
                local Label = Create("TextLabel", {
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
                RegisterThemeObject(Label, "TextColor3", "Text")
                
                local Arrow = Create("TextLabel", {
                    Size = UDim2.new(0, 20, 1, 0),
                    Position = UDim2.new(1, -28, 0, 0),
                    BackgroundTransparency = 1,
                    Text = "→",
                    TextColor3 = Theme.Accent,
                    TextSize = 14,
                    Font = Enum.Font.GothamBold,
                    Parent = Button
                })
                RegisterThemeObject(Arrow, "TextColor3", "Accent")
                
                Button.MouseEnter:Connect(function()
                    Tween(Button, {BackgroundColor3 = Theme.Tertiary}, 0.2)
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
                
                return Frame
            end
            
            -- ════════════════════════════════════════════════════════════
            -- TOGGLE
            -- ════════════════════════════════════════════════════════════
            
            function Section:CreateToggle(cfg)
                cfg = cfg or {}
                local name = cfg.Name or "Toggle"
                local icon = cfg.Icon or ""
                local default = cfg.Default or false
                local callback = cfg.Callback or function() end
                
                local Toggled = default
                
                local Frame = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 38),
                    BackgroundColor3 = Theme.Background,
                    BorderSizePixel = 0,
                    Parent = SectionContent
                })
                AddCorner(Frame, 6)
                local frameStroke = AddStroke(Frame, Theme.Divider, 1)
                frameStroke.Transparency = 0.5
                RegisterThemeObject(Frame, "BackgroundColor3", "Background")
                RegisterThemeObject(frameStroke, "Color", "Divider")
                
                local displayText = icon ~= "" and (icon .. "  " .. name) or name
                local Label = Create("TextLabel", {
                    Size = UDim2.new(1, -65, 1, 0),
                    Position = UDim2.new(0, 12, 0, 0),
                    BackgroundTransparency = 1,
                    Text = displayText,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = Frame
                })
                RegisterThemeObject(Label, "TextColor3", "Text")
                
                local ToggleBtn = Create("TextButton", {
                    Size = UDim2.new(0, 44, 0, 22),
                    Position = UDim2.new(1, -54, 0.5, -11),
                    BackgroundColor3 = Toggled and Theme.Accent or Theme.Background,
                    BorderSizePixel = 0,
                    Text = "",
                    Parent = Frame
                })
                AddCorner(ToggleBtn, 11)
                local toggleStroke = AddStroke(ToggleBtn, Toggled and Theme.Accent or Theme.Divider, 1)
                
                local Circle = Create("Frame", {
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = Toggled and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8),
                    BackgroundColor3 = Theme.Text,
                    BorderSizePixel = 0,
                    Parent = ToggleBtn
                })
                AddCorner(Circle, 8)
                RegisterThemeObject(Circle, "BackgroundColor3", "Text")
                
                local function Update()
                    Tween(ToggleBtn, {BackgroundColor3 = Toggled and Theme.Accent or Theme.Background}, 0.2)
                    Tween(Circle, {Position = Toggled and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)}, 0.2, Enum.EasingStyle.Back)
                    Tween(toggleStroke, {Color = Toggled and Theme.Accent or Theme.Divider}, 0.2)
                end
                
                ToggleBtn.MouseButton1Click:Connect(function()
                    Toggled = not Toggled
                    Update()
                    callback(Toggled)
                end)
                
                Frame.MouseEnter:Connect(function()
                    Tween(Frame, {BackgroundColor3 = Theme.Tertiary}, 0.2)
                end)
                Frame.MouseLeave:Connect(function()
                    Tween(Frame, {BackgroundColor3 = Theme.Background}, 0.2)
                end)
                
                local API = {}
                function API:Set(v) Toggled = v; Update(); callback(Toggled) end
                function API:Get() return Toggled end
                return API
            end

            -- ════════════════════════════════════════════════════════════
            -- SLIDER
            -- ════════════════════════════════════════════════════════════
            
            function Section:CreateSlider(cfg)
                cfg = cfg or {}
                local name = cfg.Name or "Slider"
                local icon = cfg.Icon or ""
                local min = cfg.Min or 0
                local max = cfg.Max or 100
                local default = cfg.Default or min
                local increment = cfg.Increment or 1
                local callback = cfg.Callback or function() end
                
                local Value = default
                local Dragging = false
                
                local Frame = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 55),
                    BackgroundColor3 = Theme.Background,
                    BorderSizePixel = 0,
                    Parent = SectionContent
                })
                AddCorner(Frame, 6)
                local frameStroke = AddStroke(Frame, Theme.Divider, 1)
                frameStroke.Transparency = 0.5
                RegisterThemeObject(Frame, "BackgroundColor3", "Background")
                RegisterThemeObject(frameStroke, "Color", "Divider")
                
                local displayText = icon ~= "" and (icon .. "  " .. name) or name
                local Label = Create("TextLabel", {
                    Size = UDim2.new(1, -70, 0, 20),
                    Position = UDim2.new(0, 12, 0, 8),
                    BackgroundTransparency = 1,
                    Text = displayText,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = Frame
                })
                RegisterThemeObject(Label, "TextColor3", "Text")
                
                local ValueLabel = Create("TextLabel", {
                    Size = UDim2.new(0, 55, 0, 20),
                    Position = UDim2.new(1, -62, 0, 8),
                    BackgroundColor3 = Theme.Tertiary,
                    BackgroundTransparency = 0.5,
                    Text = tostring(Value),
                    TextColor3 = Theme.Accent,
                    TextSize = 11,
                    Font = Enum.Font.GothamBold,
                    Parent = Frame
                })
                AddCorner(ValueLabel, 4)
                RegisterThemeObject(ValueLabel, "BackgroundColor3", "Tertiary")
                RegisterThemeObject(ValueLabel, "TextColor3", "Accent")
                
                local Bar = Create("Frame", {
                    Size = UDim2.new(1, -24, 0, 8),
                    Position = UDim2.new(0, 12, 0, 36),
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0,
                    Parent = Frame
                })
                AddCorner(Bar, 4)
                RegisterThemeObject(Bar, "BackgroundColor3", "Tertiary")
                
                local Fill = Create("Frame", {
                    Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
                    BackgroundColor3 = Theme.Accent,
                    BorderSizePixel = 0,
                    Parent = Bar
                })
                AddCorner(Fill, 4)
                RegisterThemeObject(Fill, "BackgroundColor3", "Accent")
                
                local Knob = Create("Frame", {
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = UDim2.new((default - min) / (max - min), -8, 0.5, -8),
                    BackgroundColor3 = Theme.Text,
                    BorderSizePixel = 0,
                    ZIndex = 2,
                    Parent = Bar
                })
                AddCorner(Knob, 8)
                local knobStroke = AddStroke(Knob, Theme.Accent, 2)
                RegisterThemeObject(Knob, "BackgroundColor3", "Text")
                RegisterThemeObject(knobStroke, "Color", "Accent")
                
                local SliderBtn = Create("TextButton", {
                    Size = UDim2.new(1, 0, 1, 10),
                    Position = UDim2.new(0, 0, 0, -5),
                    BackgroundTransparency = 1,
                    Text = "",
                    Parent = Bar
                })
                
                local function Update(input)
                    local percent = math.clamp((input.Position.X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
                    local raw = min + (max - min) * percent
                    Value = math.floor(raw / increment + 0.5) * increment
                    Value = math.clamp(Value, min, max)
                    local p = (Value - min) / (max - min)
                    ValueLabel.Text = tostring(Value)
                    Tween(Fill, {Size = UDim2.new(p, 0, 1, 0)}, 0.05)
                    Tween(Knob, {Position = UDim2.new(p, -8, 0.5, -8)}, 0.05)
                    callback(Value)
                end
                
                SliderBtn.MouseButton1Down:Connect(function()
                    Dragging = true
                end)
                
                local endConn = UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        Dragging = false
                    end
                end)
                table.insert(Window.Connections, endConn)
                
                local changeConn = UserInputService.InputChanged:Connect(function(input)
                    if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        Update(input)
                    end
                end)
                table.insert(Window.Connections, changeConn)
                
                SliderBtn.MouseButton1Click:Connect(function()
                    Update({Position = Vector3.new(Mouse.X, 0, 0)})
                end)
                
                Frame.MouseEnter:Connect(function()
                    Tween(Frame, {BackgroundColor3 = Theme.Tertiary}, 0.2)
                end)
                Frame.MouseLeave:Connect(function()
                    Tween(Frame, {BackgroundColor3 = Theme.Background}, 0.2)
                end)
                
                local API = {}
                function API:Set(v)
                    Value = math.clamp(v, min, max)
                    local p = (Value - min) / (max - min)
                    ValueLabel.Text = tostring(Value)
                    Tween(Fill, {Size = UDim2.new(p, 0, 1, 0)}, 0.1)
                    Tween(Knob, {Position = UDim2.new(p, -8, 0.5, -8)}, 0.1)
                    callback(Value)
                end
                function API:Get() return Value end
                return API
            end

            -- ════════════════════════════════════════════════════════════
            -- DROPDOWN
            -- ════════════════════════════════════════════════════════════
            
            function Section:CreateDropdown(cfg)
                cfg = cfg or {}
                local name = cfg.Name or "Dropdown"
                local icon = cfg.Icon or ""
                local options = cfg.Options or {}
                local default = cfg.Default or (options[1] or "Select...")
                local callback = cfg.Callback or function() end
                
                local Selected = default
                local Opened = false
                local OptHeight = 32
                
                local Frame = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 38),
                    BackgroundColor3 = Theme.Background,
                    BorderSizePixel = 0,
                    ClipsDescendants = true,
                    ZIndex = 2,
                    Parent = SectionContent
                })
                AddCorner(Frame, 6)
                local frameStroke = AddStroke(Frame, Theme.Divider, 1)
                frameStroke.Transparency = 0.5
                RegisterThemeObject(Frame, "BackgroundColor3", "Background")
                RegisterThemeObject(frameStroke, "Color", "Divider")
                
                local Header = Create("TextButton", {
                    Size = UDim2.new(1, 0, 0, 38),
                    BackgroundTransparency = 1,
                    Text = "",
                    ZIndex = 2,
                    Parent = Frame
                })
                
                local displayText = icon ~= "" and (icon .. "  " .. name) or name
                local Label = Create("TextLabel", {
                    Size = UDim2.new(0.5, -10, 1, 0),
                    Position = UDim2.new(0, 12, 0, 0),
                    BackgroundTransparency = 1,
                    Text = displayText,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 2,
                    Parent = Header
                })
                RegisterThemeObject(Label, "TextColor3", "Text")
                
                local SelectedLabel = Create("TextLabel", {
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
                    Parent = Header
                })
                RegisterThemeObject(SelectedLabel, "TextColor3", "Accent")
                
                local Arrow = Create("TextLabel", {
                    Size = UDim2.new(0, 20, 1, 0),
                    Position = UDim2.new(1, -28, 0, 0),
                    BackgroundTransparency = 1,
                    Text = "▼",
                    TextColor3 = Theme.TextDark,
                    TextSize = 10,
                    Font = Enum.Font.Gotham,
                    ZIndex = 2,
                    Parent = Header
                })
                RegisterThemeObject(Arrow, "TextColor3", "TextDark")
                
                local Content = Create("Frame", {
                    Size = UDim2.new(1, -16, 0, 0),
                    Position = UDim2.new(0, 8, 0, 44),
                    BackgroundTransparency = 1,
                    ZIndex = 2,
                    Parent = Frame
                })
                Create("UIListLayout", {Padding = UDim.new(0, 4), Parent = Content})
                
                local function CreateOption(optName)
                    local Opt = Create("TextButton", {
                        Size = UDim2.new(1, 0, 0, OptHeight),
                        BackgroundColor3 = Theme.Tertiary,
                        BorderSizePixel = 0,
                        Text = optName,
                        TextColor3 = optName == Selected and Theme.Accent or Theme.Text,
                        TextSize = 11,
                        Font = Enum.Font.Gotham,
                        ZIndex = 3,
                        Parent = Content
                    })
                    AddCorner(Opt, 4)
                    RegisterThemeObject(Opt, "BackgroundColor3", "Tertiary")
                    
                    Opt.MouseEnter:Connect(function()
                        Tween(Opt, {BackgroundColor3 = Theme.Accent, TextColor3 = Theme.Background}, 0.2)
                    end)
                    Opt.MouseLeave:Connect(function()
                        Tween(Opt, {BackgroundColor3 = Theme.Tertiary, TextColor3 = optName == Selected and Theme.Accent or Theme.Text}, 0.2)
                    end)
                    Opt.MouseButton1Click:Connect(function()
                        Selected = optName
                        SelectedLabel.Text = optName
                        Opened = false
                        Tween(Frame, {Size = UDim2.new(1, 0, 0, 38)}, 0.2, Enum.EasingStyle.Back)
                        Tween(Arrow, {Rotation = 0}, 0.2)
                        for _, c in pairs(Content:GetChildren()) do
                            if c:IsA("TextButton") then
                                c.TextColor3 = c.Name == Selected and Theme.Accent or Theme.Text
                            end
                        end
                        callback(optName)
                    end)
                end
                
                for _, opt in ipairs(options) do
                    CreateOption(opt)
                end
                
                Header.MouseButton1Click:Connect(function()
                    Opened = not Opened
                    local h = Opened and (38 + #options * (OptHeight + 4) + 10) or 38
                    Tween(Frame, {Size = UDim2.new(1, 0, 0, h)}, 0.2, Enum.EasingStyle.Back)
                    Tween(Arrow, {Rotation = Opened and 180 or 0}, 0.2)
                end)
                
                Header.MouseEnter:Connect(function()
                    if not Opened then Tween(Frame, {BackgroundColor3 = Theme.Tertiary}, 0.2) end
                end)
                Header.MouseLeave:Connect(function()
                    if not Opened then Tween(Frame, {BackgroundColor3 = Theme.Background}, 0.2) end
                end)
                
                local API = {}
                function API:Set(v)
                    Selected = v
                    SelectedLabel.Text = v
                    for _, c in pairs(Content:GetChildren()) do
                        if c:IsA("TextButton") then
                            c.TextColor3 = c.Name == Selected and Theme.Accent or Theme.Text
                        end
                    end
                    callback(v)
                end
                function API:Get() return Selected end
                function API:Refresh(newOpts)
                    for _, c in pairs(Content:GetChildren()) do
                        if c:IsA("TextButton") then c:Destroy() end
                    end
                    options = newOpts
                    for _, opt in ipairs(options) do
                        CreateOption(opt)
                    end
                end
                return API
            end

            -- ════════════════════════════════════════════════════════════
            -- TEXTBOX
            -- ════════════════════════════════════════════════════════════
            
            function Section:CreateTextBox(cfg)
                cfg = cfg or {}
                local name = cfg.Name or "TextBox"
                local icon = cfg.Icon or ""
                local placeholder = cfg.Placeholder or "Enter text..."
                local default = cfg.Default or ""
                local callback = cfg.Callback or function() end
                
                local Frame = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 38),
                    BackgroundColor3 = Theme.Background,
                    BorderSizePixel = 0,
                    Parent = SectionContent
                })
                AddCorner(Frame, 6)
                local frameStroke = AddStroke(Frame, Theme.Divider, 1)
                frameStroke.Transparency = 0.5
                RegisterThemeObject(Frame, "BackgroundColor3", "Background")
                RegisterThemeObject(frameStroke, "Color", "Divider")
                
                local displayText = icon ~= "" and (icon .. "  " .. name) or name
                local Label = Create("TextLabel", {
                    Size = UDim2.new(0.4, -10, 1, 0),
                    Position = UDim2.new(0, 12, 0, 0),
                    BackgroundTransparency = 1,
                    Text = displayText,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = Frame
                })
                RegisterThemeObject(Label, "TextColor3", "Text")
                
                local Input = Create("TextBox", {
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
                    Parent = Frame
                })
                AddCorner(Input, 4)
                local inputStroke = AddStroke(Input, Theme.Divider, 1)
                inputStroke.Transparency = 0.5
                AddPadding(Input, 0, 0, 10, 10)
                RegisterThemeObject(Input, "BackgroundColor3", "Tertiary")
                RegisterThemeObject(Input, "TextColor3", "Text")
                RegisterThemeObject(Input, "PlaceholderColor3", "TextMuted")
                RegisterThemeObject(inputStroke, "Color", "Divider")
                
                Input.Focused:Connect(function()
                    Tween(Input, {BackgroundColor3 = Theme.Secondary}, 0.2)
                    Tween(inputStroke, {Color = Theme.Accent, Transparency = 0}, 0.2)
                end)
                Input.FocusLost:Connect(function(enter)
                    Tween(Input, {BackgroundColor3 = Theme.Tertiary}, 0.2)
                    Tween(inputStroke, {Color = Theme.Divider, Transparency = 0.5}, 0.2)
                    if enter then callback(Input.Text) end
                end)
                
                Frame.MouseEnter:Connect(function()
                    Tween(Frame, {BackgroundColor3 = Theme.Tertiary}, 0.2)
                end)
                Frame.MouseLeave:Connect(function()
                    Tween(Frame, {BackgroundColor3 = Theme.Background}, 0.2)
                end)
                
                local API = {}
                function API:Set(v) Input.Text = v end
                function API:Get() return Input.Text end
                return API
            end
            
            -- ════════════════════════════════════════════════════════════
            -- KEYBIND
            -- ════════════════════════════════════════════════════════════
            
            function Section:CreateKeybind(cfg)
                cfg = cfg or {}
                local name = cfg.Name or "Keybind"
                local icon = cfg.Icon or ""
                local default = cfg.Default or Enum.KeyCode.Unknown
                local callback = cfg.Callback or function() end
                
                local CurrentKey = default
                local Listening = false
                
                local Frame = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 38),
                    BackgroundColor3 = Theme.Background,
                    BorderSizePixel = 0,
                    Parent = SectionContent
                })
                AddCorner(Frame, 6)
                local frameStroke = AddStroke(Frame, Theme.Divider, 1)
                frameStroke.Transparency = 0.5
                RegisterThemeObject(Frame, "BackgroundColor3", "Background")
                RegisterThemeObject(frameStroke, "Color", "Divider")
                
                local displayText = icon ~= "" and (icon .. "  " .. name) or name
                local Label = Create("TextLabel", {
                    Size = UDim2.new(1, -85, 1, 0),
                    Position = UDim2.new(0, 12, 0, 0),
                    BackgroundTransparency = 1,
                    Text = displayText,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = Frame
                })
                RegisterThemeObject(Label, "TextColor3", "Text")
                
                local KeyBtn = Create("TextButton", {
                    Size = UDim2.new(0, 65, 0, 26),
                    Position = UDim2.new(1, -75, 0.5, -13),
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0,
                    Text = CurrentKey == Enum.KeyCode.Unknown and "None" or CurrentKey.Name,
                    TextColor3 = Theme.Accent,
                    TextSize = 10,
                    Font = Enum.Font.GothamBold,
                    Parent = Frame
                })
                AddCorner(KeyBtn, 4)
                local keyStroke = AddStroke(KeyBtn, Theme.Divider, 1)
                keyStroke.Transparency = 0.5
                RegisterThemeObject(KeyBtn, "BackgroundColor3", "Tertiary")
                RegisterThemeObject(KeyBtn, "TextColor3", "Accent")
                RegisterThemeObject(keyStroke, "Color", "Divider")
                
                KeyBtn.MouseButton1Click:Connect(function()
                    Listening = true
                    KeyBtn.Text = "..."
                    Tween(KeyBtn, {BackgroundColor3 = Theme.Accent, TextColor3 = Theme.Background}, 0.2)
                end)
                
                local keyConn = UserInputService.InputBegan:Connect(function(input, gpe)
                    if Listening then
                        if input.UserInputType == Enum.UserInputType.Keyboard then
                            if input.KeyCode == Enum.KeyCode.Escape then
                                CurrentKey = Enum.KeyCode.Unknown
                                KeyBtn.Text = "None"
                            else
                                CurrentKey = input.KeyCode
                                KeyBtn.Text = CurrentKey.Name
                            end
                            Listening = false
                            Tween(KeyBtn, {BackgroundColor3 = Theme.Tertiary, TextColor3 = Theme.Accent}, 0.2)
                        end
                    elseif input.KeyCode == CurrentKey and not gpe and CurrentKey ~= Enum.KeyCode.Unknown then
                        callback()
                    end
                end)
                table.insert(Window.Connections, keyConn)
                
                Frame.MouseEnter:Connect(function()
                    Tween(Frame, {BackgroundColor3 = Theme.Tertiary}, 0.2)
                end)
                Frame.MouseLeave:Connect(function()
                    Tween(Frame, {BackgroundColor3 = Theme.Background}, 0.2)
                end)
                
                local API = {}
                function API:Set(k)
                    CurrentKey = k
                    KeyBtn.Text = k == Enum.KeyCode.Unknown and "None" or k.Name
                end
                function API:Get() return CurrentKey end
                return API
            end
            
            -- ════════════════════════════════════════════════════════════
            -- LABEL
            -- ════════════════════════════════════════════════════════════
            
            function Section:CreateLabel(text)
                local Frame = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 28),
                    BackgroundTransparency = 1,
                    Parent = SectionContent
                })
                
                local Label = Create("TextLabel", {
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text = text or "Label",
                    TextColor3 = Theme.TextDark,
                    TextSize = 11,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = true,
                    Parent = Frame
                })
                RegisterThemeObject(Label, "TextColor3", "TextDark")
                
                local API = {}
                function API:Set(t) Label.Text = t end
                function API:Get() return Label.Text end
                return API
            end
            
            -- ════════════════════════════════════════════════════════════
            -- SEPARATOR
            -- ════════════════════════════════════════════════════════════
            
            function Section:CreateSeparator()
                local Frame = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Parent = SectionContent
                })
                
                local Line = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 1),
                    Position = UDim2.new(0, 0, 0.5, 0),
                    BackgroundColor3 = Theme.Divider,
                    BackgroundTransparency = 0.5,
                    BorderSizePixel = 0,
                    Parent = Frame
                })
                RegisterThemeObject(Line, "BackgroundColor3", "Divider")
                
                return Frame
            end

            -- ════════════════════════════════════════════════════════════
            -- PROGRESS BAR
            -- ════════════════════════════════════════════════════════════
            
            function Section:CreateProgressBar(cfg)
                cfg = cfg or {}
                local name = cfg.Name or "Progress"
                local icon = cfg.Icon or ""
                local default = cfg.Default or 0
                local max = cfg.Max or 100
                
                local Value = default
                
                local Frame = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 50),
                    BackgroundColor3 = Theme.Background,
                    BorderSizePixel = 0,
                    Parent = SectionContent
                })
                AddCorner(Frame, 6)
                local frameStroke = AddStroke(Frame, Theme.Divider, 1)
                frameStroke.Transparency = 0.5
                RegisterThemeObject(Frame, "BackgroundColor3", "Background")
                RegisterThemeObject(frameStroke, "Color", "Divider")
                
                local displayText = icon ~= "" and (icon .. "  " .. name) or name
                local Label = Create("TextLabel", {
                    Size = UDim2.new(1, -60, 0, 20),
                    Position = UDim2.new(0, 12, 0, 8),
                    BackgroundTransparency = 1,
                    Text = displayText,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = Frame
                })
                RegisterThemeObject(Label, "TextColor3", "Text")
                
                local ValueLabel = Create("TextLabel", {
                    Size = UDim2.new(0, 50, 0, 20),
                    Position = UDim2.new(1, -58, 0, 8),
                    BackgroundTransparency = 1,
                    Text = math.floor(Value / max * 100) .. "%",
                    TextColor3 = Theme.Accent,
                    TextSize = 11,
                    Font = Enum.Font.GothamBold,
                    TextXAlignment = Enum.TextXAlignment.Right,
                    Parent = Frame
                })
                RegisterThemeObject(ValueLabel, "TextColor3", "Accent")
                
                local Bar = Create("Frame", {
                    Size = UDim2.new(1, -24, 0, 8),
                    Position = UDim2.new(0, 12, 0, 34),
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0,
                    Parent = Frame
                })
                AddCorner(Bar, 4)
                RegisterThemeObject(Bar, "BackgroundColor3", "Tertiary")
                
                local Fill = Create("Frame", {
                    Size = UDim2.new(Value / max, 0, 1, 0),
                    BackgroundColor3 = Theme.Accent,
                    BorderSizePixel = 0,
                    Parent = Bar
                })
                AddCorner(Fill, 4)
                RegisterThemeObject(Fill, "BackgroundColor3", "Accent")
                
                local API = {}
                function API:Set(v)
                    Value = math.clamp(v, 0, max)
                    ValueLabel.Text = math.floor(Value / max * 100) .. "%"
                    Tween(Fill, {Size = UDim2.new(Value / max, 0, 1, 0)}, 0.3)
                end
                function API:Get() return Value end
                function API:Increment(a) API:Set(Value + (a or 1)) end
                return API
            end
            
            -- ════════════════════════════════════════════════════════════
            -- COLOR PICKER
            -- ════════════════════════════════════════════════════════════
            
            function Section:CreateColorPicker(cfg)
                cfg = cfg or {}
                local name = cfg.Name or "Color"
                local icon = cfg.Icon or ""
                local default = cfg.Default or Color3.new(1, 1, 1)
                local callback = cfg.Callback or function() end
                
                local CurrentColor = default
                local Opened = false
                local H, S, V = Color3.toHSV(default)
                local SVDrag, HueDrag = false, false
                
                local Frame = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 38),
                    BackgroundColor3 = Theme.Background,
                    BorderSizePixel = 0,
                    ClipsDescendants = true,
                    ZIndex = 3,
                    Parent = SectionContent
                })
                AddCorner(Frame, 6)
                local frameStroke = AddStroke(Frame, Theme.Divider, 1)
                frameStroke.Transparency = 0.5
                RegisterThemeObject(Frame, "BackgroundColor3", "Background")
                RegisterThemeObject(frameStroke, "Color", "Divider")
                
                local Header = Create("TextButton", {
                    Size = UDim2.new(1, 0, 0, 38),
                    BackgroundTransparency = 1,
                    Text = "",
                    ZIndex = 3,
                    Parent = Frame
                })
                
                local displayText = icon ~= "" and (icon .. "  " .. name) or name
                local Label = Create("TextLabel", {
                    Size = UDim2.new(1, -60, 1, 0),
                    Position = UDim2.new(0, 12, 0, 0),
                    BackgroundTransparency = 1,
                    Text = displayText,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 3,
                    Parent = Header
                })
                RegisterThemeObject(Label, "TextColor3", "Text")
                
                local Preview = Create("Frame", {
                    Size = UDim2.new(0, 40, 0, 22),
                    Position = UDim2.new(1, -52, 0.5, -11),
                    BackgroundColor3 = CurrentColor,
                    BorderSizePixel = 0,
                    ZIndex = 3,
                    Parent = Header
                })
                AddCorner(Preview, 4)
                AddStroke(Preview, Theme.Divider, 1)
                
                local Content = Create("Frame", {
                    Size = UDim2.new(1, -16, 0, 130),
                    Position = UDim2.new(0, 8, 0, 44),
                    BackgroundTransparency = 1,
                    ZIndex = 3,
                    Parent = Frame
                })
                
                -- SV Picker
                local SVPicker = Create("Frame", {
                    Size = UDim2.new(1, -40, 0, 100),
                    BackgroundColor3 = Color3.fromHSV(H, 1, 1),
                    BorderSizePixel = 0,
                    ZIndex = 4,
                    Parent = Content
                })
                AddCorner(SVPicker, 4)
                
                local WhiteOverlay = Create("Frame", {
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
                    Parent = WhiteOverlay
                })
                
                local BlackOverlay = Create("Frame", {
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
                
                local SVBtn = Create("TextButton", {
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text = "",
                    ZIndex = 7,
                    Parent = SVPicker
                })
                
                local SVCursor = Create("Frame", {
                    Size = UDim2.new(0, 14, 0, 14),
                    Position = UDim2.new(S, -7, 1 - V, -7),
                    BackgroundColor3 = Color3.new(1, 1, 1),
                    BorderSizePixel = 0,
                    ZIndex = 8,
                    Parent = SVPicker
                })
                AddCorner(SVCursor, 7)
                AddStroke(SVCursor, Color3.new(0, 0, 0), 2)
                
                -- Hue Slider
                local HueSlider = Create("Frame", {
                    Size = UDim2.new(0, 25, 0, 100),
                    Position = UDim2.new(1, -25, 0, 0),
                    BackgroundColor3 = Color3.new(1, 1, 1),
                    BorderSizePixel = 0,
                    ZIndex = 4,
                    Parent = Content
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
                
                local HueBtn = Create("TextButton", {
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text = "",
                    ZIndex = 5,
                    Parent = HueSlider
                })
                
                local HueCursor = Create("Frame", {
                    Size = UDim2.new(1, 4, 0, 6),
                    Position = UDim2.new(0, -2, H, -3),
                    BackgroundColor3 = Color3.new(1, 1, 1),
                    BorderSizePixel = 0,
                    ZIndex = 6,
                    Parent = HueSlider
                })
                AddCorner(HueCursor, 2)
                AddStroke(HueCursor, Color3.new(0, 0, 0), 1)
                
                local RGBLabel = Create("TextLabel", {
                    Size = UDim2.new(1, -40, 0, 20),
                    Position = UDim2.new(0, 0, 0, 108),
                    BackgroundTransparency = 1,
                    Text = string.format("RGB: %d, %d, %d", math.floor(CurrentColor.R * 255), math.floor(CurrentColor.G * 255), math.floor(CurrentColor.B * 255)),
                    TextColor3 = Theme.TextDark,
                    TextSize = 10,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 4,
                    Parent = Content
                })
                RegisterThemeObject(RGBLabel, "TextColor3", "TextDark")
                
                local function UpdateColor()
                    CurrentColor = Color3.fromHSV(H, S, V)
                    Preview.BackgroundColor3 = CurrentColor
                    SVPicker.BackgroundColor3 = Color3.fromHSV(H, 1, 1)
                    SVCursor.Position = UDim2.new(S, -7, 1 - V, -7)
                    HueCursor.Position = UDim2.new(0, -2, H, -3)
                    RGBLabel.Text = string.format("RGB: %d, %d, %d", math.floor(CurrentColor.R * 255), math.floor(CurrentColor.G * 255), math.floor(CurrentColor.B * 255))
                    callback(CurrentColor)
                end
                
                local function UpdateSV(input)
                    S = math.clamp((input.Position.X - SVPicker.AbsolutePosition.X) / SVPicker.AbsoluteSize.X, 0, 1)
                    V = 1 - math.clamp((input.Position.Y - SVPicker.AbsolutePosition.Y) / SVPicker.AbsoluteSize.Y, 0, 1)
                    UpdateColor()
                end
                
                local function UpdateHue(input)
                    H = math.clamp((input.Position.Y - HueSlider.AbsolutePosition.Y) / HueSlider.AbsoluteSize.Y, 0, 1)
                    UpdateColor()
                end
                
                SVBtn.MouseButton1Down:Connect(function()
                    SVDrag = true
                    UpdateSV({Position = Vector3.new(Mouse.X, Mouse.Y, 0)})
                end)
                
                HueBtn.MouseButton1Down:Connect(function()
                    HueDrag = true
                    UpdateHue({Position = Vector3.new(Mouse.X, Mouse.Y, 0)})
                end)
                
                local colorEndConn = UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        SVDrag = false
                        HueDrag = false
                    end
                end)
                table.insert(Window.Connections, colorEndConn)
                
                local colorChangeConn = UserInputService.InputChanged:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        if SVDrag then UpdateSV(input) end
                        if HueDrag then UpdateHue(input) end
                    end
                end)
                table.insert(Window.Connections, colorChangeConn)
                
                Header.MouseButton1Click:Connect(function()
                    Opened = not Opened
                    Tween(Frame, {Size = UDim2.new(1, 0, 0, Opened and 185 or 38)}, 0.2, Enum.EasingStyle.Back)
                end)
                
                Header.MouseEnter:Connect(function()
                    if not Opened then Tween(Frame, {BackgroundColor3 = Theme.Tertiary}, 0.2) end
                end)
                Header.MouseLeave:Connect(function()
                    if not Opened then Tween(Frame, {BackgroundColor3 = Theme.Background}, 0.2) end
                end)
                
                local API = {}
                function API:Set(c)
                    CurrentColor = c
                    H, S, V = Color3.toHSV(c)
                    UpdateColor()
                end
                function API:Get() return CurrentColor end
                return API
            end
            
            return Section
        end
        
        return Tab
    end

    -- ════════════════════════════════════════════════════════════════════
    -- NOTIFICATIONS
    -- ════════════════════════════════════════════════════════════════════
    
    function Window:Notify(cfg)
        cfg = cfg or {}
        local title = cfg.Title or "Notification"
        local content = cfg.Content or ""
        local duration = cfg.Duration or 3
        local nType = cfg.Type or "info"
        
        local typeColors = {
            info = Theme.Accent,
            success = Theme.Success,
            error = Theme.Error,
            warning = Theme.Warning
        }
        local accentColor = typeColors[nType] or Theme.Accent
        
        local icons = {info = "ℹ", success = "✓", error = "✕", warning = "⚠"}
        
        local idx = #Window.Notifications + 1
        local yOff = 20 + (idx - 1) * 90
        
        local NotifyFrame = Create("Frame", {
            Size = UDim2.new(0, 300, 0, 0),
            Position = UDim2.new(1, 20, 1, -yOff),
            AnchorPoint = Vector2.new(0, 1),
            BackgroundColor3 = Theme.Background,
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.Y,
            ClipsDescendants = true,
            Parent = ScreenGui
        })
        AddCorner(NotifyFrame, 8)
        local notifyStroke = AddStroke(NotifyFrame, accentColor, 1)
        notifyStroke.Transparency = 0.3
        
        Create("ImageLabel", {
            Size = UDim2.new(1, 20, 1, 20),
            Position = UDim2.new(0, -10, 0, -10),
            BackgroundTransparency = 1,
            Image = "rbxassetid://5554236805",
            ImageColor3 = Color3.new(0, 0, 0),
            ImageTransparency = 0.6,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(23, 23, 277, 277),
            ZIndex = -1,
            Parent = NotifyFrame
        })
        
        local NotifyAccent = Create("Frame", {
            Size = UDim2.new(0, 4, 1, -16),
            Position = UDim2.new(0, 8, 0, 8),
            BackgroundColor3 = accentColor,
            BorderSizePixel = 0,
            Parent = NotifyFrame
        })
        AddCorner(NotifyAccent, 2)
        
        AddPadding(NotifyFrame, 12, 12, 20, 15)
        
        Create("TextLabel", {
            Size = UDim2.new(0, 20, 0, 20),
            BackgroundTransparency = 1,
            Text = icons[nType] or "ℹ",
            TextColor3 = accentColor,
            TextSize = 14,
            Font = Enum.Font.GothamBold,
            Parent = NotifyFrame
        })
        
        Create("TextLabel", {
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
        
        Create("TextLabel", {
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
        
        local ProgressBar = Create("Frame", {
            Size = UDim2.new(1, 0, 0, 3),
            Position = UDim2.new(0, 0, 1, 0),
            AnchorPoint = Vector2.new(0, 1),
            BackgroundColor3 = Theme.Tertiary,
            BorderSizePixel = 0,
            Parent = NotifyFrame
        })
        
        local ProgressFill = Create("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundColor3 = accentColor,
            BorderSizePixel = 0,
            Parent = ProgressBar
        })
        
        table.insert(Window.Notifications, NotifyFrame)
        
        Tween(NotifyFrame, {Position = UDim2.new(1, -320, 1, -yOff)}, 0.4, Enum.EasingStyle.Back)
        Tween(ProgressFill, {Size = UDim2.new(0, 0, 1, 0)}, duration, Enum.EasingStyle.Linear)
        
        task.spawn(function()
            task.wait(duration)
            Tween(NotifyFrame, {Position = UDim2.new(1, 20, 1, -yOff)}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
            task.wait(0.3)
            
            local i = table.find(Window.Notifications, NotifyFrame)
            if i then
                table.remove(Window.Notifications, i)
                for j, n in ipairs(Window.Notifications) do
                    Tween(n, {Position = UDim2.new(1, -320, 1, -(20 + (j - 1) * 90))}, 0.2)
                end
            end
            NotifyFrame:Destroy()
        end)
    end
    
    -- ════════════════════════════════════════════════════════════════════
    -- WINDOW METHODS
    -- ════════════════════════════════════════════════════════════════════
    
    local Visible = true
    
    function Window:Toggle()
        Visible = not Visible
        if Visible then
            MainFrame.Visible = true
            Tween(MainFrame, {Size = windowSize, Position = UDim2.new(0.5, -windowSize.X.Offset/2, 0.5, -windowSize.Y.Offset/2)}, 0.3, Enum.EasingStyle.Back)
        else
            Tween(MainFrame, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}, 0.3)
            task.wait(0.3)
            MainFrame.Visible = false
        end
    end
    
    function Window:Show()
        if not Visible then Window:Toggle() end
    end
    
    function Window:Hide()
        if Visible then Window:Toggle() end
    end
    
    function Window:Destroy()
        for _, c in pairs(Window.Connections) do
            if c then c:Disconnect() end
        end
        ScreenGui:Destroy()
    end
    
    -- Opening animation
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    Tween(MainFrame, {Size = windowSize, Position = UDim2.new(0.5, -windowSize.X.Offset/2, 0.5, -windowSize.Y.Offset/2)}, 0.5, Enum.EasingStyle.Back)
    
    return Window
end

return VogueLib
