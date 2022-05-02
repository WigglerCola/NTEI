#define init

//Sprites
global.sprAreaIcon					= sprite_add("../sprites/areas/sprLabsRouteIcon.png",1,4,4);

global.sprFloor 					= sprite_add("../sprites/areas/robocenter/sprFloorRobocenter.png",4,0,0);
global.sprFloorB					= sprite_add("../sprites/areas/robocenter/sprFloorRobocenterB.png",3,0,0);
global.sprFloorExplo				= sprite_add("../sprites/areas/robocenter/sprFloorRobocenterExplo.png",4,1,1);
global.sprWallBot					= sprite_add("../sprites/areas/robocenter/sprWallRobocenterBot.png",4,0,0);
global.sprWallTop				    = sprite_add("../sprites/areas/robocenter/sprWallRobocenterTop.png",10,0,0);
global.sprWallOut					= sprite_add("../sprites/areas/robocenter/sprWallRobocenterOut.png",1,4,12);
global.sprWallTrans 				= sprite_add("../sprites/areas/robocenter/sprWallRobocenterTrans.png",8,0,0);
global.sprDebris					= sprite_add("../sprites/areas/robocenter/sprDebrisRobocenter.png",4,4,4);
global.sprDetail					= sprite_add("../sprites/areas/robocenter/sprDetailRobocenter.png",3,4,4);
//global.sprTopDecal				= sprite_add("sprites/areas/robocenter/sprRobocenterTopDecal.png",3,16,24);
//Props
global.mskBattery					= sprite_add("../sprites/areas/robocenter/props/mskBattery.png", 1, 13, 7);
global.sprBattery					= sprite_add("../sprites/areas/robocenter/props/sprBattery.png", 1, 13, 7);

// Deeplabs Entrance
global.sprDeeplabsEntranceClosed	= sprite_add("../sprites/areas/deeplabs/sprEntranceClosed.png", 1, 24, 24);
global.sprDeeplabsEntranceOpening	= sprite_add("../sprites/areas/deeplabs/sprEntranceOpening.png", 5, 24, 24);
global.sprDeeplabsEntranceOpen		= sprite_add("../sprites/areas/deeplabs/sprEntranceOpen.png", 1, 24, 24);

global.song = sound_add("../sounds/music/musRobocenter.ogg");

 // Number of subareas:
#macro subareas                 1
 // The area after this one:
#macro nextarea                 6
#macro nsubarea                 1

#macro area_backcol             make_color_rgb(42,40,51)

#macro lasertrap_spawnchance    60

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


  // LASERTRAPS:
global.sprLaserTrap = sprite_add("../sprites/objects/LaserTrap/sprLaserTrap.png",1,11,16)
global.sprLaserTrapGameover = sprite_add("../sprites/objects/LaserTrap/sprLaserTrap.png",1,11,8)

global.sprLaserTrapBeam       = sprite_add("../sprites/objects/LaserTrap/sprLaserTrapBeam.png",1,0,6);
global.mskLaserTrapBeam       = sprite_add("../sprites/objects/LaserTrap/mskLaserTrapBeam.png",1,2,6);
global.sprLaserTrapBeamEnd   = sprite_add("../sprites/objects/LaserTrap/sprLaserTrapBeamEnd.png",3,5,5);
global.sprLaserTrapBeamStart = sprite_add("../sprites/objects/LaserTrap/sprLaserTrapBeamStart.png",0,8,8);
global.sprLaserTrapHead 	  = sprite_add("../sprites/objects/LaserTrap/sprLaserTrapHead.png",0,8,2)
global.sprWarningLaser       = sprite_add("../sprites/objects/LaserTrap/sprWarningLaser.png",1,0,6);

#macro anim_end ((image_index + image_speed_raw) >= image_number || (image_index + image_speed_raw) < 0)
#macro current_frame_active (current_frame < floor(current_frame) + current_time_scale)
    
