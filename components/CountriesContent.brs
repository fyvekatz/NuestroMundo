sub loadCountriesData(global as Object)
    ? "==Entering CountriesData:loadCountriesData=="

    global.addField("countriesData", "roassociativearray", false)
    global.countriesData = parsejson(readAsciiFile("pkg:/data/Countries.json"))
    
    ? "==Exitting CountriesData:loadCountriesData=="
end sub

function getCountryIndex(country as String) as Integer
    ? "==Entering CountriesData:getCountryIndex=="

    retVal = invalid

    if country = invalid or country = "" then return invalid

    for index = 0 to m.global.countriesData.countries.keys().count() step 1
        if country = m.global.countriesData.countries.keys()[index] then retVal = index
    end for

    ? "==Exitting CountriesData:getCountryIndex=="
    return retVal
end function

function incrementCountryIndex(index as Integer) as Integer
    ? "==Entering CountriesData:incrementCountryIndex=="

    returnVal = invalid

    if index < 0 or index >= m.global.countriesData.countries.count() then returnVal = invalid

    if index = m.global.countriesData.countries.count() - 1
        returnVal = 0
    else
        returnVal = index + 1
    end if    

    ? "==Exitting CountriesData:incrementCountryIndex=="
    return returnVal
end function

function decrementCountryIndex(index as Integer) as Integer
    ? "==Entering CountriesData:decrementCountryIndex=="

    returnVal = invalid

    if index < 0 or index >= m.global.countriesData.countries.count() then returnVal = invalid

    if index = 0
        returnVal = m.global.countriesData.countries.count() - 1
    else
        returnVal = index - 1
    end if    

    ? "==Exitting CountriesData:decrementCountryIndex=="
    return returnVal
end function