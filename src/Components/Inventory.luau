const React = require("../../react")

const Searchbar = require("./Searchbar")
const Slot = require("./Slot")

const e = React.createElement

export type Props = {
	width: number?,
	slotPitch: number?,
	slots: number?,
	rows: number?,
	items: { [number]: { item: BackpackItem, equipped: boolean } }?,
	opened: boolean?,
	draggingItem: BackpackItem?,
	swapSourceIndex: number?,
	onSlotActivated: ((item: BackpackItem) -> ())?,
	onSelectSwap: ((slotIndex: number) -> ())?,
	onSlotDrag: Slot.OnDrag?,
	onSlotHoverChanged: ((slot: GuiObject, hovered: boolean) -> ())?,
}

const function Inventory(props: Props)
	const width = props.width or 0
	const hotbarSlots = props.slots or 10
	const rows = props.rows or 4
	const height = rows * (props.slotPitch or 65) - 5

	const children: any = {}

	-- Create inventory slots
	if props.items then
		for order, slot in props.items do
			if slot then
				const slotIndex = order + hotbarSlots
				children[tostring(order)] = e(Slot, {
					unlocked = true,
					order = order,
					slotIndex = slotIndex,
					item = slot.item,
					equipped = slot.equipped,
					swapSource = props.swapSourceIndex == slotIndex,
					placeholder = slot.item == props.draggingItem,
					onActivated = props.onSlotActivated,
					onSelectSwap = props.onSelectSwap,
					onDrag = props.onSlotDrag,
					onHoverChanged = props.onSlotHoverChanged,
				})
			end
		end
	end

	return e("Frame", {
		Size = UDim2.fromOffset(width, 0),
		Visible = props.opened,
		[React.Tag] = "Inventory",
	}, {
		SearchFrame = e("Frame", {}, {
			SearchBox = e(Searchbar),
		}),
		SlotFrame = e("ScrollingFrame", {
			Size = UDim2.new(1, 13, 0, height),
		}, children),
	})
end

return Inventory
