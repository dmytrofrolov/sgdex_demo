' AddToMyPlaylistScreenLogic.brs

sub OpenAddToMyPlaylistScreen(rowListContent)
    ' selectedItem
    addToMyListScreen = CreateObject("roSGNode", "AddToMyListScreen")

    addToMyListScreen.content = rowListContent

    addToMyListScreen.ObserveField("selectedItem", "OnMyListSelectedItemChanged")

    m.top.ComponentController.callFunc("show", {
        view: addToMyListScreen
    })
end sub


sub OnMyListSelectedItemChanged(event as Object)
    addToMyListScreen = event.GetRoSGNode()
    addToMyListScreen.close = true

    selectedItem = event.GetData()
    Utils_forceSetFields(selectedItem, {
        isInMyPlaylist : true
    })
    m.global.myPlaylistNode.InsertChild(selectedItem, m.global.myPlaylistNode.GetChildCount()-1)
end sub
