///path_pos_value(value, path_endaction)
var _value, _endaction;
_value=argument0
_endaction=argument1

switch _endaction {
case path_action_restart:
    return _value-floor(_value)
case path_action_reverse:
    var _f;_f=floor(_value)
    if f mod 2 == 0 return _value-_f
    else return _f+1-_value
case path_action_stop:
    return saturate(_value)
}
