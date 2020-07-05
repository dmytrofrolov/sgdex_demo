
sub GetContent()
    playlistsResponse = Api().GetPlaylists()
    playlists = Parser().ParsePlaylists(playlistsResponse.json)
    m.top.content.AppendChildren(playlists)
end sub
