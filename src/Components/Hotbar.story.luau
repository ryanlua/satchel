local React = require(script.Parent.Parent.Parent.react)

local Hotbar = require(script.Parent.Hotbar)
local Slot = require(script.Parent.Slot)

local controls = {
	forceHintVisible = true,
	toolName = "Sword",
	slotNumber = 9,
	toolImage = "rbxasset://Textures/Sword128.png",
	tooltipText = "A classic sword",
}

type Props = {
	controls: typeof(controls),
}

return {
	summary = "Hotbar component that holds hotbar slots and hints",
	controls = controls,
	story = function(props: Props)
		local Tool = Instance.new("Tool")
		Tool.Name = props.controls.toolName
		Tool.TextureId = props.controls.toolImage
		Tool.ToolTip = props.controls.tooltipText

		local component = React.createElement(Hotbar, {
			forceHintVisible = props.controls.forceHintVisible,
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
