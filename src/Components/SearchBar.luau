local React = require("../../react")

export type Props = {
	size: UDim2?,
	children: any?,
}

local function SearchBar(props: Props)
	return React.createElement("TextBox", {
		Size = props.size,
		[React.Tag] = "SearchBar",
	}, props.children)
end

return SearchBar
