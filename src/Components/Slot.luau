const React = require("../../react")

const Tooltip = require("./Tooltip")

const e = React.createElement

export type OnDrag = (
	phase: "Start" | "Continue" | "End",
	item: BackpackItem,
	detector: UIDragDetector,
	inputPosition: Vector2
) -> ()

export type Props = {
	item: BackpackItem?,
	equipped: boolean?,
	unlocked: boolean?,
	forceHintVisible: boolean?,
	hint: boolean?,
	order: number?,
	-- Absolute backpack index used for gamepad selection and input actions
	slotIndex: number?,
	swapSource: boolean?,
	dragging: boolean?,
	position: (UDim2 | React.Binding<UDim2>)?,
	onActivated: ((item: BackpackItem) -> ())?,
	-- Fired for gamepad select/swap even when the slot is empty
	onSelectSwap: ((slotIndex: number) -> ())?,
	onDrag: OnDrag?,
}

const function Slot(props: Props)
	const item = props.item
	const itemImage = item and item.TextureId
	const tooltipText = item and (item:IsA("Tool") and item.ToolTip or "")
	const draggable = props.onDrag ~= nil and item ~= nil
	const dragged, setDragged = React.useState(false)

	-- Only show numbers 1-10 for hints and show 0 for the 10th slot
	const order = props.order or 1
	const slotIndex = props.slotIndex or order
	const slotNumber = if order >= 1 and order <= 10 then tostring(order % 10) else ""

	const tags = "Slot"
		.. (if props.unlocked then " Unlocked" else "")
		.. (if props.equipped then " Equipped" else "")
		.. (if props.dragging then " Dragging" else "")
		.. (if props.swapSource then " SwapSource" else "")
		.. (if dragged then " Placeholder" else "")

	const function forwardDrag(phase: "Start" | "Continue" | "End")
		return function(detector: UIDragDetector, inputPosition: Vector2)
			if phase ~= "Continue" then
				setDragged(phase == "Start")
			end
			if props.item and props.onDrag then
				props.onDrag(phase, props.item, detector, inputPosition)
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
			if props.onSelectSwap then
				props.onSelectSwap(slotIndex)
				return
			end
			-- Clicks on draggable slots are reported through onDrag instead
			if props.item and props.onActivated and not draggable then
				props.onActivated(props.item)
			end
		end :: any,
	}, {
		NumberHint = e("TextLabel", {
			Text = slotNumber,
			-- Inventory slots are not numbered. Hotbar numbers follow the stylesheet unless forced on.
			Visible = if props.hint then nil else false,
			[React.Tag] = "SlotNumber" .. (if props.forceHintVisible then " Visible" else ""),
		}),
		TextureIcon = e("ImageLabel", {
			Image = itemImage or "",
		}),
		-- Hotbar only, like the CoreGui backpack: inventory slots clip tooltips
		ToolTip = if props.hint
			then e(Tooltip, {
				text = tooltipText,
			})
			else nil,
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
