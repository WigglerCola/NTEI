#define init

// Area Sprites
global.sprAreaIcon			= sprite_add("../sprites/areas/sprLabsRouteIcon.png",1,4,4);
global.sprFloor 			= sprite_add("../sprites/areas/graveyard/sprFloorGraveyard.png",8,0,0);
global.sprFloorB			= sprite_add("../sprites/areas/graveyard/sprFloorGraveyardB.png",8,0,0);
global.sprFloorExplo		= sprite_add("../sprites/areas/graveyard/sprFloorGraveyardExplo.png",4,1,1);
global.sprWallBot			= sprite_add("../sprites/areas/graveyard/sprWallGraveyardBot.png",4,0,0);
global.sprWallTop			= sprite_add("../sprites/areas/graveyard/sprWallGraveyardTop.png",8,0,0);
global.sprWallOut			= sprite_add("../sprites/areas/robocenter/sprWallRobocenterOut.png",1,4,12);
global.sprWallTrans 		= sprite_add("../sprites/areas/graveyard/sprWallGraveyardTrans.png",8,0,0);
global.sprDebris		    = sprite_add("../sprites/areas/graveyard/sprDebrisGraveyard.png",4,4,4);
global.sprDetail			= sprite_add("../sprites/areas/graveyard/sprDetailGraveyard.png",3,4,4);
global.sprTopDecal			= sprite_add("../sprites/areas/graveyard/sprTopDecalGraveyard.png",3,16,16);
global.sprTopDecal2			= sprite_add("../sprites/areas/graveyard/sprTopDecalGraveyard2.png",1,16,48);
global.sprSnowFlake 		= sprite_add("../sprites/areas/graveyard/sprSnowFlake.png",3,4,4);

		
// Prop Sprites

