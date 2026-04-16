const React = require("../../react")

const Backpack = require("./Backpack")

const controls = {
	slots = 10,
	toolName = "Sword",
	toolImage = "rbxasset://Textures/Sword128.png",
	toolTooltip = "A classic sword",
	toolSlot = 1,
	opened = true,
	rows = 4,
}

type Props = {
	controls: typeof(controls),
}

return {
	summary = "Backpack that holds the hotbar and inventory",
	controls = controls,
	story = function(props: Props)
		const tool = Instance.new("Tool")
		tool.Name = props.controls.toolName
		tool.TextureId = props.controls.toolImage
		tool.ToolTip = props.controls.toolTooltip

		return React.createElement(Backpack, {
			slots = props.controls.slots,
			items = { [props.controls.toolSlot] = tool },
			opened = props.controls.opened,
			rows = props.controls.rows,
		})
	end,
}
