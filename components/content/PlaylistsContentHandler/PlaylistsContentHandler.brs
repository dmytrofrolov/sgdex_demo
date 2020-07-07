
sub GetContent()
    playlistsResponse = Api().GetPlaylists()
    playlists = Parser().ParsePlaylists(playlistsResponse.json)
    m.top.content.AppendChild(GetMyPlaylistItem())
    m.top.content.AppendChildren(playlists)
end sub


function GetMyPlaylistItem()
    myPlaylist = Utils_AAToContentNode({
        title : "My Playlist"
    })
    myPlaylist.appendChild(Utils_AAToContentNode({
        id : "add_to_my_playlist"
        title : "Add item to playlist"
        description : "Select item from Grid to add item to My Playlist"
        HDPosterUrl : "https://dummyimage.com/640x360/aa3300/ffffff&text=Add+item"
    }))
    m.global.myPlaylistNode = myPlaylist
    return m.global.myPlaylistNode
end function
