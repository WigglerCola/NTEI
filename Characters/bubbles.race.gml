 // On Mod Load:
#define init
	global.newLevel = instance_exists(GenCont);

	// Sprites //
	
    //A-Skin:
	global.sprIdle[0]     = sprite_add("../sprites/Characters/Bubbles/sprBubblesIdle.png", 8, 16, 15);
	global.sprWalk[0]     = sprite_add("../sprites/Characters/Bubbles/sprBubblesWalk.png", 6, 16 , 15);
	global.sprHurt[0]     = sprite_add("../sprites/Characters/Bubbles/sprBubblesHurt.png", 3, 16, 15);
	global.sprDead[0]     = sprite_add("../sprites/Characters/Bubbles/sprBubblesDead.png", 13, 16 , 15);
	global.sprGoSit[0]    = sprite_add("../sprites/Characters/Bubbles/sprBubblesGoSit.png",3, 12, 12);
	global.sprSit[0]      = sprite_add("../sprites/Characters/Bubbles/sprBubblesSit.png",	1, 12, 12);
    global.sprFire[0]     = sprite_add("../sprites/Characters/Bubbles/sprBubblesFire.png", 1, 16, 15);
	//B-Skin:
	global.sprIdle[1]     = sprite_add("../sprites/Characters/Bubbles/sprBubblesIdleB.png", 4, 16, 15);
	global.sprWalk[1]     = sprite_add("../sprites/Characters/Bubbles/sprBubblesWalkB.png", 6, 16 , 15);
	global.sprHurt[1]     = sprite_add("../sprites/Characters/Bubbles/sprBubblesHurtB.png", 3, 16, 15);
	global.sprDead[1]     = sprite_add("../sprites/Characters/Bubbles/sprBubblesDeadB.png", 9, 16 , 15);
	global.sprGoSit[1]    = sprite_add("../sprites/Characters/Bubbles/sprBubblesGoSitB.png",3, 12, 12);
	global.sprSit[1]      = sprite_add("../sprites/Characters/Bubbles/sprBubblesSitB.png",	1, 12, 12);
    global.sprFire[1]     = sprite_add("../sprites/Characters/Bubbles/sprBubblesFireB.png", 1, 16, 15);
    //C-Skin:
	global.sprIdle[2]     = sprite_add("../sprites/Characters/Bubbles/sprBubblesIdleC.png", 8, 16, 15);
	global.sprWalk[2]     = sprite_add("../sprites/Characters/Bubbles/sprBubblesWalkC.png", 6, 16 , 15);
	global.sprHurt[2]     = sprite_add("../sprites/Characters/Bubbles/sprBubblesHurtC.png", 3, 16, 15);
	global.sprDead[2]     = sprite_add("../sprites/Characters/Bubbles/sprBubblesDeadC.png", 13, 16 , 15);
	global.sprGoSit[2]    = sprite_add("../sprites/Characters/Bubbles/sprBubblesGoSitC.png",3, 12, 12);
	global.sprSit[2]      = sprite_add("../sprites/Characters/Bubbles/sprBubblesSitC.png",	1, 12, 12);
    global.sprFire[2]     = sprite_add("../sprites/Characters/Bubbles/sprBubblesFireC.png", 1, 16, 15);
	//Selection / Map:
	global.spr_slct = sprite_add("../sprites/Characters/Bubbles/sprBubblesSelect.png",	1, 0, 0);
	global.spr_port = sprite_add("../sprites/Characters/Bubbles/sprBubblesPortrait.png",	race_skins(),	40, 243);
	global.spr_skin = sprite_add("../sprites/Characters/Bubbles/sprBubblesLoadout.png",	race_skins(),	16, 16);
	global.spr_icon = sprite_add("../sprites/Characters/Bubbles/sprBubblesMapIcon.png",	race_skins(),	10, 10);
	 // Ultras:
	global.spr_ultport[1] = sprite_add("../sprites/Characters/Bubbles/sprEGSkillIconA.png", 1, 12, 16);
	global.spr_ultport[2] = sprite_add("../sprites/Characters/Bubbles/sprEGSkillIconB.png", 1, 12, 16);
	global.spr_ultport[3] = sprite_add("../sprites/Characters/Bubbles/sprEGSkillIconC.png", 1, 12, 16);	
	global.spr_ultport[4] = sprite_add("../sprites/Characters/Bubbles/sprEGSkillIconD.png", 1, 12, 16);
	global.spr_ulticon[1] = sprite_add("../sprites/Characters/Bubbles/sprEGIconHUDA.png", 1, 8, 9);
	global.spr_ulticon[2] = sprite_add("../sprites/Characters/Bubbles/sprEGIconHUDB.png", 1, 8, 9);
	global.spr_ulticon[3] = sprite_add("../sprites/Characters/Bubbles/sprEGIconHUDC.png", 1, 8, 9);
	global.spr_ulticon[4] = sprite_add("../sprites/Characters/Bubbles/sprEGIconHUDD.png", 1, 8, 9);
	// Projectiles and Such:
	global.sprBubbleProjectile[0]		  = sprite_add("../sprites/Characters/Bubbles/sprBubblesProjectile.png",	4, 8, 8);
	global.sprBubbleProjectile[1]		  = sprite_add("../sprites/Characters/Bubbles/sprBubblesProjectileB.png",	4, 8, 8);
	global.sprBubbleProjectile[2]		  = sprite_add("../sprites/Characters/Bubbles/sprBubblesProjectileC.png",	4, 8, 8);
	global.mskBubbleProjectile			  = sprite_add("../sprites/Characters/Bubbles/mskBubblesProjectile.png",	1, 8, 8);
	global.sprBubbleTrail[0]    		  = sprite_add("../sprites/Characters/Bubbles/sprBubbleTrail.png",3,4,4)
	global.sprBubbleTrail[1]    		  = sprite_add("../sprites/Characters/Bubbles/sprBubbleTrailB.png",3,4,4)
	global.sprBubbleTrail[2]    		  = sprite_add("../sprites/Characters/Bubbles/sprBubbleTrailC.png",3,4,4)
    global.sprSmallBubbleExplosion[0]	  = sprite_add("../sprites/Characters/Bubbles/sprSmallBubbleExplosion.png",7,12,12)
    global.sprSmallBubbleExplosion[1]	  = sprite_add("../sprites/Characters/Bubbles/sprSmallBubbleExplosionB.png",7,12,12)
    global.sprSmallBubbleExplosion[2]	  = sprite_add("../sprites/Characters/Bubbles/sprSmallBubbleExplosionC.png",7,12,12)
	global.sprBubbleSprayParticle[0]      = sprite_add("../sprites/Characters/Bubbles/sprBubbleSprayParticle.png",5,8,8)
	global.sprBubbleSprayParticle[1]      = sprite_add("../sprites/Characters/Bubbles/sprBubbleSprayParticleB.png",5,8,8)
	global.sprBubbleSprayParticle[2]      = sprite_add("../sprites/Characters/Bubbles/sprBubbleSprayParticleC.png",5,8,8)





	 // Reapply sprites if the mod is reloaded. //
	with(instances_matching(Player, "race", mod_current)) { 
		assign_sprites();
		assign_sounds();
	}

	var _race = [];
	for(var i = 0; i < maxp; i++) _race[i] = player_get_race(i);
	while(true){
		/// Character Selection Sound:
		for(var i = 0; i < maxp; i++){
			var r = player_get_race(i);
			if(_race[i] != r && r = "bubbles"){
				sound_play(sndGatorDie); // Select Sound
			}
			_race[i] = r;
		}

		/// Call level_start At The Start Of Every Level:
		if(instance_exists(GenCont)) global.newLevel = 1;
		else if(global.newLevel){
			global.newLevel = 0;
			level_start();
		}
		wait (1);
	}


 // On Level Start: (Custom Script, Look Above In #define init)
