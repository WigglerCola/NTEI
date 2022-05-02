#define init

//Absolutely butchered version of chomk's campfire addon to add particles 

//(Originally) DEVELOPED BY McChomk, FOR HELP CONTACT McChomk#9393 ON DISCORD (dont contact him if using this I mangled it a bit)

/*
    To give a custom character campfire support, use this code, it will detect the character automatically
*/
//#define race_ei_campf					return true;
//#define race_ei_campf_sprnotselected	return <The character's "selected" sprite>;
//#define race_ei_campf_sprselected		return <The character's "not-selected" sprite>;
//#define race_ei_campf_sprselecting 	return <The character's "selecting" sprite>;
//#define race_ei_campf_sprdeselecting	return <The character's "deselecting" sprite>;
//#define race_ei_campf_shadowx			return <Shadow's X offset>;
//#define race_ei_campf_shadowy		    return <Shadow's Y offset>;
/*
    Optional Stuff
*/
//#define race_ei_campf_prop 			    return <The prop's sprite. For characters that don't have props, don't define the function>;
//#define race_ei_campf_proptyp		    	return <-1 or 1, -1 = Prop below character, 1 = Prop above character>;

/*
   Particles
*/

//#define race_ei_campf_particles		//put the particle creation code in this

global.loaded = false;
global.created = false;

with CampChar if "ei_campfire_char" in self instance_delete(self);
with instances_matching(CustomObject,"name","ei_campfire_prop") instance_delete(self)

if (fork()) {
    wait(0);
    
    var _chars = mod_get_names("race");
    while (true) {
        if (instance_exists(Menu)) {
            if (!global.created) for (var f = 0; f < array_length(_chars); f++) {
                global.created = true;
                
                if(mod_exists("race", _chars[f]) and (!mod_script_exists("race", _chars[f], "race_avail") or (mod_script_exists("race", _chars[f], "race_avail") and mod_script_call("race", _chars[f], "race_avail") != false)) and mod_script_exists("race", _chars[f], "race_ei_campf") and mod_script_call("race", _chars[f], "race_ei_campf") != false) {
                    var xpos = 0;
                    var ypos = 0;
                    var _depth;
                        
                    with instance_create(Campfire.x,Campfire.y,CampChar) {
                        //Visual
                        spr_slct = mod_script_call("race", _chars[f], "race_ei_campf_sprselected"); //SELECTED
                        spr_menu = mod_script_call("race", _chars[f], "race_ei_campf_sprnotselected"); //NOT SELECTED
                        spr_from = mod_script_call("race", _chars[f], "race_ei_campf_sprselecting"); //SELECTING
                        spr_to = mod_script_call("race", _chars[f], "race_ei_campf_sprdeselecting"); //DESELECTING
                        sprite_index = spr_menu;
                        spr_shadow_x = mod_script_call("race", _chars[f], "race_ei_campf_shadowx");
                        spr_shadow_y = mod_script_call("race", _chars[f], "race_ei_campf_shadowy");
                        
                        //Important
                        ei_campfire_char = true;
                        num = 0.1;
                        race = _chars[f];
                        mask_index = mskPlayerMenu;
                        _depth = depth;
                        
                        //Position
                        var _tries = 1000;
                        while(_tries-- > 0) {
                            // Move Somewhere
                            x = xstart;
                            y = ystart;
                            move_contact_solid(random(360), random_range(32, 64) + random(random(64)));
                            x = round(x);
                            y = round(y);
                            // Safe
                            if(!collision_circle(x, y, 24, CampChar, true, true) && !collision_circle(x, y, 24, Wall, true, true)  && !collision_circle(x, y, 8, TV, true, true)){
                                xpos = x;
                                ypos = y;
                                break;
                            }
                        }
                        // DO PARTICLES
            	if global.loaded = false { mod_script_call("race", _chars[f], "race_ei_campf_particles"); }
                    }
                        
                    if (mod_script_exists("race", _chars[f], "race_ei_campf_prop")) with instance_create(xpos,ypos,CustomObject) {
                        name = "ei_campfire_prop"
                        sprite_index = mod_script_call("race", _chars[f], "race_ei_campf_prop");
                        depth = _depth - sign(mod_script_call("race", _chars[f], "race_ei_campf_proptyp")) * 2;
                        mask_index = mskNone;
                    }
                }
            }
        } else global.created = false;
        
        wait(0);
        
        global.loaded = true;
        
    }
    exit;
}



#macro anim_end (image_index + image_speed >= image_number || image_index + image_speed < 0)

#define step
script_bind_step(scr,0);

#define scr
with CampChar if "ei_campfire_char" in self{
	//Panning && Animation			
	for(var i = 0; i < maxp; i++) if player_is_active(i) {
		if player_get_race(i) == race with(instance_create(0, 0, Revive)) {
			//Checks if you're playing on Local Multiplayer
			var _local = false;
			for(var j = 0; j < maxp; j++) {
				if(j != i && player_get_uid(j) == player_get_uid(i)) {
					_local = true;
					break;
				}
			}
			//Only pans camera if you're NOT on Local
			if(!_local){
				var shake = UberCont.opt_shake;
				UberCont.opt_shake = 1.15;
				instance_change(Player,false);
				p = i;
				gunangle = point_direction(64,64,other.x,other.y);
				weapon_post(0,point_distance(64,64,other.x,other.y)/10*current_time_scale,0);
			}
			if(anim_end) {
				if(sprite_index != spr_slct) {
					if(sprite_index == spr_from) {
						sprite_index = spr_slct;
					} else {
						sprite_index = spr_from;
					}
				}
				image_index = 0;
			} //Animation
			instance_delete(self);
			UberCont.opt_shake = shake;
		} else if(anim_end) {
			if(sprite_index != spr_menu) {
				if(sprite_index == spr_to ) {
					sprite_index = spr_menu;
				} else {
					sprite_index = spr_to;
				}
			}
			image_index = 0;
		} //Animation
	}
}

instance_destroy();