const UserInputService = game:GetService("UserInputService")

const React = require("../../react")

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

	return React.createElement("Frame", {
		LayoutOrder = props.order,
		Visible = props.visible,
		[React.Tag] = tags,
	}, {
		KeyCode = React.createElement("ImageLabel", {
			Image = UserInputService:GetImageForKeyCode(props.keyCode),
		}),
	})
end

return HotbarHint
