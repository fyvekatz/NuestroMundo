
' ********** Copyright 2016 Roku Corp.  All Rights Reserved. **********

sub init()
    ? "== Entering HomeScenes init=="

    'Country list loaded in subroutine
    loadCountriesContent(m.global)
    
    m.numberMainPosters     = m.global.countriesContent.getChildCount()
    m.currentPosterIndex    = 1
    firstCountry            = m.global.countriesContent.getChild(m.currentPosterIndex-1)
    

    'Initialize main poster
    m.mainPoster        = m.top.findNode("mainPoster")
    m.mainPoster.uri    = "pkg:/images/poster_" + firstCountry.shortCode  + ".jpeg"

    'Initialize main poster timer
    m.mainPosterTimer          = m.top.findNode("mainPosterTimer")
    m.mainPosterTimer.control  = "start"
    m.mainPosterTimer.ObserveField("fire", "mainPosterAnimation")

    m.mainPosterAppearAnimation     = m.top.findNode("mainPosterAppear")
    m.mainPosterDisappearAnimation  = m.top.findNode("mainPosterDisappear")
    m.mainPosterDisappearAnimation.ObserveField("state", "mainPosterAnimation")

    m.mainPoster.setFocus(true)

    ? "== Exitting HomeScenes init=="
end sub

sub mainPosterAnimation()
    ? "==Entering changeMainPoster=="

    'If poster is visible
    if m.mainPoster.opacity = 1.0

        ? "Make poster disappear"
        m.mainPosterDisappearAnimation.control = "start"

    'If poster is not visible, cycle to next poster and display
    else
        ' If the current poster index is already pointing to the last poster, reset
        if m.currentPosterIndex = m.numberMainPosters
            m.currentPosterIndex = 1
        ' Normal case. Transition to the next two posters
        else m.currentPosterIndex++
        end if

        currentCountry = m.global.countriesContent.getChild(m.currentPosterIndex-1)
        m.mainPoster.uri = "pkg:/images/poster_" + currentCountry.shortCode  + ".jpeg"
        m.mainPosterAppearAnimation.control = "start"

        'Set country on channelInfoPosterCompact
        m.top.findNode("channelInfoPosterCompact").country = currentCountry.name

    end if

    ? "==Exitting changeMainPoster=="
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean

    ? "==Entering onKeyEvent (key: " + key + ")=="
    
    handled = false
    if press then

        if key = "left" OR key = "right"

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
            if key = "left"
                if (m.currentPosterIndex - 2) > 0
                    m.currentPosterIndex = m.currentPosterIndex-2
                else
                    m.currentPosterIndex = m.numberMainPosters + (m.currentPosterIndex - 2)
                end if
            end if

            mainPosterAnimation()
            handled = true
        end if
    end if

    ? "==Exitting onKeyEvent=="

    return handled
end function