--!strict

local React = require(script.Parent.Parent.Parent.react)

export type Props = {
	size: UDim2?,
}

local function Searchbar(props: Props)
	return React.createElement("TextBox", {
		Size = props.size,
		[React.Tag] = "Searchbar",
	}, {
		Clear = React.createElement("ImageButton"),
	})
end

return Searchbar
