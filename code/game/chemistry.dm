#define REGULATE_RATE 5

/obj/item/weapon/smokebomb
	desc = "It is set to detonate in 2 seconds. Contains corrosive gas"
	name = "smoke bomb"
	icon = 'grenade.dmi'
	icon_state = "smokeg"
	var/state = null
	var/det_time = 20.0
	w_class = 2.0
	item_state = "flashbang"
	throw_speed = 4
	throw_range = 20
	flags = FPRINT | TABLEPASS | USEDELAY
	slot_flags = SLOT_BELT
	var/datum/effect/effect/system/bad_smoke_spread/smoke

/obj/item/weapon/mustardbomb
	desc = "It is set to detonate in 4 seconds."
	name = "mustard gas bomb"
	icon = 'grenade.dmi'
	icon_state = "flashbang"
	var/state = null
	var/det_time = 40.0
	w_class = 2.0
	item_state = "flashbang"
	throw_speed = 4
	throw_range = 20
	flags =  FPRINT | TABLEPASS | CONDUCT
	slot_flags = SLOT_BELT
	var/datum/effect/effect/system/mustard_gas_spread/mustard_gas

/obj/item/weapon/smokebomb/New()
	..()
	src.smoke = new /datum/effect/effect/system/bad_smoke_spread/
	src.smoke.attach(src)
	src.smoke.set_up(10, 0, src.loc)

/obj/item/weapon/mustardbomb/New()
	..()
	src.mustard_gas = new /datum/effect/effect/system/mustard_gas_spread/
	src.mustard_gas.attach(src)
	src.mustard_gas.set_up(5, 0, usr.loc)

//////////////////////////////////////////////////////////////////

//phleg

/obj/item/weapon/molotovbomb
	desc = "Improvised incendiary weapon. Set The World On Fire!"
	name = "Morfei cocktail"
	icon = 'grenade.dmi'
	icon_state = "molotov"
	var/state = null
	var/det_time = 40.0
	w_class = 2.0
	item_state = "flashbang"
	throw_speed = 4
	throw_range = 20
	flags =  FPRINT | TABLEPASS | CONDUCT
	slot_flags = SLOT_BELT
	var/lit = 0
	var/datum/effect/effect/system/fire_gas_spread/fire_gas

	proc
		light(var/flavor_text = "\red [usr] lights the [name].")

/obj/item/weapon/molotovbomb/New()
	..()
	src.fire_gas = new /datum/effect/effect/system/fire_gas_spread/
	src.fire_gas.attach(src)
	src.fire_gas.set_up(5, 0, src.loc)

/obj/item/weapon/molotovbomb/attackby(obj/item/weapon/W as obj, mob/user as mob)
	..()
	if(istype(W, /obj/item/weapon/weldingtool))
		var/obj/item/weapon/weldingtool/WT = W
		if(WT.isOn())//Badasses dont get blinded while lighting their cig with a welding tool
			light("\red [user] casually lights the [name] with [W], what a badass.")
			src.det_time = rand(120,200)
			user.show_message("\blue You set fire on a rag.")
			src.desc = "It is set to fire! Beware the explosion!"
			icon_state = "molotov1"
			lit = 1
			spawn( src.det_time )
				prime()

	else if(istype(W, /obj/item/weapon/lighter/zippo))
		var/obj/item/weapon/lighter/zippo/Z = W
		if(Z.lit > 0)
			light("\red With a single flick of their wrist, [user] smoothly lights their [name] with their [W]. Damn they're dangerous.")
			src.det_time = rand(120,200)
			user.show_message("\blue You set fire on a rag.")
			src.desc = "It is set to fire! Beware the explosion!"
			icon_state = "molotov1"
			lit = 1
			spawn( src.det_time )
				prime()

	else if(istype(W, /obj/item/weapon/lighter))
		var/obj/item/weapon/lighter/L = W
		if(L.lit > 0)
			light("\red After some fiddling, [user] manages to light their [name] with [W].")
			src.det_time = rand(120,200)
			user.show_message("\blue You set fire on a rag.")
			src.desc = "It is set to fire! Beware the explosion!"
			icon_state = "molotov1"
			lit = 1
			spawn( src.det_time )
				prime()

	else if(istype(W, /obj/item/weapon/melee/energy/sword))
		var/obj/item/weapon/melee/energy/sword/S = W
		if(S.active)
			light("\red [user] swings their [W], barely missing their nose. They light their [name] in the process.")
			src.det_time = rand(120,200)
			user.show_message("\blue You set fire on a rag.")
			src.desc = "It is set to fire! Beware the explosion!"
			icon_state = "molotov1"
			lit = 1
			spawn( src.det_time )
				prime()

	else if(istype(W, /obj/item/weapon/match))
		var/obj/item/weapon/match/M = W
		if(M.lit > 0)
			light("\red [user] lights their [name] with their [W].")
			src.det_time = rand(120,200)
			user.show_message("\blue You set fire on a rag.")
			src.desc = "It is set to fire! Beware the explosion!"
			icon_state = "molotov1"
			lit = 1
			spawn( src.det_time )
				prime()

	return

