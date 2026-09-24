const React = require("../../react")

const Tooltip = require("./Tooltip")

const e = React.createElement

export type Props = {
	item: BackpackItem?,
	equipped: boolean?,
	unlocked: boolean?,
	forceHintVisible: boolean?,
	hint: boolean?,
	order: number?,
	onActivated: ((item: BackpackItem) -> ())?,
}

const function Slot(props: Props)
	const item = props.item
	const itemName = item and item.Name
	const itemImage = item and item.TextureId
	const tooltipText = item and (item:IsA("Tool") and item.ToolTip or "")

	const equipped = props.equipped or false

	-- Only show numbers 1-10 for hints and show 0 for the 10th slot
	const order = props.order or 1
	local slotNumber = ""
	if order >= 1 and order < 10 then
		slotNumber = tostring(order)
	elseif order == 10 then
		slotNumber = "0"
	end

	const hintVisible = props.hint == true and props.forceHintVisible

	-- Generate tags based on state
	local tags = "Slot"
	if props.unlocked then
		tags = tags .. " Unlocked"
	end
	if equipped then
		tags = tags .. " Equipped"
	end

	-- Hide name if there is an image
	local slotText = itemName
	if itemImage ~= "" then
		slotText = ""
	end

	return e("TextButton", {
		Text = slotText,
		LayoutOrder = props.order,
		[React.Tag] = tags,
		[React.Event.Activated] = function()
			if props.item and props.onActivated then
				props.onActivated(props.item)
			end
		end :: any,
	}, {
		NumberHint = e("TextLabel", {
			Text = slotNumber,
			Visible = hintVisible,
			[React.Tag] = "SlotNumber",
		}),
		TextureIcon = e("ImageLabel", {
			Image = itemImage or "",
		}),
		ToolTip = e(Tooltip, {
			text = tooltipText,
		}),
	})
end

return Slot
