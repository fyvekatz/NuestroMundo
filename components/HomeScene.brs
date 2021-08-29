
' ********** Copyright 2016 Roku Corp.  All Rights Reserved. **********

sub init()

    'Country list loaded in subroutine
    if m.global.countriesData = invalid
    	loadCountriesData(m.global)
	endif

    ? "==Entering HomeScene:init=="

    'm.channelInfoPosterCompact      = m.top.findNode("channelInfoPosterCompact")

    m.featuredChannelsGrid              = m.top.findNode("featuredChannelsGrid")
    m.featuredChannelsBottomBar         = m.top.findNode("featuredChannelsBottomBar")
    m.featuredChannelsToTvGuideAnimation    = m.top.findNode("featuredChannelsToTvGuideAnimation")

    m.tvGuideGrid                       = m.top.findNode("tvGuideGrid")
    m.tvGuideToFeaturedChannelsAnimation = m.top.findNode("tvGuideToFeaturedChannelsAnimation")

    m.hideFeaturedChannelsAnimation     = m.top.findNode("hideFeaturedChannelsAnimation")
    m.minimizeTvGuideAnimation          = m.top.findNode("minimizeTvGuideAnimation")
    m.showFeaturedChannelsAnimation     = m.top.findNode("showFeaturedChannelsAnimation")
    
    m.mainPoster                        = m.top.findNode("mainPoster")
    m.mainPosterTimer                   = m.top.findNode("mainPosterTimer")
    m.mainPosterAppearAnimation         = m.top.findNode("mainPosterAppear")
    m.mainPosterDisappearAnimation      = m.top.findNode("mainPosterDisappear")

    m.channelVideo                      = m.top.findNode("channelVideo")
    m.bottomBarTimeoutTimer             = m.top.findNode("bottomBarTimeoutTimer")
    
    m.currentPosterIndex    = 0
    firstCountry            = m.global.countriesData.countries[m.global.countriesData.countries.keys()[m.currentPosterIndex]]
    
    'Initialize main poster
    m.mainPoster.uri    = "pkg:/images/poster_" + firstCountry.shortCode  + ".jpeg"

    'Initialize main poster timer
    m.mainPosterTimer.control  = "start"

    'Observed fields
    m.mainPosterTimer.ObserveField("fire", "doNormalScroll")
    m.featuredChannelsGrid.ObserveField("rowItemSelected", "ChannelChange")
    m.channelVideo.ObserveField("state", "VideoStateChanged")
    m.featuredChannelsGrid.setFocus(true)
    m.bottomBarTimeoutTimer.ObserveField("fire", "bottomBarTimerFired")

    ? "==Exitting HomeScene:init=="
end sub

sub doNormalScroll()
    ? "==Entering HomeScene:doNormalScroll=="
    'Progress main poster

    'Determine next index
    if m.currentPosterIndex < m.global.countriesData.countries.count()-1
        m.currentPosterIndex++
    else
        m.currentPosterIndex = 0
    end if

    ' Hide poster
    m.mainPosterDisappearAnimation.control = "start"
    'Try to make the scroll look concurrent
    country                             = m.global.countriesData.countries.keys()[m.currentPosterIndex]
    'm.channelInfoPosterCompact.country  = country  
    ? "Changing country at HomeScene:onKeyEvent"
    m.featuredChannelsGrid.country              = country

    progressMainPoster(m.currentPosterIndex)
    ? "==Exitting HomeScene:doNormalScroll=="
end sub

