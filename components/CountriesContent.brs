sub loadCountriesContent(global as Object)
    ? "==Entering CountriesContent:loadCountriesContent=="

    global.addField("countriesContent", "roassociativearray", false)
    global.countriesContent = parsejson(readAsciiFile("pkg:/data/Countries.json"))

    ? "==Exitting CountriesContent:loadCountriesContent=="
end sub

function getCountryIndex(country as String) as Integer
    ? "==Entering CountriesContent:getCountryIndex=="

    retVal = invalid

    if country = invalid or country = "" then return invalid

    for index = 0 to m.global.countriesContent.countries.keys().count() step 1
        if country = m.global.countriesContent.countries.keys()[index] then retVal = index
    end for

    ? "==Exitting CountriesContent:getCountryIndex=="
    return retVal
end function

function incrementCountryIndex(index as Integer) as Integer
    ? "==Entering CountriesContent:incrementCountryIndex=="

    returnVal = invalid

    if index < 0 or index >= m.global.countriesContent.countries.count() then returnVal = invalid

    if index = m.global.countriesContent.countries.count() - 1
        returnVal = 0
    else
        returnVal = index + 1
    end if    

    ? "==Exitting CountriesContent:incrementCountryIndex=="
    return returnVal
end function

function decrementCountryIndex(index as Integer) as Integer
    ? "==Entering CountriesContent:decrementCountryIndex=="

    returnVal = invalid

    if index < 0 or index >= m.global.countriesContent.countries.count() then returnVal = invalid

    if index = 0
        returnVal = m.global.countriesContent.countries.count() - 1
    else
        returnVal = index - 1
    end if    

    ? "==Exitting CountriesContent:decrementCountryIndex=="
    return returnVal
end function