#define area_name
return `@1(${global.sprAreaIcon}:0)2-`+string(GameCont.subarea);

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
    sound_play_music(global.song)
    sound_play_ambient(amb6);
    goal = 160;
    background_color = area_backcol;
    BackCont.shadcol = c_black;
    TopCont.darkness = 0; //if area is dark
    safespawn = 1;
   
    
#define area_start
// Deeplabs Entrance:
	var _Entrancefloor = instance_furthest(10016, 10016, Floor);
    with (instance_nearest(
        (_Entrancefloor.x * 2 + 10016) / 3 + random(128) - 64,
        (_Entrancefloor.y * 2 + 10016) / 3 + random(128) - 64, Floor)) with DeeplabsEntrance_create( x + 16, y + 16){
        //	with place_meeting(x,y,prop){ instance_destroy() }
        }
        
//Laser Traps
	with Floor
	if !place_meeting(x,y,Player) and !place_meeting(x,y,enemy) and !place_meeting(x,y,RadChest) and !place_meeting(x,y,AmmoChest) and !place_meeting(x,y,WeaponChest) and !place_meeting(x,y,prop){
	if random(lasertrap_spawnchance) < 1 and !place_meeting(x,y,NOWALLSHEREPLEASE){
		var myx = x+choose(0,16);
		var myy = y+choose(0,16);
		
		with instance_create(myx,myy,Wall)
			instance_create(x,y,NOWALLSHEREPLEASE)
		if point_distance(myx,myy,Player.x,Player.y) > 90
		if distance_to_object(BigWeaponChest) > 64
		LaserTrap_create(myx + 8,myy + 8);
		}
	}


