Sub init()
	? "==Entering RowListItems:init=="
	m.Poster 			= m.top.findNode("poster")
	m.Label 			= m.top.findNode("label")
	m.Label.visible = false
	? "==Exiting RowListItems:init=="
End Sub

Sub itemContentChanged()
	? "==Entering RowListItems:itemContentChanged=="

	'? "Item Content"
	'? m.top.itemContent

	m.Poster.uri = m.top.itemContent.HDPosterUrl
	m.Label.text = m.top.itemContent.title
	updateLayout()
	? "==Exiting RowListItems:itemContentChanged=="
End Sub

Sub updateLayout()
	? "==Entering RowListItems:updateLayout=="
	if m.top.height > 0 and m.top.width > 0
		m.Poster.width 		= m.top.width
		m.Poster.height 	= m.top.height
		m.Label.translation = [0, m.Poster.height + 30]
		m.Label.width 		= m.Poster.width
	end if
	? "==Exiting RowListItems:updateLayout=="
End Sub