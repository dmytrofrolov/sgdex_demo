sub Init()

    m.top.findNode("backgroundRectangle").color = m.top.GetScene().theme.global.backgroundColor
    m.top.findNode("backgroundImage").visible = false
    m.top.findNode("overhang").logoUri = "pkg:/images/logo.png"

    m.list = m.top.findNode("list")
    m.list.ObserveField("itemSelected", "OnListItemSelected")
    m.list.ObserveField("itemFocused", "OnListItemFocused")

    m.top.ObserveField("content", "OnMyListContentSet")
    m.top.ObserveField("focusedChild", "OnFocusedChildChanged")

    m.title = m.top.FindNode("title")
    m.poster = m.top.FindNode("poster")
    m.descriptionLabel = m.top.FindNode("description")
    m.actorsLabel = m.top.FindNode("actors")
end sub


sub OnFocusedChildChanged()
    if m.top.IsInFocusChain() and not m.list.HasFocus()
        m.list.SetFocus(true)
    end if
end sub


sub OnMyListContentSet(event as Object)
    rowListContent = event.GetData()
    listContent = CreateObject("roSGNode", "ContentNode")
    for rowIndex = 1 to rowListContent.GetChildCount() - 1
        row = rowListContent.GetChild(rowIndex)
        for itemIndex = 0 to row.GetChildCount() - 1
            listContent.AppendChild(Utils_AAToContentNode(row.getChild(itemIndex).getFields()))
        end for
    end for
    m.list.content = listContent

    ShowBusySpinner(false)
end sub


sub OnListItemSelected(event as Object)
    list = event.GetRoSGNode()
    itemSelected = event.GetData()
    m.top.selectedItem = list.content.getChild(itemSelected)
end sub


sub OnListItemFocused(event as Object)
    list = event.GetRoSGNode()
    itemFocused = event.GetData()
    focusedItemNode = list.content.GetChild(itemFocused)

    m.title.text = focusedItemNode.title
    m.poster.uri = focusedItemNode.hdposterurl
    m.descriptionLabel.text = focusedItemNode.description
    m.actorsLabel.text = focusedItemNode.actors.join(", ")
end sub
