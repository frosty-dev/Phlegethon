/**********************Mineral deposits**************************/

/turf/simulated/mineral //wall piece
	name = "Rock"
	icon = 'walls.dmi'
	icon_state = "rock"
	oxygen = 0
	nitrogen = 0
	opacity = 1
	density = 1
	blocks_air = 1
	temperature = TCMB
	var/mineralName = ""
	var/mineralAmt = 0
	var/spread = 0 //will the seam spread?
	var/spreadChance = 0 //the percentual chance of an ore spreading to the neighbouring tiles
	var/artifactChance = 0.3	//percent chance to spawn a xenoarchaelogical artifact

/turf/simulated/mineral/Del()
	return

/turf/simulated/mineral/ex_act(severity)
	switch(severity)
		if(3.0)
			return
		if(2.0)
			if (prob(70))
				src.mineralAmt -= 1 //some of the stuff gets blown up
				src.gets_drilled()
		if(1.0)
			src.mineralAmt -= 2 //some of the stuff gets blown up
			src.gets_drilled()
	return

/turf/simulated/mineral/New()

	spawn(1)
		var/turf/T
		if((istype(get_step(src, NORTH), /turf/simulated/floor)) || (istype(get_step(src, NORTH), /turf/space)) || (istype(get_step(src, NORTH), /turf/simulated/shuttle/floor)))
			T = get_step(src, NORTH)
			if (T)
				T.overlays += image('walls.dmi', "rock_side_s")
		if((istype(get_step(src, SOUTH), /turf/simulated/floor)) || (istype(get_step(src, SOUTH), /turf/space)) || (istype(get_step(src, SOUTH), /turf/simulated/shuttle/floor)))
			T = get_step(src, SOUTH)
			if (T)
				T.overlays += image('walls.dmi', "rock_side_n", layer=6)
		if((istype(get_step(src, EAST), /turf/simulated/floor)) || (istype(get_step(src, EAST), /turf/space)) || (istype(get_step(src, EAST), /turf/simulated/shuttle/floor)))
			T = get_step(src, EAST)
			if (T)
				T.overlays += image('walls.dmi', "rock_side_w", layer=6)
		if((istype(get_step(src, WEST), /turf/simulated/floor)) || (istype(get_step(src, WEST), /turf/space)) || (istype(get_step(src, WEST), /turf/simulated/shuttle/floor)))
			T = get_step(src, WEST)
			if (T)
				T.overlays += image('walls.dmi', "rock_side_e", layer=6)

	if (mineralName && mineralAmt && spread && spreadChance)
		if(prob(spreadChance))
			if(istype(get_step(src, SOUTH), /turf/simulated/mineral/random))
				new src.type(get_step(src, SOUTH))
		if(prob(spreadChance))
			if(istype(get_step(src, NORTH), /turf/simulated/mineral/random))
				new src.type(get_step(src, NORTH))
		if(prob(spreadChance))
			if(istype(get_step(src, WEST), /turf/simulated/mineral/random))
				new src.type(get_step(src, WEST))
		if(prob(spreadChance))
			if(istype(get_step(src, EAST), /turf/simulated/mineral/random))
				new src.type(get_step(src, EAST))
	return

/turf/simulated/mineral/random
	name = "Mineral deposit"
	var/mineralAmtList = list("Uranium" = 5, "Iron" = 5, "Diamond" = 5, "Gold" = 5, "Silver" = 5, "Plasma" = 5, "Archaeo" = 3/*, "Adamantine" = 5*/)
	var/mineralSpawnChanceList = list("Uranium" = 5, "Iron" = 50, "Diamond" = 1, "Gold" = 5, "Silver" = 5, "Plasma" = 25, "Archaeo" = 5/*, "Adamantine" =5*/)//Currently, Adamantine won't spawn as it has no uses. -Durandan
	var/mineralChance = 10  //means 10% chance of this plot changing to a mineral deposit

