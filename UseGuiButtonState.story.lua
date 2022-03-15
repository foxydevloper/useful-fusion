local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Fusion)

local UseGuiButtonState = require(script.Parent.UseGuiButtonState)

return function(target)
    local guiButtonState = Fusion.Value('None')
    local instance = Fusion.New "TextLabel" {
        Parent = target,
        Size = UDim2.fromScale(0.5, 0.5),
        Position = UDim2.fromScale(0.25, 0.25),
        Text = guiButtonState,
        TextScaled = true,
        [UseGuiButtonState] = guiButtonState
    }
    return function()
        instance:Destroy()
    end
end