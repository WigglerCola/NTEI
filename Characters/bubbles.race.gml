 // On Mod Load:
#define init
	
	//LIB 
	if fork(){
		while(!mod_exists("mod", "lib")){wait(1);}
		script_ref_call(["mod", "lib", "getRef"], "race", mod_current, "scr");
		exit;
	}
	#macro scr global.scr
	#macro call script_ref_call

	// Sprites //
	global.mskBubbleProjectile			  = sprite_add("../sprites/Characters/Bubbles/mskBubblesProjectile.png",	1, 8, 8);
	
    //A-Skin:
	global.sprIdle[0]     = sprite_add("../sprites/Characters/Bubbles/sprBubblesIdle.png", 8, 16, 15);
	global.sprWalk[0]     = sprite_add("../sprites/Characters/Bubbles/sprBubblesWalk.png", 6, 16 , 15);
	global.sprHurt[0]     = sprite_add("../sprites/Characters/Bubbles/sprBubblesHurt.png", 3, 16, 15);
	global.sprDead[0]     = sprite_add("../sprites/Characters/Bubbles/sprBubblesDead.png", 13, 16 , 15);
	global.sprGoSit[0]    = sprite_add("../sprites/Characters/Bubbles/sprBubblesGoSit.png",3, 12, 12);
	global.sprSit[0]      = sprite_add("../sprites/Characters/Bubbles/sprBubblesSit.png",	1, 12, 12);
    global.sprFire[0]     = sprite_add("../sprites/Characters/Bubbles/sprBubblesFire.png", 1, 16, 15);
	global.sprBubbleProjectile[0]		  = sprite_add("../sprites/Characters/Bubbles/sprBubblesProjectile.png", 4, 8, 8);
	global.sprBubbleTrail[0]    		  = sprite_add("../sprites/Characters/Bubbles/sprBubblesTrail.png",3,4,4);
    global.sprSmallBubbleExplosion[0]	  = sprite_add("../sprites/Characters/Bubbles/sprBubblesExplosion.png",7,12,12);
	global.sprBubbleSprayParticle[0]      = sprite_add("../sprites/Characters/Bubbles/sprBubblesSprayParticle.png",5,8,8);
	global.sprBubbleCCBurst[0]			  = sprite_add("../sprites/Characters/Bubbles/sprBubblesCCBurst.png",5,24,24);
	
	//B-Skin:
	global.sprIdle[1]     = sprite_add("../sprites/Characters/Bubbles/sprBubblesBIdle.png", 4, 16, 15);
	global.sprWalk[1]     = sprite_add("../sprites/Characters/Bubbles/sprBubblesBWalk.png", 6, 16 , 15);
	global.sprHurt[1]     = sprite_add("../sprites/Characters/Bubbles/sprBubblesBHurt.png", 3, 16, 15);
	global.sprDead[1]     = sprite_add("../sprites/Characters/Bubbles/sprBubblesBDead.png", 9, 16 , 15);
	global.sprGoSit[1]    = sprite_add("../sprites/Characters/Bubbles/sprBubblesBGoSit.png",3, 12, 12);
	global.sprSit[1]      = sprite_add("../sprites/Characters/Bubbles/sprBubblesBSit.png",	1, 12, 12);
    global.sprFire[1]     = sprite_add("../sprites/Characters/Bubbles/sprBubblesBFire.png", 1, 16, 15);
	global.sprBubbleProjectile[1]		  = sprite_add("../sprites/Characters/Bubbles/sprBubblesBProjectile.png",	4, 8, 8);
	global.sprBubbleTrail[1]    		  = sprite_add("../sprites/Characters/Bubbles/sprBubblesBTrail.png",3,4,4);
    global.sprSmallBubbleExplosion[1]	  = sprite_add("../sprites/Characters/Bubbles/sprBubblesBExplosion.png",7,12,12);
	global.sprBubbleSprayParticle[1]      = sprite_add("../sprites/Characters/Bubbles/sprBubblesBSprayParticle.png",5,8,8);
	global.sprBubbleCCBurst[1]			  = sprite_add("../sprites/Characters/Bubbles/sprBubblesBCCBurst.png",5,24,24);

    //C-Skin:
	global.sprIdle[2]     = sprite_add("../sprites/Characters/Bubbles/sprBubblesCIdle.png", 8, 16, 15);
	global.sprWalk[2]     = sprite_add("../sprites/Characters/Bubbles/sprBubblesCWalk.png", 6, 16 , 15);
	global.sprHurt[2]     = sprite_add("../sprites/Characters/Bubbles/sprBubblesCHurt.png", 3, 16, 15);
	global.sprDead[2]     = sprite_add("../sprites/Characters/Bubbles/sprBubblesCDead.png", 13, 16 , 15);
	global.sprGoSit[2]    = sprite_add("../sprites/Characters/Bubbles/sprBubblesCGoSit.png",3, 12, 12);
	global.sprSit[2]      = sprite_add("../sprites/Characters/Bubbles/sprBubblesCSit.png",	1, 12, 12);
    global.sprFire[2]     = sprite_add("../sprites/Characters/Bubbles/sprBubblesCFire.png", 1, 16, 15);
	global.sprBubbleProjectile[2]		  = sprite_add("../sprites/Characters/Bubbles/sprBubblesCProjectile.png",	4, 8, 8);
	global.sprBubbleTrail[2]    		  = sprite_add("../sprites/Characters/Bubbles/sprBubblesCTrail.png",3,4,4);
    global.sprSmallBubbleExplosion[2]	  = sprite_add("../sprites/Characters/Bubbles/sprBubblesCExplosion.png",7,12,12);
	global.sprBubbleSprayParticle[2]      = sprite_add("../sprites/Characters/Bubbles/sprBubblesCSprayParticle.png",5,8,8);
	global.sprBubbleCCBurst[2]			  = sprite_add("../sprites/Characters/Bubbles/sprBubblesCCCBurst.png",5,24,24);
	
	//Selection / Map:
	global.spr_slct = sprite_add("../sprites/Characters/Bubbles/sprBubblesSelect.png",	2, 0, 0);
	global.spr_port = sprite_add("../sprites/Characters/Bubbles/sprBubblesPortrait.png",	race_skins(),	40, 243);
	global.spr_skin[0] = sprite_add("../sprites/Characters/Bubbles/sprBubblesLoadout.png",	2,	16, 16);
	global.spr_skin[1] = sprite_add("../sprites/Characters/Bubbles/sprBubblesBLoadout.png",	2,	16, 16);
	global.spr_skin[2] = sprite_add("../sprites/Characters/Bubbles/sprBubblesCLoadout.png",	2,	16, 16);
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
	
	// Campfire:
	global.sprCampfireSlct   = sprite_add("../sprites/Characters/Bubbles/sprBubblesIdle.png", 8, 16 , 15); //Selected
	global.sprCampfireMenu   = sprite_add("../sprites/Characters/Bubbles/sprBubblesMenu.png", 16, 16, 15); //Waiting
	global.sprCampfireTo     = sprite_add("../sprites/Characters/Bubbles/sprBubblesHurt.png", 3, 16, 15);  //Selecting
	global.sprCampfireFrom   = sprite_add("../sprites/Characters/Bubbles/sprBubblesHurt.png", 3, 16, 15);  //Deselecting
	
	/// SOUNDS ///
	global.sndBoom = sound_add("../sounds/sndBoom.ogg"); // boosh

	#macro current_frame_active frac(current_frame) < current_time_scale

	global.newLevel = instance_exists(GenCont);

	// Ultra Names and Descriptions:
    global.ultraData = [
        ["BUBBLE BARRICADE", "@sGAIN @wDEFENSIVE @(color:16234606)BUBBLE @wORBITALS#@sTAKE @wEVEN LESS @sCONTACT DAMAGE"], 
        ["DOUBLE BUBBLE", "DOUBLED @(color:16234606)BUBBLES @sPER SHOT#HIGHER @(color:16234606)BUBBLE @sCAPACITY"], 
        ["BUBBLE BARRAGE", "@(color:16234606)BUBBLES @sDEAL @wMORE @sDAMAGE#@(color:16234606)BUBBLES @sARE @wSMALLER @sAND @wHOMING#@wLESS @sPROPULSION FROM FIRING", "mod", "metamorphosis"], 
        ["ULTRA D", "UNFINISHED", "mod", "LOMuts"]
    ];
    global.ultraMap = [];
    global.ultraNum = 0;
    
	 // Reapply sprites if the mod is reloaded. //
	with(instances_matching(Player, "race", mod_current)) { 
		assign_sprites();
		assign_sounds();
	}


 // On Level Start: (Custom Script, Look Above In #define init)