//Snow Poff
global.sprSnowPoff		          = sprite_add("../sprites/areas/graveyard/props/sprSnowPoff.png", 1, 13, 9);
global.sprSnowPoffHurt		      = sprite_add("../sprites/areas/graveyard/props/sprSnowPoffHurt.png", 3, 13, 9);
global.sprSnowPoffDead		      = sprite_add("../sprites/areas/graveyard/props/sprSnowPoffDead.png", 3, 13, 9);
//Generic Masks
global.mskTrashPileCommonHuge	  = sprite_add("../sprites/areas/graveyard/props/mskTrashPileCommonHuge.png", 1, 44, 30);
global.mskTrashPileMedium		  = sprite_add("../sprites/areas/graveyard/props/mskTrashPileMedium.png", 1, 25, 13);
global.mskTrashPileSmall		  = sprite_add("../sprites/areas/graveyard/props/sprTrashPileCommon.png", 1, 24, 28);
//CommonPile
global.sprTrashPileCommon		  = sprite_add("../sprites/areas/graveyard/props/sprTrashPileCommon.png", 1, 22, 22);
global.sprTrashPileCommon1		  = sprite_add("../sprites/areas/graveyard/props/sprTrashPileCommon1.png", 1, 24, 28);
global.sprTrashPileCommon1Hurt	  = sprite_add("../sprites/areas/graveyard/props/sprTrashPileCommon1Hurt.png", 3, 24, 28);
global.sprTrashPileCommon1Dead    = sprite_add("../sprites/areas/graveyard/props/sprTrashPileCommon1Dead.png", 3, 24, 28);
global.sprTrashPileCommon2		  = sprite_add("../sprites/areas/graveyard/props/sprTrashPileCommon2.png", 1, 24, 28);
global.sprTrashPileCommon2Hurt	  = sprite_add("../sprites/areas/graveyard/props/sprTrashPileCommon2Hurt.png", 3, 24, 28);
global.sprTrashPileCommon2Dead    = sprite_add("../sprites/areas/graveyard/props/sprTrashPileCommon2Dead.png", 3, 24, 28);
global.sprTrashPileCommon3		  = sprite_add("../sprites/areas/graveyard/props/sprTrashPileCommon3.png", 1, 24, 28);
global.sprTrashPileCommon3Hurt	  = sprite_add("../sprites/areas/graveyard/props/sprTrashPileCommon3Hurt.png", 3, 24, 28);
global.sprTrashPileCommon3Dead    = sprite_add("../sprites/areas/graveyard/props/sprTrashPileCommon3Dead.png", 3, 24, 28);
//TechPile1
global.sprTrashPileTech1		  = sprite_add("../sprites/areas/graveyard/props/sprTrashPileTech1.png", 1, 25, 13);
global.sprTrashPileTech1Hurt	  = sprite_add("../sprites/areas/graveyard/props/sprTrashPileTech1Hurt.png", 3, 25, 13);
global.sprTrashPileTech1Dead	  = sprite_add("../sprites/areas/graveyard/props/sprTrashPileTech1Dead.png", 3, 25, 13);
//Carpile
global.mskTrashPileCar  		  = sprite_add("../sprites/areas/graveyard/props/mskTrashPileCar.png", 1, 20, 15);
global.sprTrashPileCar  		  = sprite_add("../sprites/areas/graveyard/props/sprTrashPileCar.png", 1, 20, 15);
//BossesPlusPile
global.mskTrashPileBossesPlus  	  = sprite_add("../sprites/areas/graveyard/props/mskTrashPileBossesPlus.png", 1, 29, 25);
global.sprTrashPileBossesPlus  	  = sprite_add("../sprites/areas/graveyard/props/sprTrashPileBossesPlus.png", 1, 29, 25);
global.sprTrashPileBossesPlusHurt = sprite_add("../sprites/areas/graveyard/props/sprTrashPileBossesPlusHurt.png", 3, 29, 25);
global.sprTrashPileBossesPlusDead = sprite_add("../sprites/areas/graveyard/props/sprTrashPileBossesPlusDead.png", 3, 29, 25);
//RadPile
global.sprTrashPileRad   		  = sprite_add("../sprites/areas/graveyard/props/sprTrashPileRad.png", 1, 12, 12);
//RemovedWepsPile
global.sprTrashPileRemovedWeps	  = sprite_add("../sprites/areas/graveyard/props/sprTrashPileRemovedWeps.png", 1, 12, 12);
//EggplantPile
global.sprTrashPileEggplant	   	  = sprite_add("../sprites/areas/graveyard/props/sprTrashPileEggplant.png", 1, 12, 12);
//CommonPileHuge 
global.sprTrashPileCommonHuge	  = sprite_add("../sprites/areas/graveyard/props/sprTrashPileCommonHuge.png", 1, 44, 30);
//HugeEggplantPile
global.sprTrashPileHugeEggplant   = sprite_add("../sprites/areas/graveyard/props/sprTrashPileHugeEggplant.png", 1, 44, 30);

//Mod Compat Piles
//Varia KendoPile
global.sprVariaKendoPile		  = sprite_add("../sprites/areas/graveyard/props/sprVariaPileKendo.png", 1, 19, 24);
global.sprVariaKendoPileHurt	  = sprite_add("../sprites/areas/graveyard/props/sprVariaPileKendoHurt.png", 3, 19, 24);
global.sprVariaKendoPileDead	  = sprite_add("../sprites/areas/graveyard/props/sprVariaPileKendoDead.png", 3, 19, 24);
//Varia AceSword
global.mskVariaPileAceSword		  = sprite_add("../sprites/areas/graveyard/props/mskVariaPileAceSword.png", 1, 32, 53);
global.sprVariaPileAceSword		  = sprite_add("../sprites/areas/graveyard/props/sprVariaPileAceSword.png", 1, 32, 53);
global.sprVariaPileAceSwordHurt	  = sprite_add("../sprites/areas/graveyard/props/sprVariaPileAceSwordHurt.png", 3, 32, 53);
global.sprVariaPileAceSwordDead   = sprite_add("../sprites/areas/graveyard/props/sprVariaPileAceSwordDead.png", 3, 32, 53);

#macro smallpilehealth 10
#macro hugepilehealth 40


global.song = sound_add("../sounds/music/musGraveyard.ogg");


 // Number of subareas:
#macro subareas                 3
 // The area after this one:
#macro nextarea                 "robocenter"
#macro nsubarea                 1

#macro area_backcol             make_color_rgb(20,25,27)

