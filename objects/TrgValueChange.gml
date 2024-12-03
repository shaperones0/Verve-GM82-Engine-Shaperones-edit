#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Sets given variable of given object to specified value, immediately or gradually
inst=noone
var_name=""
relative=false
value_start=""
value_end=""
value_stepsize=""
stop_when_reached=false
max_time=""
strong=false
ease=ease_none
//if you set only end value then it will immediately set this value
//if you set only stepsize then it will increment value by given stepsize
//if you set end value and stepsize then it will approach given end value
//if you set start value then it will set itself to given start value
//if start value is empty then it will start with current value of var_name
track_badges=false
badges_list=noone
selected_list=noone
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if track_badges and badges_list!=noone ds_list_destroy(badges_list)
if selected_list!=noone ds_map_destroy(selected_list)
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//field inst: instance - Supports selectors
//field var_name: string - Check object's Create event comments for instructions
//field relative: false - Ignores value_start, calculates end value by adding value_end to the current value of var_name of inst
//field value_start: number
//field value_end: number
//field value_stepsize: number
//field stop_when_reached: false
//field max_time: number - Set to make it stop after specified number of frames passed
//field strong: false - Will prevent interferences while value is changing. Enables easing
    //field     ease: enum(ease_none,ease_quad_in,ease_quad_out,ease_quad_inout,ease_exp_in,ease_exp_out,ease_exp_inout,ease_back_in,ease_back_out,ease_back_inout,ease_elastic_in,ease_elastic_out,ease_elastic_inout,ease_bounce_in,ease_bounce_out,ease_bounce_inout)
//field track_badges: false - Allows stopping changes by OFF signal
    
if track_badges badges_list=ds_list_create()
selected_list=ds_map_create()
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=203
applies_to=self
invert=0
*/
#define Trigger_Trigger On
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Do the thing
ds_map_clear(selected_list)
trigger_list_selected(inst,selected_list)
if ds_map_size(selected_list) > 0 {

    var cur_inst, last_inst; cur_inst=ds_map_find_first(selected_list) last_inst=ds_map_find_last(selected_list)
    while 1 {
        if string(value_start) == "" and string(value_stepsize) == "" {
            //only value end is set - change immediately
            execute_string("with " + string(cur_inst) + " { " + var_name + " = " + string(value_end) + " }")
        }
        else {
            //create badge
            var _o; _o = badge_create(cur_inst, BadgeValueChange)
            _o.var_name = var_name
            if relative {
                execute_string("_o.value_start=argument0." + var_name, cur_inst)
                _o.value_end=_o.value_start+value_end
            }
            else {
                if string(value_start) != "" execute_string("with " + string(cur_inst) + " { " + var_name + " = " + string(value_start) + " }")
                execute_string("_o.value_start=argument0." + var_name, cur_inst)
                _o.value_end=value_end
            }
            _o.value_stepsize=value_stepsize
            _o.stop_when_reached=stop_when_reached
            _o.strong=strong
            _o.ease=ease
            _o.max_time=max_time
            if track_badges ds_list_add(badges_list, _o)
        }
        if cur_inst==last_inst break
        else cur_inst=ds_map_find_next(selected_list,cur_inst)
    }
}
#define Trigger_Trigger Off
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if track_badges {
    var i,len; len=ds_list_size(badges_list)
    for (i=0;i<len;i+=1) instance_destroy_id(ds_list_find_value(badges_list,i))
    ds_list_clear(badges_list)
}