#define level_start

#define game_start //on Run Start
sound_play(sndMutant1Cnfm); // Play Confirm Sound

	// CAMPFIRE:
#define race_ei_campf					return true;
#define race_ei_campf_sprnotselected	return global.sprCampfireMenu;
#define race_ei_campf_sprselected		return global.sprCampfireSlct;
#define race_ei_campf_sprselecting 		return global.sprCampfireTo;
#define race_ei_campf_sprdeselecting	return global.sprCampfireFrom;
#define race_ei_campf_shadowx			return 0;
#define race_ei_campf_shadowy		    return 0;
#define race_ei_campf_particles

//Campfire Spawn Effects:
	//Dust/Water
		repeat(15) with instance_create(x,y,Dust){
			speed        = random_range(2,3)
			direction    = random(360)
			sprite_index = sprFishBoost 
			depth        = -16 }
	//Bubble
		repeat(6) with instance_create(x,y,Bubble){
			speed = random_range(1,2) }
	//BubblePop
		repeat(3) with instance_create(x,y,BubblePop){
			speed     = random_range(1,3)
			direction = random(360) }
	//FishBoost
		repeat(5) with instance_create(x,y,FishBoost){
			speed     = random_range(1,2)
			direction = random(360)
			depth     = -16 }

	//Hey Check This Out
 if random(20)<1{ sound_play(global.sndBoom) }			
		
