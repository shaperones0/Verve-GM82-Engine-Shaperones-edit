#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Make sure only 1 World instance exists

// Other World create code goes to event_world_game_start() instead.

if (instance_number(object_index) > 1) {
    instance_destroy()
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///world step event

var _pause_surf;

game_hotkeys()

if is_in_game() && !global.paused {
    if (!global.time_when_dead || instance_exists(Player)) && (global.time_when_clear || !save_get("clear")) {
        save_set_persistent("time", save_get("time") + 1 / room_speed)
    }

    debug_hotkeys()
}

update_window_caption()
render_update()
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///world end step

if is_in_game() && !global.paused {
    camera_update()
}
#define Other_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///game start
var _object;

engine_settings()

if (global.debug) {
    global.dir_cwd = directory_previous(working_directory)
}
else {
    global.dir_cwd = working_directory
}

global.dir_data = global.dir_cwd + "\data"          // doesn't end with backslash
global.dir_sounds = global.dir_data + "\sounds"     // doesn't end with backslash
global.dir_music = global.dir_data + "\music"       // doesn't end with backslash
global.dir_save = global.dir_cwd + "\" + global.save_folder // DOES end with backslash

directory_create(global.dir_save)

save_init()
config_init()
input_init()
audio_init()
camera_init()
render_init()

global.grav = 1
global.room_prev = noone
global.close_button_pressed = false

global.debug_god_mode = false
global.debug_infinite_jump = false
global.debug_show_mask = false
global.debug_overlay = 0

global.paused = false

unmuted_music_volume = config_get("music_volume")

set_room_views()

if global.debug {
    live_roomeditor_start()
    live_roomeditor_add_obj_exclusion(PlayerStart)
}

if !show_volume_check {
    room_goto_next()
}
else {
    instance_create(0, 0, VolumeCheck)
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///room start
room_speed = global.game_speed
// TODO: add stop all sounds here
audio_room_start()

//ds_map_clear(global.trigger_map)

// Set this every room start, then set it to true ahead of every transition
// that needs to clear input. (see engine_settings)
io_set_roomend_clear(false)

cement_blocks()

camera_default()
camera_update()
camera_snap()
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///room end

// Update previous room
global.room_prev = room
#define Other_30
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.close_button_pressed = true
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Draw pause screen

if global.paused {
    draw_pause_screen()
}
#define Trigger_Draw GUI
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Draw debug overlay
var _text, _player_x, _player_y, _player_align;

if is_in_game && global.debug_overlay > 0 {
    _text = ""

    _player_x = "-"
    _player_y = "-"
    _player_align = "-"
    if instance_exists(Player) {
        _player_x = Player.x
        _player_y = Player.y
        _player_align = Player.x mod 3
    }

    _text += str_cat("X: ", _player_x, " [", _player_align , "]", lf)
    _text += str_cat("Y: ", _player_y, lf)
    _text += str_cat("Room: ", room_get_name(room), " (", room, ")", lf)
    _text += str_cat("FPS: ", fps, lf)
    _text += lf

    if global.debug_overlay == 1 {
        _text += "Toggle again to show debug keys."
    }
    else {
        _text += str_cat("Hold ", key_get_name(global.debug_key), " to use debug keys", lf)
        _text += "[Home] - God mode" + lf
        _text += "[End] - Infinite jump" + lf
        _text += "[Insert] - Save" + lf
        _text += "[PageUp] - Next room" + lf
        _text += "[PageDown] - Previous room" + lf
        _text += "[Delete] - Show mask" + lf
        _text += "[Tab] - Warp to cursor" + lf
        _text += "[W] - Warp to room by name" + lf
        _text += "[G] - Flip gravity" + lf
        _text += "[I] - Show invisible objects" + lf
    }

    draw_set_halign(fa_left)
    draw_set_valign(fa_top)
    draw_set_font(fDefaultSmall)
    draw_text_outlined(16, 16, _text, c_white, c_black)
}
