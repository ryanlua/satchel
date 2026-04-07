--!strict

local React = require(script.Parent.Parent.Parent.react)

local Hotbar = require(script.Parent.Hotbar)
local Inventory = require(script.Parent.Inventory)

export type Props = {
	forceKeyboardHintVisible: boolean?,
	slots: number?,
	rows: number?, -- TODO: Add rows for inventory height
	tools: { Tool? }?,
	opened: boolean?,
	onAbsoluteSizeChanged: ((Vector2) -> ())?,
}

local function Backpack(props: Props)
	local opened = props.opened or false
	local slots = props.slots or 10

	-- Tools at indices 1..slots are hotbar; tools above slots are inventory.
	local hotbarTools: { [number]: Tool? } = {}
	local inventoryTools: { [number]: Tool? } = {}
	if props.tools then
		for index, tool in props.tools do
			if tool and index > 0 and index <= slots then
				hotbarTools[index] = tool
			elseif tool and index > slots then
				inventoryTools[index - slots] = tool
			end
		end
	end

	return React.createElement("Frame", {
		[React.Tag] = "Backpack",
		[React.Change.AbsoluteSize] = function(rbx)
			if props.onAbsoluteSizeChanged then
				props.onAbsoluteSizeChanged(rbx.AbsoluteSize)
			end
		end,
	}, {
		Hotbar = React.createElement(Hotbar, {
			forceKeyboardHintVisible = props.forceKeyboardHintVisible,
			slots = slots,
			tools = hotbarTools,
			opened = opened,
		}),
		Inventory = React.createElement(Inventory, {
			slots = slots,
			rows = props.rows,
			tools = inventoryTools,
			opened = opened,
		}),
	})
end

return Backpack
