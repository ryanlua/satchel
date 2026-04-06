--!strict

local UserInputService = game:GetService("UserInputService")

local React = require(script.Parent.Parent.Parent.react)

export type Props = {
	keyCode: Enum.KeyCode,
	text: string,
	forceVisible: boolean?,
	order: number?,
}

local function InventoryHint(props: Props)
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

		-- preferredInputChanged()
		local signal = UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(preferredInputChanged)

		return function()
			signal:Disconnect()
		end
	end, {})

	local visible = props.forceVisible or isGamepadPreferred

	return React.createElement("Frame", {
		LayoutOrder = props.order,
		Visible = visible,
		[React.Tag] = "InventoryHint",
	}, {
		Image = React.createElement("ImageLabel", {
			Image = UserInputService:GetImageForKeyCode(props.keyCode),
		}),
		KeyCode = React.createElement("TextLabel", {
			Text = props.text,
		}),
	})
end

return InventoryHint
