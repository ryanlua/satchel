--!strict

local React = require(script.Parent.Parent.Parent.react)

local Slot = require(script.Parent.Parent.Components.Slot)

local controls = {
	toolName = "Sword",
	toolImage = "rbxasset://Textures/Sword128.png",
	toolTooltip = "A classic sword",
	equipped = false,
	unlocked = false,
	order = 1,
}

type Props = {
	controls: typeof(controls),
}

return {
	summary = "Slot representing a single item in the hotbar or inventory, showing the tool and hints for equipping",
	controls = controls,
	story = function(props: Props)
		local Tool = Instance.new("Tool")
		Tool.Name = props.controls.toolName
		Tool.TextureId = props.controls.toolImage
		Tool.ToolTip = props.controls.toolTooltip

		return React.createElement(Slot, {
			tool = Tool,
			equipped = props.controls.equipped,
			unlocked = props.controls.unlocked,
			order = props.controls.order,
		})
	end,
}
