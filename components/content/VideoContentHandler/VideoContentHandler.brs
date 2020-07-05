
sub GetContent()
    videoDetailsResponse = Api().GetVideoDetails(m.top.videoId)
    videoFields = Parser().ParseVideo(videoDetailsResponse.json)
    m.top.content.SetFields(videoFields)
end sub
