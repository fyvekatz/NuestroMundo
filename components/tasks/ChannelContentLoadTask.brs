Sub Init()
    ? "==Entering ChannelContentLoadTask:init=="
    m.top.functionName = "loadContent"
    ? "==Exiting ChannelContentLoadTask:init=="
End Sub

Sub loadContent()
    ? "==Entering ChannelContentLoadTask:loadContent=="
    
    ? "Loading content..."

    'Final associative array. Will be used for lookup of channel lists (category-delimited) by country
    m.contentTemp = {}

    for each country in m.global.countriesContent.countries.keys()
        
        ? "For " + country + "..."

        'First, make an associative array of channel categories to channels (content nodes) and populate it
        channelsByCategory = {}
        channelsByRegion = {}

        'Next, make the country-specific content node where they will be stored.
        countryContentItem = createObject("RoSGNode","ContentNode")
        countryContentItem.addField("name", "string", false)
        countryContentItem.name = country

        for each channel in m.global.countriesContent.countries[country].channels

            ? "For " + channel.Title + "..."

            for each category in channel.categories

                ? "Inserting into " + category + "."

                channelContentItem = createObject("RoSGNode","ContentNode")
                channelContentItem.HDPosterUrl  = channel.HDPosterUrl
                channelContentItem.Url          = channel.Url
                channelContentItem.Title        = channel.Title

            
                if invalid = channelsByCategory[category]
                    channelsByCategory[category] = []
                end if

                channelsByCategory[category].push(channelContentItem)
            end for

            ? "Inserting into " + channel.region + "."

                channelContentItem = createObject("RoSGNode","ContentNode")
                channelContentItem.HDPosterUrl  = channel.HDPosterUrl
                channelContentItem.Url          = channel.Url
                channelContentItem.Title        = channel.Title

            'Do the same for the channel's region
            if invalid = channelsByRegion[channel.region]
                channelsByRegion[channel.region] = []
            end if

            channelsByRegion[channel.region].push(channelContentItem)

        end for

        'Make "Featured appear first"
        featuredCategoryChannels = channelsByCategory["Featured"]
        featuredCategoryContentNode = createObject("RoSGNode","ContentNode")
        featuredCategoryContentNode.Title = "Featured"
        featuredCategoryContentNode.insertChildren(featuredCategoryChannels, 0)
        countryContentItem.appendChild(featuredCategoryContentNode)
        channelsByCategory.delete("Featured")

        'Load the channel lists by region
        for each region in channelsByRegion

            regionContentItem = createObject("RoSGNode","ContentNode")
            regionContentItem.Title = region
            regionContentItem.insertChildren(channelsByRegion[region], 0)
            countryContentItem.appendChild(regionContentItem)
        end for

        'Load the channel lists by category
        for each category in channelsByCategory

            categoryContentItem = createObject("RoSGNode","ContentNode")
            categoryContentItem.Title = category
            categoryContentItem.insertChildren(channelsByCategory[category], 0)
            countryContentItem.appendChild(categoryContentItem)
        end for

        ? "Content node for " + country
        ? countryContentItem

        for each categoryContentItem in countryContentItem.getChildren(-1, 0)

            ? "Content node for " + categoryContentItem.TITLE
            ? categoryContentItem

            for each channelContentItem in categoryContentItem.getChildren(-1, 0)

                ? "Content node for " + channelContentItem.TITLE
                ? channelContentItem
            end for
        end for

        m.contentTemp[country] = {}
        m.contentTemp[country] = countryContentItem
    end for

    '? "Full content node list"
    '? m.contentTemp
    'Store as global content
    m.top.content = m.contentTemp

    ? "Content loaded."

    '? "Verification step"
    '? m.top.content

    ? "==Exiting ChannelContentLoadTask:loadContent=="
End Sub