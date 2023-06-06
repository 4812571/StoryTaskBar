local Fusion = require(script.Parent.Parent.Parent.Fusion)

local TaskBar = require(script.Parent.TaskBar)

local function Tasks()
    local task1 = {
        Name = "Test 1",
        Activated = function()
            print("Test 1 Activated")
        end,
    }

    local task2 = {
        Name = "Test 2",
        Activated = function()
            print("Test 2 Activated")
        end,
    }

    local task3 = {
        Name = "Test 3",
        Activated = function()
            print("Test 3 Activated")
        end,
    }

    local task4 = {
        Name = "Test 4",
        Activated = function()
            print("Test 4 Activated")
        end,
    }

    return {task1, task2, task3, task4}
end

return function(target)
    local tasks = Tasks()

    local taskBar = TaskBar {
        Tasks = tasks,
        TaskSize = UDim2.new(0.075, 0, 0.04, 0),
        ButtonUnhoveredColor = Color3.new(1, 1, 1),
        ButtonHoveredColor = Color3.new(0.607843, 0.607843, 0.607843),
    }

    taskBar.Parent = target

    return function()
        taskBar:Destroy()
    end
end