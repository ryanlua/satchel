--!strict

local RunService = game:GetService("RunService")

local bindableEvents = script.Parent.Parent.BindableEvents

local function setEnabled(isEnabled: boolean)
	assert(RunService:IsClient(), "setEnabled can only be called on the client")

	if isEnabled then
		bindableEvents.InventoryOpened:Fire()
	else
		bindableEvents.InventoryClosed:Fire()
	end
end

return setEnabled
