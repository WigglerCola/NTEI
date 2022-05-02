 // On Mod Load:
#define init

	// Sprites //
	global.mskCorSlash    = sprite_add("../sprites/Characters/Amalgam/mskAmalgamSlash.png", 2, 0, 36);
    //A-Skin:
	global.sprIdle[0]     = sprite_add("../sprites/Characters/Bubbles/sprBubblesIdle.png", 8, 16, 15);
	global.sprWalk[0]     = sprite_add("../sprites/Characters/Bubbles/sprBubblesWalk.png", 6, 16 ,15);
	global.sprHurt[0]     = sprite_add("../sprites/Characters/Bubbles/sprBubblesHurt.png", 3, 16, 15);
	global.sprDead[0]     = sprite_add("../sprites/Characters/Bubbles/sprBubblesDead.png", 13,16 ,15);
	global.sprGoSit[0]    = sprite_add("../sprites/Characters/Bubbles/sprBubblesGoSit.png",3, 12, 12);
	global.sprSit[0]      = sprite_add("../sprites/Characters/Bubbles/sprBubblesSit.png",	1, 12, 12);
	global.sprIdleCor[0]  = sprite_add("../sprites/Characters/Amalgam/sprAmalgamCorruptIdle.png", 8, 16, 15);
	global.sprWalkCor[0]  = sprite_add("../sprites/Characters/Amalgam/sprAmalgamCorruptWalk.png", 6, 16, 15);
	global.sprCorSlash[0] = sprite_add("../sprites/Characters/Amalgam/sprAmalgamSlash.png", 2, 0, 36);
	global.sprCurse[0]	  = sprCurse
	global.sprCurseCor[0] = sprite_add("../sprites/Characters/Amalgam/sprCurseCorrupted.png", 6, 4, 4);
	//B-Skin:
	global.sprIdle[1]     = sprite_add("../sprites/Characters/Bubbles/sprBubblesBIdle.png", 4, 16, 15);
	global.sprWalk[1]     = sprite_add("../sprites/Characters/Bubbles/sprBubblesBWalk.png", 6, 16, 15);
	global.sprHurt[1]     = sprite_add("../sprites/Characters/Bubbles/sprBubblesBHurt.png", 3, 16, 15);
	global.sprDead[1]     = sprite_add("../sprites/Characters/Bubbles/sprBubblesBDead.png", 9, 16 ,15);
	global.sprGoSit[1]    = sprite_add("../sprites/Characters/Bubbles/sprBubblesBGoSit.png",3, 12, 12);
	global.sprSit[1]      = sprite_add("../sprites/Characters/Bubbles/sprBubblesBSit.png",	1, 12, 12);
	global.sprIdleCor[1]  = sprite_add("../sprites/Characters/Amalgam/sprAmalgamBCorruptIdle.png", 8, 16, 15);
	global.sprWalkCor[1]  = sprite_add("../sprites/Characters/Amalgam/sprAmalgamBCorruptWalk.png", 6, 16, 15);	
	global.sprCorSlash[1] = sprite_add("../sprites/Characters/Amalgam/sprAmalgamBSlash.png", 2, 0, 36);
	global.sprCurse[1]	  = sprCurse
	global.sprCurseCor[1] = sprite_add("../sprites/Characters/Amalgam/sprCurseCorrupted.png", 6, 4, 4);
	//Selection / Map:
	global.spr_slct = sprite_add("../sprites/Characters/Amalgam/sprAmalgamSelect.png",	2, 0, 0);
	global.spr_port = sprite_add("../sprites/Characters/Amalgam/sprAmalgamPortrait.png",	race_skins(),	40, 243);
	global.spr_skin[0] = sprite_add("../sprites/Characters/Bubbles/sprBubblesLoadout.png",	2,	16, 16);
	global.spr_skin[1] = sprite_add("../sprites/Characters/Bubbles/sprBubblesBLoadout.png",	2,	16, 16);
	global.spr_icon = sprite_add("../sprites/Characters/Amalgam/sprAmalgamMapIcon.png",	race_skins(),	10, 10);
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
	global.sprCampfireSlct   = sprite_add("../sprites/Characters/Amalgam/sprAmalgamCorruptIdle.png", 8, 16, 15); //Selected
	global.sprCampfireMenu   = sprite_add("../sprites/Characters/Amalgam/sprAmalgamCorruptIdle.png", 8, 16, 15); //Waiting
	global.sprCampfireTo     = sprite_add("../sprites/Characters/Bubbles/sprBubblesHurt.png", 3, 16, 15);  //Selecting
	global.sprCampfireFrom   = sprite_add("../sprites/Characters/Bubbles/sprBubblesHurt.png", 3, 16, 15);  //Deselecting

	#macro current_frame_active frac(current_frame) < current_time_scale

	// Ultra Names and Descriptions:
    global.ultraData = [
        ["ULTRA A", "NYI"], 
        ["ULTRA B", "NYI"], 
        ["ULTRA C", "NYI", "mod", "metamorphosis"], 
        ["ULTRA D", "NYI", "mod", "LOMuts"]
    ];
    global.ultraMap = [];
    global.ultraNum = 0;
    
	 // Reapply sprites if the mod is reloaded. //
	with(instances_matching(Player, "race", mod_current)) { 
		assign_sprites();
		assign_sounds();
	}