/*
/obj/item/weapon/molotovbomb/afterattack(atom/target as mob|obj|turf|area, mob/user as mob)
	if (istype(target, /obj/item/weapon/storage)) return ..() // Trying to put it in a full container
	if (user.equipped() == src)
		if (!( src.state ))
			user << "\red You prime the grenade! [det_time/10] seconds!"
			src.state = 1
			src.icon_state = "fraggren1"
			playsound(src.loc, 'armfrag.ogg', 75, 1)
			spawn( src.det_time )
				prime()
				return
		user.dir = get_dir(user, target)
		user.drop_item()
		var/t = (isturf(target) ? target : target.loc)
		walk_towards(src, t, 3)
		src.add_fingerprint(user)
	return
*/

/obj/item/weapon/molotovbomb/attack_paw(mob/user as mob)
	return src.attack_hand(user)

/obj/item/weapon/molotovbomb/attack_hand()
	walk(src, null, null)
	..()
	return

/obj/item/weapon/molotovbomb/throw_impact(var/atom/target, var/blocked = 0)
	if(lit)
		prime()

	return

/obj/item/weapon/molotovbomb/proc/prime()
	playsound(src.loc, 'molotov.ogg', 75, 1)
//	explosion (src, -1, -1, 3, 2)
	spawn(0)
		src.fire_gas.start()
		sleep(5)
		src.fire_gas.start()
		sleep(5)
		src.fire_gas.start()
		sleep(5)
		src.fire_gas.start()

	for(var/obj/effect/blob/B in view(8,src))
		var/damage = round(30/(get_dist(B,src)+1))
		B.health -= damage
		B.update()
	sleep(100)
	del(src)
	return

//phleg

/////////////////////////////////////////////////////////////////

//phleg

/obj/item/weapon/fragbomb
	desc = "It is set to detonate in 4 seconds. Contains colony of fragmentation nanobots."
	name = "Frag Nanobots grenade"
	icon = 'grenade.dmi'
	icon_state = "fraggren"
	var/state = null
	var/det_time = 40.0
	w_class = 2.0
	item_state = "flashbang"
	throw_speed = 4
	throw_range = 20
	flags =  FPRINT | TABLEPASS | CONDUCT
	slot_flags = SLOT_BELT
	var/datum/effect/effect/system/frag_gas_spread/frag_gas

/obj/item/weapon/fragbomb/New()
	..()
	src.frag_gas = new /datum/effect/effect/system/frag_gas_spread/
	src.frag_gas.attach(src)
	src.frag_gas.set_up(5, 0, src.loc)

/obj/item/weapon/fragbomb/attackby(obj/item/weapon/W as obj, mob/user as mob)
	..()
	if (istype(W, /obj/item/weapon/screwdriver))
		if (src.det_time == 60)
			src.det_time = 20
			user.show_message("\blue You set the grenade for a 2 second detonation time.")
			src.desc = "It is set to detonate in 2 seconds."
		else
			src.det_time = 60
			user.show_message("\blue You set the grenade for a 6 second detonation time.")
			src.desc = "It is set to detonate in 6 seconds."
		src.add_fingerprint(user)
	return


