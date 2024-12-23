#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Make sure only 1 World instance exists

if (instance_number(object_index) > 1) {
    instance_destroy()
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///increment global time

global.time += 1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///game hotkeys

// Pause game
if !global.paused {
    // Load game
    if input_check_pressed(key_restart) && is_in_game() {
        save_load()
        exit; // Prevent wacky behavior when pausing and restarting on the same frame.
    }

    if input_check_pressed(key_pause) if is_in_game() {
        _pause_surf = surface_get("pause_surf", global.game_width, global.game_height)
        surface_copy(_pause_surf, 0, 0, application_surface)

        surface_set_target(_pause_surf)
            draw_set_blend_mode(bm_add)
                draw_set_color(c_black)
                draw_rectangle(0, 0, global.game_width, global.game_height, false)
            draw_set_blend_mode(bm_normal)
        surface_reset_target()

        instance_deactivate_all(true)
        instance_activate_object(gm82core_object)
        instance_activate_object(__gm82dx9_controller)

        global.paused = true
    }
}
else {
    if input_check_pressed(key_menu_options) {
        if !instance_exists(Options) {
            with(instance_create(0, 0, Options)) {
                visible = false
            }
        }
        else {
            instance_destroy_id(Options)
        }
    }

    if input_check_pressed(key_pause) {
        instance_activate_all()
        instance_destroy_id(Options)
        global.paused = false
    }
}

// Close game
if keyboard_check_pressed(vk_escape) || global.close_button_pressed {
    if room == rInit || room == rTitle {
        game_end()
    }
    else {
        restart_game()
        global.close_button_pressed = false
    }
}

// Restart game
if keyboard_check_pressed(vk_f2) {
    restart_game()
}

// Fullscreen
if keyboard_check_pressed(vk_f4) || (keyboard_check(vk_alt) && keyboard_check_pressed(vk_return)) {
    config_set("fullscreen", !config_get("fullscreen"))
    window_set_fullscreen(config_get("fullscreen"))

    config_write()
}

// Reset window
if keyboard_check_pressed(vk_f5) {
    if !config_get("fullscreen") {
        window_set_rectangle(
            (display_get_width() - global.game_width) / 2,
            (display_get_height() - global.game_height) / 2,
            global.game_width,
            global.game_height,
        )
    }
}

// Mute music
if keyboard_check(vk_control) && keyboard_check_pressed(ord("M")) {
    if config_get("music_volume") > 0 {
        unmuted_music_volume = config_get("music_volume")
        config_set("music_volume", 0)
    }
    else {
        if unmuted_music_volume > 0 {
            config_set("music_volume", unmuted_music_volume)
        }
        else {
            config_set("music_volume", 15)
        }
    }
    audio_music_volume(config_get("music_volume") / 100)
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=408
applies_to=self
invert=0
arg0=is_in_game() && !global.paused
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=422
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///increment ingame time

if (!global.time_when_dead || instance_exists(Player)) && (global.time_when_clear || !save_get("clear")) {
    save_set_persistent("time", save_get("time") + 1 / room_speed)
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///debug hotkeys
var _target_room_name, _target_room;

if !global.debug || !is_in_game() {
    exit
}

if global.debug_key != noone if !keyboard_check(global.debug_key) {
    exit
}


if keyboard_check_pressed(vk_home) {
    global.debug_god_mode = !global.debug_god_mode
}

if keyboard_check_pressed(vk_end) {
    global.debug_infinite_jump = !global.debug_infinite_jump
}

if keyboard_check_pressed(vk_delete) {
    global.debug_show_mask = !global.debug_show_mask
}

if keyboard_check_pressed(vk_backspace) {
    global.debug_overlay = modwrap(global.debug_overlay + 1, 0, 3)
}

if keyboard_check_pressed(vk_insert) {
    save_save(true)
}

_target_room = noone
if keyboard_check_pressed(vk_pageup) {
    _target_room = room_next(room)
}

if keyboard_check_pressed(vk_pagedown) {
    _target_room = room_previous(room)
}

if keyboard_check_pressed(ord("W")) {
    _target_room_name = get_string("Enter target room name", "")
    _target_room = room_first
    while(room_exists(_target_room)) {
        if _target_room_name == room_get_name(_target_room) {
            break
        }
        _target_room = room_next(_target_room)
    }
}

if room_exists(_target_room) && is_in_game(_target_room) {
    instance_destroy_id(Player)
    room_goto(_target_room)
}

if keyboard_check(vk_tab) {
    with(Player) {
        x = mouse_x
        y = mouse_y
    }
    global.camera_skip_update = true
}

if keyboard_check_pressed(ord("G")) {
    player_flip()
}

if keyboard_check_pressed(ord("I")) {
    with(all) {
        visible = true
    }
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=424
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///update window caption

// Updates the window caption to show current deathtime.

var _caption;

_caption = global.game_title

if is_in_game() {
    _caption += str_cat(
        " - Deaths: ", save_get("deaths"),
        " - Time: ", get_formatted_time(save_get("time")),
    )
}

room_caption = _caption
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///render update

// Appropriately resizes the window buffer, allowing for smoothing.

var _target_width, _target_height;

if config_get("smoothing") {
    _target_width = window_get_width()
    _target_height = window_get_height()
}
else {
    _target_width = global.game_width
    _target_height = global.game_height
}

if global.render_width != _target_width || global.render_height != _target_height {
    global.render_width = _target_width
    global.render_height = _target_height
    window_resize_buffer(global.render_width, global.render_height, 1, 0)
}
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
action_id=601
applies_to=self
invert=0
arg0=engine_settings
arg1=0
arg2=0
arg3=0
arg4=0
arg5=0
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///cwd init

if global.debug {
    //change here to save in local folder
    //global.dir_cwd=directory_previous(working_directory)
    global.dir_cwd=directory_previous(directory_previous(directory_previous(temp_directory)))+"Roaming\"+filename_valid(global.game_title)
}
else {
    //global.dir_cwd=working_directory
    global.dir_cwd=directory_previous(directory_previous(directory_previous(temp_directory)))+"Roaming\"+filename_valid(global.game_title)
}

global.dir_save=global.dir_cwd+"\"+global.save_folder // DOES end with backslash

directory_create(global.dir_save)
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///save init

// Actual save files also include the save file index, e.g. save0.
global.save_file = global.dir_save + "save"
global.save_current_file = ""

// Map holding the current saveable data.
global.save_map = ds_map_create()

// Map holding the current *saved* data. When you load the game, the save_map gets set from this one.
global.save_persistent_map = noone

// The current save index. Currently, a couple places expect this to be only 0, 1, or 2.
global.save_current = 0

// A map holding the persistent save maps for each save file, instead of reading them from disk each time.
global.save_file_map = ds_map_create()

// Used when you want to save as soon as the player object exists.
global.save_autosave = false

save_read()
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///config init

// Initializes data holding the game options, here is where you set their default values as well.

// Stores the config data.
global.config_map = ds_map_create()
global.config_file = global.dir_save + "config"

// Stores every option, initialized in the following script.
global.options_list = ds_list_create()
option_list()

show_volume_check = true
config_read()

// Default option values. Not strictly necessary for options that start at 0/false.
config_default("music_volume", 15)
config_default("sound_volume", 25)
config_default("fullscreen", false)
config_default("smoothing", false)

// Apply the saved options.
window_set_fullscreen(config_get("fullscreen"))
audio_music_volume(config_get("music_volume") / 100)
audio_sound_volume(config_get("sound_volume") / 100)
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///input init

// Sets up all the data necessary to allow for rebinds.
// This script also holds all the default values.
// The key constants are defined in the project's Used-Defined Constants window.

global.input_keyboard_file = global.dir_save + "keyboard"

// Stores the current keybinds.
global.input_keyboard_map = ds_map_create()

// Stores the original keybinds so the player can reset to default.
global.input_keyboard_default_map = ds_map_create()

// Stores the name of each input to be shown on the rebind screen.
global.input_name_map = ds_map_create()

// Stores which inputs are rebindable.
global.input_rebindable_list = ds_list_create()

input_read()

// Rebindable inputs
input_define(key_left,    "Left Button",    vk_left,  true)
input_define(key_right,   "Right Button",   vk_right, true)
input_define(key_up,      "Up Button",      vk_up,    true)
input_define(key_down,    "Down Button",    vk_down,  true)
input_define(key_jump,    "Jump Button",    vk_shift, true)
input_define(key_shoot,   "Shoot Button",   ord("Z"), true)
input_define(key_restart, "Restart Button", ord("R"), true)
input_define(key_skip,    "Skip Button",    ord("S"), true)
input_define(key_suicide, "Suicide Button", ord("Q"), true)
input_define(key_pause,   "Pause Button",   ord("P"), true)

// Unbindable inputs, hence no need for a name.
input_define(key_menu_left,    "", vk_left,  false)
input_define(key_menu_right,   "", vk_right, false)
input_define(key_menu_up,      "", vk_up,    false)
input_define(key_menu_down,    "", vk_down,  false)
input_define(key_menu_accept,  "", vk_shift, false)
input_define(key_menu_back,    "", ord("Z"), false)
input_define(key_menu_options, "", vk_enter, false)
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///audio init
//Initializes audio stuff and balancing
global.current_music_cidx = 0

audio_global_volume(global.audio_gain)
audio_music_loop(true)

global.audio_vol_list[musGuyRock] = 0.8

global.audio_vol_list[sndBlockChange] = 0.8
global.audio_vol_list[sndItem] = 1
global.audio_vol_list[sndPlayerAirJump] = 0.7
global.audio_vol_list[sndPlayerDeath] = 0.7
global.audio_vol_list[sndPlayerGroundJump] = 0.7
global.audio_vol_list[sndPlayerShoot] = 0.5
global.audio_vol_list[sndPlayerWallJump] = 0.5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///camera init

camera_default()

global.camera_x = 0
global.camera_y = 0
global.camera_target_x = 0
global.camera_target_y = 0

global.camera_skip_update = false
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///render init

// The render functions allow for fullscreen smoothing and Draw GUI-like behavior.

global.render_width = window_get_width()
global.render_height = window_get_height()
window_resize_buffer(global.render_width, global.render_height, 1, 0)

application_surface_enable(render_compose)
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///global game variables

global.grav=1
global.room_prev=noone
global.close_button_pressed=false
global.time=0
global.paused=false

//debug variables
global.debug_god_mode=false
global.debug_infinite_jump=false
global.debug_show_mask=false
global.debug_overlay=0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///FIXME unmuted_music_volume

unmuted_music_volume=config_get("music_volume")
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///set room views

// Sets up the same view for each room.

var r, _width, _height;

_width = global.game_width
_height = global.game_height

for (r = room_first; r != -1; r = room_next(r)) {
    room_set_view_enabled(r, true)
    room_set_view(r, 0, true, 0, 0, _width, _height, 0, 0, _width, _height, 0, 0, 0, 0, noone)
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///gm82live setup

if global.debug {
    live_roomeditor_start()
    live_roomeditor_add_obj_exclusion(PlayerStart)
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///proceed to next room
if !show_volume_check {
    room_goto_next()
}
else {
    instance_create(0,0,VolumeCheck)
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///room speed and clear io

room_speed = global.game_speed
// Set this every room start, then set it to true ahead of every transition
// that needs to clear input. (see engine_settings)
io_set_roomend_clear(false)
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///audio

//Sets room music, preload needed sounds and setup crossfade with global.room_prev

switch(room) {
    case rTitle:
    case rMenu:
    case rOptions:
        custom_music_play(musGuyRock)
        break

    default:
        custom_sound_stop_all()
        custom_music_play(0)
        break
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///cement blocks

// Stitches together Block instances into fewer, larger, instances for performance optimization.

var _coll;

repeat(global.optimize_solids) {
    with(Block) {
        if object_index != Block {
            continue
        }
        coll = instance_place(x + 1, y, Block)
        if coll if
                bbox_right < coll.bbox_left &&
                sign(image_xscale) == sign(coll.image_xscale) &&
                y == coll.y &&
                image_yscale == coll.image_yscale &&
                coll.object_index = Block {
            image_xscale += coll.image_xscale
            instance_destroy_id(coll)
        }
    }
    with(Block) {
        if object_index != Block {
            continue
        }
        coll = instance_place(x, y + 1, Block)
        if coll if
                bbox_bottom < coll.bbox_top &&
                sign(image_yscale) == sign(coll.image_yscale) &&
                x == coll.x &&
                image_xscale == coll.image_xscale &&
                coll.object_index == Block {
            image_yscale += coll.image_yscale
            instance_destroy_id(coll)
        }
    }
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///camera room setup

camera_default()
camera_update()
camera_snap()
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///update previous room variable
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
///draw pause screen

if global.paused {
    d3d_set_projection_ortho(0, 0, global.game_width, global.game_height, 0)

    _pause_surf = surface_get("pause_surf", global.game_width, global.game_height)
    draw_surface(_pause_surf, 0, 0)

    draw_set_color(c_black)
    draw_set_alpha(0.5)
        draw_rectangle(0, 0, global.game_width, global.game_height, false)
    draw_set_alpha(1)

    if !instance_exists(Options) {
        draw_set_halign(fa_middle)
        draw_set_valign(fa_middle)
        draw_set_font(fDefaultLarge)

        draw_text_outlined(global.game_width / 2, global.game_height / 2, "PAUSE", c_white, c_black, 2)

        draw_set_font(fDefaultSmall)
        draw_text_outlined(400, 556, str_cat("[", key_get_name(input_get_key(key_menu_options)), "] Options"), c_white, c_black)

        draw_set_font(fDefaultMedium)
        draw_set_halign(fa_left)

        draw_text_outlined(20, 541, str_cat("Deaths: ", save_get("deaths")), c_white, c_black)
        draw_text_outlined(20, 566, str_cat("Time: ", get_formatted_time(save_get("time"))), c_white, c_black)
    }
    else with(Options) {
        event_perform(ev_draw, 0)
    }

    d3d_set_projection_default()
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
