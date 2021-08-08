sub loadCountriesContent(global as Object)
    ? "==Entering loadCountriesContent=="

    'If we've entered while another component is loading countries content, wait.
    ? "Waiting if loading has been started by someone else"
    while global.countriesContentStatus = "loading"
    end while
    ? "Done waiting."

    'If the content is still not loaded, load it.
    if global.countriesContentStatus = "loaded"
        ? "Content previously loaded. Skipping."

    else
        ? "Content has not previously been loaded. Setting semaphore status to 'loading' and proceeding with load."

        'Semaphor. Lock it.

        'If not set, assume first time through and create fields and then set.
        global.addfield("countriesContentStatus", "string", false)
        global.addfield("countriesContent", "node", false)

        global.countriesContentStatus = "loading"
        global.countriesContent       = CreateObject("RoSGNode","ContentNode")

        ? "New countriesContent object"
        ? global
        ? global.countriesContent

        'Read in the json content
        json                          = parsejson(readAsciiFile("pkg:/data/Countries.json"))

        for each country in json.countries
            
            ? "Loading " + country.name + "..."

            countryContent              = CreateObject("RoSGNode","ContentNode")
            countryContent.addfield("id",         "string",  false)
            countryContent.addfield("name",       "string",  false)
            countryContent.addfield("shortCode",  "string",  false)
            countryContent.update(country, false)
            
            global.countriesContent.appendChild(countryContent)
        end for

        ? "Loading complete. Setting countriesContentStatus as 'loaded'."
        global.countriesContentStatus = "loaded"
    end if

    ? "==Exitting loadCountriesContent=="
end sub