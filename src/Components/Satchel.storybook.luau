--!strict

const React = require("../../react")
const ReactRoblox = require("../../react-roblox")

const DESIGN_SHEET = script.Parent.Parent.Design.SatchelStyleSheet

return {
	name = "Satchel",
	mapStory = function(Story)
		return function(storyProps)
			return React.createElement(React.Fragment, nil, {
				UIListLayout = React.createElement("UIListLayout", {
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					VerticalAlignment = Enum.VerticalAlignment.Center,
				}),
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
