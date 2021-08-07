
' ********** Copyright 2016 Roku Corp.  All Rights Reserved. **********

sub init()
    m.countryPostersTimer = m.top.findNode("countryPostersTimer")
    m.countryPostersTimer.control = "start"
    m.countryPostersTimer.ObserveField("fire", "slideCountryPosters")
end sub

sub slideCountryPosters()
    m.countryPostersAnimation = m.top.findNode("countryPostersAnimation")
    m.countryPostersAnimation.control = "start"
end sub