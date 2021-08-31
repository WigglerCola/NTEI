#define init

global.WeaponSprite 	  = sprite_add_weapon("../sprites/weapons/sprPartyCandleBarrage.png", 10, 7);
global.sprWeaponHud       = sprite_add_weapon("../sprites/weapons/hudsprites/sprCandleBarrageHud.png",1,8,);

#define weapon_name             return "CANDLE BARRAGE";                          
#define weapon_sprt             return global.WeaponSprite;
#define weapon_sprt_hud         return global.sprWeaponHud;
#define weapon_type             return 4;
#define weapon_melee            return false;
#define weapon_auto             return true;
#define weapon_load             return 8;
#define weapon_cost             return 3;
//#define weapon_rads             return 1;
#define weapon_swap             return sndSwapFlame;
#define weapon_area             return 14;
#define weapon_text             return "@(color:16745694)PARTY CITY";
#define nts_weapon_examine      return{ "d": "FIRES A FAST BARRAGE OF ROMAN CANDLES. ",}

#define weapon_fire

// Kick, Shift, Shake:
    weapon_post(6, 8, 6);
// Sounds:
    sound_play_pitchvol(sndConfettiGun,random_range(0.8,1.2),1);
// Knockback:
    motion_add(gunangle,-3);

// Projectile
repeat(5){
      with mod_script_call("mod","ExIso_Projectiles","Candle_Create",(x+lengthdir_x(7,gunangle)),y+lengthdir_y(7,gunangle)){
			direction = other.gunangle + (random_range(-13, 13) * other.accuracy);
			image_angle = direction;
      }}