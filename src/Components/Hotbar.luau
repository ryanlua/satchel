local React = require(script.Parent.Parent.Parent.react)

local HotbarHint = require(script.Parent.HotbarHint)
local Slot = require(script.Parent.Slot)

export type Props = {
	forceGamepadHintVisible: boolean?,
	forceKeyboardHintVisible: boolean?,
	slots: number?,
	tools: { Tool? }?,
	unlocked: boolean?,
	opened: boolean?,
}

local function Hotbar(props: Props)
	local slotCount = props.slots or 10

	local children = {}

	for slotNumber = 1, slotCount do
		local tool = props.tools and props.tools[slotNumber]
		local slotUnlocked = props.unlocked and tool ~= nil

		-- Only show slots if the hotbar is opened or if there is a tool in the slot
		if props.opened or tool then
			children[slotNumber] = React.createElement(Slot, {
				order = slotNumber,
				tool = tool,
				forceNumberVisible = props.forceKeyboardHintVisible,
				unlocked = slotUnlocked,
			})
		end
	end

	if next(children) then
		-- Create default hints for equipping between hotbar slots
		children.SlotLeftHint = React.createElement(HotbarHint, {
			keyCode = Enum.KeyCode.ButtonL1,
			forceVisible = props.forceGamepadHintVisible,
			order = -1,
		})
		children.SlotRightHint = React.createElement(HotbarHint, {
			keyCode = Enum.KeyCode.ButtonR1,
			forceVisible = props.forceGamepadHintVisible,
			order = 100,
		})
	end

	return React.createElement("Frame", {
		[React.Tag] = "Hotbar",
	}, children)
end

return Hotbar
