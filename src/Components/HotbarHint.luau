const UserInputService = game:GetService("UserInputService")

const React = require("../../react")

const e = React.createElement

export type Props = {
	keyCode: Enum.KeyCode,
	forceVisible: boolean?,
	order: number?,
	visible: boolean?,
}

const function HotbarHint(props: Props)
	local tags = "HotbarHint"
	if props.forceVisible then
		tags = tags .. " Visible"
	end

	return e("Frame", {
		LayoutOrder = props.order,
		Visible = props.visible,
		[React.Tag] = tags,
	}, {
		KeyCode = e("ImageLabel", {
			Image = UserInputService:GetImageForKeyCode(props.keyCode),
		}),
	})
end

return HotbarHint
