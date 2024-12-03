#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Spawns instance of indicated object, supports setting speed variables and code to execute on create
obj=noone
pos[0]=""
pos[1]=""
hsp=""
vsp=""
spd=""
dir=0
code=""

remember_spawned=false
spawned_list=noone
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Cleanup
if remember_spawned and spawned_list != noone ds_list_destroy(spawned_list)
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//field obj: object
//field remember_spawned: false - Allows despawning all spawned objects on receiving off signal
//field pos: xy
//field hsp: number
//field vsp: number
//field spd: number
    //field     dir: number
//field code: string


if remember_spawned spawned_list=ds_list_create()
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
///Spawn thing
var _o;
if string(pos[0])=="" _o=instance_create(x,y,obj)
else _o=instance_create(pos[0],pos[1],obj)
if string(spd)!="" {
    _o.speed=spd
    _o.direction=dir
}
else {
    if string(hsp)!="" _o.hspeed=hsp
    if string(vsp)!="" _o.vspeed=vsp
}
if code!="" execute_string("with "+string(_o)+" { "+code+" }")
if remember_spawned ds_list_add(spawned_list,_o)
#define Trigger_Trigger Off
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Despawn spawned things
if remember_spawned and spawned_list!=noone {
    var i, len; len=ds_list_size(spawned_list)
    for (i=0;i<len;i+=1) {
        instance_destroy_id(ds_list_find_value(spawned_list,i))
    }
    ds_list_clear(spawned_list)
}