#macro DEBUG false // remember to set to false before sharing

    if DEBUG{
        trace("Press 5 to access graveyard");
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

//make these based off a GameCont or whatever sani said
global.ThundershockPileSpawned = false;
global.BossesPlusPileSpawned = false;
			
#macro current_frame_active frac(current_frame) < current_time_scale

#define area_name
return `@1(${global.sprAreaIcon}:0)1-`+string(GameCont.subarea);

#define area_text
	return choose(
		"@(color:16745694)SMELLS LIKE DEATH",
		"@(color:16745694)WHAT A WASTE",
		"@(color:16745694)ROT", 
		"@(color:16745694)NO RESPECT FOR THE DEAD",
		"@(color:16745694)RECYCLING"
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
material = 1;

#define area_setup
    sound_play_music(global.song)
    sound_play_ambient(amb5);
    goal = 150;
    background_color = area_backcol;
    BackCont.shadcol = c_black;
    TopCont.darkness = 0; //if area is dark
    safespawn = 1;
    
    ev_snow()
   
    
#define area_start

//Top Decals
with(Floor) if (random(7) < 1)
	with instance_create(x,y,TopDecalCity){
		dir = choose(-1,1)
		sprite_index = global.sprTopDecal;
	}

with(Floor) if (random(13) < 1)
	with instance_create(x,y,TopPot){
		dir = choose(-1,1)
		sprite_index = global.sprTopDecal2;
	    name = "ei_smokestack";
	}
	
//Boss Spawning
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


    


	//HugePile spawns:
//Huge Pile Spawn, clears some area around it so it doesn't clip into walls, the random(x) is the spawnrate
if random(45) < 1 and !place_meeting(x, y,prop) {
	TrashPileHuge_create(x + 16, y + 16);
	instance_create(x+32,y,Floor)
	instance_create(x+32,y+32,Floor)
	instance_create(x,y+32,Floor)
	instance_create(x,y-32,Floor)
	instance_create(x-32,y,Floor)
	instance_create(x+32,y-32,Floor)
	instance_create(x-32,y-32,Floor)
	instance_create(x-32,y+32,Floor)
}


    
//Area Generation
if abs(turn) = 90 and random(3) < 1{
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
if (random(14) < 1) mod_script_call('mod', 'ExIso_Enemies', 'Cremator_create', x + 16, y + 16);

if (random(40) < 1)   and !place_meeting(x, y,prop) and !place_meeting(x, y,Wall) TrashPileExplosive_create( x + random_range(8, 24), y + random_range(8, 24));
#define area_pop_props
//POSSESSABLES
if (random(20) < 1)   and !place_meeting(x, y,prop) and !place_meeting(x, y,Wall) PossessableProp1_create( x + random_range(8, 24), y + random_range(8, 24));

//Common Piles:
//if (random(3) < 1)    and !place_meeting(x, y,prop) and !place_meeting(x, y,Wall) TrashPileCommon_create( x + random_range(8, 24), y + random_range(8, 24));
//if (random(15) < 1)   and !place_meeting(x, y,prop) and !place_meeting(x, y,Wall) TrashPileTech1_create( x + random_range(8, 12), y + 16);
//if (random(40) < 1)   and !place_meeting(x, y,prop) and !place_meeting(x, y,Wall) TrashPileRad_create( x + random_range(8, 24), y + random_range(8, 24));

//Uncommon Piles:
//if (random(100) < 1)  and !place_meeting(x, y,prop) and !place_meeting(x, y,Wall)  TrashPileRemovedWeps_create( x + random_range(8, 24), y + random_range(8, 24));
//Rare Piles:
//if (random(150) < 1)  and !place_meeting(x, y,prop) and !place_meeting(x, y,Wall) TrashPileEggplant_create( x + random_range(8, 24), y + random_range(8, 24));

//Snow Poff
if (random(50) < 1)   and !place_meeting(x, y,prop) and !place_meeting(x, y,Wall) SnowPoff_create( x + random_range(8, 24), y + random_range(8, 24));

//ModCompat Piles
if (random(25) < 1)   and !place_meeting(x, y,prop) and !place_meeting(x, y,Wall) and (mod_exists("mod", "varia_tools")) VariaPileKendo_create( x + random_range(8, 24), y + random_range(8, 24));

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
    return [72, -9];

//snow
#define ev_snow
	{
	script_bind_step(step_snow, 0)
	}
#define step_snow
var smokedirection = 120 + sin(current_frame * 0.06)*20
	
	if current_frame_active { 
		
		
	with(instances_matching(TopPot, "name", "ei_smokestack")){
		if random(2) < 1 { 
			with instance_create(x,y - 32,Dust){ 
				name = "ei_smokestackdust"
				sprite_index = sprSmoke;
				direction = smokedirection + random_range(-20,20); 
				speed = 1.5; 
				depth = -7; 
				growspeed = 0.14;
				friction = -0.2;
				//friction = 1;
				}
			} 
		}
		
with(instances_matching(Dust, "name", "ei_smokestackdust")){	
	image_alpha -= 0.03;
}
	
		// Snowflakes:
	with instance_create(view_xview+random(game_width*2)-game_width/2,view_yview+random(game_height*2)-game_height/2,SnowFlake){ sprite_index = global.sprSnowFlake; }		
		
		// Icy Breath:
	if random(50) < 1{
	with Player if race != "robot" and race != "plant"{
		with instance_create(x,y,Breath)
		image_xscale = other.right
		}
	}
}
//#region PROPS

//#region POSSESSABLE PROPS

#define PossessableProp1_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		 // Visual:
		spr_idle = sprBushIdle;
		spr_hurt = sprBushHurt;
		spr_dead = sprBushDead;
		 // Sounds:
		snd_hurt = sndHitMetal;
		snd_dead = sndStreetLightBreak;
		 // Vars:
		ei_possessable = true;
		ei_possesstype = 1;
		maxhealth      = 4;
		my_health      = maxhealth;
		team		   = -1;
		
		return self;
	}
	

//Huge Trash Pile Spawnweights
#define TrashPileHuge_create(_x, _y)
choosepile = random(80)

if choosepile < 50 and !place_meeting(x, y,prop){
TrashPileCommonHuge_create(_x,_y) } //Common Huge Pile

if choosepile > 50 and choosepile < 55 and !place_meeting(x, y,prop){
TrashPileHugeEggplant_create(_x,_y) } //Eggplant Huge

if choosepile > 55 and choosepile < 70 and !place_meeting(x, y,prop){
TrashPileBossesPlus_create(_x,_y) } // BossesPlus

if choosepile > 70 and choosepile < 80 and !place_meeting(x, y,prop) and (mod_exists("mod", "varia_tools")){
VariaPileAceSword_create(_x,_y) } // Varia SwordPile

if choosepile > 70 and choosepile < 80 and !place_meeting(x, y,prop) and !(mod_exists("mod", "varia_tools")){
	TrashPileCommonHuge_create(_x,_y)} //defaults to CommonHuge if mod isn't loaded

#define SnowPoff_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		 // Visual:
		spr_idle = global.sprSnowPoff;
		spr_hurt = global.sprSnowPoffHurt
		spr_dead = global.sprSnowPoffDead;
		spr_shadow = mskNone
		 // Sounds:
		snd_hurt = sndHitPlant;
		snd_dead = sndMoneyPileBreak;
		 // Vars:
		maxhealth = 4;
		my_health = maxhealth;
		team	  = 0;
		
		return self;
	}
	
//Normal Piles:
#define TrashPileCommon_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		 // Visual:
		altsprite = choose(1,2,3)
		 
		if altsprite = 1{
		spr_idle = global.sprTrashPileCommon1;
		spr_hurt = global.sprTrashPileCommon1Hurt;
		spr_dead = global.sprTrashPileCommon1Dead
		snd_dead = sndComputerBreak;}
		if altsprite = 2{
		spr_idle = global.sprTrashPileCommon2;
		spr_hurt = global.sprTrashPileCommon2Hurt;
		spr_dead = global.sprTrashPileCommon2Dead
		snd_dead = sndStreetLightBreak;}
		if altsprite = 3{
		spr_idle = global.sprTrashPileCommon3;
		spr_hurt = global.sprTrashPileCommon3Hurt;
		spr_dead = global.sprTrashPileCommon3Dead
		snd_dead = sndComputerBreak;}
		spr_shadow = mskNone

		 // Sounds:
		snd_hurt = sndHitMetal;
		 // Vars:
		maxhealth  = smallpilehealth;
		my_health  = maxhealth;
		mask_index = global.mskTrashPileMedium
		team	   = 0;
		
		on_death = TrashPileCommon_destroy
		
		return self;
	}
