#macro VERSION "<= 9944 final 5"
#define init
scr = {};

var _scripts = [
	"option_set", "option_get", "option_defget",
	
	"option_set_fake_nonsync", "option_get_fake_nonsync", "option_defget_fake_nonsync",
	
	"option_set_field", "option_get_field", "option_defget_field",
	
	"option_add", "option_add_page", "option_remove", "option_remove_ext", "option_remove_page", "option_remove_page_ext", "option_remove_category", "option_remove_mod",
	
	"options_refresh"
];

var _type = mod_current_type;
var _name = mod_current;

with(_scripts){
	lq_set(scr, self, [_type, _name, self]);
}

/*
if (fork()){
	while (!mod_script_exists("mod", "options", "scr_import")){
		wait(0);
	}
	
	if (mod_script_exists("mod", "options", "scr_import")){
		mod_script_call_nc("mod", "options", "scr_import", script_ref_create(0));
	}
	
	exit;
}

#macro scr global.scr
#macro call script_ref_call
*/

global.menu_stuff = {
	"view_settings": false, "settings_page": [], "page_index": 0, "selected": [], "pressed": [], "side": [], "surface": -1, "surface_text": "", "page_surface": -1, "page_surface_text": "", "last_page_index": 0, "splat": noone, "sub_splats": [], "tooltips": [], "timer": [], "last_settings_page": [], "page_side": -2
};

for (var p = maxp - 1; 0 <= p; p --){
	global.menu_stuff.settings_page[p] = [0, -1];
	global.menu_stuff.last_settings_page[p] = 0;
	global.menu_stuff.selected[p] = -1;
	global.menu_stuff.pressed[p] = false;
	global.menu_stuff.side[p] = 0;
	global.menu_stuff.sub_splats[p] = noone;
	global.menu_stuff.tooltips[p] = [];
	global.menu_stuff.timer[p] = 0;
}

global.options = {};

global.objects = [];

global.export_to = [];

var _persist = instances_matching(CustomObject, CONTROLLER, `${mod_current}.${mod_current_type}`);

if (array_length(_persist)){
	var _restored = false;
	
	with(_persist){
		if (!_restored){
			_restored = true;
			
			with(export_to){
				scr_import(self);
			}
			
			global.character_sets = recursive_restore(character_sets);
			global.cleaned_strings = recursive_restore(cleaned_strings);
			
			global.menu_stuff = lq_merge(global.menu_stuff, menu_stuff, true);
			global.options = lq_merge(global.options, options, true);
			global.objects = objects;
		}
		
		instance_delete(self);
	}
}

else{
	global.character_sets = ds_map_create();
	global.cleaned_strings = ds_map_create();
}

global.options_icon = sprite_add_base64("iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAB3SURBVDhPpY7RDYAgDERdxAWcwMQf1mAs/93JkbR6pLZNz0i8vA+g94BhKbWLSxin+SNUOO6EQ8EJtsTWicCSCNZZt11oG/O3XJAqtupo4REwkGgbhHd+CAADdbSthVyQSDXcDZzQhiRUeF87wWJLFiowmtBBqSfc1U5QWvARqAAAAABJRU5ErkJgggAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==", 1, 8, 8);
global.options_slider = sprite_add_base64("iVBORw0KGgoAAAANSUhEUgAAAOAAAAATCAYAAACJKwFWAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAFWSURBVHhe7ZYBjsMgDATz/y/kX/lOT0hYcn1LMLSkGHakkSqKTS5r1DsqvIyC/lzC1npqBFTb4miePItsiHfA9D5kCbT3U72gWuto0JkeBbRGFkQH3aoGfU/bFErrJDg2WPpbyUagAaDzOpTzPF/J67o+Vnpp8zFVUG2r6Jl6RL2t+bG70OHSGDaRBgQNllgaIlmv1feq+4v56DdQbQRLf49GAqVxrHIXflq3gzKrcimtaO+spufNrx6ig6Vz2020oV1JXsA1FNDaPyL+UqygvHcxx1FFh0rnNIHWbkFDQp/VcxFtsHQ+m0iho2Ggz8sLuKZdyL9GaFDoGPOrL2KDpXG85VuXTfq0inp5Rf28on5eUT8kqkWmvTmOIjZUGkMyEHSZrPZSWnOrKjZYOrdkQVDQdD7JJqDw6XySDUGD8GvvQPtb9YJqR0s2J+pQoOf2SMiXOI4/gQxK+N+yMEQAAAAASUVORK5CYII=", 2, 1, 6);

with(["mod", "weapon", "race", "skill", "crown", "area", "skin"]){
	with(mod_get_names(self)){
		if (mod_script_exists(other, self, "CustomOptions_init")){
			mod_script_call_nc(other, self, "CustomOptions_init");
		}
	}
}

chat_comp_add("custom-options", "Open the options menu (character select only)");
chat_comp_add("custom-options-update", "Check for updates");

#define cleanup
with(instance_create(0, 0, CustomObject)){
	variable_instance_set(self, CONTROLLER, `${mod_current}.${mod_current_type}`);
	name = "OptionCont";
	persistent = true;
	
	export_to = global.export_to;
	
	character_sets = recursive_cleanup(global.character_sets);
	cleaned_strings = recursive_cleanup(global.cleaned_strings);
	
	menu_stuff = global.menu_stuff;
	options = global.options;
	objects = global.objects;
}

surface_free(global.menu_stuff.surface);
surface_free(global.menu_stuff.page_surface);

sprite_delete(global.options_icon);
sprite_delete(global.options_slider);

#macro sprOptionSlider_bbox [[0, 0, 111, 18, 55, 9], [6, 4, 105, 13, 55, 8]]
#macro sprSliderEnd_bbox [[0, 0, 7, 16, 3, 8]]
#macro sprScoreSplat_bbox [[2, 11, 21, 16, 11, 13], [1, 2, 65, 21, 33, 11], [1, 1, 68, 21, 34, 11]]

#macro sprDailyArrow_xoffset 53
#macro sprDailyArrow_yoffset 9
#macro sprDailyArrow_bbox [[44, 0, 61, 17, 52, 8], [44, 0, 61, 17, 52, 8], [0, 0, 106, 17, 53, 8], [24, 0, 81, 16, 52, 8]]

#macro CONTROLLER `${mod_current}.${mod_current_type} controller`

#macro mod_current_type script_ref_create(0)[0]

#macro scr global.scr
#macro call script_ref_call

#macro OPTION_SPLAT_DEPTH ("depth" in Menu ? Menu.depth : object_get_depth(OptionMenuButton)) + 1
#macro OPTION_DEPTH ("depth" in Menu ? Menu.depth : object_get_depth(OptionMenuButton)) - 1

#macro SINGLE_CHAR_WIDTH 24
#macro SINGLE_CHAR_HEIGHT 32

#macro SURFACE_SCALE 0.65
#macro BUTTON_POS_Y (game_height >> 1) - 24 * ((instance_number(OptionMenuButton) >> 1) - 1)

#macro LINE_SPACING 6

#macro DEBUG_LAG false

#macro ds_type_list 0
#macro ds_type_map 1
#macro ds_type_grid 2

#define scr_import
/// scr_import(_ref, _overwrite = false)
var _ref = argument[0];
var _overwrite = argument_count > 1 ? argument[1] : false;
var _lq = {};

var script_count = lq_size(scr);

for (var i = 0; script_count > i; i ++){
	var _array = lq_get_value(scr, i);
	
	if (_array[0] == mod_current_type && _array[1] == mod_current){
		lq_set(_lq, lq_get_key(scr, i), array_clone(_array));
	}
}

array_push(global.export_to, array_slice(_ref, 0, 2));

if (!is_object(mod_variable_get(_ref[0], _ref[1], "scr"))){
	mod_variable_set(_ref[0], _ref[1], "scr", _lq);
}

else{
	var _mod = mod_variable_get(_ref[0], _ref[1], "scr");
	
	for (var i = 0; script_count > i; i ++){
		var _key = lq_get_key(_lq, i);
		
		if (_overwrite || !lq_exists(_mod, _key)){
			lq_set(_mod, _key, lq_get_value(_lq, i));
		}
	}
}

#define chat_command(_cmd, _arg, _p)
switch(string_lower(_cmd)){
	case "custom-options":{
		// EZ-PZ copy & paste
		if (instance_exists(Menu) && instance_exists(Loadout)){
			with(instances_matching(CustomDraw, "script", script_ref_create(draw_pause))){
				instance_destroy();
			}
			
			script_bind_draw(draw_pause, OPTION_DEPTH);
			sound_play(sndClick);
		}
		
		return true;
	}
	
	case "custom-options-update":{
		file_download(`https://itch.io/api/1/x/wharf/latest?target=gimmick/custom-options&channel_name=9944-final`, "custom options version.json");
		
		if (fork()){
			var _timeout = 3600;
			
			while (!file_loaded("custom options version.json")){
				wait(1);
				
				if (--_timeout < 0){
					trace("Custom Options version check failed: no response within two minutes");
					exit;
				}
			}
			
			var _contents = string_load("custom options version.json");
			
			file_unload("custom options version.json");
			
			if (is_undefined(_contents)){
				trace("Custom Options version check failed: no online version available");
				exit;
			}
			
			var _json = json_decode(_contents);
			
			if (_json == json_error){
				trace(json_error_text);
				trace("Custom Options version check failed: invalid JSON");
				exit;
			}
			
			else if ("errors" in _json){
				var error_count = array_length(_json.errors);
				
				for (var i = 0; error_count > i; i ++){
					trace_color(`ERROR: Custom Options version check:${chr(10)}    ${_json.errors[i]}`, c_orange);
				}
			}
			
			else if (_json.latest != VERSION){
				trace(`Custom Options update available! (version "${VERSION}" -> version "${_json.latest}")`);
			}
			
			else{
				trace("Custom Options is up to date!");
			}
			
			exit;
		}
		
		return true;
	}
}

#define step


/*
Sets the value of an option.
Equivalent to doing lq_set(mod_variable_get(mod_type, mod_name, mod_var), option_name, _value);
*/
#define option_set(mod_type, mod_name, mod_var, option_name, _value)
var _lq = mod_variable_get(mod_type, mod_name, mod_var);

if (is_undefined(_lq)){
	_lq = {};
	mod_variable_set(mod_type, mod_name, mod_var, _lq);
}

if (is_object(_lq)){
	lq_set(_lq, option_name, _value);
	return _value;
}

return null;

/*
Gets the value of an option.
Equivalent to doing =lq_get(mod_variable_get(mod_type, mod_name, mod_var), option_name);
*/
#define option_get(mod_type, mod_name, mod_var, option_name)
var _lq = mod_variable_get(mod_type, mod_name, mod_var);

if (is_object(_lq)){
	return lq_get(_lq, option_name);
}

return null;

/*
Gets the value of an option, with a default value.
Equivalent to doing =lq_defget(mod_variable_get(mod_type, mod_name, mod_var), option_name, def_value);
*/
#define option_defget(mod_type, mod_name, mod_var, option_name, def_value)
var _lq = mod_variable_get(mod_type, mod_name, mod_var);
return lq_defget(_lq, option_name, def_value);

/*
Sets the value of a fake nonsync option.
Equivalent to doing lq_get(mod_variable_get(mod_type, mod_name, mod_var), option_name)[_player] = _value;
*/
#define option_set_fake_nonsync(mod_type, mod_name, mod_var, _player, option_name, _value)
var _lq = mod_variable_get(mod_type, mod_name, mod_var);

if (is_undefined(_lq)){
	_lq = {};
	mod_variable_set(mod_type, mod_name, mod_var, _lq);
}

if (is_object(_lq)){
	var _array = lq_get(_lq, option_name);
	
	if (is_array(_array)){
		_array[_player] = _value;
		return _value;
	}
}

return null;

/*
Gets the value of a fake nonsync option.
Equivalent to doing =lq_get(mod_variable_get(mod_type, mod_name, mod_var), option_name)[_player];
*/
#define option_get_fake_nonsync(mod_type, mod_name, mod_var, _player, option_name)
var _lq = mod_variable_get(mod_type, mod_name, mod_var);

if (is_object(_lq)){
	var _array = lq_get(_lq, option_name);
	
	if (is_array(_array) && array_length(_array) > _player){
		return _array[_player];
	}
}

return null;

/*
Sets the value of a fake nonsync option, with a default value.
Equivalent to doing var _val = lq_get(mod_variable_get(mod_type, mod_name, mod_var), option_name); return (is_array(_val) && array_length(_val) > _player ? _val[_player] : def_value);
*/
#define option_defget_fake_nonsync(mod_type, mod_name, mod_var, _player, option_name, def_value)
var _lq = mod_variable_get(mod_type, mod_name, mod_var);

if (is_object(_lq)){
	var _array = lq_get(_lq, option_name);
	
	if (is_array(_array) && array_length(_array) > _player){
		return _array[_player];
	}
}

return def_value;

/*
Changes a property of an option.

Equivalent to changing the stored lightweight object for said option, or the instance that manages the value.

Allows for a lot of funky stuff, be careful.
*/
#define option_set_field(mod_type, mod_name, page_name, option_name, _field, _value)
var my_field = `${mod_name}.${mod_type}`;

if (!lq_exists(global.options, my_field)){
	exit;
}

var mod_lq = lq_defget(lq_defget(global.options, my_field, {}), "my_options", {});

if (!lq_exists(mod_lq, page_name)){
	exit;
}

var page_lq = lq_defget(mod_lq, page_name, {});

if (!lq_exists(page_lq, option_name)){
	exit;
}

lq_set(lq_get(page_lq, option_name), _field, _value);

/*
Retrieves a property of an option.

Equivalent to returning a value from the stored lightweight object for said option, or the instance that manages the value.
*/
#define option_get_field(mod_type, mod_name, page_name, option_name, _field)
return lq_get(lq_defget(lq_defget(lq_defget(lq_defget(global.options, `${mod_name}.${mod_type}`, {}), "my_options", {}), page_name, {}), option_name, {}), _field);

/*
Retrieves a property of an option, with a default value.

Equivalent to returning a value from the stored lightweight object for said option, or the instance that manages the value.
*/
#define option_defget_field(mod_type, mod_name, page_name, option_name, _field, def_value)
return lq_defget(lq_defget(lq_defget(lq_defget(lq_defget(global.options, `${mod_name}.${mod_type}`, {}), "my_options", {}), page_name, {}), option_name, {}), _field, def_value);

