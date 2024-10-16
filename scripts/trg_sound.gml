///trg_sound(sound, [volume=1])

if !global.trigger_making {
    switch argument[0] {
        case "init":
            var snd; snd = audio_play(sound_sound)
            audio_volume(snd, sound_sound_volume)
            break
    }
}
else {
    with(global.trigger_target) {
        sound_sound = argument[0]
        sound_sound_volume = 1
        if argument_count > 1 {
            sound_sound_volume = argument[1]
        }

        ds_list_add(triggers_list, trg_sound)
    }
}
