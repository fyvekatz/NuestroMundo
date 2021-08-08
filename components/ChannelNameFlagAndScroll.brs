
sub init()
	? "==Enterring ChannelNameFlagAndScroll init=="

	'Country list loaded in subroutine
    loadCountriesContent(m.global)

	countriesContent = m.global.countriesContent

	centerLabel = m.top.findNode("countryNameLabelCenter")
	leftLabel = m.top.findNode("countryNameLabelLeft")
	rightLabel = m.top.findNode("countryNameLabelRight")

	'Initialize to the beginning of the country list
	if m.country = ""
		centerLabel.text 	= countriesContent.getChild(0).name
		leftLabel.text 		= countriesContent.getChild(countriesContent.getChildCount()-1).name
		rightLabel.text 	= countriesContent.getChild(1).name
	else

		? "All children"
		? countriesContent.getChildren(countriesContent.getChildCount(), 0)

		centerLabel.text 	= countriesContent.getChild(0).name
		leftLabel.text 		= countriesContent.getChild(countriesContent.getChildCount()-1).name
		rightLabel.text 	= countriesContent.getChild(1).name
	end if

	? "==Exitting ChannelNameFlagAndScroll init=="
End sub

sub fadeToCountry()

end sub