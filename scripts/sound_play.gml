///sound_play(sound: cidx, loop = False) -> inst

var _sound, _loop;
_sound = argument0
if argument_count > 1 _loop = argument[1] else _loop = false

return audio_play_ext(global.audio_list[_sound], global.audio_vol_list[_sound], 0, 1.0, _loop)
