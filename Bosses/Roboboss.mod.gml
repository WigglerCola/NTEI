#define init
//RoboBoss
global.sprRoboBossGun       = sprite_add("../sprites/enemies/roboboss/sprRoboBossGun.png",1,25,19);

global.song = sound_add("../sounds/music/musBossRobocenter.ogg");
//Laser
global.sprRoboBossBeam      		 = sprite_add("../sprites/enemies/projectiles/sprRoboBossBeam.png",1,0,12);
global.mskRoboBossBeam      		= sprite_add("../sprites/enemies/projectiles/mskRoboBossBeam.png",1,2,12);
global.sprRoboBossBeamEnd   		= sprite_add("../sprites/enemies/projectiles/sprRoboBossBeamEnd.png",3,5,5);
global.sprRoboBossBeamStart 		= sprite_add("../sprites/enemies/projectiles/sprRoboBossBeamStart.png",0,16,16);
global.sprRoboBossHead 				= sprite_add("../sprites/enemies/projectiles/sprRoboBossHead.png",0,16,4)
global.sprRoboBossWarningLaser       = sprite_add("../sprites/enemies/projectiles/sprRoboBossWarningLaser.png",1,0,6);
global.mskRoboBossWarningLaser       = sprite_add("../sprites/enemies/projectiles/mskRoboBossWarningLaser.png",1,2,12);
//Circle
global.sprRoboBossWarningCircle      = sprite_add("../sprites/enemies/projectiles/sprRoboBossWarningCircle.png",1,48,48);
global.mskRoboBossCircle    		 = sprite_add("../sprites/enemies/projectiles/mskRoboBossCircle.png",1,48,48);
global.sprRoboBossCircle    		= sprite_add("../sprites/enemies/projectiles/sprRoboBossCircle.png",6,48,48);

#macro current_frame_active (current_frame < floor(current_frame) + current_time_scale)
#macro BOSSNAME "boss name here"



#define GunEnemy_Draw                               if gunangle < 180{ draw_sprite_ext(spr_gun,0,x + lengthdir_x(-wkick,gunangle), y + lengthdir_y(-wkick, gunangle), 1, right, gunangle, image_blend, image_alpha);} draw_sprite_ext(sprite_index,image_index,x,y,image_xscale * right, image_yscale, image_angle, image_blend, image_alpha); if gunangle >= 180{ draw_sprite_ext(spr_gun,0,x + lengthdir_x(-wkick,gunangle), y + lengthdir_y(-wkick, gunangle), 1, right, gunangle, image_blend, image_alpha);}

//#define step
//	if button_pressed(0,"key4"){
//		repeat(1){
//	RoboBoss_create(mouse_x,mouse_y);
//	}}

#define RoboBoss_create(_x, _y)
with instance_create(_x, _y, CustomEnemy){
        //visuals
        spr_idle = sprSnowTankIdle;
		spr_walk = sprSnowTankWalk;
		spr_hurt = sprSnowTankHurt; 
		spr_dead = sprSnowTankDead;
		spr_gun = global.sprRoboBossGun;
		sprite_index = spr_idle;
		image_speed = 0.4;
		hitid = [sprSnowTankIdle, BOSSNAME]
        spr_shadow = shd24;	
        spr_shadow_x = 0.5;
        nts_color_blood = [make_color_rgb(96, 59, 52), c_black] //nts blood compat
        
        name = BOSSNAME;
		boss = true;
        bossname = BOSSNAME; //Sani Healthbar Compat
		col = c_red;		   //Sani Healthbar Compat
        //audio
		//Sounds are in on_hit and on_destroy
        //getreal
        mask_index = mskSnowTank; 
        size = 3;
        maxhealth = 300;
      	maxhealth += (maxhealth/3)*GameCont.loops
       	my_health = maxhealth;
        raddrop = 50;
        maxspeed = 2;
        team = 1;
        target = 0;
        walk = 0;
        targetvisible = 0;
        gunangle = 180;
        alrm1 = 100;
        alrm2 = 50;
        alrm3 = 50;
        laserfiring = 0;
        active = 0;
        intro = 0;
        //functions
        on_step = script_ref_create(RoboBoss_step);
        on_draw = GunEnemy_Draw;
        on_hurt = RoboBoss_hurt;
        on_destroy = RoboBoss_destroy;
}


#define RoboBoss_step

//Animations
if(nexthurt > current_frame){ //use hurt animation when being damaged
		if(sprite_index != spr_hurt){
			image_index = 0;
			sprite_index = spr_hurt;}}
	else{
		if(speed > friction) 
			sprite_index = spr_walk; //use walk animation when moving
		else 
			sprite_index = spr_idle; //use idle when not hurt or moving
		}
		
