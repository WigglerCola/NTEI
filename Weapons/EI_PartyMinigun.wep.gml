#define init

global.WeaponSprite 	  = sprite_add_weapon("../sprites/weapons/sprPartyMinigun.png", 2, 6);
//global.sprWeaponHud       = sprite_add_weapon("../sprites/weapons/hudsprites/sprWEAPONHUDNAME.png",1,1,);
global.sprWhiteSmoke        = sprite_add("../sprites/particles/sprWhiteSmoke.png",5,12,12)

#define weapon_name             return "PARTY MINIGUN";                          
#define weapon_sprt             return global.WeaponSprite;
//#define weapon_sprt_hud         return global.sprWeaponHud;
#define weapon_type             return 1;
#define weapon_melee            return false;
#define weapon_auto             return true;
#define weapon_load             return 1;
#define weapon_cost             return 1;
//#define weapon_rads             return 1;
#define weapon_swap             return sndSwapFlame;
#define weapon_area             return 7;
#define weapon_text             return "@(color:16745694)THE PARTY NEVER STOPS";
#define nts_weapon_examine      return{ "d": "FIRES CONFETTI AT A RAPID PACE. ",}

#define weapon_fire

//firing code here
// Kick, Shift, Shake:
    weapon_post(3, 8, 5);
// Sounds:
    sound_play_pitchvol(sndConfettiGun,random_range(0.8,1.2),1);    
// Knockback:
    motion_add(gunangle,-0.50);

// Projectile
repeat(1){
      with mod_script_call("mod","ExIso_Projectiles","ConfettiBall_Create",(x+lengthdir_x(7,gunangle)),y+lengthdir_y(7,gunangle)){
			direction = other.gunangle + (random_range(-12, 12) * other.accuracy);
            speed = 9 + irandom(2)
      
    //Particles:
    repeat(1)
    with instance_create(x+lengthdir_x(speed,direction + 2),y+lengthdir_y(speed,direction + 2),Smoke){
    {
      sprite_index = global.sprWhiteSmoke;
      image_xscale = 0.2 + random_range(0.1,0.4);
      image_yscale = image_xscale;
      motion_add(other.direction+random_range(-8,8),2+random(2))
    }}}}
