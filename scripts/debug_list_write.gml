///debug_list_write(list)

var _list,_str,_i,_len;_list=argument0

_str=""

_i=0
_len = ds_list_size(_list)
for (_i=0;_i<_len;_i+=1) {
    _str+=string(ds_list_find_value(_list,_i))+"#"
}
return _str
