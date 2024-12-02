///audio_init()
global.current_music_cidx = 0

audio_global_volume(global.audio_gain)
audio_music_loop(true)

global.audio_vol_list[musGuyRock] = 0.8

global.audio_vol_list[sndBlockChange] = 0.8
global.audio_vol_list[sndItem] = 1
global.audio_vol_list[sndPlayerAirJump] = 0.7
global.audio_vol_list[sndPlayerDeath] = 0.7
global.audio_vol_list[sndPlayerGroundJump] = 0.7
global.audio_vol_list[sndPlayerShoot] = 0.5
global.audio_vol_list[sndPlayerWallJump] = 0.5
