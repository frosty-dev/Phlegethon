/obj/machinery/door/poddoor/shutters
	name = "Shutters"
	icon = 'rapid_pdoor.dmi'
	icon_state = "shutter1"
	health = 200

/obj/machinery/door/poddoor/shutters/New()
	..()
	layer = 3.1

/obj/machinery/door/poddoor/shutters/attackby(obj/item/weapon/C as obj, mob/user as mob)
	src.add_fingerprint(user)
	if (!( istype(C, /obj/item/weapon/crowbar) || (istype(C, /obj/item/weapon/twohanded/fireaxe) && C:wielded == 1) ))
		return
	if ((src.density && (stat & NOPOWER) && !( src.operating )))
		spawn( 0 )
			src.operating = 1
			flick("shutterc0", src)
			src.icon_state = "shutter0"
			sleep(15)
			src.density = 0
			src.ul_SetOpacity(0)
			src.operating = 0
			return
	return

/obj/machinery/door/poddoor/shutters/open()
	if (src.operating == 1) //doors can still open when emag-disabled
		return
	if (!ticker)
		return 0
	if(!src.operating) //in case of emag
		src.operating = 1
	flick("shutterc0", src)
	src.icon_state = "shutter0"
	sleep(10)
	src.density = 0
	src.ul_SetOpacity(0)
	update_nearby_tiles()

	if(operating == 1) //emag again
		src.operating = 0
	if(autoclose)
		spawn(150)
			autoclose()
	return 1

/obj/machinery/door/poddoor/shutters/close()
	if (src.operating)
		return
	src.operating = 1
	flick("shutterc1", src)
	src.icon_state = "shutter1"
	src.density = 1
	if (src.visible)
		src.ul_SetOpacity(1)
	update_nearby_tiles()

	sleep(10)
	src.operating = 0
	return

/obj/machinery/door/poddoor/shutters/proc/die()
	var/datum/effect/effect/system/dust_smoke_spread/smoke = new /datum/effect/effect/system/dust_smoke_spread()
	smoke.set_up(5, 0, src)
	smoke.start()
	new /obj/item/stack/rods (src.loc)
	new /obj/item/stack/sheet/metal (src.loc)
	new /obj/item/stack/sheet/metal (src.loc)
	new /obj/item/stack/sheet/metal (src.loc)
	new	/obj/item/weapon/metalparts	(src.loc)
	new	/obj/item/weapon/metalparts	(src.loc)
	new /obj/item/weapon/airlock_electronics (src.loc)
	new /obj/item/weapon/cable_coil (src.loc)
	del(src)

/obj/machinery/door/poddoor/shutters/bullet_act(var/obj/item/projectile/Proj)
	if(istype(Proj ,/obj/item/projectile/bullet/gyro))
		explosion(src, -1, 0, 2)
		health -= Proj.damage
	health -= Proj.damage
	src.spark_system.start()
	..()
	if (health <= 0)
		die()
	return
