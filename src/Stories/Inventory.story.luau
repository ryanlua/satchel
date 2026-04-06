--!strict

local React = require(script.Parent.Parent.Parent.react)

local Inventory = require(script.Parent.Parent.Components.Inventory)

local controls = {
	toolName = "Sword",
	toolImage = "rbxasset://Textures/Sword128.png",
	tooltipText = "A classic sword",
	toolSlot = 1,
}

type Props = {
	controls: typeof(controls),
}

return {
	summary = "Toggleable inventory for displaying items not in the hotbar",
	controls = controls,
	story = function(props: Props)
		local tool = Instance.new("Tool")
		tool.Name = props.controls.toolName
		tool.TextureId = props.controls.toolImage
		tool.ToolTip = props.controls.tooltipText

		local tools = {}
		tools[props.controls.toolSlot] = tool

		return React.createElement(Inventory, {
			size = UDim2.fromOffset(655, 300),
			tools = tools,
		})
	end,
}
