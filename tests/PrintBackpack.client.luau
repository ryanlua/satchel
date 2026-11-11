--!strict

const Satchel = require("./Satchel")

Satchel.backpackItemAdded:Connect(function(item)
	print("Added to backpack:", item.Name)
end)

Satchel.backpackItemEquipped:Connect(function(item)
	print("Equipped from backpack:", item.Name)
end)

Satchel.backpackItemUnequipped:Connect(function(item)
	print("Unequipped to backpack:", item.Name)
end)

Satchel.backpackItemRemoved:Connect(function(item)
	print("Removed from backpack:", item.Name)
end)
