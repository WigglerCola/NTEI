#define init

	// Thunderstorm lightning strikes are stolen from defpack ty burg I dont know how to use vertexs
	
	
	// EVENTS LIST AND FUNFACTS:
	
		// Meteor Shower - Any Desert Stage //
	// WIP
	
		// Nighttime Scrapyards - Any Scrapyards Stage //
	// - Was originally going to be added in Relics, but I pilfered the idea after relics development stopped
	
	
		// Thunderstorm - Any Scrapyards Stage //
	// - Makes the area half-dark, increases rain amount, and makes lightning randomly strike
	// - Lightning can only spawn nearby players
	// - Lightning can't strike Vault Entrances
	// - Lightning has a slight delay before starting when the level begins
	// - Lightning (and rain) will stop when no enemies are left (vans count as enemies)
	// - Light Beams and Custom Fog are added to the level aswell
	
		// Aurora - Any Frozen City Stage //
	// - Cannot Occur during a Blizzard

		// Blizzard - Any Frozen City Stage //
	// - Cannot occur during an Aurora
	// - Makes the area half-dark, adds lots of quickly moving snow, and adds an icy tint to the screen
	

    // LIB:
		global.libLoaded = false;
	if(fork()){
		while(!mod_exists("mod", "lib")){wait(1);}

		script_ref_call(["mod", "lib", "getRef"], "mod", mod_current, "scr");

		var modules = ["libEvents","libAreas"];
		with(modules) call(["mod", "lib", "import"], self);

		global.libLoaded = true;
		
		call(scr.event_add, "MeteorShower", mod_current);
		call(scr.event_add, "Arcade", mod_current);
		call(scr.event_add, "Thunderstorm", mod_current);
		call(scr.event_add, "ScrapyardsNight", mod_current);
		call(scr.event_add, "LabsEntranceCreate", mod_current);
		call(scr.event_add, "Aurora", mod_current);
		call(scr.event_add, "Blizzard", mod_current);
		
		exit;
	}
	
    // SETTINGS //
    global.lightningflash = true;         //Flash Effect when Lightning Strikes (true/false)
    global.respritemode = false;		  //only turn this on if using my area resprites (true/false)
    
    // SOUNDS //
   	global.musThunderstorm 						 = sound_add("sounds/music/musThunderstorm.ogg"); 
	global.musScrapyardsNight 					 = sound_add("sounds/music/musScrapyardsNight.ogg");
	global.musAurora 							 = sound_add("sounds/music/musAurora.ogg");
    
	// SPRITES //
	global.sprGenericTrail      				 = sprite_add("sprites/particles/sprGenericTrail.png", 50,0,50);
	// Meteor Shower:
	global.sprFloor1BNight						 = sprite_add("sprites/areas/events/nightdesert/sprFloor1BNight.png", 4, 2, 2)
	global.sprWindNightEvent					 = sprite_add("sprites/particles/sprWindNightEvent.png", 9, 12, 12)
	global.sprMeteorGlow						 = sprite_add("sprites/particles/sprMeteorGlow.png", 5, 24, 24)
	global.sprMeteorSparkle						 = sprite_add("sprites/particles/sprMeteorSparkle.png", 5, 8, 8)
	global.sprMeteorHit							 = sprite_add("sprites/particles/sprMeteorHit.png", 4, 12, 12)
	// Thunderstorm:
	global.sprFogThunderstorm           		 = sprite_add("sprites/particles/sprFogThunderstorm.png",1,0,0);
	global.sprLightningWarningCircle             = sprite_add("sprites/particles/sprLightningStrikeWarning.png",4,35,45);
	global.sprLightningWarningCircleBlink        = sprite_add("sprites/particles/sprLightningStrikeWarningBlink.png",4,35,45);
	global.sprLightningWarningCircleAce          = sprite_add("sprites/particles/sprLightningStrikeWarningAce.png",4,35,45);
	global.sprLightningWarningCircleBlinkAce     = sprite_add("sprites/particles/sprLightningStrikeWarningBlinkAce.png",4,35,45);
	// Night Scrapyards:
	global.sprFloor3Night						 = sprite_add("sprites/areas/events/nightscrapyards/sprFloor3Night.png", 4, 0, 0)
	global.sprFloor3BNight						 = sprite_add("sprites/areas/events/nightscrapyards/sprFloor3BNight.png", 3, 2, 2)
	global.sprFloor3ExploNight					 = sprite_add("sprites/areas/events/nightscrapyards/sprFloor3ExploNight.png", 4, 1, 1)
	global.sprWall3BotNight						 = sprite_add("sprites/areas/events/nightscrapyards/sprWall3BotNight.png", 4, 0, 0)
	global.sprWall3TopNight						 = sprite_add("sprites/areas/events/nightscrapyards/sprWall3TopNight.png", 4, 0, 0)
	global.sprWall3TransNight					 = sprite_add("sprites/areas/events/nightscrapyards/sprWall3TransNight.png", 3, 0, 0)
	global.sprWall3OutNight						 = sprite_add("sprites/areas/events/nightscrapyards/sprWall3OutNight.png", 3, 4, 12)
	global.sprDebris3Night						 = sprite_add("sprites/areas/events/nightscrapyards/sprDebris3Night.png", 4, 4, 4)
	global.sprDetail3Night						 = sprite_add("sprites/areas/events/nightscrapyards/sprDetail3Night.png", 4, 4, 4)
	global.sprScrapDecalNight					 = sprite_add("sprites/areas/events/nightscrapyards/sprScrapDecalNight.png", 2, 16, 24)
	global.sprTopDecalScrapyardNight			 = sprite_add("sprites/areas/events/nightscrapyards/sprTopDecalScrapyardNight.png", 3, 16, 16)
	global.sprTrapNight							 = sprite_add("sprites/areas/events/nightscrapyards/sprTrapNight.png", 1, 8, 8)
	global.sprTrapScorchMarkNight				 = sprite_add("sprites/areas/events/nightscrapyards/sprTrapScorchMarkNight.png", 1, 32, 32)
	global.sprCarIdleNight						 = sprite_add("sprites/areas/events/nightscrapyards/sprCarIdleNight.png", 1, 16, 16)
	global.sprCarHurtNight						 = sprite_add("sprites/areas/events/nightscrapyards/sprCarHurtNight.png", 3, 16, 16)
	global.sprVenusCarIdleNight					 = sprite_add("sprites/areas/events/nightscrapyards/sprVenusCarIdleNight.png", 1, 16, 16)
	global.sprVenusCarHurtNight					 = sprite_add("sprites/areas/events/nightscrapyards/sprVenusCarHurtNight.png", 3, 16, 16)
	global.sprVenusCarIdleNight					 = sprite_add("sprites/areas/events/nightscrapyards/sprVenusCarIdleNight.png", 1, 16, 16)
	global.sprTiresIdleNight					 = sprite_add("sprites/areas/events/nightscrapyards/sprTiresIdleNight.png", 1, 12, 12)
	global.sprTiresHurtNight					 = sprite_add("sprites/areas/events/nightscrapyards/sprTiresHurtNight.png", 3, 12, 12)
	global.sprTiresDeadNight					 = sprite_add("sprites/areas/events/nightscrapyards/sprTiresDeadNight.png", 3, 12, 12)
	
	// Aurora:
	global.sprFloor5Night			   			 = sprite_add("sprites/areas/events/nightfrozencity/sprFloor5Night.png", 8, 0, 0)	
	global.sprFloor5BNight			   			 = sprite_add("sprites/areas/events/nightfrozencity/sprFloor5BNight.png", 8, 16, 16)
	global.sprSnowFloorNight			   		 = sprite_add("sprites/areas/events/nightfrozencity/sprSnowFloorNight.png", 8, 16, 16)
	global.sprFloor5ExploNight					 = sprite_add("sprites/areas/events/nightfrozencity/sprFloor5ExploNight.png", 4, 1, 1)	
	global.sprWall5BotNight						 = sprite_add("sprites/areas/events/nightfrozencity/sprWall5BotNight.png", 3, 0, 0)	
	global.sprWall5TopNight						 = sprite_add("sprites/areas/events/nightfrozencity/sprWall5TopNight.png", 4, 0, 0)
	global.sprWall5TransNight					 = sprite_add("sprites/areas/events/nightfrozencity/sprWall5TransNight.png", 1, 0, 0)
	global.sprWall5OutNight						 = sprite_add("sprites/areas/events/nightfrozencity/sprWall5OutNight.png", 2, 4, 12)
	global.sprDebris5Night						 = sprite_add("sprites/areas/events/nightfrozencity/sprDebris5Night.png", 4, 4, 4)
	global.sprDetail5Night						 = sprite_add("sprites/areas/events/nightfrozencity/sprDetail5Night.png", 3, 4, 4)
	global.sprIceDecalNight						 = sprite_add("sprites/areas/events/nightfrozencity/sprIceDecalNight.png", 2, 16, 24)
	global.sprTopDecalCityNight					 = sprite_add("sprites/areas/events/nightfrozencity/sprTopDecalCityNight.png", 3, 16, 16)
	global.sprFrozenCarNight					 = sprite_add("sprites/areas/events/nightfrozencity/sprFrozenCarNight.png", 1, 16, 16)
	global.sprFrozenCarHurtNight				 = sprite_add("sprites/areas/events/nightfrozencity/sprFrozenCarHurtNight.png", 3, 16, 16)
	global.sprStreetLightNight					 = sprite_add("sprites/areas/events/nightfrozencity/sprStreetLightNight.png", 1, 12, 37)
	global.sprStreetLightHurtNight				 = sprite_add("sprites/areas/events/nightfrozencity/sprStreetLightHurtNight.png", 3, 12, 37)
	global.sprStreetLightDeadNight				 = sprite_add("sprites/areas/events/nightfrozencity/sprStreetLightDeadNight.png", 3, 12, 37)
	global.sprSnowFlakeNight			   		 = sprite_add("sprites/areas/events/nightfrozencity/sprSnowFlakeNight.png", 3, 4, 4)
	global.sprHydrantNight			   			 = sprite_add("sprites/areas/events/nightfrozencity/sprHydrantNight.png", 1, 12, 12)
	global.sprHydrantHurtNight			   		 = sprite_add("sprites/areas/events/nightfrozencity/sprHydrantHurtNight.png", 3, 12, 12)	
	global.sprHydrantDeadNight			   		 = sprite_add("sprites/areas/events/nightfrozencity/sprHydrantDeadNight.png", 3, 12, 12)	
	global.sprIcicleNight			   			 = sprite_add("sprites/areas/events/nightfrozencity/sprIcicleNight.png", 1, 12, 12)
	global.sprIcicleHurtNight			   		 = sprite_add("sprites/areas/events/nightfrozencity/sprIcicleHurtNight.png", 3, 12, 12)	
	global.sprIcicleDeadNight			   		 = sprite_add("sprites/areas/events/nightfrozencity/sprIcicleDeadNight.png", 4, 12, 12)	
	global.sprNewsStandNight			   		 = sprite_add("sprites/areas/events/nightfrozencity/sprNewsStandNight.png", 1, 12, 16)
	global.sprNewsStandHurtNight			   	 = sprite_add("sprites/areas/events/nightfrozencity/sprNewsStandHurtNight.png", 3, 12, 16)	
	global.sprNewsStandDeadNight			   	 = sprite_add("sprites/areas/events/nightfrozencity/sprNewsStandDeadNight.png", 3, 12, 16)	
	global.sprSodaMachineNight			   		 = sprite_add("sprites/areas/events/nightfrozencity/sprSodaMachineNight.png", 1, 16, 16)
	global.sprSodaMachineHurtNight			   	 = sprite_add("sprites/areas/events/nightfrozencity/sprSodaMachineHurtNight.png", 3, 16, 16)	
	global.sprSodaMachineDeadNight			   	 = sprite_add("sprites/areas/events/nightfrozencity/sprSodaMachineDeadNight.png", 3, 16, 16)
	global.sprSnowManNight			   			 = sprite_add("sprites/areas/events/nightfrozencity/sprSnowManNight.png", 1, 16, 16)
	global.sprSnowManHurtNight			   		 = sprite_add("sprites/areas/events/nightfrozencity/sprSnowManHurtNight.png", 3, 16, 16)	
	global.sprSnowManDeadNight			   		 = sprite_add("sprites/areas/events/nightfrozencity/sprSnowManDeadNight.png", 3, 16, 16)


	// Blizzard:
	global.sprBlizzardFog        				 = sprite_add("sprites/particles/sprBlizzardFog.png",1,12,12);
	global.sprBlizzardSnow         				 = sprite_add("sprites/particles/sprBlizzardSnow.png",1,0,0);
	global.sprBlizzardSnowResprite         		 = sprite_add("sprites/particles/sprBlizzardSnowResprite.png",1,0,0);
	
	
	// OUTPOST / ENTRANCE SPRITES // 
	// Frocity Labs Entrance Terrain:
