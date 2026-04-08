--!strict

local React = require(script.Parent.Parent.Parent.react)

local Inventory = require(script.Parent.Parent.Components.Inventory)

local controls = {
	toolName = "Sword",
	toolImage = "rbxasset://Textures/Sword128.png",
	tooltipText = "A classic sword",
	rows = 4,
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

		return React.createElement(Inventory, {
			rows = props.controls.rows,
			width = 655,
			items = { [1] = tool },
		})
	end,
}
