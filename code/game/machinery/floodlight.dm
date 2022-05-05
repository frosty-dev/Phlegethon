//these are probably broken

/obj/machinery/floodlight
	name = "Firebarrel"
	icon = 'floodlight.dmi'
	icon_state = "flood00"
	density = 1
	var/on = 0
	var/obj/item/weapon/cell/cell = null
	var/use = 1
	var/open = 0

/obj/machinery/floodlight/proc/updateicon()
	icon_state = "flood[open ? "o" : ""][open && cell ? "b" : ""]0[on]"

/obj/machinery/floodlight/process()
	if (!on)
		if (luminosity)
			updateicon()
			ul_SetLuminosity(0)
		return

	if(!luminosity && cell && cell.charge > 0)
		ul_SetLuminosity(5,3,0)
		updateicon()

	if(!cell && luminosity)
		on = 0
		updateicon()
		ul_SetLuminosity(0)
		return

	cell.charge -= use

	if(cell.charge <= 0 && luminosity)
		on = 0
		updateicon()
		ul_SetLuminosity(0)
		return

	if(on)
		if(prob(5))
			on = 0

/obj/machinery/floodlight/attackby(obj/item/weapon/W as obj, mob/user as mob)
	..()
	if(istype(W, /obj/item/weapon/weldingtool))
		var/obj/item/weapon/weldingtool/WT = W
		if(WT.isOn())//Badasses dont get blinded while lighting their cig with a welding tool
			if(cell.charge <= 0)
				user << "No fuel in [src]"
				return
			else
				on = 1
				user << "You set it on fire"


	else if(istype(W, /obj/item/weapon/lighter/zippo))
		var/obj/item/weapon/lighter/zippo/Z = W
		if(Z.lit > 0)
			if(cell.charge <= 0)
				user << "No fuel in [src]"
				return
			else
				on = 1
				user << "You set it on fire"

	else if(istype(W, /obj/item/weapon/lighter))
		var/obj/item/weapon/lighter/L = W
		if(L.lit > 0)
			if(cell.charge <= 0)
				user << "No fuel in [src]"
				return
			else
				on = 1
				user << "You set it on fire"

	else if(istype(W, /obj/item/weapon/match))
		var/obj/item/weapon/match/M = W
		if(M.lit > 0)
			if(cell.charge <= 0)
				user << "No fuel in [src]"
				return
			else
				on = 1
				user << "You set it on fire"
	updateicon()


/obj/machinery/floodlight/attack_hand(mob/user as mob)
	if(open && cell)
		cell.loc = usr
		cell.layer = 20
		if (user.hand )
			user.l_hand = cell
		else
			user.r_hand = cell

		cell.add_fingerprint(user)
		updateicon()
		cell.updateicon()

		src.cell = null
		user << "You remove the power cell"
		return

	if(on)
		user << "You warms hands by fire"
		user.bodytemperature += 5



/obj/machinery/floodlight/New()
	src.cell = new/obj/item/weapon/cell(src)
	cell.maxcharge = 500
	cell.charge = 500
	..()