//Boss Spawning, Loop Exclusive
	if GameCont.loops > 0{
	var _floor = instance_furthest(10016, 10016, Floor);
    with (instance_nearest(
        (_floor.x * 2 + 10016) / 2 + random(128) - 64,
        (_floor.y * 2 + 10016) / 2 + random(128) - 64, Floor)) mod_script_call('mod', 'Roboboss', 'RoboBoss_create', x + 16, y + 16)
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
if (random(20) < 1) and !place_meeting(x,y,CustomObject) instance_create(x + 16, y + 16, BecomeTurret);
if (random(14) < 1) repeat(random_range(3,6)) mod_script_call('mod', 'ExIso_Enemies', 'SwarmBot_create', x + 16, y + 16);
if (random(10) < 1) mod_script_call('mod', 'ExIso_Enemies', 'Engineer_create', x + 16, y + 16);
if (random(12) < 1) mod_script_call('mod', 'ExIso_Enemies', 'RollerTurret_create', x + 16, y + 16);
if (random(14) < 1) mod_script_call('mod', 'ExIso_Enemies', 'MissileDrone_create', x + 16, y + 16);
#define area_pop_props

if (random(25) < 1)  Battery_create(x + 16, y + 16);
    
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
    return [85.5, -9];
    
    
    
//#region LASERTRAP SCRIPTS

#define LaserTrap_create(_myx, _myy)

	with(instance_create(_myx, _myy, CustomObject)){
		depth = -6;
		sprite_index = global.sprLaserTrap;

		
		FireTimer = 80 + random_range(0,30); //how much time before it activates after spawning, random is there so traps have different timed patterns
		on_step = LaserTrap_Step;
		creator = instance_position(x,y,Wall)
		
		//chooses to either start on Fire1 or Fire2	
		if random(2) < 1{
		Fire1 = 1;
		Fire2 = 0;  
		}
		else
		Fire1 = 0;
		Fire2 = 1;
		}
	
#define LaserTrap_Step

  if !instance_exists(creator){ //if creator doesn't exist destroys itself
    instance_destroy();
    exit; }
    
if !instance_exists(Portal){ //when a portal exists the LaserTraps will stop firing, FireTraps do this.
	FireTimer -=current_time_scale; 

	if FireTimer <= 1{ //when timer is 0, do the thing
	    
	    if Fire1 = 1{
	           FireTimer +=60; //make sure both this and the the other Firetimer +=x; are the same, along with the Firetimer = x; in the LaserTrap_Create
	    repeat(1){
        LaserTrapFire1()
        }
	}else if Fire2 = 1{
	            FireTimer +=60;
	    repeat(1){
        LaserTrapFire2()
        }}}}
	    



	
#define LaserTrapFire1

//warning
repeat(3){
if !instance_exists(self){ exit;}
with instance_create((x+lengthdir_x(0, direction)),(y+lengthdir_y(0, direction)),CustomProjectile){
    creator = other
    team = 1;
    direction = 270;
    beamdirection = 270.014
    image_angle = direction
    created = false
	sprite_index = global.sprWarningLaser
	mask_index   = global.mskLaserTrapBeam

    on_step = warning_laser
    on_wall = nothing
	on_draw = warning_draw
	on_hit  = nothing

    time = 3
    image_speed = 0
}

with instance_create((x+lengthdir_x(0, direction)),(y+lengthdir_y(0, direction)),CustomProjectile){
    creator = other
    team = 1;
    direction = 90;
    beamdirection = 90.014
    image_angle = direction
    created = false
	sprite_index = global.sprWarningLaser
	mask_index   = global.mskLaserTrapBeam

    on_step = warning_laser
    on_wall = nothing
	on_draw = warning_draw
	on_hit  = nothing

    time = 3
    image_speed = 0
}

if !instance_exists(self) exit;
wait(5);}
if !instance_exists(self){ exit;}

//actual laser
with instance_create((x+lengthdir_x(0, direction)),(y+lengthdir_y(0, direction)),CustomProjectile){
    creator = other
    team = 1;
    direction = 270;
    beamdirection = 270.014;
    image_angle = direction
    created = false
	sprite_index = global.sprLaserTrapBeam
	mask_index   = global.mskLaserTrapBeam
	spr_tail     = global.sprLaserTrapBeamStart
	spr_head     = global.sprLaserTrapHead

    on_step = beam_step
    on_wall = nothing
	on_draw = beam_draw
	on_hit  = beam_hit
	on_cleanup = beam_cleanup

    time = 25
    image_speed = 0
}

with instance_create((x+lengthdir_x(0, direction)),(y+lengthdir_y(0, direction)),CustomProjectile){
    creator = other
    team = 1;
    direction = 90;
    beamdirection = 90.014;
    image_angle = direction
    created = false
	sprite_index = global.sprLaserTrapBeam
	mask_index   = global.mskLaserTrapBeam
	spr_tail     = global.sprLaserTrapBeamStart
	spr_head     = global.sprLaserTrapHead

    on_step = beam_step
    on_wall = nothing
	on_draw = beam_draw
	on_hit  = beam_hit
	on_cleanup = beam_cleanup

    time = 25
    image_speed = 0
}

  Fire1 = 0; //makes it so the trap will fire attack 2 next
  Fire2 = 1;
    
#define LaserTrapFire2

//warning
repeat(3){
if !instance_exists(self){ exit;}
with instance_create((x+lengthdir_x(0, direction)),(y+lengthdir_y(0, direction)),CustomProjectile){
    creator = other
    team = 1;
    direction = 180;
    beamdirection = 180;
    image_angle = direction
    created = false
	sprite_index = global.sprWarningLaser
	mask_index   = global.mskLaserTrapBeam

    on_step = warning_laser
    on_wall = nothing
	on_draw = warning_draw
	on_hit  = nothing

    time = 3
    image_speed = 0
}

with instance_create((x+lengthdir_x(0, direction)),(y+lengthdir_y(0, direction)),CustomProjectile){
    creator = other
    team = 1;
    direction = 0;
    beamdirection = 0;
    image_angle = direction
    created = false
	sprite_index = global.sprWarningLaser
	mask_index   = global.mskLaserTrapBeam

    on_step = warning_laser
    on_wall = nothing
	on_draw = warning_draw
	on_hit  = nothing

    time = 3
    image_speed = 0
}

if !instance_exists(self) exit;
wait(5);}
if !instance_exists(self){ exit;}
//actual laser
with instance_create((x+lengthdir_x(0, direction)),(y+lengthdir_y(0, direction)),CustomProjectile){
    creator = other
    team = 1;
    direction = 180;
    beamdirection = 180;
    image_angle = direction
    created = false
	sprite_index = global.sprLaserTrapBeam
	mask_index   = global.mskLaserTrapBeam
	spr_tail     = global.sprLaserTrapBeamStart
	spr_head     = global.sprLaserTrapHead

    on_step = beam_step
    on_wall = nothing
	on_draw = beam_draw
	on_hit  = beam_hit
	on_cleanup = beam_cleanup

    time = 25
    image_speed = 0
}

with instance_create((x+lengthdir_x(0, direction)),(y+lengthdir_y(0, direction)),CustomProjectile){
    creator = other
    team = 1;
    direction = 0;
    beamdirection = 0;
    image_angle = direction
    created = false
	sprite_index = global.sprLaserTrapBeam
	mask_index   = global.mskLaserTrapBeam
	spr_tail     = global.sprLaserTrapBeamStart
	spr_head     = global.sprLaserTrapHead

    on_step = beam_step
    on_wall = nothing
	on_draw = beam_draw
	on_hit  = beam_hit
	on_cleanup = beam_cleanup

    time = 25
    image_speed = 0
} 


Fire2 = 0; //makes it so the trap wil fire attack 1 next
Fire1 = 1;



//vector stuff
#define beam_cleanup
sound_set_track_position(sndEnergyHammerUpg,0)
sound_set_track_position(sndLaserUpg,0)
sound_set_track_position(sndLaser,0)
sound_stop(sndEnergyHammerUpg)

#define beam_step
if instance_exists(creator){
	if created = false{
		created = true
		sound_set_track_position(sndEnergyHammerUpg,.3)
		sound_pitch(sndEnergyHammerUpg,0)
		sound_play_pitchvol(sndEnergyHammerUpg,.4 * random_range(.9, 1.1), .25)
		sound_set_track_position(sndEnergyHammerUpg,0)
	}

    time -= current_time_scale
    if time <= 0 {instance_destroy(); exit}
    x = creator.x + creator.hspeed_raw + lengthdir_x(16,other.direction)
    y = creator.y + creator.vspeed_raw + lengthdir_y(16,other.direction)
    xstart = x
    ystart = y
    image_xscale = 1
    direction = other.beamdirection
    image_angle = direction

    var _x = lengthdir_x(2,direction), _y = lengthdir_y(2,direction)
    var dir = 0
    do {
    	dir += 2;
    	x += _x
    	y += _y
    }
    until dir >= 1800 || place_meeting(x,y,Wall)
    xprevious = x
    yprevious = y

    image_xscale = dir/2
    if every(2){
        var _r = random_range(0,image_xscale*2+12)
        with instance_create(x-lengthdir_x(_r,direction)+random_range(-5,5),y-lengthdir_y(_r,direction)+random_range(-5,5),BulletHit)
				{
        	sprite_index = global.sprLaserTrapBeamEnd
        	image_angle = other.direction
					image_speed = 0.4;
        	motion_set(other.direction,choose(1,2))
        }
    }
    image_yscale = 1 * random_range(.9,1.1)
    sound_set_track_position(sndEnergyHammerUpg,0)
    sound_set_track_position(sndLaserUpg,0)
    sound_set_track_position(sndLaser,0)
}
else instance_destroy()


#define beam_hit
var _team = team
var _ang = direction
with(other){
if nexthurt <= current_frame{
projectile_hit(self,other.damage)
hitid = [global.sprLaserTrapGameover, "LASER TRAP"];
  }
}
#define beam_draw
draw_sprite_ext(sprite_index, image_index, xstart, ystart, image_xscale, image_yscale, image_angle, image_blend, 1.0);
	if x != xstart draw_sprite_ext(spr_tail, 1, xstart, ystart, 1, image_yscale, image_angle, image_blend, 1.0);
	if x != xstart draw_sprite_ext(spr_head, 0, x, y, image_yscale*2, image_yscale*2, image_angle-45, image_blend, 1.0);

	// BLOOM:
draw_sprite_ext(sprite_index, image_index, xstart, ystart, image_xscale, image_yscale*1.7, image_angle, image_blend, 0.2);
	if x != xstart draw_sprite_ext(spr_tail, 1, xstart, ystart, 1, image_yscale*1.5, image_angle, image_blend, 0.2); 
	if x != xstart draw_sprite_ext(spr_head, 0, x, y, image_yscale*2.7, image_yscale*2.7, image_angle-45, image_blend, 0.2); 
//laser warning thing 
#define warning_laser
if instance_exists(creator){
	if created = false{
		created = true
	}

    time -= current_time_scale
    if time <= 0 {instance_destroy(); exit}
    x = creator.x + creator.hspeed_raw + lengthdir_x(8,other.direction)
    y = creator.y + creator.vspeed_raw + lengthdir_y(8,other.direction)
    xstart = x
    ystart = y
    image_xscale = 1
    direction = other.beamdirection 
    image_angle = direction

    var _x = lengthdir_x(2,direction), _y = lengthdir_y(2,direction)
    var dir = 0
    do {
    	dir += 2;
    	x += _x
    	y += _y
    }
    until dir >= 1800 || place_meeting(x,y,Wall)
    xprevious = x
    yprevious = y

    image_xscale = dir/2
    image_yscale = 1 * random_range(.9,1.1)

}
else instance_destroy()


#define nothing

#define warning_draw
draw_sprite_ext(sprite_index, image_index, xstart, ystart, image_xscale, image_yscale, image_angle, image_blend, 1.0);
draw_sprite_ext(sprite_index, image_index, xstart, ystart, image_xscale, image_yscale*1.7, image_angle, image_blend, 0.2);//bloom

#define every(_num) //every _num frames (objectively) trigger
	return frac(current_frame/_num) < current_time_scale/_num

//#region PROPS

#define Battery_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		 // Visual:
		spr_idle = global.sprBattery;
		spr_hurt = sprSpiderHurt;
		spr_dead = sprSpiderDead;
		spr_shadow = shd32
		 // Sounds:
		snd_hurt = sndHitMetal;
		snd_dead = sndComputerBreak;
		 // Vars:
		maxhealth = 10;
		my_health = maxhealth;
		mask_index = global.mskBattery
		team = 0;

		
		return self;
	}

