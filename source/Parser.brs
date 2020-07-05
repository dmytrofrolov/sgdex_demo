' Parser.brs

function Parser() as Object
    this = {
        ParsePlaylists          : _Parser__ParsePlaylists
        ParsePlaylistVideos     : _Parser__ParsePlaylistVideos
        ParseVideo              : _Parser__ParseVideo
    }
    return this
end function


function _Parser__ParsePlaylists(json)
    playlists = json.playlists
    if playlists = invalid then return []
    listOfPlaylists = []
    for each playlistItem in playlists
        playlistNode = Utils_AAToContentNode({
            id : playlistItem.id
            title : playlistItem.title
            description : playlistItem.description
            HDPosterUrl : playlistItem.poster_url
            HandlerConfigGrid : {
                name : "PlaylistDetailsContentHandler"
                fields : {
                    playlistId : playlistItem.id
                }
            }
        })
        listOfPlaylists.Push(playlistNode)
    end for
    return listOfPlaylists
end function


function _Parser__ParsePlaylistVideos(json)
    videos = json.videos
    if videos = invalid then return []
    listOfVideos = []
    for each videoItem in videos
        videoContentNode = Utils_AAToContentNode({
            id : videoItem.id
            title : videoItem.title
            description : videoItem.description
            Rating : 5+RND(5)
            categories : ["animals", "planets", "interesting"]
            actors : ["Clint Eastwood", "Eli Wallach", "Lee Van Cleef"]
            HDPosterUrl : videoItem.poster_url
            HandlerConfigVideo : {
                name : "VideoContentHandler"
                fields : {
                    videoId : videoItem.id
                }
            }
        })
        listOfVideos.Push(videoContentNode)
    end for
    return listOfVideos
end function


function _Parser__ParseVideo(json)
    return {
            id: json.id,
            title: json.title
            description: json.description,
            HDPosterUrl : json.poster_url,
            url : json.stream_url,
            streamFormat : "mp4"
        }
end function
