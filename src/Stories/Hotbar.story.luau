local React = require("../../react")
local ReactRoblox = require("../../react-roblox")

local Hotbar = require("../Components/Hotbar")
local Slot = require("../Components/Slot")

local controls = {
	ForceHintVisible = true,
}

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = controls,
	story = function(props)
		local Tool = Instance.new("Tool")
		Tool.Name = props.controls.ToolName
		Tool.TextureId = props.controls.ToolImage
		Tool.ToolTip = props.controls.TooltipText

		local component = React.createElement(Hotbar, {
			forceHintVisible = props.controls.ForceHintVisible,
		}, {
			Tool = React.createElement(Slot, {
				tool = Tool,
				slotNumber = 1,
				order = 1,
			}),
			StyleLink = React.createElement("StyleLink", {
				StyleSheet = script.Parent.Parent.StyleSheets.SatchelStyleSheet,
			}),
		})

		return component
	end,
}
