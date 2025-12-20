local UserInputService = game:GetService("UserInputService")

local React = require("../../react")

local ToolTip = require("./ToolTip")

export type Props = {
	tool: Tool?,
	slotNumber: number?,
	equipped: boolean?,
	forceVisible: boolean?,
	unlocked: boolean?,
	order: number?,
	onActivated: (() -> ())?,
	children: any?,
}

local function Slot(props: Props)
	local toolName = props.tool and props.tool.Name
	local toolImage = props.tool and props.tool.TextureId
	local tooltipText = props.tool and props.tool.ToolTip

	-- Only show hint if keyboard and mouse is preferred or forced visible
	local isKeyboardAndMousePreferred, setIsKeyboardAndMousePreferred =
		React.useState(UserInputService.PreferredInput == Enum.PreferredInput.KeyboardAndMouse)

	React.useEffect(function()
		local function preferredInputChanged()
			local preferredInput = UserInputService.PreferredInput

			if preferredInput == Enum.PreferredInput.KeyboardAndMouse then
				setIsKeyboardAndMousePreferred(true)
			else
				setIsKeyboardAndMousePreferred(false)
			end
		end

		preferredInputChanged()
		local signal: RBXScriptConnection = UserInputService:GetPropertyChangedSignal("PreferredInput")
			:Connect(preferredInputChanged)

		return function()
			signal:Disconnect()
		end
	end, {})

	local visible = props.forceVisible == true or isKeyboardAndMousePreferred

	-- Generate tags based on state
	local tags = "Slot"
	if props.unlocked then
		tags = tags .. " Unlocked"
	end
	if props.equipped then
		tags = tags .. " Equipped"
	end

	-- Hide name if there is an image
	local slotText = toolName
	if toolImage ~= "" then
		slotText = ""
	end

	return React.createElement("TextButton", {
		Text = slotText,
		LayoutOrder = props.order,
		Visible = visible,
		[React.Tag] = tags,
		[React.Event.Activated] = props.onActivated,
	}, {
		NumberHint = React.createElement("TextLabel", {
			Text = props.slotNumber or 0,
			[React.Tag] = "SlotNumber",
		}),
		TextureIcon = React.createElement("ImageLabel", {
			Image = toolImage or "",
		}),
		ToolTip = React.createElement(ToolTip, {
			text = tooltipText,
		}),
	}, props.children)
end

return Slot