/*
Adds an option to Custom Options (this mod!).

json_args may be either a lightweight object or a json string.
Default values will be used when missing, see option_create.
*/
#define option_add(mod_type, mod_name, mod_var, mod_display_name, page_name, option_name, json_args)
if (!mod_exists(mod_type, mod_name)){
	exit;
}

if (is_string(json_args)){
	json_args = json_decode(json_args);
	
	if (json_args == json_error){
		trace(json_error_text);
		exit;
	}
}

else if (!is_object(json_args)){
	exit;
}

var my_field = `${mod_name}.${mod_type}`;

if (!lq_exists(global.options, my_field)){
	lq_set(global.options, my_field, {name: mod_display_name, point: mod_var, my_options: {}});
}

var my_lq = lq_defget(lq_get(global.options, my_field), "my_options", {});

if (!lq_exists(my_lq, page_name)){
	lq_set(my_lq, page_name, {});
}

my_lq = lq_get(my_lq, page_name);

var option_desc = lq_defget(json_args, "desc", "Did you define the#JSON arguments properly?");
var _o = option_create(my_lq, option_name, json_args);

return _o;

/*
Adds a whole page of options at once to Custom options (this mod!).

Equivalent to option_add if the page only has one option.

json_args may be either a lightweight object or a json string.
Default values will be used when missing, see option_create.
*/
#define option_add_page(mod_type, mod_name, mod_var, mod_display_name, page_name, json_args)
if (!mod_exists(mod_type, mod_name)){
	exit;
}

if (is_string(json_args)){
	json_args = json_decode(json_args);
	
	if (json_args == json_error){
		trace(json_error_text);
		exit;
	}
}

else if (!is_object(json_args) && !is_array(json_args)){
	exit;
}

var my_field = `${mod_name}.${mod_type}`;

if (!lq_exists(global.options, my_field)){
	lq_set(global.options, my_field, {name: mod_display_name, point: mod_var, my_options: {}});
}

var my_lq = lq_defget(lq_get(global.options, my_field), "my_options", {});

if (!lq_exists(my_lq, page_name)){
	lq_set(my_lq, page_name, {});
}

if (is_array(json_args)){
	lq_set(my_lq, page_name, json_args);
	return my_lq;
}

my_lq = lq_get(my_lq, page_name);

var _size = lq_size(json_args);

for (var i = 0; _size > i; i ++){
	var option_name = lq_get_key(json_args, i);
	var _me = lq_get_value(json_args, i);
	
	option_create(my_lq, option_name, _me);
}

return my_lq;

/*
Removes a single option from Custom Options (this mod!).
*/
#define option_remove(category_name, page_name, option_name)
if (!lq_exists(global.options, category_name)){
	exit;
}

var my_lq = lq_defget(lq_get(global.options, category_name), "my_options", {});

if (!lq_exists(my_lq, page_name)){
	exit;
}

lq_set(my_lq, page_name, lq_delete(lq_get(my_lq, page_name), option_name));

/*
Removes a single option from Custom Options (this mod!).

Allows for specifying mod type and mod name instead of assuming via category.
Equivalent to option_remove when `${mod_name}.${mod_type}` == category_name.
*/
#define option_remove_ext(mod_type, mod_name, page_name, option_name)
var my_field = `${mod_name}.${mod_type}`;

if (!lq_exists(global.options, my_field)){
	exit;
}

var my_lq = lq_defget(lq_get(global.options, my_field), "my_options", {});

if (!lq_exists(my_lq, page_name)){
	exit;
}

lq_set(my_lq, page_name, lq_delete(lq_get(my_lq, page_name), option_name));

/*
Removes an entire page from Custom Options (this mod!).
*/
#define option_remove_page(category_name, page_name)
if (!lq_exists(global.options, category_name)){
	exit;
}

var my_lq = lq_defget(lq_get(global.options, category_name), "my_options", {});

if (!lq_exists(my_lq, page_name)){
	exit;
}

lq_set(lq_get(global.options, category_name), "my_options", lq_delete(my_lq, page_name));

/*
Removes an entire page from Custom Options (this mod!).

Allows for specifying mod type and mod name instead of assuming via category.
Equivalent to option_remove_page when `${mod_name}.${mod_type}` == category_name.
*/
#define option_remove_page_ext(mod_type, mod_name, page_name)
var my_field = `${mod_name}.${mod_type}`;

if (!lq_exists(global.options, my_field)){
	exit;
}

var my_lq = lq_defget(lq_get(global.options, category_name), "my_options", {});

if (!lq_exists(my_lq, page_name)){
	exit;
}

lq_set(lq_get(global.options, category_name), "my_options", lq_delete(my_lq, page_name));

/*
Removes an entire category from Custom Options (this mod!).
*/
#define option_remove_category(category_name)
if (!lq_exists(global.options, category_name)){
	exit;
}

global.options = lq_delete(global.options, category_name);

/*
Removes all of a mod's options from Custom Options (this mod!).

Allows for specifying mod type and mod name instead of assuming via category.
Equivalent to option_remove_category when `${mod_name}.${mod_type}` == category_name.
*/
#define option_remove_mod(mod_type, mod_name)
var my_field = `${mod_name}.${mod_type}`;

if (!lq_exists(global.options, my_field)){
	exit;
}

global.options = lq_delete(global.options, my_field);

/*
Refreshes the displayed values for the chosen mod.

Useful if you include a way to reset to default.
*/
#define options_refresh()
with(global.objects){
	Option_refresh();
}

// :>
#define potion_create(page_lq, option_name, json_args)
return option_create(page_lq, option_name, json_args);

#define option_create(page_lq, option_name, json_args)
if (is_string(json_args)){
	json_args = json_decode(json_args);
	
	if (json_args == json_error){
		trace(json_error_text);
		exit;
	}
}

else if (!is_object(json_args)){
	exit;
}

var option_type = lq_defget(json_args, "type", "bool");
var option_desc = lq_defget(json_args, "desc", "Did you define the#JSON arguments properly?");
var option_reference = lq_defget(json_args, "reference", []);
var option_display_override = lq_defget(json_args, "display_override", "");

lq_set(json_args, "type", option_type);
lq_set(json_args, "desc", option_desc);
lq_set(json_args, "reference", option_reference);
lq_set(json_args, "display_override", option_display_override);

switch(string_lower(option_type)){
	default:
	case "bool":{
		lq_set(json_args, "name", lq_defget(json_args, "name", "BLANK BOOL"));
		lq_set(json_args, "display", lq_defget(json_args, "display", ["OFF", "ON"]));
		
		break;
	}
	
	case "int":{
		lq_set(json_args, "name", lq_defget(json_args, "name", "BLANK INT"));
		lq_set(json_args, "steps", lq_defget(json_args, "steps", 1));
		lq_set(json_args, "range", lq_defget(json_args, "range", [null, null]));
		lq_set(json_args, "wrap", lq_defget(json_args, "wrap", true));
		lq_set(json_args, "prefix", lq_defget(json_args, "prefix", ""));
		lq_set(json_args, "suffix", lq_defget(json_args, "suffix", ""));
		
		break;
	}
	
	case "slider":{
		lq_set(json_args, "name", lq_defget(json_args, "name", "BLANK SLIDER"));
		lq_set(json_args, "range", lq_defget(json_args, "range", [0, 1]));
		lq_set(json_args, "prefix", lq_defget(json_args, "prefix", ""));
		lq_set(json_args, "suffix", lq_defget(json_args, "suffix", "%"));
		lq_set(json_args, "steps", lq_defget(json_args, "steps", 0.001));
		
		if (lq_exists(json_args, "fine_steps")){
			lq_set(json_args, "button_steps", lq_defget(json_args, "fine_steps", 0.1));
		}
		
		else{
			lq_set(json_args, "button_steps", lq_defget(json_args, "button_steps", 0.1));
		}
		
		if (lq_exists(json_args, "display")){
			lq_set(json_args, "display_multiplier", lq_defget(json_args, "display", 100));
		}
		
		else{
			lq_set(json_args, "display_multiplier", lq_defget(json_args, "display_multiplier", 100));
		}
		
		if (lq_exists(json_args, "decimal")){
			lq_set(json_args, "decimal_places", lq_defget(json_args, "decimal", 1));
		}
		
		else{
			lq_set(json_args, "decimal_places", lq_defget(json_args, "decimal_places", 1));
		}
		
		lq_set(json_args, "color", lq_defget(json_args, "color", [c_lime, c_lime]));
		
		break;
	}
	
	case "cycle":{
		lq_set(json_args, "name", lq_defget(json_args, "name", "BLANK CYCLE"));
		lq_set(json_args, "choices", lq_defget(json_args, "choices", ["this", "is", "a", "cycle"]));
		lq_set(json_args, "display", lq_defget(json_args, "display", null));
		
		break;
	}
	
	case "text":
	case "button":
	case "title":{
		lq_set(json_args, "name", lq_defget(json_args, "name", "BLANK " + string_upper(option_type)));
		
		break;
	}
	
	case "keys":{
		lq_set(json_args, "name", lq_defget(json_args, "name", "BLANK KEYS"));
		lq_set(json_args, "style", lq_defget(json_args, "style", "text"));
		
		break;
	}
}

lq_set(page_lq, option_name, json_args);

return lq_get(page_lq, option_name);

#define draw_gui
if (instance_exists(Menu) && instance_exists(Loadout) && lq_size(global.options)){
	var _captured = mouse_in_rectangle(-1, game_width - 20, 0, game_width, 20, true);
	
	if (array_length(_captured) <= 0){
		draw_sprite_ext(global.options_icon, 1, game_width - 10, 10, 1, 1, 0, $999999, 1);
	}
	
	else{
		draw_sprite_ext(global.options_icon, 1, game_width - 10, 10, 1, 1, 0, c_white, 1);
	}
	
	with(_captured){
		if (button_pressed(self, "fire")){
			with(instances_matching(CustomDraw, "script", script_ref_create(draw_pause))){
				instance_destroy();
			}
			
			script_bind_draw(draw_pause, OPTION_DEPTH);
			sound_play(sndClick);
			
			break;
		}
	}
}

#define draw_pause
var _halign = draw_get_halign();
var _valign = draw_get_valign();

var _cx = (game_width >> 1);
var _cy = (game_height >> 1);

var arrow_width = (sprDailyArrow_bbox[0][2] - sprDailyArrow_bbox[0][0] + 1);
var arrow_height = (sprDailyArrow_bbox[0][3] - sprDailyArrow_bbox[0][1] + 1);

var menu_stuff = global.menu_stuff;
var local_player = player_find_local_nonsync();

var _clicked = false;
var _exit = false;

if (instance_exists(Menu)){
	with(Menu){
		mode = 0;
		charsplat = 1;
		
		var charx_count = array_length(charx);
		
		for (var i = 0; charx_count > i; i ++){
			charx[i] = 0;
		}
		
		sound_volume(sndMenuCharSelect, 0);
	}
	
	with(Loadout){
		instance_destroy();
	}
	
	with(loadbutton){
		instance_destroy();
	}
	
	with(menubutton){
		instance_destroy();
	}
	
	with(BackFromCharSelect){
		noinput = 10;
	}
	
	var _color = draw_get_color();
	var _alpha = draw_get_alpha();
	
	draw_set_color(c_black);
	draw_set_alpha(0.75);
	
	draw_rectangle(view_xview_nonsync + 0, view_yview_nonsync + 0, view_xview_nonsync + game_width, view_yview_nonsync + game_height, false);
	
	draw_set_color(_color);
	draw_set_alpha(_alpha);
}

var left_width = (sprDailyArrow_bbox[0][2] - sprDailyArrow_bbox[0][0]);
var left_height = (sprDailyArrow_bbox[0][3] - sprDailyArrow_bbox[0][1]);
var left_xoffset = sprDailyArrow_bbox[0][4] * -1 + sprDailyArrow_xoffset;
var left_yoffset = sprDailyArrow_bbox[0][5] * -1 + sprDailyArrow_yoffset;

var right_width = (sprDailyArrow_bbox[1][2] - sprDailyArrow_bbox[1][0]);
var right_height = (sprDailyArrow_bbox[1][3] - sprDailyArrow_bbox[1][1]);
var right_xoffset = sprDailyArrow_bbox[1][4] * -1 + sprDailyArrow_xoffset;
var right_yoffset = sprDailyArrow_bbox[1][5] * -1 + sprDailyArrow_yoffset;

