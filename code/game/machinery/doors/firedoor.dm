/obj/machinery/door/firedoor
	name = "Firelock"
	desc = "Apply crowbar"
	icon = 'Doorfire.dmi'
	icon_state = "door_open"
	var/blocked = 0
	opacity = 0
	density = 0
	var/nextstate = null
	var/net_id
	health = 400

	Bumped(atom/AM)
		if(p_open || operating)	return
		if(!density)	return ..()
		return 0


	power_change()
		if(powered(ENVIRON))
			stat &= ~NOPOWER
		else
			stat |= NOPOWER
		return


	attackby(obj/item/weapon/C as obj, mob/user as mob)
		src.add_fingerprint(user)
		if(operating)	return//Already doing something.
		if(istype(C, /obj/item/weapon/weldingtool))
			var/obj/item/weapon/weldingtool/W = C
			if(W.remove_fuel(0, user))
				src.blocked = !src.blocked
				user << text("\red You [blocked?"welded":"unwelded"] the [src]")
				update_icon()
				return

		if (istype(C, /obj/item/weapon/crowbar) || (istype(C,/obj/item/weapon/twohanded/fireaxe) && C:wielded == 1))
			if(blocked || operating)	return
			if(src.density)
				spawn(0)
					open()
					return
			else //close it up again
				spawn(0)
					close()
					return
		return


	process()
		if(operating || stat & NOPOWER || !nextstate)
			return
		switch(nextstate)
			if(OPEN)
				spawn()
					open()
			if(CLOSED)
				spawn()
					close()
		nextstate = null
		return


	fbyond_animate(animation)
		switch(animation)
			if("opening")
				flick("door_opening", src)
			if("closing")
				flick("door_closing", src)
		return


	update_icon()
		overlays = null
		if(density)
			icon_state = "door_closed"
			if(blocked)
				overlays += "welded"
		else
			icon_state = "door_open"
			if(blocked)
				overlays += "welded_open"
		return

	proc/die()
		var/datum/effect/effect/system/dust_smoke_spread/smoke = new /datum/effect/effect/system/dust_smoke_spread()
		smoke.set_up(5, 0, src)
		smoke.start()
		new /obj/item/stack/rods (src.loc)
		new /obj/item/stack/sheet/metal (src.loc)
		new /obj/item/stack/sheet/metal (src.loc)
		new /obj/item/stack/sheet/plasteel (src.loc)
		new /obj/item/stack/sheet/plasteel (src.loc)
		new /obj/item/weapon/cable_coil (src.loc)
		new /obj/item/weapon/cable_coil (src.loc)
		new /obj/item/weapon/cable_coil (src.loc)
		del(src)

	bullet_act(var/obj/item/projectile/Proj)
		if(istype(Proj ,/obj/item/projectile/bullet/gyro))
			explosion(src, -1, 0, 2)
			health -= Proj.damage
		health -= Proj.damage
		src.spark_system.start()
		..()
		if (health <= 0)
			die()
		return


/obj/machinery/door/firedoor/border_only