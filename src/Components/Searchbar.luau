--!strict

local React = require(script.Parent.Parent.Parent.react)

export type Props = {
	size: UDim2?,
}

local function Searchbar(props: Props)
	local text, setText = React.useState("")

	return React.createElement("TextBox", {
		Size = props.size,
		Text = text,
		[React.Tag] = "Searchbar",
		[React.Change.Text] = function(rbx)
			setText(rbx.Text)
		end,
	}, {
		Clear = React.createElement("ImageButton", {
			Visible = text ~= "",
			[React.Event.Activated] = function()
				setText("")
			end,
		}),
	})
end

return Searchbar