/obj/item/weapon/fragbomb/afterattack(atom/target as mob|obj|turf|area, mob/user as mob)
	if (istype(target, /obj/item/weapon/storage)) return ..() // Trying to put it in a full container
	if (user.equipped() == src)
		if (!( src.state ))
			user << "\red You prime the grenade! [det_time/10] seconds!"
			src.state = 1
			src.icon_state = "fraggren1"
			playsound(src.loc, 'armfrag.ogg', 75, 1)
			spawn( src.det_time )
				prime()
				return
		user.dir = get_dir(user, target)
		user.drop_item()
		var/t = (isturf(target) ? target : target.loc)
		walk_towards(src, t, 3)
		src.add_fingerprint(user)
	return

/obj/item/weapon/fragbomb/attack_paw(mob/user as mob)
	return src.attack_hand(user)

/obj/item/weapon/fragbomb/attack_hand()
	walk(src, null, null)
	..()
	return

/obj/item/weapon/fragbomb/proc/prime()
	playsound(src.loc, 'fragplosive.ogg', 75, 1)
//	explosion (src, -1, -1, 3, 2)
	spawn(0)
		src.frag_gas.start()
		sleep(10)
		src.frag_gas.start()
		sleep(10)
		src.frag_gas.start()
		sleep(10)
		src.frag_gas.start()
		sleep(10)
		src.frag_gas.start()
		sleep(10)
		src.frag_gas.start()

	for(var/obj/effect/blob/B in view(8,src))
		var/damage = round(30/(get_dist(B,src)+1))
		B.health -= damage
		B.update()
	sleep(100)
	del(src)
	return

/obj/item/weapon/fragbomb/attack_self(mob/user as mob)
	if (!src.state)
		user << "\red You prime the grenade! [det_time/10] seconds!"
		src.state = 1
		playsound(src.loc, 'armfrag.ogg', 75, 1)
		src.icon_state = "fraggren1"
		add_fingerprint(user)
		spawn( src.det_time )
			prime()
			return
	return


/obj/item/weapon/fragbomb/fragnade
	desc = "A bottle, filled with fuel and metal fragments for increased lethality."
	name = "strong makeshift grenade"
	icon_state = "strongnade"

/obj/item/weapon/fragbomb/fragnade/proc/prime_fragn()
	playsound(src.loc, 'fragplosive.ogg', 75, 1)
	explosion (src, -1, -1, 2, 2)
	spawn(0)
		src.frag_gas.start()
		sleep(10)
		src.frag_gas.start()
		sleep(10)
		src.frag_gas.start()

	for(var/obj/effect/blob/B in view(8,src))
		var/damage = round(30/(get_dist(B,src)+1))
		B.health -= damage
		B.update()
	sleep(100)
	del(src)
	return

/obj/item/weapon/fragbomb/fragnade/afterattack(atom/target as mob|obj|turf|area, mob/user as mob)
	if (istype(target, /obj/item/weapon/storage)) return ..() // Trying to put it in a full container
	if (user.equipped() == src)
		if (!( src.state ))
			user << "\red You prime the grenade! [det_time/10] seconds!"
			src.state = 1
			src.icon_state = "strongnade1"
			playsound(src.loc, 'armfrag.ogg', 75, 1)
			spawn( src.det_time )
				prime_fragn()
				return
		user.dir = get_dir(user, target)
		user.drop_item()
		var/t = (isturf(target) ? target : target.loc)
		walk_towards(src, t, 3)
		src.add_fingerprint(user)
	return

/obj/item/weapon/fragbomb/nade
	desc = "A bottle, filled with fuel and stuffed with ignition mechanism. Can serve as a cruel grenade."
	name = "makeshift grenade"
	icon_state = "nade"

/obj/item/weapon/fragbomb/nade/proc/prime_nade()
	playsound(src.loc, 'fragplosive.ogg', 75, 1)
	explosion (src, -1, -1, 2, 2)

	for(var/obj/effect/blob/B in view(8,src))
		var/damage = round(30/(get_dist(B,src)+1))
		B.health -= damage
		B.update()
	sleep(100)
	del(src)
	return

