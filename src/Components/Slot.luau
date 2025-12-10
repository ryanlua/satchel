--!strict

local React = require("../../react")

local ToolTip = require("./ToolTip")

export type Props = {
	toolName: string?,
	slotNumber: number?,
	toolImage: string?,
	tooltipText: string?,

	equipped: boolean?,
	unlocked: boolean?,
	order: number?,
	onActivated: (() -> ())?,

	children: any?,
}

local function SlotButton(props: Props)
	-- Generate tags based on state
	local tags = "Slot"
	if props.unlocked then
		tags = tags .. " Unlocked"
	end
	if props.equipped then
		tags = tags .. " Equipped"
	end

	-- Hide name if there is an image
	local slotText = props.toolName
	if props.toolImage and props.toolImage ~= "" then
		slotText = ""
	end

	return React.createElement("TextButton", {
		Text = slotText,
		LayoutOrder = props.order,
		[React.Tag] = tags,
		[React.Event.Activated] = props.onActivated,
	}, {
		NumberHint = React.createElement("TextLabel", {
			Text = props.slotNumber or 0,
			[React.Tag] = "SlotNumber",
		}),
		TextureIcon = React.createElement("ImageLabel", {
			Image = props.toolImage or "",
		}),
		ToolTip = React.createElement(ToolTip, {
			text = props.tooltipText,
		}),
	}, props.children)
end

return SlotButton
