
const React = require("../../react")

export type Props = {
	size: UDim2?,
}

const function Searchbar(props: Props)
	const text, setText = React.useState("")

	return React.createElement("TextBox", {
		Size = props.size,
		Text = text,
		[React.Tag] = "Searchbar",
		[React.Change.Text] = function(rbx)
			setText(rbx.Text)
		end :: any,
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
