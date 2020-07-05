
sub GetContent()
    playlistVideosResponse = Api().GetPlaylistVideos(m.top.playlistId)
    videos = Parser().ParsePlaylistVideos(playlistVideosResponse.json)
    m.top.content.AppendChildren(videos)
end sub