//#region DEEPLABS ENTRANCE

#define DeeplabsEntrance_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		name = "DeeplabsEntrance";
		
		 // Visual:
		spr_closed = global.sprDeeplabsEntranceClosed;
		spr_opening = global.sprDeeplabsEntranceOpening;
		spr_open = global.sprDeeplabsEntranceOpen;
		sprite_index = spr_closed;
		image_speed = 0.4;
		depth = Floor.depth - 1;
		
		 // Vars:
		entranceopen = false;
		
		 // Events:
		on_step = script_ref_create(DeeplabsEntrance_step);
		
		return self;
	}
	
#define DeeplabsEntrance_step

	x = xstart;
	y = ystart;
	speed = 0;

	 // Enter Area:
	if(instance_exists(Portal) && place_meeting(x,y,Player) && entranceopen = true){
		with(GameCont){
			area = "deeplabs";
			subarea = 0;
		}
		instance_create(x, y, Portal);
		entranceopen = false;
	}
	
	 //Checks if a portal exists to open it
	if instance_exists(Portal) && sprite_index != spr_open{
		sprite_index = spr_opening;
		image_speed = 0.4;
			if(anim_end) && sprite_index != spr_open && sprite_index != spr_closed{
				entranceopen = true
			}
		if entranceopen = true{
			sound_play(sndGeneratorBreak)
			sprite_index = spr_open;
		}
	}


//#endregion
