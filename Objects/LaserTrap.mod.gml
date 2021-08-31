//the lasers for this are a fucked up version of the Vector Cannon laser from Defpack, go play defpack
//this file is so horrible im actually kinda sorry please do not base anything off of this for your own sake
//there's definitely a way to not make this file have 8 different steps but im tired so ill fix it later (probably not)
	
#define init
global.sprLaserTrap = sprite_add("../sprites/objects/LaserTrap/sprLaserTrap.png",1,11,16)
global.sprLaserTrapGameover = sprite_add("../sprites/objects/LaserTrap/sprLaserTrap.png",1,11,8)

global.sprLaserTrapBeam       = sprite_add("../sprites/objects/LaserTrap/sprLaserTrapBeam.png",1,0,6);
global.mskLaserTrapBeam       = sprite_add("../sprites/objects/LaserTrap/mskLaserTrapBeam.png",1,2,6);
global.sprLaserTrapBeamEnd   = sprite_add("../sprites/objects/LaserTrap/sprLaserTrapBeamEnd.png",3,5,5);
global.sprLaserTrapBeamStart = sprite_add("../sprites/objects/LaserTrap/sprLaserTrapBeamStart.png",0,8,8);
global.sprLaserTrapHead 	  = sprite_add("../sprites/objects/LaserTrap/sprLaserTrapHead.png",0,8,2)
global.sprWarningLaser       = sprite_add("../sprites/objects/LaserTrap/sprWarningLaser.png",1,0,6);

#macro current_frame_active (current_frame < floor(current_frame) + current_time_scale)

#define LaserTrap_create(_myx, _myy)

	with(instance_create(_myx, _myy, CustomObject)){
		depth = -6;
		sprite_index = global.sprLaserTrap;

		
		FireTimer = 80 + random_range(0,15); //how much time before it activates after spawning, random is there so traps have different timed patterns
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
	FireTimer -=1; 

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
    image_angle = direction
    created = false
	sprite_index = global.sprWarningLaser
	mask_index   = global.mskLaserTrapBeam

    on_step = warning_laser_1
    on_wall = beam_wall
	on_draw = warning_draw
	on_hit  = warning_hit

    time = 2 + current_time_scale
    image_speed = 0
    bubbleImmune = 1
}

with instance_create((x+lengthdir_x(0, direction)),(y+lengthdir_y(0, direction)),CustomProjectile){
    creator = other
    team = 1;
    direction = 90;
    image_angle = direction
    created = false
	sprite_index = global.sprWarningLaser
	mask_index   = global.mskLaserTrapBeam

    on_step = warning_laser_2
    on_wall = beam_wall
	on_draw = warning_draw
	on_hit  = warning_hit

    time = 2 + current_time_scale
    image_speed = 0
    bubbleImmune = 1
}

if !instance_exists(self) exit;
wait(5);}
if !instance_exists(self){ exit;}

//actual laser
with instance_create((x+lengthdir_x(0, direction)),(y+lengthdir_y(0, direction)),CustomProjectile){
    creator = other
    team = 1;
    direction = 270;
    image_angle = direction
    created = false
	sprite_index = global.sprLaserTrapBeam
	mask_index   = global.mskLaserTrapBeam
	spr_tail     = global.sprLaserTrapBeamStart
	spr_head     = global.sprLaserTrapHead

    on_step = beam_step_1
    on_wall = beam_wall
	on_draw = beam_draw
	on_hit  = beam_hit
	on_cleanup = beam_cleanup

    time = 25 + current_time_scale
    image_speed = 0
    bubbleImmune = 1
}

with instance_create((x+lengthdir_x(0, direction)),(y+lengthdir_y(0, direction)),CustomProjectile){
    creator = other
    team = 1;
    direction = 90;
    image_angle = direction
    created = false
	sprite_index = global.sprLaserTrapBeam
	mask_index   = global.mskLaserTrapBeam
	spr_tail     = global.sprLaserTrapBeamStart
	spr_head     = global.sprLaserTrapHead

    on_step = beam_step_2
    on_wall = beam_wall
	on_draw = beam_draw
	on_hit  = beam_hit
	on_cleanup = beam_cleanup

    time = 25 + current_time_scale
    image_speed = 0
    bubbleImmune = 1
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
    image_angle = direction
    created = false
	sprite_index = global.sprWarningLaser
	mask_index   = global.mskLaserTrapBeam

    on_step = warning_laser_3
    on_wall = beam_wall
	on_draw = warning_draw
	on_hit  = warning_hit

    time = 2 + current_time_scale
    image_speed = 0
    bubbleImmune = 1
}

