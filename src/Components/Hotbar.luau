local React = require(script.Parent.Parent.Parent.react)

local HotbarHint = require(script.Parent.HotbarHint)
local Slot = require(script.Parent.Slot)

export type Props = {
	forceHintVisible: boolean?,
	slots: number?,
	unlocked: boolean?,
}

local function Hotbar(props: Props)
	local slotCount = props.slots or 10

	local children = {
		-- Create default hints for equipping between hotbar slots
		SlotLeftHint = React.createElement(HotbarHint, {
			key = Enum.KeyCode.ButtonL1,
			forceVisible = props.forceHintVisible,
			order = -1,
		}),
		SlotRightHint = React.createElement(HotbarHint, {
			key = Enum.KeyCode.ButtonR1,
			forceVisible = props.forceHintVisible,
			order = 100,
		}),
	}

	for slotNumber = 1, slotCount do
		children[slotNumber] = React.createElement(Slot, {
			order = slotNumber,
			forceNumberVisible = props.forceHintVisible,
			unlocked = props.unlocked,
		})
	end

	return React.createElement("Frame", {
		[React.Tag] = "Hotbar",
	}, children)
end

return Hotbar