#define TrashPileCommon_destroy
pickup_drop(50,30,2)

#define TrashPileTech1_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		 // Visual:
		 
		spr_idle = global.sprTrashPileTech1;
		spr_hurt = global.sprTrashPileTech1Hurt;
		spr_dead = global.sprTrashPileTech1Dead;
		spr_shadow = mskNone

		 // Sounds:
		snd_hurt = sndHitMetal;
		snd_dead = sndComputerBreak;
		 // Vars:
		maxhealth = smallpilehealth;
		my_health = maxhealth;
		mask_index = global.mskTrashPileMedium
		team = 0;
		
		on_death = TrashPileCommon_destroy
		
		return self;
	}
	
#define TrashPileRemovedWeps_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		 // Visual:
		spr_idle = global.sprTrashPileRemovedWeps;
		spr_hurt = sprSpiderHurt;
		spr_dead = sprSpiderDead;
		spr_shadow = mskNone

		 // Sounds:
		snd_hurt = sndHitMetal;
		snd_dead = sndStreetLightBreak;
		 // Vars:
		maxhealth = smallpilehealth;
		my_health = maxhealth;
		mask_index = mskSpider
		team = 0;
		
		on_death = TrashPileRemovedWeps_destroy
		
		return self;
	}
#define TrashPileRemovedWeps_destroy
with(instance_create(x,y,WepPickup)){
    wepdrop = choose(1,2,)
	if wepdrop = 1 {wep = wep_ion_cannon}
	if wepdrop = 2 {wep = wep_sentry_gun}
}

