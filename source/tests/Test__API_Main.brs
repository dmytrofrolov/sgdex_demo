'----------------------------------------------------------------
' API Main setup function.
'----------------------------------------------------------------
Function TestSuite__API_Main() as Object
    this = BaseTestSuite()

    this.Name = "API_TestSuite"

    this.SetUp      = MainTestSuite__SetUp
    this.TearDown   = MainTestSuite__TearDown

    this.addTest("CheckAPINotInvalid", TestCase__API_Main__CheckAPINotInvalid)

    this.addTest("CheckPlaylists", TestCase__API_Main__CheckPlaylists)
    this.addTest("CheckPlaylistCount", TestCase__API_Main__CheckPlaylists_count)

    this.addTest("CheckVideosInPlaylist", TestCase__API_Main__CheckVideosInPlaylist)

    this.addTest("CheckVideoUrlIsLoaded", TestCase__API_Main__CheckVideoUrlIsLoaded)

    return this
End Function


' This function called to prepare all data for testing.
Sub MainTestSuite__SetUp()
    m.api_object  = Api()
End Sub


' This function called to clean or remove all data used in API testing.
Sub MainTestSuite__TearDown()
    ' Remove all the test data
    m.Delete("api_object")
End Sub


' Check API object exists
Function TestCase__API_Main__CheckAPINotInvalid() as String
    return m.AssertNotInvalid(m.api_object)
End Function


' Check if playlists returned from API
Function TestCase__API_Main__CheckPlaylists() as String
    getPlaylistsResponse = m.api_object.GetPlaylists()

    mandatoryAttributes = ["playlists"]

    return m.AssertAAHasKeys(GetPlaylistsResponse.json, mandatoryAttributes)
End Function


' Check if playlists are not empty
Function TestCase__API_Main__CheckPlaylists_count() as String
    getPlaylistsResponse = m.api_object.GetPlaylists()

    playlists = getPlaylistsResponse.json.playlists

    return m.assertNotEqual(playlists.count(), 0)
End Function


' Check videos for first playlist
Function TestCase__API_Main__CheckVideosInPlaylist() as String
    getPlaylistsResponse = m.api_object.GetPlaylists()

    playlists = getPlaylistsResponse.json.playlists

    playlist = playlists[0]
    getVideosResponse = m.api_object.GetPlaylistVideos(playlist.id)
    videos = getVideosResponse.json.videos

    return m.assertNotEqual(videos.count(), 0)
End Function


' Check stream url is loaded for first video
Function TestCase__API_Main__CheckVideoUrlIsLoaded() as String
    getPlaylistsResponse = m.api_object.GetPlaylists()

    playlists = getPlaylistsResponse.json.playlists

    playlist = playlists[0]
    getVideosResponse = m.api_object.GetPlaylistVideos(playlist.id)
    videos = getVideosResponse.json.videos
    video = videos[0]
    videoDetails = m.api_object.GetVideoDetails(video.id)

    mandatoryAttributes = ["id", "stream_url", "playlist_id"]

    return m.AssertAAHasKeys(videoDetails.json, mandatoryAttributes)
End Function


