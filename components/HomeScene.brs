
' ********** Copyright 2016 Roku Corp.  All Rights Reserved. **********

sub init()

    ? "==Entering HomeScenes:init=="

    m.channelInfoPosterCompact      = m.top.findNode("channelInfoPosterCompact")

    m.channelsGrid                  = m.top.findNode("channelsGrid")
    m.mainPoster                    = m.top.findNode("mainPoster")
    m.mainPosterTimer               = m.top.findNode("mainPosterTimer")
    m.mainPosterAppearAnimation     = m.top.findNode("mainPosterAppear")
    m.mainPosterDisappearAnimation  = m.top.findNode("mainPosterDisappear")
    m.channelVideo                  = m.top.findNode("channelVideo")
    m.bottomBar                     = m.top.findNode("bottomBar")
    m.bottomBarTimer                = m.top.findNode("bottomBarTimer")

    m.channelInfoPosterCompactDisappearAnimation = m.top.findNode("channelNameFlagAndScrollDisappear")
    m.channelInfoPosterCompactAppearAnimation = m.top.findNode("channelNameFlagAndScrollAppear")
    m.videoPlayingHideWidgetsAnimation = m.top.findNode("videoPlayingHideWidgets")
    m.videoPlayingShowWidgetsAnimation = m.top.findNode("videoPlayingShowWidgets")
    m.videoPlayingHideWidgetsTimer = m.top.findNode("videoPlayingHideWidgets")

    ? m.videoPlayingShowWidgetsAnimation

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
    m.channelVideo.ObserveField("state", "VideoStateChanged")
    m.videoPlayingHideWidgetsTimer.ObserveField("fire", "videoPlayingHideWidgets")
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
    
    handled = false

    if press then

        ' If player main seen is showing
        if m.channelVideo.visible = false
        
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
            else if key = "back" or key = "up"
                m.channelsGrid.setFocus(false)
                m.top.setFocus(true)
                handled = true
            else if key = "down"
                m.channelsGrid.setFocus(true)
                m.mainPosterTimer.control = "stop"
                handled = true
            end if

        ' If player is visible
        else

            ' If chanelsGrid is visible, we want to return to the video.
            if channelsGridVisible()
                if key = "back" or (key = "up" and m.channelsGrid.rowItemSelected[0] = 1)
                   
                    'hide the onscreen widgets
                    m.videoPlayingHideWidgetsAnimation.control = "start"
                    m.channelsGrid.setFocus(false)
                    m.top.setFocus(true)
                    handled = true
                end if     
           
            ' If chanelsGrid is not visible, we want to stop the video and return the main screen.
            else

                ' Show onscreen widgets
                if key = "down" or key = "up"
                    ? m.videoPlayingShowWidgetsAnimation
    
                    m.videoPlayingShowWidgetsAnimation.control = "start"
                    m.channelsGrid.setFocus(true)

                ' Go back to the main screen
                else if key = "back" 
                    m.channelVideo.control = "stop"
                    m.mainPoster.visible = "true"
                    m.videoPlayingShowWidgetsAnimation.control = "start"
                    m.mainPosterTimer.control = "start"
                end if
            end if
        end if    
    end if

    ? "==Exitting HomeScenes:onKeyEvent=="
    return handled
end function

sub ChannelChange()
    ? "==Entering HomeScenes:ChannelChange=="

    ? m.channelsGrid.content.getChild(m.channelsGrid .rowItemFocused[0]).getChild(m.channelsGrid .rowItemFocused[1])

    
    m.channelVideo.content  = m.channelsGrid.content.getChild(m.channelsGrid.rowItemFocused[0]).getChild(m.channelsGrid .rowItemFocused[1])
    m.channelVideo.visible  = true
    m.channelVideo.control  = "play"
    m.mainPoster.visible    = false
    m.mainPosterTimer.control = "stop"

    'Return focus to the main scene. If the grid maintains control, won't be able to control.
    m.channelsGrid.setFocus(false)
    m.top.setFocus(true)

    ? "==Exitting HomeScenes:ChannelChange=="
end sub

sub VideoStateChanged()
    ? "==Entering HomeScenes:VideoStateChanged=="

    ' Hide the ChannelNameFlagAndScroll widget
    if m.channelVideo.state = "playing"

        m.videoPlayingHideWidgetsTimer.control = "start"

    else if m.channelVideo.state = "stopped"
        m.channelVideo.visible = "false"
        m.videoPlayingShowWidgetsAnimation.control = "start"
        m.mainPosterAppearAnimation.control = "start"
        m.channelInfoPosterCompactAppearAnimation.control = "start"
    end if

    ? "==Exiting HomeScenes:VideoStateChanged=="
end sub

sub videoPlayingHideWidgets()
    m.videoPlayingHideWidgetsAnimation.control = "start"
end sub

function channelsGridVisible() as boolean
    if m.bottomBar.translation[1] >= 1080
        return false
    end if 

    return true
end function