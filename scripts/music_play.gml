///music_play(music_name: str, loop: bool)
var _music_name, _loop;

_music_name = argument0
_loop = argument1

if global.current_music_name != _music_name {
    // change music
    if _music_name == "" {
        // stop music
        music_stop()
    }
    else {
        // change the music to specified
        if _loop {
            global.current_music_instance = sound_loop(_music_name)
        }
        else {
            global.current_music_instance = sound_play(_music_name)
        }
    }
    global.current_music_name = _music_name
}
