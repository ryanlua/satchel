const React = require("../../react")

const Hotbar = require("./Hotbar")
const Inventory = require("./Inventory")

export type Props = {
	forceKeyboardHintVisible: boolean?,
	slots: number?,
	rows: number?, -- TODO: Add rows for inventory height
	items: { Tool | HopperBin }?,
	opened: boolean?,
	onAbsoluteSizeChanged: ((Vector2) -> ())?,
}

const function Backpack(props: Props)
	const opened = props.opened or false
	const slots = props.slots or 10

	-- Items at indices 1..slots are hotbar; items above slots are inventory.
	const hotbarItems: { [number]: Tool | HopperBin } = {}
	const inventoryItems: { [number]: Tool | HopperBin } = {}
	if props.items then
		for index, item in props.items do
			if item and index > 0 and index <= slots then
				hotbarItems[index] = item
			elseif item and index > slots then
				inventoryItems[index - slots] = item
			end
		end
	end

	return React.createElement("Frame", {
		[React.Tag] = "Backpack",
		[React.Change.AbsoluteSize] = function(rbx)
			if props.onAbsoluteSizeChanged then
				props.onAbsoluteSizeChanged(rbx.AbsoluteSize)
			end
		end :: any,
	}, {
		Hotbar = React.createElement(Hotbar, {
			forceKeyboardHintVisible = props.forceKeyboardHintVisible,
			slots = slots,
			items = hotbarItems,
			opened = opened,
		}),
		Inventory = React.createElement(Inventory, {
			slots = slots,
			rows = props.rows,
			items = inventoryItems,
			opened = opened,
		}),
	})
end

return Backpack
