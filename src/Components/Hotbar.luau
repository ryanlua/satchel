const React = require("../../react")

const Slot = require("./Slot")

const e = React.createElement

export type Props = {
	forceKeyboardHintVisible: boolean?,
	slots: number?,
	items: { [number]: { item: BackpackItem, equipped: boolean } }?,
	opened: boolean?,
	draggingItem: BackpackItem?,
	onSlotActivated: ((item: BackpackItem) -> ())?,
	onSlotDrag: Slot.OnDrag?,
	onSlotHoverChanged: ((slot: GuiObject, hovered: boolean) -> ())?,
}

const function Hotbar(props: Props)
	const slotCount = props.slots or 10

	const children: any = {}

	-- Create hotbar slots
	for order = 1, slotCount do
		const slot = props.items and props.items[order]
		const item = slot and slot.item
		const slotUnlocked = props.opened and item ~= nil

		-- Only show slots if the hotbar is opened or if there is a tool in the slot
		if props.opened or item then
			children[tostring(order)] = e(Slot, {
				order = order,
				item = item,
				hint = true,
				forceHintVisible = props.forceKeyboardHintVisible,
				unlocked = slotUnlocked,
				equipped = slot and slot.equipped,
				placeholder = item ~= nil and item == props.draggingItem,
				onActivated = props.onSlotActivated,
				onDrag = if slotUnlocked then props.onSlotDrag else nil,
				onHoverChanged = props.onSlotHoverChanged,
			})
		end
	end

	return e("Frame", {
		[React.Tag] = "Hotbar",
	}, children)
end

return Hotbar
