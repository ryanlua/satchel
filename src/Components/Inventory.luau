const React = require("../../react")

const Searchbar = require("./Searchbar")
const Slot = require("./Slot")
const useSlotMetrics = require("./useSlotMetrics")

const e = React.createElement
const useState = React.useState

export type Props = {
	width: number?,
	height: number?,
	scrollbarGutter: number?,
	slots: number?,
	rows: number?,
	items: { [number]: { item: BackpackItem, equipped: boolean } }?,
	opened: boolean?,
	swapSourceIndex: number?,
	onSlotActivated: ((item: BackpackItem) -> ())?,
	onSelectSwap: ((slotIndex: number) -> ())?,
	onSlotDrag: Slot.OnDrag?,
}

const function Inventory(props: Props)
	const width = props.width or 0
	const hotbarSlots = props.slots or 10
	const rows = props.rows or 4
	const metrics = useSlotMetrics(false)
	const height = props.height or metrics.rowsHeight(rows)
	const scrollbarGutter = props.scrollbarGutter or metrics.scrollbarGutter
	const searchText, setSearchText = useState("")

	const children: any = {}

	-- Create inventory slots
	if props.items then
		const query = string.lower(searchText)
		for order, slot in props.items do
			if slot then
				if query ~= "" then
					const tip = if slot.item:IsA("Tool") then slot.item.ToolTip else ""
					const haystack = string.lower(slot.item.Name .. tip)
					if not string.find(haystack, query, 1, true) then
						continue
					end
				end
				const slotIndex = order + hotbarSlots
				children[tostring(order)] = e(Slot, {
					unlocked = true,
					order = order,
					slotIndex = slotIndex,
					item = slot.item,
					equipped = slot.equipped,
					swapSource = props.swapSourceIndex == slotIndex,
					onActivated = props.onSlotActivated,
					onSelectSwap = props.onSelectSwap,
					onDrag = props.onSlotDrag,
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
			SearchBox = e(Searchbar, {
				onTextChanged = setSearchText,
			}),
		}),
		SlotFrame = e("ScrollingFrame", {
			Size = UDim2.new(1, scrollbarGutter, 0, height),
		}, children),
	})
end

return Inventory
