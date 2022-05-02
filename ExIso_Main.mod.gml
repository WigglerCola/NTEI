
#define init

    // LIB:
			global.libLoaded = false;
			if(fork()){
				
				while(!mod_exists("mod", "lib")){wait(1);}
		
				script_ref_call(["mod", "lib", "getRef"], "mod", mod_current, "scr");
		
				var modules = ["libWeps"];
				with(modules) call(scr.import, self);
				
				global.libLoaded = true;
				
				// Loading Message:
				wait(40);
				trace_color("NT:EI LOADED!", 16745694);
	    		trace_color("Please report bugs/feedback to WigglerCola#1288 in the NT Discord", 16745694);
	    			if room_speed > 30 { // 60FPS Warning:
	    		trace_color("WARNING: 60FPS is not fully tested and may cause issues, be careful!", c_red); }
	    	
				exit;
		}
	

	    
	    // Needed Vars:
	    global.level_start = false;
	    
	    
	    // Setting Options Vars:
	    global.loopspawns				= true;   	// Whether or not EI enemies will spawn in the main progression path during Loop. (true/false)
	    global.vanillaglow				= true; 	// If basegame things will glow in the dark that normally wouldn't (Trapfire, Salamanders, Fireballs, etc). (true/false)
	    global.confetticleanamount		= 1000;		// How much confetti is allowed at once before it will start being cleared. (default = 1000)
	    global.respritemode 			= false;	// Makes some things fit in with my resprites, probably keep off if you aren't me (true/false)
	    
	    
	    // Undergrowth Stuff for Entrance:
		global.post_step = noone;
		#macro infinity 1/0
		
		#macro anim_end 																				(image_index + image_speed >= image_number || image_index + image_speed < 0)
		
		#macro  scr																						global.scr
		#macro  call																					script_ref_call
		
	//#region SPRITES


	//#endregion

#define cleanup
	//Undergrowth Stuff for Entrance
    if(instance_exists(global.post_step)){
    	instance_delete(global.post_step);
    }
    
//this applies bloom to all customprojectiles or customobjects with ei_bloomamount set
//default bloom transparency is 0.1
#define draw_bloom
	with(instances_matching_gt(CustomProjectile, "ei_bloomamount", 0)){
		draw_sprite_ext(sprite_index, image_index, x, y, ei_bloomamount*image_xscale, ei_bloomamount*image_yscale, image_angle, image_blend, ei_bloomtransparency);
	}
	with(instances_matching_gt(CustomObject, "ei_bloomamount", 0)){
		draw_sprite_ext(sprite_index, image_index, x, y, ei_bloomamount*image_xscale, ei_bloomamount*image_yscale, image_angle, image_blend, ei_bloomtransparency);
	}
	with(instances_matching_gt(CustomSlash, "ei_bloomamount", 0)){
		draw_sprite_ext(sprite_index, image_index, x, y, ei_bloomamount*image_xscale, ei_bloomamount*image_yscale, image_angle, image_blend, ei_bloomtransparency);
	}
#define draw_dark
	draw_set_color($808080);
	// glow in the dark
	with(instances_matching(CustomEnemy, "name", "Cremator")) draw_circle(x, y, 48 + random(3), false);
	with(instances_matching(CustomProjectile, "name", "ei_labsrocketexplosion")) draw_circle(x, y, 96 + random(3), false);
//	with(instances_matching(CustomObject, "name", "ei_lightningspawn")) draw_circle(x, y, 96 + random(3), false);
	
	if global.vanillaglow = true {
	with(Salamander) draw_circle(x, y, 48 + random(3), false);
	with(DogGuardian) draw_circle(x, y, 48 + random(3), false);
	with(Guardian) draw_circle(x, y - 6, 48 + random(3), false);
	with(ExploGuardian) draw_circle(x, y, 48 + random(3), false);
	with(CrownGuardian) draw_circle(x, y - 6, 48 + random(3), false);
	with(EnemyHorror) draw_circle(x, y, 32 + random(3), false);
	}
	
//	if GameCont.area = "cove" {
//	draw_rectangle(view_xview_nonsync, view_yview_nonsync, view_xview_nonsync + game_width, view_yview_nonsync + game_width, 0);
//	}

