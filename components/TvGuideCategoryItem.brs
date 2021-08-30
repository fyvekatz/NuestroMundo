Sub init()
	? "==Entering TvGuideCategoryItem:init=="
	m.nodeLabel 			= m.top.findNode("nodeLabel")
	? "==Exiting TvGuideCategoryItem:init=="
End Sub

Sub itemContentChanged()
	? "==Entering TvGuideCategoryItem:itemContentChanged=="
	m.nodeLabel.text = m.top.itemContent.Title
	updateLayout()
	? "==Exiting TvGuideCategoryItem:itemContentChanged=="
End Sub

Sub updateLayout()
	? "==Entering TvGuideCategoryItem:updateLayout=="
	'if m.top.height > 0 and m.top.width > 0
	'	m.Poster.width 		= m.top.width
	'	m.Poster.height 	= m.top.height
	'end if
	? "==Exiting TvGuideCategoryItem:updateLayout=="
End Sub