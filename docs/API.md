# 📖 API Documentation

Complete documentation for VOGUE HUB UI Library v3.0.0

## Table of Contents

1. [Library](#library)
2. [Window](#window)
3. [Tab](#tab)
4. [Section](#section)
5. [Components](#components)
   - [Button](#button)
   - [Toggle](#toggle)
   - [Slider](#slider)
   - [Dropdown](#dropdown)
   - [TextBox](#textbox)
   - [Keybind](#keybind)
   - [Label](#label)
   - [Separator](#separator)
   - [ProgressBar](#progressbar)
   - [ColorPicker](#colorpicker)
   - [Image](#image)
6. [Notification](#notification)
7. [Themes](#themes)

---

## Library

### GetThemes

Returns list of available theme names.

```lua
local themes = VogueLib:GetThemes()
```

**Returns:** table (array of theme names)

### AddTheme

Creates a custom theme.

```lua
VogueLib:AddTheme(name, colors)
```

**Parameters:**
- `name` (string): Theme name
- `colors` (table): Color definitions

**Example:**
```lua
VogueLib:AddTheme("Neon", {
    Primary = Color3.fromRGB(10, 10, 15),
    Secondary = Color3.fromRGB(20, 20, 30),
    Tertiary = Color3.fromRGB(30, 30, 45),
    Accent = Color3.fromRGB(0, 255, 200),
    AccentDark = Color3.fromRGB(0, 200, 160),
    Text = Color3.fromRGB(255, 255, 255),
    TextDark = Color3.fromRGB(180, 180, 180),
    TextMuted = Color3.fromRGB(120, 120, 120),
    Divider = Color3.fromRGB(50, 50, 70),
    Success = Color3.fromRGB(0, 255, 150),
    Error = Color3.fromRGB(255, 80, 100),
    Warning = Color3.fromRGB(255, 200, 0)
})
```

---

## Window

### CreateWindow

Creates the main UI window.

```lua
local Window = VogueLib:CreateWindow({
    Title = "string",
    Size = UDim2,
    Theme = "string"
})
```

**Parameters:**
- `Title` (string): Window title (default: "Vogue Hub")
- `Size` (UDim2): Window size (default: UDim2.new(0, 580, 0, 420))
- `Theme` (string): Theme name (default: "Dark")

**Returns:** Window object

**Example:**
```lua
local Window = VogueLib:CreateWindow({
    Title = "My Hub",
    Size = UDim2.new(0, 600, 0, 450),
    Theme = "Ocean"
})
```

### Window Methods

#### SetTheme
Dynamically changes the theme of the current window. All UI elements update instantly.

```lua
Window:SetTheme("Ocean") -- Changes theme with smooth animation
```

**Returns:** boolean (success)

#### Toggle
```lua
Window:Toggle() -- Toggle visibility
```

#### Show
```lua
Window:Show() -- Show window
```

#### Hide
```lua
Window:Hide() -- Hide window
```

#### Destroy
```lua
Window:Destroy() -- Destroy window and cleanup
```

---

## Tab

### CreateTab

Creates a new tab in the window.

```lua
local Tab = Window:CreateTab({
    Name = "string",
    Icon = "string"
})
```

**Parameters:**
- `Name` (string): Tab name
- `Icon` (string): Tab icon emoji (optional)

**Returns:** Tab object

**Example:**
```lua
local MainTab = Window:CreateTab({
    Name = "Main",
    Icon = "🏠"
})
```

---

## Section

### CreateSection

Creates a section inside a tab.

```lua
local Section = Tab:CreateSection("string")
```

**Parameters:**
- `sectionName` (string): Section name

**Returns:** Section object

**Example:**
```lua
local PlayerSection = MainTab:CreateSection("Player")
```

---

## Components

### Button

Creates a clickable button with ripple effect.

```lua
Section:CreateButton({
    Name = "string",
    Icon = "string",
    Callback = function()
        -- code
    end
})
```

**Parameters:**
- `Name` (string): Button text
- `Icon` (string): Button icon emoji (optional)
- `Callback` (function): Function called on click

**Example:**
```lua
Section:CreateButton({
    Name = "Print Message",
    Icon = "📝",
    Callback = function()
        print("Button clicked!")
    end
})
```

---

### Toggle

Creates an On/Off toggle switch.

```lua
local Toggle = Section:CreateToggle({
    Name = "string",
    Icon = "string",
    Default = boolean,
    Callback = function(Value)
        -- Value = true/false
    end
})
```

**Parameters:**
- `Name` (string): Toggle name
- `Icon` (string): Toggle icon emoji (optional)
- `Default` (boolean): Initial state (default: false)
- `Callback` (function): Function receiving new value

**Methods:**
- `Toggle:Set(value)` - Set state
- `Toggle:Get()` - Get current state

**Example:**
```lua
local MyToggle = Section:CreateToggle({
    Name = "Enable Feature",
    Icon = "⚡",
    Default = false,
    Callback = function(Value)
        print("Toggle is now:", Value)
    end
})

MyToggle:Set(true)
local state = MyToggle:Get()
```

---

### Slider

Creates a slider for numeric value selection.

```lua
local Slider = Section:CreateSlider({
    Name = "string",
    Icon = "string",
    Min = number,
    Max = number,
    Default = number,
    Increment = number,
    Callback = function(Value)
        -- Value = number
    end
})
```

**Parameters:**
- `Name` (string): Slider name
- `Icon` (string): Slider icon emoji (optional)
- `Min` (number): Minimum value
- `Max` (number): Maximum value
- `Default` (number): Initial value
- `Increment` (number): Step increment (default: 1)
- `Callback` (function): Function receiving new value

**Methods:**
- `Slider:Set(value)` - Set value
- `Slider:Get()` - Get current value

**Example:**
```lua
local SpeedSlider = Section:CreateSlider({
    Name = "Walk Speed",
    Icon = "🏃",
    Min = 16,
    Max = 200,
    Default = 16,
    Increment = 1,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})
```

---

### Dropdown

Creates a dropdown list.

```lua
local Dropdown = Section:CreateDropdown({
    Name = "string",
    Icon = "string",
    Options = {"opt1", "opt2"},
    Default = "string",
    Callback = function(Value)
        -- Value = selected option
    end
})
```

**Parameters:**
- `Name` (string): Dropdown name
- `Icon` (string): Dropdown icon emoji (optional)
- `Options` (table): Array of available options
- `Default` (string): Default selected option
- `Callback` (function): Function receiving selected option

**Methods:**
- `Dropdown:Set(value)` - Set selected option
- `Dropdown:Get()` - Get current option
- `Dropdown:Refresh(options)` - Update options list

**Example:**
```lua
local WeaponDropdown = Section:CreateDropdown({
    Name = "Select Weapon",
    Icon = "⚔️",
    Options = {"Sword", "Bow", "Staff"},
    Default = "Sword",
    Callback = function(Value)
        print("Selected weapon:", Value)
    end
})

WeaponDropdown:Refresh({"Sword", "Bow", "Staff", "Axe"})
```

---

### TextBox

Creates a text input field.

```lua
local TextBox = Section:CreateTextBox({
    Name = "string",
    Icon = "string",
    Placeholder = "string",
    Default = "string",
    Callback = function(Value)
        -- Value = entered text
    end
})
```

**Parameters:**
- `Name` (string): Field name
- `Icon` (string): Field icon emoji (optional)
- `Placeholder` (string): Placeholder text
- `Default` (string): Default text
- `Callback` (function): Called on Enter press

**Methods:**
- `TextBox:Set(text)` - Set text
- `TextBox:Get()` - Get current text

**Example:**
```lua
local NameBox = Section:CreateTextBox({
    Name = "Player Name",
    Icon = "👤",
    Placeholder = "Enter name...",
    Callback = function(Value)
        print("Name entered:", Value)
    end
})
```

---

### Keybind

Creates a key binding.

```lua
local Keybind = Section:CreateKeybind({
    Name = "string",
    Icon = "string",
    Default = Enum.KeyCode,
    Callback = function()
        -- code
    end
})
```

**Parameters:**
- `Name` (string): Keybind name
- `Icon` (string): Keybind icon emoji (optional)
- `Default` (Enum.KeyCode): Default key
- `Callback` (function): Called on key press

**Methods:**
- `Keybind:Set(keycode)` - Set key
- `Keybind:Get()` - Get current key

**Note:** Press Escape while listening to clear the keybind.

**Example:**
```lua
local ToggleKeybind = Section:CreateKeybind({
    Name = "Toggle Menu",
    Icon = "⌨️",
    Default = Enum.KeyCode.RightControl,
    Callback = function()
        Window:Toggle()
    end
})
```

---

### Label

Creates a text label.

```lua
local Label = Section:CreateLabel("string")
```

**Parameters:**
- `labelText` (string): Label text

**Methods:**
- `Label:Set(text)` - Change text
- `Label:Get()` - Get current text

**Example:**
```lua
local StatusLabel = Section:CreateLabel("Status: Ready")
StatusLabel:Set("Status: Active")
```

---

### Separator

Creates a visual separator line.

```lua
Section:CreateSeparator()
```

**Example:**
```lua
Section:CreateButton({Name = "Button 1", Callback = function() end})
Section:CreateSeparator()
Section:CreateButton({Name = "Button 2", Callback = function() end})
```

---

### ProgressBar

Creates an animated progress bar.

```lua
local Progress = Section:CreateProgressBar({
    Name = "string",
    Icon = "string",
    Default = number,
    Max = number
})
```

**Parameters:**
- `Name` (string): Progress bar name
- `Icon` (string): Icon emoji (optional)
- `Default` (number): Initial value (default: 0)
- `Max` (number): Maximum value (default: 100)

**Methods:**
- `Progress:Set(value)` - Set value
- `Progress:Get()` - Get current value
- `Progress:Increment(amount)` - Increment by amount

**Example:**
```lua
local LoadProgress = Section:CreateProgressBar({
    Name = "Loading",
    Icon = "📊",
    Default = 0,
    Max = 100
})

-- Update progress
for i = 1, 100 do
    LoadProgress:Set(i)
    task.wait(0.05)
end
```

---

### ColorPicker

Creates a full HSV color picker.

```lua
local ColorPicker = Section:CreateColorPicker({
    Name = "string",
    Icon = "string",
    Default = Color3,
    Callback = function(Color)
        -- Color = Color3 value
    end
})
```

**Parameters:**
- `Name` (string): Color picker name
- `Icon` (string): Icon emoji (optional)
- `Default` (Color3): Default color
- `Callback` (function): Called on color change

**Methods:**
- `ColorPicker:Set(color)` - Set color
- `ColorPicker:Get()` - Get current color

**Example:**
```lua
local ESPColor = Section:CreateColorPicker({
    Name = "ESP Color",
    Icon = "🎨",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(Color)
        print("New color:", Color)
    end
})
```

---

### Image

Creates an image display.

```lua
local Image = Section:CreateImage({
    Name = "string",
    Image = "string",
    Size = UDim2
})
```

**Parameters:**
- `Name` (string): Image name
- `Image` (string): Image asset ID
- `Size` (UDim2): Image size

**Methods:**
- `Image:Set(imageId)` - Set image
- `Image:Get()` - Get current image ID

**Example:**
```lua
local Logo = Section:CreateImage({
    Name = "Logo",
    Image = "rbxassetid://123456789",
    Size = UDim2.new(1, 0, 0, 100)
})
```

---

## Notification

### Notify

Creates a stacking notification with progress bar.

```lua
Window:Notify({
    Title = "string",
    Content = "string",
    Duration = number,
    Type = "string"
})
```

**Parameters:**
- `Title` (string): Notification title
- `Content` (string): Notification text
- `Duration` (number): Display duration in seconds (default: 3)
- `Type` (string): Notification type - "info", "success", "error", "warning" (default: "info")

**Example:**
```lua
Window:Notify({
    Title = "Success",
    Content = "Feature enabled successfully!",
    Duration = 4,
    Type = "success"
})

Window:Notify({
    Title = "Error",
    Content = "Something went wrong!",
    Duration = 5,
    Type = "error"
})
```

---

## Themes

### Available Themes

| Theme | Description |
|-------|-------------|
| Dark | Elegant dark with purple accents (default) |
| Light | Clean light theme |
| Midnight | GitHub-style dark blue |
| Sunset | Warm pink/rose tones |
| Ocean | Deep blue oceanic feel |

### Dynamic Theme Switching

Themes can be changed at runtime and all UI elements will update with smooth animations:

```lua
Window:SetTheme("Ocean") -- Instantly updates all elements
```

### Theme Colors

Each theme contains these color properties:

```lua
{
    Primary = Color3,     -- Main background
    Secondary = Color3,   -- Secondary background (sidebar, header)
    Tertiary = Color3,    -- Component backgrounds
    Accent = Color3,      -- Primary accent color
    AccentDark = Color3,  -- Darker accent variant
    Text = Color3,        -- Primary text
    TextDark = Color3,    -- Secondary text
    TextMuted = Color3,   -- Muted/placeholder text
    Divider = Color3,     -- Divider lines
    Success = Color3,     -- Success notifications
    Error = Color3,       -- Error notifications
    Warning = Color3      -- Warning notifications
}
```
