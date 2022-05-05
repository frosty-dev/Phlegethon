/obj/structure/thermal/pipe
	name = "Thermal pipe."
	desc = "."
//	icon
//	icon_state
	var/list/connected = list()
	var/list/dirs = list()
	New()
		Avail_Dir()
		..()

	Del()
		..()

/obj/structure/thermal/pipe/proc/Near_Pipe()
	if(dir == 1 || dir == 2)
		var/turf/M = get_step(src, NORTH)
		var/check = 0
		for(var/obj/structure/thermal/pipe/P in M)
			if(SOUTH & P.dirs)
				check++
				connected += P
		if(check > 1)
			world << "Bag in network in ([x],[y],[z])."
		check = 0

		var/turf/M = get_step(src, SOUTH)
		for(var/obj/structure/thermal/pipe/P in M)
			if(NORTH & P.dirs)
				check++
				connected += P
		if(check > 1)
			world << "Bag in network in ([x],[y],[z])."

	else if(dir == 4 || dir == 8)
		var/turf/M = get_step(src, EAST)
		var/check = 0
		for(var/obj/structure/thermal/pipe/P in M)
			if(WEST & P.dirs)
				check++
				connected += P
		if(check > 1)
			world << "Bag in network in ([x],[y],[z])."
		check = 0

		var/turf/M = get_step(src, WEST)
		for(var/obj/structure/thermal/pipe/P in M)
			if(EAST & P.dirs)
				check++
				connected += P
		if(check > 1)
			world << "Bag in network in ([x],[y],[z])."

/obj/structure/thermal/pipe/proc/Avail_Dir()
	if(dir == 1 || dir == 2)
		dirs |= SOUTH
		dirs |= NORTH
	else if(dir == 4 || dir == 8)
		dirs |= EAST
		dirs |= WEST
