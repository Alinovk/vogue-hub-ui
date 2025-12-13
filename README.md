<div align="center">

# 🎨 VOGUE HUB UI Library

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Roblox](https://img.shields.io/badge/Roblox-Luau-blue.svg)](https://luau-lang.org/)
[![Version](https://img.shields.io/badge/version-2.0.0-green.svg)](https://github.com/yourusername/vogue-hub-ui)

**Minimalist and elegant UI library for Roblox exploits**

Inspired by fashion magazine design and modern websites

[Documentation](docs/API.md) • [Examples](examples/) • [Changelog](docs/CHANGELOG.md)

</div>

---

## ✨ Features

- 🎨 **Modern Design** — Fashion/magazine style with gradients and glow effects
- 🔧 **Full Component Set** — Buttons, toggles, sliders, color pickers, and more
- 🌊 **Smooth Animations** — TweenService for all interactions with ripple effects
- 📱 **Adaptive Interface** — Automatic size adjustment
- 🎯 **Simple API** — Easy to use and customize
- 🔔 **Notification System** — Beautiful stacking notifications with progress bars
- ⌨️ **Hotkey Support** — Keybind system with escape to clear
- 🎭 **Theme System** — 5 built-in themes + custom theme support
- 🧹 **Memory Safe** — Proper connection cleanup to prevent memory leaks

---

## 🎨 Themes

Built-in themes:
- **Dark** (default) — Elegant dark with gold accents
- **Light** — Clean light theme
- **Ocean** — Deep blue oceanic feel
- **Purple** — Rich purple aesthetics
- **Rose** — Soft pink/rose tones

---

## 📦 Installation

### Method 1: LoadString (recommended)

```lua
local VogueLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/yourusername/vogue-hub-ui/main/src/init.lua"))()
```

### Method 2: Local Script

1. Copy contents of `src/init.lua`
2. Paste into your exploit executor
3. Use as module:

```lua
local VogueLib = require(script.VogueLib)
```

---

## 🚀 Quick Start

```lua
-- Load library
local VogueLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/yourusername/vogue-hub-ui/main/src/init.lua"))()

-- Create window with theme
local Window = VogueLib:CreateWindow({
    Title = "VOGUE HUB",
    Size = UDim2.new(0, 550, 0, 400),
    Theme = "Dark" -- Dark, Light, Ocean, Purple, Rose
})

-- Create tab
local MainTab = Window:CreateTab({Name = "Main", Icon = "🏠"})

-- Create section
local Section = MainTab:CreateSection("Features")

-- Add button with ripple effect
Section:CreateButton({
    Name = "Click Me!",
    Icon = "🔥",
    Callback = function()
        print("Button clicked!")
    end
})

-- Add toggle with glow
Section:CreateToggle({
    Name = "Enable Feature",
    Default = false,
    Callback = function(Value)
        print("Toggle:", Value)
    end
})

-- Notification with type
Window:Notify({
    Title = "Success",
    Content = "UI loaded successfully!",
    Duration = 3,
    Type = "success" -- info, success, error, warning
})
```

---

## 📚 Components

| Component | Description | Example |
|-----------|-------------|---------|
| Window | Main UI window | `VogueLib:CreateWindow({...})` |
| Tab | Navigation tab | `Window:CreateTab({...})` |
| Section | Element group | `Tab:CreateSection("Name")` |
| Button | Clickable button with ripple | `Section:CreateButton({...})` |
| Toggle | On/Off switch with glow | `Section:CreateToggle({...})` |
| Slider | Value slider with knob | `Section:CreateSlider({...})` |
| Dropdown | Dropdown list | `Section:CreateDropdown({...})` |
| TextBox | Text input field | `Section:CreateTextBox({...})` |
| Keybind | Key binding | `Section:CreateKeybind({...})` |
| Label | Text label | `Section:CreateLabel("Text")` |
| Separator | Visual separator | `Section:CreateSeparator()` |
| ProgressBar | Progress indicator | `Section:CreateProgressBar({...})` |
| ColorPicker | Color selection | `Section:CreateColorPicker({...})` |
| Image | Image display | `Section:CreateImage({...})` |
| Notify | Notification | `Window:Notify({...})` |

---

## 🎨 New in v2.0.0

### Visual Enhancements
- Gradient accents on active elements
- Glow effects on toggles and buttons
- Ripple click animations
- Sliding tab indicator
- Progress bar on notifications
- Better shadows and depth
- Smooth hover animations

### New Components
- **ColorPicker** — Full HSV color picker
- **ProgressBar** — Animated progress indicator
- **Separator** — Visual divider
- **Image** — Image display component

### Theme System
```lua
-- Use built-in theme
VogueLib:SetTheme("Ocean")

-- Get available themes
local themes = VogueLib:GetThemes()

-- Create custom theme
VogueLib:CreateCustomTheme("MyTheme", {
    Background = Color3.fromRGB(20, 20, 20),
    Secondary = Color3.fromRGB(30, 30, 30),
    Accent = Color3.fromRGB(255, 100, 100),
    -- ... other colors
})
```

### Bug Fixes
- Fixed memory leaks from input connections
- Fixed notification stacking
- Fixed dropdown height calculation
- Fixed toggle stroke animation
- Proper cleanup on window destroy

---

## 📖 Documentation

Full documentation available in [docs/API.md](docs/API.md)

---

## 🤝 Contributing

We welcome any contributions! If you want to help:

1. Fork the repository
2. Create a branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📝 License

This project is distributed under the MIT License. See [LICENSE](LICENSE) file for details.

---

## 🌟 Support

If you liked the library, give it a ⭐ on GitHub!

---

## 📞 Contacts

- GitHub Issues: [Create Issue](https://github.com/yourusername/vogue-hub-ui/issues)
- Discord: YourDiscord#0000
- Email: your.email@example.com

---

## 🔄 Changelog

### v2.0.0 (2025-12-13)
- ✨ Theme system with 5 built-in themes
- 🎨 Visual enhancements (gradients, glow, ripples)
- 🆕 New components (ColorPicker, ProgressBar, Separator, Image)
- 🐛 Fixed all memory leaks
- 🐛 Fixed notification stacking
- 📝 Translated to English
- 🧹 Code cleanup and optimization

### v1.0.0 (2024-01-XX)
- ✨ First release
- 🎨 11 UI components
- 🔔 Notification system
- 📱 Adaptive design
- 🌊 Smooth animations

See [CHANGELOG.md](docs/CHANGELOG.md) for full version history.

---

<div align="center">

Made with ❤️ for the Roblox community

[⬆ Back to Top](#-vogue-hub-ui-library)

</div>

