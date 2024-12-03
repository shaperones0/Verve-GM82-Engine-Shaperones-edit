#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Sends signal on room start, can also send on every frame
inst=noone
once=true
active=true
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if not once and active with inst event_trigger(ev_trigger_on)
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//field inst: instance
//field once: true - If false, then output every frame
//field active: true

if active with inst event_trigger(ev_trigger_on)
if once instance_destroy()
#define Trigger_Trigger On
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///active=true
active=true
#define Trigger_Trigger Off
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///active=false
active=false
