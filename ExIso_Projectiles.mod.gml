//This file will have the majority of projectiles stored in it, with the exception of a few projectiles, generally try to keep things commented for easy searching
        
        //Sprites:

//Candle:
global.sprWhiteSmoke        = sprite_add("sprites/particles/sprWhiteSmoke.png",5,12,12)
global.sprCandleTrail       = sprite_add("sprites/particles/sprCandleTrail.png",3,4,4)
global.sprCandleTrail2       = sprite_add("sprites/particles/sprCandleTrail2.png",12,20,8)
global.sprCandleFire        = sprite_add("sprites/projectiles/sprCandleFire.png",7,8,8)
global.sprCandle            = sprite_add("sprites/projectiles/sprCandle.png",3,26,8)
global.sprCandleBase            = sprite_add("sprites/projectiles/sprCandleBase.png",3,26,8)
global.sprCandleHit         = sprite_add("sprites/projectiles/sprCandleHit.png",4,12,12)



        //General Stuff:

#define bloom_draw
//General Bloom Vars

//bloom_amount = BLOOMAMOUNT
//bloomtransparency = 0.1

draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 1);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, bloom_amount*image_xscale, bloom_amount*image_yscale, image_angle, image_blend, bloomtransparency);
draw_set_blend_mode(bm_normal);

#define muzzleflash_anim
image_index = 1;
Image_speed = 0;

#define missileflame_draw
//Missile Flame Vars

//missileflame_sprite = global.sprSPRITENAME
//missileflame_x      = X location
//missileflame_y      = Y location
//missileflame_bloom  = missile bloom amount

{
	draw_sprite_ext(missileflame_sprite, current_frame * .4, missileflame_x, missileflame_y, 1, 1, image_angle, c_white, image_alpha);
	draw_set_blend_mode(bm_add);
	draw_sprite_ext(missileflame_sprite, current_frame * .4, x, y, missileflame_bloom * image_xscale, missileflame_bloom * image_yscale, image_angle, c_white, 0.2);
}
draw_set_blend_mode(bm_normal);
draw_self();

#define general_hit
projectile_hit(other, damage)
instance_destroy();

#define general_wall
instance_destroy();



        //Actual Projectiles:

		// Candles:
#define Candle_Create(xx,yy)

  with instance_create(xx, yy, CustomProjectile)
    {
      var r = random(255);
      candlecolor = r
      
      sprite_index = global.sprCandle;
      mask_index = mskBullet1;
      image_blend = make_color_hsv(candlecolor,255,255);
      image_speed = 0.4;
      //depth = -2
      
      speed = 11 + irandom(2);
      damage = 7;
      typ = 0;
      creator = other;
      team = other.team;
      
      PeacockFeathers = 1	//peacock feathers
      pyroflammable = 1 	//metamorp pyromania
      
      bloom_amount = 1.8
      bloomtransparency = 0.2

	  on_step     = candle_step;
	  on_end_step = candle_end_step;
	  on_hit      = general_hit;
	  on_wall     = general_wall;
	  on_destroy  = candle_destroy;
	  on_draw     = candle_draw;

	return self;

    }

#define candle_step

  with instance_create(x+random_range(-1,1),y+random_range(-1,1),Smoke){
  	sprite_index = global.sprWhiteSmoke
  	image_xscale = 0.5;
  	image_yscale = image_xscale;
  }
  with instance_create(x+random_range(-1,1),y+random_range(-1,1),PlasmaTrail){
  	sprite_index = global.sprCandleTrail
  }
  if random(5)<1 {
  with instance_create(x+random_range(-2,2),y+random_range(-2,2),PlasmaTrail){
  	sprite_index = global.sprCandleTrail2
  	image_angle = random(360)
  	image_xscale = random_range(0.3,0.6)
  	image_yscale = image_xscale;
  	image_speed = random_range(0.4,0.8)
  	speed = 0.3
  }}

#define candle_end_step
with instance_create(x,y,BoltTrail){
    image_xscale = point_distance(x,y,other.xprevious,other.yprevious)
    image_yscale = 1.2
    image_angle = point_direction(x,y,other.xprevious,other.yprevious)
    image_blend = make_color_hsv(other.candlecolor,255,255);
}

#define candle_destroy
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
    	PeacockFeathers = 1;
    	
    	sprite_index = global.sprCandleFire
        team = other.team;
        creator = other.creator;
        direction = other.direction + other.i + random_range(-1,1);
        speed = 4;
        
        image_blend = make_color_hsv(other.candlecolor,255,255);
    }}

#define candle_draw  
//needed a seperate draw for candles
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 1);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, bloom_amount*image_xscale, bloom_amount*image_yscale, image_angle, image_blend, bloomtransparency);
draw_set_blend_mode(bm_normal);

draw_sprite_ext(global.sprCandleBase, current_frame * .4, x, y, 1, 1, image_angle, c_white, image_alpha);
draw_set_blend_mode(bm_normal);