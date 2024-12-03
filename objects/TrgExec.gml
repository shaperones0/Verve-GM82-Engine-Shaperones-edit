#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Execute specified code, possibly by specified instance
inst=noone
code=""
repeat_=false
triggered=false
selected_list=noone
selected_list_len=0
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if selected_list != noone ds_list_destroy(selected_list)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Apply code if not set to once
if repeat_ and triggered {
    if inst==noone execute_string(code)
    else {
        var cur_inst, last_inst; cur_inst=ds_map_find_first(selected_list) last_inst=ds_map_find_last(selected_list)
        while 1 {
            execute_string("with "+string(cur_inst)+"{"+code+"}")
            if cur_inst==last_inst break
            else cur_inst=ds_map_find_next(selected_list,cur_inst)
        }
    }
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//field code: string
//field inst: instance - Set if code should be executed by specified instance. Supports selectors
//field repeat_: false - Set to true if code to be executed every frame.

selected_list=ds_map_create()
trigger_list_selected(inst,selected_list)
selected_list_len=ds_map_size(my_selected_list)
#define Trigger_Trigger On
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Apply code
if inst==noone execute_string(code)
else {
    var cur_inst, last_inst; cur_inst=ds_map_find_first(selected_list) last_inst=ds_map_find_last(selected_list)
    while 1 {
        execute_string("with "+string(cur_inst)+"{"+code+"}")
        if cur_inst==last_inst break
        else cur_inst=ds_map_find_next(selected_list,cur_inst)
    }
}
triggered=true
#define Trigger_Trigger Off
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///triggered=false
triggered=false