#define race_menu_select //when i click u
	if(instance_is(self, CharSelect) || instance_is(other, CharSelect)){

		sound_play_pitchvol(sndMutant6Slct, 1.5, 0.5);
		
				if(fork()){
			wait 3 * current_time_scale;
			
		sound_play_pitchvol(sndMutant6Slct, 1.7, 0.5);
			wait 3 * current_time_scale;
			
		sound_play_pitchvol(sndMutant6Slct, 1.9, 0.5);
		
			
			exit;
		}
		
		return -1;
	}
	
	return sndRavenLift;

 // On Character's Creation (Starting a run, getting revived in co-op, etc.):
#define create
	
	spr_idle = global.sprIdle[bskin]; //setting this here so the little thing in the cheats mod char select shows up, other sprites in assign_sprites
	
	 // Variables:
	 if(!mod_exists("mod", "pvp")){
	maxbubblecharge = 100;					 //max bubble charge
	 } else{ maxbubblecharge = 100; }		 //max charge in PVP
	
	bubblecharge     = maxbubblecharge; 	 //starting bubble charge
	bubblechargerate = 1;					 //rate that bubble recharges
	bubblecooldown   = 0;					 //cooldown for firing bubbles, keep set to 0
	
	// Other Vars:
	orbitalrotate      = 0;		//var for Ultra A, leave at 0
	orbitalrotatespeed = 0;		//var for Ultra A, leave at 0
	orbitalcount	   = 0;		//var for Ultra A, leave at 0
	orbitals		   = 3;		//max orbitals for Ultra A
	orbitaloff		   = 15;	//orbital offset - default 15
	orbitalsize 	   = 1;		//orbital size, leave at 1
	ultraspeed		   = 0;		//var for Ultra D, leave at 0
	bubbles_cc_burst   = true;  //var for cc, leave at true
	

    hatOffset = [0,2] //Hats Mod Support - Repositions Hats

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
	
	// Set Projectile Sprites:
	spr_bubbleprojectile  = global.sprBubbleProjectile[bskin]
	spr_bubbletrail 	  = global.sprBubbleTrail[bskin]
	spr_smallbubbleexplo  = global.sprSmallBubbleExplosion[bskin]
	spr_sprayparticle	  = global.sprBubbleSprayParticle[bskin]
	spr_ccburst			  = global.sprBubbleCCBurst[bskin]
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


 //#region REAL
 
 // Every Frame While Character Exists:
#define step

	// PASSIVE // (Contact Damage Reduction)

	//right now it sorta just applies a debuff to the enemies that lowers their contact damage, but I don't know how to undo it, so itll be a little janky in co-op but shouldn't be a big issue
    with(instance_nearest(x,y,enemy)) {
    	if distance_to_object(other) < 10{
        	if("contactdmg" not in self or contactdmg != meleedamage) {
       //     image_blend = make_colour_hsv(255, 255, random(255)); //this is here for debugging, keep commented out
            var reduction;
            reduction = 2 + has_ultra("A"); //2 + 1 for ultra A
            
        		// make sure you dont get 0 damage
            if(meleedamage - reduction > 0) {
                meleedamage -= reduction;
            } else if(meleedamage != 0){ meleedamage = 1; }
            	contactdmg = meleedamage;
           
			}
    	}
    }

	// ACTIVE - BUBBLE SPRAY //

	// Bubble Recharge:
if bubblecharge < maxbubblecharge { bubblecharge += bubblechargerate } //bubble recharge
if instance_exists(Portal) and !instance_exists(enemy){ bubblechargerate = 10 * current_time_scale} //increases charge rate when portal exists and no enemies
else {
	if (skill_get(mut_throne_butt) == 1) { bubblechargerate = 1.5 * current_time_scale} //chargerate with Thronebutt
else {
 bubblechargerate = 1 * current_time_scale //normal charge rate
	 }
}
	
	//stops bubblecharge from going over the max
if bubblecharge > maxbubblecharge
   bubblecharge -= current_time_scale

	//Ultra B Max Bubble Boost:
if has_ultra("B") { maxbubblecharge = 150; }
	


	// Active / Use Bubble Bar:
if(canspec) and bubblecharge > 0 and bubblecooldown = 0{
if button_check(index,"spec"){

bubblecharge -=5 * current_time_scale; //drainrate

//Sounds
sound_play_pitchvol(sndOasisCrabAttack,random_range(0.8,1.2),3);
sound_play_pitchvol(sndOasisMelee,random_range(0.8,1.2),2);
sound_play_pitchvol(sndOasisHurt,random_range(0.8,1.2),1);

if sprite_index != spr_hurt { sprite_index = spr_fire }
			
				// Bubble Boost Speed:
			
			//Ultra C Boost (reduced)
			if has_ultra("C"){
			speed = maxspeed + 2; 
			motion_add(gunangle,-2);
			}
			
			//Default Values
			else{
			speed = maxspeed + 2; 
			motion_add(gunangle,-3);
			}
			 
				// Bubble Projectile Spray:
			
			 // Ultra B: 
			if has_ultra("B"){ repeat(1){ bubblespray() }} 

			// Ultra C:
			if has_ultra("C") { bubblespray_ultrac() }
			else{
				
			// Ultra D:
			if has_ultra("D") {
				
			trace("why do you have this?")
				
			//Ultraspeed Increase
			ultraspeed += 2
			
			//obj, ?force, ?direction, ?friction, ?canwallhit, ?dontwait, ?disableeffects, ?hook_merge
			//Superforce
			call(scr.superforce_push, self, 16, self.gunangle + 180, 0.4, 1, 1); 
			
			// Bubble Spray
			bubblespray()
			trace(ultraspeed)
			
			//Particles
			with instance_create(x+random_range(-20,20),y+random_range(-20,20),PlasmaTrail){
  			sprite_index = other.spr_bubbletrail
  			image_angle = random(360)}
			}
			

				//Default Spray:
				else{ bubblespray() }
			}
		}
	}

		// Active Cooldowns:
	//when charge hits 0, adds a cooldown
	if bubblecharge < 0
	  bubblecooldown = 30
	//Cooldown Counter
	if bubblecooldown > 0 
	   bubblecooldown -= current_time_scale
	//Ultraspeed Counter
	if ultraspeed > 0 
	   ultraspeed -= current_time_scale


		// CROWN CRANIUM:
	// creates basically blast armor but instead of eating projectiles it applies superforce
	if skill_get("crowncranium"){
		if (my_health < lsthealth && sprite_index == spr_hurt){
		if bubbles_cc_burst = true { bubbleprojectile_crowncranium() }
		sound_play_pitchvol(sndOasisPortal,random_range(1,1.4),0.6)
		bubbles_cc_burst = false;
	}
	else { bubbles_cc_burst = true; }
	}
	
  
				//ULTRA A :
	// Spawns projectile nullifying orbitals
