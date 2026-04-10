--!strict

local UserInputService = game:GetService("UserInputService")

local React = require(script.Parent.Parent.Parent.react)

export type Props = {
	keyCode: Enum.KeyCode,
	forceVisible: boolean?,
	order: number?,
	visible: boolean?,
}

local function HotbarHint(props: Props)
	local visible = props.visible and props.forceVisible

	return React.createElement("Frame", {
		LayoutOrder = props.order,
		Visible = visible,
		[React.Tag] = "HotbarHint",
	}, {
		KeyCode = React.createElement("ImageLabel", {
			Image = UserInputService:GetImageForKeyCode(props.keyCode),
		}),
	})
end

return HotbarHint
