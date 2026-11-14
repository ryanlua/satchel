const React = require("../../react")

const App = require("./App")

const e = React.createElement

const controls = {
	hintVisible = true,
	slots = 10,
	toolName = "Sword",
	toolImage = "rbxasset://Textures/Sword128.png",
	toolTooltip = "A classic sword",
	toolSlot = 1,
	toolEquipped = false,
	opened = true,
	rows = 4,
	extraTools = 4,
	tenFootInterface = false,
}

type Props = {
	controls: typeof(controls),
}

type Items = { [number]: { item: BackpackItem, equipped: boolean } }

const function createTool(name: string, image: string, tooltip: string): Tool
	const tool = Instance.new("Tool")
	tool.Name = name
	tool.TextureId = image
	tool.ToolTip = tooltip
	return tool
end

const function findIndex(items: Items, item: BackpackItem): number?
	for index, slot in items do
		if slot.item == item then
			return index
		end
	end
	return nil
end

-- Keeps item placement in local state so slots can be dragged around in the story
const function DraggableApp(props: Props)
	const slots = props.controls.slots

	const items, setItems = React.useState(function(): Items
		const initialItems: Items = {
			[props.controls.toolSlot] = {
				item = createTool(props.controls.toolName, props.controls.toolImage, props.controls.toolTooltip),
				equipped = props.controls.toolEquipped,
			},
		}
		for toolNumber = 1, props.controls.extraTools do
			initialItems[slots + toolNumber] = {
				item = createTool(`Tool {toolNumber}`, "", `Inventory tool {toolNumber}`),
				equipped = false,
			}
		end
		return initialItems
	end)

	return e(App, {
		forceGamepadHintVisible = props.controls.hintVisible,
		slots = slots,
		items = items,
		opened = props.controls.opened,
		rows = props.controls.rows,
		tenFootInterface = props.controls.tenFootInterface,
		onMove = function(item: BackpackItem, targetIndex: number)
			const index = findIndex(items, item)
			if index then
				const nextItems = table.clone(items)
				nextItems[index], nextItems[targetIndex] = nextItems[targetIndex], nextItems[index]
				setItems(nextItems)
			end
		end,
	})
end

return {
	summary = "Hotbar and inventory, including hints for gamepad controls. Slots can be dragged between the hotbar and inventory.",
	controls = controls,
	story = function(props: Props)
		-- App positions itself within its parent, so keep it out of the storybook's UIListLayout
		return e("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
		}, {
			App = e(DraggableApp, props),
		})
	end,
}
