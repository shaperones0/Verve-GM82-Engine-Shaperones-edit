///player_kill()

if global.debug_god_mode {
    exit
}

with(Player) {
    save_set_persistent("deaths", save_get("deaths") + 1)
    instance_create(x, y, BloodEmitter)
    custom_sound_play(sndPlayerDeath)

    instance_create(0, 0, GameOver)
    instance_destroy()
}
