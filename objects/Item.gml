#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
index = 0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if save_get(str_cat("item", index)) {
    instance_destroy()
}
#define Collision_Player
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.autosave_items {
    save_set_persistent(str_cat("item", index), true)
}
else {
    save_set(str_cat("item", index), true)
}
instance_destroy()
sound_play(snd_get_item)
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//field index: value