//	global.sprEntranceSnow     					 = sprite_add("sprites/areas/outpost/entrance/sprEntranceSnow.png",2,48,48);
	global.sprFloorEntranceFrocity      		 = sprite_add("sprites/areas/events/outpost/entrance/sprCityFloorEntrance.png",5,0,0);
	global.sprWallEntranceFrocityBot    		 = sprite_add("sprites/areas/events/outpost/entrance/sprCityWallEntranceBot.png",3,0,0);
	// Frocity Resprite Labs Entrance Terrain:
	global.sprWallEntranceRespriteFrocityBot     = sprite_add("sprites/areas/events/outpost/entrance/sprRespriteCityWallEntranceBot.png",2,0,0);
	// Frocity Night Labs Entrance Terrain:
	global.sprWallEntranceFrocityBotNight    	 = sprite_add("sprites/areas/events/outpost/entrance/sprCityWallEntranceBotNight.png",3,0,0);
	// PROPS //
	// Snowy Terminal
	global.sprTerminalSnow						 = sprite_add("sprites/areas/events/outpost/props/sprTerminalSnow.png", 1, 12, 13);
	global.sprTerminalSnowHurt					 = sprite_add("sprites/areas/events/outpost/props/sprTerminalSnowHurt.png", 3, 12, 13);
	global.sprTerminalSnowDead					 = sprite_add("sprites/areas/events/outpost/props/sprTerminalSnowDead.png", 3, 12, 13);
	// Snowy Round Server
	global.sprRoundServerSnow					 = sprite_add("sprites/areas/events/outpost/props/sprRoundServerSnow.png", 1, 16, 16);
	global.sprRoundServerSnowHurt				 = sprite_add("sprites/areas/events/outpost/props/sprRoundServerSnowHurt.png", 3, 16, 16);
	global.sprRoundServerSnowDead				 = sprite_add("sprites/areas/events/outpost/props/sprRoundServerSnowDead.png", 3, 16, 16);
	
	

	
	// Lightning Thangs
	vertex_format_begin()
	vertex_format_add_position()
	global.lightningformat = vertex_format_end()
	
