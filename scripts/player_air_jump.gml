///player_air_jump()

vspeed = -global.grav * air_jump_speed

if place_meeting(x, y, WaterRefreshing) {
    air_jumps = max_air_jumps
}
else {
    air_jumps -= 1
    air_jumps = max(air_jumps, 0)
}

custom_sound_play(sndPlayerAirJump)
