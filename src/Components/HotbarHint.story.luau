local React = require(script.Parent.Parent.Parent.react)

local HotbarHint = require(script.Parent.HotbarHint)

local controls = {
	forceVisible = true,
}

type Props = {
	controls: typeof(controls),
}

return {
	summary = "Hint for switching to a hotbar slot, displayed when gamepad is preferred or forced visible",
	controls = controls,
	story = function(props: Props)
		return React.createElement(HotbarHint, {
			hintKey = Enum.KeyCode.ButtonX,
			forceVisible = props.controls.forceVisible,
		})
	end,
}