#macro current_frame_active frac(current_frame) < current_time_scale

	
//#define step

 //  if button_pressed(0,"horn"){
//	repeat(1){
//	AuroraLightController_create(mouse_x,mouse_y);
//	}}

#define draw_dark
	draw_set_color($808080);	
	
	// Half-Darkness Effect:
	if call(scr.event_get_active, "MeteorShower") or (call(scr.event_get_active, "Thunderstorm")) or (call(scr.event_get_active, "ScrapyardsNight")) or call(scr.event_get_active, "Aurora") or call(scr.event_get_active, "Blizzard") {
		draw_rectangle(view_xview_nonsync, view_yview_nonsync, view_xview_nonsync + game_width, view_yview_nonsync + game_width, 0);
	}

#define draw_dark_end
	draw_set_color($000000);
	if global.lightningflash = true { with(instances_matching(CustomProjectile, "name", "Lightning Strike")) draw_circle(x, y, 640 + random(7), false); }
	with(instances_matching(CustomObject, "name", "ei_meteor")) draw_circle(x, y, 20 + random(5), false);
	
#define end_update(_newID)

	if(call(scr.event_get_active, "MeteorShower")) {
		with(instances_matching([Floor, FloorExplo, Wall, Top, TopSmall, Debris, Detail, Bones, prop, TopPot], "ei_meteorshower_check", null)) {
			if(instance_exists(self)) with(self) {
				ei_meteorshower_check = true;
				MeteorShower_sprite_set(object_index);
			}
		}
	}
	
	if(call(scr.event_get_active, "ScrapyardsNight")) {
		with(instances_matching([Floor, FloorExplo, Wall, Top, TopSmall, Debris, Detail, Bones, prop, TopPot, Trap, TrapScorchMark], "ei_scrapyardsnight_check", null)) {
			if(instance_exists(self)) with(self) {
				ei_scrapyardsnight_check = true;
				ScrapyardsNight_sprite_set(object_index);
			}
		}
	}
	
	if(call(scr.event_get_active, "Aurora")) {
		with(instances_matching([Floor, FloorExplo, Wall, Top, TopSmall, Debris, Detail, Bones, prop, TopPot,CarThrow,SnowBotCar], "ei_aurora_check", null)) {
			if(instance_exists(self)) with(self){
				ei_aurora_check = true;
				Aurora_sprite_set(object_index);
			}
		}
	}
	
//#region LABS ENTRANCE

#define LabsEntranceCreate_area
	return [5,"city"];
	
#define LabsEntranceCreate_chance
return (GameCont.subarea == 1)
	
#define LabsEntranceCreate_create
	var	_w          = 3,
		_h          = 3,
		_type       = "",
		_dirOff     = 0,
		_floorDis   = 0,
		_spawnX     = spawn_x,
		_spawnY     = spawn_y,
		_spawnDis   = 128,
		_spawnFloor = FloorNormal;
		
	
	with call(scr.floor_room,_spawnX, _spawnY, _spawnDis, _spawnFloor, _w, _h, _type, _dirOff, _floorDis) {
		var	_myx = x - 16,
	    	_myy = y - 16;
	    			
		// Make Entrance Object:
	mod_script_call('mod', 'LabsEntrance', 'LabsEntrance_create', x, y);
	//EntranceSnow_create(x,y)
	instance_create(x - 32,y - 32,Wall)
	instance_create(x + 16,y - 32,Wall)
	instance_create(x + 16,y + 16,Wall)
	instance_create(x - 32,y + 16,Wall)
	
		// Resprite Floors:
	for(var j = 0; j < array_length(floors); j++){
	with(floors[j]){
			ei_labsentrance_check = true;
	sprite_index = global.sprFloorEntranceFrocity;
	image_index	= irandom(5);
	depth = 10;
		}
	}
}
		// Resprite Walls:
	with(Wall) { 
	if(point_distance(x, y, _myx, _myy) < 72) {
							
		ei_labsentrance_check = true;
	if global.respritemode = true and GameCont.area == 5{
		topspr       = sprWall5Top;
		outspr       = sprWall5Out;
		sprite_index = global.sprWallEntranceRespriteFrocityBot;
	} else { 
	if (call(scr.event_get_active, "Aurora")){
		topspr       = global.sprWall5TopNight;
		outspr       = global.sprWall5OutNight;
		sprite_index = global.sprWallEntranceFrocityBotNight;
	} else { 
	{
		topspr       = sprWall5Top;
		outspr       = sprWall5Out;
		sprite_index = global.sprWallEntranceFrocityBot;
					}  	
				}
			}
		}
	}



//#region DESERT EVENTS

//#region METEOR SHOWER

#define MeteorShower_text
	return "A GIFT FROM THE STARS";

#define MeteorShower_area
	return 1;

#define MeteorShower_chance
	return 0.1;

