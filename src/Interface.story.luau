local Fusion = require(script.Parent.Parent.Fusion)

local New = Fusion.New
local Value = Fusion.Value

local StoryTaskBarInterface = require(script.Parent.StoryTaskBarInterface)

local function TestUI(props)
    return New "TextLabel" {
        Text = props.Text,
        Size = UDim2.fromScale(0.215, 0.128),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
    }
end

return function(target)
    local text = Value("Button has not been pressed.")

    local tasks = {
        {
            Name = "1",
            Activated = function()
                text:set("Button 1 has been pressed.")
            end,
        }, {
            Name = "2",
            Activated = function()
                text:set("Button 2 has been pressed.")
            end,
        }, {
            Name = "3",
            Activated = function()
                text:set("Button 3 has been pressed.")
            end,
        }
    }

    local storyTaskBarInterface = StoryTaskBarInterface {
        Tasks = tasks,
        TaskSize = UDim2.new(0.075, 0, 0.04, 0),
        Size = Value(UDim2.fromScale(1, 1)),
        Offset = UDim2.fromScale(0, 0),
        ButtonUnhoveredColor = Color3.new(1, 1, 1),
        ButtonHoveredColor = Color3.new(0.607843, 0.607843, 0.607843),
        
        DisplayedUI = TestUI {
            Text = text,
        },
    }

    storyTaskBarInterface.Parent = target

    return function()
        storyTaskBarInterface:Destroy()
    end
end