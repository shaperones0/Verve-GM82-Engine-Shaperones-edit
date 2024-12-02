///event_world_end_step()

// Called from the World object.

if is_in_game() && !global.paused {
    camera_update()
}