#define MeteorShower_create

	global.meteorfalls = 0;
	global.maxpickupmeteors = 6 + 3 * GameCont.loops;

	// Set Night Sprites:
	with([Floor, FloorExplo, Wall, Top, TopSmall, Debris, Detail, Bones, prop, TopPot, Bones]) {
		if(instance_exists(self)) with(self) {
			ei_meteorshower_check = true;
			MeteorShower_sprite_set(object_index);
		}
	}
	// Replace Objects:
	with(Cactus){
		instance_create(x,y,NightCactus)    	
        instance_delete(self);
    }
	with(BonePile){
		instance_create(x,y,BonePileNight)    	
        instance_delete(self);
    }
	with(TopDecalDesert){
		instance_create(x,y,TopDecalNightDesert)    	
        instance_delete(self);
    }
    
    sprite_replace(sprWind,"sprites/particles/sprWindNightEvent.png",9) //afaik this is the only way to change the wind sprite without also breaking everything that needs to use it

	with(TopCont) {
		darkness = 1;
	}
	
	background_color = make_color_rgb(106, 122, 175);

#define MeteorShower_cleanup
if global.respritemode = false { sprite_restore(sprWind) } //restores sprite if respritemode is off
#define MeteorShower_step
if (random(35) < current_time_scale) { with instance_random(Floor) { instance_create(x,y,FireFly) } } // you would not believe your eyes

if (random(100) < current_time_scale) { with instance_random(Floor) { Meteor_create(x + 16 ,y + 16) } } //cosmetic meteors

if (random(275) < current_time_scale) and global.meteorfalls < global.maxpickupmeteors { with instance_random(Floor) if distance_to_object(Player) < 160 { PickupMeteor_create(x + 16,y + 16) global.meteorfalls =+ 1} } //cosmetic meteors

#define MeteorShower_sprite_set(_obj)

	switch(_obj) {
		case Floor:
			switch(area_current[0]) {
				default: if(!styleb) sprite_index = sprFloor0;
				if(styleb) sprite_index = global.sprFloor1BNight;
				break;
			}
		break;
		
		case FloorExplo:
			switch(area_current[0]) {
				default: 
					sprite_index = sprFloor0Explo;
				break;
			}
		break;
		
		case Wall:
			switch(area_current[0]) {
				default: 
					sprite_index = sprWall0Bot;
					outspr		 = sprWall0Out;
					topspr       = sprWall0Top;
				break;
			}
		break;
		
		case Top:
			switch(area_current[0]) {
				default: sprite_index = sprWall0Top; break;
			}
		break;
		
		case TopSmall:
			switch(area_current[0]) {
				default: sprite_index = sprWall0Trans; break;
			}
		break;
		
		case Detail:
			sprite_index = sprDetail0;
		break;
		
		case Debris:
			sprite_index = sprDebris0;
		break;
		
		case Bones:
			sprite_index = sprNightBones;
		break;
	}

//#region SEWERS EVENTS

//#region ARCADE

#define Arcade_text
	return choose("SPIN 2 WIN","ROLL THE DICE");
	
#define Arcade_area
	return 2;
	
#define Arcade_chance
	return 0;
	
#define Arcade_create


//#region SCRAPYARD EVENTS

//#region THUNDERSTORM
	
#define Thunderstorm_text
	return choose("STORM A-BREWIN'","THUNDERSTRUCK");

#define Thunderstorm_area
	return 3;

#define Thunderstorm_chance
	return 0.1;

#define Thunderstorm_create

	sound_play_music(global.musThunderstorm)
	
    global.ThunderstormCooldown = 60 //Franes before lightning starts
    
	with(Floor){if(random(25) < 1){instance_create(x,y,LightBeam)}}
	
	with(TopCont) {
		    TopCont.fog = global.sprFogThunderstorm;
		    darkness = 1;
	}

#define Thunderstorm_step

    if global.ThunderstormCooldown > 0 { global.ThunderstormCooldown -= current_time_scale }  // Makes it so you have a bit of time before ligthning starts

    if instance_exists(enemy) and global.ThunderstormCooldown = 0 or instance_exists(RavenFly) and global.ThunderstormCooldown = 0 {  // Activate Thunderstorm
	

	with(Player){repeat(random(30 / instance_number(Player))) { instance_create(x+random_range(-450,450),y+random_range(-250,250), RainDrop)}} //Extra Rain

	if (random(50) < current_time_scale) { with instance_random(Floor) if distance_to_object(ProtoStatue) > 64 and distance_to_object(Player) < 160 { LightningStrikeSpawn_create(x,y) } } //Extra Pain
	
    }
    
#define Thunderstorm_cleanup
sound_play_music(mus3)

//#region NIGHT SCRAPYARDS



#define ScrapyardsNight_text
	return "FIRELIGHT";

#define ScrapyardsNight_area
	return 3;

#define ScrapyardsNight_chance
	return 0.1;

#define ScrapyardsNight_create

if !(call(scr.event_get_active, "Thunderstorm")) { sound_play_music(global.musScrapyardsNight) }

	// Set Night Sprites:
	with([Floor, FloorExplo, Wall, Top, TopSmall, Debris, Detail, prop, TopPot, Bones, TopDecalScrapyard]) {
		if(instance_exists(self)) with(self) {
			ei_scrapyardsnight_check = true;
			ScrapyardsNight_sprite_set(object_index);
		}
	}
    
	with(TopCont) {
		darkness = 1;
	}
	
	background_color = make_color_rgb(83, 85, 119);


#define ScrapyardsNight_sprite_set(_obj)

	switch(_obj) {
		case Floor:
			switch(area_current[0]) {
				default: if(!styleb) sprite_index = global.sprFloor3Night;
				if(styleb) sprite_index = global.sprFloor3BNight;
				break;
			}
		break;
		
		case FloorExplo:
			switch(area_current[0]) {
				default: 
					sprite_index = global.sprFloor3ExploNight;
				break;
			}
		break;
		
		case Wall:
			switch(area_current[0]) {
				default: 
					sprite_index = global.sprWall3BotNight;
					outspr		 = global.sprWall3OutNight;
					topspr       = global.sprWall3TopNight;
				break;
			}
		break;
		
		case Top:
			switch(area_current[0]) {
				default: sprite_index = global.sprWall3TopNight; break;
			}
		break;
		
		case TopSmall:
			switch(area_current[0]) {
				default: sprite_index = global.sprWall3TransNight; break;
			}
		break;
		
		case Detail:
			sprite_index = global.sprDetail3Night;
		break;
		
		case Debris:
			sprite_index = global.sprDebris3Night;
		break;
		
		case Bones:
			sprite_index = global.sprScrapDecalNight;
		break;
		
		case TopDecalScrapyard:
			sprite_index = global.sprTopDecalScrapyardNight;
		break;
		
		case Trap:
			sprite_index = global.sprTrapNight;
		break;
		
		case TrapScorchMark:
			sprite_index = global.sprTrapScorchMarkNight;
		break;
		
		case Tires:
			spr_idle = global.sprTiresIdleNight;
			spr_hurt = global.sprTiresHurtNight;
			spr_dead = global.sprTiresDeadNight;
		break;

		case Car:
			spr_idle = global.sprCarIdleNight;
			spr_hurt = global.sprCarHurtNight;
		break;
		
		case CarVenus:
			spr_idle = global.sprVenusCarIdleNight;
			spr_hurt = global.sprVenusCarHurtNight;
		break;		
		
		
	}