if speed > maxspeed{speed = maxspeed} //speedcap

//Targeting
if(instance_exists(Player))
	target = instance_nearest(x,y,Player);
	else target = -1;
if(instance_exists(target) && !collision_line(x,y,target.x,target.y,Wall,0,0)) //if not behind a wall, target is visible
	targetvisible = 1; 
	else 
	targetvisible = 0; //if target isn't visible, then its not visible
	

//firecounters
if alrm1 > 0 
	alrm1 -= (1 + GameCont.loops)
if alrm2 > 0 
	alrm2 -= (1 + GameCont.loops)
if alrm3 > 0 
	alrm3 -= (1 + GameCont.loops)	
//firecounter
if laserfiring > 0 
	laserfiring -=1

//Activation:
if distance_to_object(target) < 250 { active = 1 }
//Intro:
	if(!intro && distance_to_object(Player) < 250 && fork()){
		boss_intro();
		exit;
	}
	
//makes gun always point at target
gunangle -= (angle_difference(gunangle, point_direction(x, y, target.x, target.y)) * power(0.1*0.6, current_time_scale)); //thank u squiddy

//Movement:

if walk > 0{
	walk -= 1
	motion_add(gunangle, 0.8)}
	
if distance_to_object(target) > 70 and (random(20) < 1) and active = 1{
	direction = point_direction(x,y,target.x,target.y)
	walk = 35+random(10)
	}





//Laser Attack / Attack 1:
if alrm1 <= 0 and targetvisible == 1 and laserfiring == 0 and distance_to_object(target) > 50 and active = 1{	
    laserfiring += 90
	if !instance_exists(self){ exit;}
	direction = gunangle
	alrm1 = 200 + random(40)
	if instance_exists(self){
			if !instance_exists(self){ exit;}

            //warning
            repeat(5){
            with instance_create((x+lengthdir_x(0, direction)),(y+lengthdir_y(0, direction)),CustomProjectile){
             creator = other
             team = 1;
             direction = creator.gunangle
             image_angle = direction
             created = false
        	 sprite_index = global.sprRoboBossWarningLaser
	         mask_index   = global.mskRoboBossWarningLaser

            on_step = warning_laser
            on_wall = warning_wall
	        on_draw = warning_draw
	        on_hit  = warning_hit

             time = 2 + current_time_scale
             image_speed = 0
             bubbleImmune = 1
}
wait(5);
if !instance_exists(self) exit;
 }

//actual laser
if !instance_exists(self) exit;
			wkick += 8
            with instance_create((x+lengthdir_x(0, direction)),(y+lengthdir_y(0, direction)),CustomProjectile){
                creator = other
                team = 1;
                direction = creator.gunangle
                image_angle = direction
                 created = false
            	sprite_index = global.sprRoboBossBeam
            	mask_index   = global.mskRoboBossBeam
            	spr_tail     = global.sprRoboBossBeamStart
            	spr_head     = global.sprRoboBossHead

                on_step = beam_step
                on_wall = beam_wall
            	on_draw = beam_draw
            	on_hit  = beam_hit
            	on_cleanup = beam_cleanup

                time = 50 + current_time_scale
                image_speed = 0
                bubbleImmune = 1
}}}

//Circle Attack / Attack 2:
if alrm2 <= 0 and targetvisible == 0 and laserfiring == 0 and active = 1 or distance_to_object(target) < 50 and laserfiring == 0 and alrm2<=0{	
	if !instance_exists(self){ exit;}
	direction = gunangle
	alrm2 = 100 + random(40)
	if instance_exists(self){
			if !instance_exists(self){ exit;}

            //warning
            repeat(5){
            with instance_create((x+lengthdir_x(0, direction)),(y+lengthdir_y(0, direction)),CustomProjectile){
             creator = other
             team = 1;
        	 sprite_index = global.sprRoboBossWarningCircle
	         //mask_index   = global.mskRoboBossCircle
	         depth = -7
	         
	         bubbleImmune = 1

            on_wall = warning_wall
	        on_draw = circle_draw
	        on_hit  = warning_hit
	        on_step = warningcircle_step
}
wait(5);
if !instance_exists(self) exit;
 }

//actual circle
if !instance_exists(self) exit;
			
		sound_play_pitchvol(sndLightningCannon,1.2 * random_range(.9, 1.1), 1)
		sound_play_pitchvol(sndPlasmaRifle    ,0.8 * random_range(.9, 1.1), 0.25)
		
            with instance_create((x+lengthdir_x(0, direction)),(y+lengthdir_y(0, direction)),CustomProjectile){
             creator = other
             team = 1;
        	 sprite_index = global.sprRoboBossCircle
	         mask_index   = global.mskRoboBossCircle
	         depth = -7
            on_wall = circle_wall
	        on_draw = circle_draw
	        on_hit  = circle_hit
	        on_step = circle_step
	        hitid = [sprSnowTankIdle,BOSSNAME]
	        
	        circletime = 6;
	        bubbleImmune = 1
}}}