/obj/item/weapon/fragbomb/nade/afterattack(atom/target as mob|obj|turf|area, mob/user as mob)
	if (istype(target, /obj/item/weapon/storage)) return ..() // Trying to put it in a full container
	if (user.equipped() == src)
		if (!( src.state ))
			user << "\red You prime the grenade! [det_time/10] seconds!"
			src.state = 1
			src.icon_state = "nade1"
			playsound(src.loc, 'armfrag.ogg', 75, 1)
			spawn( src.det_time )
				prime_nade()
				return
		user.dir = get_dir(user, target)
		user.drop_item()
		var/t = (isturf(target) ? target : target.loc)
		walk_towards(src, t, 3)
		src.add_fingerprint(user)
	return

//phleg


/obj/item/weapon/smokebomb/attackby(obj/item/weapon/W as obj, mob/user as mob)
	..()
	if (istype(W, /obj/item/weapon/screwdriver))
		if (src.det_time == 60)
			src.det_time = 20
			user.show_message("\blue You set the smoke bomb for a 2 second detonation time.")
			src.desc = "It is set to detonate in 2 seconds."
		else
			src.det_time = 60
			user.show_message("\blue You set the smoke bomb for a 6 second detonation time.")
			src.desc = "It is set to detonate in 6 seconds."
		src.add_fingerprint(user)
	return

/obj/item/weapon/smokebomb/afterattack(atom/target as mob|obj|turf|area, mob/user as mob)
	if (user.equipped() == src)
		if (!( src.state ))
			user << "\red You prime the smoke bomb! [det_time/10] seconds!"
			src.state = 1
			src.icon_state = "smokeg1"
			playsound(src.loc, 'armbomb.ogg', 75, 1, -3)
			spawn( src.det_time )
				prime()
				return
		user.dir = get_dir(user, target)
		user.drop_item()
		var/t = (isturf(target) ? target : target.loc)
		walk_towards(src, t, 3)
		src.add_fingerprint(user)
	return

/obj/item/weapon/smokebomb/attack_paw(mob/user as mob)
	return src.attack_hand(user)

/obj/item/weapon/smokebomb/attack_hand()
	walk(src, null, null)
	..()
	return

/obj/item/weapon/smokebomb/proc/prime()
	playsound(src.loc, 'smoke.ogg', 50, 1, -3)
	spawn(0)
		src.smoke.start()
		sleep(10)
		src.smoke.start()
		sleep(10)
		src.smoke.start()
		sleep(10)
		src.smoke.start()

	for(var/obj/effect/blob/B in view(8,src))
		var/damage = round(30/(get_dist(B,src)+1))
		B.health -= damage
		B.update()
	sleep(80)
	del(src)
	return

/obj/item/weapon/smokebomb/attack_self(mob/user as mob)
	if (!src.state)
		user << "\red You prime the smoke bomb! [det_time/10] seconds!"
		src.state = 1
		src.icon_state = "flashbang1"
		add_fingerprint(user)
		spawn( src.det_time )
			prime()
			return
	return

/obj/item/weapon/mustardbomb/attackby(obj/item/weapon/W as obj, mob/user as mob)
	..()
	if (istype(W, /obj/item/weapon/screwdriver))
		if (src.det_time == 80)
			src.det_time = 40
			user.show_message("\blue You set the mustard gas bomb for a 4 second detonation time.")
			src.desc = "It is set to detonate in 4 seconds."
		else
			src.det_time = 80
			user.show_message("\blue You set the mustard gas bomb for a 8 second detonation time.")
			src.desc = "It is set to detonate in 8 seconds."
		src.add_fingerprint(user)
	return

/obj/item/weapon/mustardbomb/afterattack(atom/target as mob|obj|turf|area, mob/user as mob)
	if (user.equipped() == src)
		if (!( src.state ))
			user << "\red You prime the mustard gas bomb! [det_time/10] seconds!"
			src.state = 1
			src.icon_state = "flashbang1"
			playsound(src.loc, 'armbomb.ogg', 75, 1, -3)
			spawn( src.det_time )
				prime()
				return
		user.dir = get_dir(user, target)
		user.drop_item()
		var/t = (isturf(target) ? target : target.loc)
		walk_towards(src, t, 3)
		src.add_fingerprint(user)
	return

/obj/item/weapon/mustardbomb/attack_paw(mob/user as mob)
	return src.attack_hand(user)

/obj/item/weapon/mustardbomb/attack_hand()
	walk(src, null, null)
	..()
	return

