const React = require("../../react")

const Hotbar = require("./Hotbar")
const Inventory = require("./Inventory")
const Slot = require("./Slot")

const e = React.createElement

export type Props = {
	forceKeyboardHintVisible: boolean?,
	slots: number?,
	rows: number?, -- TODO: Add rows for inventory height
	items: { [number]: { item: BackpackItem, equipped: boolean } }?,
	opened: boolean?,
	width: number?,
	height: number?,
	scrollbarGutter: number?,
	swapSourceIndex: number?,
	onSlotActivated: ((item: BackpackItem) -> ())?,
	onSelectSwap: ((slotIndex: number) -> ())?,
	onSlotDrag: Slot.OnDrag?,
}

const function Backpack(props: Props)
	const opened = props.opened or false
	const slots = props.slots or 10

	-- Items at indices 1..slots are hotbar; items above slots are inventory.
	const hotbarItems: { [number]: { item: BackpackItem, equipped: boolean } } = {}
	const inventoryItems: { [number]: { item: BackpackItem, equipped: boolean } } = {}
	if props.items then
		for index, slot in props.items do
			if slot and index > 0 and index <= slots then
				hotbarItems[index] = slot
			elseif slot and index > slots then
				inventoryItems[index - slots] = slot
			end
		end
	end

	return e("Frame", {
		[React.Tag] = "Backpack",
	}, {
		Hotbar = e(Hotbar, {
			forceKeyboardHintVisible = props.forceKeyboardHintVisible,
			slots = slots,
			items = hotbarItems,
			opened = opened,
			swapSourceIndex = props.swapSourceIndex,
			onSlotActivated = props.onSlotActivated,
			onSelectSwap = props.onSelectSwap,
			onSlotDrag = props.onSlotDrag,
		}),
		Inventory = e(Inventory, {
			width = props.width,
			height = props.height,
			scrollbarGutter = props.scrollbarGutter,
			slots = slots,
			rows = props.rows,
			items = inventoryItems,
			opened = opened,
			swapSourceIndex = props.swapSourceIndex,
			onSlotActivated = props.onSlotActivated,
			onSelectSwap = props.onSelectSwap,
			onSlotDrag = props.onSlotDrag,
		}),
	})
end

return Backpack