#define TrashPilePurpleHyper_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		 // Visual:
		spr_idle = global.sprTrashPileRemovedWeps;
		spr_hurt = sprSpiderHurt;
		spr_dead = sprSpiderDead;
		spr_shadow = mskNone

		 // Sounds:
		snd_hurt = sndHitMetal;
		snd_dead = sndStreetLightBreak;
		 // Vars:
		maxhealth = smallpilehealth;
		my_health = maxhealth;
		mask_index = mskSpider
		team = 0;
		
		on_death = TrashPilePurpleHyper_destroy
		
		return self;
	}
#define TrashPilePurpleHyper_destroy
with(instance_create(x,y,WepPickup)){
    wepdrop = choose(1,2,3)
	if wepdrop = 1 {wep = "EI_PurpleHyperRifle"}
	if wepdrop = 2 {wep = "EI_PurpleHyperLauncher"}
	if wepdrop = 3 {wep = "EI_PurpleHyperSlugger"}
}

#define TrashPileEggplant_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		 // Visual:
		spr_idle = global.sprTrashPileEggplant;
		spr_hurt = sprSpiderHurt;
		spr_dead = sprSpiderDead;
		spr_shadow = mskNone

		 // Sounds:
		snd_hurt = sndHitMetal;
		snd_dead = sndStreetLightBreak;
		 // Vars:
		maxhealth = smallpilehealth;
		my_health = maxhealth;
		mask_index = mskSpider
		team = 0;
		
		on_death = TrashPileEggplant_destroy
		
		return self;
	}
#define TrashPileEggplant_destroy
repeat(random_range(3,5))
with(instance_create(x,y,WepPickup)){
    wep = wep_eggplant
    direction = random(360)
    speed = 1 + random(3)
}

#define TrashPileExplosive_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		 // Visual:
		spr_idle = global.sprTrashPileCar;
		spr_hurt = sprBarrelHurt;
		spr_dead = sprBarrelDead;
		 // Sounds:
		snd_hurt = sndHitMetal;
		snd_dead = sndExplosionCar;
		 // Vars:
		maxhealth = 20;
		my_health = maxhealth;
		mask_index = global.mskTrashPileCar
		team = 0;
		
		on_death = TrashPileExplosive_destroy
		
		return self;
	}
