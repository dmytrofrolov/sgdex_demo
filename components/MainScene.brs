
sub Show(args)
    m.top.theme = {
        global : {
            OverhangLogoUri : "pkg:/images/logo.png"
            backgroundColor : "#33333399"
        }
    }

    m.global.AddField("myPlaylistNode", "node", true)

    m.placeForVideo = CreateObject("roSGNode", "Group")
    m.videoScreen = CreateObject("roSGNode", "VideoView")
    m.videoScreen.ObserveField("close", "OnVideoScreenShouldClose")
    m.videoScreen.ObserveField("state", "OnVideoScreenStateChanged")

    m.placeForVideo.appendChild(m.videoScreen)
    m.top.insertChild(m.placeForVideo, 1)

    ' To prevent app from close on Back
    m.top.componentController.allowCloseLastViewOnBack = false
    ShowHomeScreen()
end sub


function PlayVideo(listContent, index)
    m.videoScreen.content = listContent
    m.videoScreen.jumpToItem = index
    m.videoScreen.control = "play"
end function


sub OnVideoScreenShouldClose(event as Object)
    videoScreen = event.GetRoSGNode()
    if videoScreen.state = "finished"
        m.videoScreen.jumpToItem = 0
        m.videoScreen.control = "play"
    end if
end sub


sub OnVideoScreenStateChanged(event as Object)
    videoScreen = event.GetRoSGNode()
    if videoScreen.state = "playing" and m.videoScreen.IsInFocusChain()
        m.videoScreen.moveFocusToVideoNode = true
    end if
end sub


function onKeyEvent(key as String, press as Boolean)
    if press
        if key = "back"
            if m.videoScreen.state = "playing" or m.videoScreen.state = "buffering" or m.videoScreen.state = "paused"
                if m.top.componentController.IsInFocusChain()
                    m.top.componentController.visible = false
                    m.videoScreen.setFocus(true)
                    m.videoScreen.moveFocusToVideoNode = true
                else ' video view in focus chain
                    m.top.componentController.visible = true
                    m.top.componentController.setFocus(true)
                    m.top.componentController.currentView.setFocus(true)
                end if

                return true
            end if
        end if
    end if

    return false
end function