#macro active_noc_cost 200 - corruption_on_heal // Cost of Non-Corrupted Active
#macro corruption_on_hit  20					// Amount corruption is increased when hit (is multiplied by amount)
#macro corruption_on_heal 15					// Amount corruption is subtracted when healed (is multiplied by healing strength)
#macro slash_damage_scaling min(2,(0.7037037+(0.03703704 * GameCont.level)+0.009259259*power(GameCont.level,2))) // Scales Damage based off level - same as Varia Martial Scaling

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
		repeat(15) with instance_create(x,y,Smoke){
			speed        = random_range(2,3)
			direction    = random(360)
			depth        = -16 }
		
#define race_menu_select //when i click u
	if(instance_is(self, CharSelect) || instance_is(other, CharSelect)){

		sound_play_pitchvol(sndOasisBossFire, 1, 1);
		
		return -1;
	}
	

 // On Character's Creation (Starting a run, getting revived in co-op, etc.):
#define create
	
	spr_idle = global.sprIdle[bskin]; //setting this here so the little thing in the cheats mod char select shows up, other sprites in assign_sprites
	
	 // Variables:
	maxhealth				= 6;		// 2 Less Base Health
	maxspeed				= 4.2;		// Extra .2 Extra Base Speed
	corruption_max_charge 	= 600;		// Max Corruption
	corruption_charge    	= 0; 		// Starting Corruption
	corruption_charge_rate  = 1;		// Corruption Increase Rate
	corrupted				= false;    // If Corrupted
	active_noc_recharge     = 0;		// Recharge cooldown for Non-Corrupted Active
	active_cor_recharge     = 0;		// Recharge cooldown for Corrupted Active
	
	prev_health = my_health;
	

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
	spr_idle_noc = global.sprIdle[bskin];
	spr_walk_noc = global.sprWalk[bskin];
	spr_idle_cor = global.sprIdleCor[bskin];
	spr_walk_cor = global.sprWalkCor[bskin];
	spr_slash    = global.sprCorSlash[bskin];
	spr_curse	 = global.sprCurse[bskin];
	spr_curse_cor = global.sprCurseCor[bskin];
	
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

	//#region PASSIVE
	// PASSIVE - CORRUPTION // 
	
	// Switch Corrupt State (Corrupt):
if corrupted = false and corruption_charge >= corruption_max_charge { corrupted = true; 

		// Set Sprites:
		spr_idle = spr_idle_cor;
		spr_walk = spr_walk_cor;
	
		// Set Corrupt Stats:
    	maxhealth += 2;
    	my_health += 2;
		my_health = min(my_health, maxhealth)
		
		maxspeed    += 1;
		reloadspeed += 0.25;
		accuracy	*= 2;
	
		// Particles and Sound:
		sound_play_pitchvol(sndOasisBossFire,1,1)
		repeat(random_range(10,20)) with instance_create(x,y,Curse){ speed = random(3); direction = random(360); depth = -10; }
}
	// Switch corrupt State (Not Corrupt):
