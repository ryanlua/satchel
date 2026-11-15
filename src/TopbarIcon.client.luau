--!strict

const Icon = require("../topbarplus")
const Satchel = require("./")

const icon = Icon.new()
icon:setName("SatchelInventory")
icon:modifyTheme({
	{ "IconLabel", "AutoLocalize", false },
	{ "PaddingLeft", "Size", UDim2.new(0, 4, 1, 0) },
	{ "PaddingRight", "Size", UDim2.new(0, 4, 1, 0) },
	{ "IconLabel", "TextSize", 24 },
})
icon:setLabel("backpack")
icon:setOrder(-1)
icon:setTextFont(
	"rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json",
	Enum.FontWeight.Bold,
	Enum.FontStyle.Normal,
	"Selected"
)
icon:setTextFont(
	"rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json",
	Enum.FontWeight.Regular,
	Enum.FontStyle.Normal,
	"Deselected"
)
-- Inventory toggle key is owned by HotbarContext.ToggleInventoryAction (Input Action System)
icon:autoDeselect(false)
icon:setCaption("Inventory")

icon.toggled:Connect(function(isSelected, fromSource)
	if fromSource == "User" then
		if isSelected then
			Satchel.openInventory()
		else
			Satchel.closeInventory()
		end
	end
end)

Satchel.inventoryOpened:Connect(function()
	icon:select()
end)

Satchel.inventoryClosed:Connect(function()
	icon:deselect()
end)
