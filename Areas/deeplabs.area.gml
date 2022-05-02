#define init
	
// Area Sprites //
global.sprAreaIcon				  = sprite_add("../sprites/areas/sprLabsRouteIcon.png",1,4,4);
global.sprFloor 				  = sprite_add("../sprites/areas/deeplabs/sprFloorDeeplabs.png",4,0,0);
global.sprFloorB				  = sprite_add("../sprites/areas/deeplabs/sprFloorDeeplabs.png",4,0,0);
global.sprFloorExplo			  = sprite_add("../sprites/areas/deeplabs/sprFloorDeeplabsExplo.png",4,1,1);
global.sprWallBot				  = sprite_add("../sprites/areas/deeplabs/sprWallDeeplabsBot.png",6,0,0);
global.sprWallTop				  = sprite_add("../sprites/areas/deeplabs/sprWallDeeplabsTop.png",3,0,0);
global.sprWallOut				  = sprite_add("../sprites/areas/deeplabs/sprWallDeeplabsOut.png",1,4,12);
global.sprWallTrans				  = sprite_add("../sprites/areas/deeplabs/sprWallDeeplabsTrans.png",3,0,0);
global.sprDebris				  = sprite_add("../sprites/areas/deeplabs/sprDebrisDeeplabs.png",4,4,4);
global.sprDetail				  = sprite_add("../sprites/areas/deeplabs/sprDetailDeeplabs.png",6,4,4);
global.sprFogDeeplabs			  = sprite_add("../sprites/areas/deeplabs/sprFogDeeplabs.png",1,0,0);
//global.sprTopDecal = sprite_add("sprites/areas/robocenter/sprRobocenterTopDecal.png",3,16,24);

// Prop Sprites //
//Terminal (Off)
global.sprTerminalOff			  = sprite_add("../sprites/areas/deeplabs/props/sprTerminalOff.png", 1, 12, 12);
global.sprTerminalOffHurt		  = sprite_add("../sprites/areas/deeplabs/props/sprTerminalOffHurt.png", 3, 12, 12);
//BigTube
global.sprBigTube				  = sprite_add("../sprites/areas/deeplabs/props/sprBigTube.png", 1, 24, 24);
global.sprBigTubeBack			  = sprite_add("../sprites/areas/deeplabs/props/sprBigTubeBack.png", 1, 24, 24);
global.mskBigTube				  = sprite_add("../sprites/areas/deeplabs/props/mskBigTube.png", 1, 24, 24);
global.sprBigTubeHurt			  = sprite_add("../sprites/areas/deeplabs/props/sprBigTubeHurt.png", 3, 24, 24);
global.sprBigTubeDead			  = sprite_add("../sprites/areas/deeplabs/props/sprBigTubeDead.png", 3, 24, 24);
global.sprTubeStreak			  = sprite_add("../sprites/areas/deeplabs/props/sprTubeStreak.png", 7, 8, 8);
global.sprTubeDebris			  = sprite_add("../sprites/areas/deeplabs/props/sprDebrisTube.png", 4, 4, 4);
global.sprTubeDebrisBig			  = sprite_add("../sprites/areas/deeplabs/props/sprDebrisTubeBig.png", 3, 8, 8);
//BigTube Objects
//hey it might be better to put these all on one image and just call the image index
global.sprFishFreak				  = sprite_add("../sprites/areas/deeplabs/props/tubeobjects/sprFishFreak.png", 1, 12, 12);
global.sprFishFreakDead			  = sprite_add("../sprites/areas/deeplabs/props/tubeobjects/sprFishFreakDead.png", 6, 12, 12);
global.sprTubeGator				  = sprite_add("../sprites/areas/deeplabs/props/tubeobjects/sprTubeGator.png", 1, 12, 12);


global.song = sound_add("../sounds/music/musGraveyard.ogg");


 // Number of subareas:
#macro subareas                 3
 // The area after this one:
#macro nextarea                 7
#macro nsubarea                 3

#macro area_backcol             make_color_rgb(20,22,23)

#macro DEBUG false // remember to set to false before sharing

    if DEBUG{
        trace("Press 5 to access DEEPLABS");
        if fork(){
            while(mod_exists("area", mod_current)){
                with(Player) if button_pressed(index, "key5"){
                    with instance_create(x, y, Portal) endgame = 5;
                    with(GameCont){
                        area = mod_current;
                        subarea = 0;
                    }
                }
                wait(0);
            }
            exit;
        }
    }
#define area_name
return `@1(${global.sprAreaIcon}:0)3-`+string(GameCont.subarea);