if corrupted = true  and corruption_charge <= 0 { corrupted = false; 

		// Set Sprites:
		spr_idle = spr_idle_noc;
		spr_walk = spr_walk_noc;
	
		// Set Normal Stats:

    	maxhealth -= 2;
    	my_health = max(my_health - 2, 1) 
    	my_health = min(my_health, maxhealth)
    	
		maxspeed    -= 1;
		reloadspeed -= 0.25;
		accuracy	/= 2;
		
		
		// Particles and Sound:
		sound_play_pitchvol(sndOasisBossMelee,1.5,2)
		repeat(random_range(10,20)) with instance_create(x,y,CaveSparkle){ speed = random(3); direction = random(360); image_blend = c_purple; }
}

	// DURING NORMAL STATE:
if corrupted = false {
	if random(600) < corruption_charge / 4 { with instance_create(x,y,Curse){ speed = random_range(0,1); direction = random(360); sprite_index = other.spr_curse; } }	
}
	// DURING CORRUPT STATE:
if corrupted = true {
	with instance_create(x,y,Curse){ speed = random(2); direction = random(360); sprite_index = other.spr_curse_cor; }
}

	// Increase/Decrease Corruption on Hit/Heals:
var diff = prev_health - my_health;
    
    	// When change is 0 (does nothing)
    if (diff != 0){ 
    
		// Decrease Corruption when Healed:
    if(diff < 0){ 
        	corruption_charge += corruption_on_heal * diff;
        }
        // Increase Corruption when Hit:
        else{
            corruption_charge += corruption_on_hit * diff * 2;
        }
    }
    // make prev_health work again
    prev_health = my_health;
    


	// Corruption Recharge (Not Corrupted):
if corrupted = false and corruption_charge < corruption_max_charge { corruption_charge += corruption_charge_rate } // Increase Corruption over time:
 corruption_charge_rate = 0.5 * current_time_scale // Normal Charge Rate
	
	// Corruption Drain (Corrupted)
if corrupted = true and corruption_charge > 0 { corruption_charge -= 2 * current_time_scale }	
	
	// Stops Corruption from going over max:
if corruption_charge > corruption_max_charge
   corruption_charge = corruption_max_charge
	// Stops Corruption from going below zero:
if corruption_charge < 0
   corruption_charge = 0
   
	// Remove Cooldowns
if active_noc_recharge >= 0 { active_noc_recharge -= current_time_scale }
if active_cor_recharge >= 0 { active_cor_recharge -= current_time_scale }

	//#region ACTIVES

	// Not Corrupted //
	
	// PURIFY //	
if(canspec) and corrupted = false and corruption_charge > active_noc_cost and active_noc_recharge <= 0 {
if button_check(index,"spec"){

sound_play_pitchvol(sndSwapGold,1.5,2)
//repeat(random_range(10,20)) with instance_create(x,y,CaveSparkle){ speed = random(3); direction = random(360); image_blend = c_lime; }

repeat(18){ PurifyParticle_create(x + random_range(-30,30),y + random_range(-30,30)) }            

my_health = min(my_health + 1, maxhealth)
corruption_charge -= active_noc_cost - corruption_on_heal;
active_noc_recharge = 30 * 1 / reloadspeed; // Haste make go Fast; 

		}
	}
	
	// Corrupted //	
	
	// PUNCTURE // 
