--!strict

local React = require(script.Parent.Parent.Parent.react)
local ReactRoblox = require(script.Parent.Parent.Parent["react-roblox"])

local DESIGN_SHEET = script.Parent.Parent.StyleSheets.SatchelStyleSheet

return {
	name = "Satchel",
	mapStory = function(Story)
		return function(storyProps)
			return React.createElement(React.Fragment, nil, {
				StyleLink = React.createElement("StyleLink", {
					StyleSheet = DESIGN_SHEET,
				}),

				Story = React.createElement(Story, storyProps),
			})
		end
	end,
	storyRoots = {
		script.Parent,
	},
	packages = {
		React = React,
		ReactRoblox = ReactRoblox,
	},
}