#define area_text
	return choose(
		"@(color:16745694)ITS DARK DOWN HERE",
		"@(color:16745694)HOW FAR DOWN?",
		"@(color:16745694)UNETHICAL", 
		"@(color:16745694)FREAKS",
		"@(color:16745694)TOO MANY EYES"
	);

#define area_sprite(q)
switch (q) {
    case sprFloor1:   with([self, other]) if(instance_is(self, Floor)){ area_setup_floor(); break; } return global.sprFloor;
    case sprFloor1B:  with([self, other]) if(instance_is(self, Floor)){ area_setup_floor(); break; } return global.sprFloorB;
    case sprFloor1Explo: return global.sprFloorExplo;
    case sprWall1Trans: return global.sprWallTrans;
    case sprWall1Bot: return global.sprWallBot;
    case sprWall1Out: return global.sprWallOut;
    case sprWall1Top: return global.sprWallTop;
    case sprDebris1: return global.sprDebris;
	case sprDetail1: return global.sprDetail;
}
#define area_setup_floor
//Footsteps
material = 3;

#define area_setup
    sound_play_music(global.song)
    sound_play_ambient(amb6);
    goal = 150;
    background_color = area_backcol;
    BackCont.shadcol = c_black;
    TopCont.darkness = 1;
    TopCont.fog      = global.sprFogDeeplabs;
    safespawn = 1;
   
    
#define area_start
with(Corpse){ instance_destroy() } //cleans up the broken tube corpses from when they randomly spawn broken or outside the map

//Boss Spawning
	if GameCont.subarea == 3{
	var _floor = instance_furthest(10016, 10016, Floor);
    with (instance_nearest(
        (_floor.x * 2 + 10016) / 3 + random(128) - 64,
        (_floor.y * 2 + 10016) / 3 + random(128) - 64, Floor)) mod_script_call('mod', 'Roboboss', 'RoboBoss_create', x + 16, y + 16)
	}
#define area_make_floor
var turn = choose(0,0,0,0,0,0,0,0,0,90,90,90,-90,180);
direction += turn;

//weapon chest spawn
if (turn == 180 && point_distance(x, y, 10016, 10016) > 48) {
    instance_create(x, y, Floor);
    instance_create(x + 16, y + 16, WeaponChest);}
//ammo chest spawn
if (turn == -90 && point_distance(x, y, 10016, 10016) > 48) {
    instance_create(x, y, Floor);
    instance_create(x + 16, y + 16, AmmoChest);}




if random(18) < 1 and !place_meeting(x + 16, y + 2 ,prop) and !place_meeting(x + 16, y + 2 ,chestprop) {
	BigTube_create(x + 16, y + 2);
	instance_create(x,y,Floor)
	instance_create(x+32,y,Floor)
	instance_create(x+32,y+32,Floor)
	instance_create(x,y+32,Floor)
	instance_create(x,y-32,Floor)
	instance_create(x-32,y,Floor)
	instance_create(x+32,y-32,Floor)
	instance_create(x-32,y-32,Floor)
	instance_create(x-32,y+32,Floor)
	}
	
		
//Area Generation
if abs(turn) = 90 and random(10) < 1{
	instance_create(x+32,y,Floor)
	instance_create(x+32,y+32,Floor)
	instance_create(x,y+32,Floor)
	instance_create(x,y-32,Floor)
	instance_create(x-32,y,Floor)
	instance_create(x+32,y-32,Floor)
	instance_create(x-32,y-32,Floor)
	instance_create(x-32,y+32,Floor)
	}
else instance_create(x,y,Floor)


if random(20) < 1
	instance_create(x,y,FloorMaker)

if random(21 + instance_number(FloorMaker)) > 22 {
		instance_destroy();
		}
    

	

#define area_pop_enemies
if (random(20) < 1) mod_script_call('mod', 'ExIso_Enemies', 'RavenAmalgam_create', x + 16, y + 16);
#define area_pop_props
//if (random(18) < 1) and !place_meeting(x + 16, x + 2, prop ) BigTube_create(x + 16, y + 2);
if (random(50) < 1) instance_create(x + 16, y + 16, Terminal);
if (random(35) < 1) TerminalOff_create( x + 16, y + 16);
    
#define area_finish
    lastarea = area;
    subarea++;
    
    if background_color == area_backcol && subarea > subareas{
        area =      nextarea;
        subarea =   nsubarea;
    }

#define area_secret
    return true;
    
#define area_mapdata(_x, _y)
    return [99, -9];
    
//#region PROPS

