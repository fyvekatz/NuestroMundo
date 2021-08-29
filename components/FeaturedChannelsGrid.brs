sub init()
    ? "==Entering FeaturedChannelsGrid:init=="

    'Load channel configuration content from DISK
    if m.global.countriesData = invalid
    	loadCountriesData(m.global)
	endif
    
    'Load / prep any multimedia 
    m.loadChannelContentTask            = createObject("RoSGNode", "FeaturedChannelContentLoadTask")
    m.loadChannelContentTask.control    = "RUN"

    'Call-back functions for when channel content should be changed
    m.loadChannelContentTask.ObserveField("content", "updateChannelContent")
    m.top.ObserveField("country", "countryChanged")

    ? "==Exiting FeaturedChannelsGrid:init=="
end sub

sub countryChanged()
    ? "==Entering FeaturedChannelsGrid:countryChanged=="
    updateChannelContent()
    ? "==Exitting FeaturedChannelsGrid:countryChanged=="
end sub

sub updateChannelContent()
	? "==Entering FeaturedChannelsGrid:updateChannelContent=="
    
    if m.loadChannelContentTask.content <> invalid

        ? "Setting content for: " + m.top.country
        m.top.content = m.loadChannelContentTask.content[m.top.country]

        '? "What is our content?"
        '? m.top.content
        '? m.top.content.getChildren(-1, 0).count().ToStr()
        
        for each categoryNode in m.top.content.getChildren(-1, 0)
            ? "Category: " + categoryNode.Title

            for each channelNode in categoryNode.getChildren(-1,0)
                ? "Channel: " + channelNode.Title
            end for
        end for
    end if 

	? "==Exitting FeaturedChannelsGrid:updateChannelContent=="
end sub

sub FocusChange()
    ? "==Entering FeaturedChannelsGrid:FocusChange=="

    '? m.top.rowItemFocused
    '? m.top.content.getChild(m.top.rowItemFocused[0])
    '? m.top.content.getChild(m.top.rowItemFocused[0]).getChild(m.top.rowItemFocused[1])

    ? "==Exiting FeaturedChannelsGrid:FocusChange=="
end sub

sub ItemSelected()
    ? "==Entering FeaturedChannelsGrid:ItemSelected=="

    ' Necessary line. Noticed that the first time this function is called, there's no row item selected
    if m.top.rowItemSelected <> invalid and m.top.rowItemSelected.count() <> 0

        '? m.top.rowItemSelected
        '? m.top.content.getChild(m.top.rowItemSelected[0])
        '? m.top.content.getChild(m.top.rowItemSelected[0]).getChild(m.top.rowItemSelected[1])
    end if

    ? "==Exitting FeaturedChannelsGrid:ItemSelected=="
end sub