#define level_start

#define game_start //on Run Start
sound_play(sndMutant1Cnfm); // Play Confirm Sound


 // On Character's Creation (Starting a run, getting revived in co-op, etc.):
#define create
	
	 // Variables:
	 if(!mod_exists("mod", "pvp")){
	maxbubblecharge = 100;					 //max bubble charge
	 } else{ maxbubblecharge = 50; }		 //cuts max charge in half when pvp is on
	
	bubblecharge = maxbubblecharge; 	     //starting bubble charge
	bubblechargerate = 1;					 //rate that bubble recharges
	bubblecooldown = 0;						 //cooldown for firing bubbles, keep set to 0
	
	orbitalrotate = 0;						//var for Ultra A, leave at 0
	orbitalrotatespeed = 0;					//var for Ultra A, leave at 0
	orbitalcount = 0						//var for Ultra A, leave at 0
	orbitals = 3							//max orbitals for Ultra A
	orbitaloff = 15
	orbitalsize = 1

    
    hatOffset = [0,2]						//hats mod support (changes offsets)

	assign_sprites();
	assign_sounds();

#define assign_sprites
	if(object_index = Player) {
	 // Set Sprites:
	spr_idle = global.sprIdle[bskin];
	spr_walk = global.sprWalk[bskin];
	spr_hurt = global.sprHurt[bskin];
	spr_dead = global.sprDead[bskin];
	spr_sit1 = global.sprGoSit[bskin];
	spr_sit2 = global.sprSit[bskin];
	spr_fire = global.sprFire[bskin]
	
	// Set Other Sprites
	spr_bubbleprojectile  = global.sprBubbleProjectile[bskin]
	spr_bubbletrail 	  = global.sprBubbleTrail[bskin]
	spr_smallbubbleexplo  = global.sprSmallBubbleExplosion[bskin]
	spr_sprayparticle	  = global.sprBubbleSprayParticle[bskin]
}

