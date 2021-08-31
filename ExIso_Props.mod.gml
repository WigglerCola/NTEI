
//DevZone
global.sprDevbox1 = sprite_add("sprites/areas/devzone/props/sprDevbox1.png", 1, 12, 12);
global.sprDevbox1Hurt = sprite_add("sprites/areas/devzone/props/sprDevbox1Hurt.png", 3, 12, 12);
global.sprDevbox2 = sprite_add("sprites/areas/devzone/props/sprDevbox2.png", 1, 12, 12);
global.sprDevbox2Hurt = sprite_add("sprites/areas/devzone/props/sprDevbox2Hurt.png", 3, 12, 12);
global.sprDevbox3 = sprite_add("sprites/areas/devzone/props/sprDevbox3.png", 1, 12, 12);
global.sprDevbox3Hurt = sprite_add("sprites/areas/devzone/props/sprDevbox3Hurt.png", 3, 12, 12);
global.sprDevbox1Dead = sprite_add("sprites/areas/devzone/props/sprDevboxDead.png", 3, 12, 12);
global.sprDevcone = sprite_add("sprites/areas/devzone/props/sprDevcone.png", 1, 12, 14);
global.sprDevconeHurt = sprite_add("sprites/areas/devzone/props/sprDevconeHurt.png", 3, 12, 14);
global.sprDevconeDead = sprite_add("sprites/areas/devzone/props/sprDevconeDead.png", 3, 12, 14);
global.sprDevLight = sprite_add("sprites/areas/devzone/props/sprDevLight.png", 1, 16, 52);
global.sprDevLightHurt = sprite_add("sprites/areas/devzone/props/sprDevLightHurt.png", 3, 16, 52);
global.sprDevLightDead = sprite_add("sprites/areas/devzone/props/sprDevLightDead.png", 3, 16, 52);

#define ExampleProp_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		 // Visual:
		spr_idle = global.sprDevbox1;
		spr_hurt = global.sprDevbox1Hurt;
		spr_dead = global.sprDevbox1Dead;
		 // Sounds:
		snd_hurt = sndHitMetal;
		snd_dead = sndStreetLightBreak;
		 // Vars:
		maxhealth = 4;
		my_health = maxhealth;
		
		return self;
	}

//Devzone Props	
#define Devbox_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		 // Visual:
		altsprite = choose(1,2,3)
		 
		if altsprite = 1{
		spr_idle = global.sprDevbox1;
		spr_hurt = global.sprDevbox1Hurt;}
		if altsprite = 2{
		spr_idle = global.sprDevbox2;
		spr_hurt = global.sprDevbox2Hurt;}
		if altsprite = 3{
		spr_idle = global.sprDevbox3;
		spr_hurt = global.sprDevbox3Hurt;}
		
		
		spr_dead = global.sprDevbox1Dead;
		 // Sounds:
		snd_hurt = sndHitMetal;
		snd_dead = sndStreetLightBreak;
		 // Vars:
		maxhealth = 4;
		my_health = maxhealth;
		
		return self;
	}
#define Devcone_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		 // Visual:
		spr_idle = global.sprDevcone;
		spr_hurt = global.sprDevconeHurt;
		spr_dead = global.sprDevconeDead;
		 // Sounds:
		snd_hurt = sndHitMetal;
		snd_dead = sndStreetLightBreak;
		 // Vars:
		maxhealth = 4;
		my_health = maxhealth;
		
		return self;
	}
#define Devlight_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		 // Visual:
		spr_idle = global.sprDevLight;
		spr_hurt = global.sprDevLightHurt;
		spr_dead = global.sprDevLightDead;
		mask_index = mskStreetLight;
		spr_shadow = shd32;	
		spr_shadow_y = 1;
		depth = -7;
		 // Sounds:
		snd_hurt = sndHitMetal;
		snd_dead = sndStreetLightBreak;
		 // Vars:
		maxhealth = 4;
		my_health = maxhealth;
		friction = 12;
		
		return self;
	}