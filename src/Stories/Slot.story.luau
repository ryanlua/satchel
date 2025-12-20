local React = require("../../react")
local ReactRoblox = require("../../react-roblox")

local Slot = require("../Components/Slot")

local controls = {
	ToolName = "Sword",
	SlotNumber = 9,
	ToolImage = "rbxasset://Textures/Sword128.png",
	TooltipText = "A classic sword",
	Equipped = false,
	Unlocked = false,
	ForceNumberVisible = true,
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

		local component = React.createElement(Slot, {
			tool = Tool,
			slotNumber = props.controls.SlotNumber,
			equipped = props.controls.Equipped,
			unlocked = props.controls.Unlocked,
			forceVisible = props.controls.ForceNumberVisible,
		}, {
			StyleLink = React.createElement("StyleLink", {
				StyleSheet = game.ReplicatedStorage.Design.SatchelStyleSheet,
			}),
		})

		return component
	end,
}
