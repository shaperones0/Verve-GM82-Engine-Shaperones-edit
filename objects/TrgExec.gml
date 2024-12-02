#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Execute specified code, possibly by specified instance
inst=noone
code=""
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//field code: string
//field inst: instance - Set if code should be executed by specified instance. Supports selectors
#define Trigger_Trigger On
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///apply code
if inst==noone execute_string(code)
else trigger_execute_selected(inst, code)
