//Development Area, set the DEBUG Macro to true to access

#define init

//Sprites
global.sprAreaIcon = sprite_add("../sprites/areas/cove/sprAreaIconCove.png",1,4,4);
global.sprFloor = sprite_add("../sprites/areas/cove/sprFloorCove.png",4,0,0);
global.sprFloorB = sprite_add("../sprites/areas/cove/sprFloorCoveB.png",4,0,0);
global.sprSandFloor = sprite_add("../sprites/areas/cove/sprSandFloor.png",8,16,16);
global.sprFloorExplo = sprite_add("../sprites/areas/cove/sprFloorCoveExplo.png",4,1,1);
global.sprWallBot = sprite_add("../sprites/areas/cove/sprWallCoveBot.png",2,0,0);
global.sprWallTop = sprite_add("../sprites/areas/cove/sprWallCoveTop.png",4,0,0);
global.sprWallOut = sprite_add("../sprites/areas/cove/sprWallCoveOut.png",1,4,12);
global.sprWallTrans = sprite_add("../sprites/areas/cove/sprWallCoveTrans.png",3,0,0);
global.sprDebris = sprite_add("../sprites/areas/cove/sprDebrisCove.png",4,4,4);
global.sprDetail = sprite_add("../sprites/areas/cove/sprDetailCove.png",5,4,4);
//global.sprTopDecal = sprite_add("sprites/areas/cove/sprCoveTopDecal.png",3,16,24);


 // Number of subareas:
#macro subareas                 1
 // The area after this one:
#macro nextarea                 1
#macro nsubarea                 1

#macro area_backcol             make_color_rgb(138,150,158)

#macro DEBUG true // remember to set to false before sharing

    if DEBUG{
        trace("Press 5 to access PIRATE LEGEND area");
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
return `@1(${global.sprAreaIcon}:0)1-`+string(GameCont.subarea);

#define area_ttip
return ["@(color:16745694)DEV ZONE WOOOO"];

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
material = 2;
#define area_setup
    sound_play_music(mus101)
    sound_play_ambient(amb100);
    goal = 150;
    background_color = area_backcol;
    BackCont.shadcol = c_black;
    TopCont.darkness = 1; //if area is dark
    safespawn = 1;
   
    
#define area_start

with instances_matching(Floor,"styleb",1){
	depth -= 0.1;
	material = 1;
	with instance_create(x,y,SnowFloor){
		depth = other.depth + 0.05;
		sprite_index = global.sprSandFloor;
		image_speed = 0;
		image_index = other.image_index;
		}
	}
	
#define area_make_floor
var turn = choose(0, 0, 0, 0, 0, 0, 0, 90, 90, 90, -90, -90, -90, 180);
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

if (random(40) < 1) instance_create(x + 16, y + 16, Bandit);
#define area_pop_props

if (random(25) < 1) instance_create(x + 16,y + 16,Torch)
if (random(40) < 1) mod_script_call('mod', 'ExIso_Props', 'Devcone_create', x + 16, y + 16);
if (random(60) < 1) mod_script_call('mod', 'ExIso_Props', 'Devlight_create', x + 16, y + 6);

if (random(15) < 1) instance_create(x + 16, y + 16, LightBeam);
    
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