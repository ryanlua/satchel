--!strict

local React = require(script.Parent.Parent.Parent.react)

local Slot = require(script.Parent.Parent.Components.Slot)

local controls = {
	toolName = "Sword",
	toolImage = "rbxasset://Textures/Sword128.png",
	toolTooltip = "A classic sword",
	equipped = false,
	unlocked = false,
	hint = true,
	order = 1,
}

type Props = {
	controls: typeof(controls),
}

return {
	summary = "Slot representing a single item in the hotbar or inventory, showing the tool and hints for equipping",
	controls = controls,
	story = function(props: Props)
		local tool = Instance.new("Tool")
		tool.Name = props.controls.toolName
		tool.TextureId = props.controls.toolImage
		tool.ToolTip = props.controls.toolTooltip

		return React.createElement(Slot, {
			item = tool,
			equipped = props.controls.equipped,
			unlocked = props.controls.unlocked,
			hint = props.controls.hint,
			order = props.controls.order,
		})
	end,
}
