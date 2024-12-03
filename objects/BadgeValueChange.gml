#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///setup
inst=noone
var_name=""
value_start=""
value_end=""
value_stepsize=""
stop_when_reached=false
strong=false
ease=ease_none
time=0
max_time=""
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///do the thing
if instance_exists(inst) {
    x=inst.x
    y=inst.y
}
else {
    instance_destroy() exit
}
time += 1
if string(max_time) != "" if time >= max_time {
    instance_destroy() exit
}

var _value_new;
if strong {
    //calcualte new value by interpolating between start and end values
    if string(value_end) == "" {
        //stepsize * time
        _value_new = value_start + time * value_stepsize
    }
    else {
        //interpolate
        if value_end > value_start {
            step_size = abs(value_stepsize)
            value_min = value_start
            value_max = value_end
        }
        else {
            step_size = -abs(value_stepsize)
            value_min = value_end
            value_max = value_start
        }
        _value_new = clamp(value_start + time * step_size, value_min, value_max)
        if ease != ease_none _value_new = lerp(value_start, value_end, ease_value(unlerp(value_start, value_end, _value_new), ease))
        if _value_new == value_end and stop_when_reached instance_destroy()
    }
}
else {
    //calculate new value by approaching end value

    _value_new = execute_string("return inst." + var_name)
    if string(value_end) == "" {
        //simply add stepsize
        _value_new += value_stepsize
    }
    else {
        //aproach end value
        _value_new = approach(_value_new, value_end, value_stepsize)
        if _value_new == value_end and stop_when_reached instance_destroy()
    }
}
execute_string("inst." + var_name + " = " + string(_value_new))