#define ScrapyardsNight_cleanup
sound_play_music(mus3)

//#region FROZEN CITY EVENTS

//#region AURORA

#define Aurora_text
	return choose("PRETTY","SHINING COLORS");

#define Aurora_area
	return 5;

#define Aurora_chance
	return (call(scr.event_get_active, "Blizzard")) ? 0 : 0.1;

#define Aurora_create

	global.currentauroras = 0;
	sound_play_music(global.musAurora)

	// Set Night Sprites:
	with([Floor, FloorExplo, Wall, Top, TopSmall, Debris, Detail, prop, TopPot, Bones, TopDecalCity, SnowFloor,SnowMan,SnowBotCar,CarThrow]) {
		if(instance_exists(self)) with(self) {
			ei_aurora_check = true;
			Aurora_sprite_set(object_index);
		}
	}
    
	with(TopCont) {
		darkness = 1;
	}
	
	background_color = make_color_rgb(77, 73, 127);

#define Aurora_step
//var auroracontrollers = instances_matching(CustomObject, "name", "ei_auroralightcontroller")
var auroracontrollers = instance_find(CustomObject,noone)
						// Pretty!
if (random(70) < current_time_scale) and global.currentauroras < 4 { 
	with instance_random(Floor) if abs(y - CustomObject.y){ 
			
		
		AuroraLightController_create(x,y) global.currentauroras += 1; 
	}}

		
		with(instances_matching(SnowFlake, "ei_aurora_check", null)) {
			if(instance_exists(self)) with(self) {
				ei_aurora_check = true;
				sprite_index = global.sprSnowFlakeNight;
			}
		}
		with(instances_matching(SnowBotCar, "ei_aurora_check", null)) {
			if(instance_exists(self)) with(self) {
				ei_aurora_check = true;
				spr_idle = sprSnowBotCarIdle;
				spr_hurt = sprSnowBotCarHurt;
				spr_walk = sprSnowBotCarWalk;
			}
		}
		with(instances_matching(CarThrow, "ei_aurora_check", null)) {
			if(instance_exists(self)) with(self) {
				ei_aurora_check = true;
				sprite_index = sprFrozenCarThrown;
			}
		}
		
#define AuroraLightController_create(_x,_y)
	with instance_create(_x,_y,CustomObject){
		name = "ei_auroralightcontroller"
		ei_auroralightcontroller = true;
		sprite_index = mskNone;
		
		color1 = choose(c_fuchsia,c_aqua);
		color2 = choose(c_lime,c_blue,c_lime);
		wavespeed = random_range(2500,4500);
		waveheight = random_range(6,12);
		auroraheight = random_range(50,70)
		aurorafade = 0;
		auroracontroller_lifetime = random_range(600,1000)
		aurorabobheight = random_range(10,15)
		aurorabobspeed = random_range(0.01,0.015)
		
		on_step = AuroraLightController_step
		
	}
	
#define AuroraLightController_step

	// Draw Aurora:
	if current_frame_active{
		with script_bind_draw(Aurora_fog,-12){
	    	fadeoutmax = room_speed
	    	fadeout = fadeoutmax
	    	
	    	color1 = other.color1;
	    	color2 = other.color2;
	    	wavespeed = other.wavespeed;
	    	waveheight= other.waveheight;
	    	aurorafade = other.aurorafade;
	    	auroraheight = other.auroraheight;
	    	aurorabobheight = other.aurorabobheight;
	    	aurorabobspeed = other.aurorabobspeed;
	    	x = other.x
	    	y = other.y
				}
			}
			

	// Controller Lifetime:
if auroracontroller_lifetime > 0 { auroracontroller_lifetime -= current_time_scale }
	// Fade In:
if aurorafade < 0.5 and auroracontroller_lifetime > 0 { aurorafade += (0.005 * current_time_scale) }
	// Fade Out:
if aurorafade > 0 and auroracontroller_lifetime <= 0 { aurorafade -= (0.005 * current_time_scale) }
	// Destroy:
if aurorafade <= 0 and auroracontroller_lifetime <= 0 { global.currentauroras -= 1 instance_destroy() }

			
#define Aurora_fog
if instance_exists(self){
var aurorabob = sin(current_frame * aurorabobspeed)*aurorabobheight

draw_primitive_begin(pr_trianglestrip)
    for(i = 10; i<=40; i++){
        draw_vertex_color(view_xview_nonsync+i*30 - 500, y+sin(current_time/wavespeed+i)*waveheight + aurorabob, color1, aurorafade) 
        draw_vertex_color(view_xview_nonsync+i*30 - 500, y+sin(current_time/wavespeed+i)*waveheight + auroraheight + aurorabob, color2, 0) 
        //run whatever code to iterate to next position in the curtain here
    }
draw_primitive_end()

    fadeout -= 50
    
    if !fadeout instance_destroy();
}
		
#define Aurora_sprite_set(_obj)