#define TerminalOff_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		 // Visual:
		spr_idle = global.sprTerminalOff;
		spr_hurt = global.sprTerminalOffHurt;
		spr_dead = sprTerminalDead;
		spr_shadow = shd24
		 // Sounds:
		snd_hurt = sndHitMetal;
		snd_dead = sndComputerBreak;
		 // Vars:
		maxhealth = 10;
		my_health = maxhealth;
		team = 0;
		
		return self;
	}

#define BigTube_create(_x, _y)
		
	with(instance_create(_x, _y, CustomProp)){
		
		 // Visual:
		spr_idle = global.sprBigTube;
		spr_hurt = global.sprBigTubeHurt;
		spr_dead = global.sprBigTubeDead;
		spr_back = global.sprBigTubeBack;
		spr_shadow = shd64B
		spr_shadow_y = 9
		 // Sounds:
		snd_hurt = sndHitMetal;
		//snd_dead = sndLabsTubeBreak;
		 // Vars:
		maxhealth = 30;
		my_health = maxhealth;
		size = 12;
		mask_index = global.mskBigTube;
		image_xscale = 1; //no flippin
		team = 0;
		
		object = choose("fishfreak", "gator", "raven", "bandit", "chest","spider")
		
		if object = "fishfreak"{
		spr_object = global.sprFishFreak
		color = make_color_rgb(40, 87, 9);
		rotato = random(100)
		rotspeed = random_range(0.7,1.5)
		bobspeed = random_range(0.04,0.06)
		bobheight = 3
		canflip = 0
		flip = image_xscale
		}
		
		if object = "gator"{
		spr_object = global.sprTubeGator
		color = make_color_rgb(40, 87, 9);
		rotato = 0
		rotspeed = 0
		bobspeed = random_range(0.06,0.08)
		bobheight = 1
		flip = choose(image_xscale,-image_xscale)
		}
		
		if object = "raven"{
		spr_object = sprRavenIdle
		color = make_color_rgb(40, 87, 9);
		rotato = 0
		rotspeed = 0
		bobspeed = random_range(0.06,0.08)
		bobheight = 1
		flip = choose(image_xscale,-image_xscale)
		}
		
		if object = "bandit"{
		spr_object = sprBanditIdle
		color = make_color_rgb(40, 87, 9);
		rotato = random(100)
		rotspeed = random_range(0.7,1.5)
		bobspeed = random_range(0.04,0.06)
		bobheight = 2.5
		canflip = 0
		flip = image_xscale
		}
		
		if object = "chest"{
		spr_object = sprAmmoChest
		color = make_color_rgb(40, 87, 9);
		rotato = random(100)
		rotspeed = random_range(0.7,1.5)
		bobspeed = random_range(0.04,0.06)
		bobheight = 3
		canflip = 0
		flip = image_xscale
		}
		
		if object = "spider"{
		spr_object = sprSpiderIdle
		color = make_color_rgb(40, 87, 9);
		rotato = random(100)
		rotspeed = random_range(0.7,1.5)
		bobspeed = random_range(0.04,0.06)
		bobheight = 3
		canflip = 0
		flip = image_xscale
		}
		
		on_step = BigTube_step
		on_death = BigTube_destroy
				
		return self;
		
	}
		
		
#define BigTube_step
if !instance_exists(GenCont) { snd_dead = sndLabsTubeBreak }
rotato += current_time_scale * rotspeed

script_bind_draw(BigTube_draw_back, depth, self);

#define BigTube_draw_back(_inst)
	with(_inst){
		draw_sprite_ext(spr_back, 1, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
		
		var _y = y + sin(current_frame * bobspeed)*bobheight
		
		draw_sprite_ext(spr_object, 0, x , _y , flip, image_yscale, rotato, color, image_alpha);
	}
	//get outta here
	instance_destroy();
	
#define BigTube_destroy
with instance_create(x,y,CaveSparkle){ sprite_index = sprExploderExplo } //explo

repeat(random_range(3,5)){
with instance_create(x,y,Debris){ sprite_index = global.sprTubeDebris; direction = random(360); speed = random(5); } // debris
}
repeat(random_range(2,4)){
with instance_create(x,y,Debris){ sprite_index = global.sprTubeDebrisBig; direction = random(360); speed = random(5);  } // big debris
}
repeat(random_range(3,6)){
with instance_create(x+random_range(-12,12),y+random_range(-12,12),BloodStreak){ sprite_index = global.sprTubeStreak direction = irandom(360)} // streaks
}
if object = "fishfreak"{ with instance_create(x,y,Corpse){sprite_index = global.sprFishFreakDead image_index = 0 direction = irandom(360) speed = random_range(6,10)} }
if object = "bandit"{ instance_create(x,y,Bandit)}
if object = "chest"{ instance_create(x,y,AmmoChest)}
if object = "spider"{ instance_create(x,y,Spider)}
