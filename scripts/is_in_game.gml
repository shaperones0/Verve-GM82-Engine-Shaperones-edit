///is_in_game([room])

// Returns true if a room isn't a menu room.
var _room;

if argument_count > 0 _room = argument[0] else _room = room

switch(_room) {
    case rInit:
    case rTitle:
    case rMenu:
    case rOptions:
        return false

    default:
        return true
}
