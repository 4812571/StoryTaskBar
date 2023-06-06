local Fusion = require(script.Parent.Parent.Fusion)

local New = Fusion.New
local Value = Fusion.Value
local Spring = Fusion.Spring
local Computed = Fusion.Computed
local Children = Fusion.Children

local SunIcon = require(script.SunIcon)
local TaskBar = require(script.TaskBar)

local function Background(props)
    return New "Frame" {
        Name = "Background",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = Spring(props.Size, 30, 1),
        BackgroundTransparency = 1,
        Position = UDim2.fromScale(0.5, 0.5) + props.Offset,
        [Children] = props[Children],
    }
end

local BACKGROUND_DARK = Color3.fromRGB(46, 46, 46)
local BACKGROUND_LIGHT = Color3.fromRGB(245, 238, 214)

local function StoryTaskBarInterface(props)
    local isDarkTheme = Value(true)

    local backgroundColor = Computed(function()
        if isDarkTheme:get() then
            return BACKGROUND_DARK
        else
            return BACKGROUND_LIGHT
        end
    end)

    return New "Frame" {
        Name = "StoryTaskBar",
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Spring(backgroundColor, 25, 1),
        BackgroundTransparency = 0,

        [Children] = {
            SunIcon {
                NormalColor = Color3.new(1, 1, 1),
                HoverColor = Color3.new(0.607843, 0.607843, 0.607843),
                Position = UDim2.new(1, -18, 0, 18),

                Activated = function()
                    isDarkTheme:set(not isDarkTheme:get())
                end,
            },

            TaskBar {
                Tasks = props.Tasks,
                TaskSize = props.TaskSize,
                ButtonHoveredColor = Color3.new(0.55, 0.55, 0.55),
                ButtonUnhoveredColor = Color3.fromRGB(204, 204, 204),
            },

            Background {
                Size = props.Size,
                Offset = props.Offset,
                [Children] = props.DisplayedUI,
            },
        }
    }
end

return StoryTaskBarInterface