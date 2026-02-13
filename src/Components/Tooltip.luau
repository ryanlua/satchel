local React = require(script.Parent.Parent.Parent.react)

local function Tooltip(props: {
	text: string?,
	children: any?,
})
	-- Hide tooltip if there is no text
	if not props.text or props.text == "" then
		return nil
	end

	return React.createElement("TextLabel", {
		Text = props.text,
		[React.Tag] = "Tooltip",
	}, props.children)
end

return Tooltip