if (!global.menu_stuff.view_settings && (instance_exists(Menu) || instance_exists(OptionMenuButton)) && instance_number(menubutton) <= instance_number(OptionMenuButton)){
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	
	var _obj = lq_get_value(global.options, global.menu_stuff.page_index);
	var my_options = lq_defget(_obj, "my_options", {});
	var _pages = lq_size(global.options);
	
	while (_pages){
		var my_pages = lq_size(my_options);
		
		for (var i = 0; my_pages > i; i ++){
			var my_items = lq_size(lq_get_value(my_options, i));
			
			if (my_items <= 0 && !is_array(lq_get_value(my_options, i))){
				option_remove_page(lq_get_key(global.options, global.menu_stuff.page_index), lq_get_key(my_options, i));
				my_pages -= 1;
			}
		}
		
		if (my_pages){
			break;
		}
		
		option_remove_category(lq_get_key(global.options, global.menu_stuff.page_index));
		global.menu_stuff.page_index = min(global.menu_stuff.page_index, _pages - 1);
		_obj = lq_get_value(global.options, global.menu_stuff.page_index);
		my_options = lq_defget(_obj, "my_options", {});
		_pages -= 1;
	}
	
	if (!_pages){
		_exit = true;
	}
	
	if (is_object(_obj)){
		draw_set_font(fntBigName);
		
		var _text = lq_get(_obj, "name");
		var _measure = string_nt_clean(string_height_fix(_text));
		var text_width = max(string_width(_measure), SINGLE_CHAR_WIDTH);
		var text_height = max(string_height(_measure), SINGLE_CHAR_HEIGHT);
		var _resized = false;
		
		if (!surface_exists(global.menu_stuff.surface)){
			global.menu_stuff.surface = surface_create(text_width + 2, text_height + 2);
		}
		
		else if (surface_get_width(global.menu_stuff.surface) != text_width + 2 || surface_get_height(global.menu_stuff.surface) != text_height + 2){
			surface_resize(global.menu_stuff.surface, text_width + 2, text_height + 2);
			_resized = true;
		}
		
		if (global.menu_stuff.surface_text != _text || _resized || surface_cleared(global.menu_stuff.surface)){
			surface_set_target(global.menu_stuff.surface);
			
			draw_clear_alpha(c_black, 0);
			
			draw_text_nt(floor(text_width >> 1), 0, _text);
			
			surface_reset_target();
		}
		
		var text_left = _cx - (text_width >> 1) * SURFACE_SCALE;
		var menu_top = BUTTON_POS_Y - text_height * SURFACE_SCALE * 1.1 - 21 + text_height div (SINGLE_CHAR_HEIGHT << 1);
		var text_top = (instance_exists(Menu) ? (game_height >> 1) - (text_height >> 1) * SURFACE_SCALE : menu_top);
		
		if (!instance_exists(global.menu_stuff.splat)){
			with(script_bind_draw(Menu_draw_splat, OPTION_SPLAT_DEPTH)){
				global.menu_stuff.splat = self;
				sprite_index = sprCharSplat;
				visible = false;
				image_speed = 0.8;
				x = text_left + (text_width >> 1) * SURFACE_SCALE;
				y = text_top + (text_height >> 1) * SURFACE_SCALE;
			}
		}
		
		var left_x = text_left - arrow_width;
		var left_y = text_top + ((text_height * SURFACE_SCALE) >> 1);
		var right_x = text_left + arrow_width + text_width * SURFACE_SCALE;
		var right_y = text_top + ((text_height * SURFACE_SCALE) >> 1);
		
		var _x1 = left_x - (left_width >> 1);
		var _y1 = left_y - (left_height >> 1);
		var _x2 = left_x + (left_width << 1);
		var _y2 = left_y + (left_height << 1);
		
		var _x3 = right_x - (right_width >> 1);
		var _y3 = right_y - (right_height >> 1);
		var _x4 = right_x + (right_width << 1);
		var _y4 = right_y + (right_height << 1);
		
		var _input = false;
		
		for (var p = 0; maxp > p; p ++){
			if (player_is_active(p)){
				var _mx = mouse_x[p] - view_xview[p];
				var _my = mouse_y[p] - view_yview[p];
				
				var _dir = sign(button_pressed(p, "east") - button_pressed(p, "west"));
				
				if (_dir != 0){
					if (_pages > 1){
						global.menu_stuff.page_side = wrap_clamp(global.menu_stuff.page_side + _dir, (global.menu_stuff.page_index > 0 ? -2 : 0), (global.menu_stuff.page_index < _pages - 1 ? 2 : 0));
					}
					
					else{
						global.menu_stuff.page_side = wrap_clamp(global.menu_stuff.page_side + (_dir << 1) - (global.menu_stuff.page_side % 2), -2, 0);
					}
				}
				
				var _center = (_mx >= text_left && _my >= text_top && _mx <= text_left + text_width * SURFACE_SCALE && _my <= text_top + text_height * SURFACE_SCALE);
				var _left = (_mx >= _x1 && _my >= _y1 && _mx <= _x2 && _my <= _y2);
				var _right = (_mx >= _x3 && _my >= _y3 && _mx <= _x4 && _my <= _y4);
				
				if (global.menu_stuff.page_side != 0 && _center){
					global.menu_stuff.page_side = 0;
				}
				
				else if (global.menu_stuff.page_side != -1 && _left){
					global.menu_stuff.page_side = -1;
				}
				
				else if (global.menu_stuff.page_side != 1 && _right){
					global.menu_stuff.page_side = 1;
				}
				
				_input |= (button_pressed(p, "pick") || (button_pressed(p, "fire") && (_center || _left || _right)));
				
				if (_input && global.menu_stuff.page_side != -2){
					break;
				}
			}
		}
		
		if (global.menu_stuff.page_side == 0){
			global.menu_stuff.splat.visible = true;
			
			draw_surface_centered_ext(global.menu_stuff.surface, view_xview_nonsync + text_left + (text_width >> 1) * SURFACE_SCALE, view_yview_nonsync + text_top + (text_height >> 1) * SURFACE_SCALE, SURFACE_SCALE, SURFACE_SCALE, 0, c_white, 1);
			
			if (_input){
				sound_play(sndClick);
				
				global.menu_stuff.view_settings = true;
				
				var mod_details = string_split(lq_get_key(global.options, global.menu_stuff.page_index), ".");
				var dot_count = array_length(mod_details);
				
				var mod_name = array_join(array_slice(mod_details, 0, dot_count - 1), ".");
				var mod_type = mod_details[dot_count - 1];
				
				if (mod_script_exists(mod_type, mod_name, "CustomOptions_open")){
					mod_script_call_nc(mod_type, mod_name, "CustomOptions_open");
				}
				
				with(global.menu_stuff.splat){
					instance_destroy();
				}
				
				with(OptionMenuButton){
					instance_destroy();
				}
				
				_clicked = true;
			}
		}
		
		else{
			global.menu_stuff.splat.visible = false;
			draw_surface_centered_ext(global.menu_stuff.surface, view_xview_nonsync + text_left + (text_width >> 1) * SURFACE_SCALE, view_yview_nonsync + text_top + (text_height >> 1) * SURFACE_SCALE, SURFACE_SCALE, SURFACE_SCALE, 0, $999999, 1);
			
			with(global.menu_stuff.splat){
				image_index = 0;
				image_speed = 0.8;
			}
		}
		
		if (_pages > 1){
			if (global.menu_stuff.page_index > 0){
				if (global.menu_stuff.page_side == -1){
					draw_sprite_centered_ext(sprDailyArrow, 0, view_xview_nonsync + left_x, view_yview_nonsync + left_y, 1, 1, 0, c_white, 1);
					
					if (_input){
						sound_play(sndClick);
						global.menu_stuff.page_index -= 1;
					}
				}
				
				else{
					draw_sprite_centered_ext(sprDailyArrow, 0, view_xview_nonsync + left_x, view_yview_nonsync + left_y, 1, 1, 0, $999999, 1);
				}
			}
			
			else if (global.menu_stuff.page_side == -1){
				global.menu_stuff.page_side = -2;
			}
			
			if (global.menu_stuff.page_index < _pages - 1){
				if (global.menu_stuff.page_side == 1){
					draw_sprite_centered_ext(sprDailyArrow, 1, view_xview_nonsync + right_x, view_yview_nonsync + right_y, 1, 1, 0, c_white, 1);
					
					if (_input){
						sound_play(sndClick);
						global.menu_stuff.page_index -= 1;
					}
				}
				
				else{
					draw_sprite_centered_ext(sprDailyArrow, 1, view_xview_nonsync + right_x, view_yview_nonsync + right_y, 1, 1, 0, $999999, 1);
				}
			}
			
			else if (global.menu_stuff.page_side == 1){
				global.menu_stuff.page_side = -2;
			}
		}
		
		global.menu_stuff.page_index = wrap_clamp(global.menu_stuff.page_index, 0, _pages - 1);
	}
	
	else{
		global.options = lq_delete(global.options, lq_get_key(global.options, global.menu_stuff.page_index));
		global.menu_stuff.page_index = wrap_clamp(global.menu_stuff.page_index, 0, _pages - 1);
	}
}

else if (!global.menu_stuff.view_settings){
	with(global.menu_stuff.splat){
		instance_destroy();
	}
}

if (instance_exists(Menu) && instance_is(self, CustomDraw)){
	for (var p = 0; maxp > p; p ++){
		with(BackFromCharSelect){
			if (button_pressed(p, "spec") || button_pressed(p, "paus") || (position_meeting((mouse_x[p] - (view_xview[p] + xstart)) + x, (mouse_y[p] - (view_yview[p] + ystart)) + y, self) && button_pressed(p, "fire"))){
				_exit = true;
				break;
			}
		}
		
		if (_exit){
			break;
		}
	}
}

