#define init

global.WeaponSprite 	  = sprite_add_weapon("../sprites/weapons/sprPartyCandleMinigun.png", 3, 6);
global.sprWeaponHud       = sprite_add_weapon("../sprites/weapons/hudsprites/sprCandleMinigunHud.png",1,8,);

#define weapon_name             return "CANDLE MINIGUN";                          
#define weapon_sprt             return global.WeaponSprite;
#define weapon_sprt_hud         return global.sprWeaponHud;
#define weapon_type             return 4;
#define weapon_melee            return false;
#define weapon_auto             return true;
#define weapon_load             return 2;
#define weapon_cost             return 1;
//#define weapon_rads             return 1;
#define weapon_swap             return sndSwapFlame;
#define weapon_area             return 11;
#define weapon_text             return "@(color:16745694)HIGH SPEED PARTY DELIVERY";
#define nts_weapon_examine      return{ "d": "A MINIGUN THAT FIRES ROMAN CANDLES. ",}

#define weapon_fire

// Kick, Shift, Shake:
    weapon_post(3, 8, 6);
// Sounds:
    sound_play_pitchvol(sndConfettiGun,random_range(0.8,1.2),1);
// Knockback:
    motion_add(gunangle,-1.5);

// Projectile
repeat(1){
      with mod_script_call("mod","ExIso_Projectiles","Candle_Create",(x+lengthdir_x(7,gunangle)),y+lengthdir_y(7,gunangle)){
			direction = other.gunangle + (random_range(-12, 12) * other.accuracy);
			image_angle = direction;
      }}