#define init

global.WeaponSprite 	  = sprite_add_weapon("../sprites/weapons/sprPartyCandleRifle.png", 1, 4);
//global.sprWeaponHud       = sprite_add_weapon("../sprites/weapons/hudsprites/sprWEAPONHUDNAME.png",1,1,);

#define weapon_name             return "CANDLE RIFLE";                          
#define weapon_sprt             return global.WeaponSprite;
//#define weapon_sprt_hud         return global.sprWeaponHud;
#define weapon_type             return 4;
#define weapon_melee            return false;
#define weapon_auto             return true;
#define weapon_load             return 12;
#define weapon_cost             return 2;
//#define weapon_rads             return 1;
#define weapon_swap             return sndSwapFlame;
#define weapon_area             return 9;
#define weapon_text             return "@(color:16745694)JUST A MORE PARTY";
#define nts_weapon_examine      return{ "d": "A ROMAN CANDLE LAUNCHER THAT FIRES IN BURSTS OF 3. ",}

#define weapon_fire


repeat(2) if instance_exists(self){
// Kick, Shift, Shake:
    weapon_post(3, 8, 6);
// Sounds
    sound_play_pitchvol(sndConfettiGun,random_range(0.8,1.2),1);

// Projectile
      with mod_script_call("mod","ExIso_Projectiles","Candle_Create",(x+lengthdir_x(7,gunangle)),y+lengthdir_y(7,gunangle)){
			direction = other.gunangle + (random_range(-6, 6) * other.accuracy);
			image_angle = direction;
      }
	wait(3);
}