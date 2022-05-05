/turf/simulated
	var/list/obj/structure/thermal/thermal = list()

/obj/structure/thermal
	name = "Thermal"
	desc = "."
//	icon
//	icon_state
	density   = 1
	opacity   = 0
	anchored  = 1
	var/near  = 0
	var/temp  = 0
	var/debug = 0
	var/turf/simulated/master = null

/*
/obj/structure/thermal/matter/cooler
	name = "Cooler"

	New()
		while(!ticker)
			sleep(30)
		while(ticker.current_state < 3)
			sleep(30)
		var/turf/simulated/place = src.loc
		if(!istype(place, /turf/simulated))
			del(src)

/obj/structure/thermal/matter/cooler/NearMagma()
	var/count = 0
	for(var/d in cardinal)
		var/turf/simulated/M = get_step(src, d)
		if(M.thermal)
			count++
	return count

/obj/structure/thermal/matter/cooler/AddNearMagma()
	for(var/d in cardinal)
		var/turf/D = get_step(src, d)
		if(istype(D,/turf/simulated))
			var/turf/simulated/M = D
			if(M.thermal)
				M.thermal.near++

/obj/structure/thermal/matter/cooler/NearMagmaIfDel()
	for(var/d in cardinal)
		var/turf/D = get_step(src, d)
		if(istype(D,/turf/simulated))
			var/turf/simulated/M = D
			if(M.thermal)
				M.thermal.near--
*/
/*
/turf/simulated/proc/hasMagma()
	var/obj/structure/thermal/magma/M = locate(/obj/structure/thermal/magma) in thermal
	if(M)
		return 1
	return 0

/turf/simulated/proc/hasWater()
	var/obj/structure/thermal/water/M = locate(/obj/structure/thermal/water) in thermal
	if(M)
		return 1
	return 0
*/
