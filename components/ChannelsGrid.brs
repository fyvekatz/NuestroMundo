sub init()
    ? "==Entering ChannelsGrid:init=="

    'Load channel configuration content from DISK
    loadCountriesContent(m.global)
    
    'Load / prep any multimedia 
    m.loadChannelContentTask            = createObject("RoSGNode", "ChannelContentLoadTask")
    m.loadChannelContentTask.control    = "RUN"

    'Call-back functions for when channel content should be changed
    m.loadChannelContentTask.ObserveField("content", "updateChannelContent")
    m.top.ObserveField("country", "updateChannelContent")
    'm.top.ObserveField("rowItemSelected", "ItemSelected")
    'm.top.ObserveField("rowItemFocused", "FocusChange")
    
    'Whenever we update, update the following:
    '- Clipping rectangle
    'm.top.setField("ClippingRect", "[0.0, 0.0, 0.0, 0.0]")

    ? "==Exiting ChannelsGrid:init=="
end sub

sub updateChannelContent()
	? "==Entering ChannelsGrid:updateChannelContent=="

    if m.top.country = "" or m.top.country = invalid
        m.top.country = m.global.countriesContent.countries.keys()[0]
    end if

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

	? "==Exitting ChannelsGrid:updateChannelContent=="
end sub

sub FocusChange()
    ? "==Entering ChannelsGrid:FocusChange=="

    ? m.top.rowItemFocused
    ? m.top.content.getChild(m.top.rowItemFocused[0])
    ? m.top.content.getChild(m.top.rowItemFocused[0]).getChild(m.top.rowItemFocused[1])

    ? "==Exiting ChannelsGrid:FocusChange=="
end sub

sub ItemSelected()
    ? "==Entering ChannelsGrid:ItemSelected=="

    ' Necessary line. Noticed that the first time this function is called, there's no row item selected
    if m.top.rowItemSelected <> invalid and m.top.rowItemSelected.count() <> 0

        ? m.top.rowItemSelected
        ? m.top.content.getChild(m.top.rowItemSelected[0])
        ? m.top.content.getChild(m.top.rowItemSelected[0]).getChild(m.top.rowItemSelected[1])
    end if

    ? "==Exitting ChannelsGrid:ItemSelected=="
end sub