with instance_create((x+lengthdir_x(0, direction)),(y+lengthdir_y(0, direction)),CustomProjectile){
    creator = other
    team = 1;
    direction = 0;
    image_angle = direction
    created = false
	sprite_index = global.sprWarningLaser
	mask_index   = global.mskLaserTrapBeam

    on_step = warning_laser_4
    on_wall = beam_wall
	on_draw = warning_draw
	on_hit  = warning_hit

    time = 2 + current_time_scale
    image_speed = 0
    bubbleImmune = 1
}

if !instance_exists(self) exit;
wait(5);}
if !instance_exists(self){ exit;}
//actual laser
with instance_create((x+lengthdir_x(0, direction)),(y+lengthdir_y(0, direction)),CustomProjectile){
    creator = other
    team = 1;
    direction = 180;
    image_angle = direction
    created = false
	sprite_index = global.sprLaserTrapBeam
	mask_index   = global.mskLaserTrapBeam
	spr_tail     = global.sprLaserTrapBeamStart
	spr_head     = global.sprLaserTrapHead

    on_step = beam_step_3
    on_wall = beam_wall
	on_draw = beam_draw
	on_hit  = beam_hit
	on_cleanup = beam_cleanup

    time = 25 + current_time_scale
    image_speed = 0
    bubbleImmune = 1
}

with instance_create((x+lengthdir_x(0, direction)),(y+lengthdir_y(0, direction)),CustomProjectile){
    creator = other
    team = 1;
    direction = 0;
    image_angle = direction
    created = false
	sprite_index = global.sprLaserTrapBeam
	mask_index   = global.mskLaserTrapBeam
	spr_tail     = global.sprLaserTrapBeamStart
	spr_head     = global.sprLaserTrapHead

    on_step = beam_step_4
    on_wall = beam_wall
	on_draw = beam_draw
	on_hit  = beam_hit
	on_cleanup = beam_cleanup

    time = 25 + current_time_scale
    image_speed = 0
    bubbleImmune = 1
} 


Fire2 = 0; //makes it so the trap wil fire attack 1 next
Fire1 = 1;



//vector stuff (im sorry for ruining it)
#define beam_cleanup
sound_set_track_position(sndEnergyHammerUpg,0)
sound_set_track_position(sndLaserUpg,0)
sound_set_track_position(sndLaser,0)
sound_stop(sndEnergyHammerUpg)

//im so sorry
#define beam_step_1
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
    x = creator.x + creator.hspeed_raw + lengthdir_x(16,270)
    y = creator.y + creator.vspeed_raw + lengthdir_y(16,270)
    xstart = x
    ystart = y
    image_xscale = 1
    direction = 270.014 //im so bewildered by this I can't just set it to 270 because it fucks it up it doesn't make any sense
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
    if current_frame_active{
        var _r = random_range(0,image_xscale*2+12)
        with instance_create(x-lengthdir_x(_r,direction)+random_range(-5,5),y-lengthdir_y(_r,direction)+random_range(-5,5),BulletHit)
				{
        	sprite_index = global.sprLaserTrapBeamEnd
        	image_angle = other.direction
					image_speed = .4;
        	motion_set(other.direction,choose(1,2))
        }
    }
    image_yscale = 1 * random_range(.9,1.1)
    sound_set_track_position(sndEnergyHammerUpg,0)
    sound_set_track_position(sndLaserUpg,0)
    sound_set_track_position(sndLaser,0)
}
else instance_destroy()

#define beam_step_2
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
    x = creator.x + creator.hspeed_raw + lengthdir_x(16,90)
    y = creator.y + creator.vspeed_raw + lengthdir_y(16,90)
    xstart = x
    ystart = y
    image_xscale = 1
    direction = 90.014 //im so bewildered by this I can't just set it to 90 because it fucks it up it doesn't make any sense
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
    if current_frame_active{
        var _r = random_range(0,image_xscale*2+12)
        with instance_create(x-lengthdir_x(_r,direction)+random_range(-5,5),y-lengthdir_y(_r,direction)+random_range(-5,5),BulletHit)
				{
        	sprite_index = global.sprLaserTrapBeamEnd
        	image_angle = other.direction
					image_speed = .4;
        	motion_set(other.direction,choose(1,2))
        }
    }
    image_yscale = 1 * random_range(.9,1.1)
    sound_set_track_position(sndEnergyHammerUpg,0)
    sound_set_track_position(sndLaserUpg,0)
    sound_set_track_position(sndLaser,0)
}
else instance_destroy()