if "ei_labsentrance_check" not in self {
	switch(_obj) {
		case Floor:
			switch(area_current[0]) {
				default: if(!styleb) sprite_index = global.sprFloor5Night;
				if(styleb) sprite_index = global.sprFloor5BNight;
				break;
			}
		break;
		
		case FloorExplo:
			switch(area_current[0]) {
				default: 
					sprite_index = global.sprFloor5ExploNight;
				break;
			}
		break;
		
		case Wall:
			switch(area_current[0]) {
				default: 
					sprite_index = global.sprWall5BotNight;
					outspr		 = global.sprWall5OutNight;
					topspr       = global.sprWall5TopNight;
				break;
			}
		break;
		
		case Top:
			switch(area_current[0]) {
				default: sprite_index = global.sprWall3TopNight; break;
			}
		break;
		
		case TopSmall:
			switch(area_current[0]) {
				default: sprite_index = global.sprWall5TransNight; break;
			}
		break;
		
		case SnowFloor:
			sprite_index = global.sprSnowFloorNight;
		break;
		
		case Detail:
			sprite_index = global.sprDetail5Night;
		break;
		
		case Debris:
			sprite_index = global.sprDebris5Night;
		break;
		
		case Bones:
			sprite_index = global.sprIceDecalNight;
		break;
		
		case TopDecalCity:
			sprite_index = global.sprTopDecalCityNight;
		break;

		case Car:
			spr_idle = global.sprFrozenCarNight;
			spr_hurt = global.sprFrozenCarHurtNight;
		break;
		
		case StreetLight:
			spr_idle = global.sprStreetLightNight;
			spr_hurt = global.sprStreetLightHurtNight;
			spr_dead = global.sprStreetLightDeadNight;
		break;
		
		case SodaMachine:
			spr_idle = global.sprSodaMachineNight;
			spr_hurt = global.sprSodaMachineHurtNight;
			spr_dead = global.sprSodaMachineDeadNight;
		break;
		
		case SnowMan:
			spr_idle = global.sprSnowManNight;
			spr_hurt = global.sprSnowManHurtNight;
			spr_dead = global.sprSnowManDeadNight;
		break;

		case Hydrant:
		  if (spr_idle = sprHydrant){
			spr_idle = global.sprHydrantNight;
			spr_hurt = global.sprHydrantHurtNight;
			spr_dead = global.sprHydrantDeadNight;
		  }
		  if (spr_idle = sprNewsStand){
			spr_idle = global.sprNewsStandNight;
			spr_hurt = global.sprNewsStandHurtNight;
			spr_dead = global.sprNewsStandDeadNight;
		  }
		  if (spr_idle = sprIcicle){
			spr_idle = global.sprIcicleNight;
			spr_hurt = global.sprIcicleHurtNight;
			spr_dead = global.sprIcicleDeadNight;
		  }
		break;
		
		
		}
	}
	
#define Aurora_cleanup
sound_play_music(mus5)	
	
//#region BLIZZARD
	
#define Blizzard_text
	return choose("SO COLD","THE WIND IS HOWLING");

#define Blizzard_area
	return 5;

#define Blizzard_chance
	return (call(scr.event_get_active, "Aurora")) ? 0 : 0.1;

#define Blizzard_create
	with(TopCont) {
		darkness = 1;
	}
	
#define Blizzard_step
var snowdirection = 190 + sin(current_frame * 0.06)*20

		// Cool Snow: 
with(Player){
	repeat(random(4/instance_number(Player))) { with instance_create(x+random_range(-450,450)+lengthdir_x(300,0),y+random_range(-100,600), SnowFlake){
		if global.respritemode = true { sprite_index = global.sprBlizzardSnowResprite; }
		else{ sprite_index = global.sprBlizzardSnow; }
		direction = snowdirection; 
		speed = 8; 
			}	
		}
	}

if (player_find_local_nonsync() == 0){
	if current_frame_active{
		with script_bind_draw(Blizzard_fog,-12){
	    	fadeoutmax = room_speed
	    	fadeout = fadeoutmax
	    	x = other.x
	    	y = other.y
				}
			}
}

with(SnowFlake){ direction = snowdirection; speed = 8}

#define Blizzard_fog
    draw_set_blend_mode(bm_add)
    draw_sprite_ext(global.sprBlizzardFog,1,view_xview_nonsync + 1000,view_yview_nonsync,160,160,random(360),c_white, 0.75)
    draw_set_blend_mode(bm_normal)
    
    fadeout -= 40
    
    if !fadeout instance_destroy();

//#region EVENT OBJECTS

//#region OUTPOST PROPS

//#define EntranceSnow_create(_x, _y)
//	with(instance_create(_x, _y, Carpet)){
//		sprite_index = global.sprEntranceSnow;
//		if global.respritemode = true { image_index = 1; } 
//		image_speed = 0;
//		depth		= 9;
		
//		return self;
//	}
#define TerminalSnow_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		 // Visual:
		spr_idle = global.sprTerminalSnow;
		spr_hurt = global.sprTerminalSnowHurt;
		spr_dead = global.sprTerminalSnowDead;
		spr_shadow = shd24
		 // Sounds:
		snd_hurt = sndHitMetal;
		snd_dead = sndComputerBreak;
		 // Vars:
		maxhealth = 10;
		my_health = maxhealth;
		
		return self;
	}

#define RoundServerSnow_create(_x, _y)
	with(instance_create(_x, _y, Server)){
		 // Visual:
		spr_idle = global.sprRoundServerSnow;
		spr_hurt = global.sprRoundServerSnowHurt;
		spr_dead = global.sprRoundServerSnowDead;
		
		return self;
	}

//#region LIGHTNING STRIKES

#define LightningStrikeSpawn_create(_x,_y)

	// Check For Ace:
	var foundAce = false;
	 with Player {
	 if (race == "ace") {
	   foundAce = true
	   break
	  }
	}

with instance_create(_x,_y,CustomObject){
	 name				  = "ei_lightningspawn"
     creator    		  = other
     team       		  = 1; 

    sprite_index = global.sprLightningWarningCircle; 
    spr_blink    = global.sprLightningWarningCircleBlink;     	
	if foundAce = true {
    sprite_index = global.sprLightningWarningCircleAce; 
    spr_blink    = global.sprLightningWarningCircleBlinkAce;
	}
    
	 image_speed		  = 0.4;
	 depth      		  = -1;
	 timer      		  = 45;
	 image_xscale		  = 0.1;
	 image_yscale		  = image_xscale;
	 ei_bloomamount 	  = 1.1;
	 ei_bloomtransparency = 0.1;
	 
	 on_step    		  = LightningStrikeSpawn_step;
	 on_destroy 		  = LightningStrikeSpawn_destroy;
	 
}

#define LightningStrikeSpawn_step

if current_frame_active{
with instance_create(x+random_range(-20,20),y+random_range(-20,20),FireFly){sprite_index = sprLightning speed = random(3) direction = random(360) depth = -3 }
if image_xscale < 1 { image_xscale += 0.25; image_yscale = image_xscale }
}

if timer > 0 { timer -= current_time_scale }
if timer < 12{ sprite_index = spr_blink }
//if timer = 20{ call(scr.sound_play_at, x, y, sndIDPDNadeLoad, 1 + random(0.2), 1, 64, 1.5); }
if timer = 0 { instance_destroy() }

#define LightningStrikeSpawn_destroy
LightningStrike_create(x,y)

#define LightningStrike_create(_x,_y)

// Messed with Defpack's lightning strikes for these, big ty for letting me use them

