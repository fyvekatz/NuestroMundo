
' ********** Copyright 2016 Roku Corp.  All Rights Reserved. **********

sub init()

    ? "==Entering HomeScenes:init=="

    m.channelInfoPosterCompact      = m.top.findNode("channelInfoPosterCompact")

    m.bottomBarUpAnimation          = m.top.findNode("bottomBarUp")
    m.bottomBarDownAnimation        = m.top.findNode("bottomBarDown")
    m.channelsGrid                  = m.top.findNode("channelsGrid")
    m.mainPoster                    = m.top.findNode("mainPoster")
    m.mainPosterTimer               = m.top.findNode("mainPosterTimer")
    m.mainPosterAppearAnimation     = m.top.findNode("mainPosterAppear")
    m.mainPosterDisappearAnimation  = m.top.findNode("mainPosterDisappear")
    m.channelVideo                  = m.top.findNode("channelVideo")

    
    'Country list loaded in subroutine
    loadCountriesContent(m.global)
    
    m.currentPosterIndex    = 0
    firstCountry            = m.global.countriesContent.countries[m.global.countriesContent.countries.keys()[m.currentPosterIndex]]
    
    'Initialize main poster
    m.mainPoster.uri    = "pkg:/images/poster_" + firstCountry.shortCode  + ".jpeg"

    'Initialize main poster timer
    m.mainPosterTimer.control  = "start"

    'Observed fields
    m.mainPosterTimer.ObserveField("fire", "doNormalScroll")
    m.channelsGrid.ObserveField("rowItemSelected", "ChannelChange")

    m.top.setFocus(true)

    ? "==Exitting HomeScenes:init=="
end sub

sub doNormalScroll()

    'Progress main poster

    'Determine next index
    if m.currentPosterIndex < m.global.countriesContent.countries.count()-1
        m.currentPosterIndex++
    else
        m.currentPosterIndex = 0
    end if

    ' Hide poster
    m.mainPosterDisappearAnimation.control = "start"
    'Try to make the scroll look concurrent
    country                             = m.global.countriesContent.countries.keys()[m.currentPosterIndex]
    m.channelInfoPosterCompact.country  = country     
    m.channelsGrid.country              = country

    progressMainPoster(m.currentPosterIndex)

end sub

sub progressMainPoster(index as Integer)
    ? "==Entering HomeScenes:progressMainPoster=="

    currentCountry = m.global.countriesContent.countries.keys()[index]
    m.mainPoster.uri = "pkg:/images/poster_" + m.global.countriesContent.countries[m.global.countriesContent.countries.keys()[index]].shortCode  + ".jpeg"
    m.mainPosterAppearAnimation.control = "start"

    'Set country on channelInfoPosterCompact
    ? "Changing to " + currentCountry + "(index: " + index.ToStr() + ")"
    m.top.findNode("channelInfoPosterCompact").country = currentCountry

    ? "==Exitting HomeScenes:progressMainPoster=="
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    ? "==Entering HomeScenes:onKeyEvent (key: " + key + ")=="
    
    ? "What has focus?"

    ? m.top.hasFocus()
    ? m.channelsGrid.hasFocus()

    handled = false
    if press then
        if m.top.hasFocus()
            if key = "left" OR key = "right"

                ? "Manually scroll through countries"
            
                'Force poster to hide and then perform a transition.
                'If an animation is current executing, handle it.

                'Stop the animations (in case they're firing at the moment) and blacken the Poster.
                m.mainPosterAppearAnimation.control = "stop"
                m.mainPosterDisappearAnimation.control = "stop"
                m.mainPoster.opacity = 0.0

                'For the timer to start over
                m.mainPosterTimer.control = "stop"
                m.mainPosterTimer.control = "start"
                
                'The poster animation is going to advance the currentPosterIndex by one.
                'If the key press is a "right" ("forward"), do nothing and do the animation.
                'If the key press is a "left" ("back"), move currentPosterIndex back two and do the animation.

                '? "Before index: " + Str(m.currentPosterIndex)

                if key = "left"
                    m.currentPosterIndex = decrementCountryIndex(m.currentPosterIndex)
                else
                    m.currentPosterIndex = incrementCountryIndex(m.currentPosterIndex)
                end if

                '? "Target index: " + Str(m.currentPosterIndex)
                m.channelsGrid.country = m.global.countriesContent.countries.keys()[m.currentPosterIndex]
                progressMainPoster(m.currentPosterIndex)

                handled = true

            else if key = "down"
                m.bottomBarUpAnimation.control = "start"
                m.channelsGrid.setFocus(true)
                handled = true
            end if
        else if m.channelsGrid.hasFocus()
            if key = "back" or key = "up"
                m.bottomBarDownAnimation.control = "start"
                m.channelsGrid.setFocus(false)
                m.top.setFocus(true)
                handled = true
            end if
        end if
    end if

    ? "==Exitting HomeScenes:onKeyEvent=="
    return handled
end function

sub ChannelChange()
    ? "==Entering HomeScenes:ChannelChange=="

    ? m.channelsGrid.content.getChild(m.channelsGrid .rowItemFocused[0]).getChild(m.channelsGrid .rowItemFocused[1])

    m.channelVideo.content  = m.channelsGrid.content.getChild(m.channelsGrid .rowItemFocused[0]).getChild(m.channelsGrid .rowItemFocused[1])
    m.channelVideo.visible  = true
    m.channelVideo.control  = "play"
    m.mainPoster.visible    = false
    m.mainPosterTimer.control = "stop"

    'Return channel grid to the bottom of the screen hidden

    ? "==Exitting HomeScenes:ChannelChange=="
end sub