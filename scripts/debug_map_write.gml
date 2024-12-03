///debug_map_write(map)
var _map,_str,_key_cur,_key_last,_value;_map = argument0

_str=""

_key_cur=ds_map_find_first(_map)
_key_last=ds_map_find_last(_map)

while (true) {
    _value=ds_map_find_value(_map,_key_cur)
    _str+=string(_key_cur)+"="+string(_value)+"#"

    if _key_cur==_key_last break
    else _key_cur=ds_map_find_next(_map, _key_cur)
}
return _str
