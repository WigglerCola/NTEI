
//BOSSES ARE GOING TO BE STORED SEPERATELY IN THEIR OWN FILES.
//Any custom projectiles they might end up using will probably be in here aswell, so this file is likely going to be pretty annoying to manage, but at least it shouldn't cause performance issues.

#define init

//Roller Turret Sprites
global.sprRollerTurretIdle = sprite_add("sprites/enemies/rollerturret/sprRollerTurretIdle.png", 5, 24, 16)
global.sprRollerTurretWalk = sprite_add("sprites/enemies/rollerturret/sprRollerTurretWalk.png", 6, 24, 16)
global.sprRollerTurretHurt = sprite_add("sprites/enemies/rollerturret/sprRollerTurretHurt.png", 3, 24, 16)
global.sprRollerTurretDead = sprite_add("sprites/enemies/rollerturret/sprRollerTurretDead.png", 6, 24, 16)
global.sprRollerTurretFire = sprite_add("sprites/enemies/rollerturret/sprRollerTurretFire.png", 5, 24, 16)
global.sprRollerTurretRoll = sprite_add("sprites/enemies/rollerturret/sprRollerTurretRoll.png", 3, 24, 6)
//Swarm Bot Sprites
global.sprSwarmBotIdle = sprite_add("sprites/enemies/swarmbot/sprSwarmBotIdle.png", 5, 15, 16)
global.sprSwarmBotWalk = sprite_add("sprites/enemies/swarmbot/sprSwarmBotWalk.png", 6, 15, 16)
global.sprSwarmBotHurt = sprite_add("sprites/enemies/swarmbot/sprSwarmBotHurt.png", 3, 15, 16)
global.sprSwarmBotDead = sprite_add("sprites/enemies/swarmbot/sprSwarmBotDead.png", 6, 15, 16)
//Engineer Sprites
global.sprEngineerIdle = sprite_add("sprites/enemies/engineer/sprEngineerIdle.png", 4, 16, 20)
global.sprEngineerWalk = sprite_add("sprites/enemies/engineer/sprEngineerWalk.png", 6, 16, 20)
global.sprEngineerHurt = sprite_add("sprites/enemies/engineer/sprEngineerHurt.png", 3, 16, 20)
global.sprEngineerDead = sprite_add("sprites/enemies/engineer/sprEngineerDead.png", 6, 16, 20)
global.sprEngineerCannon = sprite_add("sprites/enemies/engineer/sprEngineerCannon.png", 1, 6, 0)
global.sprEngineerWrench = sprite_add("sprites/enemies/engineer/sprEngineerWrench.png", 1, 6, 0)
//Projectiles/Effects
global.sprSwarmBotFired = sprite_add("sprites/enemies/projectiles/sprSwarmBotFired.png", 1, 7, 5)
global.sprWhiteSmoke = sprite_add("sprites/particles/sprWhiteSmoke.png",5,12,12)

//general scripts
#define StandardDrops                               pickup_drop(40, 10, 2);
#define LessDrops                                   pickup_drop(7, 5, 0);
#define BasicEnemy_Draw                             draw_sprite_ext(sprite_index,image_index,x,y,image_xscale * right, image_yscale, image_angle, image_blend, image_alpha);
#define GunEnemy_Draw                               if gunangle < 180{ draw_sprite_ext(spr_gun,0,x + lengthdir_x(-wkick,gunangle), y + lengthdir_y(-wkick, gunangle), 1, right, gunangle, image_blend, image_alpha);} draw_sprite_ext(sprite_index,image_index,x,y,image_xscale * right, image_yscale, image_angle, image_blend, image_alpha); if gunangle >= 180{ draw_sprite_ext(spr_gun,0,x + lengthdir_x(-wkick,gunangle), y + lengthdir_y(-wkick, gunangle), 1, right, gunangle, image_blend, image_alpha);}

//remove this step later, this is for dev stuff
//#define step 
//
//	if button_pressed(0,"horn"){
//		repeat(1){
//	RavenAmalgam_create(mouse_x,mouse_y);
//	}}





