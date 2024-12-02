///music_play(music, loop=true, fade_type=mf_normal, fade_time=0)
//plays specified music, 0 to stop music.
var _music, _loop, _fade_type, _fade_time;

_music=argument0
if argument_count > 1 _loop=argument[1] else _loop=true
if argument_count > 2 _fade_type=argument[2] else _fade_type=mf_normal
if argument_count > 3 _fade_time=argument[3] else _fade_time=0

if global.current_music_cidx != _music {
    // change music
    if _music == 0 {
        // stop music
        audio_music_stop(_fade_time)
    }
    else {
        // change the music to specified
        switch _fade_type {
        case mf_normal:
            audio_music_play_ext(_music, _fade_time, global.audio_vol_list[_music], 0, 1.0, _loop)
            break
        case mf_crossfade:
            audio_music_crossfade_ext(_music, _fade_time, global.audio_vol_list[_music], 0, 1.0, _loop)
            break
        }

    }
    global.current_music_cidx = _music
}
