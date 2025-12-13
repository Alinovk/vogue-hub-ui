--[[
    ╔══════════════════════════════════════════════════════════════════════╗
    ║                        VOGUE HUB UI LIBRARY                          ║
    ║                            Version 3.0.0                             ║
    ║                                                                      ║
    ║  Premium UI Library for Roblox                                       ║
    ║  License: MIT                                                        ║
    ╚══════════════════════════════════════════════════════════════════════╝
]]

local VogueLib = {Version = "3.0.0", Windows = {}}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Theme Definitions
local Themes = {
    Dark = {
        Primary = Color3.fromRGB(18, 18, 22),
        Secondary = Color3.fromRGB(25, 25, 32),
        Tertiary = Color3.fromRGB(35, 35, 45),
        Accent = Color3.fromRGB(138, 116, 249),
        AccentDark = Color3.fromRGB(108, 86, 219),
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(170, 170, 180),
        TextMuted = Color3.fromRGB(100, 100, 115),
        Divider = Color3.fromRGB(45, 45, 55),
        Success = Color3.fromRGB(87, 212, 139),
        Error = Color3.fromRGB(248, 113, 113),
        Warning = Color3.fromRGB(251, 191, 36)
    },
    Light = {
        Primary = Color3.fromRGB(250, 250, 252),
        Secondary = Color3.fromRGB(240, 240, 245),
        Tertiary = Color3.fromRGB(225, 225, 235),
        Accent = Color3.fromRGB(99, 91, 255),
        AccentDark = Color3.fromRGB(79, 71, 235),
        Text = Color3.fromRGB(20, 20, 30),
        TextDark = Color3.fromRGB(80, 80, 100),
        TextMuted = Color3.fromRGB(140, 140, 160),
        Divider = Color3.fromRGB(210, 210, 220),
        Success = Color3.fromRGB(34, 197, 94),
        Error = Color3.fromRGB(239, 68, 68),
        Warning = Color3.fromRGB(234, 179, 8)
    },
    Midnight = {
        Primary = Color3.fromRGB(13, 17, 23),
        Secondary = Color3.fromRGB(22, 27, 34),
        Tertiary = Color3.fromRGB(33, 38, 45),
        Accent = Color3.fromRGB(88, 166, 255),
        AccentDark = Color3.fromRGB(58, 136, 225),
        Text = Color3.fromRGB(230, 237, 243),
        TextDark = Color3.fromRGB(139, 148, 158),
        TextMuted = Color3.fromRGB(110, 118, 129),
        Divider = Color3.fromRGB(48, 54, 61),
        Success = Color3.fromRGB(63, 185, 80),
        Error = Color3.fromRGB(248, 81, 73),
        Warning = Color3.fromRGB(210, 153, 34)
    },
    Sunset = {
        Primary = Color3.fromRGB(24, 15, 25),
        Secondary = Color3.fromRGB(35, 22, 38),
        Tertiary = Color3.fromRGB(50, 32, 55),
        Accent = Color3.fromRGB(255, 107, 129),
        AccentDark = Color3.fromRGB(225, 77, 99),
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(200, 180, 195),
        TextMuted = Color3.fromRGB(140, 120, 135),
        Divider = Color3.fromRGB(70, 50, 75),
        Success = Color3.fromRGB(134, 239, 172),
        Error = Color3.fromRGB(251, 113, 133),
        Warning = Color3.fromRGB(253, 224, 71)
    },
    Ocean = {
        Primary = Color3.fromRGB(15, 23, 32),
        Secondary = Color3.fromRGB(22, 33, 46),
        Tertiary = Color3.fromRGB(32, 46, 62),
        Accent = Color3.fromRGB(56, 189, 248),
        AccentDark = Color3.fromRGB(26, 159, 218),
        Text = Color3.fromRGB(248, 250, 252),
        TextDark = Color3.fromRGB(148, 163, 184),
        TextMuted = Color3.fromRGB(100, 116, 139),
        Divider = Color3.fromRGB(51, 65, 85),
        Success = Color3.fromRGB(52, 211, 153),
        Error = Color3.fromRGB(251, 113, 133),
        Warning = Color3.fromRGB(251, 191, 36)
    }
}

-- Utility Functions
local function Tween(obj, props, duration, style, direction)
    local tween = TweenService:Create(
        obj,
        TweenInfo.new(duration or 0.2, style or Enum.EasingStyle.Quart, direction or Enum.EasingDirection.Out),
        props
    )
    tween:Play()
    return tween
end

local function Create(class, props)
    local obj = Instance.new(class)
    for k, v in pairs(props) do
        if k ~= "Parent" then obj[k] = v end
    end
    if props.Parent then obj.Parent = props.Parent end
    return obj
end

local function Ripple(parent, x, y, color)
    local circle = Create("Frame", {
        Parent = parent,
        BackgroundColor3 = color or Color3.new(1, 1, 1),
        BackgroundTransparency = 0.7,
        BorderSizePixel = 0,
        Position = UDim2.new(0, x - parent.AbsolutePosition.X, 0, y - parent.AbsolutePosition.Y),
        Size = UDim2.new(0, 0, 0, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        ZIndex = 10
    })
    Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = circle})
    local size = math.max(parent.AbsoluteSize.X, parent.AbsoluteSize.Y) * 2.5
    Tween(circle, {Size = UDim2.new(0, size, 0, size), BackgroundTransparency = 1}, 0.5)
    task.delay(0.5, function() if circle then circle:Destroy() end end)
end

-- Library Functions
function VogueLib:GetThemes()
    local list = {}
    for name in pairs(Themes) do table.insert(list, name) end
    return list
end

function VogueLib:AddTheme(name, colors)
    Themes[name] = colors
end


