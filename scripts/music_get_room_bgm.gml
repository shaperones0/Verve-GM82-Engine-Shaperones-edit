///music_get_room_bgm() -> cidx

switch(room) {
    case rTitle:
    case rMenu:
    case rOptions:
        return mus_guyrock

    default:
        return 0
}
