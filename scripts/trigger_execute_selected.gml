///trigger_execute_selected(inst, code)
var _inst,_code;
_inst=argument0
_code=argument1

switch (_inst.object_index) {
case SelectorMultiple:
    if (_inst.inst0 != noone) trigger_execute_selected(_inst.inst0, _code)
    if (_inst.inst1 != noone) trigger_execute_selected(_inst.inst1, _code)
    if (_inst.inst2 != noone) trigger_execute_selected(_inst.inst2, _code)
    if (_inst.inst3 != noone) trigger_execute_selected(_inst.inst3, _code)
    if (_inst.inst4 != noone) trigger_execute_selected(_inst.inst4, _code)
    if (_inst.inst5 != noone) trigger_execute_selected(_inst.inst5, _code)
    if (_inst.inst6 != noone) trigger_execute_selected(_inst.inst6, _code)
    if (_inst.inst7 != noone) trigger_execute_selected(_inst.inst7, _code)
    if (_inst.inst8 != noone) trigger_execute_selected(_inst.inst8, _code)
    if (_inst.inst9 != noone) trigger_execute_selected(_inst.inst9, _code)
    break
case SelectorArea:
    var rect_l, rect_t, rect_r, rect_b;
    if (_inst.manual_rect) {
        rect_l = _inst.manual_rect_lt[0]
        rect_t = _inst.manual_rect_lt[1]
        rect_r = _inst.manual_rect_rb[0]
        rect_b = _inst.manual_rect_rb[1]
    }
    else {
        rect_l = _inst.bbox_left
        rect_t = _inst.bbox_top
        rect_r = _inst.bbox_right
        rect_b = _inst.bbox_bottom
    }

    switch (_inst.filter_type) {
    case "none":
        with all if collision_rectangle(rect_l, rect_t, rect_r, rect_b, id, true, false) and id != other.id trigger_execute_selected(id, _code)
        break
    case "include":
        with _inst.filter_obj1 if collision_rectangle(rect_l, rect_t, rect_r, rect_b, id, true, false) and id != other.id trigger_execute_selected(id, _code)
        with _inst.filter_obj2 if collision_rectangle(rect_l, rect_t, rect_r, rect_b, id, true, false) and id != other.id trigger_execute_selected(id, _code)
        with _inst.filter_obj3 if collision_rectangle(rect_l, rect_t, rect_r, rect_b, id, true, false) and id != other.id trigger_execute_selected(id, _code)
        with _inst.filter_obj4 if collision_rectangle(rect_l, rect_t, rect_r, rect_b, id, true, false) and id != other.id trigger_execute_selected(id, _code)
        with _inst.filter_obj5 if collision_rectangle(rect_l, rect_t, rect_r, rect_b, id, true, false) and id != other.id trigger_execute_selected(id, _code)
        break
    case "exclude":
        with all if collision_rectangle(rect_l, rect_t, rect_r, rect_b, id, true, false) and id != other.id
            and object_index != _inst.filter_obj1
            and object_index != _inst.filter_obj2
            and object_index != _inst.filter_obj3
            and object_index != _inst.filter_obj4
            and object_index != _inst.filter_obj5
            trigger_execute_selected(id, _code)
        break
    }
    break
default:
    execute_string("with " + string(_inst.id) + " { " + _code + " }")
    break
}