//SwarmBot
#define SwarmBot_create(_x, _y)
with instance_create(_x, _y, CustomEnemy){
        //visuals
        spr_idle = global.sprSwarmBotIdle;
		spr_walk = global.sprSwarmBotWalk;
		spr_hurt = global.sprSwarmBotHurt; 
		spr_dead = global.sprSwarmBotDead;
		sprite_index = spr_idle;
		image_speed = 0.4;
		hitid = [global.sprSwarmBotIdle, "SWARMBOT"]
        spr_shadow = shd24;	
        spr_shadow_x = 0.5;
        nts_color_blood = [make_color_rgb(96, 59, 52), c_black] //nts blood compat
        //audio
        snd_hurt = sndHydrantBreak //placeholder, get better sound later
        snd_dead = sndPlantPotBreak //also placeholder
        //getreal
        mask_index = mskFreak; 
        maxhealth = 10;
        my_health = maxhealth;
        raddrop = 2;
        maxspeed = 3;
        canmelee = 1;
        meleedamage = 2;
        team = 1;
        target = 0;
        panic = 0;
        walk = 0;
        targetvisible = 0;
        //functions
        on_step = script_ref_create(SwarmBot_step);
        on_draw = BasicEnemy_Draw;
        on_death = LessDrops;
}
#define SwarmBot_step

   
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
//Targeting
if(instance_exists(Player))
	target = instance_nearest(x,y,Player);
	else target = -1;
if(instance_exists(target) && !collision_line(x,y,target.x,target.y,Wall,0,0)) //if not behind a wall, target is visible
	targetvisible = 1; 
	else 
	targetvisible = 0; //if target isn't visible, then its not visible


	
//strolling around like a little idiot when it can't find a target and not panicking
if walk > 0{
	walk -= 1
	motion_add(direction, 0.8)
}
if speed > maxspeed{ //without this part they go absolutely nuts
	speed = maxspeed
	}	
if targetvisible == 0 and (random(50) < 1) and panic = 0{
	direction = random(360)
	walk = 25+random(10)
	}


//runs at you and kills you
if panic = 0 and targetvisible = 1 {
	if random(25)<1
		motion_add(direction+choose(-90,90),3)
	if speed > random(7)
		speed = 3
	motion_add(point_direction(x,y,target.x,target.y),1)
	}
	
//slap this in so the sprite flips correctly
right = (direction + 270) mod 360 > 180 ? 1 : -1;


#define Engineer_create(_x, _y)
with instance_create(_x, _y, CustomEnemy){
        //visuals
        spr_idle = global.sprEngineerIdle;
		spr_walk = global.sprEngineerWalk;
		spr_hurt = global.sprEngineerHurt; 
		spr_dead = global.sprEngineerDead;
		spr_gun = global.sprEngineerCannon;
		sprite_index = spr_idle;
		image_speed = 0.4;
		hitid = [global.sprEngineerIdle, "ENGINEER"]
        spr_shadow = shd24;	
        spr_shadow_y = 1;
        nts_color_blood = [c_red, make_color_rgb(134, 44, 35)] //nts blood compat
        //audio
        snd_hurt = sndNecromancerHurt
        snd_dead = sndNecromancerDead
        //getreal
        mask_index = mskBandit; //PLACEHOLDER - GET NEW MASK 
        maxhealth = 6;
       	my_health = maxhealth;
        raddrop = 8;
        maxspeed = 2.5;
        canmelee = 0;
        meleedamage = 0;
        team = 1;
        target = 0;
        panic = 0;
        walk = 0;
        targetvisible = 0;
        gunangle = 180;
        alrm1 = 100;
        panicrange = 60;


        //functions
        on_step = script_ref_create(Engineer_step);
        on_draw = GunEnemy_Draw;
        on_death = StandardDrops;
}


#define Engineer_step

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
//Targeting
if(instance_exists(Player))
	target = instance_nearest(x,y,Player);
	else target = -1;
if(instance_exists(target) && !collision_line(x,y,target.x,target.y,Wall,0,0)) //if not behind a wall, target is visible
	targetvisible = 1; 
	else 
	targetvisible = 0; //if target isn't visible, then its not visible

//walking stuff
//strolling around like a little idiot when it can't find a target and not panicking
if walk > 0 and targetvisible = 0{
	walk -= 1
	motion_add(gunangle, 0.8) }
//idle walkin
if targetvisible == 0 and (random(50) < 1){
	gunangle = random(360)
	walk = 20+random(10) }
	
//when has a target
if walk > 0 and targetvisible = 1{
	walk -= 1
	motion_add(gunangle + random_range(40,80), 0.8) }
//target walkin
if targetvisible == 1 and (random(40) < 1){
	walk = 20+random(10) }
	

//firecounter
if alrm1 > 0 
	alrm1-=1

if speed > maxspeed{speed = maxspeed}	//without this part they go absolutely nuts

