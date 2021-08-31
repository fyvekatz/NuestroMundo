sub init()
    ? "==Entering TvGuideCategoryGrid:init=="

    'Load channel configuration content from DISK
    if m.global.countriesData = invalid
    	loadCountriesData(m.global)
	endif

    contentRoot = CreateObject("rosgnode", "ContentNode")

    contentItem = CreateObject("rosgnode", "ContentNode")
    contentItem.TITLE = "Featured"
    contentItem.HDGRIDPOSTERURL = "pkg:/images/icon_" + contentItem.TITLE + ".png"
    contentRoot.appendChild(contentItem)

    contentItem = CreateObject("rosgnode", "ContentNode")
    contentItem.TITLE = "Music"
    contentItem.HDGRIDPOSTERURL = "pkg:/images/icon_" + contentItem.TITLE + ".png"
    contentRoot.appendChild(contentItem)

    contentItem = CreateObject("rosgnode", "ContentNode")
    contentItem.TITLE = "Religious"
    contentItem.HDGRIDPOSTERURL = "pkg:/images/icon_" + contentItem.TITLE + ".png"
    contentRoot.appendChild(contentItem)


    m.top.content = contentRoot
    
    m.top.ObserveField("country", "countryChanged")

    ? "==Exiting TvGuideCategoryGrid:init=="
end sub

sub countryChanged()
    ? "==Entering TvGuideCategoryGrid:countryChanged=="

    updateChannelContent()

    ? "==Exitting TvGuideCategoryGrid:countryChanged=="
end sub

sub updateChannelContent()
	? "==Entering TvGuideCategoryGrid:updateChannelContent=="
    
    if m.loadChannelContentTask.content <> invalid and m.top.country <> invalid

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

	? "==Exitting TvGuideCategoryGrid:updateChannelContent=="
end sub

sub FocusChange()
    ? "==Entering TvGuideCategoryGrid:FocusChange=="

    '? m.top.rowItemFocused
    '? m.top.content.getChild(m.top.rowItemFocused[0])
    '? m.top.content.getChild(m.top.rowItemFocused[0]).getChild(m.top.rowItemFocused[1])

    ? "==Exiting TvGuideCategoryGrid:FocusChange=="
end sub

sub ItemSelected()
    ? "==Entering TvGuideCategoryGrid:ItemSelected=="

    ' Necessary line. Noticed that the first time this function is called, there's no row item selected
    if m.top.rowItemSelected <> invalid and m.top.rowItemSelected.count() <> 0

        '? m.top.rowItemSelected
        '? m.top.content.getChild(m.top.rowItemSelected[0])
        '? m.top.content.getChild(m.top.rowItemSelected[0]).getChild(m.top.rowItemSelected[1])
    end if

    ? "==Exitting TvGuideCategoryGrid:ItemSelected=="
end sub