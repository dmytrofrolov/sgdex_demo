
function ShowDetailsScreen(rowContent, focusedIndex, shouldStartPlayback = false)
    detailsScreen = CreateObject("roSGNode", "DetailsView")

    detailsScreen.content = rowContent
    detailsScreen.jumpToItem = focusedIndex

    detailsScreen.ObserveField("wasShown", "OnDetailsScreenWasShown")
    detailsScreen.ObserveField("buttonSelected", "OnDetailsButtonSelected")

    m.top.ComponentController.callFunc("show", {
        view: detailsScreen
    })
    m.detailsScreen = detailsScreen
    return detailsScreen
end function


sub OnDetailsScreenWasShown(event as Object)
    detailsScreen = event.GetRoSGNode()
    detailsScreen.buttons = Utils_ContentList2Node([{
            id: "play"
            title: "Play"
        }])
end sub


sub OnDetailsButtonSelected(event as Object)
    detailsScreen = event.GetRoSGNode()
    focusedIndex = detailsScreen.itemFocused
    buttonSelectedIndex = event.GetData()
    selectedButtonNode = detailsScreen.buttons.GetChild(buttonSelectedIndex)
    if selectedButtonNode <> invalid
        if selectedButtonNode.id = "play"
            videoScreen = ShowVideoScreen(detailsScreen.content, focusedIndex)
            videoScreen.ObserveField("wasClosed", "OnVideoScreenWasClosed")
        end if
    end if
end sub


sub OnVideoScreenWasClosed(event as Object)
    videoScreen = event.GetRoSGNode()
    if videoScreen.state = "finished"
        videoScreen = ShowVideoScreen(m.detailsScreen.content, 0)
        videoScreen.ObserveField("wasClosed", "OnVideoScreenWasClosed")
    else
        m.detailsScreen.jumpToItem = videoScreen.currentIndex
    end if
end sub
