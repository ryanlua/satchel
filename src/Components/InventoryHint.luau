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
	return React.createElement("Frame", {
		LayoutOrder = props.order,
		Visible = props.forceVisible,
		[React.Tag] = "InventoryHint",
	}, {
		KeyCode = React.createElement("ImageLabel", {
			Image = UserInputService:GetImageForKeyCode(props.keyCode),
		}),
		Action = React.createElement("TextLabel", {
			Text = props.text,
		}),
	})
end

return InventoryHint
