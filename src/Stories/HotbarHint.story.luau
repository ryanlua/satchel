local React = require("../../react")
local ReactRoblox = require("../../react-roblox")

local HotbarHint = require("../Components/HotbarHint")

local controls = {
	ForceHintVisible = true,
}

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = controls,
	story = function(props)
		local component = React.createElement(HotbarHint, {
			hintKey = Enum.KeyCode.ButtonX,
			forceVisible = props.controls.ForceHintVisible,
		}, {
			StyleLink = React.createElement("StyleLink", {
				StyleSheet = script.Parent.Parent.StyleSheets.SatchelStyleSheet,
			}),
		})

		return component
	end,
}
