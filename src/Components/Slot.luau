const React = require("../../react")

const Tooltip = require("./Tooltip")

const e = React.createElement

export type OnDrag = (
	phase: "Start" | "Continue" | "End",
	item: BackpackItem,
	slot: GuiObject,
	inputPosition: Vector2
) -> ()

export type Props = {
	item: BackpackItem?,
	equipped: boolean?,
	unlocked: boolean?,
	forceHintVisible: boolean?,
	hint: boolean?,
	order: number?,
	placeholder: boolean?,
	dragging: boolean?,
	position: UDim2?,
	onActivated: ((item: BackpackItem) -> ())?,
	onDrag: OnDrag?,
}

const function Slot(props: Props)
	const item = props.item
	const itemImage = item and item.TextureId
	const tooltipText = item and (item:IsA("Tool") and item.ToolTip or "")
	const draggable = props.onDrag ~= nil and item ~= nil

	-- Only show numbers 1-10 for hints and show 0 for the 10th slot
	const order = props.order or 1
	const slotNumber = if order >= 1 and order <= 10 then tostring(order % 10) else ""

	const hintVisible = props.hint == true and props.forceHintVisible

	const tags = "Slot"
		.. (if props.unlocked then " Unlocked" else "")
		.. (if props.equipped then " Equipped" else "")
		.. (if props.dragging then " Dragging" else "")
		.. (if props.placeholder then " Placeholder" else "")

	const function forwardDrag(phase: "Start" | "Continue" | "End")
		return function(detector: UIDragDetector, inputPosition: Vector2)
			if props.item and props.onDrag then
				props.onDrag(phase, props.item, detector.Parent :: GuiObject, inputPosition)
			end
		end :: any
	end

	return e("TextButton", {
		-- Hide name if there is an image
		Text = if itemImage ~= "" then "" else item and item.Name,
		LayoutOrder = props.order,
		Position = props.position,
		Interactable = not props.dragging,
		[React.Tag] = tags,
		[React.Event.Activated] = function()
			-- Clicks on draggable slots are reported through onDrag instead
			if props.item and props.onActivated and not draggable then
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
		EquipStroke = e("UIStroke", {
			[React.Tag] = "EquipStroke",
		}),
		PressStroke = e("UIStroke", {
			[React.Tag] = "PressStroke",
		}),
		DragDetector = if props.dragging
			then nil
			else e("UIDragDetector", {
				Enabled = draggable,
				ResponseStyle = Enum.UIDragDetectorResponseStyle.CustomOffset,
				[React.Event.DragStart] = forwardDrag("Start"),
				[React.Event.DragContinue] = forwardDrag("Continue"),
				[React.Event.DragEnd] = forwardDrag("End"),
			}),
	})
end

return Slot