//stole this orbital code from Ash (thank u Class)
if has_ultra("A"){
if right > 0{ if orbitalrotatespeed < 6 orbitalrotatespeed += 1 }
orbitalrotate += current_time_scale * orbitalrotatespeed;
if orbitals != 0 && orbitaloff < 5{
for(var ii = 0; ii <= 360; ii += 360 / orbitals){
	with instance_create(x+hspeed+lengthdir_x(16,orbitalrotate+ii),y+vspeed+lengthdir_y(16,orbitalrotate+ii),CustomSlash){
		spr_bubbletrail = other.spr_bubbletrail	
		sprite_index    = other.spr_bubbleprojectile
		damage          = 0;
		force			= 0;
		team			= other.team;
		creator 		= other
		image_speed 	= 0;
		image_xscale	= other.orbitalsize
		image_yscale	= image_xscale
		direction		= other.orbitalrotate+ii
		depth			= other.depth;

		ammo_type = -1;

		on_anim = nothing
		on_hit  = nothing
		on_wall = nothing
		on_projectile = orbital_nullify
		on_step = orbital_step;
		on_grenade = nothing;


		}
	}
}
orbitaloff -= current_time_scale;
if orbitalsize < 1 {orbitalsize += 0.04 * current_time_scale}
if orbitalsize < 0 { orbitalsize = 0 } //keeps size from going below zero
if orbitalsize > 1 { orbitalsize = 1 } //keeps size from going above one

}

//#region CHARACTER VARS

 // Locked away forever:
#define race_avail			   return 1;					// Can I have you:
#define race_lock              return "REACH COVE";			// How I get you;
#define race_unlock            return "FOR REACHING COVE";  // I got you!:


//locking skins is actually so fucked up fix it later im going to bed
//look through parrot and vagabonds or whatever this is awful
#define race_skin_avail 									// Can I have your forms:
return 1;
#define race_skin_lock(_skin)
	switch(_skin){
		case 0 : return "YOU MESSED UP YOUR FILE SOMEHOW";
		case 1 : return "JOE";
		case 2 : return "GET";
	}

#define race_skins						return 3;																	// Skin Count:
#define race_skin_button				sprite_index = global.spr_skin[argument0]; image_index = !race_skin_avail();// Skin Icons:


// Character Vars:
#define race_name						return "BUBBLES";													  // Character Name: 
#define race_text						return "@wTAKES LESS CONTACT DAMAGE#@(color:16234606)BUBBLE @wSPRAY"; // Character Description:
#define race_menu_button				sprite_index = global.spr_slct; image_index = !race_avail();		  // Character Selection Icon:
#define race_portrait					return global.spr_port; 											  // Portrait:
#define race_mapicon					return global.spr_icon; 										   	  // Loading Screen Map Icon:
#define race_ultra_button				sprite_index = global.spr_ultport[argument0];						  // Ultra Button Portraits:
#define race_ultra_icon 				return global.spr_ulticon[argument0];								  // Ultra HUD Icons:

#define race_ttip
	 // Ultra:
	if(GameCont.level >= 10 && chance(1, 5)){
		return choose(
			"@(color:16234606)ILL BE YOUR KILLER FISH#@(color:16234606)FOR THE EVENING",
			"@(color:16234606)SHIVER ME TIMBERS",
			"@(color:16234606)ALL HANDS ON DECK",
			"@(color:16234606)LEVIATHAN"
		);
	}
	
	 // Normal:
	return choose(
		"@(color:16234606)BUBBLES @wDESTROY PROJECTILES",                  
		"@(color:16234606)BUBBLE DAMAGE#@(color:16234606)SCALES WITH LOOPS",
		"@(color:16234606)FISH N' CHIPS",
		"@(color:16234606)HEAD EMPTY",
		"@(color:16234606)STAY HYDRATED",
		"@(color:16234606)FISHY BUSINESS",
		"@(color:16234606)FIND SHINIES",
		"@(color:16234606)FOLLOW THE CODE"
	);

//Deathtips:
#define deathtips_add
//deathtips support, cheese wrote em
if(mod_exists("mod","deathtips")){
	add_tip("race", "bubbles", ["gghhlmhmkllkjj..,,,,,lm", "chewy", "dont press in his soft spots", "gerber life grow up plan", "blowing bubbles in the gasoline"]);
}
#define add_tip(tiptype,tipsource,tipoutput)
	return mod_script_call("mod","deathtips","add_tip",tiptype,tipsource,tipoutput)
	
#define race_swep //Starting Weapons - Armed and Dangerous:
    switch(player_get_skin(("index" in other) ? other.index : 0)){
        case 1  : return "BubblesShovel";    //B Skin
        case 2  : return "BubblesWelder";    //C Skin
        default : return "BubblesCutlass"; } //A Skin
        
#define race_tb_text return "FASTER @(color:16234606)BUBBLE @sRECHARGE";		  // Throne Butt Description:
#define race_tb_take															  // On Taking Throne Butt:
// Crown Cranium Description:
#define race_cc_text 
// Put a lil warning in case libWeps isn't loaded
if(mod_exists("mod","libWeps")){
return "@sCREATE A @(color:16234606)WATER BURST #@sWHEN @wDAMAGED"}
else{
return "@rWARNING: #@rLIBWEPS IS NOT LOADED: #@rCC WILL NOT WORK"
}

 // Ultra Names and Descriptions in #define init
 
 // Ultra Names:
#define race_ultra_name
    var returnData = [""];
    global.ultraMap = [];
    var num = 0;
    with(global.ultraData){
        if(array_length(self) == 2 || mod_exists(self[2], self[3])){
            array_push(returnData, self[0]);
            num++;
            array_push(global.ultraMap, num);
        }else{
            array_push(global.ultraMap, 0);
        }
    }
    global.ultraNum = num;
    if(argument0 < array_length(returnData)){
        return returnData[argument0];
    }


 // Ultra Descriptions:
#define race_ultra_text
    var returnData = [""];
    with(global.ultraData){
        if(array_length(self) == 2 || mod_exists(self[2], self[3])){
            array_push(returnData, self[1]);
        }
    }
    if(argument0 < array_length(returnData)){
        return returnData[argument0];
    }

 // On Taking An Ultra:
#define race_ultra_take
    var ultra = 0;
    var ultraName = global.ultraData[argument0-1][1];
    for(i = 1; i <= ultra_count(mod_current); i++){
        if(race_ultra_text(i) == ultraName){
            ultra = i;
            break;
        }
    }
    if(instance_exists(mutbutton)) switch(ultra){
         // Play Ultra Sounds:
        case 1:    sound_play(sndFishUltraA); break;
        case 2:    sound_play(sndFishUltraB); break;
        case 3:    sound_play(sndRobotUltraA); break;
        case 4:    sound_play(sndRobotUltraB); break;
        /// Add more cases if you have more ultras!
    }
 // Get Ultra:
