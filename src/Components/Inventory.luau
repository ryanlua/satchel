const React = require("../../react")

const Searchbar = require("./Searchbar")
const Slot = require("./Slot")

const e = React.createElement

export type Props = {
	width: number?,
	rows: number?,
	items: { [number]: { item: BackpackItem, equipped: boolean } }?,
	opened: boolean?,
	onSlotActivated: ((item: BackpackItem) -> ())?,
}

const function Inventory(props: Props)
	const width = props.width or 0
	const rows = props.rows or 4
	const height = rows * 65 - 5

	const children: any = {}

	-- Create inventory slots
	if props.items then
		for order, slot in props.items do
			if slot then
				children[tostring(order)] = e(Slot, {
					unlocked = true,
					order = order,
					item = slot.item,
					equipped = slot.equipped,
					onActivated = props.onSlotActivated,
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