//Panic Switch
if distance_to_object(target) < panicrange  and targetvisible = 1{ panic = 1 }
if distance_to_object(target) > panicrange{ panic = 0 }
//Panic Wep Switch
if panic = 1 { spr_gun = global.sprEngineerWrench}
if panic = 0 { spr_gun = global.sprEngineerCannon} 

//Panic Particles
if panic = 1 and random (random(5) < 1){instance_create(x,y,Sweat)}

//Attacks
//Fire Swarmbot Projectile
if alrm1 <= 0 and targetvisible == 1 and panic == 0{
	alrm1 = 65 + random(20)
	wait(random_range(10,20)); //wait is here so they don't insta-snipe you when you peek corners
	if !instance_exists(self){ exit;}
	if targetvisible = 0{ exit;} //makes it so they wont fire if you become not visible again
	gunangle = point_direction(x,y,target.x,target.y)
	direction = gunangle
			with instance_create((x+lengthdir_x(0, gunangle)),(y+lengthdir_y(0, gunangle)),CustomEnemy){ //Projectile
				hitid = [global.sprEngineerIdle,"ENGINEER"]
				sprite_index = global.sprSwarmBotFired;
				mask_index = mskBullet1;
				damage = 2
				maxspeed = 10
				speed = maxspeed
				team = other.team
				direction = other.gunangle+random_range(-25,25)
				creator = other
				image_angle = direction
				typ = 1 //can be reflected
				//functions
				on_step = EngineerProjectile_step;
				on_wall = EngineerProjectile_wall;
				on_destroy = EngineerProjectile_destroy;
				}
			if !instance_exists(self){ exit;}
			wkick += 8
			//sound_play(sndEnemyFire)
			sound_play_pitchvol(sndGrenadeRifle,random_range(1.3,1.5),0.8)

			
			//smoke particles
			repeat(5)
			with instance_create(x+lengthdir_x(15,gunangle),y+lengthdir_y(15,gunangle),Smoke){
			sprite_index = global.sprWhiteSmoke;
			image_xscale = 0.2 + random_range(0.1,0.5);
			image_yscale = image_xscale;
			motion_add(other.direction+random_range(-10,10),1+random(2)) }
}
			
//Wrench Swing
if alrm1 <= 0 and targetvisible == 1 and panic == 1{	
	direction = gunangle
	alrm1 = 50 + random(20)
	if instance_exists(self){
			instance_create(x,y,AssassinNotice)
			wait(5);
		if !instance_exists(self){ exit;}
			gunangle = point_direction(x,y,target.x,target.y)
			with instance_create((x+lengthdir_x(1, gunangle)),(y+lengthdir_y(1, gunangle)),EnemySlash){ //Melee Slash
				sound_play(sndAssassinAttack)
				hitid = [global.sprEngineerIdle,"ENGINEER"]
				damage = 3
				speed = 2
				team = other.team
				direction = other.gunangle+random_range(-15,15)
				creator = other
				image_angle = direction
				}
			motion_add(gunangle, 3.5);
			}}

//slap this in so the sprite flips correctly
right = (gunangle + 270) mod 360 > 180 ? 1 : -1;



//Roller Turret
#define RollerTurret_create(_x, _y)
with instance_create(_x, _y, CustomEnemy){
        //visuals
        spr_idle = global.sprRollerTurretIdle;
		spr_walk = global.sprRollerTurretWalk;
		spr_hurt = global.sprRollerTurretHurt; 
		spr_dead = global.sprRollerTurretDead;
		spr_roll = global.sprRollerTurretRoll;
		spr_fire = global.sprRollerTurretFire;
		sprite_index = spr_idle;
		image_speed = 0.4;
		hitid = [global.sprRollerTurretIdle, "RollerTurret"]
        spr_shadow = shd64;	
        spr_shadow_y = -1;
        nts_color_blood = [make_color_rgb(96, 59, 52), c_black] //nts blood compat
        //audio
        snd_hurt = sndTurretHurt //placeholder, get better sound later
        snd_dead = sndTurretDead //also placeholder
        //getreal
        mask_index = mskBigMaggot; 
        maxhealth = 30;
        my_health = maxhealth;
        raddrop = 4;
        maxspeed = 1;
        canmelee = 0;
        meleedamage = 0;
        team = 1;
        target = 0;
        targetvisible = 0;
        alrm1 = 100;
        rolling = 0;
        rolltime = 0;
        fireanim = 0;
        gunangle = 180;
        //functions
        on_step = script_ref_create(RollerTurret_step);
        on_draw = BasicEnemy_Draw;
        on_death = StandardDrops;
}

