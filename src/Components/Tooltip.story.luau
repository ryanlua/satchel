const React = require("../../react")

const Tooltip = require("./Tooltip")

const controls = {
	text = "I'm a tooltip!",
}

type Props = {
	controls: typeof(controls),
}

return {
	summary = "Message displayed when hovering over a slot",
	controls = controls,
	story = function(props: Props)
		return React.createElement(Tooltip, {
			text = props.controls.text,
		})
	end,
}