#define beam_step_3
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
    x = creator.x + creator.hspeed_raw + lengthdir_x(16,180)
    y = creator.y + creator.vspeed_raw + lengthdir_y(16,180)
    xstart = x
    ystart = y
    image_xscale = 1
    direction = 180
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
    if current_frame_active{
        var _r = random_range(0,image_xscale*2+12)
        with instance_create(x-lengthdir_x(_r,direction)+random_range(-5,5),y-lengthdir_y(_r,direction)+random_range(-5,5),BulletHit)
				{
        	sprite_index = global.sprLaserTrapBeamEnd
        	image_angle = other.direction
					image_speed = .4;
        	motion_set(other.direction,choose(1,2))
        }
    }
    image_yscale = 1 * random_range(.9,1.1)
    sound_set_track_position(sndEnergyHammerUpg,0)
    sound_set_track_position(sndLaserUpg,0)
    sound_set_track_position(sndLaser,0)
}
else instance_destroy()

#define beam_step_4
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
    x = creator.x + creator.hspeed_raw + lengthdir_x(16,0)
    y = creator.y + creator.vspeed_raw + lengthdir_y(16,0)
    xstart = x
    ystart = y
    image_xscale = 1
    direction = 0
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
    if current_frame_active{
        var _r = random_range(0,image_xscale*2+12)
        with instance_create(x-lengthdir_x(_r,direction)+random_range(-5,5),y-lengthdir_y(_r,direction)+random_range(-5,5),BulletHit)
				{
        	sprite_index = global.sprLaserTrapBeamEnd
        	image_angle = other.direction
					image_speed = .4;
        	motion_set(other.direction,choose(1,2))
        }
    }
    image_yscale = 1 * random_range(.9,1.1)
    sound_set_track_position(sndEnergyHammerUpg,0)
    sound_set_track_position(sndLaserUpg,0)
    sound_set_track_position(sndLaser,0)
}
else instance_destroy()
#define beam_wall

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
draw_sprite_ext(sprite_index, image_index, xstart, ystart, image_xscale, image_yscale*1.7, image_angle, image_blend, 0.2);//bloom
	if x != xstart draw_sprite_ext(spr_tail, 1, xstart, ystart, 1, image_yscale, image_angle, image_blend, 1.0);
		if x != xstart draw_sprite_ext(spr_tail, 1, xstart, ystart, 1, image_yscale*1.5, image_angle, image_blend, 0.2);
	if x != xstart draw_sprite_ext(spr_head, 0, x, y, image_yscale*2, image_yscale*2, image_angle-45, image_blend, 1.0);
	if x != xstart draw_sprite_ext(spr_head, 0, x, y, image_yscale*2.7, image_yscale*2.7, image_angle-45, image_blend, 0.2); //bloom

//laser warning thing I made it even worse somehow
#define warning_laser_1
if instance_exists(creator){
	if created = false{
		created = true
	}

    time -= current_time_scale
    if time <= 0 {instance_destroy(); exit}
    x = creator.x + creator.hspeed_raw + lengthdir_x(8,270)
    y = creator.y + creator.vspeed_raw + lengthdir_y(8,270)
    xstart = x
    ystart = y
    image_xscale = 1
    direction = 270.014 //im so bewildered by this I can't just set it to 270 because it fucks it up it doesn't make any sense
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

#define warning_laser_2
if instance_exists(creator){
	if created = false{
		created = true
	}

    time -= current_time_scale
    if time <= 0 {instance_destroy(); exit}
    x = creator.x + creator.hspeed_raw + lengthdir_x(8,90)
    y = creator.y + creator.vspeed_raw + lengthdir_y(8,90)
    xstart = x
    ystart = y
    image_xscale = 1
    direction = 90.014 //im so bewildered by this I can't just set it to 270 because it fucks it up it doesn't make any sense
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

#define warning_laser_3
if instance_exists(creator){
	if created = false{
		created = true
	}

    time -= current_time_scale
    if time <= 0 {instance_destroy(); exit}
    x = creator.x + creator.hspeed_raw + lengthdir_x(8,180)
    y = creator.y + creator.vspeed_raw + lengthdir_y(8,180)
    xstart = x
    ystart = y
    image_xscale = 1
    direction = 180
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

#define warning_laser_4
if instance_exists(creator){
	if created = false{
		created = true
	}

    time -= current_time_scale
    if time <= 0 {instance_destroy(); exit}
    x = creator.x + creator.hspeed_raw + lengthdir_x(8,0)
    y = creator.y + creator.vspeed_raw + lengthdir_y(8,0)
    xstart = x
    ystart = y
    image_xscale = 1
    direction = 0
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

#define warning_hit

#define warning_draw
draw_sprite_ext(sprite_index, image_index, xstart, ystart, image_xscale, image_yscale, image_angle, image_blend, 1.0);
draw_sprite_ext(sprite_index, image_index, xstart, ystart, image_xscale, image_yscale*1.7, image_angle, image_blend, 0.2);//bloom