if (!_clicked && !_exit && global.menu_stuff.view_settings && !instance_exists(menubutton)){
	var mod_details = string_split(lq_get_key(global.options, global.menu_stuff.page_index), ".");
	var dot_count = array_length(mod_details);
	
	var mod_name = array_join(array_slice(mod_details, 0, dot_count - 1), ".");
	var mod_type = mod_details[dot_count - 1];
	
	var mod_lq = lq_get_value(global.options, global.menu_stuff.page_index);
	var my_options = lq_defget(mod_lq, "my_options", {});
	
	var my_variable = (lq_exists(mod_lq, "point") ? lq_get(mod_lq, "point") : "options");
	
	var page_count = lq_size(my_options);
	
	var _scale = SURFACE_SCALE;
	
	var _visible = [];
	
	for (var p = maxp - 1; 0 <= p; p --){
		_visible[p] = draw_get_visible(p);
	}
	
	var _highlight = array_clone(array_create(maxp, -1));
	
	for (var p = 0; maxp > p; p ++){
		if (player_is_active(p)){
			if (player_is_local_nonsync(p) && p != player_find_local_nonsync()){
				continue;
			}
			
			draw_set_visible_all(false);
			draw_set_visible(p, true);
			
			global.menu_stuff.settings_page[p][@0] = clamp(global.menu_stuff.settings_page[p][@0], 0, page_count - 1);
			
			var my_page = lq_get_value(my_options, global.menu_stuff.settings_page[p][@0]);
			var page_name = lq_get_key(my_options, global.menu_stuff.settings_page[p][@0]);
			var _measure = string_nt_clean(string_height_fix(page_name));
			
			var _mx = mouse_x[p] - view_xview[p];
			var _my = mouse_y[p] - view_yview[p];
			
			var _left = button_pressed(p, "west");
			var _right = button_pressed(p, "east");
			var _up = button_pressed(p, "nort");
			var _down = button_pressed(p, "sout");
			
			var option_count = lq_size(my_page);
			
			if (page_count > 1){
				draw_set_font(fntBigName);
				draw_set_halign(fa_center);
				draw_set_valign(fa_top);
				
				var page_width = max(string_width(_measure), 16) * _scale;
				var page_height = max(string_height(_measure), 16) * _scale;
				
				var name_left = _cx - (page_width >> 1);
				var name_top = game_height - page_height - 6;
				
				if ((global.menu_stuff.side[p] == 0 && global.menu_stuff.selected[p] == option_count) || (_mx >= name_left && _my >= name_top - (page_height >> 2) && _mx <= name_left + page_width && _my <= name_top - (page_height >> 2) + page_height)){
					global.menu_stuff.selected[p] = option_count;
					global.menu_stuff.side[p] = 0;
					_highlight[p] = fa_center;
				}
				
				if (global.menu_stuff.settings_page[p][@0] > 0 && ((global.menu_stuff.side[p] == -1 && global.menu_stuff.selected[p] == option_count) || (_mx >= name_left - arrow_width - (left_width >> 1) && _my >= name_top && _mx <= name_left - arrow_width + (left_width >> 1) && _my <= name_top + arrow_height))){
					global.menu_stuff.selected[p] = option_count;
					global.menu_stuff.side[p] = -1;
					_highlight[p] = fa_left;
				}
				
				else if (global.menu_stuff.settings_page[p][@0] < page_count - 1 && ((global.menu_stuff.side[p] == 1 && global.menu_stuff.selected[p] == option_count) || (_mx >= name_left + page_width + arrow_width - (right_width >> 1) && _my >= name_top && _mx <= name_left + page_width + arrow_width + (right_width >> 1) && _my <= name_top + arrow_height))){
					global.menu_stuff.selected[p] = option_count;
					global.menu_stuff.side[p] = 1;
					_highlight[p] = fa_right;
				}
				
				else{
					global.menu_stuff.side[p] = 0;
				}
				
				if (global.menu_stuff.side[p] != 0 && (button_pressed(p, "fire") || button_pressed(p, "okay") || button_pressed(p, "pick"))){
					sound_play_nonsync(p, sndClick);
					
					with(instances_matching(global.objects, "from_page", page_name)){
						var _index = array_find_index(visible_to, p);
						
						if (_index >= 0){
							var _new = array_slice(visible_to, 0, _index);
							array_copy(_new, _index, visible_to, _index + 1, array_length(visible_to) - (_index + 1));
							visible_to = _new;
							
							if (array_length(visible_to) <= 0){
								instance_destroy();
							}
						}
					}
					
					with(global.menu_stuff.sub_splats[p]){
						instance_destroy();
					}
					
					global.menu_stuff.settings_page[p][@0] = wrap_clamp(global.menu_stuff.settings_page[p][@0] + global.menu_stuff.side[p], 0, page_count - 1);
					global.menu_stuff.settings_page[p][@1] = -1;
					global.menu_stuff.side[p] = 0;
					global.menu_stuff.timer[p] = 0;
					global.menu_stuff.selected[p] = -1;
					
					my_page = lq_get_value(my_options, global.menu_stuff.settings_page[p][@0]);
					page_name = lq_get_key(my_options, global.menu_stuff.settings_page[p][@0]);
					option_count = lq_size(my_page);
				}
				
				var _resized = false;
				
				_measure = string_nt_clean(string_height_fix(page_name));
				
				page_width = max(string_width(_measure), 16);
				page_height = max(string_height(_measure), 16);
				
				if (!surface_exists(global.menu_stuff.page_surface)){
					global.menu_stuff.page_surface = surface_create(page_width + 2, page_height + 2);
				}
				
				else if (surface_get_width(global.menu_stuff.page_surface) != page_width + 2 || surface_get_height(global.menu_stuff.page_surface) != page_height + 2){
					surface_resize(global.menu_stuff.page_surface, page_width + 2, page_height + 2);
					_resized = true;
				}
				
				if (global.menu_stuff.page_surface_text != page_name || _resized || surface_cleared(global.menu_stuff.page_surface)){
					surface_set_target(global.menu_stuff.page_surface);
					
					draw_clear_alpha(c_black, 0);
					
					draw_text_nt(floor(page_width >> 1), 0, page_name);
					
					surface_reset_target();
				}
				
				draw_set_font(fntM);
			}
			
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
			
			if (is_array(my_page) && array_length(my_page) >= 3 && mod_script_exists(my_page[0], my_page[1], my_page[2])){
				draw_set_projection(0);
				script_ref_call(my_page, p);
				draw_reset_projection();
				option_count = 0;
				global.menu_stuff.selected[p] = -1;
			}
			
			if (option_count <= 0){
				continue;
			}
			
			if (global.menu_stuff.selected[p] < 10016){
				var _dir = sign(_down - _up);
				
				if (_dir != 0){
					var _max = (option_count - (page_count <= 1));
					
					global.menu_stuff.selected[p] = wrap_clamp(global.menu_stuff.selected[p] + _dir, -1, _max);
					
					with(global.menu_stuff.sub_splats[p]){
						visible = (global.menu_stuff.selected[p] <= _max && global.menu_stuff.selected[p] >= 0);
						image_index = 0;
						image_speed = 0.8;
					}
				}
				
				if (global.menu_stuff.selected[p] == option_count){
					var _side = sign(_right - _left);
					global.menu_stuff.side[p] = clamp(global.menu_stuff.side[p] + _side, -1, 1);
					
					with(global.menu_stuff.sub_splats[p]){
						instance_destroy();
					}
				}
			}
			
			if (is_object(my_page)){
				var _space = 0;
				
				var option_height = 0;
				var line_height = string_height("OFF") + 4;
				
				for (var o = 0; option_count > o; o ++){
					var _me = lq_get_value(my_page, o);
					
					if (is_object(_me)){
						option_height += (LINE_SPACING + string_height(string_nt_clean(string_height_fix(lq_defget(_me, "name", "BLANK TITLE")))));
						option_height += (lq_defget(_me, "pixels", 0) + lq_defget(_me, "lines", 0) * line_height);
					}
				}
				
				var mod_options = mod_variable_get(mod_type, mod_name, my_variable);
				
				with(instances_matching(instances_matching(global.objects, "from_page", page_name), "selected", p)){
					selected = -1;
				}
				
				var _selected = 0;
				
				for (var o = 0; option_count > o; o ++){
					var _key = lq_get_key(my_page, o);
					var _me = lq_get_value(my_page, o);
					var _pressed = array_clone(array_create(maxp, false));
					
					if (global.menu_stuff.timer[p] >= o && is_object(_me)){
						_space += lq_defget(_me, "pixels", 0);
						var true_name = lq_defget(_me, "name", "BLANK TITLE");
						var true_measure = string_nt_clean(string_height_fix(true_name));
						var local_space = LINE_SPACING + string_height(true_measure) + lq_defget(_me, "lines", 0) * line_height;
						var my_y = round(_cy + _space - (option_height >> 1));
						_space += local_space;
						
						var _last = _selected;
						_selected = ((_selected <= 0 && (global.menu_stuff.selected[p] == o || global.menu_stuff.selected[p] == o + 10016)) + (global.menu_stuff.selected[p] == o + 10016));
						
						if (_selected){
							my_y -= 1;
						}
						
						var name_x = round(game_width * 0.100);
						var value_x = round(game_width * 0.800);
						
						var name_width = string_width(true_measure);
						var name_height = string_height(true_measure);
						
						var bounds_left = game_width * 0.078;
						var bounds_right = game_width * 0.966;
						
						var in_bounds = false;
						
						if (_mx >= bounds_left && _my >= my_y - (line_height >> 1) - 1 && _mx <= bounds_right && _my <= my_y + (line_height >> 1) + 1){
							if (global.menu_stuff.selected[p] < 10016){
								if (global.menu_stuff.selected[p] != o){
									with(global.menu_stuff.sub_splats[p]){
										image_index = 0;
										image_speed = 0.8;
									}
								}
								
								global.menu_stuff.selected[p] = o;
							}
							
							in_bounds = true;
						}
						
						if (global.menu_stuff.selected[p] == o + 10016 && button_pressed(p, "okay") && global.menu_stuff.pressed[p]){
							_pressed[p] = true;
						}
						
						var _type = string_lower(lq_defget(_me, "type", "title"));
						
						if (_type == "title" || _type == "button"){
							name_x = _cx - (name_width >> 1);
							
							if (_selected && (button_pressed(p, "okay") || (in_bounds && button_pressed(p, "fire")))){
								var _ref = lq_defget(_me, "reference", []);
								
								if (is_array(_ref) && array_length(_ref) >= 3 && mod_script_exists(_ref[0], _ref[1], _ref[2])){
									sound_play_pitchvol_nonsync(p, sndClick, random_range(0.8, 1.2), 1);
									script_ref_call(_ref, p, null);
								}
							}
						}
						
						var _fsync = lq_defget(_me, "fake_nonsync", false);
						var _nonsync = (lq_defget(_me, "nonsync", false) ? p : -1);
						
						if (global.menu_stuff.settings_page[p][@1] < o){
							var _initialized = false;
							
							// var _matching = instances_matching(instances_matching(global.objects, "option_name", _key), "from_page", page_name);
							
							// if (!_fsync && _nonsync == -1){
							// 	with(instances_matching(instances_matching(global.objects, "option_name", _key), "from_page", page_name)){
							// 		if (array_find_index(visible_to, p) < 0){
							// 			_initialized = true;
							// 			array_push(visible_to, p);
							// 		}
							// 	}
							// }
							
							// if (!_initialized && array_length(_matching) <= 0){
							if (!_initialized){
								var _point = lq_defget(_me, "point", [mod_type, mod_name, my_variable]);
								
								var _x = round(view_xview[p] + value_x);
								var _y = round(view_yview[p] + my_y + (name_height >> 1));
								
								switch(_type){
									case "bool":
									case "int":
									case "slider":
									case "cycle":
									case "text":
									case "keys":{
										var _upper = string_upper(string_char_at(_type, 1)) + string_lower(string_copy(_type, 2, string_length(_type) - 1));
										
										with(mod_script_call(mod_current_type, mod_current, _upper + "_create", view_xview[p] + value_x, view_yview[p] + my_y + (name_height >> 1))){
											fake_nonsync = _fsync;
											nonsync = _nonsync;
											
											array_push(global.objects, self);
											
											option_name = _key;
											point = _point;
											from_page = page_name;
											array_push(visible_to, p);
											value = option_get(point[0], point[1], point[2], option_name);
											lst_value = value;
											on_menu_change = script_ref_create(Option_change);
											
											Option_refresh();
										}
										
										break;
									}
								}
							}
							
							global.menu_stuff.settings_page[p][@1] = o;
						}
						
						if (_last <= 0 && _selected){
							with(instances_matching(instances_matching(global.objects, "option_name", _key), "from_page", page_name)){
								selected = p;
							}
						}
						
						if (_selected){
							if (!instance_exists(global.menu_stuff.sub_splats[p])){
								with(script_bind_draw(Menu_draw_sub_splat, OPTION_SPLAT_DEPTH)){
									global.menu_stuff.sub_splats[p] = self;
									sprite_index = sprMainMenuSplat;
									image_speed = 0.8;
									x = view_xview[p] + name_x + (name_width >> 1);
									y = view_yview[p] + my_y + (name_height >> 1);
									index = p;
								}
							}
							
							else{
								with(global.menu_stuff.sub_splats[p]){
									if (!visible || x != view_xview[p] + name_x + (name_width >> 1) || y != view_yview[p] + my_y + (name_height >> 1)){
										visible = true;
										x = view_xview[p] + name_x + (name_width >> 1);
										y = view_yview[p] + my_y + (name_height >> 1);
									}
								}
							}
							
							draw_text_nt(view_xview_nonsync + name_x, view_yview_nonsync + my_y, `@w${true_name}`);
							
							var _desc = lq_defget(_me, "desc", "");
							
							if (string_length(_desc) && p == local_player){
								array_push(global.menu_stuff.tooltips[local_player], [_cx, _cy - (option_height >> 1), _desc]);
							}
						}
						
						else{
							draw_text_nt(view_xview_nonsync + name_x, view_yview_nonsync + my_y, `@(color:${$999999})${true_name}`);
						}
						
						if (_pressed[p]){
							global.menu_stuff.pressed[p] = false;
							global.menu_stuff.selected[p] = o;
						}
					}
				}
				
				with(instances_matching_ne(instances_matching(global.objects, "from_page", page_name), "noinput", null)){
					if (array_find_index(noinput, p) < 0){
						array_push(noinput, p);
					}
				}
			}
			
			global.menu_stuff.timer[p] += current_time_scale;
		}
	}
	
	for (var p = maxp - 1; 0 <= p; p --){
		draw_set_visible(p, _visible[p]);
		
		var mx_gui = mouse_x[p] - view_xview[p];
		var my_gui = mouse_y[p] - view_yview[p];
		
		if (button_pressed(p, "spec") || button_pressed(p, "paus") || (mx_gui >= 0 && my_gui >= 0 && mx_gui <= 28 && my_gui <= 28 && button_pressed(p, "fire"))){
			_exit = true;
			break;
		}
	}
	
	if (!_exit){
		if (page_count > 1 && local_player >= 0 && local_player < maxp){
			draw_set_font(fntBigName);
			draw_set_halign(fa_center);
			draw_set_valign(fa_top);
			
			var page_name = lq_get_key(my_options, global.menu_stuff.settings_page[local_player][0]);
			var _measure = string_nt_clean(string_height_fix(page_name));
			
			var page_width = max(string_width(_measure), 16) * _scale;
			var page_height = max(string_height(_measure), 16) * _scale;
			
			var name_left = view_xview_nonsync + (game_width >> 1) - (page_width >> 1);
			var name_top = view_yview_nonsync + game_height - page_height;
			
			var left_x = name_left - arrow_width;
			var right_x = name_left + arrow_width + page_width;
			var arrow_y = name_top + (page_height >> 1);
			
			var page_drawn = false;
			
			if (_highlight[local_player] == fa_center){
				draw_surface_centered_ext(global.menu_stuff.page_surface, name_left + (page_width >> 1) - 1, arrow_y, _scale, _scale, 0, c_white, 1);
				page_drawn = true;
			}
			
			else{
				draw_surface_centered_ext(global.menu_stuff.page_surface, name_left + (page_width >> 1), arrow_y, _scale, _scale, 0, $999999, 1);
			}
			
			switch(_highlight[local_player]){
				case fa_left:{
					if (global.menu_stuff.settings_page[local_player][@0] > 0){
						draw_sprite_centered_ext(sprDailyArrow, 0, left_x, arrow_y - 1, 1, 1, 0, c_white, 1);
					}
					
					if (global.menu_stuff.settings_page[local_player][@0] < page_count - 1){
						draw_sprite_centered_ext(sprDailyArrow, 1, right_x, arrow_y, 1, 1, 0, $999999, 1);
					}
					
					break;
				}
				
				default:{
					if (global.menu_stuff.settings_page[local_player][@0] > 0){
						draw_sprite_centered_ext(sprDailyArrow, 0, left_x, arrow_y, 1, 1, 0, $999999, 1);
					}
					
					if (global.menu_stuff.settings_page[local_player][@0] < page_count - 1){
						draw_sprite_centered_ext(sprDailyArrow, 1, right_x, arrow_y, 1, 1, 0, $999999, 1);
					}
					
					break;
				}
				
				case fa_right:{
					if (global.menu_stuff.settings_page[local_player][@0] > 0){
						draw_sprite_centered_ext(sprDailyArrow, 0, left_x, arrow_y, 1, 1, 0, $999999, 1);
					}
					
					if (global.menu_stuff.settings_page[local_player][@0] < page_count - 1){
						draw_sprite_centered_ext(sprDailyArrow, 1, right_x, arrow_y - 1, 1, 1, 0, c_white, 1);
					}
					
					break;
				}
			}
			
			draw_set_font(fntM);
			
			if (page_drawn && player_find_local_nonsync() == local_player){
				array_push(global.menu_stuff.tooltips[local_player], [_cx, name_top - view_yview_nonsync, `Page ${global.menu_stuff.settings_page[local_player][0] + 1} of ${page_count}`]);
			}
		}
		
		if (local_player >= 0 && local_player < maxp){
			with(global.menu_stuff.tooltips[local_player]){
				draw_tooltip(view_xview_nonsync + self[0], view_yview_nonsync + self[1], self[2]);
			}
			
			global.menu_stuff.tooltips[local_player] = [];
		}
	}
}

draw_set_font(fntM);
draw_set_halign(_halign);
draw_set_valign(_valign);

if ((instance_is(self, CustomDraw) && !instance_exists(Menu)) || instance_exists(PauseButton)){
	_exit = true;
}

if (_exit){
	for (var p = 0; maxp > p; p ++){
		with(global.menu_stuff.sub_splats[p]){
			instance_destroy();
		}
		
		global.menu_stuff.sub_splats[p] = noone;
		global.menu_stuff.settings_page[p][@1] = -1;
		global.menu_stuff.selected[p] = -1;
		global.menu_stuff.pressed[p] = false;
		global.menu_stuff.side[p] = 0;
		global.menu_stuff.timer[p] = 0;
	}
	
	with(global.menu_stuff.splat){
		instance_destroy();
	}
	
	with(global.objects){
		if (instance_exists(self)){
			instance_destroy();
		}
	}
	
	global.objects = [];
	
	if (global.menu_stuff.view_settings){
		var mod_details = string_split(lq_get_key(global.options, global.menu_stuff.page_index), ".");
		var dot_count = array_length(mod_details);
		
		var mod_name = array_join(array_slice(mod_details, 0, dot_count - 1), ".");
		var mod_type = mod_details[dot_count - 1];
		
		if (mod_script_exists(mod_type, mod_name, "CustomOptions_save")){
			mod_script_call_nc(mod_type, mod_name, "CustomOptions_save");
		}
		
		else if (mod_script_exists(mod_type, mod_name, "save_options")){
			mod_script_call_nc(mod_type, mod_name, "save_options");
		}
		
		global.menu_stuff.view_settings = false;
	}
	
	global.menu_stuff.page_side = -2;
	
	if (instance_exists(Menu)){
		with(Menu){
			mode = 0;
			event_perform(ev_step, ev_step_end);
			sound_volume(sndMenuCharSelect, 1);
			sound_stop(sndMenuCharSelect);
		}
		
		with(CharSelect){
			alarm_set(0, 2);
		}
		
		with(Loadout){
			selected = 0;
		}
		
		sound_play(sndClickBack);
		
		if (instance_is(self, CustomDraw)){
			instance_destroy();
		}
	}
}

#define Option_change
if ("point" in self && is_array(point) && array_length(point) >= 3 && mod_variable_exists(point[0], point[1], point[2])){
	if (fake_nonsync){
		option_set_fake_nonsync(point[0], point[1], point[2], selected, option_name, value);
	}
	
	else if (nonsync == -1 || player_find_local_nonsync() == nonsync){
		option_set(point[0], point[1], point[2], option_name, value);
	}
	
	var _point = point;
	var _value = value;
	
	with(instances_matching(instances_matching(global.objects, "from_page", from_page), "option_name", option_name)){
		if (self != other && "point" in self && array_equals(point, _point)){
			value = _value;
			lst_value = _value;
		}
	}
	
	if (is_array(on_option_change) && array_length(on_option_change) >= 3 && mod_script_exists(on_option_change[0], on_option_change[1], on_option_change[2])){
		script_ref_call(on_option_change, selected, (fake_nonsync ? value[selected] : value));
	}
}

#define Option_refresh
if (!"point" in self || !"name" in self || !"from_page" in self || !"option_name" in self){
	exit;
}

