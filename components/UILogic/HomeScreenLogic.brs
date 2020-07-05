
sub ShowHomeScreen()
    homeGrid = CreateObject("roSGNode", "GridView")
    content = CreateObject("roSGNode", "ContentNode")
    Utils_forceSetFields(content, {
            HandlerConfigGrid : {
                name : "PlaylistsContentHandler"
            }
        })
    homeGrid.content = content

    homeGrid.ObserveField("rowItemSelected", "OnHomeGridItemSelected")
    m.homeGrid = homeGrid

    m.top.ComponentController.callFunc("show", {
        view: homeGrid
    })
end sub


sub OnHomeGridItemSelected(event as Object)
    homeGrid = event.GetRoSGNode()
    rowItemSelected = event.GetData()
    selectedRow = homeGrid.content.GetChild(rowItemSelected[0])
    detailsScreen = ShowDetailsScreen(selectedRow, rowItemSelected[1])
    detailsScreen.ObserveField("wasClosed", "OnDetailsScreenWasClosed")
end sub


sub OnDetailsScreenWasClosed(event as Object)
    detailsScreen = event.GetRoSGNode()
    m.homeGrid.jumpToRowItem = [m.homeGrid.rowItemSelected[0], detailsScreen.itemFocused]
end sub
