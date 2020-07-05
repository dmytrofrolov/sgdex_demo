
function ShowVideoScreen(listContent, index)
    videoScreen = CreateObject("roSGNode", "VideoView")

    videoScreen.content = listContent
    videoScreen.jumpToItem = index

    videoScreen.control = "play"

    m.top.ComponentController.callFunc("show", {
        view: videoScreen
    })

    return videoScreen
end function

