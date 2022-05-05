/obj/structure/thermal/gas/steam
	name = "Steam"
	desc = "Hot gas."
//	icon
//	icon_state

	New()
		..()
		var/turf/T = src.loc
		if(!istype(T, /turf/simulated))
			del(src)
			return
		var/turf/simulated/place = T
		processing_objects.Add(src)
		place.gas = src


	Del()
		..()
		processing_objects.Remove(src)

	process()