
const React = require("../../react")

const Tooltip = require("./Tooltip")

export type Props = {
	item: (Tool | HopperBin)?,
	equipped: boolean?,
	unlocked: boolean?,
	forceHintVisible: boolean?,
	hint: boolean?,
	order: number?,
}

const function Slot(props: Props)
	const item = props.item
	const itemName = item and item.Name
	const itemImage = item and item.TextureId
	const tooltipText = item and (item:IsA("Tool") and item.ToolTip or "")

	local equipped, setEquipped = React.useState(props.equipped or false)

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

	return React.createElement("TextButton", {
		Text = slotText,
		LayoutOrder = props.order,
		[React.Tag] = tags,
		[React.Event.Activated] = function()
			if props.item then
				setEquipped(not equipped)
			end
		end :: any,
	}, {
		NumberHint = React.createElement("TextLabel", {
			Text = slotNumber,
			Visible = hintVisible,
			[React.Tag] = "SlotNumber",
		}),
		TextureIcon = React.createElement("ImageLabel", {
			Image = itemImage or "",
		}),
		ToolTip = React.createElement(Tooltip, {
			text = tooltipText,
		}),
	})
end

return Slot
