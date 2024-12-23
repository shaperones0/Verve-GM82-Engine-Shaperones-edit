#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

init = false
block = noone
sound = sndBlockChange
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy_id(block)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !init {
    block = instance_create(x, y, Block)
    block.image_xscale = image_xscale
    block.image_yscale = image_yscale
    init = true
}

if !visible if collision_rectangle(bbox_left - 1, bbox_top - 1, bbox_right + 1, bbox_bottom + 1, Player, false, false) {
    visible = true
    custom_sound_play(sound)
}

if instance_exists(block) {
    block.x = x
    block.y = y
}
#define Collision_Player
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
custom_sound_play(sound)
instance_destroy()
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//field sound: constant