//Bullet Attack / Attack 3:
if alrm3 <= 0 and targetvisible == 1 and active = 1{	
	if !instance_exists(self){ exit;}
	direction = gunangle
	alrm3 = 75 + random(40)

	if instance_exists(self){
			if !instance_exists(self){ exit;}
            //Boolet
            repeat(10){
            sound_play_pitchvol(sndTurretFire,random_range(0.6,0.9),1)
            with instance_create((x+lengthdir_x(0, direction)),(y+lengthdir_y(0, direction)),EnemyBullet1){
             creator = other
             team = other.team;
             speed = 7;
             direction = other.gunangle + 90
			 image_angle = direction
			 hitid = [sprSnowTankIdle,BOSSNAME]
			}
            with instance_create((x+lengthdir_x(0, direction)),(y+lengthdir_y(0, direction)),EnemyBullet1){
             creator = other
             team = other.team;
             speed = 7;
             direction = other.gunangle + 180
			 image_angle = direction
			 hitid = [sprSnowTankIdle,BOSSNAME]			 
			}
			 with instance_create((x+lengthdir_x(0, direction)),(y+lengthdir_y(0, direction)),EnemyBullet1){
             creator = other
             team = other.team;
             speed = 7;
             direction = other.gunangle + 270
			 image_angle = direction
			 hitid = [sprSnowTankIdle,BOSSNAME]			 
			}
			 with instance_create((x+lengthdir_x(0, direction)),(y+lengthdir_y(0, direction)),EnemyBullet1){
             creator = other
             team = other.team;
             speed = 7;
             direction = other.gunangle + 360
			 image_angle = direction
			 hitid = [sprSnowTankIdle,BOSSNAME]			 
			}
wait(5);
if !instance_exists(self) exit;
 }}}

//on Hurt
#define RoboBoss_hurt(_damage, _force, _direction)
	my_health -= _damage;           // Damage
	nexthurt = current_frame + 6;   // I-Frames
	motion_add(_direction, _force); // Knockback
	sound_play_pitchvol(sndSnowBotHurt,random_range(0.5,0.7),0.9)  // Sound
	
	 // Hurt Sprite:
	sprite_index = spr_hurt;
	image_index  = 0;
	
//on Death
#define RoboBoss_destroy 
	pickup_drop(350, 15);
	pickup_drop(50, 0);
	pickup_drop(30, 0);
	sound_play_pitchvol(sndBigDogDeath,2,1)
	 // Boss Win Music:
	with(MusCont) alarm_set(1, 1);





//beam stuff
#define beam_step
if instance_exists(creator){
	if created = false{
		created = true
		sound_play_pitchvol(sndUltraLaserUpg,0.5 * random_range(.9, 1.1), 1)
		sound_play_pitchvol(sndPlasmaRifleUpg,0.5 * random_range(.9, 1.1), 0.25)
	}

    time -= current_time_scale
    if time <= 0 {instance_destroy(); exit}
    x = creator.x + creator.hspeed_raw + lengthdir_x(16,creator.gunangle)
    y = creator.y + creator.vspeed_raw + lengthdir_y(16,creator.gunangle)
    xstart = x
    ystart = y
    image_xscale = 1
    direction = creator.gunangle
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
        	sprite_index = global.sprRoboBossBeamEnd
        	image_angle = other.direction
					image_speed = .4;
        	motion_set(other.direction,choose(1,2))
        }
    }
    image_yscale = 1 * random_range(.9,1.1)
}
else instance_destroy()

#define beam_wall
//		with(other){
//		if (random(4) < 1){
//		instance_create(x, y, FloorExplo);
//	    instance_destroy();
//		}}
#define beam_hit
var _team = team
var _ang = direction
with(other){
if nexthurt <= current_frame{
projectile_hit(self,2)
hitid = [sprSnowTankIdle, BOSSNAME];
  }
}

#define beam_cleanup

