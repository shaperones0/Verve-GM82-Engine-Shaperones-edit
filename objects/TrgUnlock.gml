#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Broadcasts specified key across all instances of Trigger and TriggerRelay
key=""
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//field key: string
#define Trigger_Trigger On
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with TriggerRelay if key == other.key event_trigger(ev_trigger_unlock)
with Trigger if key == other.key event_trigger(ev_trigger_unlock)
