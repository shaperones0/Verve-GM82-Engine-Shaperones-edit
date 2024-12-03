#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Allows relaying action on multiple instances inside area, covered by this object or inside rectangle specified
filter_type="none"//"include","exclude"
tag=""
filter_obj1=noone
filter_obj2=noone
filter_obj3=noone
filter_obj4=noone
filter_obj5=noone
manual_rect=false
manual_rect_lt[0]=0
manual_rect_lt[1]=0
manual_rect_rb[0]=room_width
manual_rect_rb[1]=room_height
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//field tag: string - Set to only affect instances with specified __tag variable set
//field filter_type: enum("include","exclude") - none
    //field     filter_obj1: object
    //field     filter_obj2: object
    //field     filter_obj3: object
    //field     filter_obj4: object
    //field     filter_obj5: object
//field manual_rect: false
    //field     manual_rect_lt: xy - (0, 0)
    //field     manual_rect_rb: xy - (room_width, room_height)

/*preview
    if manual_rect {
        draw_set_alpha(1)
        draw_set_color(c_purple)
        draw_rectangle(manual_rect_lt[0], manual_rect_lt[1], manual_rect_rb[0], manual_rect_rb[1], 1)
        draw_line(bbox_left, bbox_top,      manual_rect_lt[0], manual_rect_lt[1])
        draw_line(bbox_left, bbox_bottom,   manual_rect_lt[0], manual_rect_rb[1])
        draw_line(bbox_right, bbox_top,     manual_rect_rb[0], manual_rect_lt[1])
        draw_line(bbox_right, bbox_bottom,  manual_rect_rb[0], manual_rect_rb[1])
        draw_reset()
    }
    draw_sprite(sprite_index, 0, x, y)
*/

//TODO remove 4 spaces thingie once benex fixes room editor
