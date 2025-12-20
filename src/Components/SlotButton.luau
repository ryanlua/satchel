--!strict

local templateObjects = script.Parent.Parent.Objects

local slotButtonTemplate: TextButton = templateObjects.Slot

local SlotButton = {}
SlotButton.__index = SlotButton

export type ClassType = typeof(setmetatable(
	{} :: {
		_instance: {
			button: TextButton,
		},
	},
	SlotButton
))

function SlotButton.new(): ClassType
	local buttonInstance = slotButtonTemplate:Clone()

	local self = setmetatable({
		activated = buttonInstance.Activated,
		_instance = {
			button = buttonInstance,
		},
	}, SlotButton)

	return self
end

function SlotButton.setParent(self: ClassType, parent: GuiBase2d?)
	self._instance.button.Parent = parent
end

function SlotButton.setText(self: ClassType, text: string)
	local slotTextLabel = self._instance.button

	slotTextLabel.Text = text
end

function SlotButton.setTooltipText(self: ClassType, text: string)
	local tooltipTextLabel = self._instance.button:WaitForChild("ToolTip") :: TextLabel

	tooltipTextLabel.Text = text
end

function SlotButton.setNumber(self: ClassType, number: number)
	local numberTextLabel = self._instance.button:WaitForChild("Number") :: TextLabel

	numberTextLabel.Text = tostring(number)
end

function SlotButton.destroy(self: ClassType)
	self._instance.button:Destroy()
end

return SlotButton
