Sub init()
	? "==Entering TvGuideCategoryItem:init=="
	m.nodeLabel 			= m.top.findNode("nodeLabel")
	m.nodeIcon				= m.top.findNode("nodeIcon")
	? "==Exiting TvGuideCategoryItem:init=="
End Sub

Sub itemContentChanged()
	? "==Entering TvGuideCategoryItem:itemContentChanged=="
	m.nodeLabel.text = m.top.itemContent.TITLE
	m.nodeIcon.uri   = m.top.itemContent.HDGRIDPOSTERURL
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