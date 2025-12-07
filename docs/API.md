# 📖 API Documentation

Полная документация по VOGUE HUB UI Library

## Содержание

1. [Window](#window)
2. [Tab](#tab)
3. [Section](#section)
4. [Components](#components)
   - [Button](#button)
   - [Toggle](#toggle)
   - [Slider](#slider)
   - [Dropdown](#dropdown)
   - [TextBox](#textbox)
   - [Keybind](#keybind)
   - [Label](#label)
5. [Notification](#notification)

---

## Window

### CreateWindow

Создает главное окно UI.

```lua
local Window = VogueLib:CreateWindow({
    Title = "string",              -- Заголовок окна
    Size = UDim2                   -- Размер окна
})
Параметры:

Title (string): Заголовок окна (по умолчанию: "VOGUE HUB")
Size (UDim2): Размер окна (по умолчанию: UDim2.new(0, 550, 0, 400))
Возвращает: Window object

Пример:

Lua

local Window = VogueLib:CreateWindow({
    Title = "My Hub",
    Size = UDim2.new(0, 600, 0, 450)
})
Tab
CreateTab
Создает новую вкладку в окне.

Lua

local Tab = Window:CreateTab({
    Name = "string",               -- Название таба
    Icon = "string"                -- Иконка (опционально)
})
Параметры:

Name (string): Название таба
Icon (string): Иконка таба (опционально)
Возвращает: Tab object

Пример:

Lua

local MainTab = Window:CreateTab({
    Name = "Main"
})
Section
CreateSection
Создает секцию внутри таба.

Lua

local Section = Tab:CreateSection("string")
Параметры:

sectionName (string): Название секции
Возвращает: Section object

Пример:

Lua

local PlayerSection = MainTab:CreateSection("Player")
Components
Button
Создает кликабельную кнопку.

Lua

Section:CreateButton({
    Name = "string",               -- Название кнопки
    Callback = function()          -- Функция при клике
        -- код
    end
})
Параметры:

Name (string): Текст на кнопке
Callback (function): Функция, вызываемая при клике
Пример:

Lua

Section:CreateButton({
    Name = "Print Message",
    Callback = function()
        print("Button clicked!")
    end
})
Toggle
Создает переключатель On/Off.

Lua

local Toggle = Section:CreateToggle({
    Name = "string",               -- Название
    Default = boolean,             -- Начальное состояние
    Callback = function(Value)     -- Функция обратного вызова
        -- Value = true/false
    end
})
Параметры:

Name (string): Название переключателя
Default (boolean): Начальное состояние (по умолчанию: false)
Callback (function): Функция, получающая новое значение
Методы:

Toggle:Set(value) - Установить состояние
Toggle:Get() - Получить текущее состояние
Пример:

Lua

local MyToggle = Section:CreateToggle({
    Name = "Enable Feature",
    Default = false,
    Callback = function(Value)
        print("Toggle is now:", Value)
    end
})

-- Использование API
MyToggle:Set(true)           -- Включить
local state = MyToggle:Get() -- Получить состояние
Slider
Создает слайдер для выбора числового значения.

Lua

local Slider = Section:CreateSlider({
    Name = "string",               -- Название
    Min = number,                  -- Минимальное значение
    Max = number,                  -- Максимальное значение
    Default = number,              -- Значение по умолчанию
    Callback = function(Value)     -- Функция обратного вызова
        -- Value = число
    end
})
Параметры:

Name (string): Название слайдера
Min (number): Минимальное значение
Max (number): Максимальное значение
Default (number): Начальное значение
Callback (function): Функция, получающая новое значение
Методы:

Slider:Set(value) - Установить значение
Slider:Get() - Получить текущее значение
Пример:

Lua

local SpeedSlider = Section:CreateSlider({
    Name = "Walk Speed",
    Min = 16,
    Max = 200,
    Default = 16,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})

SpeedSlider:Set(100)  -- Установить скорость
Dropdown
Создает выпадающий список.

Lua

local Dropdown = Section:CreateDropdown({
    Name = "string",               -- Название
    Options = {"opt1", "opt2"},    -- Список опций
    Default = "string",            -- Выбранная опция
    Callback = function(Value)     -- Функция обратного вызова
        -- Value = выбранная опция
    end
})
Параметры:

Name (string): Название dropdown
Options (table): Массив доступных опций
Default (string): Выбранная по умолчанию опция
Callback (function): Функция, получающая выбранную опцию
Методы:

Dropdown:Set(value) - Установить выбранную опцию
Dropdown:Get() - Получить текущую опцию
Dropdown:Refresh(options) - Обновить список опций
Пример:

Lua

local WeaponDropdown = Section:CreateDropdown({
    Name = "Select Weapon",
    Options = {"Sword", "Bow", "Staff"},
    Default = "Sword",
    Callback = function(Value)
        print("Selected weapon:", Value)
    end
})

WeaponDropdown:Refresh({"Sword", "Bow", "Staff", "Axe"})
TextBox
Создает поле для ввода текста.

Lua

local TextBox = Section:CreateTextBox({
    Name = "string",               -- Название
    Placeholder = "string",        -- Текст-подсказка
    Callback = function(Value)     -- Функция обратного вызова
        -- Value = введенный текст
    end
})
Параметры:

Name (string): Название поля
Placeholder (string): Текст-подсказка
Callback (function): Вызывается при нажатии Enter
Методы:

TextBox:Set(text) - Установить текст
TextBox:Get() - Получить текущий текст
Пример:

Lua

local NameBox = Section:CreateTextBox({
    Name = "Player Name",
    Placeholder = "Enter name...",
    Callback = function(Value)
        print("Name entered:", Value)
    end
})
Keybind
Создает привязку к клавише.

Lua

local Keybind = Section:CreateKeybind({
    Name = "string",               -- Название
    Default = Enum.KeyCode,        -- Клавиша по умолчанию
    Callback = function()          -- Функция при нажатии
        -- код
    end
})
Параметры:

Name (string): Название keybind
Default (Enum.KeyCode): Клавиша по умолчанию
Callback (function): Вызывается при нажатии клавиши
Методы:

Keybind:Set(keycode) - Установить клавишу
Keybind:Get() - Получить текущую клавишу
Пример:

Lua

local ToggleKeybind = Section:CreateKeybind({
    Name = "Toggle Menu",
    Default = Enum.KeyCode.RightControl,
    Callback = function()
        print("Menu toggled!")
    end
})
Label
Создает текстовую метку.

Lua

local Label = Section:CreateLabel("string")
Параметры:

labelText (string): Текст метки
Методы:

Label:Set(text) - Изменить текст
Пример:

Lua

local StatusLabel = Section:CreateLabel("Status: Ready")

-- Обновить текст
StatusLabel:Set("Status: Active")
Notification
Notify
Создает всплывающее уведомление.

Lua

Window:Notify({
    Title = "string",              -- Заголовок
    Content = "string",            -- Содержимое
    Duration = number              -- Длительность в секундах
})
Параметры:

Title (string): Заголовок уведомления
Content (string): Текст уведомления
Duration (number): Длительность показа (по умолчанию: 3)
Пример:

Lua

Window:Notify({
    Title = "Success",
    Content = "Feature enabled successfully!",
    Duration = 4
})
