' *************************************************
' Utils_IsXmlElement - check if value contains XMLElement interface
' @param value As Dynamic
' @return As Boolean - true if value contains XMLElement interface, else return false
' *************************************************
function Utils_IsXmlElement(value as Dynamic) as Boolean
    return Utils_IsValid(value) and GetInterface(value, "ifXMLElement") <> invalid
end function

' *************************************************
' Utils_IsFunction - check if value contains Function interface
' @param value As Dynamic
' @return As Boolean - true if value contains Function interface, else return false
' *************************************************
function Utils_IsFunction(value as Dynamic) as Boolean
    return Utils_IsValid(value) and GetInterface(value, "ifFunction") <> invalid
end function

' *************************************************
' Utils_IsBoolean - check if value contains Boolean interface
' @param value As Dynamic
' @return As Boolean - true if value contains Boolean interface, else return false
' *************************************************
function Utils_IsBoolean(value as Dynamic) as Boolean
    return Utils_IsValid(value) and GetInterface(value, "ifBoolean") <> invalid
end function

' *************************************************
' Utils_IsInteger - check if value type equals Integer
' @param value As Dynamic
' @return As Boolean - true if value type equals Integer, else return false
' *************************************************
function Utils_IsInteger(value as Dynamic) as Boolean
    return Utils_IsValid(value) and GetInterface(value, "ifInt") <> invalid and (Type(value) = "roInt" or Type(value) = "roInteger" or Type(value) = "Integer")
end function

' *************************************************
' Utils_IsFloat - check if value contains Float interface
' @param value As Dynamic
' @return As Boolean - true if value contains Float interface, else return false
' *************************************************
function Utils_IsFloat(value as Dynamic) as Boolean
    return Utils_IsValid(value) and GetInterface(value, "ifFloat") <> invalid
end function

' *************************************************
' Utils_IsDouble - check if value contains Double interface
' @param value As Dynamic
' @return As Boolean - true if value contains Double interface, else return false
' *************************************************
function Utils_IsDouble(value as Dynamic) as Boolean
    return Utils_IsValid(value) and GetInterface(value, "ifDouble") <> invalid
end function

' *************************************************
' Utils_IsLongInteger - check if value contains LongInteger interface
' @param value As Dynamic
' @return As Boolean - true if value contains LongInteger interface, else return false
' *************************************************
function Utils_IsLongInteger(value as Dynamic) as Boolean
    return Utils_IsValid(value) and GetInterface(value, "ifLongInt") <> invalid
end function

' *************************************************
' Utils_IsNumber - check if value contains LongInteger or Integer or Double or Float interface
' @param value As Dynamic
' @return As Boolean - true if value is number, else return false
' *************************************************
function Utils_IsNumber(value as Dynamic) as Boolean
    return Utils_IsLongInteger(value) or Utils_IsDouble(value) or Utils_IsInteger(value) or Utils_IsFloat(value)
end function

' *************************************************
' Utils_IsList - check if value contains List interface
' @param value As Dynamic
' @return As Boolean - true if value contains List interface, else return false
' *************************************************
function Utils_IsList(value as Dynamic) as Boolean
    return Utils_IsValid(value) and GetInterface(value, "ifList") <> invalid
end function

' *************************************************
' Utils_IsArray - check if value contains Array interface
' @param value As Dynamic
' @return As Boolean - true if value contains Array interface, else return false
' *************************************************
function Utils_IsArray(value as Dynamic) as Boolean
    return Utils_IsValid(value) and GetInterface(value, "ifArray") <> invalid
end function

' *************************************************
' Utils_IsAssociativeArray - check if value contains AssociativeArray interface
' @param value As Dynamic
' @return As Boolean - true if value contains AssociativeArray interface, else return false
' *************************************************
function Utils_IsAssociativeArray(value as Dynamic) as Boolean
    return Utils_IsValid(value) and GetInterface(value, "ifAssociativeArray") <> invalid
end function

' *************************************************
' Utils_IsSGNode - check if value contains SGNodeChildren interface
' @param value As Dynamic
' @return As Boolean - true if value contains SGNodeChildren interface, else return false
' *************************************************
function Utils_IsSGNode(value as Dynamic) as Boolean
    return Utils_IsValid(value) and GetInterface(value, "ifSGNodeChildren") <> invalid
end function

' *************************************************
' Utils_IsString - check if value contains String interface
' @param value As Dynamic
' @return As Boolean - true if value contains String interface, else return false
' *************************************************
function Utils_IsString(value as Dynamic) as Boolean
    return Utils_IsValid(value) and GetInterface(value, "ifString") <> invalid
end function

