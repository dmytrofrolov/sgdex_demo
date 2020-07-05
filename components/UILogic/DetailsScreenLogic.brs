' DetailsScreenLogic.brs

function ShowDetailsScreen(rowContent, focusedIndex)
    detailsScreen = CreateObject("roSGNode", "DetailsView")

    detailsScreen.content = rowContent
    detailsScreen.jumpToItem = focusedIndex

    detailsScreen.ObserveField("wasShown", "OnDetailsScreenWasShown")
    detailsScreen.ObserveField("buttonSelected", "OnDetailsButtonSelected")
    detailsScreen.ObserveField("itemFocused", "OnDetailsItemFocused")

    m.top.ComponentController.callFunc("show", {
        view: detailsScreen
    })
    m.detailsScreen = detailsScreen
    m.previousFocusedButtonId = invalid

    return detailsScreen
end function


' There may be several cases if need to reload buttons:
' If number of buttons changed (bookmark added or deleted)
' or button is changed
sub ReloadButtons(detailsScreen)
    if detailsScreen.content = invalid then return
    
    focusedItem = detailsScreen.content.GetChild(detailsScreen.itemFocused)
    if focusedItem = invalid then return

    videoId = focusedItem.id
    playStart = GetBookmark(videoId)
    if playStart < 3
        focusedItem.playStart = playStart
        buttonsList = [{
                id: "play"
                title: "Play"
            }]
    else
        buttonsList = [{
                id: "continue"
                title: "Continue watching"
            },
            {
                id: "play_from_beginning"
                title: "Play from the beginning"
            }]
    end if
    detailsScreen.buttons = Utils_ContentList2Node(buttonsList)
    
    ' It's good UX if focused button didn't change in case is number of buttons
    ' changed or so
    if m.previousFocusedButtonId <> invalid
        for i = 0 to buttonsList.count() - 1
            if buttonsList[i].id = m.previousFocusedButtonId
                detailsScreen.jumpToButton = i
                exit for
            end if
        end for
    end if
end sub


' Each time screen is shown, buttons need to be reloaded, for case 
sub OnDetailsScreenWasShown(event as Object)
    detailsScreen = event.GetRoSGNode()
    ReloadButtons(detailsScreen)
end sub


sub OnDetailsButtonSelected(event as Object)
    detailsScreen = event.GetRoSGNode()
    focusedIndex = detailsScreen.itemFocused
    buttonSelectedIndex = event.GetData()
    selectedButtonNode = detailsScreen.buttons.GetChild(buttonSelectedIndex)
    if selectedButtonNode <> invalid
        buttonId = selectedButtonNode.id
        m.previousFocusedButtonId = buttonId
        if buttonId = "play_from_beginning"
            focusedItem = detailsScreen.content.GetChild(focusedIndex)
            focusedItem.playStart = 0
            DeleteBookmark(focusedItem.id)
        end if
        if buttonId = "play_from_beginning" or buttonId = "continue" or buttonId = "play"
            videoScreen = ShowVideoScreen(detailsScreen.content, focusedIndex)
            videoScreen.ObserveField("wasClosed", "OnVideoScreenWasClosed")
        end if
    end if
end sub


' When user switch item on details screen buttons should be reloaded to
' check Bookmark position
sub OnDetailsItemFocused(event as Object)
    detailsScreen = event.GetRoSGNode()
    ReloadButtons(detailsScreen)
end sub


' When video is ended by itself and screen is closed then it was last item in playlist
' and need to restart video playback. If screen was closed by user need to move
' focus to correct item in playlist.
sub OnVideoScreenWasClosed(event as Object)
    videoScreen = event.GetRoSGNode()
    if videoScreen.state = "finished"
        videoScreen = ShowVideoScreen(m.detailsScreen.content, 0)
        videoScreen.ObserveField("wasClosed", "OnVideoScreenWasClosed")
    else
        m.detailsScreen.jumpToItem = videoScreen.currentIndex
    end if
end sub
