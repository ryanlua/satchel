--!strict

local UserInputService = game:GetService("UserInputService")

local React = require(script.Parent.Parent.Parent.react)

local Tooltip = require(script.Parent.Tooltip)

export type Props = {
	item: (Tool | HopperBin)?,
	equipped: boolean?,
	unlocked: boolean?,
	forceHintVisible: boolean?,
	hint: boolean?,
	order: number?,
}

local function Slot(props: Props)
	local item = props.item
	local itemName = item and item.Name
	local itemImage = item and item.TextureId
	local tooltipText = item and (item:IsA("Tool") and item.ToolTip or "")

	local equipped, setEquipped = React.useState(props.equipped or false)

	-- Only show numbers 1-10 for hints and show 0 for the 10th slot
	local order = props.order or 1
	local slotNumber = ""
	if order >= 1 and order < 10 then
		slotNumber = tostring(order)
	elseif order == 10 then
		slotNumber = "0"
	end

	-- Only show slot number if keyboard and mouse is preferred or forced visible
	local isKeyboardPreferred, setIsKeyboardPreferred =
		React.useState(UserInputService.PreferredInput == Enum.PreferredInput.KeyboardAndMouse)

	React.useEffect(function()
		local function preferredInputChanged()
			local preferredInput = UserInputService.PreferredInput

			if preferredInput == Enum.PreferredInput.KeyboardAndMouse then
				setIsKeyboardPreferred(true)
			else
				setIsKeyboardPreferred(false)
			end
		end

		-- preferredInputChanged()
		local signal = UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(preferredInputChanged)

		return function()
			signal:Disconnect()
		end
	end, {})

	local hintVisible = props.hint == true and (props.forceHintVisible or isKeyboardPreferred)

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
