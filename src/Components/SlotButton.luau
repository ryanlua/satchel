--!strict

local UserInputService = game:GetService("UserInputService")

local templateObjects = script.Parent.Parent.Objects

local slotButtonTemplate: TextButton = templateObjects.Slot

local SlotButton = {}
SlotButton.__index = SlotButton

export type ClassType = typeof(setmetatable(
	{} :: {
		activated: RBXScriptSignal,
		tool: Tool | HopperBin?,
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
		tool = nil :: Tool | HopperBin?,
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

function SlotButton.destroy(self: ClassType)
	self.tool = nil
	self._instance.button:Destroy()

	for _, connection in self._connections do
		connection:Disconnect()
	end
end

function SlotButton.onPreferredInputChanged(self: ClassType)
	local preferredInput = UserInputService.PreferredInput
	local isKeyboardAndMouse = preferredInput == Enum.PreferredInput.KeyboardAndMouse

	self._instance.hint.Visible = isKeyboardAndMouse
end

function SlotButton.setUnlocked(self: ClassType, unlocked: boolean)
	if unlocked then
		self._instance.button:AddTag("Unlocked")
	else
		self._instance.button:RemoveTag("Unlocked")
	end
end

function SlotButton.setEquipped(self: ClassType, equipped: boolean)
	if equipped then
		self._instance.button:AddTag("Equipped")
	else
		self._instance.button:RemoveTag("Equipped")
	end
end

function SlotButton.setTool(self: ClassType, tool: Tool | HopperBin?)
	self.tool = tool

	if tool then
		self:setText(tool.Name)
		self:setIcon(tool.TextureId)
		if tool:IsA("Tool") then
			self:setTooltip(tool.ToolTip)
		end
	else
		self:setText("")
		self:setIcon("")
		self:setTooltip("")
	end
end

function SlotButton.setText(self: ClassType, text: string)
	self._instance.button.Text = text
end

function SlotButton.setIcon(self: ClassType, iconAssetId: string)
	self._instance.icon.Image = iconAssetId
end

function SlotButton.setTooltip(self: ClassType, text: string)
	self._instance.tooltip.Text = text
end

function SlotButton.setHint(self: ClassType, hint: string)
	self._instance.hint.Text = tostring(hint)
end

function SlotButton.setParent(self: ClassType, parent: GuiBase2d?)
	self._instance.button.Parent = parent
end

return SlotButton
