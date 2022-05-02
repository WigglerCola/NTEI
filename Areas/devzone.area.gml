//Development Area, set the DEBUG Macro to true to access

#define init

//Area Sprites:
global.sprAreaIcon				= sprite_add("../sprites/areas/devzone/sprAreaIconDevzone.png",1,4,4);
global.sprFloor 				= sprite_add("../sprites/areas/devzone/sprFloorDevzone.png",1,0,0);
global.sprFloorB				= sprite_add("../sprites/areas/devzone/sprFloorDevzoneB.png",1,0,0);
global.sprFloorExplo			= sprite_add("../sprites/areas/devzone/sprFloorDevzoneExplo.png",4,1,1);
global.sprWallBot				= sprite_add("../sprites/areas/devzone/sprWallDevzoneBot.png",3,0,0);
global.sprWallTop				= sprite_add("../sprites/areas/devzone/sprWallDevzoneTop.png",1,0,0);
global.sprWallOut				= sprite_add("../sprites/areas/devzone/sprWallDevzoneOut.png",1,4,12);
global.sprWallTrans 			= sprite_add("../sprites/areas/devzone/sprWallDevzoneTrans.png",1,0,0);
global.sprDebris				= sprite_add("../sprites/areas/devzone/sprDebrisDevzone.png",4,4,4);
global.sprDetail				= sprite_add("../sprites/areas/devzone/sprDetailDevzone.png",6,4,4);
//global.sprTopDecal			= sprite_add("sprites/areas/devzone/sprDevzoneTopDecal.png",3,16,24);

// Prop Sprites:
//Devbox
global.sprDevbox1				 = sprite_add("../sprites/areas/devzone/props/sprDevbox1.png", 1, 12, 12);
global.sprDevbox1Hurt			 = sprite_add("../sprites/areas/devzone/props/sprDevbox1Hurt.png", 3, 12, 12);
global.sprDevbox2				 = sprite_add("../sprites/areas/devzone/props/sprDevbox2.png", 1, 12, 12);
global.sprDevbox2Hurt			 = sprite_add("../sprites/areas/devzone/props/sprDevbox2Hurt.png", 3, 12, 12);
global.sprDevbox3				 = sprite_add("../sprites/areas/devzone/props/sprDevbox3.png", 1, 12, 12);
global.sprDevbox3Hurt		     = sprite_add("../sprites/areas/devzone/props/sprDevbox3Hurt.png", 3, 12, 12);
global.sprDevbox1Dead			 = sprite_add("../sprites/areas/devzone/props/sprDevboxDead.png", 3, 12, 12);
//Devcone
global.sprDevcone				 = sprite_add("../sprites/areas/devzone/props/sprDevcone.png", 1, 12, 14);
global.sprDevconeHurt			 = sprite_add("../sprites/areas/devzone/props/sprDevconeHurt.png", 3, 12, 14);
global.sprDevconeDead			 = sprite_add("../sprites/areas/devzone/props/sprDevconeDead.png", 3, 12, 14);
//Devlight
global.sprDevLight				 = sprite_add("../sprites/areas/devzone/props/sprDevLight.png", 1, 16, 52);
global.sprDevLightHurt			 = sprite_add("../sprites/areas/devzone/props/sprDevLightHurt.png", 3, 16, 52);
global.sprDevLightDead			 = sprite_add("../sprites/areas/devzone/props/sprDevLightDead.png", 3, 16, 52);


 // Number of subareas:
#macro subareas                 1
 // The area after this one:
#macro nextarea                 1
#macro nsubarea                 1

#macro area_backcol             make_color_rgb(65,83,124)

