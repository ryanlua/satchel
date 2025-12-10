--!strict

local React = require("../../react")
local ReactRoblox = require("../../react-roblox")

local HotbarHint = require("../Components/HotbarHint")

local controls = {
	HintImage = "rbxasset://textures/ui/Controls/DesignSystem/ButtonX.png",
	Visible = true,
}

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = controls,
	story = function(props)
		local component = React.createElement(HotbarHint, {
			hintImage = props.controls.HintImage,
			forceVisible = props.controls.Visible,
		}, {
			StyleLink = React.createElement("StyleLink", {
				StyleSheet = game.ReplicatedStorage.Design.SatchelStyleSheet,
			}),
		})

		return component
	end,
}
