local React = require(script.Parent.Parent.Parent.react)

local function ToolTip(props: {
	text: string?,
})
	-- Hide tooltip if there is no text
	if not props.text or props.text == "" then
		return nil
	end

	return React.createElement("TextLabel", {
		Text = props.text,
		[React.Tag] = "ToolTip",
	})
end

return ToolTip