#define has_ultra(num)
    //let it use single characters
    if(is_string(num)){
        var char = string_ord_at(num, 1);
        if(char >= 65 && char <= 90){
            num = char - 65;
        }else if(char >= 97 && char <= 122){
            num = char - 97;
        }
        num++;
    }
    if(array_length(global.ultraMap) < num){
        race_ultra_name(1);
    }
    if(global.ultraNum < num || global.ultraMap[num - 1] == 0){
        return false;
    }
    return ultra_get(mod_current, global.ultraMap[num - 1]);
    
 // Projectile Stuff and Such//
 //#region PROJECTILE THINGIES

#define bubblespray
if current_frame_active{
				//Boost Particle:
				with(instance_create(x + lengthdir_x(0,gunangle),y + lengthdir_y(0,gunangle),FishBoost)){
					depth        = -3;
					image_speed  = 1.6;
					image_xscale = random_range(0.8,1.3);
					image_yscale = image_xscale;
					sprite_index = other.spr_sprayparticle;
					
				}
				//Bubble Particle:
				if (random(3) < 1) { instance_create(x + lengthdir_x(0,gunangle),y + lengthdir_y(0,gunangle),Bubble) }
				
				//Projectile:
				with(instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),CustomSlash)){
					
					direction = point_direction(x,y,mouse_x[other.index],mouse_y[other.index])+(random_range(20, -20))
					
					sprite_index = other.spr_bubbleprojectile;
					mask_index   = global.mskBubbleProjectile;
					
					spr_bubbletrail      = other.spr_bubbletrail;
					spr_smallbubbleexplo = other.spr_smallbubbleexplo;
					
					image_speed  = 0.4;
					image_xscale = random_range(0.8,1.3);
					image_yscale = image_xscale;
					image_angle  = random(360);
					depth		 = -3;
					
					ammo_type = -1;
					
					team = other.team;
					speed = 5.5 + random_range(0.8,2.3);
					friction = 0.2;
					
					// Loop Scaling Damage:
					if has_ultra("B"){ damage = 1 + round(GameCont.loops/4); } //decreases loop scaling with DB
					else{ damage = 1 + round(GameCont.loops/2); }
					
					on_projectile = bubbleprojectile_nullify
					on_anim       = nothing
					on_step       = bubbleprojectile_step
					on_wall       = bubbleprojectile_wall
				    on_hit        = bubbleprojectile_hit
				    on_destroy    = bubbleprojectile_destroy
				    on_draw       = bubbleprojectile_draw
				    
				}}
				
 // Bubble Projectile:
#define bubbleprojectile_step 

//speen
image_angle += 5
//trail
if (random(25) < current_time_scale){
with instance_create(x+random_range(-1,1),y+random_range(-1,1),PlasmaTrail){ sprite_index = other.spr_bubbletrail image_angle = random(360) }
}




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
}}
//Explosion:
with instance_create(x,y,CustomSlash){
	sprite_index = other.spr_smallbubbleexplo
	mask_index = mskSmallExplosion
	image_speed = 0.4 
	
	ammo_type = -1;
	
	//damage = 1 + round(GameCont.loops/2);
	speed = 0;
	team = other.team
	
	on_projectile = bubbleprojectile_nullify;
	on_wall = nothing;
	on_hit  = nothing;
	on_draw = bubbleprojectile_draw;
}

#define bubbleprojectile_draw
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 0.8);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 1.2*image_xscale, 1.2*image_yscale, image_angle, image_blend, 0.1);
draw_set_blend_mode(bm_normal);