#define RollerTurret_step

//Animations
if(nexthurt > current_frame){ //use hurt animation when being damaged
		if(sprite_index != spr_hurt){
			image_index = 0;
			sprite_index = spr_hurt;}}
	
	else{
		if(fireanim > 0)
		sprite_index = spr_fire
		
	else{
		if(rolling > 0)
		sprite_index = spr_roll

	else{
		if(speed > friction) and rolling = 0
			sprite_index = spr_walk; //use walk animation when moving
		else 
			sprite_index = spr_idle; //use idle when not hurt or moving
		}}}
//Targeting
if(instance_exists(Player))
	target = instance_nearest(x,y,Player);
	else target = -1;
if(instance_exists(target) && !collision_line(x,y,target.x,target.y,Wall,0,0)) //if not behind a wall, target is visible
	targetvisible = 1; 
	else 
	targetvisible = 0; //if target isn't visible, then its not visible

//firecounter
if alrm1 > 0 
	alrm1-=1
	
//fireanimcounter
if fireanim > 0 
	fireanim-=1

//without this part they go absolutely nuts
if speed > 2 and rolling == 0{
	speed = 2}		
if speed > 4 and rolling == 1{ 
	speed = 4}	

//Rollin

//Roll Switch
if rolltime > 0 { rolling = 1}
if rolltime < 0 { rolling = 0}

//strolling around like a little idiot when it can't find a target and not panicking
if rolltime > 0{
	rolltime -= 1
	motion_add(direction, 0.8)
}
//if target visible
if distance_to_object(target) > 130 and targetvisible == 1 and (random(50) < 1){
	direction = point_direction(x,y,target.x,target.y)
	rolltime = 25+random(10)
	sound_play_pitchvol(sndWolfRoll,random_range(0.8,1.2),1)
	}
//target not visible
//if targetvisible == 0 and (random(50) < 1){
//	direction = random(360)
//	rolltime = 30+random(10)
//	sound_play_pitchvol(sndWolfRoll,random_range(0.8,1.2),0.5)
//	}

	
//Bullet Attack
if alrm1 <= 0 and targetvisible == 1 and rolling = 0 and distance_to_object(target) < 130{	
	if !instance_exists(self){ exit;}
	direction = gunangle
	alrm1 = 100 + random(40)
	if instance_exists(self){
			gunangle = point_direction(x,y,target.x,target.y)
			
			wait(random_range(10,20)); //wait is here so they don't insta-snipe you when you peek corners
			if !instance_exists(self){ exit;}
			if targetvisible = 0{ exit;} //makes it so they wont fire if you become not visible again
			fireanim = 25
			repeat(10){
			if !instance_exists(self){ exit;}
			with instance_create((x+lengthdir_x(1, gunangle)),(y+lengthdir_y(1, gunangle)),EnemyBullet1){ //Bullets
				sound_play_pitchvol(sndTurretFire,random_range(1,1.3),1)
				hitid = [global.sprRollerTurretIdle,"ROLLER TURRET"]
				damage = 3
				speed = 7
				team = other.team
				direction = other.gunangle+random_range(-4,4)
				creator = other
				image_angle = direction
				} wait(2.5);
			}}}


//Raven Amalgam
#define RavenAmalgam_create(_x, _y)
with instance_create(_x, _y, CustomEnemy){
        //visuals
        spr_idle = sprRhinoFreakIdle;
		spr_walk = sprRhinoFreakWalk;
		spr_hurt = sprRhinoFreakHurt; 
		spr_dead = sprRhinoFreakDead;
		spr_chrg = sprRhinoFreakDead;
		spr_fire = sprRhinoFreakHurt;
		sprite_index = spr_idle;
		image_speed = 0.4;
		hitid = [spr_idle, "RAVEN AMALGAM"]
        spr_shadow = shd48;	
        spr_shadow_y = 0;
        nts_color_blood = [c_red, make_color_rgb(134, 44, 35)] //nts blood compat
        //audio
		//Sounds in on_hurt and on_death
        //getreal
        mask_index = mskRhinoFreak; 
        maxhealth = 45;
        my_health = maxhealth;
        raddrop = 4;
        maxspeed = 1.5;
        canmelee = 1;
        meleedamage = 2;
        team = 1;
        target = 0;
        targetvisible = 0;
        alrm1 = 100;
        charging = 0;
        chargetime = 0;
        walk = 0;
        activated = 0;
        speedpause = 0;
        //functions
        on_step = RavenAmalgam_step;
        on_draw = BasicEnemy_Draw;
        on_hurt = RavenAmalgam_hurt
        on_death = RavenAmalgam_death;
}

