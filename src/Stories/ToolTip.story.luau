local React = require("../../react")
local ReactRoblox = require("../../react-roblox")

local ToolTip = require("../Components/ToolTip")

local controls = {
	Text = "TEH EPIK DUCK IS COMING!!!",
}

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = controls,
	story = function(props)
		local component = React.createElement(ToolTip, {
			text = props.controls.Text,
		}, {
			StyleLink = React.createElement("StyleLink", {
				StyleSheet = game.ReplicatedStorage.Design.SatchelStyleSheet,
			}),
		})

		return component
	end,
}