#define TrashPileExplosive_destroy
instance_create(x,y,Explosion)
repeat(random_range(5,7)){
instance_create(x+random_range(-25,25),y+random_range(-25,25),GroundFlame)
}
#define TrashPileRad_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		 // Visual:
		spr_idle = global.sprTrashPileRad;
		spr_hurt = sprBarrelHurt;
		spr_dead = sprBarrelDead;
		 // Sounds:
		snd_hurt = sndHitMetal;
		snd_dead = sndStreetLightBreak;
		 // Vars:
		maxhealth = 4;
		my_health = maxhealth;
		team = 0;
		
		on_death = TrashPileRad_destroy
		
		return self;
	}
#define TrashPileRad_destroy
repeat(random_range(7,25))
	with instance_create(x,y,Rad){ direction = random(360) speed = irandom(2) }

//Huge Piles:
#define TrashPileCommonHuge_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		 // Visual:
		 
		spr_idle = global.sprTrashPileCommonHuge;
		spr_hurt = sprSpiderHurt;
		spr_dead = sprSpiderDead;
		spr_shadow = mskNone

		 // Sounds:
		snd_hurt = sndHitMetal;
		snd_dead = sndStreetLightBreak;
		 // Vars:
		maxhealth = hugepilehealth;
		my_health = maxhealth;
		mask_index = global.mskTrashPileCommonHuge
		team = 0;
		
		on_death = TrashPileCommonHuge_destroy
		
		return self;
	}
#define TrashPileCommonHuge_destroy
repeat(random_range(5,10))
pickup_drop(50,30,2)

#define TrashPileHugeEggplant_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		 // Visual:
		 
		spr_idle = global.sprTrashPileHugeEggplant;
		spr_hurt = sprSpiderHurt;
		spr_dead = sprSpiderDead;
		spr_shadow = mskNone

		 // Sounds:
		snd_hurt = sndHitMetal;
		snd_dead = sndStreetLightBreak;
		 // Vars:
		maxhealth = hugepilehealth;
		my_health = maxhealth;
		mask_index = global.mskTrashPileCommonHuge
		team = 0;
		
		on_death = TrashPileHugeEggplant_destroy
		
		return self;
	}
#define TrashPileHugeEggplant_destroy
repeat(random_range(30,60))
with(instance_create(x,y,WepPickup)){
    wep = wep_eggplant
    direction = random(360)
    speed = 2 + random(4)
}

#define TrashPileBossesPlus_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		 // Visual:
		 
		spr_idle = global.sprTrashPileBossesPlus;
		spr_hurt = global.sprTrashPileBossesPlusHurt;
		spr_dead = global.sprTrashPileBossesPlusDead;
		spr_shadow = mskNone

		 // Sounds:
		snd_hurt = sndHitMetal;
		snd_dead = sndHydrantBreak;
		 // Vars:
		maxhealth = 25;
		my_health = maxhealth;
		mask_index = global.mskTrashPileBossesPlus
		team = 0;
		
		on_death = TrashPileCommon_destroy
		
		return self;
	}
	
//ModCompat Piles
#define VariaPileKendo_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		 // Visual:
		 
		spr_idle = global.sprVariaKendoPile;
		spr_hurt = global.sprVariaKendoPileHurt;
		spr_dead = global.sprVariaKendoPileDead;
		spr_shadow = mskNone

		 // Sounds:
		snd_hurt = sndHitPlant;
		snd_dead = sndMoneyPileBreak;
		 // Vars:
		maxhealth = smallpilehealth;
		my_health = maxhealth;
		mask_index = mskSpider
		team = 0;
		
		on_death = VariaPileKendo_destroy
		
		return self;
	}
#define VariaPileKendo_destroy
repeat(random_range(1,4))
with(instance_create(x,y,WepPickup)){
    wep = "va_kendo_stick"
}

#define VariaPileAceSword_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		 // Visual:
		 
		spr_idle = global.sprVariaPileAceSword;
		spr_hurt = global.sprVariaPileAceSwordHurt;
		spr_dead = global.sprVariaPileAceSwordDead;
		spr_shadow = mskNone

		 // Sounds:
		snd_hurt = sndHitMetal;
		snd_dead = sndComputerBreak;
		 // Vars:
		maxhealth = hugepilehealth;
		my_health = maxhealth;
		mask_index = global.mskVariaPileAceSword
		team = 0;
		
		on_death = VariaPileAceSword_destroy
		
		return self;
	}
#define VariaPileAceSword_destroy
with(instance_create(x,y,WepPickup)){
    wep = "va_thundershock"
}