#define beam_draw
draw_sprite_ext(sprite_index, image_index, xstart, ystart, image_xscale, image_yscale, image_angle, image_blend, 1.0);
draw_sprite_ext(sprite_index, image_index, xstart, ystart, image_xscale, image_yscale*1.7, image_angle, image_blend, 0.1);//bloom
	if x != xstart draw_sprite_ext(spr_tail, 1, xstart, ystart, 1, image_yscale, image_angle, image_blend, 1.0);
		if x != xstart draw_sprite_ext(spr_tail, 1, xstart, ystart, 1, image_yscale*1.5, image_angle, image_blend, 0.2);
	if x != xstart draw_sprite_ext(spr_head, 0, x, y, image_yscale*2, image_yscale*2, image_angle-45, image_blend, 1.0);
	if x != xstart draw_sprite_ext(spr_head, 0, x, y, image_yscale*2.7, image_yscale*2.7, image_angle-45, image_blend, 0.2); //bloom

#define warning_laser
if instance_exists(creator){
	if created = false{
		created = true
	}

    time -= current_time_scale
    if time <= 0 {instance_destroy(); exit}
    x = creator.x + creator.hspeed_raw + lengthdir_x(8,creator.gunangle)
    y = creator.y + creator.vspeed_raw + lengthdir_y(8,creator.gunangle)
    xstart = x
    ystart = y
    image_xscale = 1
    direction = creator.gunangle
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
#define warning_wall
#define warning_hit
#define warning_draw
draw_sprite_ext(sprite_index, image_index, xstart, ystart, image_xscale, image_yscale, image_angle, image_blend, 1.0);
draw_sprite_ext(sprite_index, image_index, xstart, ystart, image_xscale, image_yscale*1.7, image_angle, image_blend, 0.2);//bloom

#define circle_draw
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 1.0);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale*1.1, image_yscale*1.1, image_angle, image_blend, 0.1);//bloom
#define circle_wall with(other){ instance_create(x, y, FloorExplo); instance_destroy();}
#define circle_hit  projectile_hit(other,damage);
#define circle_step
		if circletime > 0 
			circletime -=1
if instance_exists(creator){
		xprevious = creator.x;
		yprevious = creator.y;
		x = creator.x;
		y = creator.y;
}
if circletime <= 0 or !instance_exists(creator){ instance_destroy() }
#define warningcircle_step
if instance_exists(creator){
		xprevious = creator.x;
		yprevious = creator.y;
		x = creator.x;
		y = creator.y;
}
wait(1);
instance_destroy();



//Intro
//thanks NTTE
#define boss_intro
intro = true;
wait(5);
with(MusCont){
	alarm_set(2, 1);
	alarm_set(3, -1);
}
with(script_bind_begin_step(boss_intro_step, 0)){
	boss    = "RoboBoss";
	loops   = 0;
	intro   = true;
	sprites = [
		[`../Sprites/Enemies/Roboboss/${boss}Main.png`, sprBossIntro,          0],
		[`../Sprites/Enemies/Roboboss/${boss}Back.png`, sprBossIntroBackLayer, 0],
		[`../Sprites/Enemies/Roboboss/${boss}Name.png`, sprBossName,           0]
	];
	
	 // Preload Sprites:
	with(sprites){
		if(!file_loaded(self[0])){
			file_load(self[0]);
		}
	}
}
sound_play_pitchvol(sndBigDogIntro,2,1);

//thank u ntte
#define boss_intro_step
	if(intro){
		intro = false;
		
		 // Preload Sprites:
		with(sprites){
			if(!file_loaded(self[0])){
				other.intro = true;
				break;
			}
		}
		
		 // Boss Intro Time:
		if(!intro && UberCont.opt_bossintros == true && GameCont.loops <= loops){
			 // Replace Big Bandit's Intro:
			with(sprites){
				if(file_exists(self[0])){
					sprite_replace_image(self[1], self[0], self[2]);
				}
			}
			
			 // Call Big Bandit's Intro:
			var	_lastSub   = GameCont.subarea,
				_lastLoop  = GameCont.loops,
				_lastIntro = UberCont.opt_bossintros;
				
			GameCont.loops          = 0;
			UberCont.opt_bossintros = true;
			
			with(instance_create(0, 0, BanditBoss)){
				with(self){
					event_perform(ev_alarm, 6);
				}
				sound_stop(sndBigBanditIntro);
				instance_delete(id);
			}
			
			with(MusCont){
				alarm_set(3, -1);
			}
			
			GameCont.subarea        = _lastSub;
			GameCont.loops          = _lastLoop;
			UberCont.opt_bossintros = _lastIntro;
		}
		sound_play_music(global.song);
	}
	
	 // End:
	else{
		with(sprites){
			sprite_restore(self[1]);
		}
		instance_destroy();
	}