#define assign_sounds
	 // Set Sounds:
	snd_wrld = sndMutant1Wrld;	// FLÄSHYN
	snd_hurt = sndMutant1Hurt;	// THE WIND HURTS
	snd_dead = sndMutant1Dead;	// THE STRUGGLE CONTINUES
	snd_lowa = sndMutant1LowA;	// ALWAYS KEEP ONE EYE ON YOUR AMMO
	snd_lowh = sndMutant1LowH;	// THIS ISN'T GOING TO END WELL
	snd_chst = sndMutant1Chst;	// TRY NOT OPENING WEAPON CHESTS
	snd_valt = sndMutant1Valt;	// AWWW YES
	snd_crwn = sndMutant1Crwn;	// CROWNS ARE LOYAL
	snd_spch = sndMutant1Spch;	// YOU REACHED THE NUCLEAR THRONE
	snd_idpd = sndMutant1IDPD;	// BEYOND THE PORTAL
	snd_cptn = sndMutant1Cptn;	// THE STRUGGLE IS OVER
	


	

 // Every Frame While Character Exists:
#define step

	// PASSIVE // (Contact Damage Reduction)

	//right now it sorta just applies a debuff to the enemies that lowers their contact damage, but I don't know how to undo it, so itll be a little janky in co-op but shouldn't be a big issue
    with(instance_nearest(x,y,enemy)) {
    	if distance_to_object(other) < 10{
        if("contactdmg" not in self or contactdmg != meleedamage) {
       //     image_blend = make_colour_hsv(255, 255, random(255)); //this is here for debugging, keep commented out
            var reduction;
            reduction = 2 + (ultra_get(mod_current, 1)); //2 + 1 for ultra A
            
            if(meleedamage - reduction > 0) { // makin sure you dont get 0 damage
                meleedamage -= reduction;
            } else if(meleedamage != 0){
                meleedamage = 1;
            }
            
            contactdmg = meleedamage;
           
    }}}



	// ACTIVE - BUBBLE SPRAY //

	// Bubble Recharge:
