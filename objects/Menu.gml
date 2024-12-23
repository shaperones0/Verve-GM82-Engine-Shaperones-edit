#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
file_count = 3
file_first_x = 96
file_x_separation = 240
file_y = 160

current_file = 0
current_difficulty = 0
current_overwrite = 0

state_not_selected = 0
state_difficulty = 1
state_overwrite = 2
state = state_not_selected

animation_timer = 0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var _h_input;

save_select(current_file)
_h_input = input_check_pressed(key_menu_right) - input_check_pressed(key_menu_left)

// Selecting a save file
if state == state_not_selected {
    if _h_input != 0 {
        current_file = modwrap(current_file + _h_input, 0, file_count)
        custom_sound_play(sndPlayerGroundJump)
    }
    save_select(current_file)

    if input_check_pressed(key_menu_accept) {
        custom_sound_play(sndPlayerAirJump)
        state = state_difficulty
        if save_get("exists") {
            current_difficulty = -1
        }
        else {
            current_difficulty = 0
        }
    }
    else if input_check_pressed(key_menu_back) {
        room_goto(rTitle)
    }
}

// Selecting a difficulty
else if state == state_difficulty {
    current_difficulty = modwrap(current_difficulty + _h_input, ternary(save_get("exists"), -1, 0), global.difficulty_count)
    if _h_input != 0 {
        custom_sound_play(sndPlayerGroundJump)
    }

    if input_check_pressed(key_menu_accept) {
        if current_difficulty == -1 {
            save_load()
        }
        else {
            if save_get("exists") {
                current_overwrite = 1
                state = state_overwrite
                custom_sound_play(sndPlayerGroundJump)
            }
            else {
                save_new_game(current_difficulty)
            }
        }
    }
    else if input_check_pressed(key_menu_back) {
        state = state_not_selected
    }
}

// Confirming overwrite
else if state == state_overwrite {
    current_overwrite = modwrap(current_overwrite + _h_input, 0, 2)
    if _h_input != 0 {
        custom_sound_play(sndPlayerGroundJump)
    }

    if input_check_pressed(key_menu_accept) {
        if current_overwrite == 0 {
            state = state_difficulty
        }
        else {
            save_new_game(current_difficulty)
        }
    }
    else if input_check_pressed(key_menu_back) {
        state = state_difficulty
    }
}

if input_check_pressed(key_menu_options) {
    room_goto(rOptions)
}

animation_timer += 1
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var j;

for(j = 0; j < file_count; j += 1) {
    //draw savefile itself
    var i, _index, xx, yy, _selected, _top_text;

    _index = j
    xx = file_first_x + j * file_x_separation
    yy = file_y
    _selected = (current_file == _index)

    save_select(_index)

    draw_set_halign(fa_middle)
    draw_set_valign(fa_top)
    draw_set_color(c_black)
    draw_set_font(fDefaultLarge)
    draw_text_outlined(xx + 64, yy, str_cat("Save ", _index + 1), c_white, c_black)

    draw_set_font(fDefaultSmall)

    if !_selected || state == state_not_selected {
        if save_get("exists") {
            _top_text = global.difficulty_names[save_get("difficulty") + 1]

            draw_set_halign(fa_left)
            draw_text_outlined(xx + 8, yy + 70, str_cat("Deaths: ", save_get("deaths")), c_white, c_black)
            draw_text_outlined(xx + 8, yy + 90, str_cat("Time: ", get_formatted_time(save_get("time"))), c_white, c_black)
        }
        else {
            _top_text = "No Data"
        }
    }
    else {
        if state == state_difficulty {
            _top_text = str_cat("< ", global.difficulty_names[current_difficulty + 1], " >")
        }
        else if state == state_overwrite {
            draw_text_outlined(xx + 64, yy - 100, "Are you sure" + lf + "you want to" + lf + "overwrite this save?", c_white, c_black)
            _top_text = ternary(current_overwrite == 1, "< Yes >", "< No >")
        }
    }
    draw_set_halign(fa_middle)
    draw_text_outlined(xx + 64, yy + 49, _top_text, c_white, c_black)

    for(i = 0; i < 4; i += 1) {
        if save_get(str_cat("item", i)) {
            draw_sprite(sprItem, 0, xx + 32 * i, yy + 128)
        }
        if save_get(str_cat("boss_item", i)) {
            draw_sprite(sprBossItem, 0, xx + 32 * i, yy + 160)
        }
    }

    if save_get("clear") {
        draw_set_font(fDefaultBig)
        draw_text_outlined(xx + 65, yy + 215, "Clear!", c_white, c_black)
    }

    if _selected {
        // Draw selection "cursor".
        for(i = 0; i < 7; i += 1) {
            if i == 3 {
                continue
            }
            draw_sprite(sprCherry, animation_timer / 15, xx + 5 + 20 * i, yy + 310)
        }
        draw_sprite(sprPlayerIdle, animation_timer / 5, xx + 66, yy + 312)
    }

}

//draw navigation
var _accept_button, _back_button, _options_button;

_accept_button = key_get_name(input_get_key(key_menu_accept))
_back_button = key_get_name(input_get_key(key_menu_back))
_options_button = key_get_name(input_get_key(key_menu_options))

draw_set_valign(fa_bottom)
draw_set_font(fDefaultSmall)

draw_set_halign(fa_left)
draw_text_outlined(42, global.game_height - 40, str_cat("[", _back_button, "] Back"), c_white, c_black)
draw_set_halign(fa_right)
draw_text_outlined(global.game_width - 42, global.game_height - 40, str_cat("[", _accept_button, "] Accept"), c_white, c_black)

if true {
    draw_set_halign(fa_middle)
    draw_text_outlined(global.game_width / 2, global.game_height - 40, str_cat("[", _options_button, "] Options"), c_white, c_black)
}

draw_reset()
