///audio_init()

//my audio types explained:
//  cidx - game constant that is used as music name (for example, mus_guyrock is cidx). 0 means no sound
//  idx - gm82audio's internal sound index when it is loaded (for example, global.audio_list[mus_guyrock] contains a value of type idx
//  inst - gm82audio's sound instance that is produced when playing a sound (for example, audio_play(global.audio_list[mus_guyrock]) is going to return a value of type inst

var i, _music_map;

global.current_music_cidx = 0
global.current_music_instance = noone


audio_global_volume(global.audio_gain)
audio_music_loop(true)

global.audio_list[mus_guyrock] = audio_load_included("mus_guyrock.ogg")     audio_balance(mus_guyrock, 0.8)
global.audio_list[mus_megaman] = audio_load_included("mus_megaman.ogg")     audio_balance(mus_megaman, 0.8)

global.audio_list[snd_block_break] =        audio_load_included("snd_block_break.wav")          audio_balance(snd_block_break, 1)
global.audio_list[snd_block_change] =       audio_load_included("snd_block_change.wav")         audio_balance(snd_block_change, 0.8)
global.audio_list[snd_boss_hit] =           audio_load_included("snd_boss_hit.wav")             audio_balance(snd_boss_hit, 0.8)
global.audio_list[snd_cherry_trap] =        audio_load_included("snd_cherry_trap.wav")          audio_balance(snd_cherry_trap, 0.6)
global.audio_list[snd_get_item] =           audio_load_included("snd_get_item.wav")             audio_balance(snd_get_item, 1)
global.audio_list[snd_glass] =              audio_load_included("snd_glass.wav")                audio_balance(snd_glass, 1)
global.audio_list[snd_player_air_jump] =    audio_load_included("snd_player_air_jump.wav")      audio_balance(snd_player_air_jump, 0.7)
global.audio_list[snd_player_death] =       audio_load_included("snd_player_death.wav")         audio_balance(snd_player_death, 0.7)
global.audio_list[snd_player_ground_jump] = audio_load_included("snd_player_ground_jump.wav")   audio_balance(snd_player_ground_jump, 0.7)
global.audio_list[snd_player_shoot] =       audio_load_included("snd_player_shoot.wav")         audio_balance(snd_player_shoot, 0.5)
global.audio_list[snd_player_wall_jump] =   audio_load_included("snd_player_wall_jump.wav")     audio_balance(snd_player_wall_jump, 0.5)
global.audio_list[snd_spike_trap] =         audio_load_included("snd_spike_trap.wav")           audio_balance(snd_spike_trap, 1)
