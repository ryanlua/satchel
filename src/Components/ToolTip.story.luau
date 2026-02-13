local React = require(script.Parent.Parent.Parent.react)

local ToolTip = require(script.Parent.ToolTip)

local controls = {
	text = "I'm a tooltip!",
}

type Props = {
	controls: typeof(controls),
}

return {
	controls = controls,
	story = function(props: Props)
		return React.createElement(ToolTip, {
			text = props.controls.text,
		}, {
			StyleLink = React.createElement("StyleLink", {
				StyleSheet = script.Parent.Parent.StyleSheets.SatchelStyleSheet,
			}),
		})
	end,
}
