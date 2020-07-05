' VideoScreenLogic.brs

function ShowVideoScreen(listContent, index)
    videoScreen = CreateObject("roSGNode", "VideoView")

    videoScreen.content = listContent
    videoScreen.jumpToItem = index

    videoScreen.control = "play"

    videoScreen.ObserveField("position", "OnVideoPositionChanged")

    m.top.ComponentController.callFunc("show", {
        view: videoScreen
    })

    return videoScreen
end function


' When video playback position is changed Bookmark should be set or deleted.
sub OnVideoPositionChanged(event as Object)
    videoScreen = event.GetRoSGNode()
    position = event.GetData()
    currentItem = videoScreen.currentItem
    SetBookmark(currentItem.id, position)

    if position < 3 or position > videoScreen.duration - 3
        DeleteBookmark(currentItem.id)
    end if
end sub
