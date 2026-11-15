--!strict

const Players = game:GetService("Players")

const Icon = require("./Satchel/Packages/topbarplus")

const player = Players.LocalPlayer
const createdTools: { Tool } = {}
local nextToolNumber = 1

const function getBackpack(): Backpack
	return player:WaitForChild("Backpack") :: Backpack
end

const function createTool(name: string): Tool
	const tool = Instance.new("Tool")
	tool.Name = name
	tool.ToolTip = name
	-- Tools with no Handle are destroyed/unequippable unless this is false
	tool.RequiresHandle = false
	return tool
end

const function addTool()
	const tool = createTool(`Tool {nextToolNumber}`)
	nextToolNumber += 1
	table.insert(createdTools, tool)
	tool.Parent = getBackpack()
end

const function removeTool()
	const tool = table.remove(createdTools)
	if tool and tool.Parent then
		tool:Destroy()
		return
	end

	const backpack = getBackpack()
	const fromBackpack = backpack:FindFirstChildWhichIsA("Tool")
	if fromBackpack then
		fromBackpack:Destroy()
		return
	end

	const character = player.Character
	if character then
		const fromCharacter = character:FindFirstChildWhichIsA("Tool")
		if fromCharacter then
			fromCharacter:Destroy()
		end
	end
end

const icon = Icon.new()
icon:modifyTheme({
	{ "IconLabel", "AutoLocalize", false },
	{ "PaddingLeft", "Size", UDim2.new(0, 4, 1, 0) },
	{ "PaddingRight", "Size", UDim2.new(0, 4, 1, 0) },
	{ "IconLabel", "TextSize", 24 },
})
icon:setLabel("hammer-code")
icon:align("Right")
icon:setTextSize(24)
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
icon:autoDeselect(false)
icon:setCaption("Tools")

const addIcon = Icon.new()
addIcon:setLabel("Add Tool")
addIcon:bindEvent("selected", addTool)
addIcon:oneClick()

const removeIcon = Icon.new()
removeIcon:setLabel("Remove Tool")
removeIcon:bindEvent("selected", removeTool)
removeIcon:oneClick()

icon:setDropdown({ addIcon, removeIcon })
