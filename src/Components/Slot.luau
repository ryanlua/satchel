--!strict

local UserInputService = game:GetService("UserInputService")

local React = require(script.Parent.Parent.Parent.react)

local Tooltip = require(script.Parent.Tooltip)

export type Props = {
	tool: Tool?,
	slotNumber: number?,
	equipped: boolean?,
	forceHintVisible: boolean?,
	unlocked: boolean?,
	order: number?,
	onActivated: (() -> ())?,
}

local function Slot(props: Props)
	local tool = props.tool
	local toolName = tool and tool.Name
	local toolImage = tool and tool.TextureId
	local tooltipText = tool and tool.ToolTip

	-- Only show slot number if keyboard and mouse is preferred or forced visible
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

	local hintVisible = props.forceHintVisible or isKeyboardAndMousePreferred

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
		[React.Tag] = tags,
		[React.Event.Activated] = props.onActivated,
	}, {
		NumberHint = React.createElement("TextLabel", {
			Text = props.slotNumber or 0,
			Visible = hintVisible,
			[React.Tag] = "SlotNumber",
		}),
		TextureIcon = React.createElement("ImageLabel", {
			Image = toolImage or "",
		}),
		ToolTip = React.createElement(Tooltip, {
			text = tooltipText,
		}),
	})
end

return Slot
