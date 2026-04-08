--!strict

local React = require(script.Parent.Parent.Parent.react)

local Hotbar = require(script.Parent.Parent.Components.Hotbar)

local controls = {
	slots = 10,
	toolName = "Sword",
	toolImage = "rbxasset://Textures/Sword128.png",
	tooltipText = "A classic sword",
	toolSlot = 1,
	opened = true,
}

type Props = {
	controls: typeof(controls),
}

return {
	summary = "Hotbar on the bottom of the screen that shows equipped tools and hints for equipping",
	controls = controls,
	story = function(props: Props)
		local tool = Instance.new("Tool")
		tool.Name = props.controls.toolName
		tool.TextureId = props.controls.toolImage
		tool.ToolTip = props.controls.tooltipText

		return React.createElement(Hotbar, {
			slots = props.controls.slots,
			items = { [props.controls.toolSlot] = tool },
			opened = props.controls.opened,
		})
	end,
}
