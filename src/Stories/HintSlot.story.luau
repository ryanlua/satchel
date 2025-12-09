--!strict

local React = require("../../react")
local ReactRoblox = require("../../react-roblox")

local HintSlot = require("../Components/HintSlot")

local controls = {
	HintImage = "rbxasset://textures/ui/Controls/DesignSystem/ButtonX.png",
}

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = controls,
	story = function(props)
		local component = React.createElement(HintSlot, {
			hintImage = props.controls.HintImage,
		}, {
			StyleLink = React.createElement("StyleLink", {
				StyleSheet = game.ReplicatedStorage.Design.SatchelStyleSheet,
			}),
		})

		return component
	end,
}
