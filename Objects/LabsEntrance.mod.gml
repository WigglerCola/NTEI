//Based off of Undergrowth's Entrance (ty matt)

#define init

global.respritemode = false;

global.sprLaserTrapBeamEnd  	   = sprite_add("../sprites/objects/LaserTrap/sprLaserTrapBeamEnd.png",3,5,5);
// Frocity Entrance:


// 5-1 Resprited Entrance:
global.sprLabsEntranceResprite     = sprite_add("../sprites/objects/LabsEntrance/sprLabsEntranceResprite.png",6,12,12);
global.sprLabsEntranceRespriteHurt = sprite_add("../sprites/objects/LabsEntrance/sprLabsEntranceRespriteHurt.png",3,12,12);
global.sprLabsEntranceRespriteDead = sprite_add("../sprites/objects/LabsEntrance/sprLabsEntranceRespriteDead.png",11,12,12);
// Hive-1 Entrance:
global.sprLabsEntranceHive		   = sprite_add("../sprites/objects/LabsEntrance/sprLabsEntranceHive.png",6,12,12);
global.sprLabsEntranceHiveHurt	   = sprite_add("../sprites/objects/LabsEntrance/sprLabsEntranceHiveHurt.png",3,12,12);
global.sprLabsEntranceHiveDead     = sprite_add("../sprites/objects/LabsEntrance/sprLabsEntranceHiveDead.png",11,12,12);


#macro anim_end ((image_index + image_speed_raw) >= image_number || (image_index + image_speed_raw) < 0)


#define LabsEntrance_create(_x, _y)
	with(instance_create(_x, _y, CustomHitme)){
		name = "EI_PromptObject";
		
		 // Visual:
		 
		 if global.respritemode = false and GameCont.area == 5{
		// 5-1 Normal:
		spr_idle = sprBoneFish1Idle
		spr_hurt = sprBoneFish1Hurt
		spr_dead = sprBoneFish1Dead
		
		 } else {
		if global.respritemode = true and GameCont.area == 5{
		// 5-1 Resprite: 
		spr_idle = global.sprLabsEntranceResprite
		spr_hurt = global.sprLabsEntranceRespriteHurt
		spr_dead = global.sprLabsEntranceRespriteDead
		
		 } else { 
		if GameCont.area == "hive"{
		// Hive Resprite: 
		spr_idle = global.sprLabsEntranceHive
		spr_hurt = global.sprLabsEntranceHiveHurt
		spr_dead = global.sprLabsEntranceHiveDead

		} else {
		// uses these sprites if no previous conditions are met somehow
		spr_idle = sprBoneFish1Idle
		spr_hurt = sprBoneFish1Hurt
		spr_dead = sprBoneFish1Dead

		}}}
		
		spr_shadow = shd16
		sprite_index = spr_idle;
		image_speed = 0.4;
		hitid = [sprite_index, "LabsEntrance"];
		depth = -1;
		
		 // Sounds:
		snd_hurt = sndHitPlant;
		snd_dead = -1;
		
		 // Vars:
		my_health = 500;
		size = 1;
		prompt = noone;
		text = "ENTER";
		pick = -1;
		respriteterrain = false;
		xoff = 0;
		yoff = 0;
		// chests = instances_matching_lt(chestprop, "id", id);
		
		 // Events:
		on_begin_step = script_ref_create(LabsEntrance_begin_step);
		on_step = script_ref_create(LabsEntrance_step);
		on_end_step = script_ref_create(LabsEntrance_end_step);
		on_hurt = script_ref_create(LabsEntrance_hurt);
		on_cleanup = script_ref_create(LabsEntrance_cleanup);
		
		return self;
	}
	
#define LabsEntrance_begin_step
	if(instance_exists(prompt)){
		instance_delete(prompt);
	}
	
#define LabsEntrance_step
	x = xstart;
	y = ystart;
	speed = 0;
	
	 // Animate:
	if(anim_end){
		sprite_index = spr_idle;
	}
	
	 // Enter Area:
	if(pick != -1){
		with(GameCont){
			area = "graveyard";
			subarea = 0;
			
			killenemies = true;
		}
		
		 // Effects:
		    repeat(random_range(12,20)){
			with(instance_create(x,y, PlasmaTrail)){
			    sprite_index = global.sprLaserTrapBeamEnd
				image_angle  = direction
				direction    = irandom(360);
				speed		 = random_range(2,5);
			}}
		
		
		 // Disable Chests:
		with(chestprop){
			mask_index = mskNone;
		}
		
		instance_create(x, y, Portal);
		my_health = 0;
	}
	
	
	if(my_health <= 0){
		with(instance_create(x, y, Corpse)){
			sprite_index = other.spr_dead;
			image_xscale = other.image_xscale;
			size		 = other.size;
		}
		
		 // Goodbye:
		instance_destroy();
	}
#define LabsEntrance_end_step
	if(instance_exists(prompt)){
		with(prompt){
			visible = true;
		}
	}
	
#define LabsEntrance_hurt(_dmg, _spd, _dir)
	my_health -= _dmg;
	nexthurt   = current_frame + 6;
	
	sound_play_hit(snd_hurt, 0.3);
	
	sprite_index = spr_hurt;
	image_index  = 0;
	
#define LabsEntrance_cleanup
	if(instance_exists(prompt)){
		instance_delete(prompt);
	}

#define orandom(_num)
	return irandom_range(-_num, _num);
