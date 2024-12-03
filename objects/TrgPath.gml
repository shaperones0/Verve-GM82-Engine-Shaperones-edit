#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
inst=noone
pth=noone
endaction=path_action_stop
spd="" //path pos is between 0 and 1 so
spd_px=""
offset=0
offset_delta=0  //peak selector action
relative=false
relative_pos[0]=""
relative_pos[1]=""
strong=false
ease=ease_none

track_badges=false
badges_list=noone
selected_list=noone
selected_list_len=0
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
//field pth: path
//field endaction: enum(path_action_restart,path_action_reverse,path_action_stop) - path_action_stop
//field spd: number(0,1) - If speed is 1 then it goes full cycle in 1 frame
//field spd_px: number - Alternative speed, measured in pixels per frame but might have small inaccuracy
//field offset: number(0,1) - Same rules as speed, 0 (and 1) is the first point of the path, middle of the path is 0.5
//field offset_delta: number(0,1) - Each instance chosen with selector will add given number to path offset
//field relative: false
    //field     relative_pos: xy - Places first point of path in specified point. If unset then instance pos will be used
//field strong: false - Will prevent interferences while value is changing
//field ease: enum(ease_none,ease_quad_in,ease_quad_out,ease_quad_inout,ease_exp_in,ease_exp_out,ease_exp_inout,ease_back_in,ease_back_out,ease_back_inout,ease_elastic_in,ease_elastic_out,ease_elastic_inout,ease_bounce_in,ease_bounce_out,ease_bounce_inout)
//field track_badges: false

if track_badges badges_list=ds_list_create()
selected_list=ds_map_create()
trigger_list_selected(inst,selected_list)
selected_list_len=ds_map_size(selected_list)
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
var cur_inst,last_inst,i; cur_inst=ds_map_find_first(selected_list) last_inst=ds_map_find_last(selected_list) i=0
while 1 {
    //place instance according to its path position
    var path_pos,path_ox,path_oy; path_pos=path_pos_value(offset+i*offset_delta,endaction)
    if relative {
        if string(relative_pos[0]) == "" {
            //first point of the path must be located where the instance is at
            path_ox=-path_get_x(pth,0)+cur_inst.x
            path_oy=-path_get_y(pth,0)+cur_inst.y
        }
        else {
            //relative_pos contains position, where the first point of the path should be
            path_ox=-path_get_x(pth,0)+relative_pos[0]
            path_oy=-path_get_y(pth,0)+relative_pos[1]
        }
    }
    else {
        //if absolute then use absolute position
        path_ox=0
        path_oy=0
    }
    cur_inst.x=path_get_x(pth,path_pos)+path_ox
    cur_inst.y=path_get_y(pth,path_pos)+path_oy
    //create badge
    var _o; _o=badge_create(cur_inst, BadgePath)
    _o.pth=pth
    _o.endaction=endaction
    _o.path_ox=path_ox
    _o.path_oy=path_oy
    if string(spd) == "" _o.spd=spd_px/path_get_length(pth)
    else _o.spd=spd
    _o.offset=path_pos
    _o.strong=strong
    _o.ease=ease
    if track_badges ds_list_add(badges_list, _o)

    if cur_inst==last_inst break
    else cur_inst=ds_map_find_next(selected_list,cur_inst)
    i+=1
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
