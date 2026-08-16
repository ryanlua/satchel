const React = require("../../react")

const Inventory = require("./Inventory")

const e = React.createElement

const controls = {
	toolName = "Sword",
	toolImage = "rbxasset://Textures/Sword128.png",
	tooltipText = "A classic sword",
	toolEquipped = false,
	rows = 4,
}

type Props = {
	controls: typeof(controls),
}

return {
	summary = "Toggleable inventory for displaying items not in the hotbar",
	controls = controls,
	story = function(props: Props)
		const tool = Instance.new("Tool")
		tool.Name = props.controls.toolName
		tool.TextureId = props.controls.toolImage
		tool.ToolTip = props.controls.tooltipText

		return e(Inventory, {
			rows = props.controls.rows,
			width = 655,
			items = {
				[1] = {
					item = tool,
					equipped = props.controls.toolEquipped,
				},
			},
		})
	end,
}