sound_play_pitchvol(sndExplosion,random_range(1.2,1.5),2)
sound_play_pitchvol(sndExplosionS,random_range(0.6,0.8),2)
sound_play_pitchvol(sndLightningPistolUpg,random_range(0.6,0.8),2)
sound_play_pitchvol(sndLightningCannonUpg,random_range(0.7,1.2),2.5)
    with instance_create(_x,_y,CustomProjectile){
        vbuf = vertex_create_buffer()
        lightning_refresh()
        hitid		 = [sprLightningHit,"Lightning Strike"]
        name		 = "Lightning Strike"
        time		 = 4;
        timestart	 = time;
        create_frame = current_frame;
        colors		 = [c_black,c_white,c_white,merge_color(c_white,c_white,.3),c_white]
        wantdust	 = 1;
        damage		 = 100;
        force		 = 40;
        mask_index   = sprPlasmaBall;
        image_xscale = 2.5;
        image_yscale = 2.5;
        on_wall 	 = lightning_wall;
        on_draw      = lightning_draw;
        on_destroy   = lightning_destroy;
        on_cleanup   = lightning_cleanup;
        on_step      = lightning_step;
        on_hit       = lightning_hit;
        depth	     = -8;
        hitlist		 = [];

        return id
    }

#define lightning_wall
with other{
	instance_create(x,y,FloorExplo)
	instance_destroy()
}

#define lightning_draw
d3d_set_fog(1,colors[min((current_frame - create_frame),array_length_1d(colors)-1)], 0,0)
vertex_submit(vbuf, pr_trianglestrip)
d3d_set_fog(0,0,0,0)
for (var i = 0; i < array_length(ypoints); i++){
	draw_sprite(sprLightningHit,1+irandom(2),xpoints[i],ypoints[i])
	//draw_line_width(xpoints[i],ypoints[i],xpoints[i-1],ypoints[i-1],i/10)
}
#define lightning_hit

if array_find_index(hitlist,other) == -1{
array_push(hitlist,other)
with(other){
if instance_is(self,Player){
    switch race{
        case "robot": 
				// Run the script
	trace("hi im robot I havent implemented his effect yet")
	my_health -= 3;
		
    break;
        
    default: 
				// Run the script
    if mod_script_exists("race",race,"race_ei_thunderstruck"){
       mod_script_call_self("race",race,"race_ei_thunderstruck")
    }
           
    else{
        // If script doesn't exist and you arent robot you die
	projectile_hit(self,other.damage,other.force)
	lasthit = [sprLightningHit,"LIGHTNING STRIKE"]
			}
		}
    }
   
	else{
		// If not a player, just kill u
	projectile_hit(self,other.damage,other.force)
	lasthit = [sprLightningHit,"LIGHTNING STRIKE"]
					
		}
	}
}

#define lightning_refresh
ypoints = []
xpoints = []
var mmax = 100;
var mmin = -100;
var xx = x;
var yy = y;

var ang = random_range(70,110)
var width = 0.8, length = 10
var bwidth = .8                 // Thickness
var n = 0
vertex_begin(vbuf, global.lightningformat)
vertex_position(vbuf, xx, yy)
while yy > y - 2*game_height{
    vertex_position(vbuf, xx + width * ((n mod 2) ? -1 : 1), yy)
    n++
    xx += lengthdir_x(length,ang)
    yy += lengthdir_y(length,ang)
    length = random(6)
    width = (y - yy)/75 + bwidth
    ang = clamp(ang + random_range(7,30) * choose(-1,1) * (min((y-yy), 20))/20,40,140)
    if ang = 40 or ang = 140 ang -= random_range(5,20)*sign(ang - 90)
    if !irandom(5) {
        array_push(xpoints,xx)
        array_push(ypoints,yy)
    }
}
vertex_end(vbuf)
vertex_freeze(vbuf)

#define slope(x1,x2,y1,y2)
return((y2-y1)/(x2-x1))

#define lightning_destroy

if global.lightningflash = true {
	with script_bind_draw(lightning_flash,-30){
	    fadeoutmax = room_speed
	    fadeout = fadeoutmax
	}
}

instance_create(x,y,MeltSplat)

for (var i = 1; i < array_length_1d(ypoints); i++){
	if !irandom(4) with instance_create(xpoints[i],ypoints[i],FireFly){
		depth = other.depth
		image_speed/=1.5
		sprite_index = sprLightning
		hspeed += random_range(-.5,.5)
		vspeed += random_range(-.5,.5)
	}
}
lightning_cleanup()

#define lightning_cleanup
vertex_delete_buffer(vbuf)

#define lightning_step
view_shake_max_at(x,y,30)
if wantdust != 0{
    repeat(12){
  		with instance_create(x,y,Dust){
  		  motion_set(random(360),3+random(5))
	    }
  	}
    repeat(8){
        with instance_create(x+random_range(-30,30),y+random_range(-30,30),LightningSpawn){
            image_angle = point_direction(other.x,other.y,x,y) + random_range(-8,8)
        }
    }
  	if instance_exists(Floor){
  	    var closeboy = instance_nearest(x,y,Floor);
      	if point_in_rectangle(x,y,closeboy.x-16,closeboy.y-16,closeboy.x+16,closeboy.y+16){
      	    with instance_create(x,y,Scorchmark){
      	        time = 0;
      	        if fork(){
      	            while instance_exists(self) && time < 45{
      	                time += current_time_scale
      	                image_alpha -= current_time_scale/45
      	                if chance(45 - time){
      	                    with instance_create(x,y,Smoke){
      	                        motion_add(90,random_range(1,2))
      	                        image_xscale = (1-(other.time/45)) * random_range(.5,1)
      	                        image_yscale = image_xscale
      	                        gravity = -friction
      	                    }
      	                }
      	                wait(0)
      	            }
      	            if instance_exists(self) instance_destroy()
      	            exit
      	        }
      	    }
      	}
  	}
  	wantdust = 0
}
time -= current_time_scale
if time <= 0 instance_destroy()


#define lightning_flash
wait(2)
    draw_set_blend_mode(bm_add)
    draw_sprite_ext(sprSuperFlakBullet,1,view_xview_nonsync + game_width/2 ,view_yview_nonsync + game_height/2,100,100,random(360),c_white,fadeout/fadeoutmax*.45)
    draw_set_blend_mode(bm_normal)
    
    fadeout -= 4
    
    if !fadeout instance_destroy();


