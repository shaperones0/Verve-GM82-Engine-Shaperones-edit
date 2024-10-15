///music_play(music: cidx)
//plays specified music, 0 to stop music. music instance is then stored in global.current_music_instance
var _music;

_music = argument0

if global.current_music_cidx != _music {
    // change music
    if _music == 0 {
        // stop music
        audio_music_stop()
        global.current_music_instance = noone
    }
    else {
        // change the music to specified
        global.current_music_instance = audio_music_play_ext(global.audio_list[_music], 0, global.audio_vol_list[_music], 0, 1.0, true)
    }
    global.current_music_cidx = _music
}
