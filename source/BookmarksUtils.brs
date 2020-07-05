' BookmarksUtils.brs

function SetBookmark(id, duration) as Object
    section = CreateObject("roRegistrySection", "Bookmark")
    section.Write(Utils_AsString(id), Utils_AsString(duration))
    section.Flush()
end function


function GetBookmark(id)
    section = CreateObject("roRegistrySection", "Bookmark")
    duration = 0
    if section.Exists(id) then
        duration = section.Read(id)
    end if
    return Utils_AsInteger(duration)
end function


function DeleteBookmark(id)
    section = CreateObject("roRegistrySection", "Bookmark")
    if section.Exists(id) then
        section.Delete(id)
    end if
end function
