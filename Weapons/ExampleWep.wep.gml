#define init
global.WeaponSprite 	  = sprite_add_weapon("../sprites/weapons/sprPartyGun.png", 1, 1);
//global.sprWeaponHud       = sprite_add_weapon("../sprites/weapons/hudsprites/sprWEAPONHUDNAME.png",1,1,);

#define weapon_name  return "NAME";                          
#define weapon_sprt  return global.WeaponSprite;
#define weapon_type  return 0;
#define weapon_melee return false;
#define weapon_auto  return false;
#define weapon_load  return 1;
#define weapon_cost  return 1;
//#define weapon_rads  return 1;
#define weapon_swap  return sndSwapShotgun;
#define weapon_area  return 10;
#define weapon_text  return "@(color:16745694)WEAPON TIP";

//#define weapon_sprt_hud     return global.sprWeaponHud;
#define nts_weapon_examine  return{ "d": "NTS WEAPON DESCRIPTION. ",}

#define weapon_fire
    // Sounds:
    sound_play_pitchvol(sndConfettiGun,random_range(0.8,1.2),1);    
    
    // Kick, Shift, Shake:
    weapon_post(2, 2, 2);