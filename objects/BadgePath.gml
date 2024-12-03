#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///setup
inst=noone
pth=noone
endaction=path_action_stop
spd=0 //path pos is between 0 and 1 so
offset=0
path_ox=0
path_oy=0
strong=false
ease=ease_none
time=0
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
time+=1

if strong {
    //assign new path position
    var new_path_pos; new_path_pos=ease_value(path_pos_value(offset+spd*time, endaction), ease)
    inst.x=path_get_x(pth,new_path_pos)+path_ox
    inst.y=path_get_y(pth,new_path_pos)+path_oy
}
else {
    //add needed motion
    var new_path_pos, old_path_pos;
    old_path_pos=ease_value(path_pos_value(offset+spd*(time-1), endaction), ease)
    new_path_pos=ease_value(path_pos_value(offset+spd*time, endaction), ease)
    inst.x+=path_get_x(pth,new_path_pos)-path_get_x(pth,old_path_pos)
    inst.y+=path_get_y(pth,new_path_pos)-path_get_y(pth,old_path_pos)
}
