--!strict

local React = require(script.Parent.Parent.Parent.react)

local Searchbar = require(script.Parent.Searchbar)
local Slot = require(script.Parent.Slot)

export type Props = {
	size: UDim2?, -- TODO: change size to use slots amount
	tools: { Tool? }?,
	visible: boolean?,
}

local function Inventory(props: Props)
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
		Visible = props.visible,
		[React.Tag] = "Inventory",
	}, {
		SearchBox = React.createElement(Searchbar),
		SlotFrame = React.createElement("ScrollingFrame", nil, slotChildren),
	})
end

return Inventory