var mod_details = string_split(lq_get_key(global.options, global.menu_stuff.page_index), ".");
var dot_count = array_length(mod_details);

var mod_name = array_join(array_slice(mod_details, 0, dot_count - 1), ".");
var mod_type = mod_details[dot_count - 1];

value = option_get(point[0], point[1], point[2], option_name);
lst_value = value;

on_option_change = option_defget_field(mod_type, mod_name, from_page, option_name, "reference", []);
display_override = option_defget_field(mod_type, mod_name, from_page, option_name, "display_override", "");

var _scr = [mod_current_type, mod_current, name + "_refresh"];

if (mod_script_exists(_scr[0], _scr[1], _scr[2])){
	mod_script_call(_scr[0], _scr[1], _scr[2], mod_type, mod_name);
}

#define Slider_refresh(mod_type, mod_name)
range = option_defget_field(mod_type, mod_name, from_page, option_name, "range", [0, 1]);
prefix = option_defget_field(mod_type, mod_name, from_page, option_name, "prefix", "");
suffix = option_defget_field(mod_type, mod_name, from_page, option_name, "suffix", "%");
steps = option_defget_field(mod_type, mod_name, from_page, option_name, "steps", 0.001);
button_steps = option_defget_field(mod_type, mod_name, from_page, option_name, "button_steps", 0.1);
display_multiplier = option_defget_field(mod_type, mod_name, from_page, option_name, "display_multiplier", 100);
decimal_places = option_defget_field(mod_type, mod_name, from_page, option_name, "decimal_places", 1);
color = option_defget_field(mod_type, mod_name, from_page, option_name, "color", [c_lime, c_lime]);

#define Bool_refresh(mod_type, mod_name)
display = option_defget_field(mod_type, mod_name, from_page, option_name, "display", ["OFF", "ON"]);

#define Int_refresh(mod_type, mod_name)
steps = option_defget_field(mod_type, mod_name, from_page, option_name, "steps", 1);
range = option_defget_field(mod_type, mod_name, from_page, option_name, "range", [null, null]);
wrap = option_defget_field(mod_type, mod_name, from_page, option_name, "wrap", true);
prefix = option_defget_field(mod_type, mod_name, from_page, option_name, "prefix", "");
suffix = option_defget_field(mod_type, mod_name, from_page, option_name, "suffix", "");

#define Cycle_refresh(mod_type, mod_name)
choices = option_defget_field(mod_type, mod_name, from_page, option_name, "choices", ["this", "is", "a", "cycle"]);
display = option_defget_field(mod_type, mod_name, from_page, option_name, "display", array_clone(choices));

#define Keys_refresh(mod_type, mod_name)
style = option_defget_field(mod_type, mod_name, from_page, option_name, "style", "text");

#define Menu_draw_splat
if (image_index + image_speed_raw >= image_number || image_index + image_speed_raw < 0){
	image_speed = 0;
}

for (var i = -1; 1 >= i; i += 2){
	for (var j = 1; -1 <= j; j -= 2){
		draw_sprite_ext(sprite_index, image_index, view_xview_nonsync + x, view_yview_nonsync + y, i * image_xscale, j * image_yscale, image_angle, image_blend, image_alpha);
	}
}

#define Menu_draw_sub_splat
if (image_index + image_speed_raw >= image_number || image_index + image_speed_raw < 0){
	image_speed = 0;
}

if (index == player_find_local_nonsync()){
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}

#define MenuItem_create(_x, _y)
with(instance_create(_x, _y, CustomObject)){
	depth = OPTION_DEPTH - 1;
	image_speed = 0.4;
	image_alpha = -1;
	
	spr_splat = [sprScoreSplat, 2];
	lst_splat = array_clone(spr_splat);
	box_splat = sprScoreSplat_bbox[2];
	
	visible_to = [];
	fake_nonsync = false;
	nonsync = -1;
	hover = false;
	selected = -1;
	noinput = [];
	
	display_override = "";
	value = null;
	lst_value = value;
	
	mod_source = `${mod_current}.${mod_current_type}`;
	name = "MenuItem";
	
	font = fntM;
	halign = fa_left;
	valign = fa_middle;
	
	rotspeed = 0;
	xflipspd = 0;
	yflipspd = 0;
	
	on_menu_step = [];
	on_menu_change = [];
	on_menu_draw = [];
	
	text_surface = -1;
	
	on_step = script_ref_create(MenuItem_step);
	on_draw = script_ref_create(MenuItem_draw);
	on_destroy = script_ref_create(MenuItem_destroy);
	on_cleanup = script_ref_create(MenuItem_destroy);
	
	return self;
}

#define MenuItem_step
if ("nonsync" in self && player_is_active(nonsync) && player_find_local_nonsync() != nonsync){
	exit;
}

if (DEBUG_LAG){
	trace_time();
}

image_angle = (((image_angle + rotspeed) % 360) + 360) % 360;
image_xscale += sin(current_frame) * xflipspd;
image_yscale += cos(current_frame) * yflipspd;

var _nonsync = false;

for (var p = 0; maxp > p; p ++){
	if (array_find_index(visible_to, p) >= 0){
		_nonsync = true;
		break;
	}
}

var _index = array_find_index(noinput, selected);

if (_index >= 0){
	var _new = array_slice(noinput, 0, _index);
	array_copy(_new, _index, noinput, _index + 1, array_length(noinput) - (_index + 1));
	noinput = _new;
}

var _hover = false;

for (var p = 0; maxp > p; p ++){
	if (player_is_active(p)){
		if (player_is_local_nonsync(p) && p != player_find_local_nonsync()){
			continue;
		}
		
		if (((selected == -1 && array_find_index(noinput, p) < 0) || selected == p) && (!_nonsync || array_find_index(visible_to, p) >= 0)){
			if (is_array(on_menu_step) && array_length(on_menu_step) >= 3 && mod_script_exists(on_menu_step[0], on_menu_step[1], on_menu_step[2])){
				var _h = mod_script_call(on_menu_step[0], on_menu_step[1], on_menu_step[2], false, p);
				
				if (_h && !_hover){
					_hover = true;
				}
			}
		}
	}
}

if (!_hover){
	hover = false;
}

if ((!fake_nonsync && value != lst_value) || (is_array(value) xor is_array(lst_value)) || (fake_nonsync && !array_equals(value, lst_value))){
	if (is_array(on_menu_change) && array_length(on_menu_change) >= 3 && mod_script_exists(on_menu_change[0], on_menu_change[1], on_menu_change[2])){
		mod_script_call(on_menu_change[0], on_menu_change[1], on_menu_change[2], value);
	}
	
	lst_value = (fake_nonsync ? array_clone(value) : value);
}

if (DEBUG_LAG){
	trace_time("MenuItem_step");
}

#define MenuItem_draw
if ("nonsync" in self && player_is_active(nonsync) && player_find_local_nonsync() != nonsync){
	exit;
}

if (DEBUG_LAG){
	trace_time();
}

var _nonsync = false;

for (var p = 0; maxp > p; p ++){
	if (array_find_index(visible_to, p) >= 0){
		_nonsync = true;
		break;
	}
}

var _visible = (_nonsync ? [] : -1);

if (_nonsync){
	for (var p = maxp - 1; 0 <= p; p --){
		_visible[p] = draw_get_visible(p);
	}
	
	draw_set_visible_all(false);
	
	for (var p = 0; maxp > p; p ++){
		if (array_find_index(visible_to, p) >= 0){
			draw_set_visible(p, true);
		}
	}
}

var _drawn = false;

var _halign = draw_get_halign();
var _valign = draw_get_valign();

draw_set_font(font);
draw_set_halign(halign);
draw_set_valign(valign);

if (!surface_exists(text_surface)){
	text_surface = surface_create(1, 1);
}

for (var p = 0; maxp > p; p ++){
	if (player_is_active(p)){
		if (player_is_local_nonsync(p) && p != player_find_local_nonsync()){
			continue;
		}
		
		if ((!_nonsync || array_find_index(visible_to, p) >= 0)){
			if (is_array(on_menu_draw) && array_length(on_menu_draw) >= 3 && mod_script_exists(on_menu_draw[0], on_menu_draw[1], on_menu_draw[2])){
				_drawn = mod_script_call(on_menu_draw[0], on_menu_draw[1], on_menu_draw[2], _drawn, p);
			}
		}
	}
}

draw_set_font(fntM);
draw_set_halign(_halign);
draw_set_valign(_valign);

if (_nonsync){
	draw_set_visible_all(true);
	
	for (var p = maxp - 1; 0 <= p; p --){
		draw_set_visible(p, _visible[p]);
	}
}

if (DEBUG_LAG){
	trace_time("MenuItem_draw");
}

#define MenuItem_draw_splat
if (DEBUG_LAG){
	trace_time();
}

if (is_real(creator) && floor(creator) == creator && instance_exists(creator)){
	var _splat = spr_splat;
	var _nonsync = visible_to;
	var _depth = depth;
	var _angle = image_angle;
	var _xscale = image_xscale;
	var _yscale = image_yscale;
	var _x = x;
	var _y = y;
	
	with(creator){
		_splat = spr_splat;
		_nonsync = visible_to;
		_depth = depth + 1;
		_angle = image_angle;
		_xscale = image_xscale;
		_yscale = image_yscale;
		_x = x;
		_y = y;
	}
	
	spr_splat = _splat;
	visible_to = array_clone(_nonsync);
	depth = _depth;
	image_angle = _angle;
	image_xscale = _xscale;
	image_yscale = _yscale;
	x = _x;
	y = _y;
}

else{
	instance_destroy();
	exit;
}

if (is_array(spr_splat) && array_length(spr_splat) >= 2 && sprite_exists(spr_splat[0]) && is_real(spr_splat[1]) && sprite_get_number(spr_splat[0]) > spr_splat[1]){
	if (!array_equals(spr_splat, lst_splat)){
		var _left = sprite_get_bbox_left(spr_splat);
		var _top = sprite_get_bbox_top(spr_splat);
		var _right = sprite_get_bbox_right(spr_splat);
		var _bottom = sprite_get_bbox_bottom(spr_splat);
		
		box_splat = [_left, _top, _right, _bottom, _left + ((_right - _left) >> 1), _top + ((_bottom - _top) >> 1)];
		lst_splat = array_clone(spr_splat);
	}
	
	sprite_index = spr_splat[0];
	
	var max_img = spr_splat[1];
	
	if (image_index + image_speed_raw >= max_img || image_index + image_speed_raw < 0){
		image_index = max_img;
		image_speed = 0;
	}
}

var _nonsync = false;

for (var p = 0; maxp > p; p ++){
	if (array_find_index(visible_to, p) >= 0){
		_nonsync = true;
		break;
	}
}

var _visible = (_nonsync ? [] : -1);

if (_nonsync){
	for (var p = maxp - 1; 0 <= p; p --){
		_visible[p] = draw_get_visible(p);
	}
	
	draw_set_visible_all(false);
	
	for (var p = 0; maxp > p; p ++){
		if (array_find_index(visible_to, p) >= 0){
			draw_set_visible(p, true);
		}
	}
}

draw_sprite_centered_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);

if (_nonsync){
	draw_set_visible_all(true);
	
	for (var p = maxp - 1; 0 <= p; p --){
		draw_set_visible(p, _visible[p]);
	}
}

if (DEBUG_LAG){
	trace_time("MenuItem_draw_splat");
}

#define MenuItem_destroy
if (surface_exists(text_surface)){
	surface_free(text_surface);
}

var _index = array_find_index(global.objects, self);

if (_index >= 0){
	var _new = array_slice(global.objects, 0, _index);
	array_copy(_new, _index, global.objects, _index + 1, array_length(global.objects) - (_index + 1));
	global.objects = _new;
}

// https://yal.cc/2d-pivot-points/
#define translate_rotate(_x, _y, _xlength, _ylength, _dir)
var new_x = _x + lengthdir_x(_xlength, _dir) + lengthdir_x(_ylength, _dir - 90);
var new_y = _y + lengthdir_y(_xlength, _dir) + lengthdir_y(_ylength, _dir - 90);
return [new_x, new_y];

#define sound_play_nonsync(_p, _sound)
if (sound_exists(_sound) && _p == player_find_local_nonsync()){
	sound_play(_sound);
}

#define sound_play_pitchvol_nonsync(_p, _sound, _pitch, _vol)
if (sound_exists(_sound) && is_real(_pitch) && is_real(_vol) && _p == player_find_local_nonsync()){
	sound_play_pitchvol(_sound, _pitch, _vol);
}

#define mouse_in_rectangle(_p, _x1, _y1, _x2, _y2, _gui)
var _x = _x1;
var _y = _y1;

_x1 = min(_x, _x2);
_y1 = min(_y, _y2);
_x2 = max(_x, _x2);
_y2 = max(_y, _y2);

var _players = [];

if (_p >= 0 && maxp > p){
	if (player_is_active(_p)){
		var _mx = mouse_x[_p] - (_gui ? view_xview[_p] : 0);
		var _my = mouse_y[_p] - (_gui ? view_yview[_p] : 0);
		
		if (_mx >= _x1 && _my >= _y1 && _mx <= _x2 && _my <= _y2){
			array_push(_players, _p);
		}
	}
}

else{
	for (var p = 0; maxp > p; p ++){
		if (player_is_active(p)){
			var _mx = mouse_x[p] - (_gui ? view_xview[p] : 0);
			var _my = mouse_y[p] - (_gui ? view_yview[p] : 0);
			
			if (_mx >= _x1 && _my >= _y1 && _mx <= _x2 && _my <= _y2){
				array_push(_players, p);
			}
		}
	}
}

return _players;

#define wrap_clamp(_value, _min, _max)
if (_value < _min){
	_value = _max;
}

else if (_value > _max){
	_value = _min;
}

return _value;

#define Slider_create(_x, _y)
with(MenuItem_create(_x, _y)){
	sprite_index = global.options_slider;
	
	spr_splat = [sprOptionSlider, 0];
	spr_front = [sprOptionSlider, 1];
	spr_end = [sprSliderEnd, 0];
	
	lst_splat = array_clone(spr_splat);
	lst_front = array_clone(spr_front);
	lst_end = array_clone(spr_end);
	
	box_splat = sprOptionSlider_bbox[0];
	box_front = sprOptionSlider_bbox[1];
	box_end = sprSliderEnd_bbox[0];
	
	range = [0, 1];
	steps = 0.001;
	button_steps = 0.1;
	display_multiplier = 100;
	decimal_places = 1;
	prefix = "";
	suffix = "%";
	color = [c_lime, c_lime];
	
	value = 0.5;
	sliding = -1;
	
	name = "Slider";
	
	var _splat = spr_splat;
	var _splast = lst_splat;
	var _box = box_splat;
	var _nonsync = visible_to;
	
	with(script_bind_draw(MenuItem_draw_splat, depth + 1)){
		x = _x;
		y = _y;
		name = script[2];
		
		creator = other;
		spr_splat = _splat;
		lst_splat = _splast;
		box_splat = _box;
		visible_to = array_clone(_nonsync);
	}
	
	on_menu_step = script_ref_create(Slider_step);
	on_menu_draw = script_ref_create(Slider_draw);
	
	return self;
}

