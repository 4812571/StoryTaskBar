local Fusion = require(script.Parent.Fusion)

local Value = Fusion.Value

local StoryTaskBarInterface = require(script.StoryTaskBarInterface)

local function default(value, defaultValue)
	if value == nil then
		return defaultValue
	end

	return value
end

local function StoryTaskBar(props)
	local backgroundSize = default(props.BackgroundSize, UDim2.fromScale(1, 1))
	local backgroundOffset = default(props.BackgroundOffset, UDim2.fromScale(0, 0))
	local buttonSize = default(props.ButtonSize, UDim2.fromScale(0.075, 0.04))

	return function(fn)
		return function(target)
			local displayedUI = Value(nil)
			local tasks = Value({})
	
			local function mount(ui)
				displayedUI:set(ui)
			end
	
			local function task(name, func)
				local taskDescription = {
					Name = name,
					Activated = func,
				}
	
				local previousTasks = tasks:get()
				table.insert(previousTasks, taskDescription)
				tasks:set(previousTasks, true)
			end
	
			local fnCleanup = fn(mount, task)
	
			local interface = StoryTaskBarInterface {
				Size = Value(backgroundSize),
				Offset = backgroundOffset,
				Tasks = tasks,
				TaskSize = buttonSize,
				DisplayedUI = displayedUI,
			}
	
			interface.Parent = target
	
			return function()
				fnCleanup()
				interface:Destroy()
			end
		end
	end
end

return StoryTaskBar