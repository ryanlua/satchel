--!strict

local UserInputService = game:GetService("UserInputService")

local templateObjects = script.Parent.Parent.Objects

local slotButtonTemplate: TextButton = templateObjects.Slot

local SlotButton = {}
SlotButton.__index = SlotButton

export type ClassType = typeof(setmetatable(
	{} :: {
		_instance: {
			button: TextButton,
			hint: TextLabel,
			icon: ImageLabel,
			tooltip: TextLabel,
		},
		_connections: { RBXScriptConnection },
	},
	SlotButton
))

function SlotButton.new(): ClassType
	local buttonInstance = slotButtonTemplate:Clone()
	local hintText = buttonInstance:WaitForChild("NumberHint") :: TextLabel
	local iconImage = buttonInstance:WaitForChild("TextureIcon") :: ImageLabel
	local tooltipText = buttonInstance:WaitForChild("ToolTip") :: TextLabel

	local self = setmetatable({
		activated = buttonInstance.Activated,
		_instance = {
			button = buttonInstance,
			hint = hintText,
			icon = iconImage,
			tooltip = tooltipText,
		},
		_connections = {},
	}, SlotButton)

	local preferredInputChangedConnection = UserInputService:GetPropertyChangedSignal("PreferredInput")
		:Connect(function()
			self:onPreferredInputChanged()
		end)
	table.insert(self._connections, preferredInputChangedConnection)

	return self
end

function SlotButton.onPreferredInputChanged(self: ClassType)
	local preferredInput = UserInputService.PreferredInput
	local isKeyboardAndMouse = preferredInput == Enum.PreferredInput.KeyboardAndMouse

	self._instance.hint.Visible = isKeyboardAndMouse
end

function SlotButton.setParent(self: ClassType, parent: GuiBase2d?)
	self._instance.button.Parent = parent
end

function SlotButton.setText(self: ClassType, text: string)
	self._instance.button.Text = text
end

function SlotButton.setTooltipText(self: ClassType, text: string)
	self._instance.tooltip.Text = text
end

function SlotButton.setNumber(self: ClassType, number: number)
	self._instance.hint.Text = tostring(number)
end

function SlotButton.destroy(self: ClassType)
	self._instance.button:Destroy()

	for _, connection in self._connections do
		connection:Disconnect()
	end
end

return SlotButton
