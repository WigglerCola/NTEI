#define init
	global.addchest = false
	global.sprPartyChest = sprite_add_weapon("../../sprites/modcompat/defpack/sprPartyChest.png", 8, 8);
	global.sprPartyChestOpen = sprite_add("../../sprites/modcompat/defpack/sprPartyChestOpen.png", 1, 8, 8);
	
//this doens't work.
#define step
	if(global.addchest == false && mod_exists("mod", "chest")){
		global.addchest = true
		wait(30)
		chestmap = mod_variable_get("mod", "chest", "chests")

		//Party Chest (new)
		chestmap[? "Party"] = {
		name : "Party",
		spr_idle : global.sprPartyChest,
		spr_open : global.sprPartyChestOpen,
		weps : ["PartyGun","PartyMinigun","CandleBarrage","CandleMinigun","CandlePistol","CandleRifle"],
		difficulty : 1
		}
		
		
		trace("BALLSWIDE CHEST COMPAT EXTREME")
	}

