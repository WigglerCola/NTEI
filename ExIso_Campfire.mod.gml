
//replace the words "ExIso", "coolid", and "ballswide" and it should work for you (I know its not funny)

#define init
global.ExIso_racelist = ["bubbles"]
global.ExIso_shadowx = [0,0,1]
global.ExIso_shadowy = [0,0,5]
ExIso_num = 0

//vine boom
global.sndBoom = sound_add("sounds/sndBoom.ogg");
//Bubbles
global.sprt_slct[0] = sprite_add("sprites/Characters/Bubbles/sprBubblesWalk.png", 6, 16 , 15); //Selected
global.sprt_menu[0] = sprite_add("sprites/Characters/Bubbles/sprBubblesIdle.png", 8, 16, 15);  //Waiting
global.sprt_from[0] = sprite_add("sprites/Characters/Bubbles/sprBubblesHurt.png", 3, 16, 15); //Selecting
global.sprt_to[0]   = sprite_add("sprites/Characters/Bubbles/sprBubblesHurt.png", 3, 16, 15); //Deselecting


#macro anim_end (image_index + image_speed >= image_number || image_index + image_speed < 0)

#define step
script_bind_step(scr,0)
with CampChar if "ballswide" in self {
	other.ExIso_num += 1
}
if instance_exists(Menu){
	if ExIso_num < array_length(global.ExIso_racelist){
		for (var coolid = 0; coolid < array_length(global.ExIso_racelist); coolid ++) {
			with instance_create(Campfire.x,Campfire.y,CampChar){

				//Visual
				spr_slct = global.sprt_slct[coolid] //Selected
				spr_menu = global.sprt_menu[coolid] //Waiting
				spr_from = global.sprt_from[coolid] //Selecting
				spr_to = global.sprt_to[coolid] //Deselecting
				sprite_index = spr_menu
				spr_shadow_x = global.ExIso_shadowx[coolid]
				spr_shadow_y = global.ExIso_shadowy[coolid]
				//Important
				ballswide = coolid
				num = 0.1;
				race = global.ExIso_racelist[coolid]
				mask_index = sprite_index
				//Position
				var _tries = 1000;
				while(_tries-- > 0){
					// Move Somewhere
					x = xstart;
					y = ystart;
					move_contact_solid(random(360), random_range(32, 64) + random(random(64)));
					x = round(x);
					y = round(y);
					// Safe
					if(!collision_circle(x, y, 24, CampChar, true, true) && !collision_circle(x, y, 24, Wall, true, true)  && !collision_circle(x, y, 8, TV, true, true)){
						break;
					}
					}
					//dust
					repeat(15) with instance_create(x,y,Dust){
					speed = random_range(2,5)
					direction = random(360)
				}	
					if random(20)<1{
					wait(1)
					sound_play(global.sndBoom)}
			}
		}
	} else ExIso_num = 0;
}

#define scr
//if !mod_exists("mod", "bl_campfire"){
with CampChar if "ballswide" in self{
	//Panning && Animation			
	for(var i = 0; i < maxp; i++) if player_is_active(i) {
		if player_get_race(i) = global.ExIso_racelist[ballswide] with(instance_create(0, 0, Revive)){
			//Checks if you're playing on Local Multiplayer
			var _local = false;
			for(var j = 0; j < maxp; j++){
				if(j != i && player_get_uid(j) == player_get_uid(i)){
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
instance_destroy()
//}