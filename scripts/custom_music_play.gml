///custom_music_play(music, loop=true, sync=false, fade_time=0, crossfade=false)
//plays specified music, 0 to stop music.
var _music, _loop, _sync, _fade_time, _crossfade;

_music=argument0
if argument_count > 1 _loop=argument[1] else _loop=true
if argument_count > 2 global.music_sync=argument[2] else global.music_sync=false
if argument_count > 3 _fade_time=argument[3] else _fade_time=0
if argument_count > 4 _crossfade=argument[4] else _crossfade=0

if global.music_cidx != _music {
    // change music
    if _music == 0 {
        // stop music
        audio_music_stop(_fade_time)
    }
    else {
        if global.music_cidx == 0 {
            //starting from silence
            if _fade_time >= 0 {
                //start with fade time, ignore type
                audio_music_play_ext(_music, _fade_time, custom_sound_volume(_music), 0, 1.0, _loop)
            }
            else {
                //instantly start
                audio_music_play_ext(_music, 0, custom_sound_volume(_music), 0, 1.0, _loop)
            }
        }
        else {
            //gotta stop other music as well
            if _fade_time >= 0 {
                //do what fade type tells
                if _crossfade {
                    audio_music_crossfade_ext(_music, _fade_time, custom_sound_volume(_music), 0, 1.0, _loop)
                }
                else {
                    audio_music_switch_ext(_music, _fade_time, _fade_time, custom_sound_volume(_music), 0, 1.0, _loop)
                }
            }
            else {
                //instantly switch
                audio_music_switch_ext(_music, 0, 0, custom_sound_volume(_music), 0, 1.0, _loop)
            }
        }
    }
    global.music_cidx = _music
    global.music_time = 0
    if global.music_sync global.music_lenframe=audio_get_length(_music)*50
    else global.music_lenframe=-1


}
