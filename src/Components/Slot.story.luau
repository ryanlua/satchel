local React = require(script.Parent.Parent.Parent.react)

local Slot = require(script.Parent.Slot)

local controls = {
	toolName = "Sword",
	slotNumber = 9,
	toolImage = "rbxasset://Textures/Sword128.png",
	tooltipText = "A classic sword",
	equipped = false,
	unlocked = false,
	forceNumberVisible = true,
}

type Props = {
	controls: typeof(controls),
}

return {
	summary = "Text button that can hold a tool",
	controls = controls,
	story = function(props: Props)
		local Tool = Instance.new("Tool")
		Tool.Name = props.controls.toolName
		Tool.TextureId = props.controls.toolImage
		Tool.ToolTip = props.controls.tooltipText

		return React.createElement(Slot, {
			tool = Tool,
			slotNumber = props.controls.slotNumber,
			equipped = props.controls.equipped,
			unlocked = props.controls.unlocked,
			forceVisible = props.controls.forceNumberVisible,
		})
	end,
}
