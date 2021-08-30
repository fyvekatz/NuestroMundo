Sub init()
	? "==Entering RowListItems:init=="
	m.Poster 			= m.top.findNode("poster")
	? "==Exiting RowListItems:init=="
End Sub

Sub itemContentChanged()
	? "==Entering RowListItems:itemContentChanged=="

	m.Poster.uri = m.top.itemContent.HDPosterUrl
	updateLayout()
	? "==Exiting RowListItems:itemContentChanged=="
End Sub

Sub updateLayout()
	? "==Entering RowListItems:updateLayout=="
	if m.top.height > 0 and m.top.width > 0
		m.Poster.width 		= m.top.width
		m.Poster.height 	= m.top.height
	end if
	? "==Exiting RowListItems:updateLayout=="
End Sub