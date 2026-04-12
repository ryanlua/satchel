--!strict

const React = require("../../react")

export type Props = {
	text: string?,
}

const function Tooltip(props: Props)
	-- Hide tooltip if there is no text
	if not props.text or props.text == "" then
		return
	end

	return React.createElement("TextLabel", {
		Text = props.text,
		[React.Tag] = "Tooltip",
	})
end

return Tooltip
