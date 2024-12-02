///audio_room_start()
//set here room music, preload needed sounds and setup crossfade with global.room_prev

switch(room) {
    case rTitle:
    case rMenu:
    case rOptions:
        music_play(musGuyRock)
        break

    default:
        sound_stop_all()
        music_play(0)
        break
}
