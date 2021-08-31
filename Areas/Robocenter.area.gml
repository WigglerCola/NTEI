#define init

//Sprites
global.sprAreaIcon = sprite_add("../sprites/areas/sprLabsRouteIcon.png",1,4,4);

global.sprFloor = sprite_add("../sprites/areas/robocenter/sprFloorRobocenter.png",4,0,0);
global.sprFloorB = sprite_add("../sprites/areas/robocenter/sprFloorRobocenterB.png",3,0,0);
global.sprFloorExplo = sprite_add("../sprites/areas/robocenter/sprFloorRobocenterExplo.png",4,1,1);
global.sprWallBot = sprite_add("../sprites/areas/robocenter/sprWallRobocenterBot.png",4,0,0);
global.sprWallTop = sprite_add("../sprites/areas/robocenter/sprWallRobocenterTop.png",10,0,0);
global.sprWallOut = sprite_add("../sprites/areas/robocenter/sprWallRobocenterOut.png",1,4,12);
global.sprWallTrans = sprite_add("../sprites/areas/robocenter/sprWallRobocenterTrans.png",8,0,0);
global.sprDebris = sprite_add("../sprites/areas/robocenter/sprDebrisRobocenter.png",4,4,4);
global.sprDetail = sprite_add("../sprites/areas/robocenter/sprDetailRobocenter.png",3,4,4);
//global.sprTopDecal = sprite_add("sprites/areas/robocenter/sprRobocenterTopDecal.png",3,16,24);


 // Number of subareas:
#macro subareas                 3
 // The area after this one:
#macro nextarea                 "Graveyard"
#macro nsubarea                 1

#macro area_backcol             make_color_rgb(42,40,51)

#macro DEBUG false // remember to set to false before sharing

    if DEBUG{
        trace("Press 5 to access robocenter");
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

#define area_text
	return choose(
		"@(color:16745694)FOR SCIENCE",
		"@(color:16745694)DOING WORK",
		"@(color:16745694)WATCH OUT FOR THE BEAMS", 
		"@(color:16745694)ASSEMBLERS",
		"@(color:16745694)THE ANSWER IS BENEATH US"
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
    safespawn = 1;
   
    
#define area_start
//Laser Traps
	with Floor
	if !place_meeting(x,y,Player) and !place_meeting(x,y,enemy) and !place_meeting(x,y,RadChest) and !place_meeting(x,y,AmmoChest) and !place_meeting(x,y,WeaponChest) and !place_meeting(x,y,prop){
	if random(30) < 1 and !place_meeting(x,y,NOWALLSHEREPLEASE){ //this random is chance to spawn traps
		var myx = x+choose(0,16);
		var myy = y+choose(0,16);
		
		with instance_create(myx,myy,Wall)
			instance_create(x,y,NOWALLSHEREPLEASE)
		if point_distance(myx,myy,Player.x,Player.y) > 90
		mod_script_call("mod", "LaserTrap", "LaserTrap_create", myx + 8,myy + 8);
		}
	}
	
//Boss Spawning, big dog is placeholder
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
if (random(20) < 1) instance_create(x + 16, y + 16, BecomeTurret);
if (random(14) < 1) repeat(random_range(6,12)) mod_script_call('mod', 'LabsEnemies', 'SwarmBot_create', x + 16, y + 16);
if (random(14) < 1) mod_script_call('mod', 'LabsEnemies', 'Engineer_create', x + 16, y + 16);
if (random(14) < 1) mod_script_call('mod', 'LabsEnemies', 'RollerTurret_create', x + 16, y + 16);
#define area_pop_props

if (random(25) < 1)  mod_script_call('mod', 'ExIso_Props', 'Devbox_create', x + 16, y + 16);
if (random(40) < 1)  mod_script_call('mod', 'ExIso_Props', 'Devcone_create', x + 16, y + 16);
if (random(60) < 1)  mod_script_call('mod', 'ExIso_Props', 'Devlight_create', x + 16, y + 6);
    
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