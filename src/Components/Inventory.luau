
const React = require("../../react")

const Searchbar = require("./Searchbar")
const Slot = require("./Slot")

export type Props = {
	width: number?,
	rows: number?,
	items: { Tool | HopperBin }?,
	opened: boolean?,
}

const function Inventory(props: Props)
	const width = props.width or 0
	const rows = props.rows or 4
	const height = rows * 65 - 5

	const children: any = {}

	-- Create inventory slots
	if props.items then
		for order, item in props.items do
			if item then
				children[tostring(order)] = React.createElement(Slot, {
					unlocked = true,
					order = order,
					item = item,
				})
			end
		end
	end

	return React.createElement("Frame", {
		Size = UDim2.fromOffset(width, 0),
		Visible = props.opened,
		[React.Tag] = "Inventory",
	}, {
		SearchBox = React.createElement(Searchbar),
		SlotFrame = React.createElement("ScrollingFrame", {
			Size = UDim2.new(1, 0, 0, height),
		}, children),
	})
end

return Inventory
