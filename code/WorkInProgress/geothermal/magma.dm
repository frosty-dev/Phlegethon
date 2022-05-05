#define MAGMA_MASS_FOR_FLOOD  30
#define MAGMA_MASS_MOD        1
#define MAGMA_DAMAGE    	  400
#define MAGMA_MAX_TEMP        1000
#define MAGMA_TEMP      	  500
#define MAGMA_LESS_TEMP       200
#define MAGMA_CHECK_TEMP      10
#define MAGMA_TEMP_MOD        2
#define MAGMA_CAN_PASS_HARD   0
#define MAGMA_FOR_DESTROY     300

var/list/cant_melt = list(/obj/machinery/power/apc, /obj/machinery/alarm, /obj/machinery/light)
var/list/hard_melt = list(/obj/structure/window)

/obj/structure/thermal/magma
	name = "Magma"
	desc = "."
	icon = 'thermal.dmi'
	icon_state = "magma_1"
	var/inner = 0
	var/mass  = 1
	var/tick  = 0
	var/temp_calc = 0
	var/list/obj/protected = list()
	temp = MAGMA_TEMP

	New()
		var/turf/simulated/place = src.loc
		if(!istype(place, /turf/simulated))
			del(src)
			return
		processing_objects.Add(src)
		temp += rand(-100,100)
		place.thermal += src
		master = place
		Melt()
		near = NearMagma()
		AddNearMagma()
		if((IsEven(x) && IsEven(y)) || (IsOdd(x) && IsOdd(y)))
			temp_calc = 1
		update_icon()
		..()

	Del()
		processing_objects.Remove(src)
		NearMagmaIfDel()
		var/turf/simulated/place = src.loc
		place.thermal -= src
		..()

	process()
		if(debug)
			world << "Processing magma in ([x],[y],[z])."
		if(mass >= MAGMA_MASS_FOR_FLOOD)
			src.Flood()
		if(protected)
			if(mass >= MAGMA_FOR_DESTROY)
				for(var/O in protected)
					del(O)
		mass += (near + 1) * MAGMA_MASS_MOD
		if(tick >= MAGMA_CHECK_TEMP)
			Temp_Up()
			if(temp_calc)
				Temp_Share()
			tick = 0
		Check_Health()
		if(debug)
			world << "Magma stats: mass([mass]), near([near]), temp([temp]), tick([tick]), inner([inner]), temp_calc([temp_calc])."
		tick++

/obj/structure/thermal/magma/proc/NearMagma()
	var/count = 0
	for(var/d in cardinal)
		var/turf/simulated/M = get_step(src, d)
		if(M.hasMagma())
			count++
	return count

/obj/structure/thermal/magma/proc/AddNearMagma()
	for(var/d in cardinal)
		var/turf/D = get_step(src, d)
		if(istype(D,/turf/simulated))
			var/turf/simulated/M = D
			if(M.hasMagma())
				var/obj/structure/thermal/magma/T = locate(/obj/structure/thermal/magma) in M.thermal
				T.near++

/obj/structure/thermal/magma/proc/NearMagmaIfDel()
	for(var/d in cardinal)
		var/turf/D = get_step(src, d)
		if(istype(D,/turf/simulated))
			var/turf/simulated/M = D
			if(M.hasMagma())
				var/obj/structure/thermal/magma/T = locate(/obj/structure/thermal/magma) in M.thermal
				T.near--

/obj/structure/thermal/magma/proc/Flood()
	if(inner)
		return
	var/list/turf/simulated/floor/FreeSpace = list()
	var/list/turf/simulated/wall/HardSpace = list()
	for(var/d in cardinal)
		var/turf/D = get_step(src, d)
		if(istype(D,/turf/simulated))
			var/turf/simulated/M = D
			if(!M.hasMagma())
				if(istype(M, /turf/simulated/wall))
					HardSpace += M
				else if(istype(M, /turf/simulated/floor))
					FreeSpace += M
	if(isemptylist(FreeSpace) && isemptylist(HardSpace))
		src.inner = 1
		return

	if(isemptylist(FreeSpace))
		if(MAGMA_CAN_PASS_HARD)
			new /obj/structure/thermal/magma (pick(HardSpace))
		else
			src.inner = 1
	else
		var/turf/simulated/S = pick(FreeSpace)
		var/check = 1
		if(!master.ZAirPass(S))
			for(var/obj/structure/window/W in S)
				if(get_dir(W.loc, src.loc) == dir)
					if(mass >= MAGMA_FOR_DESTROY)
						del(W)
						check = 1
					else
						check = 0
			for(var/obj/structure/window/W in master)
				if(get_dir(src.loc, W.loc) == dir)
					if(mass >= MAGMA_FOR_DESTROY)
						del(W)
						check = 1
					else
						check = 0
			if(S.HasDoor(master))
				for(var/obj/machinery/door/D)
					if(mass >= MAGMA_FOR_DESTROY)
						del(D)
						check = 1
			if(check)
				new /obj/structure/thermal/magma (S)
		else
			new /obj/structure/thermal/magma (S)
	src.mass -= MAGMA_MASS_FOR_FLOOD + 1
	return

/obj/structure/thermal/magma/proc/Melt()
	for(var/obj/O in src.loc)
		if(O != src)
			if(!(O.type in cant_melt))
				if(!(O.type in hard_melt))
					del(O)
				else if(src.mass >= MAGMA_FOR_DESTROY)
					del(O)
				else
					protected += O
	for(var/mob/living/O in src.loc)
		O.apply_damage(MAGMA_DAMAGE, "fire")
//	new /turf/simulated/floor/planting(src.loc)

/obj/structure/thermal/magma/proc/Temp_Up()
	var/datum/gas_mixture/enviroment = master.return_air()
	if(enviroment.temperature < temp)
		var/datum/gas_mixture/removed = enviroment.remove(enviroment.total_moles())
		if(removed)
			removed.temperature = temp
		enviroment.merge(removed)
	if(temp < MAGMA_MAX_TEMP)
		temp += min(MAGMA_MAX_TEMP - temp,near + 1)

/obj/structure/thermal/magma/proc/Check_Health()
	if(temp <= MAGMA_LESS_TEMP || mass <= 0)
		del(src)
	return

/obj/structure/thermal/magma/proc/Temp_Share()
	var/count = 1
	var/term  = temp
	var/list/magma = list(src)
	for(var/d in cardinal)
		var/turf/D = get_step(src, d)
		if(!istype(D,/turf/simulated))
			return
		var/turf/simulated/M = D
		if(M.hasMagma())
			count++
			term += M.thermal.temp
			magma += M.thermal
	var/diff = term/count

	for(var/obj/structure/thermal/magma/M in magma)
		if(M.temp != diff)
			M.temp = M.temp - (M.temp - diff)/MAGMA_TEMP_MOD
			M.update_icon()

/obj/structure/thermal/magma/proc/Check_Water()
	var/turf/simulated/W = src.loc
	if(W.hasWater())
		var/obj/structure/thermal/water/B = locate(/obj/structure/thermal/water) in W.thermal
		B.Check_Magma()
	return

/obj/structure/thermal/magma/update_icon()
	if(temp >= 200 && temp <= 400)
		icon_state = "magma_1"
		return
	if(temp > 400 && temp <= 600)
		icon_state = "magma_2"
		return
	if(temp > 600 && temp <= 800)
		icon_state = "magma_3"
		return
	if(temp > 800 && temp <= 1000)
		icon_state = "magma_4"
		return
	return