sub progressMainPoster(index as Integer)
    ? "==Entering HomeScene:progressMainPoster=="

    currentCountry = m.global.countriesData.countries.keys()[index]
    m.mainPoster.uri = "pkg:/images/poster_" + m.global.countriesData.countries[m.global.countriesData.countries.keys()[index]].shortCode  + ".jpeg"
    m.mainPosterAppearAnimation.control = "start"

    'Set country on channelInfoPosterCompact
    ? "Changing to " + currentCountry + "(index: " + index.ToStr() + ")"
    'm.channelInfoPosterCompact.country = currentCountry

    ? "==Exitting HomeScene:progressMainPoster=="
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    ? "==Entering HomeScene:onKeyEvent (key: " + key + ")=="
    
    handled = false

    if press then

        ' If player main seen is showing
        if m.channelVideo.visible = false
            
            ? "Video player is not visible"

            if key = "left" OR key = "right"

                '? "Manually scroll through countries"
            
                'Force poster to hide and then perform a transition.
                'If an animation is current executing, handle it.

                'Stop the animations (in case they're firing at the moment) and blacken the Poster.
                m.mainPosterAppearAnimation.control = "stop"
                m.mainPosterDisappearAnimation.control = "stop"
                m.mainPoster.opacity = 0.0

                'Force the timer to start over
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
                ? "Changing country at HomeScene:onKeyEvent"
                m.featuredChannelsGrid.country = m.global.countriesData.countries.keys()[m.currentPosterIndex]
                progressMainPoster(m.currentPosterIndex)
                handled = true

            else if m.featuredChannelsBottomBar.hasFocus()
                if key = "down"
                    m.mainPosterTimer.control                       = "stop"
                    m.featuredChannelsToTvGuideAnimation.control    = "start"
                    m.tvGuideGrid.setFocus(true)
                    handled = true
                end if

            else if m.tvGuideGrid.hasFocus()
                if key = "back" or key = "up"
                    m.mainPosterTimer.control                       = "start"
                    m.tvGuideToFeaturedChannelsAnimation.control    = "start"
                    m.featuredChannelsGrid.setFocus(true)
                    handled = true
                end if
            end if

        ' If player is visible
        else
            ? "Video player is visible"

            ' If chanelsGrid is visible, we want to return to the video.
            if m.featuredChannelsGrid.hasFocus()
                if key = "back"
                   
                    'hide the onscreen widgets
                    m.hideFeaturedChannelsAnimation.control = "start"
                    m.featuredChannelsGrid.setFocus(false)
                    m.channelVideo.setFocus(true)
                    handled = true
                end if     
           
            ' If chanelsGrid is not visible, we want to stop the video and return the main screen.
            else
                ? "Channels grid is not visible."

                ' Show onscreen widgets
                if key = "down" or key = "up"
                    m.showFeaturedChannelsAnimation.control = "start"
                    m.featuredChannelsGrid.setFocus(true)
                    handled = true

                ' Go back to the main screen
                else if key = "back" 
                    m.channelVideo.control = "stop"
                    m.mainPoster.visible = "true"
                    m.hideFeaturedChannelsAnimation.control = "start"
                    m.mainPosterTimer.control = "start"
                    handled = true
                end if
            end if
        end if    
    end if

    ? "==Exitting HomeScene:onKeyEvent=="
    return handled
end function

sub ChannelChange()
    ? "==Entering HomeScene:ChannelChange=="

    ? m.featuredChannelsGrid.content.getChild(m.featuredChannelsGrid .rowItemFocused[0]).getChild(m.featuredChannelsGrid .rowItemFocused[1])

    
    m.channelVideo.content  = m.featuredChannelsGrid.content.getChild(m.featuredChannelsGrid.rowItemFocused[0]).getChild(m.featuredChannelsGrid .rowItemFocused[1])
    m.channelVideo.visible  = true
    m.channelVideo.control  = "play"
    m.mainPoster.visible    = false
    m.mainPosterTimer.control = "stop"

    'Return focus to the main scene. If the grid maintains control, won't be able to control.
    'Wait to do this after the video is playing. See VideoStateChanged()

    'm.featuredChannelsGrid.setFocus(false)
    'm.top.setFocus(true)

    ? "==Exitting HomeScene:ChannelChange=="
end sub

sub VideoStateChanged()
    ? "==Entering HomeScene:VideoStateChanged=="

    ? "Video state: " + m.channelVideo.state
    ' Hide the ChannelNameFlagAndScroll widget
    if m.channelVideo.state = "playing"

        m.bottomBarTimeoutTimer.control = "start"
        

    else if m.channelVideo.state = "stopped"
        m.channelVideo.visible = "false"
        m.bottomBarTimeoutTimer.control = "start"
        m.mainPosterAppearAnimation.control = "start"
    end if

    ? "==Exiting HomeScene:VideoStateChanged=="
end sub

'sub videoPlayingHideWidgets()
'    ? "==Entering HomeScene:videoPlayingHideWidgets"

'    m.videoPlayingHideWidgetsAnimation.control = "start"

'    ? "==Exitting HomeScene:videoPlayingHideWidgets"
'end sub

function featuredChannelsGridVisible() as boolean
    if m.featuredChannelsBottomBar.translation[1] >= 1080
        return false
    end if 

    return true
end function

sub bottomBarTimerFired()
    ?"==Entering HomeScene:bottomBarTimerFired=="
    m.hideFeaturedChannelsAnimation.control = "start"
    m.featuredChannelsGrid.setFocus(false)
    m.top.setFocus(true)
    ?"==Exitting HomeScene:bottomBarTimerFired=="
end sub