' *************************************************
' Utils_IsNotEmptyString - check if value contains String interface and length more 0
' @param value As Dynamic
' @return As Boolean - true if value contains String interface and length more 0, else return false
' *************************************************
function Utils_IsNotEmptyString(value as Dynamic) as Boolean
    return Utils_IsString(value) and Len(value) > 0
end function

' *************************************************
' Utils_IsDateTime - check if value contains DateTime interface
' @param value As Dynamic
' @return As Boolean - true if value contains DateTime interface, else return false
' *************************************************
function Utils_IsDateTime(value as Dynamic) as Boolean
    return Utils_IsValid(value) and (GetInterface(value, "ifDateTime") <> invalid or Type(value) = "roDateTime")
end function

' *************************************************
' Utils_IsValid - check if value initialized and not equal invalid
' @param value As Dynamic
' @return As Boolean - true if value initialized and not equal invalid, else return false
' *************************************************
function Utils_IsValid(value as Dynamic) as Boolean
    return Type(value) <> "<uninitialized>" and value <> invalid
end function

' *************************************************
' Utils_ValidStr - return value if his contains String interface else return empty string
' @param value As Object
' @return As String - value if his contains String interface else return empty string
' *************************************************
function Utils_ValidStr(obj as Object) as String
    if obj <> invalid and GetInterface(obj, "ifString") <> invalid
        return obj
    else
        return ""
    end if
end function

' *************************************************
' Utils_AsString - convert input to String if this possible, else return empty string
' @param input As Dynamic
' @return As String - return converted string
' *************************************************
function Utils_AsString(input as Dynamic) as String
    if Utils_IsValid(input) = false
        return ""
    else if Utils_IsString(input)
        return input
    else if Utils_IsInteger(input) or Utils_IsLongInteger(input) or Utils_IsBoolean(input)
        return input.ToStr()
    else if Utils_IsFloat(input) or Utils_IsDouble(input)
        return Str(input).Trim()
    else
        return ""
    end if
end function

' *************************************************
' Utils_AsInteger - convert input to Integer if this possible, else return 0
' @param input As Dynamic
' @return As Integer - return converted Integer
' *************************************************
function Utils_AsInteger(input as Dynamic) as Integer
    if Utils_IsValid(input) = false
        return 0
    else if Utils_IsString(input)
        return input.ToInt()
    else if Utils_IsInteger(input)
        return input
    else if Utils_IsFloat(input) or Utils_IsDouble(input) or Utils_IsLongInteger(input)
        return Int(input)
    else
        return 0
    end if
end function

' *************************************************
' Utils_AsLongInteger - convert input to LongInteger if this possible, else return 0
' @param input As Dynamic
' @return As Integer - return converted LongInteger
' *************************************************
function Utils_AsLongInteger(input as Dynamic) as Longinteger
    if Utils_IsValid(input) = false
        return 0
    else if Utils_IsString(input)
        return Utils_AsInteger(input)
    else if Utils_IsLongInteger(input) or Utils_IsFloat(input) or Utils_IsDouble(input) or Utils_IsInteger(input)
        return input
    else
        return 0
    end if
end function

' *************************************************
' Utils_AsFloat - convert input to Float if this possible, else return 0.0
' @param input As Dynamic
' @return As Float - return converted Float
' *************************************************
function Utils_AsFloat(input as Dynamic) as Float
    if Utils_IsValid(input) = false
        return 0.0
    else if Utils_IsString(input)
        return input.ToFloat()
    else if Utils_IsInteger(input)
        return (input / 1)
    else if Utils_IsFloat(input) or Utils_IsDouble(input) or Utils_IsLongInteger(input)
        return input
    else
        return 0.0
    end if
end function

' *************************************************
' Utils_AsDouble - convert input to Double if this possible, else return 0.0
' @param input As Dynamic
' @return As Float - return converted Double
' *************************************************
function Utils_AsDouble(input as Dynamic) as Double
    if Utils_IsValid(input) = false
        return 0.0
    else if Utils_IsString(input)
        return Utils_AsFloat(input)
    else if Utils_IsInteger(input) or Utils_IsLongInteger(input) or Utils_IsFloat(input) or Utils_IsDouble(input)
        return input
    else
        return 0.0
    end if
end function

' *************************************************
' Utils_AsBoolean - convert input to Boolean if this possible, else return False
' @param input As Dynamic
' @return As Boolean
' *************************************************
function Utils_AsBoolean(input as Dynamic) as Boolean
    if Utils_IsValid(input) = false
        return false
    else if Utils_IsString(input)
        return LCase(input) = "true"
    else if Utils_IsInteger(input) or Utils_IsFloat(input)
        return input <> 0
    else if Utils_IsBoolean(input)
        return input
    else
        return false
    end if
