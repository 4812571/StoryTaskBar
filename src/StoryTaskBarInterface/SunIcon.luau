local Fusion = require(script.Parent.Parent.Parent.Fusion)

local New = Fusion.New
local Value = Fusion.Value
local OnEvent = Fusion.OnEvent
local Children = Fusion.Children
local Spring = Fusion.Spring

local function SunIcon(props)
	local sunColor = Value(props.NormalColor)

	return New "ImageButton" {
		AnchorPoint = Vector2.new(1, 0),
		Size = UDim2.new(0, 40, 0, 40),
		BackgroundTransparency = 0,
		BackgroundColor3 = Spring(sunColor, 25, 1),
		Image = "rbxassetid://8419178931",
		Position = props.Position,

		[OnEvent("Activated")] = function()
			props.Activated()
		end,

		[OnEvent("MouseEnter")] = function()
			sunColor:set(props.HoverColor)
		end,

		[OnEvent("MouseLeave")] = function()
			sunColor:set(props.NormalColor)
		end,

		[Children] = {
			New "UICorner" {
				CornerRadius = UDim.new(1, 0),
			},

			New "UIStroke" {
				Color = Color3.fromRGB(115, 115, 115),
				Thickness = 4,
			},
		},
	}
end

return SunIcon