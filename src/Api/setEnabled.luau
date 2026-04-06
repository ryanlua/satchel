--!strict

local RunService = game:GetService("RunService")

local function setEnabled(isEnabled: boolean)
	assert(RunService:IsClient(), "setEnabled can only be called on the client")
end

return setEnabled
