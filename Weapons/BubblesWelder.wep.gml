#define init

global.WeaponSprite 	  = sprite_add_weapon("../sprites/weapons/sprBubblesWelder.png", 0, 2);
//global.sprWeaponHud       = sprite_add_weapon("../sprites/weapons/hudsprites/sprBubblesCutlassHud.png",0,4,);
//global.sprWeaponArt       = sprite_add_weapon("../sprites/weapons/loadout/sprBubblesCutlassLoadout.png",24,18,);

global.sprWelderShank       = sprite_add("../sprites/projectiles/sprWelderShank.png",2,-5,8)

#define weapon_name             return "WELDING TOOL";                          
#define weapon_sprt             return global.WeaponSprite;
//#define weapon_sprt_hud         return global.sprWeaponHud;
#define weapon_type             return 5;
#define weapon_melee            return false;
#define weapon_auto             return true;
#define weapon_load             return 15;
#define weapon_cost             return 1;
#define weapon_swap             return sndSwapEnergy;
#define weapon_area             return -1;
#define weapon_text             return "@(color:16745694)NON-BIODEGRADABLE";
#define nts_weapon_examine      return{ "d": "THE WEAPON OF A TRUE TREASURE HUNTER, PROBABLY. ",}

//#define weapon_loadout          return global.sprWeaponArt;

#define weapon_fire

repeat(15){
if !instance_exists(self){exit}

//Sounds//
//Laser Brain
if skill_get(17){
sound_play_pitchvol(sndEnergyScrewdriverUpg,random_range(0.9,1.2),1);
sound_play_pitchvol(sndEnergySword,random_range(1.1,1.3),0.55);
} else {
//Default
sound_play_pitchvol(sndEnergyScrewdriver,random_range(0.9,1.2),1);
sound_play_pitchvol(sndEnergySword,random_range(1.1,1.3),0.55);
}

// Kick, Shift, Shake:
    weapon_post(-6, 2,2);

//Shank
  with instance_create(x+lengthdir_x(8,gunangle),y+lengthdir_y(8,gunangle),EnergyShank)
  {
    sprite_index = global.sprWelderShank
    direction = other.gunangle + (random_range(10, -10) * other.accuracy);
    speed = 1.5 + (skill_get(13) * 6);
    image_angle = direction;
    team = other.team;
    creator = other;
    damage = 5;
    }

//Particles
    with instance_create(x+lengthdir_x(16,gunangle),y+lengthdir_y(16,gunangle),PlasmaTrail){
      sprite_index = sprPopoPlasmaTrail
      image_xscale = 0.4 + random_range(0.1,0.4);
      image_yscale = image_xscale;
      speed = 3;
      direction = other.gunangle + (random_range(45, -45) * other.accuracy);
    }
    
//motion_add(gunangle, 0.6);
wait(1)
}