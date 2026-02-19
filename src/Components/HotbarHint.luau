--!strict

local UserInputService = game:GetService("UserInputService")

local React = require(script.Parent.Parent.Parent.react)

export type Props = {
	hintKey: Enum.KeyCode,
	forceVisible: boolean?,
	order: number?,
}

local function HotbarHint(props: Props)
	-- Only show hint if gamepad is preferred or forced visible
	local isGamepadPreferred, setIsGamepadPreferred =
		React.useState(UserInputService.PreferredInput == Enum.PreferredInput.Gamepad)

	React.useEffect(function()
		local function preferredInputChanged()
			local preferredInput = UserInputService.PreferredInput

			if preferredInput == Enum.PreferredInput.Gamepad then
				setIsGamepadPreferred(true)
			else
				setIsGamepadPreferred(false)
			end
		end

		preferredInputChanged()
		local signal: RBXScriptConnection = UserInputService:GetPropertyChangedSignal("PreferredInput")
			:Connect(preferredInputChanged)

		return function()
			signal:Disconnect()
		end
	end, {})

	local visible = props.forceVisible == true or isGamepadPreferred

	return React.createElement("ImageLabel", {
		Image = UserInputService:GetImageForKeyCode(props.hintKey),
		LayoutOrder = props.order,
		Visible = visible,
		[React.Tag] = "HintSlot",
	})
end

return HotbarHint
