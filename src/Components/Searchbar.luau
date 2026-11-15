const React = require("../../react")

const e = React.createElement
const useState = React.useState

export type Props = {
	size: UDim2?,
	onTextChanged: ((text: string) -> ())?,
}

const function Searchbar(props: Props)
	const text, setText = useState("")

	const function updateText(newText: string)
		setText(newText)
		if props.onTextChanged then
			props.onTextChanged(newText)
		end
	end

	return e("TextBox", {
		Size = props.size,
		Text = text,
		[React.Tag] = "Searchbar",
		[React.Change.Text] = function(rbx)
			updateText(rbx.Text)
		end :: any,
	}, {
		Clear = e("ImageButton", {
			Visible = text ~= "",
			[React.Event.Activated] = function()
				updateText("")
			end,
		}),
	})
end

return Searchbar
