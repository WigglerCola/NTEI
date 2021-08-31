#define init
global.WeaponSprite 	  = sprite_add_weapon("../sprites/weapons/sprLaserPrism.png", 1, 6);

global.sprPrismBeam       = sprite_add("../sprites/projectiles/sprPrismBeam.png",14,0,6);
global.mskPrismBeam       = sprite_add("../sprites/projectiles/mskPrismBeam.png",1,2,6);
global.mskPrismBeamLB       = sprite_add("../sprites/projectiles/mskPrismBeamLB.png",1,2,7.5);
global.sprPrismBeamStart = sprite_add("../sprites/projectiles/sprPrismBeamStart.png",14,8,8);
global.sprPrismBeamHead 	  = sprite_add("../sprites/projectiles/sprPrismBeamHead.png",14,8,2)

#macro current_frame_active (current_frame < floor(current_frame) + current_time_scale)

#define weapon_name             return "LASER PRISM";                          
#define weapon_sprt             return global.WeaponSprite;
//#define weapon_sprt_hud       return global.sprWeaponHud;
#define weapon_type             return 5;
#define weapon_melee            return false;
#define weapon_auto             return true;
#define weapon_load             return 14;
#define weapon_cost             return 2;
//#define weapon_rads           return 1;
#define weapon_swap             return sndSwapEnergy;
#define weapon_area             return 15;
#define weapon_text             return "@(color:16745694)SHINING COLORS";
#define nts_weapon_examine      return{ "d": "A POWERFUL PRISM CAPABLE OF EMITTING A COLORFUL BEAM. ",}

#define weapon_fire

if !instance_exists(self) exit;
with instance_create((x+lengthdir_x(0, direction)),(y+lengthdir_y(0, direction)),CustomProjectile){
    creator = other
    team = other.team
    direction = creator.gunangle
    image_angle = direction
    created = false
	sprite_index = global.sprPrismBeam
	if !skill_get(17) mask_index   = global.mskPrismBeam 
	if skill_get(17) mask_index   = global.mskPrismBeamLB
	spr_tail     = global.sprPrismBeamStart
	spr_head     = global.sprPrismBeamHead
	damage = 2 

    on_step = beam_step
    on_wall = beam_wall
	on_hit  = beam_hit
	
	if !skill_get(17) on_draw = beam_draw
	if skill_get(17) on_draw = beam_draw_lb
	if skill_get(17) image_yscale = 1.3
	
    time = weapon_load() + current_time_scale
    image_speed = 1
}


//beam stuff
#define beam_step
if instance_exists(creator){
	if created = false{
		created = true
		sound_play_pitchvol(sndSwapGold,.4 * random_range(.9, 1.1), 1.5)
	}

    time -= current_time_scale
    if time <= 0 {instance_destroy(); exit}
    x = creator.x + creator.hspeed_raw + lengthdir_x(16,creator.gunangle)
    y = creator.y + creator.vspeed_raw + lengthdir_y(16,creator.gunangle)
    xstart = x
    ystart = y
    image_xscale = 1
    direction = creator.gunangle
    image_angle = direction

    var _x = lengthdir_x(2,direction), _y = lengthdir_y(2,direction)
    var dir = 0
    do {
    	dir += 2;
    	x += _x
    	y += _y
    }
    until dir >= 1800 || place_meeting(x,y,Wall)
    xprevious = x
    yprevious = y

    image_xscale = dir/2
    image_yscale = 1 * random_range(.9,1.1)

}
else instance_destroy()

#define beam_wall
#define beam_hit
projectile_hit(other,damage);

#define beam_draw
draw_sprite_ext(sprite_index, image_index, xstart, ystart, image_xscale, image_yscale, image_angle, image_blend, 1.0);
draw_sprite_ext(sprite_index, image_index, xstart, ystart, image_xscale, image_yscale*1.7, image_angle, image_blend, 0.1);//bloom
	if x != xstart draw_sprite_ext(spr_tail, -1, xstart, ystart, 1, image_yscale, image_angle, image_blend, 1.0);
		if x != xstart draw_sprite_ext(spr_tail, -1, xstart, ystart, 1, image_yscale*1.5, image_angle, image_blend, 0.2);
	if x != xstart draw_sprite_ext(spr_head, -1, x, y, image_yscale*2, image_yscale*2, image_angle-45, image_blend, 1.0);
	if x != xstart draw_sprite_ext(spr_head, -1, x, y, image_yscale*2.7, image_yscale*2.7, image_angle-45, image_blend, 0.2); //bloom
#define beam_draw_lb
draw_sprite_ext(sprite_index, image_index, xstart, ystart, image_xscale, image_yscale*1.3, image_angle, image_blend, 1.0);
draw_sprite_ext(sprite_index, image_index, xstart, ystart, image_xscale, image_yscale*2, image_angle, image_blend, 0.1);//bloom
	if x != xstart draw_sprite_ext(spr_tail, -1, xstart, ystart, 1.3, image_yscale*1.3, image_angle, image_blend, 1.0);
		if x != xstart draw_sprite_ext(spr_tail, -1, xstart, ystart, 1.3, image_yscale*1.8, image_angle, image_blend, 0.2);
	if x != xstart draw_sprite_ext(spr_head, -1, x, y, image_yscale*2.3, image_yscale*2.3, image_angle-45, image_blend, 1.0);
	if x != xstart draw_sprite_ext(spr_head, -1, x, y, image_yscale*3, image_yscale*3, image_angle-45, image_blend, 0.2); //bloom