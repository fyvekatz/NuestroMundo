
sub init()
	? "==Entering ChannelNameFlagAndScroll:init=="

	'Country list loaded in subroutine
    loadCountriesContent(m.global)

	m.centerLabel 	= m.top.findNode("countryNameLabelCenter")
	m.leftLabel 	= m.top.findNode("countryNameLabelLeft")
	m.rightLabel 	= m.top.findNode("countryNameLabelRight")

	m.centerPoster 	= m.top.findNode("countryFlagPosterCenter")
	m.leftPoster 	= m.top.findNode("countryFlagPosterLeft")
	m.rightPoster 	= m.top.findNode("countryFlagPosterRight")

	'Maintain during any scroll decision a concept of a "previous index"
	m.currentIndex	= 0

	'Initialize country if not already set
	if m.top.country = invalid or m.top.country= ""
		m.top.country = m.global.countriesContent.countries.keys()[0]
		? "Setting centerLabel to the start of the country list."
		m.centerLabel.text 	= m.global.countriesContent.countries.keys()[0]
		m.leftLabel.text 	= m.global.countriesContent.countries.keys()[m.global.countriesContent.countries.count()-1]
		m.rightLabel.text 	= m.global.countriesContent.countries.keys()[1]

		m.centerPoster.uri 	= "pkg:/images/flag_" + m.global.countriesContent.countries[m.global.countriesContent.countries.keys()[0]].shortCode + ".jpeg"
		m.leftPoster.uri 	= "pkg:/images/flag_" + m.global.countriesContent.countries[m.global.countriesContent.countries.keys()[m.global.countriesContent.countries.count()-1]].shortCode + ".jpeg"
		m.rightPoster.uri 	= "pkg:/images/flag_" + m.global.countriesContent.countries[m.global.countriesContent.countries.keys()[1]].shortCode + ".jpeg"
	end if

	'updateToCountry()

	? "==Exitting ChannelNameFlagAndScroll:init=="
End sub

sub updateToCountry()

	? "==Entering ChannelNameFlagAndScroll:updateToCountry=="
	
	? "Initial current index: " + Str(m.currentIndex)

	'Identify index of current country
	targetIndex = getCountryIndex(m.top.country)

	? "Target country is " + m.top.country
	? "Target index is " + Str(targetIndex)

	'Is it faster to get there by scrolling "left" or "right"?
	
	'If targetIndex > currentIndex
	if targetIndex > m.currentIndex

		? "New index is greater than previous index (" + Str(targetIndex) + ">" + Str(m.currentIndex) + ")."
		forwardDistance = targetIndex - m.currentIndex
		backDistance	= m.currentIndex + (m.global.countriesContent.countries.count() - targetIndex)

		? "Forward distance: " + Str(forwardDistance)
		? "Back distance:" + Str(backDistance)

	'Else newIndex < currentIndex
	else

		? "New index is less than current index (" + Str(targetIndex) + "<" + Str(m.currentIndex) + ")."
		forwardDistance = (m.global.countriesContent.countries.count() - m.currentIndex) + targetIndex
		backDistance = m.currentIndex - targetIndex

		? "Forward distance: " + Str(forwardDistance)
		? "Back distance:" + Str(backDistance)
	end if

	'Note previous index prior to animating
	m.previousIndex = m.currentIndex
	
	'Whichever's smaller, scroll that way.
	if forwardDistance < backDistance

		? "Scrolling left..."
		while m.currentIndex <> targetIndex
			scrollLeft()
		end while
		? "Scroll complete."
	else
		? "Scrolling right..."
		while m.currentIndex <> targetIndex
			scrollRight()
		end while
		? "Scroll complete."
	end if

	? "Final current index: " + Str(m.currentIndex)

	? "==Exitting ChannelNameFlagAndScroll:updateToCountry=="
end sub

sub scrollLeft()
	? "==Entering ChannelNameFlagAndScroll:scrollLeft=="

	rightIndex = incrementCountryIndex(m.currentIndex)

	'Set the new labels
	
	m.centerLabel.visible 	= true
	m.leftLabel.visible		= false
	m.rightLabel.visible	= true
	
	m.centerLabel.text = m.global.countriesContent.countries.keys()[m.currentIndex]
	m.rightLabel.text  = m.global.countriesContent.countries.keys()[rightIndex]

	m.centerPoster.visible 	= true
	m.leftPoster.visible	= false
	m.rightPoster.visible	= true

	m.centerPoster.uri 	= "pkg:/images/flag_" + m.global.countriesContent.countries[m.global.countriesContent.countries.keys()[m.currentIndex]].shortCode + ".jpeg"
	m.rightPoster.uri 	= "pkg:/images/flag_" + m.global.countriesContent.countries[m.global.countriesContent.countries.keys()[rightIndex]].shortCode + ".jpeg"

	m.top.findNode("scrollLeftAnimation").control = "start"

	m.currentIndex = rightIndex
	? "==Exiting ChannelNameFlagAndScroll:scrollLeft=="
end sub

sub scrollRight()
	? "==Entering ChannelNameFlagAndScroll:scrollRight=="

	leftIndex = decrementCountryIndex(m.currentIndex)

	'Set the new labels
	
	m.centerLabel.visible 	= true
	m.leftLabel.visible		= true
	m.rightLabel.visible	= false

	m.centerLabel.text = m.global.countriesContent.countries.keys()[m.currentIndex]
	m.leftLabel.text   = m.global.countriesContent.countries.keys()[leftIndex]
	
	m.centerPoster.visible 	= true
	m.leftPoster.visible	= true
	m.rightPoster.visible	= false

	m.centerPoster.uri 	= "pkg:/images/flag_" + m.global.countriesContent.countries[m.global.countriesContent.countries.keys()[m.currentIndex]].shortCode + ".jpeg"
	m.leftPoster.uri	= "pkg:/images/flag_" + m.global.countriesContent.countries[m.global.countriesContent.countries.keys()[leftIndex]].shortCode + ".jpeg"

	m.top.findNode("scrollRightAnimation").control = "start"

	m.currentIndex = leftIndex
	? "==Exiting ChannelNameFlagAndScroll:scrollRight=="
end sub