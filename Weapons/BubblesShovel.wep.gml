#define init

global.WeaponSprite 	  = sprite_add_weapon("../sprites/weapons/sprBubblesShovel.png", 7, 7);
global.sprWeaponHud       = sprite_add_weapon("../sprites/weapons/hudsprites/sprBubblesShovelHud.png",0,5,);

#define weapon_name             return "HOARDER SHOVEL";                          
#define weapon_sprt             return global.WeaponSprite;
#define weapon_sprt_hud       return global.sprWeaponHud;
#define weapon_type             return 0;
#define weapon_melee            return true;
#define weapon_auto             return false;
#define weapon_load             return 22;
#define weapon_cost             return 0;
#define weapon_swap             return sndSwapGold;
#define weapon_area             return -1;
#define weapon_text             return "@(color:16745694)24 KARAT";
#define nts_weapon_examine      return{ "d": "A GOLDEN SHOVEL WITH GREEN GEMS EMBEDDED INTO IT. ",}

#define weapon_fire

sound_play_pitchvol(sndShovel,random_range(0.9,1.2),0.75);
sound_play_pitchvol(sndGoldScrewdriver,random_range(0.8,1),1);
  with instance_create(x+lengthdir_x(0,gunangle),y+lengthdir_y(0,gunangle),Slash)
  {
    direction = other.gunangle;
    speed = 1.5 + (skill_get(13) * 6);
    image_angle = direction;
    sprite_index = sprHeavySlash;
    team = other.team;
    creator = other;
    damage = 12;
    }

wepangle = -wepangle;
motion_add(gunangle, 3.5);