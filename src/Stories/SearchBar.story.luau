local React = require("../../react")
local ReactRoblox = require("../../react-roblox")

local SearchBar = require("../Components/SearchBar")

return {
	react = React,
	reactRoblox = ReactRoblox,
	story = function()
		local component = React.createElement(SearchBar, {
			size = UDim2.fromOffset(190, 30),
		}, {
			StyleLink = React.createElement("StyleLink", {
				StyleSheet = script.Parent.Parent.StyleSheets.SatchelStyleSheet,
			}),
		})

		return component
	end,
}
