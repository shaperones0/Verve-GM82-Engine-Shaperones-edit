///event_room_start()

// Called from the World object.

room_speed = global.game_speed
// TODO: add stop all sounds here
music_play(music_get_room_bgm())

ds_map_clear(global.trigger_map)

// Set this every room start, then set it to true ahead of every transition
// that needs to clear input. (see engine_settings)
io_set_roomend_clear(false)

cement_blocks()

camera_default()
camera_update()
camera_snap()
