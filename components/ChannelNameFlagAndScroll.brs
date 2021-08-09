
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

	updateToCountry()

	? "==Exitting ChannelNameFlagAndScroll:init=="
End sub

sub updateToCountry()

	? "==Entering ChannelNameFlagAndScroll:updateToCountry=="
	
	country = m.top.getField("country")

	'Initialize to the beginning of the country list
	if country = ""

		'Maintain during any scroll decision a concept of a "previous index"
		m.previousIndex = 0
		m.currentIndex	= 0

		? "Setting centerLabel to the start of the country list."
		m.centerLabel.text 	= m.global.countriesContent.getChild(0).name
		m.leftLabel.text 	= m.global.countriesContent.getChild(m.global.countriesContent.getChildCount()-1).name
		m.rightLabel.text 	= m.global.countriesContent.getChild(1).name

		m.centerPoster.uri 	= "pkg:/images/flag_" + m.global.countriesContent.getChild(0).shortCode + ".jpeg"
		m.leftPoster.uri 	= "pkg:/images/flag_" + m.global.countriesContent.getChild(m.global.countriesContent.getChildCount()-1).shortCode + ".jpeg"
		m.rightPoster.uri 	= "pkg:/images/flag_" + m.global.countriesContent.getChild(1).shortCode + ".jpeg"
	else

		? "Searching for '" + country + "' in countries list." 
		found = false
		index = -1

		'Search the countries list for country which can be either a country name or a short code.
		while found = false
			index++
			if m.global.countriesContent.getChild(index).name = country or m.global.countriesContent.getChild(index).shortCode = country
				found = true
			end if
		end while

		'Note the index to which we want to navigate.
		newIndex = index

		? "New index chosen is " + Str(newIndex)

		'Is it faster to get there by scrolling "left" or "right"?
		
		'If newIndex > previousIndex
		if newIndex > m.previousIndex

			? "New index is greater than previous index (" + Str(newIndex) + ">" + Str(m.previousIndex) + ")."
			forwardDistance = newIndex - m.previousIndex
			backDistance	= m.previousIndex + (m.global.countriesContent.getChildCount() - newIndex)

			? "Forward distance: " + Str(forwardDistance)
			? "Back distance:" + Str(backDistance)

		'Else newIndex < previousIndex
		else

			? "New index is less than previous index (" + Str(newIndex) + "<" + Str(m.previousIndex)
			forwardDistance = (m.global.countriesContent.getChildCount() - m.previousIndex) + newIndex
			backDistance = m.previousIndex - newIndex

			? "Forward distance: " + Str(forwardDistance)
			? "Back distance:" + Str(backDistance)
		end if
		
		test = 0

		'Whichever's smaller, scroll that way.
		if forwardDistance < backDistance

			? "Scrolling left..."
			while m.currentIndex <> newIndex
				scrollLeft()
			end while
			? "Scroll complete."
		else
			? "Scrolling right..."
			while m.currentIndex <> newIndex
				scrollRight()
			end while
			? "Scroll complete."
		end if

		'The new becomes the old
		m.previousIndex = newIndex
	end if

	? "==Exitting ChannelNameFlagAndScroll:updateToCountry=="
end sub

sub scrollLeft()
	? "==Entering ChannelNameFlagAndScroll:scrollLeft=="

	if m.currentIndex = m.global.countriesContent.getChildCount() - 1
		rightIndex = 0
	else 
		rightIndex = m.currentIndex + 1
	end if

	'Set the new labels
	
	m.centerLabel.visible 	= true
	m.leftLabel.visible		= false
	m.rightLabel.visible	= true
	
	m.centerLabel.text = m.global.countriesContent.getChild(m.currentIndex).name
	m.rightLabel.text  = m.global.countriesContent.getChild(rightIndex).name

	m.centerPoster.visible 	= true
	m.leftPoster.visible	= false
	m.rightPoster.visible	= true

	m.centerPoster.uri 	= "pkg:/images/flag_" + m.global.countriesContent.getChild(m.currentIndex).shortCode + ".jpeg"
	m.rightPoster.uri 	= "pkg:/images/flag_" + m.global.countriesContent.getChild(rightIndex).shortCode + ".jpeg"

	m.top.findNode("scrollLeftAnimation").control = "start"

	m.currentIndex = rightIndex
	? "==Exiting ChannelNameFlagAndScroll:scrollLeft=="
end sub

sub scrollRight()
	? "==Entering ChannelNameFlagAndScroll:scrollRight=="

	if m.currentIndex = 0
		leftIndex = m.global.countriesContent.getChildCount() - 1
	else 
		leftIndex = m.currentIndex - 1
	end if

	'Set the new labels
	
	m.centerLabel.visible 	= true
	m.leftLabel.visible		= true
	m.rightLabel.visible	= false

	m.centerLabel.text = m.global.countriesContent.getChild(m.currentIndex).name
	m.leftLabel.text   = m.global.countriesContent.getChild(leftIndex).name
	
	m.centerPoster.visible 	= true
	m.leftPoster.visible	= true
	m.rightPoster.visible	= false

	m.centerPoster.uri 	= "pkg:/images/flag_" + m.global.countriesContent.getChild(m.currentIndex).shortCode + ".jpeg"
	m.leftPoster.uri	= "pkg:/images/flag_" + m.global.countriesContent.getChild(leftIndex).shortCode + ".jpeg"

	m.top.findNode("scrollRightAnimation").control = "start"

	m.currentIndex = leftIndex
	? "==Exiting ChannelNameFlagAndScroll:scrollRight=="
end sub