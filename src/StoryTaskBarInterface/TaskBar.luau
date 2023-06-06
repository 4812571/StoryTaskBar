local Fusion = require(script.Parent.Parent.Parent.Fusion)

local New = Fusion.New
local ForValues = Fusion.ForValues
local Children = Fusion.Children

local TaskBarTask = require(script.Parent.TaskBarTask)

export type Task = {
    Name: string,
    Activated: () -> ()
}

local function TaskBar(props)
	return New "Frame" {
		Name = "TaskBar",
		Size = UDim2.new(1, 0, props.TaskSize.Y.Scale, props.TaskSize.Y.Offset + 24),
		Position = UDim2.new(0, 0, 1, 0),
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 1),

		[Children] = {
			New "UIListLayout" {
				Padding = UDim.new(0, 10),
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
			},

			ForValues(props.Tasks, function(task: Task)
				return TaskBarTask {
                    Name = task.Name,
					TaskSize = props.TaskSize,
					UnhoveredColor = props.ButtonUnhoveredColor,
					HoveredColor = props.ButtonHoveredColor,
					Activated = task.Activated,
				}
			end),
		},
	}
end

return TaskBar