#define draw_dark_end
	draw_set_color($000000);
	// shine like a star!
	with(instances_matching(CustomEnemy, "name", "Cremator")) draw_circle(x, y, 32 + random(3), false);
	with(instances_matching(CustomProjectile, "name", "ei_labsrocketexplosion")) draw_circle(x, y, 48 + random(3), false);
//	with(instances_matching(CustomObject, "name", "ei_lightningspawn")) draw_circle(x, y, 48 + random(3), false);

	if global.vanillaglow = true {
	with(TrapFire) draw_circle(x, y, 24 + random(7), false);
	with(FireBall) draw_circle(x, y, 16 + random(7), false);
	with(Salamander) draw_circle(x, y, 32 + random(3), false);
	with(DogGuardian) draw_circle(x, y, 32 + random(3), false);
	with(Guardian) draw_circle(x, y - 6, 32 + random(3), false);
	with(ExploGuardian) draw_circle(x, y, 32 + random(3), false);
	with(CrownGuardian) draw_circle(x, y - 6, 32 + random(3), false);
	with(EnemyHorror) draw_circle(x, y, 16 + random(3), false);
	}

#define step
	
     // Bind Post Step:
    if(!instance_exists(global.post_step)){
        global.post_step = script_bind_step(post_step, 0);
        global.post_step.persistent = true;
    }


	//Confetti Cleanup:
if instance_number(Confetti) > global.confetticleanamount {
    with(Confetti){
        if random(5)<1{ instance_destroy() }
    } }
    
    
    // Level Start:
    if(instance_exists(GenCont)){
        global.level_start = true;
    }
    else{
        if(global.level_start){
        	
        	//#region NORMAL SPAWNS
        	
        	    switch(GameCont.area){
                    
                	/// PALACE
                    case 7:
                    case "palace":
                    
                    // Splitter Guardians:
                    with(DogGuardian){
                    if(random(6) < 1){
                    mod_script_call('mod', 'ExIso_Enemies', 'GupGuardian_create', x, y);
                    instance_destroy();
                   	}
                    }
                        break;
                        
                        
             }
                
            
             //#region LOOP SPAWNS:
            if(GameCont.loops > 0) and global.loopspawns = true{
                switch(GameCont.area){
                    
                	/// LABS
                    case 6:
                    case "labs":
                    
                    // Roller Turrets:
                    with(RhinoFreak){
                    if(random(3) < 1){
                    mod_script_call('mod', 'ExIso_Enemies', 'RollerTurret_create', x, y);
                    instance_destroy();
                    	}
                    }
                        break;
                        
                        
                        
                }
            }
                        
            	        
            global.level_start = false;
        		}
			 }       
    
#define post_step
//Undergrowth Stuff for Entrance
    if(instance_exists(CustomHitme)){
        var _inst = instances_matching(instances_matching(CustomHitme, "name", "EI_PromptObject"), "visible", true);
        
        if(array_length(_inst)) with(_inst){
    		var _inst = instances_matching(Player, "visible", true);
    		
    		if(array_length(_inst)) with(_inst){
    			if(place_meeting(x, y, other) && !place_meeting(x, y, IceFlower) && !place_meeting(x, y, CarVenusFixed)){
    				
    					
    					if(!instance_exists(nearwep) || nearwep.depth < other.depth){
    						with(other){
    							prompt = instance_create(x + xoff, y + yoff, IceFlower);
    							with(prompt){
    								name = other.text;
    								x = xstart;
    								y = ystart;
    								xprevious = x;
    								yprevious = y;
    								visible = false;
    								mask_index = mskNone;
    								sprite_index = mskNone;
    								spr_idle = mskNone;
    								spr_walk = mskNone;
    								spr_hurt = mskNone;
    								spr_dead = mskNone;
    								spr_shadow = -1;
    								snd_hurt = -1;
    								snd_dead = -1;
    								size = 0;
    								team = 0;
    								my_health = infinity;
    								nexthurt = infinity;
    							}
    							
    							other.nearwep = prompt;
    						}
    						
    						if(button_pressed(index, "pick")){
    							other.pick = index;
    						}
    					}
    			}
    		}
        }
    }    		
