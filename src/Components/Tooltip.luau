local React = require(script.Parent.Parent.Parent.react)

export type Props = {
	text: string?,
}

local function Tooltip(props: Props)
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
