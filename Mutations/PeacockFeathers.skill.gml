//If you want a projectile to work with Peacock Feathers, just add PeacockFeathers = 1
#define init
global.sprSkillIcon = sprite_add("../sprites/mutations/PeacockFeathers.png", 1, 12, 16)
global.sprSkillHud   = sprite_add("../sprites/mutations/PeacockFeathersIcon.png", 1, 8, 8)

#define skill_name
	return "Peacock Feathers";
	
#define skill_text
	return "@sEnemies killed by @wParty Weapons#@sBurst into damaging Confetti@s";

#define skill_button
	sprite_index = global.sprSkillIcon;
	
#define skill_icon
	return global.sprSkillHud;
	
#define skill_wepspec
	return 1;

#define skill_tip
	return "THE REAL PARTY BEGINS";
	
#define skill_take
	sound_play(sndConfetti4)
	
#define step

//thank u gepsi

with(instances_matching(projectile, "PeacockFeathers", 1)){
    PeacockFeathers = 2;
    if(fork()){
        var _x = x + hspeed_raw;
        var _y = y + vspeed_raw;
        while(instance_exists(self)){
            _x = x + hspeed_raw;
            _y = y + vspeed_raw;
            wait(0);
        }
        with(instances_matching_le(enemy, "my_health", 0)){
            if(distance_to_point(_x, _y) < 16){
                featherburst()
                //trace("WOOHOO!")
                break;
            }
        }
        exit;
    }
}

#define featherburst			
	//Confetti Balls:
  for (i = 0; i < 360; i += 45){
  with instance_create(x,y,ConfettiBall){
  	team = 2
    direction = other.direction + other.i //+ random_range(-65,65);
    speed = 6
   }}
    //Particle
     with instance_create(x,y,ImpactWrists){
     var r = random(255);
     image_blend = make_color_hsv(r,255,255);
     image_xscale = 1
     image_yscale = image_xscale
}

