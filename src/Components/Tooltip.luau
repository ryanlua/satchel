const React = require("../../react")

const e = React.createElement

export type Props = {
	text: string?,
}

const function Tooltip(props: Props)
	-- Hide tooltip if there is no text
	if not props.text or props.text == "" then
		return
	end

	return e("TextLabel", {
		Text = props.text,
		[React.Tag] = "Tooltip",
	})
end

return Tooltip
