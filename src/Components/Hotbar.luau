--!strict

local React = require(script.Parent.Parent.Parent.react)

local Slot = require(script.Parent.Slot)

export type Props = {
	forceKeyboardHintVisible: boolean?,
	slots: number?,
	items: { Tool | HopperBin }?,
	opened: boolean?,
}

local function Hotbar(props: Props)
	local slotCount = props.slots or 10

	local children: any = {}

	-- Create hotbar slots
	for order = 1, slotCount do
		local item = props.items and props.items[order]
		local slotUnlocked = props.opened and item ~= nil

		-- Only show slots if the hotbar is opened or if there is a tool in the slot
		if props.opened or item then
			children[tostring(order)] = React.createElement(Slot, {
				order = order,
				item = item,
				hint = true,
				forceHintVisible = props.forceKeyboardHintVisible,
				unlocked = slotUnlocked,
			})
		end
	end

	return React.createElement("Frame", {
		[React.Tag] = "Hotbar",
	}, children)
end

return Hotbar
