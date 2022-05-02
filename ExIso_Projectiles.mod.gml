#define init
	    
        //Sprites:
//Generic:
global.sprGenericTrail      = sprite_add("sprites/particles/sprGenericTrail.png", 50,0,50);
//Candle:
global.sprWhiteSmoke        = sprite_add("sprites/particles/sprWhiteSmoke.png",5,12,12)
global.sprCandleTrail       = sprite_add("sprites/particles/sprCandleTrail.png",3,4,4)
global.sprCandleTrail2      = sprite_add("sprites/particles/sprCandleTrail2.png",12,20,8)
global.sprCandleFire        = sprite_add("sprites/projectiles/sprCandleFire.png",7,8,8)
global.sprCandle            = sprite_add("sprites/projectiles/sprCandle.png",3,26,8)
global.sprCandleBase        = sprite_add("sprites/projectiles/sprCandleBase.png",3,26,8)
global.sprCandleHit         = sprite_add("sprites/projectiles/sprCandleHit.png",4,12,12)
//ConfettiBall:
global.sprConfettiBall      = sprite_add("sprites/projectiles/sprConfettiBall.png",1,3,3)

#macro current_frame_active frac(current_frame) < current_time_scale

        //General Stuff:
#define muzzleflash_anim
image_index = 1;
Image_speed = 0;

#define general_hit
projectile_hit(other, damage)
instance_destroy();

#define general_wall
instance_destroy();
#define nothing
//wow! look! nothing!

#define generic_trail_create(xx,yy) 
    with instance_create(xx,yy,Wind){
        sprite_index     = global.sprGenericTrail
        mask_index       = mskNone
        image_speed      = 2
        image_yscale     = (1/50)
        image_xscale     = 1
        depth			 = 0
        
        return self;
    }


        //Actual Projectiles:

		// Candles:
#define Candle_Create(xx,yy)

  with instance_create(xx, yy, CustomProjectile)
    {
      var randomcolor = random(255);
      candlecolor = randomcolor
      
      sprite_index = global.sprCandle;
      mask_index = mskBullet1;
      image_blend = make_color_hsv(candlecolor,255,255);
      image_speed = 0.4;
      //depth = -2
      
      speed = 11 + irandom(2);
      damage = 7;
      typ = 1;
      creator = other;
      team = other.team;
      hitid = [sprite_index, "CANDLE"];
      
      is_party = 1;	        //peacock feathers
      pyroflammable = 1; 	//metamorp pyromania
      
      ei_bloomamount = 1.8;
      ei_bloomtransparency = 0.2;
      
      //Compat Vars
	  ammo_type = 4;

	  on_step     = candle_step;
	  on_end_step = candle_end_step;
	  on_hit      = general_hit;
	  on_wall     = general_wall;
	  on_destroy  = candle_destroy;
	  on_draw     = candle_draw;

	return self;

    }

#define candle_step

if current_frame_active{
  with instance_create(x+random_range(-1,1),y+random_range(-1,1),Smoke){
  	sprite_index = global.sprWhiteSmoke
  	image_xscale = 0.5;
  	image_yscale = image_xscale;
  }
  with instance_create(x+random_range(-1,1),y+random_range(-1,1),PlasmaTrail){
  	sprite_index = global.sprCandleTrail
  }}
  if random(5)<current_time_scale {
  with instance_create(x+random_range(-2,2),y+random_range(-2,2),PlasmaTrail){
  	sprite_index = global.sprCandleTrail2
  	image_angle = random(360)
  	image_xscale = random_range(0.3,0.6)
  	image_yscale = image_xscale;
  	image_speed = random_range(0.4,0.8)
  	speed = 0.3
  }}

#define candle_end_step
with generic_trail_create(x,y){
    image_xscale = point_distance(x,y,other.xprevious,other.yprevious)
    image_yscale *= 1.2;
    image_speed  *= 4;
    image_angle = point_direction(x,y,other.xprevious,other.yprevious)
    image_blend = make_color_hsv(other.candlecolor,255,255);
}

#define candle_destroy