-- Main Window Creation
function VogueLib:CreateWindow(options)
    options = options or {}
    
    local Window = {
        Title = options.Title or "Vogue Hub",
        Size = options.Size or UDim2.new(0, 580, 0, 420),
        ThemeName = options.Theme or "Dark",
        Tabs = {},
        ActiveTab = nil,
        Minimized = false,
        Visible = true,
        Connections = {},
        Elements = {},
        Notifications = {}
    }
    
    local Theme = Themes[Window.ThemeName] or Themes.Dark
    
    -- Theme Registration System
    local function Register(obj, property, themeKey)
        table.insert(Window.Elements, {Object = obj, Property = property, ThemeKey = themeKey})
    end
    
    -- ScreenGui Setup
    local ScreenGui = Create("ScreenGui", {
        Name = "VogueUI_" .. tostring(math.random(1000, 9999)),
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })
    pcall(function() ScreenGui.Parent = CoreGui end)
    if not ScreenGui.Parent then ScreenGui.Parent = Player:WaitForChild("PlayerGui") end
    
    -- Main Frame
    local Main = Create("Frame", {
        Parent = ScreenGui,
        BackgroundColor3 = Theme.Primary,
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 0, 0, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        ClipsDescendants = true
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = Main})
    Register(Main, "BackgroundColor3", "Primary")
    
    -- Glow Border
    local BorderStroke = Create("UIStroke", {
        Parent = Main,
        Color = Theme.Accent,
        Thickness = 1.5,
        Transparency = 0.6
    })
    Register(BorderStroke, "Color", "Accent")
    
    -- Shadow
    Create("ImageLabel", {
        Parent = Main,
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.5, 4),
        Size = UDim2.new(1, 40, 1, 40),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Image = "rbxassetid://5554236805",
        ImageColor3 = Color3.new(0, 0, 0),
        ImageTransparency = 0.5,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(23, 23, 277, 277),
        ZIndex = -1
    })
    
    -- Header
    local Header = Create("Frame", {
        Parent = Main,
        BackgroundColor3 = Theme.Secondary,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 44),
        ZIndex = 5
    })
    Register(Header, "BackgroundColor3", "Secondary")
    
    Create("Frame", {
        Parent = Header,
        BackgroundColor3 = Theme.Secondary,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 1, -8),
        Size = UDim2.new(1, 0, 0, 8)
    })
    
    -- Title
    local TitleLabel = Create("TextLabel", {
        Parent = Header,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 14, 0, 0),
        Size = UDim2.new(0.6, 0, 1, 0),
        Font = Enum.Font.GothamBold,
        Text = Window.Title,
        TextColor3 = Theme.Text,
        TextSize = 15,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    Register(TitleLabel, "TextColor3", "Text")
    
    -- Window Controls
    local ControlsFrame = Create("Frame", {
        Parent = Header,
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -80, 0, 0),
        Size = UDim2.new(0, 70, 1, 0)
    })
    
    -- Minimize Button
    local MinBtn = Create("TextButton", {
        Parent = ControlsFrame,
        BackgroundColor3 = Theme.Tertiary,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0.5, -12),
        Size = UDim2.new(0, 24, 0, 24),
        Font = Enum.Font.GothamBold,
        Text = "−",
        TextColor3 = Theme.TextDark,
        TextSize = 18,
        AutoButtonColor = false
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = MinBtn})
    Register(MinBtn, "TextColor3", "TextDark")
    
    MinBtn.MouseEnter:Connect(function()
        Tween(MinBtn, {BackgroundTransparency = 0}, 0.15)
    end)
    MinBtn.MouseLeave:Connect(function()
        Tween(MinBtn, {BackgroundTransparency = 1}, 0.15)
    end)
    MinBtn.MouseButton1Click:Connect(function()
        Window.Minimized = not Window.Minimized
        if Window.Minimized then
            Tween(Main, {Size = UDim2.new(0, Window.Size.X.Offset, 0, 44)}, 0.3, Enum.EasingStyle.Back)
        else
            Tween(Main, {Size = Window.Size}, 0.3, Enum.EasingStyle.Back)
        end
    end)
    
    -- Close Button
    local CloseBtn = Create("TextButton", {
        Parent = ControlsFrame,
        BackgroundColor3 = Theme.Error,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 34, 0.5, -12),
        Size = UDim2.new(0, 24, 0, 24),
        Font = Enum.Font.GothamBold,
        Text = "×",
        TextColor3 = Theme.TextDark,
        TextSize = 20,
        AutoButtonColor = false
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = CloseBtn})
    Register(CloseBtn, "TextColor3", "TextDark")
    
    CloseBtn.MouseEnter:Connect(function()
        Tween(CloseBtn, {BackgroundTransparency = 0, TextColor3 = Color3.new(1, 1, 1)}, 0.15)
    end)
    CloseBtn.MouseLeave:Connect(function()
        Tween(CloseBtn, {BackgroundTransparency = 1, TextColor3 = Theme.TextDark}, 0.15)
    end)
    CloseBtn.MouseButton1Click:Connect(function()
        Window:Destroy()
    end)
    
    -- Dragging
    local Dragging, DragStart, StartPos = false, nil, nil
    Header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            DragStart = input.Position
            StartPos = Main.Position
        end
    end)
    Header.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = false
        end
    end)
    
    local dragConn = UserInputService.InputChanged:Connect(function(input)
        if Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - DragStart
            Main.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + delta.X, StartPos.Y.Scale, StartPos.Y.Offset + delta.Y)
        end
    end)
    table.insert(Window.Connections, dragConn)

    
    -- Sidebar (Tab Container)
    local Sidebar = Create("Frame", {
        Parent = Main,
        BackgroundColor3 = Theme.Secondary,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 44),
        Size = UDim2.new(0, 130, 1, -44)
    })
    Register(Sidebar, "BackgroundColor3", "Secondary")
    
    local SidebarDivider = Create("Frame", {
        Parent = Sidebar,
        BackgroundColor3 = Theme.Divider,
        BorderSizePixel = 0,
        Position = UDim2.new(1, -1, 0, 8),
        Size = UDim2.new(0, 1, 1, -16)
    })
    Register(SidebarDivider, "BackgroundColor3", "Divider")
    
    local TabList = Create("ScrollingFrame", {
        Parent = Sidebar,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 6, 0, 6),
        Size = UDim2.new(1, -12, 1, -12),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 2,
        ScrollBarImageColor3 = Theme.Accent,
        ScrollBarImageTransparency = 0.5
    })
    Register(TabList, "ScrollBarImageColor3", "Accent")
    
    local TabListLayout = Create("UIListLayout", {
        Parent = TabList,
        Padding = UDim.new(0, 4),
        SortOrder = Enum.SortOrder.LayoutOrder
    })
    TabListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabList.CanvasSize = UDim2.new(0, 0, 0, TabListLayout.AbsoluteContentSize.Y + 4)
    end)
    
    -- Content Area
    local ContentArea = Create("Frame", {
        Parent = Main,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 138, 0, 52),
        Size = UDim2.new(1, -146, 1, -60),
        ClipsDescendants = true
    })
    
    -- Notification Container
    local NotifContainer = Create("Frame", {
        Parent = ScreenGui,
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -320, 1, -20),
        Size = UDim2.new(0, 300, 0, 400),
        AnchorPoint = Vector2.new(0, 1),
        ClipsDescendants = false
    })
    
    local NotifLayout = Create("UIListLayout", {
        Parent = NotifContainer,
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Bottom,
        HorizontalAlignment = Enum.HorizontalAlignment.Right
    })
    
    -- Opening Animation
    Tween(Main, {Size = Window.Size}, 0.4, Enum.EasingStyle.Back)
    
    -- ═══════════════════════════════════════════════════════════════
    -- WINDOW METHODS
    -- ═══════════════════════════════════════════════════════════════
    
    function Window:SetTheme(themeName)
        local newTheme = Themes[themeName]
        if not newTheme then return false end
        
        Theme = newTheme
        Window.ThemeName = themeName
        
        for _, el in ipairs(Window.Elements) do
            if el.Object and el.Object.Parent then
                pcall(function()
                    local targetValue = Theme[el.ThemeKey]
                    if targetValue then
                        Tween(el.Object, {[el.Property] = targetValue}, 0.3)
                    end
                end)
            end
        end
        return true
    end
    
    function Window:Toggle()
        Window.Visible = not Window.Visible
        if Window.Visible then
            ScreenGui.Enabled = true
            Tween(Main, {Size = Window.Minimized and UDim2.new(0, Window.Size.X.Offset, 0, 44) or Window.Size}, 0.3, Enum.EasingStyle.Back)
        else
            Tween(Main, {Size = UDim2.new(0, 0, 0, 0)}, 0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In)
            task.delay(0.25, function()
                if not Window.Visible then ScreenGui.Enabled = false end
            end)
        end
    end
    
    function Window:Show()
        Window.Visible = true
        ScreenGui.Enabled = true
        Tween(Main, {Size = Window.Minimized and UDim2.new(0, Window.Size.X.Offset, 0, 44) or Window.Size}, 0.3, Enum.EasingStyle.Back)
    end
    
    function Window:Hide()
        Window.Visible = false
        Tween(Main, {Size = UDim2.new(0, 0, 0, 0)}, 0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        task.delay(0.25, function()
            if not Window.Visible then ScreenGui.Enabled = false end
        end)
    end
    
    function Window:Destroy()
        for _, conn in pairs(Window.Connections) do
            pcall(function() conn:Disconnect() end)
        end
        Tween(Main, {Size = UDim2.new(0, 0, 0, 0)}, 0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        task.delay(0.3, function()
            ScreenGui:Destroy()
        end)
    end

    
    -- ═══════════════════════════════════════════════════════════════
    -- NOTIFICATION SYSTEM
    -- ═══════════════════════════════════════════════════════════════
    
    function Window:Notify(options)
        options = options or {}
        local title = options.Title or "Notification"
        local content = options.Content or ""
        local duration = options.Duration or 3
        local notifType = options.Type or "info"
        
        local typeColors = {
            info = Theme.Accent,
            success = Theme.Success,
            warning = Theme.Warning,
            error = Theme.Error
        }
        local accentColor = typeColors[notifType] or Theme.Accent
        
        local NotifFrame = Create("Frame", {
            Parent = NotifContainer,
            BackgroundColor3 = Theme.Secondary,
            BorderSizePixel = 0,
            Size = UDim2.new(0, 280, 0, 0),
            ClipsDescendants = true
        })
        Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = NotifFrame})
        Register(NotifFrame, "BackgroundColor3", "Secondary")
        
        local NotifStroke = Create("UIStroke", {
            Parent = NotifFrame,
            Color = accentColor,
            Thickness = 1,
            Transparency = 0.7
        })
        
        -- Accent Bar
        local AccentBar = Create("Frame", {
            Parent = NotifFrame,
            BackgroundColor3 = accentColor,
            BorderSizePixel = 0,
            Size = UDim2.new(0, 3, 1, 0)
        })
        Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = AccentBar})
        
        -- Title
        local NotifTitle = Create("TextLabel", {
            Parent = NotifFrame,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 12, 0, 8),
            Size = UDim2.new(1, -20, 0, 18),
            Font = Enum.Font.GothamBold,
            Text = title,
            TextColor3 = Theme.Text,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left
        })
        Register(NotifTitle, "TextColor3", "Text")
        
        -- Content
        local NotifContent = Create("TextLabel", {
            Parent = NotifFrame,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 12, 0, 26),
            Size = UDim2.new(1, -20, 0, 30),
            Font = Enum.Font.Gotham,
            Text = content,
            TextColor3 = Theme.TextDark,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            TextWrapped = true
        })
        Register(NotifContent, "TextColor3", "TextDark")
        
        -- Progress Bar
        local ProgressBg = Create("Frame", {
            Parent = NotifFrame,
            BackgroundColor3 = Theme.Tertiary,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 1, -3),
            Size = UDim2.new(1, 0, 0, 3)
        })
        Register(ProgressBg, "BackgroundColor3", "Tertiary")
        
        local ProgressFill = Create("Frame", {
            Parent = ProgressBg,
            BackgroundColor3 = accentColor,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 1, 0)
        })
        Create("UICorner", {CornerRadius = UDim.new(0, 2), Parent = ProgressFill})
        
        -- Animate In
        Tween(NotifFrame, {Size = UDim2.new(0, 280, 0, 70)}, 0.3, Enum.EasingStyle.Back)
        
        -- Progress Animation
        Tween(ProgressFill, {Size = UDim2.new(0, 0, 1, 0)}, duration, Enum.EasingStyle.Linear)
        
        -- Auto Remove
        task.delay(duration, function()
            Tween(NotifFrame, {Size = UDim2.new(0, 280, 0, 0)}, 0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In)
            task.delay(0.3, function()
                if NotifFrame then NotifFrame:Destroy() end
            end)
        end)
    end
    
    -- ═══════════════════════════════════════════════════════════════
    -- TAB CREATION
    -- ═══════════════════════════════════════════════════════════════
    
    function Window:CreateTab(options)
        options = options or {}
        local Tab = {
            Name = options.Name or "Tab",
            Icon = options.Icon or "",
            Sections = {},
            Button = nil,
            Container = nil
        }
        
        -- Tab Button
        local TabBtn = Create("TextButton", {
            Parent = TabList,
            BackgroundColor3 = Theme.Tertiary,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 32),
            Font = Enum.Font.Gotham,
            Text = "",
            AutoButtonColor = false
        })
        Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = TabBtn})
        Tab.Button = TabBtn
        
        local TabIcon = Create("TextLabel", {
            Parent = TabBtn,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 8, 0, 0),
            Size = UDim2.new(0, 20, 1, 0),
            Font = Enum.Font.Gotham,
            Text = Tab.Icon,
            TextColor3 = Theme.TextDark,
            TextSize = 14
        })
        
        local TabText = Create("TextLabel", {
            Parent = TabBtn,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 30, 0, 0),
            Size = UDim2.new(1, -38, 1, 0),
            Font = Enum.Font.GothamMedium,
            Text = Tab.Name,
            TextColor3 = Theme.TextDark,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left
        })
        Register(TabText, "TextColor3", "TextDark")
        
        -- Active Indicator
        local ActiveIndicator = Create("Frame", {
            Parent = TabBtn,
            BackgroundColor3 = Theme.Accent,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0.5, -8),
            Size = UDim2.new(0, 3, 0, 16),
            BackgroundTransparency = 1
        })
        Create("UICorner", {CornerRadius = UDim.new(0, 2), Parent = ActiveIndicator})
        Register(ActiveIndicator, "BackgroundColor3", "Accent")
        
        -- Tab Content Container
        local TabContainer = Create("ScrollingFrame", {
            Parent = ContentArea,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 1, 0),
            CanvasSize = UDim2.new(0, 0, 0, 0),
            ScrollBarThickness = 3,
            ScrollBarImageColor3 = Theme.Accent,
            ScrollBarImageTransparency = 0.5,
            Visible = false
        })
        Register(TabContainer, "ScrollBarImageColor3", "Accent")
        Tab.Container = TabContainer
        
        local ContentLayout = Create("UIListLayout", {
            Parent = TabContainer,
            Padding = UDim.new(0, 8),
            SortOrder = Enum.SortOrder.LayoutOrder
        })
        Create("UIPadding", {Parent = TabContainer, PaddingRight = UDim.new(0, 6)})
        
        ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContainer.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 8)
        end)
        
        -- Tab Selection
        local function SelectTab()
            -- Deselect all tabs
            for _, t in pairs(Window.Tabs) do
                if t.Button then
                    Tween(t.Button, {BackgroundTransparency = 1}, 0.2)
                    local indicator = t.Button:FindFirstChild("Frame")
                    if indicator then Tween(indicator, {BackgroundTransparency = 1}, 0.2) end
                end
                if t.Container then t.Container.Visible = false end
            end
            
            -- Select this tab
            Tween(TabBtn, {BackgroundTransparency = 0.9}, 0.2)
            Tween(ActiveIndicator, {BackgroundTransparency = 0}, 0.2)
            TabContainer.Visible = true
            Window.ActiveTab = Tab
        end
        
        TabBtn.MouseEnter:Connect(function()
            if Window.ActiveTab ~= Tab then
                Tween(TabBtn, {BackgroundTransparency = 0.95}, 0.15)
            end
        end)
        TabBtn.MouseLeave:Connect(function()
            if Window.ActiveTab ~= Tab then
                Tween(TabBtn, {BackgroundTransparency = 1}, 0.15)
            end
        end)
        TabBtn.MouseButton1Click:Connect(SelectTab)
        
        table.insert(Window.Tabs, Tab)
        
        -- Auto-select first tab
        if #Window.Tabs == 1 then
            SelectTab()
        end

        
        -- ═══════════════════════════════════════════════════════════════
        -- SECTION CREATION
        -- ═══════════════════════════════════════════════════════════════
        
        function Tab:CreateSection(name)
            local Section = {Name = name or "Section", Elements = {}}
            
            local SectionFrame = Create("Frame", {
                Parent = TabContainer,
                BackgroundColor3 = Theme.Secondary,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 36),
                AutomaticSize = Enum.AutomaticSize.Y
            })
            Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = SectionFrame})
            Register(SectionFrame, "BackgroundColor3", "Secondary")
            
            local SectionPadding = Create("UIPadding", {
                Parent = SectionFrame,
                PaddingTop = UDim.new(0, 8),
                PaddingBottom = UDim.new(0, 8),
                PaddingLeft = UDim.new(0, 10),
                PaddingRight = UDim.new(0, 10)
            })
            
            local SectionLayout = Create("UIListLayout", {
                Parent = SectionFrame,
                Padding = UDim.new(0, 6),
                SortOrder = Enum.SortOrder.LayoutOrder
            })
            
            -- Section Header
            local SectionHeader = Create("TextLabel", {
                Parent = SectionFrame,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 18),
                Font = Enum.Font.GothamBold,
                Text = Section.Name,
                TextColor3 = Theme.TextDark,
                TextSize = 11,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            Register(SectionHeader, "TextColor3", "TextDark")
            
            table.insert(Tab.Sections, Section)
            
            -- ═══════════════════════════════════════════════════════════════
            -- BUTTON
            -- ═══════════════════════════════════════════════════════════════
            
            function Section:CreateButton(opts)
                opts = opts or {}
                local name = opts.Name or "Button"
                local icon = opts.Icon or ""
                local callback = opts.Callback or function() end
                
                local Btn = Create("TextButton", {
                    Parent = SectionFrame,
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 32),
                    Font = Enum.Font.Gotham,
                    Text = "",
                    AutoButtonColor = false,
                    ClipsDescendants = true
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = Btn})
                Register(Btn, "BackgroundColor3", "Tertiary")
                
                local BtnText = Create("TextLabel", {
                    Parent = Btn,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, icon ~= "" and 32 or 10, 0, 0),
                    Size = UDim2.new(1, -40, 1, 0),
                    Font = Enum.Font.GothamMedium,
                    Text = name,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left
                })
                Register(BtnText, "TextColor3", "Text")
                
                if icon ~= "" then
                    Create("TextLabel", {
                        Parent = Btn,
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 10, 0, 0),
                        Size = UDim2.new(0, 20, 1, 0),
                        Font = Enum.Font.Gotham,
                        Text = icon,
                        TextColor3 = Theme.TextDark,
                        TextSize = 14
                    })
                end
                
                Btn.MouseEnter:Connect(function()
                    Tween(Btn, {BackgroundColor3 = Theme.Accent}, 0.15)
                end)
                Btn.MouseLeave:Connect(function()
                    Tween(Btn, {BackgroundColor3 = Theme.Tertiary}, 0.15)
                end)
                Btn.MouseButton1Click:Connect(function()
                    Ripple(Btn, Mouse.X, Mouse.Y, Theme.Text)
                    pcall(callback)
                end)
                
                return {Button = Btn}
            end
            
            -- ═══════════════════════════════════════════════════════════════
            -- TOGGLE
            -- ═══════════════════════════════════════════════════════════════
            
            function Section:CreateToggle(opts)
                opts = opts or {}
                local name = opts.Name or "Toggle"
                local icon = opts.Icon or ""
                local default = opts.Default or false
                local callback = opts.Callback or function() end
                
                local Value = default
                
                local ToggleFrame = Create("Frame", {
                    Parent = SectionFrame,
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 32)
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = ToggleFrame})
                Register(ToggleFrame, "BackgroundColor3", "Tertiary")
                
                local ToggleText = Create("TextLabel", {
                    Parent = ToggleFrame,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, icon ~= "" and 32 or 10, 0, 0),
                    Size = UDim2.new(1, -70, 1, 0),
                    Font = Enum.Font.GothamMedium,
                    Text = name,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left
                })
                Register(ToggleText, "TextColor3", "Text")
                
                if icon ~= "" then
                    Create("TextLabel", {
                        Parent = ToggleFrame,
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 10, 0, 0),
                        Size = UDim2.new(0, 20, 1, 0),
                        Font = Enum.Font.Gotham,
                        Text = icon,
                        TextColor3 = Theme.TextDark,
                        TextSize = 14
                    })
                end
                
                -- Toggle Switch
                local SwitchBg = Create("Frame", {
                    Parent = ToggleFrame,
                    BackgroundColor3 = Value and Theme.Accent or Theme.Primary,
                    BorderSizePixel = 0,
                    Position = UDim2.new(1, -50, 0.5, -10),
                    Size = UDim2.new(0, 40, 0, 20)
                })
                Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = SwitchBg})
                Register(SwitchBg, "BackgroundColor3", Value and "Accent" or "Primary")
                
                local SwitchCircle = Create("Frame", {
                    Parent = SwitchBg,
                    BackgroundColor3 = Theme.Text,
                    BorderSizePixel = 0,
                    Position = Value and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8),
                    Size = UDim2.new(0, 16, 0, 16)
                })
                Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = SwitchCircle})
                
                local ToggleBtn = Create("TextButton", {
                    Parent = ToggleFrame,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    Text = ""
                })
                
                local function UpdateToggle()
                    if Value then
                        Tween(SwitchBg, {BackgroundColor3 = Theme.Accent}, 0.2)
                        Tween(SwitchCircle, {Position = UDim2.new(1, -18, 0.5, -8)}, 0.2)
                    else
                        Tween(SwitchBg, {BackgroundColor3 = Theme.Primary}, 0.2)
                        Tween(SwitchCircle, {Position = UDim2.new(0, 2, 0.5, -8)}, 0.2)
                    end
                end
                
                ToggleBtn.MouseButton1Click:Connect(function()
                    Value = not Value
                    UpdateToggle()
                    pcall(callback, Value)
                end)
                
                local Toggle = {}
                function Toggle:Set(val)
                    Value = val
                    UpdateToggle()
                    pcall(callback, Value)
                end
                function Toggle:Get() return Value end
                
                return Toggle
            end

            
            -- ═══════════════════════════════════════════════════════════════
            -- SLIDER
            -- ═══════════════════════════════════════════════════════════════
            
            function Section:CreateSlider(opts)
                opts = opts or {}
                local name = opts.Name or "Slider"
                local icon = opts.Icon or ""
                local min = opts.Min or 0
                local max = opts.Max or 100
                local default = opts.Default or min
                local increment = opts.Increment or 1
                local callback = opts.Callback or function() end
                
                local Value = default
                
                local SliderFrame = Create("Frame", {
                    Parent = SectionFrame,
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 48)
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = SliderFrame})
                Register(SliderFrame, "BackgroundColor3", "Tertiary")
                
                local SliderText = Create("TextLabel", {
                    Parent = SliderFrame,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, icon ~= "" and 32 or 10, 0, 0),
                    Size = UDim2.new(0.6, 0, 0, 24),
                    Font = Enum.Font.GothamMedium,
                    Text = name,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left
                })
                Register(SliderText, "TextColor3", "Text")
                
                if icon ~= "" then
                    Create("TextLabel", {
                        Parent = SliderFrame,
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 10, 0, 0),
                        Size = UDim2.new(0, 20, 0, 24),
                        Font = Enum.Font.Gotham,
                        Text = icon,
                        TextColor3 = Theme.TextDark,
                        TextSize = 14
                    })
                end
                
                local ValueLabel = Create("TextLabel", {
                    Parent = SliderFrame,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(1, -50, 0, 0),
                    Size = UDim2.new(0, 40, 0, 24),
                    Font = Enum.Font.GothamMedium,
                    Text = tostring(Value),
                    TextColor3 = Theme.Accent,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Right
                })
                Register(ValueLabel, "TextColor3", "Accent")
                
                -- Slider Track
                local SliderTrack = Create("Frame", {
                    Parent = SliderFrame,
                    BackgroundColor3 = Theme.Primary,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 10, 0, 30),
                    Size = UDim2.new(1, -20, 0, 6)
                })
                Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = SliderTrack})
                Register(SliderTrack, "BackgroundColor3", "Primary")
                
                local SliderFill = Create("Frame", {
                    Parent = SliderTrack,
                    BackgroundColor3 = Theme.Accent,
                    BorderSizePixel = 0,
                    Size = UDim2.new((Value - min) / (max - min), 0, 1, 0)
                })
                Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = SliderFill})
                Register(SliderFill, "BackgroundColor3", "Accent")
                
                local SliderKnob = Create("Frame", {
                    Parent = SliderFill,
                    BackgroundColor3 = Theme.Text,
                    BorderSizePixel = 0,
                    Position = UDim2.new(1, -7, 0.5, -7),
                    Size = UDim2.new(0, 14, 0, 14),
                    AnchorPoint = Vector2.new(0, 0)
                })
                Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = SliderKnob})
                
                local SliderBtn = Create("TextButton", {
                    Parent = SliderTrack,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 10),
                    Position = UDim2.new(0, 0, 0, -5),
                    Text = ""
                })
                
                local Dragging = false
                
                local function UpdateSlider(input)
                    local pos = math.clamp((input.Position.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X, 0, 1)
                    local rawValue = min + (max - min) * pos
                    Value = math.floor(rawValue / increment + 0.5) * increment
                    Value = math.clamp(Value, min, max)
                    
                    local displayValue = Value
                    if increment < 1 then
                        displayValue = math.floor(Value * 100) / 100
                    end
                    
                    ValueLabel.Text = tostring(displayValue)
                    Tween(SliderFill, {Size = UDim2.new((Value - min) / (max - min), 0, 1, 0)}, 0.1)
                    pcall(callback, Value)
                end
                
                SliderBtn.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        Dragging = true
                        UpdateSlider(input)
                    end
                end)
                
                SliderBtn.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        Dragging = false
                    end
                end)
                
                local sliderConn = UserInputService.InputChanged:Connect(function(input)
                    if Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        UpdateSlider(input)
                    end
                end)
                table.insert(Window.Connections, sliderConn)
                
                local Slider = {}
                function Slider:Set(val)
                    Value = math.clamp(val, min, max)
                    ValueLabel.Text = tostring(Value)
                    SliderFill.Size = UDim2.new((Value - min) / (max - min), 0, 1, 0)
                    pcall(callback, Value)
                end
                function Slider:Get() return Value end
                
                return Slider
            end

            
            -- ═══════════════════════════════════════════════════════════════
            -- DROPDOWN
            -- ═══════════════════════════════════════════════════════════════
            
            function Section:CreateDropdown(opts)
                opts = opts or {}
                local name = opts.Name or "Dropdown"
                local icon = opts.Icon or ""
                local options = opts.Options or {}
                local default = opts.Default or (options[1] or "")
                local callback = opts.Callback or function() end
                
                local Value = default
                local Open = false
                
                local DropdownFrame = Create("Frame", {
                    Parent = SectionFrame,
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 32),
                    ClipsDescendants = true
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = DropdownFrame})
                Register(DropdownFrame, "BackgroundColor3", "Tertiary")
                
                local DropdownText = Create("TextLabel", {
                    Parent = DropdownFrame,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, icon ~= "" and 32 or 10, 0, 0),
                    Size = UDim2.new(0.5, 0, 0, 32),
                    Font = Enum.Font.GothamMedium,
                    Text = name,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left
                })
                Register(DropdownText, "TextColor3", "Text")
                
                if icon ~= "" then
                    Create("TextLabel", {
                        Parent = DropdownFrame,
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 10, 0, 0),
                        Size = UDim2.new(0, 20, 0, 32),
                        Font = Enum.Font.Gotham,
                        Text = icon,
                        TextColor3 = Theme.TextDark,
                        TextSize = 14
                    })
                end
                
                local SelectedLabel = Create("TextLabel", {
                    Parent = DropdownFrame,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0.5, 0, 0, 0),
                    Size = UDim2.new(0.5, -30, 0, 32),
                    Font = Enum.Font.Gotham,
                    Text = Value,
                    TextColor3 = Theme.Accent,
                    TextSize = 11,
                    TextXAlignment = Enum.TextXAlignment.Right
                })
                Register(SelectedLabel, "TextColor3", "Accent")
                
                local Arrow = Create("TextLabel", {
                    Parent = DropdownFrame,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(1, -25, 0, 0),
                    Size = UDim2.new(0, 20, 0, 32),
                    Font = Enum.Font.GothamBold,
                    Text = "▼",
                    TextColor3 = Theme.TextDark,
                    TextSize = 10,
                    Rotation = 0
                })
                Register(Arrow, "TextColor3", "TextDark")
                
                local OptionsContainer = Create("Frame", {
                    Parent = DropdownFrame,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 4, 0, 36),
                    Size = UDim2.new(1, -8, 0, 0)
                })
                
                local OptionsLayout = Create("UIListLayout", {
                    Parent = OptionsContainer,
                    Padding = UDim.new(0, 2),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
                
                local DropdownBtn = Create("TextButton", {
                    Parent = DropdownFrame,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 32),
                    Text = ""
                })
                
                local function CreateOptions()
                    for _, child in pairs(OptionsContainer:GetChildren()) do
                        if child:IsA("TextButton") then child:Destroy() end
                    end
                    
                    for _, opt in ipairs(options) do
                        local OptBtn = Create("TextButton", {
                            Parent = OptionsContainer,
                            BackgroundColor3 = Theme.Primary,
                            BorderSizePixel = 0,
                            Size = UDim2.new(1, 0, 0, 26),
                            Font = Enum.Font.Gotham,
                            Text = opt,
                            TextColor3 = opt == Value and Theme.Accent or Theme.TextDark,
                            TextSize = 11,
                            AutoButtonColor = false
                        })
                        Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = OptBtn})
                        
                        OptBtn.MouseEnter:Connect(function()
                            Tween(OptBtn, {BackgroundColor3 = Theme.Secondary}, 0.1)
                        end)
                        OptBtn.MouseLeave:Connect(function()
                            Tween(OptBtn, {BackgroundColor3 = Theme.Primary}, 0.1)
                        end)
                        OptBtn.MouseButton1Click:Connect(function()
                            Value = opt
                            SelectedLabel.Text = Value
                            for _, c in pairs(OptionsContainer:GetChildren()) do
                                if c:IsA("TextButton") then
                                    c.TextColor3 = c.Text == Value and Theme.Accent or Theme.TextDark
                                end
                            end
                            pcall(callback, Value)
                            
                            -- Close dropdown
                            Open = false
                            Tween(Arrow, {Rotation = 0}, 0.2)
                            Tween(DropdownFrame, {Size = UDim2.new(1, 0, 0, 32)}, 0.2)
                        end)
                    end
                end
                
                CreateOptions()
                
                local function ToggleDropdown()
                    Open = not Open
                    local optHeight = #options * 28 + 8
                    Tween(Arrow, {Rotation = Open and 180 or 0}, 0.2)
                    Tween(DropdownFrame, {Size = UDim2.new(1, 0, 0, Open and (32 + optHeight) or 32)}, 0.2)
                end
                
                DropdownBtn.MouseButton1Click:Connect(ToggleDropdown)
                
                local Dropdown = {}
                function Dropdown:Set(val)
                    if table.find(options, val) then
                        Value = val
                        SelectedLabel.Text = Value
                        for _, c in pairs(OptionsContainer:GetChildren()) do
                            if c:IsA("TextButton") then
                                c.TextColor3 = c.Text == Value and Theme.Accent or Theme.TextDark
                            end
                        end
                        pcall(callback, Value)
                    end
                end
                function Dropdown:Get() return Value end
                function Dropdown:Refresh(newOptions)
                    options = newOptions
                    CreateOptions()
                    if not table.find(options, Value) then
                        Value = options[1] or ""
                        SelectedLabel.Text = Value
                    end
                end
                
                return Dropdown
            end

            
            -- ═══════════════════════════════════════════════════════════════
            -- TEXTBOX
            -- ═══════════════════════════════════════════════════════════════
            
            function Section:CreateTextBox(opts)
                opts = opts or {}
                local name = opts.Name or "TextBox"
                local icon = opts.Icon or ""
                local placeholder = opts.Placeholder or "Enter text..."
                local default = opts.Default or ""
                local callback = opts.Callback or function() end
                
                local Value = default
                
                local TextBoxFrame = Create("Frame", {
                    Parent = SectionFrame,
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 32)
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = TextBoxFrame})
                Register(TextBoxFrame, "BackgroundColor3", "Tertiary")
                
                local TextBoxLabel = Create("TextLabel", {
                    Parent = TextBoxFrame,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, icon ~= "" and 32 or 10, 0, 0),
                    Size = UDim2.new(0.4, 0, 1, 0),
                    Font = Enum.Font.GothamMedium,
                    Text = name,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left
                })
                Register(TextBoxLabel, "TextColor3", "Text")
                
                if icon ~= "" then
                    Create("TextLabel", {
                        Parent = TextBoxFrame,
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 10, 0, 0),
                        Size = UDim2.new(0, 20, 1, 0),
                        Font = Enum.Font.Gotham,
                        Text = icon,
                        TextColor3 = Theme.TextDark,
                        TextSize = 14
                    })
                end
                
                local InputBox = Create("TextBox", {
                    Parent = TextBoxFrame,
                    BackgroundColor3 = Theme.Primary,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0.45, 0, 0.5, -11),
                    Size = UDim2.new(0.52, 0, 0, 22),
                    Font = Enum.Font.Gotham,
                    Text = Value,
                    PlaceholderText = placeholder,
                    PlaceholderColor3 = Theme.TextMuted,
                    TextColor3 = Theme.Text,
                    TextSize = 11,
                    ClearTextOnFocus = false
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = InputBox})
                Create("UIPadding", {Parent = InputBox, PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 6)})
                Register(InputBox, "BackgroundColor3", "Primary")
                Register(InputBox, "TextColor3", "Text")
                Register(InputBox, "PlaceholderColor3", "TextMuted")
                
                InputBox.FocusLost:Connect(function(enterPressed)
                    Value = InputBox.Text
                    if enterPressed then
                        pcall(callback, Value)
                    end
                end)
                
                local TextBox = {}
                function TextBox:Set(text)
                    Value = text
                    InputBox.Text = text
                end
                function TextBox:Get() return Value end
                
                return TextBox
            end
            
            -- ═══════════════════════════════════════════════════════════════
            -- KEYBIND
            -- ═══════════════════════════════════════════════════════════════
            
            function Section:CreateKeybind(opts)
                opts = opts or {}
                local name = opts.Name or "Keybind"
                local icon = opts.Icon or ""
                local default = opts.Default or Enum.KeyCode.Unknown
                local callback = opts.Callback or function() end
                
                local Value = default
                local Listening = false
                
                local KeybindFrame = Create("Frame", {
                    Parent = SectionFrame,
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 32)
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = KeybindFrame})
                Register(KeybindFrame, "BackgroundColor3", "Tertiary")
                
                local KeybindText = Create("TextLabel", {
                    Parent = KeybindFrame,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, icon ~= "" and 32 or 10, 0, 0),
                    Size = UDim2.new(0.6, 0, 1, 0),
                    Font = Enum.Font.GothamMedium,
                    Text = name,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left
                })
                Register(KeybindText, "TextColor3", "Text")
                
                if icon ~= "" then
                    Create("TextLabel", {
                        Parent = KeybindFrame,
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 10, 0, 0),
                        Size = UDim2.new(0, 20, 1, 0),
                        Font = Enum.Font.Gotham,
                        Text = icon,
                        TextColor3 = Theme.TextDark,
                        TextSize = 14
                    })
                end
                
                local KeyBtn = Create("TextButton", {
                    Parent = KeybindFrame,
                    BackgroundColor3 = Theme.Primary,
                    BorderSizePixel = 0,
                    Position = UDim2.new(1, -70, 0.5, -11),
                    Size = UDim2.new(0, 60, 0, 22),
                    Font = Enum.Font.GothamMedium,
                    Text = Value.Name or "None",
                    TextColor3 = Theme.Accent,
                    TextSize = 10,
                    AutoButtonColor = false
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = KeyBtn})
                Register(KeyBtn, "BackgroundColor3", "Primary")
                Register(KeyBtn, "TextColor3", "Accent")
                
                KeyBtn.MouseButton1Click:Connect(function()
                    Listening = true
                    KeyBtn.Text = "..."
                    Tween(KeyBtn, {BackgroundColor3 = Theme.Accent}, 0.15)
                    Tween(KeyBtn, {TextColor3 = Theme.Primary}, 0.15)
                end)
                
                local keybindConn = UserInputService.InputBegan:Connect(function(input, processed)
                    if Listening then
                        if input.KeyCode == Enum.KeyCode.Escape then
                            Value = Enum.KeyCode.Unknown
                            KeyBtn.Text = "None"
                        elseif input.KeyCode ~= Enum.KeyCode.Unknown then
                            Value = input.KeyCode
                            KeyBtn.Text = Value.Name
                        end
                        Listening = false
                        Tween(KeyBtn, {BackgroundColor3 = Theme.Primary}, 0.15)
                        Tween(KeyBtn, {TextColor3 = Theme.Accent}, 0.15)
                    elseif not processed and input.KeyCode == Value and Value ~= Enum.KeyCode.Unknown then
                        pcall(callback)
                    end
                end)
                table.insert(Window.Connections, keybindConn)
                
                local Keybind = {}
                function Keybind:Set(key)
                    Value = key
                    KeyBtn.Text = Value.Name or "None"
                end
                function Keybind:Get() return Value end
                
                return Keybind
            end

            
            -- ═══════════════════════════════════════════════════════════════
            -- LABEL
            -- ═══════════════════════════════════════════════════════════════
            
            function Section:CreateLabel(text)
                local LabelFrame = Create("Frame", {
                    Parent = SectionFrame,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 20)
                })
                
                local LabelText = Create("TextLabel", {
                    Parent = LabelFrame,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    Font = Enum.Font.Gotham,
                    Text = text or "",
                    TextColor3 = Theme.TextDark,
                    TextSize = 11,
                    TextXAlignment = Enum.TextXAlignment.Left
                })
                Register(LabelText, "TextColor3", "TextDark")
                
                local Label = {}
                function Label:Set(newText)
                    LabelText.Text = newText
                end
                function Label:Get() return LabelText.Text end
                
                return Label
            end
            
            -- ═══════════════════════════════════════════════════════════════
            -- SEPARATOR
            -- ═══════════════════════════════════════════════════════════════
            
            function Section:CreateSeparator()
                local SepFrame = Create("Frame", {
                    Parent = SectionFrame,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 8)
                })
                
                local SepLine = Create("Frame", {
                    Parent = SepFrame,
                    BackgroundColor3 = Theme.Divider,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 0, 0.5, 0),
                    Size = UDim2.new(1, 0, 0, 1)
                })
                Register(SepLine, "BackgroundColor3", "Divider")
            end
            
            -- ═══════════════════════════════════════════════════════════════
            -- PROGRESS BAR
            -- ═══════════════════════════════════════════════════════════════
            
            function Section:CreateProgressBar(opts)
                opts = opts or {}
                local name = opts.Name or "Progress"
                local icon = opts.Icon or ""
                local default = opts.Default or 0
                local max = opts.Max or 100
                
                local Value = default
                
                local ProgressFrame = Create("Frame", {
                    Parent = SectionFrame,
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 42)
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = ProgressFrame})
                Register(ProgressFrame, "BackgroundColor3", "Tertiary")
                
                local ProgressText = Create("TextLabel", {
                    Parent = ProgressFrame,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, icon ~= "" and 32 or 10, 0, 0),
                    Size = UDim2.new(0.6, 0, 0, 22),
                    Font = Enum.Font.GothamMedium,
                    Text = name,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left
                })
                Register(ProgressText, "TextColor3", "Text")
                
                if icon ~= "" then
                    Create("TextLabel", {
                        Parent = ProgressFrame,
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 10, 0, 0),
                        Size = UDim2.new(0, 20, 0, 22),
                        Font = Enum.Font.Gotham,
                        Text = icon,
                        TextColor3 = Theme.TextDark,
                        TextSize = 14
                    })
                end
                
                local PercentLabel = Create("TextLabel", {
                    Parent = ProgressFrame,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(1, -45, 0, 0),
                    Size = UDim2.new(0, 35, 0, 22),
                    Font = Enum.Font.GothamMedium,
                    Text = math.floor((Value / max) * 100) .. "%",
                    TextColor3 = Theme.Accent,
                    TextSize = 11,
                    TextXAlignment = Enum.TextXAlignment.Right
                })
                Register(PercentLabel, "TextColor3", "Accent")
                
                local ProgressTrack = Create("Frame", {
                    Parent = ProgressFrame,
                    BackgroundColor3 = Theme.Primary,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 10, 0, 26),
                    Size = UDim2.new(1, -20, 0, 8)
                })
                Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = ProgressTrack})
                Register(ProgressTrack, "BackgroundColor3", "Primary")
                
                local ProgressFill = Create("Frame", {
                    Parent = ProgressTrack,
                    BackgroundColor3 = Theme.Accent,
                    BorderSizePixel = 0,
                    Size = UDim2.new(Value / max, 0, 1, 0)
                })
                Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = ProgressFill})
                Register(ProgressFill, "BackgroundColor3", "Accent")
                
                local Progress = {}
                function Progress:Set(val)
                    Value = math.clamp(val, 0, max)
                    PercentLabel.Text = math.floor((Value / max) * 100) .. "%"
                    Tween(ProgressFill, {Size = UDim2.new(Value / max, 0, 1, 0)}, 0.2)
                end
                function Progress:Get() return Value end
                function Progress:Increment(amount)
                    Progress:Set(Value + (amount or 1))
                end
                
                return Progress
            end

            
            -- ═══════════════════════════════════════════════════════════════
            -- COLOR PICKER
            -- ═══════════════════════════════════════════════════════════════
            
            function Section:CreateColorPicker(opts)
                opts = opts or {}
                local name = opts.Name or "Color"
                local icon = opts.Icon or ""
                local default = opts.Default or Color3.fromRGB(255, 255, 255)
                local callback = opts.Callback or function() end
                
                local Value = default
                local Open = false
                local H, S, V = Color3.toHSV(default)
                
                local ColorFrame = Create("Frame", {
                    Parent = SectionFrame,
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 32),
                    ClipsDescendants = true
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = ColorFrame})
                Register(ColorFrame, "BackgroundColor3", "Tertiary")
                
                local ColorText = Create("TextLabel", {
                    Parent = ColorFrame,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, icon ~= "" and 32 or 10, 0, 0),
                    Size = UDim2.new(0.6, 0, 0, 32),
                    Font = Enum.Font.GothamMedium,
                    Text = name,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left
                })
                Register(ColorText, "TextColor3", "Text")
                
                if icon ~= "" then
                    Create("TextLabel", {
                        Parent = ColorFrame,
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 10, 0, 0),
                        Size = UDim2.new(0, 20, 0, 32),
                        Font = Enum.Font.Gotham,
                        Text = icon,
                        TextColor3 = Theme.TextDark,
                        TextSize = 14
                    })
                end
                
                -- Color Preview
                local ColorPreview = Create("Frame", {
                    Parent = ColorFrame,
                    BackgroundColor3 = Value,
                    BorderSizePixel = 0,
                    Position = UDim2.new(1, -50, 0.5, -10),
                    Size = UDim2.new(0, 40, 0, 20)
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = ColorPreview})
                Create("UIStroke", {Parent = ColorPreview, Color = Theme.Divider, Thickness = 1})
                
                local ColorBtn = Create("TextButton", {
                    Parent = ColorFrame,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 32),
                    Text = ""
                })
                
                -- Color Picker Panel
                local PickerPanel = Create("Frame", {
                    Parent = ColorFrame,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 8, 0, 38),
                    Size = UDim2.new(1, -16, 0, 120)
                })
                
                -- Saturation/Value Box
                local SVBox = Create("Frame", {
                    Parent = PickerPanel,
                    BackgroundColor3 = Color3.fromHSV(H, 1, 1),
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, -30, 0, 100)
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = SVBox})
                
                -- White gradient (left to right)
                local WhiteGrad = Create("UIGradient", {
                    Parent = SVBox,
                    Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                        ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1))
                    }),
                    Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 0),
                        NumberSequenceKeypoint.new(1, 1)
                    }),
                    Rotation = 0
                })
                
                -- Black overlay (top to bottom)
                local BlackOverlay = Create("Frame", {
                    Parent = SVBox,
                    BackgroundColor3 = Color3.new(0, 0, 0),
                    BackgroundTransparency = 0,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 1, 0)
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = BlackOverlay})
                Create("UIGradient", {
                    Parent = BlackOverlay,
                    Color = ColorSequence.new(Color3.new(0, 0, 0)),
                    Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 1),
                        NumberSequenceKeypoint.new(1, 0)
                    }),
                    Rotation = 90
                })
                
                -- SV Cursor
                local SVCursor = Create("Frame", {
                    Parent = SVBox,
                    BackgroundColor3 = Color3.new(1, 1, 1),
                    BorderSizePixel = 0,
                    Position = UDim2.new(S, -6, 1 - V, -6),
                    Size = UDim2.new(0, 12, 0, 12),
                    ZIndex = 5
                })
                Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = SVCursor})
                Create("UIStroke", {Parent = SVCursor, Color = Color3.new(0, 0, 0), Thickness = 2})
                
                -- SV Input Button
                local SVBtn = Create("TextButton", {
                    Parent = SVBox,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    Text = "",
                    ZIndex = 6
                })
                
                -- Hue Bar
                local HueBar = Create("Frame", {
                    Parent = PickerPanel,
                    BackgroundColor3 = Color3.new(1, 1, 1),
                    BorderSizePixel = 0,
                    Position = UDim2.new(1, -18, 0, 0),
                    Size = UDim2.new(0, 14, 0, 100)
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = HueBar})
                Create("UIGradient", {
                    Parent = HueBar,
                    Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                        ColorSequenceKeypoint.new(0.167, Color3.fromRGB(255, 255, 0)),
                        ColorSequenceKeypoint.new(0.333, Color3.fromRGB(0, 255, 0)),
                        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
                        ColorSequenceKeypoint.new(0.667, Color3.fromRGB(0, 0, 255)),
                        ColorSequenceKeypoint.new(0.833, Color3.fromRGB(255, 0, 255)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
                    }),
                    Rotation = 90
                })
                
                -- Hue Cursor
                local HueCursor = Create("Frame", {
                    Parent = HueBar,
                    BackgroundColor3 = Color3.new(1, 1, 1),
                    BorderSizePixel = 0,
                    Position = UDim2.new(0.5, -7, H, -3),
                    Size = UDim2.new(0, 14, 0, 6),
                    AnchorPoint = Vector2.new(0.5, 0),
                    ZIndex = 5
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 2), Parent = HueCursor})
                Create("UIStroke", {Parent = HueCursor, Color = Color3.new(0, 0, 0), Thickness = 1})
                
                -- Hue Input Button
                local HueBtn = Create("TextButton", {
                    Parent = HueBar,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    Text = "",
                    ZIndex = 6
                })
                
                local function UpdateColor()
                    Value = Color3.fromHSV(H, S, V)
                    ColorPreview.BackgroundColor3 = Value
                    SVBox.BackgroundColor3 = Color3.fromHSV(H, 1, 1)
                    SVCursor.Position = UDim2.new(S, -6, 1 - V, -6)
                    HueCursor.Position = UDim2.new(0.5, -7, H, -3)
                    pcall(callback, Value)
                end
                
                -- SV Dragging
                local SVDragging = false
                SVBtn.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        SVDragging = true
                        local pos = Vector2.new(input.Position.X, input.Position.Y)
                        S = math.clamp((pos.X - SVBox.AbsolutePosition.X) / SVBox.AbsoluteSize.X, 0, 1)
                        V = math.clamp(1 - (pos.Y - SVBox.AbsolutePosition.Y) / SVBox.AbsoluteSize.Y, 0, 1)
                        UpdateColor()
                    end
                end)
                SVBtn.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        SVDragging = false
                    end
                end)
                
                -- Hue Dragging
                local HueDragging = false
                HueBtn.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        HueDragging = true
                        H = math.clamp((input.Position.Y - HueBar.AbsolutePosition.Y) / HueBar.AbsoluteSize.Y, 0, 1)
                        UpdateColor()
                    end
                end)
                HueBtn.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        HueDragging = false
                    end
                end)
                
                local colorConn = UserInputService.InputChanged:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                        if SVDragging then
                            S = math.clamp((input.Position.X - SVBox.AbsolutePosition.X) / SVBox.AbsoluteSize.X, 0, 1)
                            V = math.clamp(1 - (input.Position.Y - SVBox.AbsolutePosition.Y) / SVBox.AbsoluteSize.Y, 0, 1)
                            UpdateColor()
                        elseif HueDragging then
                            H = math.clamp((input.Position.Y - HueBar.AbsolutePosition.Y) / HueBar.AbsoluteSize.Y, 0, 1)
                            UpdateColor()
                        end
                    end
                end)
                table.insert(Window.Connections, colorConn)
                
                -- Toggle Picker
                ColorBtn.MouseButton1Click:Connect(function()
                    Open = not Open
                    Tween(ColorFrame, {Size = UDim2.new(1, 0, 0, Open and 170 or 32)}, 0.25)
                end)
                
                local ColorPicker = {}
                function ColorPicker:Set(color)
                    Value = color
                    H, S, V = Color3.toHSV(color)
                    ColorPreview.BackgroundColor3 = Value
                    SVBox.BackgroundColor3 = Color3.fromHSV(H, 1, 1)
                    SVCursor.Position = UDim2.new(S, -6, 1 - V, -6)
                    HueCursor.Position = UDim2.new(0.5, -7, H, -3)
                    pcall(callback, Value)
                end
                function ColorPicker:Get() return Value end
                
                return ColorPicker
            end
            
            -- ═══════════════════════════════════════════════════════════════
            -- IMAGE
            -- ═══════════════════════════════════════════════════════════════
            
            function Section:CreateImage(opts)
                opts = opts or {}
                local name = opts.Name or ""
                local image = opts.Image or ""
                local size = opts.Size or UDim2.new(1, 0, 0, 80)
                
                local ImageFrame = Create("Frame", {
                    Parent = SectionFrame,
                    BackgroundTransparency = 1,
                    Size = size
                })
                
                local ImageLabel = Create("ImageLabel", {
                    Parent = ImageFrame,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    Image = image,
                    ScaleType = Enum.ScaleType.Fit
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = ImageLabel})
                
                local Image = {}
                function Image:Set(newImage)
                    ImageLabel.Image = newImage
                end
                function Image:Get() return ImageLabel.Image end
                
                return Image
            end
            
            return Section
        end
        
        return Tab
    end
    
    table.insert(VogueLib.Windows, Window)
    return Window
end

return VogueLib
