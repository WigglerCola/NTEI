
// currently disabled since its not in a good state atm


#define init
global.sprSkillIcon = sprite_add("../sprites/mutations/PeacockFeathers.png", 1, 12, 16)
global.sprSkillHud   = sprite_add("../sprites/mutations/PeacockFeathersIcon.png", 1, 8, 8)

#define skill_name
	return "Peacock Feathers";
	
#define skill_text
	return "@sSome kills burst into @wdamaging Confetti@s";

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

//chance to burst on kill
        with(instances_matching_le(enemy, "my_health", 0)){
            if(random(13) < 1 * skill_get(mod_current)) and "Peacocked" not in self{
                featherburst()
                Peacocked = 1 //Stops PF from proccing multiple times on a single enemy
                //trace("WOOHOO!")
                break;
            }
        }
   
//Confetti Particles on Player
    	with(Player) {
    		if(random(20) < 1) {
    			repeat(irandom_range(1, 3)) {
	    			with instance_create(x, y, Confetti){ speed = random(3) z = random(3) direction = random(360)}
	    		}
    		}
    	}
#define featherburst
	var randodirect = irandom(360)
	//Confetti Balls:
  for (i = 0; i < 360; i += 45){
      with mod_script_call("mod","ExIso_Projectiles","ConfettiBall_Create",x,y){
			direction = other.direction + other.i + randodirect// + random_range(-65,65);
			team = 2;
			is_party = 0;
			PeacockTrail = 1;
			CanGland = 0;
			ConfettiCount = 30;
   }}
    //Particle
     with instance_create(x,y,ImpactWrists){
     var r = random(255);
     image_blend = make_color_hsv(r,255,255);
     image_xscale = 1
     image_yscale = image_xscale
}

