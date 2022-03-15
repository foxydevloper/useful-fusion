local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Fusion)

-- Drop-in replacement for Activated that works well with
-- ScrollingFrames on touch devices.
local UseGuiButtonActivated = {}
UseGuiButtonActivated.type = "SpecialKey"
UseGuiButtonActivated.kind = "UseGuiButtonActivated"
UseGuiButtonActivated.stage = "observer"

function UseGuiButtonActivated:apply(callback: () -> (), applyToRef, cleanupTasks)
    Fusion.OnEvent("Activated"):apply(function(inputObject: InputObject)
        if inputObject.UserInputType ~= Enum.UserInputType.Touch then
            callback()
        end
    end, applyToRef, cleanupTasks)
    Fusion.OnEvent("TouchTap"):apply(function()
        callback()
    end, applyToRef, cleanupTasks)
end

return UseGuiButtonActivated