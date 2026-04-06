--!strict

local React = require(script.Parent.Parent.Parent.react)

local Hotbar = require(script.Parent.Hotbar)
local Inventory = require(script.Parent.Inventory)

export type Props = {
	forceGamepadHintVisible: boolean?,
	forceKeyboardHintVisible: boolean?,
	slots: number?,
	tools: { Tool? }?,
	opened: boolean?,
}

local function Backpack(props: Props)
	local opened = props.opened or false

	-- Negative index for inventory and positive index for hotbar
	local hotbarTools: { [number]: Tool? } = {}
	local inventoryTools: { [number]: Tool? } = {}
	if props.tools then
		for index, tool in props.tools do
			if tool and index > 0 then
				hotbarTools[index] = tool
			elseif tool and index < 0 then
				inventoryTools[math.abs(index)] = tool
			end
		end
	end

	return React.createElement("Frame", {
		[React.Tag] = "Backpack",
	}, {
		Hotbar = React.createElement(Hotbar, {
			forceGamepadHintVisible = props.forceGamepadHintVisible,
			forceKeyboardHintVisible = props.forceKeyboardHintVisible,
			slots = props.slots,
			tools = hotbarTools,
			opened = props.opened,
		}),
		Inventory = React.createElement(Inventory, {
			forceHintVisible = props.forceGamepadHintVisible,
			slots = props.slots,
			tools = inventoryTools,
			visible = opened,
		}),
	})
end

return Backpack
