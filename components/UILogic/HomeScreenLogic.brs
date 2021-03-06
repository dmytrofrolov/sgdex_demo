' HomeScreenLogic.brs

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
    selectedItem = selectedRow.GetChild(rowItemSelected[1])
    if selectedItem <> invalid
        if selectedItem.id = "add_to_my_playlist"
            OpenAddToMyPlaylistScreen(homeGrid.content)
        else
            detailsScreen = ShowDetailsScreen(selectedRow, rowItemSelected[1])
            detailsScreen.ObserveField("wasClosed", "OnDetailsScreenWasClosed")
        end if
    end if
end sub


' When user is returned back from DetailsScreen, it's a good UX to move focus
' to exact item user is returned from
sub OnDetailsScreenWasClosed(event as Object)
    detailsScreen = event.GetRoSGNode()
    m.homeGrid.jumpToRowItem = [m.homeGrid.rowItemSelected[0], detailsScreen.itemFocused]
end sub