/turf/simulated/mineral/random/New()
	..()
	if (prob(mineralChance))
		var/mName = pickweight(mineralSpawnChanceList) //temp mineral name

		if (mName)
			var/turf/simulated/mineral/M
			switch(mName)
				if("Uranium")
					M = new/turf/simulated/mineral/uranium(src)
				if("Iron")
					M = new/turf/simulated/mineral/iron(src)
				if("Diamond")
					M = new/turf/simulated/mineral/diamond(src)
				if("Gold")
					M = new/turf/simulated/mineral/gold(src)
				if("Silver")
					M = new/turf/simulated/mineral/silver(src)
				if("Plasma")
					M = new/turf/simulated/mineral/plasma(src)
				if("Archaeo")
					M = new/turf/simulated/mineral/archaeo(src)
				/*if("Adamantine")
					M = new/turf/simulated/mineral/adamantine(src)*/
			if(M)
				src = M
				M.levelupdate()
	else if (prob(artifactChance))
		//spawn a rare, xeno-arch artifact here
		new/obj/machinery/artifact(src)
	return

/turf/simulated/mineral/random/high_chance
	mineralChance = 25
	mineralSpawnChanceList = list("Uranium" = 10, "Iron" = 30, "Diamond" = 2, "Gold" = 10, "Silver" = 10, "Plasma" = 25, "Archaeo" = 2)

/turf/simulated/mineral/random/Del()
	return

/turf/simulated/mineral/uranium
	name = "Uranium deposit"
	icon_state = "rock_Uranium"
	mineralName = "Uranium"
	mineralAmt = 5
	spreadChance = 10
	spread = 1



/turf/simulated/mineral/iron
	name = "Iron deposit"
	icon_state = "rock_Iron"
	mineralName = "Iron"
	mineralAmt = 5
	spreadChance = 25
	spread = 1


/turf/simulated/mineral/diamond
	name = "Diamond deposit"
	icon_state = "rock_Diamond"
	mineralName = "Diamond"
	mineralAmt = 5
	spreadChance = 10
	spread = 1


/turf/simulated/mineral/gold
	name = "Gold deposit"
	icon_state = "rock_Gold"
	mineralName = "Gold"
	mineralAmt = 5
	spreadChance = 10
	spread = 1


/turf/simulated/mineral/silver
	name = "Silver deposit"
	icon_state = "rock_Silver"
	mineralName = "Silver"
	mineralAmt = 5
	spreadChance = 10
	spread = 1


/turf/simulated/mineral/plasma
	name = "Plasma deposit"
	icon_state = "rock_Plasma"
	mineralName = "Plasma"
	mineralAmt = 5
	spreadChance = 25
	spread = 1


/turf/simulated/mineral/archaeo
	name = "Strange rock formation"
	icon_state = "rock_Archaeo"
	mineralName = "Archaeo"
	mineralAmt = 3
	spreadChance = 25
	spread = 1


/turf/simulated/mineral/clown
	name = "Bananium deposit"
	icon_state = "rock_Clown"
	mineralName = "Clown"
	mineralAmt = 3
	spreadChance = 0
	spread = 0


/turf/simulated/mineral/ReplaceWithFloor()
	if(!icon_old) icon_old = icon_state
	var/turf/simulated/floor/plating/airless/asteroid/W
	var/old_dir = dir

	for(var/direction in cardinal)
		for(var/obj/effect/glowshroom/shroom in get_step(src,direction))
			if(!shroom.floor) //shrooms drop to the floor
				shroom.floor = 1
				shroom.icon_state = "glowshroomf"
				shroom.pixel_x = 0
				shroom.pixel_y = 0

	W = new /turf/simulated/floor/plating/airless/asteroid( locate(src.x, src.y, src.z) )
	W.dir = old_dir
	W.fullUpdateMineralOverlays()

	/*
	W.icon_old = old_icon
	if(old_icon) W.icon_state = old_icon
	*/
	W.opacity = 1
	W.ul_SetOpacity(0)
	W.ul_Recalculate()
	W.levelupdate()
	return W


/turf/simulated/mineral/attackby(obj/item/weapon/W as obj, mob/user as mob)

	if (!(istype(usr, /mob/living/carbon/human) || ticker) && ticker.mode.name != "monkey")
		usr << "\red You don't have the dexterity to do this!"
		return

	if (istype(W, /obj/item/weapon/pickaxe))
		var/turf/T = user.loc
		if (!( istype(T, /turf) ))
			return
