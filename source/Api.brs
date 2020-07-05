' API.brs

function Api() as Object
    this = {
        ' PRIVATE FIELDS
        _BASE_URL               : "https://sgdex.udesgo.com"

        ' Public methods
        GetPlaylists            : _API__GetPlaylists
        GetPlaylistVideos       : _API__GetPlaylistVideos
        GetVideoDetails         : _API__GetVideoDetails

        ' Private methods
        _makeApiCall            : _API__makeApiCall
    }
    return this
end function


function _API__GetPlaylists()
    url = m._BASE_URL + "/playlist.php"
    apiResult = m._makeApiCall(url)
    code = apiResult.code
    if apiResult.response = "" or code >= 400
        return {
            type: "NO_RESPONSE"
            apiResult : FormatJson(apiResult)
            code : code
            json : {}
        }
    end if

    return {
        code : code
        json : ParseJSON(apiResult.response)
    }
end function


function _API__GetPlaylistVideos(playlistId)
    url = m._BASE_URL + "/playlistDetails.php"
    apiResult = m._makeApiCall(url, {
        id: playlistId
    })
    code = apiResult.code
    if apiResult.response = "" or code >= 400
        return {
            type: "NO_RESPONSE"
            apiResult : FormatJson(apiResult)
            code : code
            json : {}
        }
    end if

    return {
        code : code
        json : ParseJSON(apiResult.response)
    }
end function


function _API__GetVideoDetails(videoId)
    url = m._BASE_URL + "/video.php"
    apiResult = m._makeApiCall(url, {
        id: videoId
    })
    code = apiResult.code
    if apiResult.response = "" or code >= 400
        return {
            type: "NO_RESPONSE"
            apiResult : FormatJson(apiResult)
            code : code
            json : {}
        }
    end if

    return {
        code : code
        json : ParseJSON(apiResult.response)
    }
end function







function _API__makeApiCall(url as String, parameters = {}, headers = {}, body = "" as String, requestType = "GET" as String, cookies = {} as Object, timeout = 20 as Integer) as Object
    ? "[_API__makeApiCall] url == ["; requestType; "] "; url
    requestType = LCase(requestType)

    urlTransfer = CreateObject("roUrlTransfer")
    urlTransfer.SetCertificatesFile("common:/certs/ca-bundle.crt")


    if parameters <> Invalid and parameters.count() > 0
        if Instr(0, url, "?") = 0 then url = url + "?"

        for each key in parameters
            value = parameters[key].ToStr()

            if key <> "" and value <> ""
                url = url + "&" + key + "=" + value
            end if
        end for
    end if

    urlTransfer.SetUrl(url)


    if headers.count() > 0
        for each header in headers
            urlTransfer.AddHeader(header, headers[header])
        end for
    end if

    port = CreateObject("roMessagePort")
    urlTransfer.SetMessagePort(port)
    if requestType = "get"
        urlTransfer.AsyncGetToString()
    else if requestType = "head"
        urlTransfer.SetRequest(UCase(requestType))
        urlTransfer.AsyncHead()
    else if requestType = "post" or requestType = "put"
        urlTransfer.SetRequest(UCase(requestType))
        urlTransfer.AsyncPostFromString(body)
    end if

    msg = wait(timeout * 1000, port) ' Convert timeout to milliseconds
    if type(msg) = "roUrlEvent"
        rsp = msg.getString()
        code = msg.GetResponseCode()
        headers = msg.GetResponseHeaders()
        if rsp <> invalid
            return {
                code        :   code
                headers     :   headers
                response    :   rsp
            }
        end if
    end if

    return {
                code        : -1
                response    : ""
                errorMsg    : "Request timeout"
            }
end function

