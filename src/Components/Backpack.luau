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
		[React.Change.AbsoluteSize] = function(rbx)
			if props.onAbsoluteSizeChanged then
				props.onAbsoluteSizeChanged(rbx.AbsoluteSize)
			end
		end,
	}, {
		Hotbar = React.createElement(Hotbar, {
			forceKeyboardHintVisible = props.forceKeyboardHintVisible,
			slots = props.slots,
			tools = hotbarTools,
			opened = opened,
		}),
		Inventory = React.createElement(Inventory, {
			slots = props.slots,
			rows = props.rows,
			tools = inventoryTools,
			opened = opened,
		}),
	})
end

return Backpack