/obj/item/weapon/mustardbomb/proc/prime()
	playsound(src.loc, 'smoke.ogg', 50, 1, -3)
	spawn(0)
		src.mustard_gas.start()
		sleep(10)
		src.mustard_gas.start()
		sleep(10)
		src.mustard_gas.start()
		sleep(10)
		src.mustard_gas.start()

	for(var/obj/effect/blob/B in view(8,src))
		var/damage = round(30/(get_dist(B,src)+1))
		B.health -= damage
		B.update()
	sleep(100)
	del(src)
	return

/obj/item/weapon/mustardbomb/attack_self(mob/user as mob)
	if (!src.state)
		user << "\red You prime the mustard gas bomb! [det_time/10] seconds!"
		src.state = 1
		src.icon_state = "flashbang1"
		add_fingerprint(user)
		spawn( src.det_time )
			prime()
			return
	return

/obj/item/weapon/storage/beakerbox
	name = "Beaker Box"
	icon_state = "beaker"
	item_state = "syringe_kit"
	foldable = /obj/item/stack/sheet/cardboard	//BubbleWrap

/obj/item/weapon/storage/beakerbox/New()
	..()
	new /obj/item/weapon/reagent_containers/glass/beaker( src )
	new /obj/item/weapon/reagent_containers/glass/beaker( src )
	new /obj/item/weapon/reagent_containers/glass/beaker( src )
	new /obj/item/weapon/reagent_containers/glass/beaker( src )
	new /obj/item/weapon/reagent_containers/glass/beaker( src )
	new /obj/item/weapon/reagent_containers/glass/beaker( src )
	new /obj/item/weapon/reagent_containers/glass/beaker( src )

/obj/item/weapon/paper/alchemy/
	name = "paper - 'Chemistry Information'"

/obj/item/weapon/storage/trashcan
	name = "disposal unit"
	w_class = 4.0
	anchored = 1.0
	density = 1.0
	var/processing = null
	var/locked = 1
	req_access = list(ACCESS_JANITOR)
	desc = "A compact incineration device, used to dispose of garbage."
	icon = 'stationobjs.dmi'
	icon_state = "trashcan"
	item_state = "syringe_kit"

/obj/item/weapon/storage/trashcan/attackby(obj/item/weapon/W as obj, mob/user as mob)
	//..()

	if (src.contents.len >= 7)
		user << "The trashcan is full!"
		return
	if (istype(W, /obj/item/weapon/disk/nuclear)||istype(W, /obj/item/weapon/melee/energy/blade))
		user << "This is far too important to throw away!"
		return
	if (istype(W, /obj/item/weapon/storage/))
		return
	if (istype(W, /obj/item/weapon/grab))
		user << "You cannot fit the person inside."
		return
	var/t
	for(var/obj/item/weapon/O in src)
		t += O.w_class
		//Foreach goto(46)
	t += W.w_class
	if (t > 30)
		user << "You cannot fit the item inside. (Remove larger classed items)"
		return
	user.u_equip(W)
	W.loc = src
	if ((user.client && user.s_active != src))
		user.client.screen -= W
	src.orient2hud(user)
	W.dropped(user)
	add_fingerprint(user)
	user.visible_message("\blue [user] has put [W] in [src]!")

	if (src.contents.len >= 7)
		src.locked = 1
		src.icon_state = "trashcan1"
	spawn (200)
		if (src.contents.len < 7)
			src.locked = 0
			src.icon_state = "trashcan"
	return

/obj/item/weapon/storage/trashcan/attack_hand(mob/user as mob)
	if(src.allowed(usr))
		locked = !locked
	else
		user << "\red Access denied."
		return
	if (src.processing)
		return
	if (src.contents.len >= 7)
		user << "\blue You begin the emptying procedure."
		var/area/A = src.loc.loc		// make sure it's in an area
		if(!A || !isarea(A))
			return
//		var/turf/T = src.loc
		A.use_power(250, EQUIP)
		src.processing = 1
		src.contents.len = 0
		src.icon_state = "trashmelt"
		if (istype(loc, /turf))
			loc:hotspot_expose(1000,10)
		sleep (60)
		src.icon_state = "trashcan"
		src.processing = 0
		return
	else
		src.icon_state = "trashcan"
		user << "\blue Due to conservation measures, the unit is unable to start until it is completely filled."
		return


