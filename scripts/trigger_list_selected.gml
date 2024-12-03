///trigger_list_selected(inst, list)
var _inst,_list;
_inst=argument0
_list=argument1

switch (_inst.object_index) {
case SelectorMultiple:
    if (_inst.inst0 != noone) trigger_list_selected(_inst.inst0,_list)
    if (_inst.inst1 != noone) trigger_list_selected(_inst.inst1,_list)
    if (_inst.inst2 != noone) trigger_list_selected(_inst.inst2,_list)
    if (_inst.inst3 != noone) trigger_list_selected(_inst.inst3,_list)
    if (_inst.inst4 != noone) trigger_list_selected(_inst.inst4,_list)
    if (_inst.inst5 != noone) trigger_list_selected(_inst.inst5,_list)
    if (_inst.inst6 != noone) trigger_list_selected(_inst.inst6,_list)
    if (_inst.inst7 != noone) trigger_list_selected(_inst.inst7,_list)
    if (_inst.inst8 != noone) trigger_list_selected(_inst.inst8,_list)
    if (_inst.inst9 != noone) trigger_list_selected(_inst.inst9,_list)
    break
case SelectorArea:
    var rect_l, rect_t, rect_r, rect_b;
    if (_inst.manual_rect) {
        rect_l = _inst.manual_rect_lt[0]
        rect_t = _inst.manual_rect_lt[1]
        rect_r = _inst.manual_rect_rb[0]-1
        rect_b = _inst.manual_rect_rb[1]-1
    }
    else {
        rect_l = _inst.bbox_left
        rect_t = _inst.bbox_top
        rect_r = _inst.bbox_right
        rect_b = _inst.bbox_bottom
    }

    switch (_inst.filter_type) {
    case "none":
        with all if collision_rectangle(rect_l, rect_t, rect_r, rect_b, id, true, false) and id != other.id and tag_match(_inst.tag) trigger_list_selected(id,_list)
        break
    case "include":
        with _inst.filter_obj1 if collision_rectangle(rect_l, rect_t, rect_r, rect_b, id, true, false) and id != other.id and tag_match(_inst.tag) trigger_list_selected(id,_list)
        with _inst.filter_obj2 if collision_rectangle(rect_l, rect_t, rect_r, rect_b, id, true, false) and id != other.id and tag_match(_inst.tag) trigger_list_selected(id,_list)
        with _inst.filter_obj3 if collision_rectangle(rect_l, rect_t, rect_r, rect_b, id, true, false) and id != other.id and tag_match(_inst.tag) trigger_list_selected(id,_list)
        with _inst.filter_obj4 if collision_rectangle(rect_l, rect_t, rect_r, rect_b, id, true, false) and id != other.id and tag_match(_inst.tag) trigger_list_selected(id,_list)
        with _inst.filter_obj5 if collision_rectangle(rect_l, rect_t, rect_r, rect_b, id, true, false) and id != other.id and tag_match(_inst.tag) trigger_list_selected(id,_list)
        break
    case "exclude":
        with all if collision_rectangle(rect_l, rect_t, rect_r, rect_b, id, true, false) and id != other.id and tag_match(_inst.tag)
            and object_index != _inst.filter_obj1
            and object_index != _inst.filter_obj2
            and object_index != _inst.filter_obj3
            and object_index != _inst.filter_obj4
            and object_index != _inst.filter_obj5
            trigger_list_selected(id,_list)
        break
    }
    break
default:
    ds_map_add(_list,_inst,0)
    break
}
