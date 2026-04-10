--!strict

local UserInputService = game:GetService("UserInputService")

local React = require("../../react")

export type Props = {
	keyCode: Enum.KeyCode,
	text: string,
	forceVisible: boolean?,
	order: number?,
}

local function InventoryHint(props: Props)
	local tags = "InventoryHint"
	if props.forceVisible then
		tags = tags .. " Visible"
	end

	return React.createElement("Frame", {
		LayoutOrder = props.order,
		[React.Tag] = tags,
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
