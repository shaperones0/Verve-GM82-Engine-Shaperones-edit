#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///setup
once=true
inst=noone
key=""
#define Collision_Player
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///fire Trigger On for specified instance (no selector support)
if key=="" {
    with inst event_trigger(ev_trigger_on)
    if once instance_destroy()
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//field inst: instance - doesn't support selectors, use relays for that
//field key: string - don't set to make it unlocked
//field once: true
#define Trigger_Trigger Unlock
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///unlock yourself (whoever calls this did the key checks i hope)
key=""
