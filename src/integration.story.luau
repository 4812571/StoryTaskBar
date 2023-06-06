local Fusion = require(script.Parent.Parent.Fusion)

local StoryTaskBar = require(script.Parent)

local New = Fusion.New
local Value = Fusion.Value

local function TestUI(props)
    return New "TextLabel" {
        Text = props.Text,
        Size = UDim2.fromScale(0.215, 0.128),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
    }
end

local StoryBook = StoryTaskBar {

}

return StoryBook(function(mount, task)
    local text = Value("Button has not been pressed.")

    task("1", function()
        text:set("Button 1 has been pressed.")
    end)

    task("2", function()
        text:set("Button 2 has been pressed.")
    end)

    task("3", function()
        text:set("Button 3 has been pressed.")
    end)

    local ui = TestUI {
        Text = text,
    }

    mount(ui)

    return function()
        ui:Destroy()
    end
end)