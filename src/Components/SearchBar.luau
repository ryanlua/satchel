--!strict

local React = require("../../react")

export type Props = {
	size: UDim2?,

	children: any?,
}

local function SearchBarTextBox(props: Props)
	return React.createElement("TextBox", {
		Size = props.size,
		[React.Tag] = "SearchBar",
	}, props.children)
end

return SearchBarTextBox
