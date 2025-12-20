local React = require("../../react")

export type Props = {
	text: string?,
	children: any?,
}

local function ToolTip(props: Props)
	-- Hide tooltip if there is no text
	if not props.text or props.text == "" then
		return nil
	end

	return React.createElement("TextLabel", {
		Text = props.text,
		[React.Tag] = "ToolTip",
	}, props.children)
end

return ToolTip