#define Slider_step
/// Slider_step(_hover, p = 0)
var _hover = argument[0];
var p = argument_count > 1 ? argument[1] : 0;
var _pos = translate_rotate(x, y, (box_front[0] - box_front[4]) * image_xscale, (box_front[1] - box_front[5]) * image_yscale, image_angle);
var _x = _pos[0];
var _y = _pos[1];

var _end = translate_rotate(_x, _y, box_front[2] * image_xscale, box_front[3] * image_yscale, image_angle);

var _bpos = translate_rotate(_x, _y, (box_splat[0] - box_front[0]), (box_splat[1] - box_front[1]), image_angle);
var _bx = _bpos[0];
var _by = _bpos[1];

var top_left = translate_rotate(_bpos[0], _bpos[1], box_splat[0], box_splat[1], image_angle);
var bottom_right = translate_rotate(_bpos[0], _bpos[1], box_splat[2], box_splat[3], image_angle);

var _left = top_left[0];
var _top = top_left[1];
var _right = bottom_right[0];
var _bottom = bottom_right[1];

var _r = _right;
_right = max(_left, _r);
_left = min(_left, _r);

var _b = _bottom;
_bottom = max(_top, _b);
_top = min(_top, _b);

var dir_mult = ((image_angle + 270) % 360 > 180 ? 1 : -1);

var _mx = mouse_x[p];
var _my = mouse_y[p];

var _min = range[0];
var _max = range[1];
_min = (is_real(_min) ? _min : 0);
_max = (is_real(_max) ? _max : 1);

if (_min > _max){
	var _m = _max;
	_max = _min;
	_min = _m;
}

var _range = (_max - _min);

var _value = value;

if (fake_nonsync){
	if (!is_array(value)){
		value = array_clone(array_create(maxp, value));
	}
	
	_value = value[p];
}

var _width = (box_front[2] - box_front[0]) + 1;
var _percent = (_value - _min) / _range;
var x_mult = abs(lengthdir_x(_width, image_angle)) / _width;
var y_mult = abs(lengthdir_y(_width, image_angle)) / _width;

if (_mx >= _left && _my >= _top && _mx <= _right && _my <= _bottom){
	_hover = true;
	hover = true;
	
	if (sliding == -1 && button_pressed(p, "fire")){
		sound_play_pitchvol_nonsync(p, sndClick, _percent, 1);
		sliding = p;
	}
	
	if (sliding == p && array_length(range) >= 2){
		var _released = button_released(p, "fire");
		
		if (button_check(p, "fire") || _released){
			var use_this_for_x1 = min(_x, _end[0]);
			var use_this_for_x2 = max(_x, _end[0]);
			var use_this_for_y1 = min(_y, _end[1]);
			var use_this_for_y2 = max(_y, _end[1]);
			
			var _new = ((clamp(_mx, use_this_for_x1, use_this_for_x2) - use_this_for_x1) / _width * _range + _min) * x_mult + ((clamp(_my, use_this_for_y1, use_this_for_y2) - use_this_for_y1) / _width * _range + _min) * y_mult;
			
			_new = clamp(round(_new / steps) * steps, _min, _max);
			
			if (dir_mult == -1){
				_new = _max - _new;
			}
			
			if (_released){
				sound_play_pitchvol_nonsync(p, sndSliderLetGo, _new / _range, 1);
				sliding = -1;
				_value = _new;
			}
			
			else if (_value != _new){
				sound_play_pitchvol_nonsync(p, sndSlider, _new / _range, 1);
				_value = _new;
			}
		}
	}
}

if (_hover || selected == p){
	var _dir = sign(button_pressed(p, "east") - button_pressed(p, "west")) * dir_mult;
	
	if (_dir != 0){
		var _new = _value + (_dir * button_steps);
		
		_new = clamp(round(_new / steps) * steps, _min, _max);
		
		if (_value != _new){
			sound_play_pitchvol_nonsync(p, sndSlider, _new / _range, 1);
			_value = _new;
		}
	}
}

if (!fake_nonsync){
	if (_value != value){
		value = _value;
	}
}

else if (_value != value[p]){
	value[p] = _value;
}

return _hover;

#define Slider_draw
/// Slider_draw(_drawn, p = 0)
var _drawn = argument[0];
var p = argument_count > 1 ? argument[1] : 0;
var _min = range[0];
var _max = range[1];
_min = (is_real(_min) ? _min : 0);
_max = (is_real(_max) ? _max : 1);

if (_min > _max){
	var _m = _max;
	_max = _min;
	_min = _m;
}

var _value = value;

if (fake_nonsync){
	if (!is_array(value)){
		value = array_clone(array_create(maxp, value));
	}
	
	_value = value[p];
}

var _width = (box_front[2] - box_front[0]) + 1;
var _percent = (_value - _min) / (_max - _min);

if (!_drawn){
	_drawn = true;
	
	var _grey = (((selected == -1 && hover) || selected == p) ? c_white : $999999);
	var _blend = (((selected == -1 && hover) || selected == p) ? image_blend : $999999);
	var _alpha = image_alpha * -1;
	
	var _pos1 = translate_rotate(x, y, (box_front[0] - box_front[4]) * image_xscale, (box_front[1] - box_front[5]) * image_yscale, image_angle);
	
	var slider_blend = merge_color(color[0], color[1], _percent);
	
	draw_sprite_general(sprite_index, 1, box_front[0], box_front[1], _width * _percent, box_front[3], _pos1[0], _pos1[1], image_xscale, image_yscale, image_angle, slider_blend, slider_blend, slider_blend, slider_blend, _alpha);
	
	var _length = _width * _percent * image_xscale;
	var _pos2 = translate_rotate(x, y, _length - (_width >> 1), 0, image_angle);
	
	draw_sprite_centered_ext(spr_end[0], spr_end[1], _pos2[0], _pos2[1], image_xscale, image_yscale, image_angle, _grey, _alpha);
	
	var _digits = string_pos(".", string_auto(_value * display_multiplier)) - 1;
	_digits = max(_digits, 1);
	
	var _text = (display_override != "" ? string(display_override) : `${prefix}${string_format(_value * display_multiplier, _digits, decimal_places)}${suffix}`);
	var _measure = string_nt_clean(string_height_fix(_text));
	
	var _w = string_width(_measure);
	var _h = string_height(_measure);
	
	if (surface_exists(text_surface)){
		if (surface_get_width(text_surface) != _w + 1 || surface_get_height(text_surface) != _h + 1){
			surface_resize(text_surface, _w + 1, _h + 1);
		}
	}
	
	else{
		text_surface = surface_create(_w + 1, _h + 1);
	}
	
	surface_set_target(text_surface);
	
	draw_clear_alpha(c_black, 0);
	
	var _x = 0;
	var _y = 0;
	
	switch(halign){
		case fa_center: _x = _w >> 1; break;
		case fa_right: _x = _w; break;
	}
	
	switch(valign){
		case fa_middle: _y = _h >> 1; break;
		case fa_bottom: _y = _h; break;
	}
	
	draw_text_nt(_x, _y, _text);
	
	surface_reset_target();
	
	draw_surface_centered_ext(text_surface, x, y, image_xscale, image_yscale, image_angle, _blend, image_alpha * -1);
}

return _drawn;

#define Bool_create(_x, _y)
with(MenuItem_create(_x, _y)){
	sprite_index = sprScoreSplat;
	
	spr_splat = [sprScoreSplat, 2];
	
	lst_splat = array_clone(spr_splat);
	
	box_splat = sprScoreSplat_bbox[2];
	
	display = ["OFF", "ON"];
	
	value = false;
	
	name = "Bool";
	
	halign = fa_center;
	
	var _splat = spr_splat;
	var _splast = lst_splat;
	var _box = box_splat;
	var _nonsync = visible_to;
	
	with(script_bind_draw(MenuItem_draw_splat, depth + 1)){
		x = _x;
		y = _y;
		name = script[2];
		
		creator = other;
		spr_splat = _splat;
		lst_splat = _splast;
		box_splat = _box;
		visible_to = array_clone(_nonsync);
	}
	
	on_menu_step = script_ref_create(Bool_step);
	on_menu_draw = script_ref_create(Bool_draw);
	
	return self;
}

#define Bool_step
/// Bool_step(_hover, p = 0)
var _hover = argument[0];
var p = argument_count > 1 ? argument[1] : 0;
var _bx = x - box_splat[4] - box_splat[0];
var _by = y - box_splat[5] - box_splat[1];

var _left = _bx + box_splat[0];
var _top = _by + box_splat[1];
var _right = _bx + box_splat[2];
var _bottom = _by + box_splat[3];

var _mx = mouse_x[p];
var _my = mouse_y[p];

var _value = value;

if (fake_nonsync){
	if (!is_array(value)){
		value = array_clone(array_create(maxp, value));
	}
	
	_value = value[p];
}

if (_mx >= _left && _my >= _top && _mx <= _right && _my <= _bottom){
	_hover = true;
	hover = true;
	
	if (button_pressed(p, "fire")){
		_value = !_value;
		sound_play_pitchvol_nonsync(p, sndClick, 0.5 + _value, 1);
	}
}

if (_hover || selected == p){
	var _dir = sign(button_pressed(p, "east") - button_pressed(p, "west"));
	
	if (_dir != 0 || button_pressed(p, "okay") || button_pressed(p, "pick")){
		_value = !_value;
		sound_play_pitchvol_nonsync(p, sndClick, 0.5 + _value, 1);
	}
}

if (!fake_nonsync){
	if (_value != value){
		value = _value;
	}
}

else if (_value != value[p]){
	value[p] = _value;
}

return _hover;

#define Bool_draw
/// Bool_draw(_drawn, p = 0)
var _drawn = argument[0];
var p = argument_count > 1 ? argument[1] : 0;
var _value = value;

if (fake_nonsync){
	if (!is_array(value)){
		value = array_clone(array_create(maxp, value));
	}
	
	_value = value[p];
}

if (!_drawn){
	_drawn = true;
	
	var _grey = (((selected == -1 && hover) || selected == p) ? c_white : $999999);
	var _blend = (((selected == -1 && hover) || selected == p) ? image_blend : $999999);
	
	var _text = (display_override != "" ? string(display_override) : `${display[_value]}`);
	var _measure = string_nt_clean(string_height_fix(_text));
	
	var _w = string_width(_measure);
	var _h = string_height(_measure);
	
	if (surface_exists(text_surface)){
		if (surface_get_width(text_surface) != _w + 1 || surface_get_height(text_surface) != _h + 1){
			surface_resize(text_surface, _w + 1, _h + 1);
		}
	}
	
	else{
		text_surface = surface_create(_w + 1, _h + 1);
	}
	
	surface_set_target(text_surface);
	
	draw_clear_alpha(c_black, 0);
	
	var _x = 0;
	var _y = 0;
	
	switch(halign){
		case fa_center: _x = _w >> 1; break;
		case fa_right: _x = _w; break;
	}
	
	switch(valign){
		case fa_middle: _y = _h >> 1; break;
		case fa_bottom: _y = _h; break;
	}
	
	draw_text_nt(_x, _y, _text);
	
	surface_reset_target();
	
	draw_surface_centered_ext(text_surface, x, y, image_xscale, image_yscale, image_angle, _blend, image_alpha * -1);
}

return _drawn;

#define Int_create(_x, _y)
with(MenuItem_create(_x, _y)){
	sprite_index = sprScoreSplat;
	
	spr_splat = [sprScoreSplat, 2];
	
	lst_splat = array_clone(spr_splat);
	
	box_splat = sprScoreSplat_bbox[2];
	
	range = [-5, 5];
	steps = 1;
	wrap = true;
	prefix = "";
	suffix = "";
	
	value = 0;
	
	name = "Int";
	
	halign = fa_center;
	
	var _splat = spr_splat;
	var _splast = lst_splat;
	var _box = box_splat;
	var _nonsync = visible_to;
	
	with(script_bind_draw(MenuItem_draw_splat, depth + 1)){
		x = _x;
		y = _y;
		name = script[2];
		
		creator = other;
		spr_splat = _splat;
		lst_splat = _splast;
		box_splat = _box;
		visible_to = array_clone(_nonsync);
	}
	
	on_menu_step = script_ref_create(Int_step);
	on_menu_draw = script_ref_create(Int_draw);
	
	return self;
}

#define Int_step
/// Int_step(_hover, p = 0)
var _hover = argument[0];
var p = argument_count > 1 ? argument[1] : 0;
var _bx = x - box_splat[4] - box_splat[0];
var _by = y - box_splat[5] - box_splat[1];

var _left = _bx + box_splat[0];
var _top = _by + box_splat[1];
var _right = _bx + box_splat[2];
var _bottom = _by + box_splat[3];

var _mx = mouse_x[p];
var _my = mouse_y[p];

var _min = range[0];
var _max = range[1];
// swap these out for negative infinity and infinity once GMS2 builds are public
_min = (is_real(_min) ? _min : -1000000000);
_max = (is_real(_max) ? _max : 1000000000);

if (_min > _max){
	var _m = _max;
	_max = _min;
	_min = _m;
}

var _range = (_max - _min + 1);

var _value = value;

if (fake_nonsync){
	if (!is_array(value)){
		value = array_clone(array_create(maxp, value));
	}
	
	_value = value[p];
}

if (_mx >= _left && _my >= _top && _mx <= _right && _my <= _bottom){
	_hover = true;
	hover = true;
}

if (_hover || selected == p){
	var _dir = sign(button_pressed(p, "east") - button_pressed(p, "west"));
	
	if (_dir != 0){
		_value += (steps * _dir);
		sound_play_pitchvol_nonsync(p, sndClick, random_range(0.8, 1.2), 1);
		
		if (_value > _max || _value < _min){
			if (wrap){
				_value = wrap_clamp(_value, _min, _max);
			}
			
			else{
				_value = clamp(_value, _min, _max);
			}
		}
	}
}

if (!fake_nonsync){
	if (_value != value){
		value = _value;
	}
}

else if (_value != value[p]){
	value[p] = _value;
}

