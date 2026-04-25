--!strict

const StarterGui = game:GetService("StarterGui")

const Satchel = require("./")

task.spawn(function()
	while task.wait(1) do
		if StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Backpack) and Satchel.getEnabled() then
			warn("[Satchel] CoreGui backpack detected. Disabling Satchel to prevent conflicts.")
			Satchel.setEnabled(false)
			break
		end
	end
end)