#define RavenAmalgam_step
//Animations
if(nexthurt > current_frame){ //use hurt animation when being damaged
		if(sprite_index != spr_hurt){
			image_index = 0;
			sprite_index = spr_hurt;}}
	else{
		if(speedpause > 0)
		sprite_index = spr_chrg
		
	else{
		if(charging > 0)
		sprite_index = spr_fire

	else{
		if(speed > friction) and charging = 0
			sprite_index = spr_walk; //use walk animation when moving
		else 
			sprite_index = spr_idle; //use idle when not hurt or moving
		}}}
//Targeting
if(instance_exists(Player))
	target = instance_nearest(x,y,Player);
	else target = -1;
if(instance_exists(target) && !collision_line(x,y,target.x,target.y,Wall,0,0)) //if not behind a wall, target is visible
	targetvisible = 1; 
	else 
	targetvisible = 0; //if target isn't visible, then its not visible

//without this part they go absolutely nuts
if speed > 1.5 and charging == 0{
	speed = 1.5}		
if speed > 3.5 and charging == 1{ 
	speed = 3.5}
if speedpause > 0 {speed = -0}

if charging = 1{ meleedamage = 2 }
if charging = 20{ meleedamage = 5 }

if charging < 1{ size = 2 }
if charging > 0{ size = 6 }
	
//walking stuff
//strolling around like a little idiot when it can't find a target and not panicking
if walk > 0{
	walk -= 1
	motion_add(direction, 0.8)
}
if targetvisible == 0 and (random(50) < 1){
	direction = random(360)
	walk = 25+random(10)
	}

//walk at player
if activated = 0 && target >= 0 && collision_line(x,y,target.x,target.y,Wall,0,0) < 0{
	activated = 1 }
if activated = 1 and target >= 0 and charging = 0{
if random(50)<1
	motion_add(direction+choose(-90,90),3)
motion_add(point_direction(x,y,target.x,target.y),1)
	}

//firecounter
if alrm1 > 0 
	alrm1 -=1
//chargecounter
if charging > 0 
	charging -=1
//speedpausecounter
if speedpause > 0 
	speedpause -=1
	
//Charge Attack
if alrm1 <= 0 and targetvisible == 1 and distance_to_object(target) < 200{
	speedpause += 20
	direction = point_direction(x,y,target.x,target.y)
	alrm1 += 170 + random(40)
	wait(21)
	if !instance_exists(self) or targetvisible == 0{ exit;}
	sound_play_pitchvol(sndRavenScreech,random_range(0.6,0.8),1)
	charging += 20
	trace("charge")	
	
}
//charging happenin
if charging > 0{
motion_add(direction,1)
instance_create(x,y,Dust)

	if(place_meeting(x + hspeed_raw, y + vspeed_raw, Wall)){
		trace("WALLED!");
		charging = 1
		instance_create(x,y,ImpactWrists)
		sound_play_pitchvol(sndMeleeWall,random_range(0.6,0.8),1)
	}
}









//slap this in so the sprite flips correctly
right = (direction + 270) mod 360 > 180 ? 1 : -1;

#define RavenAmalgam_hurt(_damage, _force, _direction)
	my_health -= _damage;           // Damage
	nexthurt = current_frame + 6;   // I-Frames
	motion_add(_direction, _force); // Knockback
	sound_play_pitchvol(sndRavenHit,random_range(0.5,0.7),0.9)  // Sound
	
	 // Hurt Sprite:
	sprite_index = spr_hurt;
	image_index  = 0;

#define RavenAmalgam_death
	sound_play_pitchvol(sndRavenDie,random_range(0.5,0.7),0.9)  // Sound
	StandardDrops()



//Enemy Projectiles
#define EngineerProjectile_step
	speed = 10
	if place_meeting(x + hspeed, y + vspeed, Wall){
		x = xprevious;
		y = yprevious;
		instance_destroy();
	}
#define EngineerProjectile_wall

#define EngineerProjectile_destroy
	if place_meeting(x,y,Wall){
		x = xprevious;
		y = yprevious;
	}
SwarmBot_create(x,y)
