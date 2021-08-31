#define init

global.WeaponSprite 	  = sprite_add_weapon("../sprites/weapons/sprPartyGun.png", -2, 4);
//global.sprWeaponHud       = sprite_add_weapon("../sprites/weapons/hudsprites/sprWEAPONHUDNAME.png",1,1,);
global.sprWhiteSmoke        = sprite_add("../sprites/particles/sprWhiteSmoke.png",5,12,12)

#define weapon_name             return "PARTY GUN";                          
#define weapon_sprt             return global.WeaponSprite;
//#define weapon_sprt_hud         return global.sprWeaponHud;
#define weapon_type             return 1;
#define weapon_melee            return false;
#define weapon_auto             return true;
#define weapon_load             return 6;
#define weapon_cost             return 1;
//#define weapon_rads             return 1;
#define weapon_swap             return sndSwapFlame;
#define weapon_area             return 2;
#define weapon_text             return "@(color:16745694)WOOHOO!";
#define nts_weapon_examine      return{ "d": "PERFECT FOR CELEBRATIONS. ",}

#define weapon_fire

//firing code here
// Kick, Shift, Shake:
    weapon_post(3, 8, 5);
// Sounds
    sound_play_pitchvol(sndConfettiGun,random_range(0.8,1.2),1);    

  with instance_create(x+lengthdir_x(-1,gunangle),y+lengthdir_y(-1,gunangle),ConfettiBall)
    {
      direction = other.gunangle + (random_range(5, -5) * other.accuracy);
      speed = 8;
      depth = -2;
      image_angle = direction;
      team = other.team;
      creator = other
      
      PeacockFeathers = 1;
    
    //Particles:
    repeat(1)
    with instance_create(x+lengthdir_x(speed,direction),y+lengthdir_y(speed,direction),Smoke){
    {
      sprite_index = global.sprWhiteSmoke;
      image_xscale = 0.2 + random_range(0.1,0.4);
      image_yscale = image_xscale;
      motion_add(other.direction+random_range(-8,8),1+random(2))
    }}}