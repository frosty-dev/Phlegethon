/*
dayarea
### This file contains a list of all the areas in your station. Format is as follows:

/area/CATEGORY/OR/DESCRIPTOR/NAME 	(you can make as many subdivisions as you want)
	name = "NICE NAME" 				(not required but makes things really nice)
	icon = "ICON FILENAME" 			(defaults to areas.dmi)
	icon_state = "NAME OF ICON" 	(defaults to "unknown" (blank))
	requires_power = 0 				(defaults to 1)
	music = "music/music.ogg"		(defaults to "music/music.ogg")

NOTE: there are two lists of areas in the end of this file: centcom and station itself. Please maintain these lists valid. --rastaf0

*/


//Phleg day area

//world.timeofday

/area/street
	atmos = 1
	atmosalm = 0
	poweralm = 1
	name = "Street"
	icon = 'areas.dmi'
	icon_state = "street"
	layer = 10
	mouse_opacity = 0
	lightswitch = 1

	luminosity = 0
	ul_Lighting = 1

	area_lights_luminosity = 6	//This gets assigned at area creation. It is used to determine how bright the lights in an area should be. At the time of writing the value that it gets assigned is rand(6,9) - only used for light tubes

	eject = null

	requires_power = 1
	always_unpowered = 0	//this gets overriden to 1 for space in area/New()

	power_equip = 1
	power_light = 1
	power_environ = 1

/area/street/sewers
	name = "Sewers"
	icon = 'areas.dmi'
	icon_state = "street_sewers"

/area/street/building
	name = "Building"
	icon = 'areas.dmi'
	icon_state = "street_building"

/area/street/Entered(mob/living/A as mob)

	var/sound = null
	var/musVolume = 25
	sound = 'ambiatm1.ogg'


	if (ismob(A))

		if (istype(A, /mob/dead/observer)) return
		if (!A:ckey)
			return

		if(istype(A,/mob/living))
			if(!A:lastarea)
				A:lastarea = get_area(A:loc)
			//world << "Entered new area [get_area(A:loc)]"
			var/area/newarea = get_area(A:loc)
		//	var/area/oldarea = A:lastarea

			A:lastarea = newarea

		//if (A:ear_deaf) return

//		if (A && A:client && !A:client:ambience_playing && !A:client:no_ambi) // Ambience goes down here -- make sure to list each area seperately for ease of adding things in later, thanks! Note: areas adjacent to each other should have the same sounds to prevent cutoff when possible.- LastyScratch
//			A:client:ambience_playing = 1
//			A << sound('shipambience.ogg', repeat = 1, wait = 0, volume = 35, channel = 2)

		switch(daypart)
			if ("dawn","morning") sound = pick("morning1.ogg","morning2.ogg",'a_morning.ogg')
			if ("noon","afternoon") sound = pick('crow1.ogg','crow2.ogg','crow3.ogg','crow4.ogg','crow5.ogg','crow6.ogg','a_day.ogg','a_day1.ogg','wind1.ogg')
			if ("dusk") sound = pick('a_dusk.ogg','a_dusk1.ogg','wind1.ogg','wind5.ogg','wind6.ogg')
			if ("evening") sound = pick('a_evening.ogg','a_evening1.ogg','wind1.ogg','wind2.ogg','wind3.ogg','wind4.ogg','wind5.ogg','wind6.ogg')
			if ("night") sound = pick('night1.ogg','night2.ogg','night3.ogg','night4.ogg','night5.ogg',)
			else
				sound = pick('ambigen3.ogg','ambigen4.ogg','ambigen5.ogg','ambigen6.ogg','ambigen7.ogg','ambigen8.ogg','ambigen9.ogg','ambigen10.ogg','ambigen11.ogg','ambigen12.ogg')


		if (prob(45)) //35
			if(A && A:client && !A:client:played)
				A << sound(sound, repeat = 0, wait = 0, volume = musVolume, channel = 1)
				A:client:played = 1
				spawn(600)
					if(A && A:client)
						A:client:played = 0
		return

//area/street/proc/coolnight(A)
	var/obj/item/W
	if(istype(A,/mob/living/carbon/human))
		if(W == A:w_uniform)
			switch(daypart)
				if("evening")
					A.bodytemperature -= 0.5
				if("night")
					A.bodytemperature -= 3
		if(W == A:shoes)
			switch(daypart)
				if("evening")
					A.bodytemperature -= 0.5
				if("night")
					A.bodytemperature -= 2
		if(W == A:wear_suit)
			switch(daypart)
				if("evening")
					A.bodytemperature -= 0.5
				if("night")
					A.bodytemperature -= 2
		if(W == A:head)
			switch(daypart)
				if("evening")
					A.bodytemperature -= 0.1
				if("night")
					A.bodytemperature -= 1
		return

/obj/machinery/light/sunlight
	name = "sunlight"
	icon = 'lighting.dmi'
	icon_state = "sunlight"
	desc = "Its light."
	anchored = 1
	base_state = "sunlight"
//	fitting = "sunlight"
	mouse_opacity = 0
	layer = 3
	active_power_usage = 0
	on = 1					// 1 if on, 0 if off

	New()
		..()
		invisibility = 101
	//	sleep(rand(1,10))
		for()
			src.ul_SetLuminosity(6,6,5)
			daypart = "noon"
			sleep(2400)
			src.ul_SetLuminosity(7,7,6)
			daypart = "afternoon"
			sleep(2400)
			src.ul_SetLuminosity(6,5,5)
			daypart = "afternoon"
			sleep(2400)

			src.ul_SetLuminosity(4,3,2)
			daypart = "dusk"
			sleep(2400)
			src.ul_SetLuminosity(3,2,1)
			daypart = "dusk"
			sleep(2400)
			src.ul_SetLuminosity(2,1,0)
			daypart = "evening"
			sleep(2400)
			src.ul_SetLuminosity(0,1,1)
			daypart = "evening"
			sleep(2400)

			src.ul_SetLuminosity(0,0,1)
			daypart = "night"
			sleep(2400)

			src.ul_SetLuminosity(1,1,0)
			daypart = "dawn"
			sleep(2400)
			src.ul_SetLuminosity(2,2,1)
			daypart = "morning"
			sleep(2400)
			src.ul_SetLuminosity(3,3,2)
			daypart = "morning"
			sleep(2400)
			src.ul_SetLuminosity(4,5,4)
			daypart = "morning"
			sleep(2400)
/*
/obj/machinery/light/sunlight/proc/daypassing()
//phleg

//	var/showstart = pick(0, 1440, 2880, 4320)
	var/areatime = world.time+1000// + showstart

	switch(areatime)
		if(0 to 1440)	//0000-0600
			luminosity = 0

		if(1440 to 1680)	//0600-7000
			luminosity = 1

		if(1680 to 1920)	//0700-0800
			luminosity = 2

		if(1920 to 2160)	//0800-0900
			luminosity = 3

		if(2160 to 2400)	//0900-1000
			luminosity = 4

		if(2400 to 2640)	//1000-1100
			luminosity = 5

		if(2640 to 4320)	//1100-1800
			luminosity = 6

		if(4320 to 4560)	//1800-1900
			luminosity = 5

		if(4560 to 4800)	//1900-2000
			luminosity = 4

		if(4800 to 5040)	//2100-2200
			luminosity = 3

		if(5040 to 5280)	//2200-2300
			luminosity = 2

		if(5280 to 5520)	//2300-0000
			luminosity = 1

		else
			areatime = 0

*/
