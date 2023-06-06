local SunIcon = require(script.Parent.SunIcon)

return function(target)
    local sunIcon = SunIcon {
        NormalColor = Color3.new(1, 1, 1),
        HoverColor = Color3.new(0.607843, 0.607843, 0.607843),
        Position = UDim2.new(1, -18, 0, 18),

        Activated = function()
            print("SunIcon Activated")
        end
    }

    sunIcon.Parent = target

    return function()
        sunIcon:Destroy()
    end
end