/*
	if (istype(W, /obj/item/weapon/pickaxe/radius))
		var/turf/T = user.loc
		if (!( istype(T, /turf) ))
			return
*/
//Watch your tabbing, microwave. --NEO

		if(istype(W, /obj/item/weapon/pickaxe/excavationtool))
			user << "\red You carefully start clearing away the rock."
			playsound(user, 'sound/weapons/Genhit.ogg', 20, 1)

			if(do_after(user,W:digspeed))
				user << "\blue You finish clearing away the rock."
				gets_drilled(1)
		else
			user << "\red You start picking."
			playsound(user, 'sound/weapons/Genhit.ogg', 20, 1)

			if(do_after(user,W:digspeed))
				user << "\blue You finish cutting into the rock."
				gets_drilled()

	else
		return attack_hand(user)
	return

/turf/simulated/mineral/proc/gets_drilled(var/delicate = 0)
	var/destroyed = 0
	if ((src.mineralName != "") && (src.mineralAmt > 0) && (src.mineralAmt < 11))
		var/i
		for (i=0;i<mineralAmt;i++)
			if (src.mineralName == "Uranium")
				new /obj/item/weapon/ore/uranium(src)
			if (src.mineralName == "Iron")
				new /obj/item/weapon/ore/iron(src)
			if (src.mineralName == "Gold")
				new /obj/item/weapon/ore/gold(src)
			if (src.mineralName == "Silver")
				new /obj/item/weapon/ore/silver(src)
			if (src.mineralName == "Plasma")
				new /obj/item/weapon/ore/plasma(src)
			if (src.mineralName == "Diamond")
				new /obj/item/weapon/ore/diamond(src)
			if (src.mineralName == "Archaeo")
				//spawn strange rocks here
				if(prob(10) || delicate)
					new /obj/item/weapon/ore/strangerock(src)
				else
					destroyed = 1
			if (src.mineralName == "Clown")
				new /obj/item/weapon/ore/clown(src)
	if (prob(src.artifactChance))
		//spawn a rare, xeno-archaelogical artifact here
		new /obj/machinery/artifact(src)
	ReplaceWithFloor()
	if(destroyed)
		usr << "\red You destroy some of the rocks!"
	return

/*
/turf/simulated/mineral/proc/setRandomMinerals()
	var/s = pickweight(list("uranium" = 5, "iron" = 50, "gold" = 5, "silver" = 5, "plasma" = 50, "diamond" = 1))
	if (s)
		mineralName = s

	var/N = text2path("/turf/simulated/mineral/[s]")
	if (N)
		var/turf/simulated/mineral/M = new N
		src = M
		if (src.mineralName)
			mineralAmt = 5
	return*/


/**********************Asteroid**************************/

/turf/simulated/floor/plating/airless/asteroid //floor piece
	name = "Asteroid"
	icon = 'floors.dmi'
	icon_state = "asteroid"
	oxygen = 0.01
	nitrogen = 0.01
	temperature = TCMB
	icon_plating = "asteroid"
	var/dug = 0       //0 = has not yet been dug, 1 = has already been dug

/turf/simulated/floor/plating/airless/asteroid/New()
	var/proper_name = name
	..()
	name = proper_name
	//if (prob(50))
	//	seedName = pick(list("1","2","3","4"))
	//	seedAmt = rand(1,4)
	if(prob(20))
		icon_state = "asteroid[rand(0,12)]"
	spawn(2)
		updateMineralOverlays()

/turf/simulated/floor/plating/airless/asteroid/ex_act(severity)
	return