#define bubblespray_ultrac
if current_frame_active{
				//Particle:
				with(instance_create(x + lengthdir_x(0,gunangle),y + lengthdir_y(0,gunangle),FishBoost)){
					depth = -3
					image_speed = 1.6
					image_xscale = random_range(0.8,1.3)
					image_yscale = image_xscale
					sprite_index = other.spr_sprayparticle
					
					ammo_type = -1;
					
					
				}
				//Bubble Particle:
				if (random(3) < 1) {
				with(instance_create(x + lengthdir_x(0,gunangle),y + lengthdir_y(0,gunangle),Bubble)){
					image_yscale = image_xscale
					
				}}
				//Projectile:
				with(instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),CustomSlash)){
					
					direction = point_direction(x,y,mouse_x[other.index],mouse_y[other.index])+(random_range(20, -20))
					
					sprite_index = other.spr_bubbleprojectile
					//mask_index   = global.mskBubbleProjectile
					
					spr_bubbletrail = other.spr_bubbletrail
					spr_smallbubbleexplo = other.spr_smallbubbleexplo
					
					image_speed  = 0.4;
					image_xscale = random_range(0.65,0.9)
					image_yscale = image_xscale;
					image_angle  = random(360)
					depth		 = -3;
					target		 = noone;
					angle		 = 16;
					team		 = other.team;
					speed		 = 7.5 + random_range(0.8,2.3);
					friction	 = 0.2;
					
					ammo_type = -1;

					damage = 7 + GameCont.loops;
					
					on_projectile = bubbleprojectile_nullify
					on_anim       = nothing
					on_step       = bubbleprojectile_ultrac_step
					on_wall       = bubbleprojectile_wall
				    on_hit        = bubbleprojectile_hit
				    on_destroy    = bubbleprojectile_destroy
				    on_draw       = bubbleprojectile_draw
				    
				}}

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
if (random(25) < current_time_scale){
with instance_create(x+random_range(-1,1),y+random_range(-1,1),PlasmaTrail){
  	sprite_index = other.spr_bubbletrail
  	image_angle = random(360)
 }}

//speedcheck / destroy
if speed < 2 { instance_destroy()}

#define bubbleprojectile_crowncranium

with instance_create(x,y,CustomSlash){
	sprite_index = other.spr_ccburst;
	mask_index = mskExplosion;
	image_speed = 0.4;
	depth = -3;
	damage = 0;
	force = 10;
	hitlist = [];
	
	ammo_type = -1;
	
	speed = 0;
	team = other.team;
	creator = other;
	
	on_projectile = nothing;
	on_wall = nothing;
	on_step = bubbleprojectile_cc_step;
	on_hit  = bubbleprojectile_cc_hit;
	on_draw = bubbleprojectile_draw;
}
#define bubbleprojectile_cc_step
if current_frame_active{
if instance_exists(creator){
		xprevious = creator.x;
		yprevious = creator.y;
		x = creator.x;
		y = creator.y;
	}
}
#define bubbleprojectile_cc_hit
							 //obj, ?force, ?direction, ?friction, ?canwallhit, ?dontwait, ?disableeffects, ?hook_merge
	call(scr.superforce_push, other, force, point_direction(x,y,other.x,other.y), 0.8, true, false); //superforce is so cool...

//only hit once
	var _r = 0;
	with(other){
		for(var i = 0;i<array_length(other.hitlist);i++){
			if other.hitlist[i] = self{
				_r = 1;
			}
		}
		if !(_r){
			other.hitlist[array_length(other.hitlist)] = self;
			var _nexthurt = nexthurt
			projectile_hit(self, other.damage, other.damage, other.direction);
			if instance_exists (self) nexthurt = _nexthurt
		}
	}
#define nothing
//wow look! nothing!

#define orbital_step

//trail
if current_frame_active{
if random(2)< 1 {
with instance_create(x+random_range(-4,4),y+random_range(-4,4),PlasmaTrail){
  	sprite_index = other.spr_bubbletrail
  	image_angle = random(360)
  	image_speed = 0.3
  	image_xscale = 0.6
  	image_yscale = image_xscale
		}
	}
}
 
if image_alpha == 0{
instance_destroy()
}
if instance_exists(self){
image_alpha = 0
}

#define orbital_nullify
//trace("AAA")
if(instance_exists(creator)){
with creator{if orbitalsize > 0{orbitalsize -= 0.10}} //orbitals shrink as they take hits
if creator.orbitalsize > 0.2{
if(instance_exists(self)){
		if (other.typ > 0) {
			 with (other){
			 	//trace("BLOCK!")
			  	instance_destroy()
			  } } } } }

#define chance(_numer, _denom)                                                          return  random(_denom) < _numer;