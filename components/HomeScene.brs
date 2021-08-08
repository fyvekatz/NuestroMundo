
' ********** Copyright 2016 Roku Corp.  All Rights Reserved. **********

sub init()
    ? "Entering ==init=="
    m.numberMainPosters     = 7
    m.currentPosterIndex    = 1

    m.mainPoster = m.top.findNode("mainPoster")
    m.mainPoster.findNode("mainPoster").uri = "pkg:/images/poster_" + m.currentPosterIndex.ToStr()  + ".jpeg"

    m.mainPosterTimer          = m.top.findNode("mainPosterTimer")
    m.mainPosterTimer.control  = "start"
    m.mainPosterTimer.ObserveField("fire", "mainPosterAnimation")

    m.mainPosterAppearAnimation     = m.top.findNode("mainPosterAppear")
    m.mainPosterDisappearAnimation  = m.top.findNode("mainPosterDisappear")
    m.mainPosterDisappearAnimation.ObserveField("state", "mainPosterAnimation")

    m.mainPoster.setFocus(true)
end sub

sub mainPosterAnimation()
    ? "Entering ==changeMainPoster=="

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

        ? "Pre-transformation:" + m.mainPoster.uri

        m.mainPoster.uri = "pkg:/images/poster_" + m.currentPosterIndex.ToStr()  + ".jpeg"

        ? "Post-transformation:" + m.mainPoster.uri

        ? "Make poster appear"
        m.mainPosterAppearAnimation.control = "start"
    
    end if
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean

    ? "Key pressed"
    
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
    return handled
end function