var candlecolor = other.candlecolor

    sound_play_pitchvol(sndExplosionS,random_range(0.8,1),1.5);
sound_play (asset_get_index("sndConfetti" + string(irandom_range(1, 7)))) //sounds

	with instance_create(x,y,BulletHit){  //hit effect
		sprite_index = global.sprCandleHit
		image_blend = make_color_hsv(other.candlecolor,255,255);
		image_xscale = 1.5
		image_yscale = image_xscale
		}
		
    for (i = 0; i < 360; i += 32){ //fire
    with instance_create(x,y,Flame)
    {
    	is_party = 1;
    	
    	sprite_index = global.sprCandleFire
        team = other.team;
        creator = other.creator;
        direction = other.direction + other.i + random_range(-1,1);
        speed = 4;
        hitid = [global.sprCandle, "CANDLE"];
        
        image_blend = make_color_hsv(candlecolor,255,255);
    }}

#define candle_draw
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 1);
draw_set_blend_mode(bm_add);
draw_sprite_ext(global.sprCandleBase, current_frame * .4, x, y, 1, 1, image_angle, c_white, image_alpha);
draw_set_blend_mode(bm_normal);

		// Confetti Remake:
#define ConfettiBall_Create(xx,yy)

  with instance_create(xx, yy, CustomProjectile)
    {
      var r = random(255);
      confetticolor = r
      
      sprite_index = global.sprConfettiBall;
      //mask_index = mskBullet1;
      image_blend = make_color_hsv(confetticolor,255,255);
      image_angle = 0
      depth = -2
      
      speed = 9 //default speed, change in wep file if needed
      friction = 0.3
      damage = 4;
      typ = 1;
      creator = other;
      team = other.team;
      hitid = [sprite_index, "CONFETTI"];
      gland_value = 1
      CanGland = 1
      ConfettiCount = 1 //keep as 1 for default value, raise for decreased confetti chance
      
      is_party = 1;
      PeacockTrail = 0;
      
      //Compat Vars
	  ammo_type = 1;
	  is_bullet = true;

	  on_step     = confettiball_step;
	  on_hit      = confettiball_hit;
	  on_wall     = general_wall;
	  on_destroy  = confettiball_destroy;

	return self;

    }
    
#define confettiball_hit
projectile_hit(other, damage)

//Recycle Gland
 if(skill_get(16) and CanGland = 1 && random(5) < 3){
 instance_create(other.x, other.y, RecycleGland);
 sound_play(sndRecGlandProc);
 with(creator) ammo[1] = min(typ_amax[1], ammo[1] + other.gland_value); }

//On kill effect
with(self){
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
                confetti_burst()
                break;
            }
        }
        exit;
    }
}

instance_destroy();
#define confetti_burst
sound_play (asset_get_index("sndConfetti" + string(irandom_range(1, 7))))
    repeat(random_range(8,15)){ //Confetti
    with instance_create(x,y,Confetti)
    {
        direction = irandom(360)
        speed = random_range(2,10)
        z = random_range(0,5)
    }}
  

#define confettiball_step

//Confetti
  if random(4 * ConfettiCount)<current_time_scale {
  with instance_create(x+random_range(-1,1),y+random_range(-1,1),Confetti){
  	speed = irandom(2.5)
  	direction = irandom(360)
  }}

   if PeacockTrail = 1 {
   with(instance_create(x, y, BoltTrail)) {
	 image_blend = make_color_hsv(other.confetticolor,255,255);
     image_angle = other.direction;
     image_xscale = other.speed;
     image_yscale = other.speed / 6;
     image_speed  = 0
	}}
	
//Speedcheck
if 1 > speed instance_destroy()
#define confettiball_destroy
with instance_create(x,y,Dust){
	sprite_index = global.sprWhiteSmoke
	image_xscale = random_range(0.3,0.6)
	image_yscale = image_xscale
}
    repeat(random(5)){ //Confetti
    with instance_create(x,y,Confetti)
    {
        direction = irandom(360)
        speed = random_range(1,3)
    }}

			