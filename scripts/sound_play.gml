///sound_play(sound, loop=false, pitch=1.0, pan=0) -> inst
//plays specified sound

var _sound, _loop, _pitch, _pan;
_sound = argument0
if argument_count > 1 _loop = argument[1] else _loop = false
if argument_count > 2 _pitch = argument[2] else _pitch = 1.0
if argument_count > 3 _pan = argument[3] else _pan = 0

return audio_play_ext(_sound, global.audio_vol_list[_sound], _pan, _pitch, _loop)
