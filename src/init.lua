-- sun icon designed by Aranagraphics from Flaticon
local Fusion = require(script.Parent.Fusion)

local New = Fusion.New
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent
local Value = Fusion.Value
local Computed = Fusion.Computed
local Spring = Fusion.Spring
local ForValues = Fusion.ForValues

local BACK_DARK = Color3.fromRGB(46, 46, 46)
local BACK_LIGHT = Color3.fromRGB(245, 238, 214)

local StoryTaskBar = {}
StoryTaskBar.__index = StoryTaskBar

function StoryTaskBar.new()
	local self = setmetatable({}, StoryTaskBar)

	self._backgroundSize = Fusion.Value(UDim2.new(1, 0, 1, 0))
	self._backgroundOffset = UDim2.new(0, 0, 0, 0)
	self._taskSize = UDim2.new(0.075, 0, 0.04, 0)
	self._constructor = function() end
	self._destructor = function() end
	self._tasks = Value({})
	self._meta = {}

	self._darkTheme = Value(true)
	self._backgroundColor = Computed(function()
		return if self._darkTheme:get() then BACK_DARK else BACK_LIGHT
	end)

	return self
end

function StoryTaskBar:setConstructor(func: (Instance) -> ())
	self._constructor = func
end

function StoryTaskBar:setDestructor(func: (meta: any?) -> ())
	self._destructor = func
end

function StoryTaskBar:setBackgroundSize(size: UDim2)
	self._backgroundSize:set(size)
end

function StoryTaskBar:setBackgroundOffset(offset: UDim2)
	self._backgroundOffset = offset
end

function StoryTaskBar:setTaskSize(size: UDim2)
	self._taskSize = size
end

function StoryTaskBar:addTask(name: string, task: () -> ())
	local newTasks = {}
	local newTask = {
		name = name,
		func = task,
	}

	-- insert task
	for index, value in next, self._tasks:get(false) do
		newTasks[index] = value
	end

	table.insert(newTasks, newTask)
	self._tasks:set(newTasks)

	return function()
		-- remove task
		newTasks = {}
		local didChange: boolean = false

		for index, value in next, self._tasks:get(false) do
			if value ~= task then
				newTasks[index] = value
			else
				didChange = true
			end
		end

		if didChange then
			self._tasks:set(newTasks)
		end
	end
end

function StoryTaskBar:toStory()
	return function(target)
		local sunHover = Value(Color3.new(1, 1, 1))

		local background = New("Frame")({
			Name = "Background",
			AnchorPoint = Vector2.new(0.5, 0.5),
			Size = Fusion.Spring(self._backgroundSize, 30, 1),
			BackgroundTransparency = 1,
			Position = UDim2.new(0.5, 0, 0.5, 0) + self._backgroundOffset,
		})

		local holder = New("Frame")({
			Parent = target,
			Name = "Holder",
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundColor3 = Spring(self._backgroundColor, 25, 1),
			BackgroundTransparency = 0,

			[Children] = {
				background,

				New("ImageButton")({
					AnchorPoint = Vector2.new(1, 0),
					Size = UDim2.new(0, 40, 0, 40),
					BackgroundTransparency = 0,
					BackgroundColor3 = Spring(sunHover, 25, 1),
					Image = "rbxassetid://8419178931",
					Position = UDim2.new(1, -18, 0, 18),

					[OnEvent("Activated")] = function()
						self._darkTheme:set(not self._darkTheme:get(false))
					end,

					[OnEvent("MouseEnter")] = function()
						sunHover:set(Color3.new(0.607843, 0.607843, 0.607843))
					end,

					[OnEvent("MouseLeave")] = function()
						sunHover:set(Color3.new(1, 1, 1))
					end,

					[Children] = {
						New("UICorner")({
							CornerRadius = UDim.new(1, 0),
						}),

						New("UIStroke")({
							Color = Color3.fromRGB(115, 115, 115),
							Thickness = 4,
						}),
					},
				}),

				New("Frame")({
					Name = "TaskBar",
					Size = UDim2.new(1, 0, self._taskSize.Y.Scale, self._taskSize.Y.Offset + 24),
					Position = UDim2.new(0, 0, 1, 0),
					BackgroundTransparency = 1,
					AnchorPoint = Vector2.new(0, 1),

					[Children] = {
						New("UIListLayout")({
							Padding = UDim.new(0, 10),
							FillDirection = Enum.FillDirection.Horizontal,
							HorizontalAlignment = Enum.HorizontalAlignment.Center,
							VerticalAlignment = Enum.VerticalAlignment.Center,
						}),

						ForValues(self._tasks, function(task)
							local name = task.name
							local func = task.func

							local buttonHover = Value(Color3.fromRGB(204, 204, 204))

							local button = New("TextButton")({
								Size = UDim2.new(self._taskSize.X.Scale, self._taskSize.X.Offset, 1, -24),
								BackgroundColor3 = Spring(buttonHover, 25, 1),
								BackgroundTransparency = 0,

								[OnEvent("Activated")] = function()
									func(unpack(self._meta))
								end,

								[OnEvent("MouseEnter")] = function()
									buttonHover:set(Color3.new(0.55, 0.55, 0.55))
								end,

								[OnEvent("MouseLeave")] = function()
									buttonHover:set(Color3.fromRGB(204, 204, 204))
								end,

								[Children] = {
									New("UICorner")({
										CornerRadius = UDim.new(0, 5),
									}),

									New("TextLabel")({
										BackgroundTransparency = 1,
										AnchorPoint = Vector2.new(0.5, 0.5),
										Size = UDim2.new(0.8, 0, 0.6, 0),
										Position = UDim2.new(0.5, 0, 0.5, 0),
										Font = Enum.Font.FredokaOne,
										TextColor3 = Color3.new(),
										Text = name,
										TextScaled = true,
									}),
								},
							})

							return button
						end),
					},
				}),
			},
		})

		self._meta = { self._constructor(background) }

		return function()
			self._destructor(unpack(self._meta))
			holder:Destroy()
		end
	end
end

return StoryTaskBar.new
