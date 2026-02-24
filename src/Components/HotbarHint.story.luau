--!strict

local React = require(script.Parent.Parent.Parent.react)

local HotbarHint = require(script.Parent.HotbarHint)

local controls = {
	forceVisible = true,
}

type Props = {
	controls: typeof(controls),
}

return {
	name = "Hotbar Hint",
	summary = "Hint shown in the hotbar to show how to equip slots",
	controls = controls,
	story = function(props: Props)
		return React.createElement(HotbarHint, {
			keyCode = Enum.KeyCode.ButtonX,
			forceVisible = props.controls.forceVisible,
		})
	end,
}
