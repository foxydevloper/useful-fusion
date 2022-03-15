local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Fusion)

-- Special key that stores the current state of the button into a state object
-- as 'None', 'Hovering', 'Pressed'. This is useful as a replacement to AutoButtonColor.
local UseGuiButtonState = {}
UseGuiButtonState.type = "SpecialKey"
UseGuiButtonState.kind = "UseGuiButtonState"
UseGuiButtonState.stage = "observer"

function UseGuiButtonState:apply(outValue, applyToRef, cleanupTasks)
    outValue:set('None')
    Fusion.OnEvent("InputBegan"):apply(function(inputObject: InputObject)
        if inputObject.UserInputType == Enum.UserInputType.MouseMovement
        and inputObject.UserInputState == Enum.UserInputState.Change then
            outValue:set("Hovering")
        end
        if inputObject.UserInputType == Enum.UserInputType.MouseButton1
        and inputObject.UserInputState == Enum.UserInputState.Begin then
            outValue:set("Pressing")
        end
        if inputObject.UserInputType == Enum.UserInputType.Touch
        and inputObject.UserInputState == Enum.UserInputState.Begin then
            outValue:set("Pressing")
        end
    end, applyToRef, cleanupTasks)
    Fusion.OnEvent("InputEnded"):apply(function(inputObject: InputObject)
        if inputObject.UserInputType == Enum.UserInputType.MouseMovement
        and inputObject.UserInputState == Enum.UserInputState.Change then
            outValue:set("None")
        end
        if inputObject.UserInputType == Enum.UserInputType.MouseButton1
        and inputObject.UserInputState == Enum.UserInputState.End
        and outValue:get() == 'Pressing' then
            outValue:set("Hovering")
        end
        if inputObject.UserInputType == Enum.UserInputType.Touch
        and inputObject.UserInputState == Enum.UserInputState.End then
            outValue:set("None")
        end
        -- When TouchTap is no longer possible due to a drag, `inputObject`
        -- will have a state of `Change`.
        if inputObject.UserInputType == Enum.UserInputType.Touch
        and inputObject.UserInputState == Enum.UserInputState.Change then
            outValue:set("None")
        end
    end, applyToRef, cleanupTasks)
end

return UseGuiButtonState