Sub Init()
    ? "==Entering FeaturedChannelContentLoadTask:init=="
    m.top.functionName = "loadContent"
    ? "==Exiting FeaturedChannelContentLoadTask:init=="
End Sub

Sub loadContent()
    ? "==Entering FeaturedChannelContentLoadTask:loadContent=="
    
    ? "Loading content..."

    'Final associative array. Will be used for lookup of channel lists (category-delimited) by country
    m.contentTemp = {}
    
    for each country in m.global.countriesData.countries.keys()
        
        '? "For " + country + "..."

        categoryLabel = "Canales Destacados de " + country

        'First, make an associative array of channel categories to channels (content nodes) and populate it
        channelsByCategory = {}
        channelsByCategory[categoryLabel] = []

        'Next, make the country-specific content node where they will be stored.
        countryContentItem = createObject("RoSGNode","ContentNode")
        countryContentItem.addField("name", "string", false)
        countryContentItem.name = country
        
        for each channel in m.global.countriesData.countries[country].channels
            
            '? "For " + channel.Title + "..."

            if channel.Featured = "true"
                channelContentItem = createObject("RoSGNode","ContentNode")
                channelContentItem.HDPosterUrl  = channel.HDPosterUrl
                channelContentItem.Url          = channel.Url
                channelContentItem.Title        = channel.Title

                channelsByCategory[categoryLabel].push(channelContentItem)
            endif
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

    ? "==Exiting FeaturedChannelContentLoadTask:loadContent=="
End Sub