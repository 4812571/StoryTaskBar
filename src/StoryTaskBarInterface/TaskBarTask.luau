local Fusion = require(script.Parent.Parent.Parent.Fusion)

local New = Fusion.New
local Value = Fusion.Value
local Spring = Fusion.Spring
local OnEvent = Fusion.OnEvent
local Children = Fusion.Children

local function TaskBarTask(props)
	local buttonColor = Value(props.UnhoveredColor)

	return New "TextButton" {
		Size = UDim2.new(props.TaskSize.X.Scale, props.TaskSize.X.Offset, 1, -24),
		BackgroundColor3 = Spring(buttonColor, 25, 1),
		BackgroundTransparency = 0,

		[OnEvent "Activated"] = function()
			props.Activated()
		end,

		[OnEvent "MouseEnter"] = function()
			buttonColor:set(props.HoveredColor)
		end,

		[OnEvent "MouseLeave"] = function()
			buttonColor:set(props.UnhoveredColor)
		end,

		[Children] = {
			New "UICorner" {
				CornerRadius = UDim.new(0, 5),
			},

			New "TextLabel" {
				BackgroundTransparency = 1,
				AnchorPoint = Vector2.new(0.5, 0.5),
				Size = UDim2.new(0.8, 0, 0.6, 0),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				Font = Enum.Font.FredokaOne,
				TextColor3 = Color3.new(),
				Text = props.Name,
				TextScaled = true,
			}
		}
	}
end

return TaskBarTask