end function

' *************************************************
' Utils_AsArray - if type of value equals array return value, else return array with one element [value]
' @param value As Object
' @return As Object - roArray
' *************************************************
function Utils_AsArray(value as Object) as Object
    if Utils_IsValid(value)
        if not Utils_IsArray(value)
            return [value]
        else
            return value
        end if
    end if
    return []
end function

' =====================
' Strings
' =====================

' *************************************************
' Utils_IsNullOrEmpty - check if value is invalid or empty
' @param value As Dynamic
' @return As Boolean - true if value is null or empty string, else return false
' *************************************************
function Utils_IsNullOrEmpty(value as Dynamic) as Boolean
    if Utils_IsString(value)
        return Len(value) = 0
    else
        return not Utils_IsValid(value)
    end if
end function

' =====================
' Arrays
' =====================

' *************************************************
' Utils_FindElementIndexInArray - find an element index in array
' @param array As Object
' @param value As Object
' @param compareAttribute As Dynamic
' @param caseSensitive As Boolean
' @return As Integer - element index if array contains a value, else return -1
' *************************************************
function Utils_FindElementIndexInArray(array as Object, value as Object, compareAttribute = invalid as Dynamic, caseSensitive = false as Boolean) as Integer
    if Utils_IsArray(array)
        for i = 0 to Utils_AsArray(array).Count() - 1
            compareValue = array[i]

            if compareAttribute <> invalid and Utils_IsAssociativeArray(compareValue) and compareValue.DoesExist(compareAttribute)
                compareValue = compareValue.LookupCI(compareAttribute)
            end if

            if Utils_IsString(compareValue) and Utils_IsString(value) and not caseSensitive
                if LCase(compareValue) = LCase(value)
                    return i
                end if
            else if Utils_BaseComparator(compareValue, value)
                return i
            end if

            item = array[i]
        next
    end if

    return -1
end function

' *************************************************
' Utils_ArrayContains - check if array contains specified value
' @param array As Object
' @param value As Object
' @param compareAttribute As Dynamic
' @return As Boolean - true if array contains a value, else return false
' *************************************************
function Utils_ArrayContains(array as Object, value as Object, compareAttribute = invalid as Dynamic) as Boolean
    return (Utils_FindElementIndexInArray(array, value, compareAttribute) > - 1)
end function

' ----------------------------------------------------------------
' Type Comparison Functionality
' ----------------------------------------------------------------

' ----------------------------------------------------------------
' Compare two arbitrary values to each other.

' @param Value1 (dynamic) A first item to compare.
' @param Value2 (dynamic) A second item to compare.
' @param comparator (Function, optional) Function, to compare 2 values. Should take in 2 parameters and return either true or false.

' @return True if values are equal or False in other case.
' ----------------------------------------------------------------
function Utils_EqValues(Value1 as Dynamic, Value2 as Dynamic, comparator = invalid as Object) as Boolean
    if comparator = invalid
        return Utils_BaseComparator(value1, value2)
    else
        return comparator(value1, value2)
    end if
end function

' ----------------------------------------------------------------
' Base comparator for comparing two values.

' @param Value1 (dynamic) A first item to compare.
' @param Value2 (dynamic) A second item to compare.

' @return True if values are equal or False in other case.
function Utils_BaseComparator(value1 as Dynamic, value2 as Dynamic) as Boolean
    value1Type = Type(value1)
    value2Type = Type(value2)

    if (value1Type = "roList" or value1Type = "roArray") and (value2Type = "roList" or value2Type = "roArray")
        return Utils_EqArray(value1, value2)
    else if value1Type = "roAssociativeArray" and value2Type = "roAssociativeArray"
        return Utils_EqAssocArray(value1, value2)
    else if Type(box(value1), 3) = Type(box(value2), 3)
        return value1 = value2
    else
        return false
    end if
end function

' ----------------------------------------------------------------
' Compare two roAssociativeArray objects for equality.

' @param Value1 (object) A first associative array.
' @param Value2 (object) A second associative array.

' @return True if arrays are equal or False in other case.
' ----------------------------------------------------------------
function Utils_EqAssocArray(Value1 as Object, Value2 as Object) as Boolean
    l1 = Value1.Count()
    l2 = Value2.Count()

    if not l1 = l2
        return false
    else
        for each k in Value1
            if not Value2.DoesExist(k)
                return false
            else
                v1 = Value1[k]
                v2 = Value2[k]
                if not Utils_EqValues(v1, v2)
                    return false
                end if
            end if
        end for
        return true
    end if
end function
