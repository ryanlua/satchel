--!strict

local React = require(script.Parent.Parent.Parent.react)

local Slot = require(script.Parent.Slot)

export type Props = {
	forceKeyboardHintVisible: boolean?,
	slots: number?,
	tools: { Tool? }?,
	opened: boolean?,
}

local function Hotbar(props: Props)
	local slotCount = props.slots or 10

	local children = {}

	for slotNumber = 1, slotCount do
		local tool = props.tools and props.tools[slotNumber]
		local slotUnlocked = props.opened and tool ~= nil

		-- Only show slots if the hotbar is opened or if there is a tool in the slot
		if props.opened or tool then
			children[slotNumber] = React.createElement(Slot, {
				order = slotNumber,
				tool = tool,
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