if(canspec) and corrupted = true and active_cor_recharge <= 0 {
if button_check(index,"spec"){
	
sound_play_pitchvol(sndBlackSwordMega,random_range(1.3,1.5),0.8)
sound_play_pitchvol(sndCursedReminder,random_range(0.7,0.9),1.2)
  with instance_create(x + lengthdir_x(-5,gunangle),y + lengthdir_y(-5,gunangle),CustomSlash)
  {
  	sprite_index = other.spr_slash;
  	mask_index   = global.mskCorSlash;
    direction	 = other.gunangle;
    speed		 = 2;
    image_angle  = direction;
    image_yscale = choose(1,-1)
    image_speed  = 0.4;
    ei_bloomamount = 1.1;
    ei_bloomtransparency = 0.1;
    team		 = other.team;
    creator 	 = other;
    damage		 = round(16 * slash_damage_scaling);
    canreflect	 = false;
    
    ammo_type = -1;
    
    on_hit		 = AmalgamSlash_hit;
    }

active_cor_recharge = 15 * 1 / reloadspeed; // Haste make go Fast

		}
	}

	
	
	
	
//#region CHARACTER VARS

 // Locked away forever:
#define race_avail			   return 1;					// Can I have you:
#define race_lock              return "COMPLETE LABS ROUTE";// How I get you;
#define race_unlock            return "FOR COMPLETING LABS ROUTE";  // I got you!:


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

#define race_skins						return 2;																	// Skin Count:
#define race_skin_button				sprite_index = global.spr_skin[argument0]; image_index = !race_skin_avail();// Skin Icons:


// Character Vars:
#define race_name						return "AMALGAM";													  // Character Name: 
#define race_text						return "@(color:8592231)C@(color:8264567)U@(color:6822787)R@(color:5315480)S@(color:4398256)E@(color:4529874)D#@gPURIFY@w/@(color:4529874)PUNCTURE"; // Character Description:
#define race_menu_button				sprite_index = global.spr_slct; image_index = !race_avail();		  // Character Selection Icon:
#define race_portrait					return global.spr_port; 											  // Portrait:
#define race_mapicon					return global.spr_icon; 										   	  // Loading Screen Map Icon:
#define race_ultra_button				sprite_index = global.spr_ultport[argument0];						  // Ultra Button Portraits:
#define race_ultra_icon 				return global.spr_ulticon[argument0];								  // Ultra HUD Icons:

#define race_ttip
	 // Ultra:
	if(GameCont.level >= 10 && chance(1, 5)){
		return choose(
			"@(color:4529874)WHOS THE FAILED EXPERIMENT NOW?",
			"@(color:4529874)NO MORE CAGES"
		);
	}
	
	 // Normal:
	return choose(
		"@gPURIFY @sREDUCES @(color:4529874)CORRUPTION",                  
		"@sTAKING @wDAMAGE @sINCREASES @(color:4529874)CORRUPTION",
		"@gHEALING @sREDUCES @(color:4529874)CORRUPTION",
		"@(color:4529874)LAB RAT",
		"@(color:4529874)CONTAINMENT BREACH",
		"@(color:4529874)WHATS GOING ON?",
		"@(color:4529874)THEY CHANGED YOU"
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
        default : return "AmalgamShiv"; } //A Skin
        
#define race_tb_text return "NYI";												  // Throne Butt Description:
#define race_tb_take															  // On Taking Throne Butt:
// Crown Cranium Description:
#define race_cc_text return "NYI";


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

#define chance(_numer, _denom)                                                          return  random(_denom) < _numer;
#define nothing
//wow look, nothing!

#define AmalgamSlash_hit
with(other){
if nexthurt <= current_frame{
if chance(1,5){ instance_create(x,y,AmmoPickup) }
if chance(1,3){ instance_create(x,y,BigRad) }
projectile_hit(self,other.damage,other.force)
  }
}

#define PurifyParticle_create(_x, _y)	
	with instance_create(_x, _y, CustomObject){
		creator = other;
		sprite_index = sprCaveSparkle;
		image_index = random(image_number);
		image_speed = 0;
		image_blend = c_lime;
		image_angle = random(360);
		image_xscale = random_range(0.7,1);
		image_yscale = image_xscale;
		speed		 = random_range(7,9)
		ei_bloomamount       = 2;
		ei_bloomtransparency = 0.1;
		
		
		on_step = PurifyParticle_step
		return self
	}
#define PurifyParticle_step
if instance_exists(creator){
direction = point_direction(x, y, creator.x, creator.y)
}
if place_meeting(x,y,creator) or !instance_exists(creator){ instance_destroy()}