//#region METEORS
#define PickupMeteor_create(_x, _y)
	with instance_create(_x + random_range(-380, 380), _y - 1000, CustomObject){
		
		name = "ei_meteor"
		
		type = choose("ammo","health")
		
		if type = "ammo"{
		sprite_index		 = sprAmmo;
		sparklecolor		 = $92e6fe;
		glowcolor			 = 47356;
		}
		if type = "health"{
		sprite_index		 = sprHP;
		sparklecolor		 = $91a2ff;
		glowcolor			 = 14588;
		}
		
		image_index 		 = 0;
		image_speed 		 = 0;
		depth				 = -9;
		ei_bloomamount 	     = 1.2;
		ei_bloomtransparency = 0.1;
		target				 = {x: _x, y:_y}
		direction			 = point_direction(x, y, target.x, target.y)
		speed				 = random_range(8,12);
		image_angle 		 = direction;
		on_step			     = PickupMeteor_step;
		on_draw 			 = PickupMeteor_draw;
	}

#define PickupMeteor_step
if current_frame_active{
	
image_angle += 25;

if random(5)<1 {
with instance_create(x + random_range(-10, 10), y + random_range(-10, 10), PlasmaTrail){
	depth		 = other.depth;
	sprite_index = global.sprMeteorSparkle;
	image_blend  = other.sparklecolor;
	image_xscale = random_range(0.5,1);
	image_yscale = image_xscale;
	speed		 = 5;
	friction	 = 0.4;
	direction	 = other.direction;
	}
}

meteor_trail_create()
	
 // When hit ground:
if y > target.y{
	if type = "ammo"{ instance_create(target.x, target.y, AmmoPickup) }
	if type = "health"{ instance_create(target.x, target.y, HPPickup) }
	
	repeat(random_range(7,12)){
	with instance_create(x + random_range(-10, 10), y + random_range(-10, 10), PlasmaTrail){
	depth		 = other.depth;
	sprite_index = global.sprMeteorSparkle;
	image_blend  = other.sparklecolor;
	image_xscale = random_range(0.5,1);
	image_yscale = image_xscale;
	speed		 = random(6);
	friction	 = 0.4;
	direction	 = random(360);
		}
	}
    repeat(random_range(3,5)){
  		with instance_create(x,y,Dust){
  		  motion_set(random(360),3+random(2))
	    }
  	}
	with instance_create(x,y,BulletHit){ sprite_index = global.sprMeteorHit; image_blend  = other.glowcolor; }
	
	sound_play_pitchvol(sndHitWall, random_range(0.5,0.9), 2)
	instance_destroy()
	}
}

#define PickupMeteor_draw
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 1);
draw_set_blend_mode(bm_add);
draw_sprite_ext(global.sprMeteorGlow, current_frame * .4, x, y, 1, 1, image_angle, glowcolor, 0.7);
draw_set_blend_mode(bm_normal);

#define Meteor_create(_x, _y)
	with instance_create(_x + random_range(-380, 380), _y - 1000, CustomObject){
		
		name = "ei_meteor"
		
		type = choose("color1","color2","color3")
		
		if type = "color1"{
		sparklecolor		 = $ffcf2d;
		glowcolor			 = $ffcf2d;
		}
		if type = "color2"{
		sparklecolor		 = $fff171;
		glowcolor			 = $fff171;
		}
		if type = "color3"{
		sparklecolor		 = $e1ff71;
		glowcolor			 = $e1ff71;
		}
		
		image_index 		 = 0;
		image_speed 		 = 0;
		glow_scale		     = random_range(0.6,0.9);
		depth				 = -9;
		ei_bloomamount 	     = 1.2;
		ei_bloomtransparency = 0.1;
		target				 = {x: _x, y:_y}
		direction			 = point_direction(x, y, target.x, target.y)
		speed				 = random_range(8,12);
		image_angle 		 = direction;
		on_step			     = Meteor_step;
		on_draw 			 = Meteor_draw;
	}

#define Meteor_step
if current_frame_active{
	
image_angle += 25;

if random(5)<1 {
with instance_create(x + random_range(-10, 10), y + random_range(-10, 10), PlasmaTrail){
	depth		 = other.depth;
	sprite_index = global.sprMeteorSparkle;
	image_blend  = other.sparklecolor;
	image_xscale = random_range(0.5,1);
	image_yscale = image_xscale;
	speed		 = 5;
	friction	 = 0.4;
	direction	 = other.direction;
	}
}

meteor_trail_create()
	
 // When hit ground:
if y > target.y{
	
	repeat(random_range(5,9)){
	with instance_create(x + random_range(-10, 10), y + random_range(-10, 10), PlasmaTrail){
	depth		 = other.depth;
	sprite_index = global.sprMeteorSparkle;
	image_blend  = other.sparklecolor;
	image_xscale = random_range(0.5,1);
	image_yscale = image_xscale;
	speed		 = random(6);
	friction	 = 0.4;
	direction	 = random(360);
		}
	}
    repeat(random_range(3,5)){
  		with instance_create(x,y,Dust){
  		  motion_set(random(360),3+random(2))
	    }
  	}
	with instance_create(x,y,BulletHit){ sprite_index = global.sprMeteorHit; image_blend  = other.glowcolor; }
	
	sound_play_pitchvol(sndHitWall, random_range(0.5,0.9), 2)
	instance_destroy()
	}
}

#define Meteor_draw
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 1);
draw_set_blend_mode(bm_add);
draw_sprite_ext(global.sprMeteorGlow, current_frame * .4, x, y, glow_scale, glow_scale, image_angle, glowcolor, 0.7);
draw_set_blend_mode(bm_normal);

#define meteor_trail_create

	var _trail = noone
	if "xprev" not in self xprev = x
	if "yprev" not in self yprev = y
    with instance_create(x,y,Wind){
        sprite_index     = global.sprGenericTrail
        mask_index       = mskNone
        image_speed      = 5;
        image_yscale     = (1/25);
        image_xscale     = 1;
        depth			 = -10;
		image_angle 	 = point_direction(x, y, other.xprev, other.yprev)
		image_xscale	 = point_distance(x, y, other.xprev, other.yprev)
		image_blend 	 = other.sparklecolor;
    }
	xprev = x
	yprev = y
	return self
    
	
#define chance(percentage)
return random(100) <= percentage * current_time_scale

#define instance_random(_obj)
	/*
		Returns a random instance of the given object
		Also accepts an array of instances
	*/
	
	var	_inst = instances_matching_ne(_obj, "id", null),
		_size = array_length(_inst);
		
	return (
		(_size > 0)
		? _inst[irandom(_size - 1)]
		: noone
	);
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
    
#macro  scr																						global.scr
#macro  call																					script_ref_call
#macro  area_current																			instance_exists(GameCont) ? [GameCont.area, GameCont.subarea] : [-1, -1] 
#macro  FloorNormal		instances_matching(Floor, "object_index", Floor)