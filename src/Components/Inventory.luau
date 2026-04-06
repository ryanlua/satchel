--!strict

local React = require(script.Parent.Parent.Parent.react)

local Searchbar = require(script.Parent.Searchbar)
local Slot = require(script.Parent.Slot)

export type Props = {
	width: number?,
	rows: number?,
	tools: { Tool? }?,
	opened: boolean?,
}

local function Inventory(props: Props)
	local width = props.width or 0
	local rows = props.rows or 4
	local height = rows * 65 - 5

	local slotChildren = {}

	if props.tools then
		for order, tool in props.tools do
			if tool then
				slotChildren[order] = React.createElement(Slot, {
					unlocked = true,
					order = order,
					tool = tool,
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
			Size = UDim2.fromOffset(0, height),
		}, slotChildren),
	})
end

return Inventory