if bubblecharge < maxbubblecharge { bubblecharge += bubblechargerate } //bubble recharge
if instance_exists(Portal) and !instance_exists(enemy){ bubblechargerate = 10}//increases charge rate when portal exists and no enemies
else {
	if (skill_get(mut_throne_butt) == 1) { bubblechargerate = 1.5} //chargerate with Thronebutt
else {
 bubblechargerate = 1 //normal charge rate
	 }}
	
	//stops bubblecharge from going over the max
if bubblecharge > maxbubblecharge
   bubblecharge -= 1

	//Ultra B Max Bubble Boost:
if ultra_get(mod_current, 2) { maxbubblecharge = 150}
	


	// Active / Use Bubble Bar:
if(canspec) and bubblecharge > 0 and bubblecooldown = 0{
if button_check(index,"spec"){
bubblecharge -=5; //drainrate

//Sounds
sound_play_pitchvol(sndOasisCrabAttack,random_range(0.8,1.2),3);
sound_play_pitchvol(sndOasisMelee,random_range(0.8,1.2),2);
sound_play_pitchvol(sndOasisHurt,random_range(0.8,1.2),1);

sprite_index = spr_fire
			
			//Bubble Boost
			
			//Ultra C Boost (reduced)
			if ultra_get(mod_current, 3){
			speed = maxspeed + 2; 
			motion_add(gunangle,-2);
			}
			
			//Default Values
			else{
			speed = maxspeed + 2; 
			motion_add(gunangle,-3);
			}
			 
			//Bubble Spray
			
			 //Ultra B: 
			if ultra_get(mod_current, 2){ repeat(2){ bubblespray() }} 
		
			//Ultra C:
			if ultra_get(mod_current, 3) { bubblespray_ultrac() }

			
			//Default:
			else{
				bubblespray()
				}
	
}}

	// Active Cooldown:
//when charge hits 0, adds a cooldown
if bubblecharge = 0
   bubblecooldown +=30
//Cooldown Counter
if bubblecooldown > 0 
   bubblecooldown -=1

  
//ULTRA A :
//stole this orbital code from Ash (thank u Class)
if ultra_get(mod_current, 1){
if right > 0{
if orbitalrotatespeed < 6 orbitalrotatespeed += 1
}
orbitalrotate += current_time_scale * orbitalrotatespeed;
if orbitals != 0 && orbitaloff < 5{
for(var ii = 0; ii <= 360; ii += 360 / orbitals){
with instance_create(x+hspeed+lengthdir_x(16,orbitalrotate+ii),y+vspeed+lengthdir_y(16,orbitalrotate+ii),CustomSlash){
spr_bubbletrail = other.spr_bubbletrail	
sprite_index = other.spr_bubbleprojectile
damage = 0;
force = 0;
team = other.team;
creator = other
image_speed = 0.4;
image_xscale = other.orbitalsize
image_yscale = image_xscale
direction = other.orbitalrotate+ii
depth = other.depth;

comp_fist = 1; //disables compressing fist affect

on_anim = nothing
on_hit  = nothing
on_wall = nothing
on_projectile = orbital_nullify
on_step = orbitalanim;


		}
	}
}
orbitaloff -= 1;
if orbitalsize < 1 {orbitalsize += 0.04}
if orbitalsize < 0 { orbitalsize = 0 } //keeps size from going below zero
if orbitalsize > 1 { orbitalsize = 1 } //keeps size from going above one
}

