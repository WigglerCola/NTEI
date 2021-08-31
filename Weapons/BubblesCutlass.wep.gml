#define init

global.WeaponSprite 	  = sprite_add_weapon("../sprites/weapons/sprBubblesCutlass.png", 4, 2);
global.sprWeaponHud       = sprite_add_weapon("../sprites/weapons/hudsprites/sprBubblesCutlassHud.png",0,4,);
global.sprWeaponArt       = sprite_add_weapon("../sprites/weapons/loadout/sprBubblesCutlassLoadout.png",24,18,);

#define weapon_name             return "PLASTIC CUTLASS";                          
#define weapon_sprt             return global.WeaponSprite;
#define weapon_sprt_hud         return global.sprWeaponHud;
#define weapon_type             return 0;
#define weapon_melee            return true;
#define weapon_auto             return false;
#define weapon_load             return 14;
#define weapon_cost             return 0;
#define weapon_swap             return sndSwapSword;
#define weapon_area             return -1;
#define weapon_text             return "@(color:16745694)NON-BIODEGRADABLE";
#define nts_weapon_examine      return{ "d": "THE WEAPON OF A TRUE TREASURE HUNTER, PROBABLY. ",}

#define weapon_loadout          return global.sprWeaponArt;

#define weapon_fire

sound_play_pitchvol(sndChickenSword,random_range(0.9,1.2),1);
sound_play_pitchvol(sndWrench,random_range(1.1,1.3),0.75);
  with instance_create(x+lengthdir_x(0,gunangle),y+lengthdir_y(0,gunangle),Slash)
  {
    direction = other.gunangle;
    speed = 1.5 + (skill_get(13) * 6);
    image_angle = direction;
    team = other.team;
    creator = other;
    damage = 8;
    }

wepangle = -wepangle;
motion_add(gunangle, 3.5);