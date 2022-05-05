/obj/machinery/power/thermal/engine
	name = "Termal engine"
	desc = "."
//	icon =
//	icon_state =
	var/temp_left
	var/temp_right
	var/obj/machinery/power/terminal/terminal = null

	New()
		..()
		spawn(5)
			dir_loop:
				for(var/d in cardinal)
					var/turf/T = get_step(src, d)
					for(var/obj/machinery/power/terminal/term in T)
						if(term && term.dir == turn(d, 180))
							terminal = term
							break dir_loop
			if(!terminal)
				if(!terminal)
				stat |= BROKEN
				return
			terminal.master = src
			updateicon()
		return

	Del()
		..()
		teminal.master = null