#define bubblespray
				//Particle:
				with(instance_create(x + lengthdir_x(0,gunangle),y + lengthdir_y(0,gunangle),FishBoost)){
					depth = -3
					image_speed = 1.6
					image_xscale = random_range(0.8,1.3)
					image_yscale = image_xscale
					sprite_index = other.spr_sprayparticle
					
					comp_fist = 1; //disables compressing fist affect
					
				}
				//Bubble Particle:
				if (random(3) < 1) {
				with(instance_create(x + lengthdir_x(0,gunangle),y + lengthdir_y(0,gunangle),Bubble)){
					image_yscale = image_xscale
					
					comp_fist = 1; //disables compressing fist affect
					
				}}
				
				
				//Projectile:
				with(instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),CustomSlash)){
					
					direction = point_direction(x,y,mouse_x[other.index],mouse_y[other.index])+(random_range(20, -20))
					
					sprite_index = other.spr_bubbleprojectile
					mask_index   = global.mskBubbleProjectile
					
					spr_bubbletrail = other.spr_bubbletrail
					spr_smallbubbleexplo = other.spr_smallbubbleexplo
					
					image_speed  = 0.4
					image_xscale = random_range(0.8,1.3)
					image_yscale = image_xscale
					image_angle  = random(360)
					depth = -3
					
					comp_fist = 1; //disables compressing fist affect
					
					team = other.team;
					speed = 5.5 + random_range(0.8,2.3);
					friction = 0.2;
					
					if ultra_get(mod_current, 2){
					damage = 1 + round(GameCont.loops/3);}//decreases loop scaling with DB
					else{
					damage = 1 + round(GameCont.loops/2);
					}
					
					on_projectile = bubbleprojectile_nullify
					on_anim    = nothing
					on_step    = bubbleprojectile_step
					on_wall    = bubbleprojectile_wall
				    on_hit     = bubbleprojectile_hit
				    on_destroy = bubbleprojectile_destroy
				    on_draw    = bubbleprojectile_draw
				    
				}

// Character Vars:
#define race_name						return "BUBBLES";										    // Character Name: 
#define race_text						return "@wTAKES LESS CONTACT DAMAGE#@(color:16234606)BUBBLE @wSPRAY"; // Character Description:
#define race_menu_button				sprite_index = global.spr_slct; 							// Character Selection Icon:
#define race_portrait					return global.spr_port; 									// Portrait:
#define race_mapicon					return global.spr_icon; 									// Loading Screen Map Icon:
#define race_skins						return 3;													// Skin Count:
#define race_skin_button				sprite_index = global.spr_skin; image_index = argument0;	// Skin Icons:
#define race_ultra_button				sprite_index = global.spr_ultport[argument0];				// Ultra Button Portraits:
#define race_ultra_icon 				return global.spr_ulticon[argument0];						// Ultra HUD Icons:
#define race_ttip						return ["@(color:16745694)FISH N' CHIPS", "@(color:16745694)HEAD EMPTY", "@(color:16745694)BUBBLE DAMAGE#@(color:16745694)SCALES WITH LOOPS", "@(color:16745694)STAY HYDRATED", "@(color:16745694)FIND SHINIES", "@(color:16745694)FISHY BUISNESS", "@(color:16745694)BUBBLES DESTROY PROJECTILES"]; // Loading Screen Tips:

#define race_swep //Starting Weapons:
    switch(player_get_skin(("index" in other) ? other.index : 0)){
        case 1  : return "BubblesShovel";    //B Skin
        case 2  : return "BubblesWelder";    //C Skin
        default : return "BubblesCutlass"; } //A Skin
        
#define race_tb_text return "FASTER @(color:16234606)BUBBLE @sRECHARGE"; // Throne Butt Description:
#define race_tb_take			   // On Taking Throne Butt:
#define race_cc_text return "TAKING CONTACT DAMAGE LEAVES DAMAGING FINS - NYI"  // Crown Cranium Description:

 // Ultra Names:
#define race_ultra_name
	switch(argument0){
		case 1: return "BUBBLE BARRICADE";
		case 2: return "DOUBLE BUBBLE";
		case 3: if(mod_exists("mod", "metamorphosis")) return "BUBBLE BARRAGE";
		case 4: if(mod_exists("mod", "LOMutsSprites")) return "ULTRA D - NYI";
	}

 // Ultra Descriptions:
#define race_ultra_text
	switch(argument0){
		case 1: return "@sGAIN @wDEFENSIVE @(color:16234606)BUBBLE @wORBITALS#@sTAKE @wEVEN LESS @sCONTACT DAMAGE";
		case 2: return "DOUBLED @(color:16234606)BUBBLES @sPER SHOT#HIGHER @(color:16234606)BUBBLE @sCAPACITY";
		case 3: if(mod_exists("mod", "metamorphosis")) return "@(color:16234606)BUBBLES @sDEAL @wMORE @sDAMAGE#@(color:16234606)BUBBLES @sARE @wSMALLER @sAND @wHOMING#@sLESS PROPULSION";
		case 4: if(mod_exists("mod", "LOMutsSprites")) return "NYI";
	}

 // On Taking An Ultra:
#define race_ultra_take
	if(instance_exists(mutbutton)) switch(argument0){
		 // Play Ultra Sounds:
		case 1:	sound_play(sndFishUltraA); break;
		case 2: sound_play(sndFishUltraB); break;
		case 3:	sound_play(sndFishUltraA); break;
		case 4:	sound_play(sndFishUltraA); break;
	}







 // Projectile Stuff and Such//
 // Bubble Projectile:
#define bubbleprojectile_step 

//speen
image_angle += 5
//trail
if (random(25) < 1){
with instance_create(x+random_range(-1,1),y+random_range(-1,1),PlasmaTrail){
  	sprite_index = other.spr_bubbletrail
  	image_angle = random(360)
  	
  	comp_fist = 1; //disables compressing fist affect
 }}




//destroy projectiles
//with instances_matching_ne(projectile, "team", other.team){
//if distance_to_object(other) <= 0 and object_index != PopoNade && object_index != CustomSlash && object_index != EnemySlash && object_index != Laser && object_index != EnemyLaser && !("bubbleImmune" in self && bubbleImmune == 1){
//instance_destroy()}}

//speedcheck / destroy
if speed < 2 { instance_destroy()}

#define bubbleprojectile_nullify
//trace("AAA")
if(instance_exists(self)){
		if (other.typ > 0) {
			 with (other){
			  	instance_destroy()
			  } } }

#define bubbleprojectile_wall    
move_bounce_solid(true); speed -= 1
    var d = direction + 180, h = hspeed, v = vspeed;
        with instance_create(x + h, y + v, MeleeHitWall) {
            image_angle = d - angle_difference(other.direction, d)
            image_yscale = random_range(0.5,0.8)
            image_speed *= 2
            image_index = irandom(1)
        }
#define bubbleprojectile_hit     projectile_hit(other,damage); instance_destroy()
#define bubbleprojectile_destroy
//Sounds:
	var _pitch = random_range(0.8, 1.2);
	sound_play_pitch(sndOasisCrabAttack,     1.3 * _pitch);
	sound_play_pitch(sndOasisExplosionSmall, 1 * _pitch);

//Particles
repeat(irandom(3)){
with instance_create(x+random_range(-1,1),y+random_range(-1,1),Bubble){
image_yscale = image_xscale
					
comp_fist = 1; //disables compressing fist affect
}}
//Explosion:
with instance_create(x,y,CustomSlash){
	sprite_index = other.spr_smallbubbleexplo
	mask_index = mskSmallExplosion
	image_speed = 0.4
	
	comp_fist = 1; //disables compressing fist affect
	
	//damage = 1 + round(GameCont.loops/2);
	speed = 0;
	team = other.team
	
	on_projectile = bubbleprojectile_nullify
	//on_step = bubbleexplo_step
	on_wall = bubbleexplo_wall
	on_hit  = bubbleexplo_hit
	on_draw = bubbleprojectile_draw
}

#define bubbleprojectile_draw
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 0.8);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 1.2*image_xscale, 1.2*image_yscale, image_angle, image_blend, 0.1);
draw_set_blend_mode(bm_normal);
#define bubbleexplo_wall
#define bubbleexplo_hit
//projectile_hit(other,damage);

//#define bubbleexplo_step

//destroy projectiles
//with instances_matching_ne(projectile, "team", other.team){
//if distance_to_object(other) <= 0 and object_index != PopoNade && object_index != CustomSlash && object_index != EnemySlash && object_index != Laser && object_index != EnemyLaser && !("bubbleImmune" in self && bubbleImmune == 1){
//instance_destroy()}}