/turf/simulated/floor/plating/airless/asteroid/attackby(obj/item/weapon/W as obj, mob/user as mob)

	if(!W || !user)
		return 0

	if ((istype(W, /obj/item/weapon/shovel)))
		var/turf/T = user.loc
		if (!( istype(T, /turf) ))
			return

		if (dug == 1)
			user << "\red This area has already been dug"
			return

		user << "\red You start digging."
		playsound(src.loc, 'rustle1.ogg', 50, 1) //russle sounds sounded better

		sleep(40)
		if ((user.loc == T && user.equipped() == W) && !dug)
			user << "\blue You dug a hole."
			gets_dug()
			dug = 1
			icon_plating = "asteroid_dug"
			icon_state = "asteroid_dug"
			return
		else
			return
	else
		..(W,user)
	if ((istype(W,/obj/item/weapon/pickaxe/drill)))
		var/turf/T = user.loc
		if (!( istype(T, /turf) ))
			return

		if (dug == 1)
			user << "\red This area has already been dug."
			return

		user << "\red You start digging."
		playsound(src.loc, 'rustle1.ogg', 50, 1) //russle sounds sounded better

		sleep(30)
		if ((user.loc == T && user.equipped() == W))
			user << "\blue You dug a hole."
			gets_dug()
			dug = 1
			icon_plating = "asteroid_dug"
			icon_state = "asteroid_dug"
			return
		else
			return
	else
		..(W,user)

	if ((istype(W,/obj/item/weapon/pickaxe/diamonddrill)) || (istype(W,/obj/item/weapon/pickaxe/borgdrill)))
		var/turf/T = user.loc
		if (!( istype(T, /turf) ))
			return

		if (dug == 1)
			user << "\red This area has already been dug."
			return

		user << "\red You start digging."
		playsound(src.loc, 'rustle1.ogg', 50, 1) //russle sounds sounded better

		sleep(0)
		if ((user.loc == T && user.equipped() == W))
			user << "\blue You dug a hole."
			gets_dug()
			dug = 1
			icon_plating = "asteroid_dug"
			icon_state = "asteroid_dug"
			return
		else
			return
	else
		..(W,user)

	return

/turf/simulated/floor/plating/airless/asteroid/proc/gets_dug()
	new/obj/item/weapon/ore/glass(src)
	new/obj/item/weapon/ore/glass(src)
	new/obj/item/weapon/ore/glass(src)
	new/obj/item/weapon/ore/glass(src)
	new/obj/item/weapon/ore/glass(src)
	return

/turf/simulated/floor/plating/airless/asteroid/proc/updateMineralOverlays()

	src.overlays = null

	if(istype(get_step(src, NORTH), /turf/simulated/mineral))
		src.overlays += image('walls.dmi', "rock_side_n")
	if(istype(get_step(src, SOUTH), /turf/simulated/mineral))
		src.overlays += image('walls.dmi', "rock_side_s", layer=6)
	if(istype(get_step(src, EAST), /turf/simulated/mineral))
		src.overlays += image('walls.dmi', "rock_side_e", layer=6)
	if(istype(get_step(src, WEST), /turf/simulated/mineral))
		src.overlays += image('walls.dmi', "rock_side_w", layer=6)


/turf/simulated/floor/plating/airless/asteroid/proc/fullUpdateMineralOverlays()
	var/turf/simulated/floor/plating/airless/asteroid/A
	if(istype(get_step(src, WEST), /turf/simulated/floor/plating/airless/asteroid))
		A = get_step(src, WEST)
		A.updateMineralOverlays()
	if(istype(get_step(src, EAST), /turf/simulated/floor/plating/airless/asteroid))
		A = get_step(src, EAST)
		A.updateMineralOverlays()
	if(istype(get_step(src, NORTH), /turf/simulated/floor/plating/airless/asteroid))
		A = get_step(src, NORTH)
		A.updateMineralOverlays()
	if(istype(get_step(src, NORTHWEST), /turf/simulated/floor/plating/airless/asteroid))
		A = get_step(src, NORTHWEST)
		A.updateMineralOverlays()
	if(istype(get_step(src, NORTHEAST), /turf/simulated/floor/plating/airless/asteroid))
		A = get_step(src, NORTHEAST)
		A.updateMineralOverlays()
	if(istype(get_step(src, SOUTHWEST), /turf/simulated/floor/plating/airless/asteroid))
		A = get_step(src, SOUTHWEST)
		A.updateMineralOverlays()
	if(istype(get_step(src, SOUTHEAST), /turf/simulated/floor/plating/airless/asteroid))
		A = get_step(src, SOUTHEAST)
		A.updateMineralOverlays()
	if(istype(get_step(src, SOUTH), /turf/simulated/floor/plating/airless/asteroid))
		A = get_step(src, SOUTH)
		A.updateMineralOverlays()
	src.updateMineralOverlays()