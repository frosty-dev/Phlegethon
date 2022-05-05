#define WATER_CHECK_TEMP      10

/obj/structure/thermal/water
	name = "Water"
	desc = "Just water. More when need."
	icon = 'thermal.dmi'
	icon_state = "water"
	var/mass = 1
	var/last_flood = 0


	New()
		var/turf/T = src.loc
		if(!istype(T, /turf/simulated))
			del(src)
			return
		var/turf/simulated/place = T
		processing_objects.Add(src)
		place.thermal += src
		master = place
		Check_Magma()
		..()
	Del()
		..()
		master.thermal -= src
		processing_objects.Remove(src)

	process()
		if(mass >= 1)
			Flood()
		if(last_flood >= WATER_CHECK_TEMP)
			//Share_Temp()
			last_flood = 0
		Check_Health()
		last_flood++

/obj/structure/thermal/water/proc/Flood()
	var/list/turf/simulated/floor/Space = list()
	for(var/d in cardinal)
		var/turf/D = get_step(src, d)
		if(istype(D,/turf/simulated))
			var/turf/simulated/M = D
			if(istype(M, /turf/simulated/floor))
				Space += M
	if(!isemptylist(Space))
		var/length = Space.len + 1
		var/wtransfer = mass/length
		length++
		for(var/turf/T in Space)
			if(istype(T,/turf/simulated))
				length--
				wtransfer = mass/length
				var/turf/simulated/M = T
				if(M.hasWater())
					var/obj/structure/thermal/water/W = locate(/obj/structure/thermal/water) in M.thermal
					if(W.mass != src.mass)
						if(W.mass > src.mass)
							var/delta = min((W.mass - src.mass)/2, wtransfer)
							W.mass -= delta
							src.mass += delta
						else if(W.mass < src.mass)
							var/delta = min((src.mass - W.mass)/2, wtransfer)
							W.mass += delta
							src.mass -= delta
					if(W.temp != src.temp)
						var/Atemp_sum = (src.temp * src.mass + W.temp * W.mass)/(src.mass + W.mass)
						W.temp = min(abs(Atemp_sum),src.mass/W.mass)
						src.temp = min(abs(Atemp_sum), W.mass/src.mass)
				else if(src.mass > 1)
					if(master.ZCanPass(M) && !M.HasDoor(master))
						var/obj/structure/thermal/water/S = new /obj/structure/thermal/water (T)
						S.mass = wtransfer
						src.mass -= wtransfer
	return

/obj/structure/thermal/water/proc/Check_Health()
	if(mass > 0)
		if(temp >= 100)
			//Steam
			return
		else if(temp <= 0)
			//Ice
			return
	else
		del(src)

/obj/structure/thermal/water/proc/Check_Magma()
	var/turf/simulated/W = master
	if(W.hasMagma())
		var/obj/structure/thermal/magma/magma = locate(/obj/structure/thermal/magma) in W.thermal

		var/arch_temp_water = src.temp
		var/arch_temp_magma = magma.temp
		var/check = src.temp * src.mass - magma.temp * magma.mass
		if(check == 0)
			del(magma)
			del(src)
			return
		else if (check > 0)
			src.mass = check / arch_temp_water
			del(magma)
			return
		else if (check < 0)
			magma.mass = -check / arch_temp_magma
			del(src)
			return
	return

/obj/structure/thermal/water/update_icon()
	return