//if bubbleexplotime > 0 
//   bubbleexplotime -=1
//if bubbleexplotime <= 0 { instance_destroy() }

#define bubblespray_ultrac
				//Particle:
				with(instance_create(x + lengthdir_x(0,gunangle),y + lengthdir_y(0,gunangle),FishBoost)){
					depth = -3
					image_speed = 1.6
					image_xscale = random_range(0.8,1.3)
					image_yscale = image_xscale
					sprite_index = other.spr_sprayparticle
					
					comp_fist = 1; //disables compressing fist affect
					
				}
				//Bubble Particle:
				if (random(3) < 1) {
				with(instance_create(x + lengthdir_x(0,gunangle),y + lengthdir_y(0,gunangle),Bubble)){
					image_yscale = image_xscale
					
					comp_fist = 1; //disables compressing fist affect
					
				}}
				//Projectile:
				with(instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),CustomSlash)){
					
					direction = point_direction(x,y,mouse_x[other.index],mouse_y[other.index])+(random_range(20, -20))
					
					sprite_index = other.spr_bubbleprojectile
					//mask_index   = global.mskBubbleProjectile
					
					spr_bubbletrail = other.spr_bubbletrail
					spr_smallbubbleexplo = other.spr_smallbubbleexplo
					
					image_speed  = 0.4
					image_xscale = random_range(0.65,0.9)
					image_yscale = image_xscale
					image_angle  = random(360)
					depth = -3
					target = noone;
					angle = 16;
					team = other.team;
					speed = 7.5 + random_range(0.8,2.3);
					friction = 0.2;
					
					comp_fist = 1; //disables compressing fist affect

					damage = 7 + GameCont.loops;
					
					on_projectile = bubbleprojectile_nullify
					on_anim       = nothing
					on_step       = bubbleprojectile_ultrac_step
					on_wall       = bubbleprojectile_wall
				    on_hit        = bubbleprojectile_hit
				    on_destroy    = bubbleprojectile_destroy
				    on_draw       = bubbleprojectile_draw
				    
				}

#define bubbleprojectile_ultrac_step

if target = noone && instance_exists(enemy){
	var nearest = enemy;
	if distance_to_object(nearest) < 100{
	with enemy if point_distance(other.x, other.y, x, y) < point_distance(other.x, other.y, nearest.x, nearest.y)
	&& !collision_line(other.x, other.y, x, y, Wall, 0, 0) nearest = self;
	if !collision_line(x, y, nearest.x, nearest.y, Wall, 0, 0) target = nearest;
}}
angle += 0.1 * current_time_scale;
if instance_exists(target) direction += clamp(angle_difference(point_direction(x, y, target.x, target.y), direction), -angle, angle) * (0.4);

//speen
image_angle += 5
//trail
if (random(25) < 1){
with instance_create(x+random_range(-1,1),y+random_range(-1,1),PlasmaTrail){
  	sprite_index = other.spr_bubbletrail
  	image_angle = random(360)
 }}

//speedcheck / destroy
if speed < 2 { instance_destroy()}

#define nothing
//wow look! nothing!

#define orbitalanim

//trail
with instance_create(x+random_range(-4,4),y+random_range(-4,4),PlasmaTrail){
  	sprite_index = other.spr_bubbletrail
  	image_angle = random(360)
  	image_speed = 0.3
  	image_xscale = 0.5
  	image_yscale = image_xscale
  	
  	comp_fist = 1; //disables compressing fist affect
 }
 
if image_alpha == 0{
instance_destroy()
}
if instance_exists(self){
image_alpha = 0
}

#define orbital_nullify
//trace("AAA")
with creator{if orbitalsize > 0{orbitalsize -= 0.2}} //orbitals shrink as they take hits
if creator.orbitalsize > 0.2{
if(instance_exists(self)){
		if (other.typ > 0) {
			 with (other){
			 	//trace("BLOCK!")
			  	instance_destroy()
			  } } } }
