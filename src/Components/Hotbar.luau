
const React = require("../../react")

const Slot = require("./Slot")

export type Props = {
	forceKeyboardHintVisible: boolean?,
	slots: number?,
	items: { Tool | HopperBin }?,
	opened: boolean?,
}

const function Hotbar(props: Props)
	const slotCount = props.slots or 10

	const children: any = {}

	-- Create hotbar slots
	for order = 1, slotCount do
		const item = props.items and props.items[order]
		const slotUnlocked = props.opened and item ~= nil

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
