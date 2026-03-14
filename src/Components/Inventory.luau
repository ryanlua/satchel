--!strict

local React = require(script.Parent.Parent.Parent.react)

local Searchbar = require(script.Parent.Searchbar)

export type Props = {
	forceHintVisible: boolean?,
	size: UDim2?, -- TODO: change size to use slots amount
	tools: { Tool? }?,
}

local function Inventory(props: Props)
	return React.createElement("Frame", {
		Size = props.size,
		[React.Tag] = "Inventory",
	}, {
		SearchBox = React.createElement(Searchbar),
		SlotFrame = React.createElement("ScrollingFrame"),
	})
end

return Inventory
