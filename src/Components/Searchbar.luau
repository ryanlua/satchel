const React = require("../../react")

const e = React.createElement
const useState = React.useState

export type Props = {
	size: UDim2?,
}

const function Searchbar(props: Props)
	const text, setText = useState("")

	return e("TextBox", {
		Size = props.size,
		Text = text,
		[React.Tag] = "Searchbar",
		[React.Change.Text] = function(rbx)
			setText(rbx.Text)
		end :: any,
	}, {
		Clear = e("ImageButton", {
			Visible = text ~= "",
			[React.Event.Activated] = function()
				setText("")
			end,
		}),
	})
end

return Searchbar
