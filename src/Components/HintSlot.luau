--!strict

local React = require("../../react")

export type Props = {
	hintImage: string,

	children: any?,
}

local function HintSlotImageLabel(props: Props)
	return React.createElement("ImageLabel", {
		Image = props.hintImage,
		[React.Tag] = "HintSlot",
	}, props.children)
end

return HintSlotImageLabel
