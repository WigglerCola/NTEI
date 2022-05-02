#define init

global.WeaponSprite 	  = sprite_add_weapon("../../sprites/weapons/sprAmalgamShiv.png", -2, 2);
global.sprWeaponHud       = sprite_add_weapon("../../sprites/weapons/hudsprites/sprAmalgamShivHud.png",-4,3,);
//global.sprWeaponArt       = sprite_add_weapon("../../sprites/weapons/loadout/sprBubblesCutlassLoadout.png",24,18,);

#define weapon_name             return "GLASS SHIV";                          
#define weapon_sprt             return global.WeaponSprite;
#define weapon_sprt_hud         return global.sprWeaponHud;
#define weapon_type             return 0;
#define weapon_melee            return true;
#define weapon_auto             return false;
#define weapon_load             return 5;
#define weapon_cost             return 0;
#define weapon_swap             return sndSwapSword;
#define weapon_area             return -1;
#define weapon_text             return "@(color:16745694)THEY NEVER SAW IT COMING";
#define nts_weapon_examine      return{ "d": "PERFECT FOR ESCAPING FACILITES 9/10.",}

//#define weapon_loadout          return global.sprWeaponArt;

#define weapon_fire

disjoint = 0 + 15 * skill_get(mut_long_arms) // long arms effect
		
sound_play_pitchvol(sndChickenSword,random_range(0.9,1.2),1);
sound_play_pitchvol(sndWrench,random_range(1.1,1.3),0.75);
  with instance_create(x + lengthdir_x(disjoint,gunangle),y + lengthdir_y(disjoint,gunangle),Shank)
  {
    direction = other.gunangle;
    speed = 2 + (skill_get(13) * 4);
    image_angle = direction;
    team = other.team;
    creator = other;
    damage = 5;
    canfix = false;
    }

wepangle = -wepangle;
weapon_post(-4,8,3);
instance_create(x,y,Dust)
motion_add(gunangle, 3.5);

#define weapon_reloaded
sound_play(sndMeleeFlip)
wepflip = sign(wepangle)