return _hover;

#define Int_draw
/// Int_draw(_drawn, p = 0)
var _drawn = argument[0];
var p = argument_count > 1 ? argument[1] : 0;
var _value = value;

if (fake_nonsync){
	if (!is_array(value)){
		value = array_clone(array_create(maxp, value));
	}
	
	_value = value[p];
}

if (!_drawn){
	_drawn = true;
	
	var _grey = (((selected == -1 && hover) || selected == p) ? c_white : $999999);
	var _blend = (((selected == -1 && hover) || selected == p) ? image_blend : $999999);
	
	var _text = (display_override != "" ? string(display_override) : `${prefix}${string_auto(_value)}${suffix}`);
	var _measure = string_nt_clean(string_height_fix(_text));
	
	var _w = string_width(_measure);
	var _h = string_height(_measure);
	
	if (surface_exists(text_surface)){
		if (surface_get_width(text_surface) != _w + 1 || surface_get_height(text_surface) != _h + 1){
			surface_resize(text_surface, _w + 1, _h + 1);
		}
	}
	
	else{
		text_surface = surface_create(_w + 1, _h + 1);
	}
	
	surface_set_target(text_surface);
	
	draw_clear_alpha(c_black, 0);
	
	var _x = 0;
	var _y = 0;
	
	switch(halign){
		case fa_center: _x = _w >> 1; break;
		case fa_right: _x = _w; break;
	}
	
	switch(valign){
		case fa_middle: _y = _h >> 1; break;
		case fa_bottom: _y = _h; break;
	}
	
	draw_text_nt(_x, _y, _text);
	
	surface_reset_target();
	
	draw_surface_centered_ext(text_surface, x, y, image_xscale, image_yscale, image_angle, _blend, image_alpha * -1);
}

return _drawn;

#define Cycle_create(_x, _y)
with(MenuItem_create(_x, _y)){
	sprite_index = sprScoreSplat;
	
	spr_splat = [sprScoreSplat, 2];
	
	lst_splat = array_clone(spr_splat);
	
	box_splat = sprScoreSplat_bbox[2];
	
	choices = ["this", "is", "a", "cycle"];
	display = array_clone(choices);
	
	value = 0;
	
	name = "Cycle";
	
	halign = fa_center;
	
	var _splat = spr_splat;
	var _splast = lst_splat;
	var _box = box_splat;
	var _nonsync = visible_to;
	
	with(script_bind_draw(MenuItem_draw_splat, depth + 1)){
		x = _x;
		y = _y;
		name = script[2];
		
		creator = other;
		spr_splat = _splat;
		lst_splat = _splast;
		box_splat = _box;
		visible_to = array_clone(_nonsync);
	}
	
	on_menu_step = script_ref_create(Cycle_step);
	on_menu_draw = script_ref_create(Cycle_draw);
	
	return self;
}

#define Cycle_step
/// Cycle_step(_hover, p = 0)
var _hover = argument[0];
var p = argument_count > 1 ? argument[1] : 0;
var _bx = x - box_splat[4] - box_splat[0];
var _by = y - box_splat[5] - box_splat[1];

var _left = _bx + box_splat[0];
var _top = _by + box_splat[1];
var _right = _bx + box_splat[2];
var _bottom = _by + box_splat[3];

var _mx = mouse_x[p];
var _my = mouse_y[p];

var _value = value;

if (fake_nonsync){
	if (!is_array(value)){
		value = array_clone(array_create(maxp, value));
	}
	
	_value = value[p];
}

var choice_count = array_length(choices);
var _index = array_find_index(choices, _value);
_index = (_index >= 0 ? _index : 0);

if (_mx >= _left && _my >= _top && _mx <= _right && _my <= _bottom){
	_hover = true;
	hover = true;
	
	if (button_pressed(p, "fire")){
		_index += 1;
		sound_play_pitchvol_nonsync(p, sndClick, random_range(0.8, 1.2), 1);
	}
}

if (_hover || selected == p){
	var _dir = sign((button_pressed(p, "east") || button_pressed(p, "okay") || button_pressed(p, "pick")) - button_pressed(p, "west"));
	
	if (_dir != 0){
		_index += _dir;
		sound_play_pitchvol_nonsync(p, sndClick, random_range(0.8, 1.2), 1);
	}
}

_index = wrap_clamp(_index, 0, choice_count - 1);
_value = choices[_index];

if (!fake_nonsync){
	if (_value != value){
		value = _value;
	}
}

else if (_value != value[p]){
	value[p] = _value;
}

return _hover;

#define Cycle_draw
/// Cycle_draw(_drawn, p = 0)
var _drawn = argument[0];
var p = argument_count > 1 ? argument[1] : 0;
var _value = value;

if (fake_nonsync){
	if (!is_array(value)){
		value = array_clone(array_create(maxp, value));
	}
	
	_value = value[p];
}

if (!_drawn){
	_drawn = true;
	
	var _grey = (((selected == -1 && hover) || selected == p) ? c_white : $999999);
	var _blend = (((selected == -1 && hover) || selected == p) ? image_blend : $999999);
	
	var _index = array_find_index(choices, _value);
	_index = (_index >= 0 ? _index : 0);
	
	var _display = (is_array(display) ? display : array_clone(choices));
	
	var _text = (display_override != "" ? string(display_override) : `${_display[_index]}`);
	var _measure = string_nt_clean(string_height_fix(_text));
	
	var _w = string_width(_measure);
	var _h = string_height(_measure);
	
	if (surface_exists(text_surface)){
		if (surface_get_width(text_surface) != _w + 1 || surface_get_height(text_surface) != _h + 1){
			surface_resize(text_surface, _w + 1, _h + 1);
		}
	}
	
	else{
		text_surface = surface_create(_w + 1, _h + 1);
	}
	
	surface_set_target(text_surface);
	
	draw_clear_alpha(c_black, 0);
	
	var _x = 0;
	var _y = 0;
	
	switch(halign){
		case fa_center: _x = _w >> 1; break;
		case fa_right: _x = _w; break;
	}
	
	switch(valign){
		case fa_middle: _y = _h >> 1; break;
		case fa_bottom: _y = _h; break;
	}
	
	draw_text_nt(_x, _y, _text);
	
	surface_reset_target();
	
	draw_surface_centered_ext(text_surface, x, y, image_xscale, image_yscale, image_angle, _blend, image_alpha * -1);
}

return _drawn;

#define Text_create(_x, _y)
with(MenuItem_create(_x, _y)){
	sprite_index = sprOptionSlider;
	
	spr_splat = [sprOptionSlider, 0];
	
	lst_splat = array_clone(spr_splat);
	
	box_splat = sprOptionSlider_bbox[0];
	
	input = -1;
	value = "Enter text here";
	
	name = "Text";
	
	halign = fa_right;
	
	var _splat = spr_splat;
	var _splast = lst_splat;
	var _box = box_splat;
	var _nonsync = visible_to;
	
	with(script_bind_draw(MenuItem_draw_splat, depth + 1)){
		x = _x;
		y = _y;
		name = script[2];
		
		creator = other;
		spr_splat = _splat;
		lst_splat = _splast;
		box_splat = _box;
		visible_to = array_clone(_nonsync);
	}
	
	on_menu_step = script_ref_create(Text_step);
	on_menu_draw = script_ref_create(Text_draw);
	
	return self;
}

#define Text_step
/// Text_step(_hover, p = 0)
var _hover = argument[0];
var p = argument_count > 1 ? argument[1] : 0;
var _bx = x - box_splat[4] - box_splat[0];
var _by = y - box_splat[5] - box_splat[1];

var _left = _bx + box_splat[0];
var _top = _by + box_splat[1];
var _right = _bx + box_splat[2];
var _bottom = _by + box_splat[3];

var _mx = mouse_x[p];
var _my = mouse_y[p];

var _value = value;

if (fake_nonsync){
	if (!is_array(value)){
		value = array_clone(array_create(maxp, value));
	}
	
	_value = value[p];
}

if (_mx >= _left && _my >= _top && _mx <= _right && _my <= _bottom){
	_hover = true;
	hover = true;
}

if ((input == -1 || input == p) && (_hover || selected == p)){
	var _okay = button_pressed(p, "okay");
	var _fire = button_pressed(p, "fire");
	var _pick = button_pressed(p, "pick");
	
	if ((_hover && (_okay || _pick)) || _fire){
		input = (input == p ? -1 : p);
		selected = input;
	}
	
	else if (selected == p && (_okay || _pick)){
		input = (input == p ? -1 : p);
		selected = input;
	}
}

if (!fake_nonsync){
	if (_value != value){
		value = _value;
	}
}

else if (_value != value[p]){
	value[p] = _value;
}

return _hover;

#define Text_draw
/// Text_draw(_drawn, p = 0)
var _drawn = argument[0];
var p = argument_count > 1 ? argument[1] : 0;
var _value = value;

if (fake_nonsync){
	if (!is_array(value)){
		value = array_clone(array_create(maxp, value));
	}
	
	_value = value[p];
}

var _text = _value;

if (input == p){
	_text = (current_frame % (current_time_scale * 40) < current_time_scale * 20 ? "|" : "");
}

if (!_drawn){
	_drawn = true;
	
	var _grey = (((selected == -1 && hover) || selected == p) ? c_white : $999999);
	var _blend = (((selected == -1 && hover) || selected == p) ? image_blend : $999999);
	
	var _measure = string_nt_clean(string_height_fix((display_override != "" ? string(display_override) : _text)));
	
	var _w = string_width(_measure);
	var _h = string_height(_measure);
	
	if (surface_exists(text_surface)){
		if (surface_get_width(text_surface) != _w + 1 || surface_get_height(text_surface) != _h + 1){
			surface_resize(text_surface, _w + 1, _h + 1);
		}
	}
	
	else{
		text_surface = surface_create(_w + 1, _h + 1);
	}
	
	surface_set_target(text_surface);
	
	draw_clear_alpha(c_black, 0);
	
	var _x = 0;
	var _y = 0;
	
	switch(halign){
		case fa_center: _x = _w >> 1; break;
		case fa_right: _x = _w; break;
	}
	
	switch(valign){
		case fa_middle: _y = _h >> 1; break;
		case fa_bottom: _y = _h; break;
	}
	
	draw_text_nt(_x, _y, _text);
	
	surface_reset_target();

	var _width = (box_splat[2] - box_splat[0]) + 1;
	var _pos = translate_rotate(x, y, -(_width >> 1) + (_w >> 1), 0, image_angle);
	draw_surface_centered_ext(text_surface, _pos[0], _pos[1], image_xscale, image_yscale, image_angle, _blend, image_alpha * -1);
}

return _drawn;

#define chat_message(_msg, _p)
var _any = instances_matching(global.objects, "selected", _p);

if (array_length(_any)){
	with(_any){
		var _number = string_realize(_msg);
		
		if (_number != null){
			switch(string_lower(name)){
				case "int":
				case "slider": value = _number / ("display_multiplier" in self ? display_multiplier : 1); return true;
			}
		}
	}
}

var _matching = instances_matching(instances_matching(CustomObject, "mod_source", `${mod_current}.${mod_current_type}`), "input", _p);

if (array_length(_matching)){
	with(_matching){
		if (string_pos("Text", name) == 1){
			if (!fake_nonsync){
				value = _msg;
			}
			
			else{
				value[_p] = _msg;
			}
			
			selected = -1;
			input = -1;
		}
	}
	
	return true;
}

#define Keys_create(_x, _y)
with(MenuItem_create(_x, _y)){
	sprite_index = sprOptionSlider;
	
	spr_splat = [sprOptionSlider, 0];
	
	lst_splat = array_clone(spr_splat);
	
	box_splat = sprOptionSlider_bbox[0];
	
	delim = "+";
	timer = 0;
	input = -1;
	style = "text";
	
	value = "pick" + delim + "swap";
	
	name = "Keys";
	
	halign = fa_center;
	
	var _splat = spr_splat;
	var _splast = lst_splat;
	var _box = box_splat;
	var _nonsync = visible_to;
	
	with(script_bind_draw(MenuItem_draw_splat, depth + 1)){
		x = _x;
		y = _y;
		name = script[2];
		
		creator = other;
		spr_splat = _splat;
		lst_splat = _splast;
		box_splat = _box;
		visible_to = array_clone(_nonsync);
	}
	
	on_menu_step = script_ref_create(Keys_step);
	on_menu_draw = script_ref_create(Keys_draw);
	
	return self;
}

#define Keys_step
/// Keys_step(_hover, p = 0)
var _hover = argument[0];
var p = argument_count > 1 ? argument[1] : 0;
var _bx = x - box_splat[4] - box_splat[0];
var _by = y - box_splat[5] - box_splat[1];

var _left = _bx + box_splat[0];
var _top = _by + box_splat[1];
var _right = _bx + box_splat[2];
var _bottom = _by + box_splat[3];

var _mx = mouse_x[p];
var _my = mouse_y[p];

var _value = value;

if (fake_nonsync){
	if (!is_array(value)){
		value = array_clone(array_create(maxp, value));
	}
	
	_value = value[p];
}

if (_mx >= _left && _my >= _top && _mx <= _right && _my <= _bottom){
	_hover = true;
	hover = true;
}

if ((input == -1 || input == p) && (_hover || selected == p)){
	var _okay = button_pressed(p, "okay");
	var _fire = button_pressed(p, "fire");
	
	if ((_hover && (_okay || (input == -1 && _fire))) || (!_hover && _fire)){
		input = (input == p ? -1 : p);
		selected = input;
	}
	
	else if (selected == p && _okay){
		input = (input == p ? -1 : p);
		selected = input;
	}
}

var my_keys = (timer ? string_split(_value, delim) : []);
var key_count = 0;

var _combo = "";

if (input == p){
	var _timer = timer;
	var _style = style;
	
	var _buttons = ["nort", "sout", "west", "east", "fire", "spec", "swap", "pick", "key1", "key2", "key3", "key4", "key5", "key6", "key7", "key8", "key9"];
	
	with(_buttons){
		if ((self != "fire" || _timer) && button_check(p, self) && array_find_index(my_keys, self) < 0){
			key_count += 1;
			
			array_push(my_keys, self);
		}
	}
}

if (key_count){
	timer = 15;
}

if (timer){
	timer -= current_time_scale;
	_value = array_join(my_keys, delim);
}

if (!fake_nonsync){
	if (_value != value){
		value = _value;
	}
}

else if (_value != value[p]){
	value[p] = _value;
}

return _hover;

#define Keys_draw
/// Keys_draw(_drawn, p = 0)
var _drawn = argument[0];
var p = argument_count > 1 ? argument[1] : 0;
var _value = value;

