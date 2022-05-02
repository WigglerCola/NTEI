#define init

//Default Settings values:

global.options = {
    
// Gameplay Settings:
"setting_loopspawns": true,	
"setting_unlockall": false,	

// Visual Settings:
"setting_vanillaglow": true,	
"setting_confetticount": 10,    
"setting_respritemode": false,

};

global.loaded = false;

if (fork()){
	while (!mod_script_exists("mod", "options", "scr_import")){
		wait(0);
	}
	
	if (mod_script_exists("mod", "options", "scr_import")){
		mod_script_call_nc("mod", "options", "scr_import", script_ref_create(0));
	}
	
	call(scr.option_add_page, mod_current_type, mod_current, "options", "NTEI", "GAMEPLAY", {

		"test_title": {"name": "GAMEPLAY OPTIONS", "type": "title", "desc": "These options are for gameplay effects"},

		"setting_loopspawns": {"name": "LOOP SPAWNS", "type": "bool", "desc": "Makes NTEI enemies spawn in the #main path during loop#Default: ON", "display": ["OFF", "ON"]},
		"setting_unlockall": {"name": "@rUNLOCK ALL", "type": "bool", "desc": "UNLOCKS ALL CONTENT WHEN ENABLED#@rIDK IF IT SAVES PROGRESS#@rARE YOU SURE THIS IS WHAT YOU WANT?", "display": ["OFF", "ON"]},

	});
	
	call(scr.option_add_page, mod_current_type, mod_current, "options", "NTEI", "VISUALS", {
	    
		"test_title": {"name": "VISUAL OPTIONS", "type": "title", "desc": "These options are for visual effects"},

		"setting_vanillaglow": {"name": "VANILLAGLOW", "type": "bool", "desc": "Makes some vanilla objects #@yglow in the dark#@wDefault: ON", "display": ["OFF", "ON"]},
		"setting_lightningflash": {"name": "LIGHTNING FLASH", "type": "bool", "desc": "Causes thunderstorm lightning #strikes to flash #@wDefault: ON", "display": ["OFF", "ON"]},
		"setting_confetticount": {"name": "MAX CONFETTI", "type": "slider", "desc": "How much confetti is allowed to exist#before it gets cleaned#@rlower this number if #@rconfetti is lagging your game#@wDEFAULT: 1000", "range": [0, 20], "prefix": "", "suffix": "", "steps": 0.001, "button_steps": 0.1, "display_multiplier": 100, "decimal_places": 0, "color": [c_lime, c_lime]},
		"setting_respritemode": {"name": "RESPRITE MODE", "type": "bool", "desc": "Changes some objects' appearences #to fit in with my resprites better#@ryou'll probably want this off", "display": ["OFF", "ON"]},
		
	});

	mod_script_call("mod", "options", "option_add_page", "mod", mod_current, "settings", "NTEI", "CREDITS", {

	  ei_credits_title: {name: "NTEI#By Wiggler Cola", type: "title", desc: "I made this",},
	  ei_credits_title2: {name: "CONTRIBUTORS:", type: "title", desc: "thank u",pixels:6},
	  ei_credits_title3: {name: "Im gonna put everyone here#after I figure out#how to use this thing", type: "title", desc: "WHY COLOR NOT WORK >:("},
	});
	
	exit;
}

// load our options
load_options();

global.my_variable = false;

var _persist = instances_matching(CustomObject, CONTROLLER, mod_current);

if (array_length(_persist) > 0){
	var _restored = false;
	
	with(_persist){
		if (!_restored){
			_restored = true;
			
			global.my_variable = my_variable;
		}
		
		instance_delete(self);
	}
}

#define cleanup
with(instance_create(0, 0, CustomObject)){
	variable_instance_set(self, CONTROLLER, mod_current);
	persistent = true;
	
	my_variable = global.my_variable;
}

save_options();

// remove our options from Custom Options
call(scr.option_remove_mod, mod_current_type, mod_current);

#macro CURRENT_FRAME_ACTIVE ((current_frame % 1) < current_time_scale)
#macro mod_current_type script_ref_create(0)[0]

#macro scr global.scr
#macro call script_ref_call

#macro CONTROLLER mod_current + + "." + mod_current_type + " controller"

#define save_options()
string_save(json_encode(global.options, chr(9)), "ExIso_Save.json");

#define load_options()
if (fork()){
	var _path = "ExIso_Save.json";
	
	file_load(_path);
	
	while (!file_loaded(_path)){
		wait(0);
	}
	
	if (file_exists(_path)){
		var _options = json_decode(string_load(_path));
		
		if (_options == json_error){
			trace(json_error_text);
			exit;
		}
		
		var option_count = lq_size(global.options);
		
		var _obj = {};
		
		for (var i = 0; option_count > i; i ++){
			var _key = lq_get_key(global.options, i);
			lq_set(_obj, _key, lq_defget(_options, _key, lq_get(global.options, _key)));
		}
		
		global.options = _obj;
	}
	
	else{
		save_options();
	}
	
	file_unload(_path);
	
	global.loaded = true;
	
	exit;
}


#define CustomOptions_open
trace(`${mod_current}.${mod_current_type} open!`);

#define CustomOptions_save
trace(`${mod_current}.${mod_current_type} saved!`);
save_options();


