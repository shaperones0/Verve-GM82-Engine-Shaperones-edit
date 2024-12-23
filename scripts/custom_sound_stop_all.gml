///custom_sound_stop_all()
//stop all sounds (assume there is no way you have more than 50 sounds)
var i; for (i=0; i<50; i+=1) {
    if (sound_exists(i) and i != global.music_cidx) {
        audio_stop(i)
        if (i>40) show_error("I should increase the limit in this for loop right there", 1)
    }
}