if (fake_nonsync){
	if (!is_array(value)){
		value = array_clone(array_create(maxp, value));
	}
	
	_value = value[p];
}

var _combo = "";

var _buttons = ["nort", "sout", "west", "east", "fire", "spec", "swap", "pick", "key1", "key2", "key3", "key4", "key5", "key6", "key7", "key8", "key9"];

if (style != "text"){
	with(string_split(_value, delim)){
		var is_number = (string_pos("key", self) == 1);
		_combo += `+@3(sprKeySmall:${(is_number ? 48 + real(string_char_at(self, 4)) : self)})`;
	}
}

if (style != "text"){
	_combo = string_delete(_combo, 1, 1);
}

else{
	_combo = _value;
}

if (!_drawn){
	_drawn = true;
	
	var _grey = (((selected == -1 && hover) || selected == p) ? c_white : $999999);
	var _blend = (((selected == -1 && hover) || selected == p) ? image_blend : $999999);
	
	var _text = (display_override != "" ? string(display_override) : _combo);
	var _measure = string_nt_clean(string_height_fix(_text));
	
	var _w = string_width(_measure);
	var _h = string_height(_measure);
	
	if (surface_exists(text_surface)){
		if (surface_get_width(text_surface) != _w + 1 || surface_get_height(text_surface) != _h + 1){
			surface_resize(text_surface, _w + 1, _h + 1);
		}
	}
	
	else{
		text_surface = surface_create(_w + 1, _h + 1);
	}
	
	surface_set_target(text_surface);
	
	draw_clear_alpha(c_black, 0);
	
	var _x = 0;
	var _y = 0;
	
	switch(halign){
		case fa_center: _x = _w >> 1; break;
		case fa_right: _x = _w; break;
	}
	
	switch(valign){
		case fa_middle: _y = _h >> 1; break;
		case fa_bottom: _y = _h; break;
	}
	
	draw_text_nt(_x, _y, _text);
	
	surface_reset_target();
	
	draw_surface_centered_ext(text_surface, x, y, image_xscale, image_yscale, image_angle, _blend, image_alpha * -1);
}

return _drawn;

#define lq_merge(_old, _new, _overwrite)
var _return = {};

with([_old, _new]){
	var _size = lq_size(self);
	
	for (var i = 0; _size > i; i ++){
		var _key = lq_get_key(self, i);
		var _value = lq_get_value(self, i);
		
		if (_overwrite || !lq_exists(_return, _key)){
			lq_set(_return, _key, _value);
		}
	}
}

return _return;

#define lq_delete(_lq, _field)
var o = {};

var _size = lq_size(_lq);

for (var i = 0; _size > i; i ++){
	var _key = lq_get_key(_lq, i);
	
	if (_key != _field){
		lq_set(o, _key, lq_get(_lq, _key));
	}
}

return o;

#define draw_sprite_centered_ext(_sprite, _subimage, _x, _y, _xscale, _yscale, _angle, _blend, _alpha)
/*
Draw a sprite centered, with all draw_sprite_ext arguments
*/
var _xoff = sprite_get_xoffset(_sprite);
var _yoff = sprite_get_yoffset(_sprite);

var _l = sprite_get_bbox_left(_sprite);
var _t = sprite_get_bbox_top(_sprite);
var _w = (sprite_get_bbox_right(_sprite) - _l + 1);
var _h = (sprite_get_bbox_bottom(_sprite) - _t + 1);

var _xlen = _xoff - _l - (_w >> 1);
var _ylen = _yoff - _t - (_h >> 1);

var new_x = _x + (lengthdir_x(_xlen, _angle) + lengthdir_x(_ylen, _angle - 90)) * _xscale;
var new_y = _y + (lengthdir_y(_xlen, _angle) + lengthdir_y(_ylen, _angle - 90)) * _yscale;

draw_sprite_ext(_sprite, _subimage, new_x, new_y, _xscale, _yscale, _angle, _blend, _alpha);

#define draw_surface_centered_ext(_surface, _x, _y, _xscale, _yscale, _angle, _blend, _alpha)
/*
Draw a sprite centered, with all draw_sprite_ext arguments
*/
var _w = surface_get_width(_surface);
var _h = surface_get_height(_surface);

var _xlen = -(_w >> 1);
var _ylen = -(_h >> 1);

var new_x = _x + (lengthdir_x(_xlen, _angle) + lengthdir_x(_ylen, _angle - 90)) * _xscale;
var new_y = _y + (lengthdir_y(_xlen, _angle) + lengthdir_y(_ylen, _angle - 90)) * _yscale;

draw_surface_ext(_surface, new_x, new_y, _xscale, _yscale, _angle, _blend, _alpha);

#define surface_cleared(_surface)
/*
Returns true if the surface has been cleared by any unexpected means
	(window resizing, being an inactive window for a while, anything previously undetectable)
*/
var _string = string(surface_get_texture(_surface));
return (string_count("0", _string) == string_length(_string));

#define string_nt_clean(_string)
/*
Remove draw_text_nt tags from a string while preserving @[0-9] spacing
Good for when you need the width of a tagged string
*/
if (global.cleaned_strings[? _string] != null){
	return global.cleaned_strings[? _string];
}

var _original = _string;
var _length = string_length(_string);
var _pos = 1;

while (_length >= _pos){
	var _tag = scan_substring("@", _string, _pos);
	
	if (_tag > _pos){
		var _valid = (scan_character_set("SWDRGBPYQswdrgbpyq", _string, _tag) > _tag);
		
		if (_valid){
			_string = string_delete(_string, _pos, 2);
			_length -= 2;
			continue;
		}
		
		_valid = (scan_character_set("0-9", _string, _tag) > _tag);
		
		if (_valid){
			var _start = (scan_substring("(", _string, _tag + _valid) > _tag + _valid);
			
			if (_start){
				var _end = scan_substring(")", _string, _tag + _valid + _start, true);
				
				if (_end > _tag + _valid + _start){
					var _spaces = real(string_char_at(_string, _tag));
					
					_string = string_delete(_string, _pos, _end - _pos + 1);
					_string = string_insert(string_repeat(" ", _spaces), _string, _pos);
					_pos += _spaces;
					
					continue;
				}
			}
		}
		
		_pos = _tag + _valid;
	}
	
	_pos += 1;
}

global.cleaned_strings[? _original] = _string;
return _string;

#define string_realize
/// string_realize(_string, _pos = 1)
/*
Convert any leading signs and digits in a string to a number
*/
var _string = argument[0];
var _pos = argument_count > 1 ? argument[1] : 1;
var _sign = scan_character_set("-+", _string, _pos);
var _num = scan_unsigned_number(_string, _sign);

if (_num > _sign){
	var _slice = string_copy(_string, _pos, _num);
	return real(string_copy(_string, _sign, _num)) * (((string_count("-", _slice) & 1) * -2) + 1);
}

return null;

#define string_height_fix(_string)
/*
Replace non-escaped "#"s in a string with a newline character
Intended for 9944 where string_height doesn't count "#" as a new line
*/
var _length = string_length(_string);
var _pos = scan_substring("#", _string, 1, true);
var _n = chr(10);

while (_length >= _pos){
	var _char = string_char_at(_string, _pos - 1);
	var _next = string_char_at(_string, _pos);
	
	if (_next == "#"){
		if (_char == "\"){
			_string = string_delete(_string, _pos - 1, 1);
			_length -= 1;
		}
		
		else{
			_string = string_delete(_string, _pos, 1);
			_string = string_insert(_n, _string, _pos);
			_length -= 1;
		}
	}
	
	_pos = scan_substring("#", _string, _pos + 1, true);
}

return _string;

#define scan_unsigned_number(_string, _pos)
/*
Parse a series of digits that may or may not have a decimal point and return the next string index
*/
return scan_digits(_string, scan_substring(".", _string, scan_digits(_string, _pos)));

#define scan_character_set(_set, _string, _pos)
/*
Parse a regex-like character set and return the next string index
*/
var character_set = character_set_create(_set);
return scan_characters(character_set, _string, _pos, character_set.inverted);

#define character_set_create(_string)
/*
Turn the input string into a lightweight object that has every contained character as a field
Part of scan_character_set, not intended for external use
*/
if (global.character_sets[? _string] != null){
	return global.character_sets[? _string];
}

var _length = string_length(_string);

if (!_length){
	return null;
}

var _characters = {};
var in_brackets = (string_pos("[", _string) == 1 && string_char_at(_string, _length) == "]");
var _inverted = (string_pos("^", _string) == 1 + in_brackets);
var _pos = 1 + in_brackets + _inverted;

var _last = "";
_characters.inverted = _inverted;
_length -= in_brackets;

while (_length >= _pos){
	var _char = string_char_at(_string, _pos ++);
	
	switch(_char){
		case "-":{
			if (_pos > 2){
				if (_last != "\" && _length >= _pos){
					var _next = string_ord_at(_string, _pos ++);
					
					for (var i = ord(_last); _next >= i; i ++){
						lq_set(_characters, chr(i), true);
					}
					
					break;
				}
			}
		}
		
		default: lq_set(_characters, _char, true); break;
	}
	
	_last = _char;
}

global.character_sets[? _string] = _characters;
return _characters;

#define scan_characters
/*
Parse a series of characters depending on if they're present as keys in the _characters lightweight object
Part of scan_character_set, not intended for external use
*/
/// scan_characters(_characters, _string, _pos, _inverted = false)
var _characters = argument[0], _string = argument[1], _pos = argument[2];
var _inverted = argument_count > 3 ? argument[3] : false;
var _length = string_length(_string);
var _index = _pos;

while (_length >= _pos && (lq_exists(_characters, string_char_at(_string, _index)) xor _inverted)){
	_index += 1;
}

return _index;

#define scan_substring
/*
Parse a substring of _string and return the next string index
*/
/// scan_substring(_sub, _string, _pos, _inverted = false)
var _sub = argument[0], _string = argument[1], _pos = argument[2];
var _inverted = argument_count > 3 ? argument[3] : false;
var sub_pos = string_pos_ext(_sub, _string, _pos);

if (_inverted){
	return (sub_pos ? sub_pos : string_length(_string) + 1);
}

else{
	return (sub_pos == _pos ? _pos + string_length(_sub) : _pos);
}

#define string_pos_ext(_sub, _string, _pos)
/*
Get the position of a substring in _string, starting at _pos
*/
var _slice = string_pos(_sub, string_copy(_string, _pos, (string_length(_string) + 1) - _pos));
return (_slice ? _pos + _slice - 1 : _slice);

#define scan_digits
/*
Parse a series of digits and return the next string index
*/
/// scan_digits(_string, _pos, _inverted = false)
var _string = argument[0], _pos = argument[1];
var _inverted = argument_count > 2 ? argument[2] : false;
var _length = string_length(_string);
var _index = _pos;

while (_length >= _index && (string_digits(string_char_at(_string, _index)) != "" xor _inverted)){
	_index += 1;
}

return _index;

#define recursive_cleanup(_structure)
var _data = {};

if (ds_list_valid(_structure)){
	lq_set(_data, "type", ds_type_list);
	lq_set(_data, "data", []);
	var _lists = lq_get(_data, "data");
	
	var _size = ds_list_size(_structure);
	var _index = 0;
	var add_to = null;
	
	for (var i = 0; _size > i; i ++){
		var list_index = i % 32000;
		
		if (!list_index){
			array_push(_lists, []);
			add_to = _lists[_index];
			_index += 1;
		}
		
		array_push(add_to, recursive_cleanup(_structure[| i]));
	}
	
	ds_list_destroy(_structure);
}

else if (ds_map_valid(_structure)){
	lq_set(_data, "type", ds_type_map);
	lq_set(_data, "data", []);
	var _maps = lq_get(_data, "data");
	
	with(ds_map_keys(_structure)){
		array_push(_maps, [self, recursive_cleanup(_structure[? self])]);
	}
	
	ds_map_destroy(_structure);
}

else if (ds_grid_valid(_structure)){
	lq_set(_data, "type", ds_type_map);
	lq_set(_data, "data", []);
	var _grids = lq_get(_data, "data");
	
	var _width = ds_grid_width(_structure);
	var _height = ds_grid_height(_structure);
	
	for (var i = 0; _width > i; i ++){
		_grids[i] = [];
		
		for (var j = 0; _height > j; j ++){
			_grids[i][@j] = recursive_cleanup(_structure[# i, j]);
		}
	}
	
	ds_grid_destroy(_structure);
}

else if (is_array(_structure)){
	var _size = array_length(_structure);
	
	for (var i = 0; _size > i; i ++){
		_structure[@i] = recursive_cleanup(_structure[i]);
	}
}

else if (is_object(_structure)){
	var _size = lq_size(_structure);
	
	for (var i = 0; _size > i; i ++){
		lq_set(_structure, lq_get_key(_structure, i), recursive_cleanup(lq_get_value(_structure, i)));
	}
}

else if (is_real(_structure) && floor(_structure) == _structure){
	if (_structure > sprTV5A && sprite_exists(_structure)){
		sprite_delete(_structure);
	}
	
	else if (_structure > sndStrongSpiritLost && sound_exists(_structure)){
		sound_delete(_structure);
	}
}

else if (surface_exists(_structure)){
	surface_free(_structure);
}

if (lq_size(_data)){
	return _data;
}

return _structure;

#define recursive_restore(_data)
if (!is_object(_data) || !"type" in _data || !"data" in _data){
	return _data;
}

var _stored = lq_get(_data, "data");
var stored_size = array_length(_stored);

switch(lq_get(_data, "type")){
	case ds_type_list:{
		var _list = ds_list_create();
		
		for (var i = 0; stored_size > i; i ++){
			var _segment = _stored[i];
			var segment_size = array_length(_segment);
			
			for (var j = 0; segment_size > j; j ++){
				ds_list_add(_list, recursive_restore(_segment[j]));
			}
		}
		
		return _list;
	}
	
	case ds_type_map:{
		var _map = ds_map_create();
		
		for (var i = 0; stored_size > i; i ++){
			var _pair = _stored[i];
			_map[? _pair[0]] = recursive_restore(_pair[1]);
		}
		
		return _map;
	}
	
	case ds_type_grid:{
		var _width = stored_size;
		var _height = array_length(_stored[0]);
		
		var _grid = ds_grid_create(_width, _height);
		
		for (var i = 0; _width > i; i ++){
			for (var j = 0; _height > j; j ++){
				_grid[# i, j] = recursive_restore(_stored[i][@j]);
			}
		}
		
		return _grid;
	}
}

return _data;
