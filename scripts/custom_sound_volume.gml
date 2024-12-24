///custom_sound_volume(snd): number
//returns the max volume that should be used for specified sound
switch global.audio_group_list[argument0] {
case ag_any:
    return global.audio_gain * config_get("sound_volume")/100 * global.audio_vol_list[argument0] * global.audio_modifier_vol[argument0]
case ag_music:
    return global.audio_gain * config_get("music_volume")/100 * global.audio_vol_list[argument0] * global.audio_modifier_vol[argument0]
}