#macro DEBUG false // remember to set to false before sharing

    if DEBUG{
        trace("Press 6 to access dev area");
        if fork(){
            while(mod_exists("area", mod_current)){
                with(Player) if button_pressed(index, "key6"){
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
return `@1(${global.sprAreaIcon}:0)0-`+string(GameCont.subarea);

#define area_text
	return choose(
		"@(color:16745694)MAKE SOMETHING NEAT",
		"@(color:16745694)THIS IS WHERE BRAIN WORK",
		"@(color:16745694)BE SMARTERER", 
		"@(color:16745694)DONT CRASH IT THIS TIME",
		"@(color:16745694)OOPS! ANOTHER ERROR!"
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
    sound_play_music(musThemeP)
    sound_play_ambient(amb6);
    goal = 110;
    background_color = area_backcol;
    BackCont.shadcol = c_black;
    TopCont.darkness = 0; //if area is dark
    GameCont.norads = 0; // disable horror spawn when debugging
    safespawn = 1;
   
    
#define area_start
//Laser Traps
//	with Floor
//	if !place_meeting(x,y,Player) and !place_meeting(x,y,enemy) and !place_meeting(x,y,RadChest) and !place_meeting(x,y,AmmoChest) and !place_meeting(x,y,WeaponChest) and !place_meeting(x,y,prop){
//	if random(30) < 1 and !place_meeting(x,y,NOWALLSHEREPLEASE){ //this random is chance to spawn traps
//		var myx = x+choose(0,16);
//		var myy = y+choose(0,16);
		
//		with instance_create(myx,myy,Wall)
//			instance_create(x,y,NOWALLSHEREPLEASE)
//		if point_distance(myx,myy,Player.x,Player.y) > 90
//		mod_script_call("mod", "LaserTrap", "LaserTrap_create", myx + 8,myy + 8);
//		}
//	}
	
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
    
//Area Generation
if abs(turn) = 90 and random(4) < 1{
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

	


	
#define area_pop_enemies

if (random(40) < 1) mod_script_call('mod', 'ExIso_Enemies', 'Roomba_create', x + 16, y + 16);
#define area_pop_props

if (random(25) < 1) DevBox_create(x + 16,y + 16);
if (random(40) < 1) DevCone_create(x + 16,y + 16);
if (random(60) < 1) DevLight_create(x + 16,y + 16);
    
#define area_finish
    lastarea = area;
    subarea++;
    
    if background_color == area_backcol && subarea > subareas{
        area =      nextarea;
        subarea =   nsubarea;
    }

#define area_secret
    return true;
    
#define area_mapdata(lx, ly, lp, ls, ws, ll)
    return [lx, -9,10,1,1];
    
    
//#region PROPS
#define ExampleProp_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		 // Visual:
		spr_idle = global.sprDevbox1;
		spr_hurt = global.sprDevbox1Hurt;
		spr_dead = global.sprDevbox1Dead;
		 // Sounds:
		snd_hurt = sndHitMetal;
		snd_dead = sndStreetLightBreak;
		 // Vars:
		maxhealth = 4;
		my_health = maxhealth;
		mask_index = mskSpider
		team = -1;
		
		return self;
	}

//Devzone Props	
#define DevBox_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		 // Visual:
		altsprite = choose(1,2,3)
		 
		if altsprite = 1{
		spr_idle = global.sprDevbox1;
		spr_hurt = global.sprDevbox1Hurt;}
		if altsprite = 2{
		spr_idle = global.sprDevbox2;
		spr_hurt = global.sprDevbox2Hurt;}
		if altsprite = 3{
		spr_idle = global.sprDevbox3;
		spr_hurt = global.sprDevbox3Hurt;}
		
		
		spr_dead = global.sprDevbox1Dead;
		 // Sounds:
		snd_hurt = sndHitMetal;
		snd_dead = sndStreetLightBreak;
		 // Vars:
		maxhealth = 4;
		my_health = maxhealth;
		team = -1;
		
		return self;
	}
#define DevCone_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		 // Visual:
		spr_idle = global.sprDevcone;
		spr_hurt = global.sprDevconeHurt;
		spr_dead = global.sprDevconeDead;
		 // Sounds:
		snd_hurt = sndHitMetal;
		snd_dead = sndStreetLightBreak;
		 // Vars:
		maxhealth = 4;
		my_health = maxhealth;
		team = -1;
		
		return self;
	}
#define DevLight_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		 // Visual:
		spr_idle = global.sprDevLight;
		spr_hurt = global.sprDevLightHurt;
		spr_dead = global.sprDevLightDead;
		mask_index = mskStreetLight;
		spr_shadow = shd32;	
		spr_shadow_y = 1;
		depth = -7;
		 // Sounds:
		snd_hurt = sndHitMetal;
		snd_dead = sndStreetLightBreak;
		 // Vars:
		maxhealth = 4;
		my_health = maxhealth;
		friction = 12;
		team = -1;
		
		return self;
	}