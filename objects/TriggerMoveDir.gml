#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

speed = 0
direction = 0
relative = false
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
//field speed: number
//field direction: number
//field relative: bool

with(instance) {
    trigger_make(other.trigger)
    trg_move_dir(other.speed, other.direction, other.relative)
}

instance_destroy()
