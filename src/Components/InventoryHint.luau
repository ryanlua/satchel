const UserInputService = game:GetService("UserInputService")

const React = require("../../react")

const e = React.createElement

export type Props = {
	keyCode: Enum.KeyCode,
	text: string,
	forceVisible: boolean?,
	order: number?,
}

const function InventoryHint(props: Props)
	local tags = "InventoryHint"
	if props.forceVisible then
		tags = tags .. " Visible"
	end

	return e("Frame", {
		LayoutOrder = props.order,
		[React.Tag] = tags,
	}, {
		KeyCode = e("ImageLabel", {
			Image = UserInputService:GetImageForKeyCode(props.keyCode),
		}),
		Action = e("TextLabel", {
			Text = props.text,
		}),
	})
end

return InventoryHint
