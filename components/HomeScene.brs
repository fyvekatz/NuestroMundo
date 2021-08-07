
' ********** Copyright 2016 Roku Corp.  All Rights Reserved. **********

sub init()
    ? "Entering ==init=="
    m.numberMainPosters     = 7
    m.currentPosterIndex    = 1
    m.nextPosterIndex       = m.currentPosterIndex + 1

    m.currentPosterIndex = 1

    m.top.findNode("visibleMainPoster").uri = "pkg:/images/poster_" + m.currentPosterIndex.ToStr()  + ".jpeg"
    m.top.findNode("nextMainPoster").uri    = "pkg:/images/poster_" + m.nextPosterIndex.ToStr()     + ".jpeg"

    m.mainPostersTimer          = m.top.findNode("mainPostersTimer")
    m.mainPostersTimer.control  = "start"

    m.mainPostersTimer.ObserveField("fire", "slideMainPosters")
end sub

sub slideMainPosters()
    ? "Entering ==slideMainPosters=="
    m.mainPosterAnimations = m.top.findNode("mainPosterAnimations")
    m.mainPosterAnimations.control = "resume"
    
    ' If the current poster indext is already pointing to the last poster, reset
    if m.currentPosterIndex = m.numberMainPosters
        m.currentPosterIndex    = 1
        m.nextPosterIndex       = m.currentPosterIndex + 1

    ' If the next poster will be the last, set next poster to the first poster
    else if m.currentPosterIndex + 1 = m.numberMainPosters
        m.currentPosterIndex = m.numberMainPosters
        m.nextPosterIndex    = 1
    
    ' Normal case. Transition to the next two posters
    else if m.currentPosterIndex + 1 <> m.numberMainPosters
        m.currentPosterIndex++
        m.nextPosterIndex++
    end if

    currentPoster = m.top.findNode("visibleMainPoster")
    nextPoster    = m.top.findNode("nextMainPoster")
    
    ? "Pre-transformation:" + currentPoster.uri + " and " + nextPoster.uri

    currentPoster.uri   = "pkg:/images/poster_" + m.currentPosterIndex.ToStr()  + ".jpeg" 
    nextPoster.uri      = "pkg:/images/poster_" + m.nextPosterIndex.ToStr()     + ".jpeg"

    ? "Post-transformation:" + currentPoster.uri + " and " + nextPoster.uri

    
end sub