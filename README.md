<div align="center">

# 🎨 VOGUE HUB UI Library

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Roblox](https://img.shields.io/badge/Roblox-Luau-blue.svg)](https://luau-lang.org/)
[![Version](https://img.shields.io/badge/version-1.0.0-green.svg)](https://github.com/yourusername/vogue-hub-ui)

**Минималистичная и элегантная UI библиотека для Roblox exploits**

Вдохновлена дизайном модных журналов и современных веб-сайтов

[Документация](docs/API.md) • [Примеры](examples/) • [Changelog](docs/CHANGELOG.md)

</div>

---

## ✨ Особенности

- 🎨 **Современный дизайн** — стиль fashion/magazine
- 🔧 **Полный набор компонентов** — кнопки, переключатели, слайдеры и многое другое
- 🌊 **Плавные анимации** — TweenService для всех взаимодействий
- 📱 **Адаптивный интерфейс** — автоматическая подстройка размеров
- 🎯 **Простой API** — легко использовать и настраивать
- 🔔 **Система уведомлений** — красивые всплывающие сообщения
- ⌨️**Поддержка горячих клавиш** — keybind система
- 🎭 **Темная цветовая схема** — приятная для глаз

---

## 📦 Установка

### Метод 1: LoadString (рекомендуется)

```lua
local VogueLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/yourusername/vogue-hub-ui/main/src/init.lua"))()
Метод 2: Локальный скрипт
Скопируйте содержимое src/init.lua
Вставьте в ваш exploit executor
Используйте как модуль:
Lua

local VogueLib = require(script.VogueLib)
🚀 Быстрый старт
Lua

-- Загрузка библиотеки
local VogueLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/yourusername/vogue-hub-ui/main/src/init.lua"))()

-- Создание окна
local Window = VogueLib:CreateWindow({
    Title = "VOGUE HUB",
    Size = UDim2.new(0, 550, 0, 400)
})

-- Создание таба
local MainTab = Window:CreateTab({Name = "Main"})

-- Создание секции
local Section = MainTab:CreateSection("Features")

-- Добавление кнопки
Section:CreateButton({
    Name = "Click Me!",
    Callback = function()
        print("Button clicked!")
    end
})

-- Уведомление
Window:Notify({
    Title = "Success",
    Content = "UI loaded successfully!",
    Duration = 3
})
📚 Компоненты
Компонент	Описание	Пример
Window	Главное окно UI	VogueLib:CreateWindow({...})
Tab	Вкладка навигации	Window:CreateTab({...})
Section	Группа элементов	Tab:CreateSection("Name")
Button	Кликабельная кнопка	Section:CreateButton({...})
Toggle	Переключатель On/Off	Section:CreateToggle({...})
Slider	Ползунок значений	Section:CreateSlider({...})
Dropdown	Выпадающий список	Section:CreateDropdown({...})
TextBox	Поле ввода текста	Section:CreateTextBox({...})
Keybind	Привязка клавиш	Section:CreateKeybind({...})
Label	Текстовая метка	Section:CreateLabel("Text")
Notify	Уведомление	Window:Notify({...})
🎨 Скриншоты
Главное окно
text

┌─────────────────────────────────────────────────────┐
│  VOGUE HUB                                    — ×   │
├─────────────────────────────────────────────────────┤
│  MAIN • COMBAT • VISUALS • MISC • SETTINGS          │
│  ━━━━                                               │
├─────────────────────────────────────────────────────┤
│  ┌─ PLAYER ────────────────────────────────────┐   │
│  │                                              │   │
│  │  Walk Speed                      [====●   ] │   │
│  │  Jump Power                      [==●     ] │   │
│  │  Infinite Jump               ◯──────────●  │   │
│  │                                              │   │
│  └──────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────┘
📖 Документация
Подробная документация доступна в docs/API.md

Основные методы
Создание окна
Lua

local Window = VogueLib:CreateWindow({
    Title = "My Hub",           -- Заголовок окна
    Size = UDim2.new(0, 550, 0, 400)  -- Размер окна
})
Создание таба
Lua

local Tab = Window:CreateTab({
    Name = "Main",              -- Название таба
    Icon = ""                   -- Иконка (опционально)
})
Создание Toggle
Lua

local Toggle = Section:CreateToggle({
    Name = "Feature",           -- Название
    Default = false,            -- Значение по умолчанию
    Callback = function(Value)  -- Функция обратного вызова
        print("Toggle:", Value)
    end
})

-- API
Toggle:Set(true)               -- Установить значение
local state = Toggle:Get()     -- Получить значение
Создание Slider
Lua

local Slider = Section:CreateSlider({
    Name = "Speed",             -- Название
    Min = 0,                    -- Минимум
    Max = 100,                  -- Максимум
    Default = 50,               -- Значение по умолчанию
    Callback = function(Value)
        print("Slider:", Value)
    end
})

-- API
Slider:Set(75)                 -- Установить значение
local value = Slider:Get()     -- Получить значение
Больше примеров в папке examples/

🤝 Вклад в проект
Мы приветствуем любой вклад! Если вы хотите помочь:

Fork репозитория
Создайте ветку (git checkout -b feature/AmazingFeature)
Commit изменения (git commit -m 'Add some AmazingFeature')
Push в ветку (git push origin feature/AmazingFeature)
Откройте Pull Request
📝 Лицензия
Этот проект распространяется под лицензией MIT. См. файл LICENSE для подробностей.

🌟 Поддержка
Если вам понравилась библиотека, поставьте ⭐ на GitHub!

📞 Контакты
GitHub Issues: Создать Issue
Discord: YourDiscord#0000
Email: your.email@example.com
🔄 Changelog
v1.0.0 (2024-01-XX)
✨ Первый релиз
🎨 11 компонентов UI
🔔 Система уведомлений
📱 Адаптивный дизайн
🌊 Плавные анимации
См. CHANGELOG.md для полной истории версий.

<div align="center">
Сделано с ❤️ для Roblox сообщества

⬆ Наверх

</div> ```