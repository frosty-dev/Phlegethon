/obj/structure/stool/bed/chair/motorcycle
	name = "captain's hoverbike"
	icon = 'icons/obj/vehicles.dmi'
	icon_state = "cap_hoverbike"
	anchored = 1
	density = 1
	flags = OPENCONTAINER

/obj/structure/stool/bed/chair/motorcycle/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/key))
		user << "Hold [W] in one of your hands while you drive this pimpin' ride."

	//	if((istype(src.loc, /turf/space)) || (src.lastarea.has_gravity == 0))
	//		src.inertia_dir = get_dir(target, src)
	//		step(src, inertia_dir)


/obj/structure/stool/bed/chair/motorcycle/relaymove(mob/user, dir)
	if(user.stat || user.stunned || user.weakened || user.paralysis)
		unbuckle()
	if(istype(user.l_hand, /obj/item/key) || istype(user.r_hand, /obj/item/key))
		step(src, dir)
		update_mob()
		handle_rotation()
	else
		user << "<span class='notice'>You'll need the keys in one of your hands to drive this pimpin' ride.</span>"

/obj/structure/stool/bed/chair/motorcycle/Move()
	..()
	if(buckled_mob)
		if(buckled_mob.buckled == src)
			buckled_mob.loc = src.loc

/obj/structure/stool/bed/chair/motorcycle/buckle_mob(mob/M, mob/user)
	if(M != user || !ismob(M) || get_dist(src, user) > 1 || user.restrained() || user.lying || user.stat || M.buckled || istype(user, /mob/living/silicon))
		return
	unbuckle()
	M.visible_message(\
		"<span class='notice'>[M] clambers onto the hoverbike.</span>",\
		"<span class='notice'>You clamber onto the hoverbike.</span>")
	M.buckled = src
	M.loc = loc
	M.dir = dir
	M:update_canmove()
	buckled_mob = M
	update_mob()
	add_fingerprint(user)
	return



/obj/structure/stool/bed/chair/motorcycle/handle_rotation()
	if(dir == SOUTH)
		layer = FLY_LAYER
	else
		layer = OBJ_LAYER

	if(buckled_mob)
		if(buckled_mob.loc != loc)
			buckled_mob.buckled = null //Temporary, so Move() succeeds.
			buckled_mob.buckled = src //Restoring

	update_mob()

/obj/structure/stool/bed/chair/motorcycle/proc/update_mob()
	if(buckled_mob)
		buckled_mob.dir = dir

/obj/item/key
	name = "captain's hoverbike key"
	desc = "A blue and gold keyring with a small steel key. This one goes to the Captain's Hoverbike."
	icon = 'icons/obj/vehicles.dmi'
	icon_state = "cap_key"
	w_class = 1

/obj/item/key/sec
	name = "security hoverbike key"
	desc = "A red keyring with a small steel key. This one goes to Security's Hoverbikes."
	icon_state = "sec_key"
	w_class = 1

/obj/item/key/eng
	name = "engineering hoverbike key"
	desc = "An orange keyring with a small steel key. This one goes to Engineering's Hoverbikes."
	icon_state = "eng_key"
	w_class = 1

/obj/item/key/syn
	name = "suspicious hoverbike key"
	desc = "A red and black keyring with a small steel key. This one is Suspicious looking."
	icon_state = "syn_key"
	w_class = 1

/obj/structure/stool/bed/chair/motorcycle/sec
	name = "security hoverbike"
	icon_state = "sec_hoverbike"

/obj/structure/stool/bed/chair/motorcycle/sec/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/key/sec))
		user << "Hold [W] in one of your hands while you drive this hoverbike."

/obj/structure/stool/bed/chair/motorcycle/sec/relaymove(mob/user, direction)
	if(user.stat || user.stunned || user.weakened || user.paralysis)
		unbuckle()
	if(istype(user.l_hand, /obj/item/key/sec) || istype(user.r_hand, /obj/item/key/sec))
		step(src, direction)
		update_mob()
		handle_rotation()
	else
		user << "<span class='notice'>You'll need the keys in one of your hands to drive this robust ride.</span>"

/obj/structure/stool/bed/chair/motorcycle/eng
	name = "engineering hoverbike"
	icon_state = "eng_hoverbike"

/obj/structure/stool/bed/chair/motorcycle/eng/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/key/eng))
		user << "Hold [W] in one of your hands while you drive this hoverbike."

/obj/structure/stool/bed/chair/motorcycle/eng/relaymove(mob/user, direction)
	if(user.stat || user.stunned || user.weakened || user.paralysis)
		unbuckle()
	if(istype(user.l_hand, /obj/item/key/eng) || istype(user.r_hand, /obj/item/key/eng))
		step(src, direction)
		update_mob()
		handle_rotation()
	else
		user << "<span class='notice'>You'll need the keys in one of your hands to drive this shocking ride.</span>"

/obj/structure/stool/bed/chair/motorcycle/syn
	name = "suspicious hoverbike"
	icon_state = "syn_hoverbike"

/obj/structure/stool/bed/chair/motorcycle/syn/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/key/syn))
		user << "Hold [W] in one of your hands while you drive this hoverbike."

/obj/structure/stool/bed/chair/motorcycle/syn/relaymove(mob/user, direction)
	if(user.stat || user.stunned || user.weakened || user.paralysis)
		unbuckle()
	if(istype(user.l_hand, /obj/item/key/syn) || istype(user.r_hand, /obj/item/key/syn))
		step(src, direction)
		update_mob()
		handle_rotation()
	else
		user << "<span class='notice'>You'll need the keys in one of your hands to drive this suspicious ride.</span>"


/obj/structure/stool/bed/chair/motorcycle/bobber
	name = "bobber"
	icon_state = "bobberbike"
	var/health = 300
	var/max_health = 300
	var/broken = 0
	var/fuel = 0
	var/max_fuel = 1800
	var/hole = 0
	var/armor = 0
	var/cruise = 0
	desc = "Bobber bike."

	proc/leak()
		if(hole > 0)
			fuel -= hole * 2
			return
		else
			return

	examine(obj/item/W, mob/user)
		..()
		user << "Fuel [fuel]."
		return

/obj/structure/stool/bed/chair/motorcycle/bobber/Bump(atom/movable/A as mob|obj)
	var/mob/living/M = A
	if(cruise > 4)
		TakeDamage (10)
		cruise -= 2
		if(istype(A, /mob/living))
			M.take_organ_damage(cruise*2)
		return
	if(cruise > 6)
		TakeDamage (20)
		cruise -= 4
		if(istype(A, /mob/living))
			M.take_organ_damage(cruise*4)
		return
	if(cruise > 8)
		if(prob(30))
			broken = 1
			buckled_mob.apply_damage(cruise*4, BRUTE, pick("head", "chest", "l_leg", "r_leg", "l_arm", "r_arm"))
		TakeDamage(30)
		cruise -= 6
		buckled_mob.Stun(10)
		if(istype(A, /mob/living))
			M.take_organ_damage(cruise*6)
		return

/obj/structure/stool/bed/chair/motorcycle/bobber/proc/iconcheck()
	if((dir == SOUTH || dir == NORTH)&&(pixel_y >= 0))
		pixel_y -= 4
	else
		if(pixel_y < 0)
			pixel_y += 4
	return

/obj/structure/stool/bed/chair/motorcycle/bobber/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/key/bobber))
		user << "Hold [W] in one of your hands while you drive this bike."

	if(istype(W, /obj/item/weapon/metalparts))
		if(hole > 0)
			user << "You start repairing..."
			sleep(50) //not sleep and in handcraft/ Need do move
			del(W)
			hole = 0
			user << "You successfully fixed a gastank."
		else
			user << "Gas tank do not leak."

	if(istype(W, /obj/item/weapon/weldingtool))
		var/obj/item/weapon/weldingtool/WT = W
		if (WT.remove_fuel(0))
			if(broken == 1)
				broken = 0
			if(health < max_health)
				health += 10
			else
				return
			for(var/mob/O in viewers(user, null))
				O.show_message(text("\red [user] has fixed some of the dents on [src]!"), 1)
		else
			user << "Need more welding fuel!"

	if(istype(W, /obj/item/weapon/reagent_containers))
		if(W.reagents)
			if(W.reagents.total_volume < 1)
				return
			//	user << "The [W] is empty."
			else if(W.reagents.total_volume >= 1)
				if(W.reagents.has_reagent("fuel"))
					user << "You refilled [src]"
			//		W.reagents.trans_to(src.fuel)
			//		fuel = W.reagents.total_volume
					fuel += W.reagents.total_volume
					W.reagents.total_volume = 0
				else
					user << "\red Its not fuel!"

	else
		var/damage = 0
		damage = W.force
		TakeDamage(damage)
		if(prob(20))
			src.visible_message("Fuel system is damaged!")
			hole +=1
			leak()
	return

/obj/structure/stool/bed/chair/motorcycle/bobber/relaymove(mob/user, direction)
	iconcheck()
	if(fuel > 0)
		fuel -= 1
	else
		src.visible_message("Engine emiting sneezing sound")
		handle_rotation()
		return

	if(user.stat || user.stunned || user.weakened || user.paralysis || src.broken == 1)
		unbuckle()
	if(istype(user.l_hand, /obj/item/key/bobber) || istype(user.r_hand, /obj/item/key/bobber) && (broken == 0))
		step(src, direction)
		update_mob()
		handle_rotation()
	else
		user << "<span class='notice'>You'll need the keys in one of your hands.</span>"

	cruise += 1
	user << "[cruise*5] km/h speed."
	sleep(10)
	cruise -= 1

/obj/item/key/bobber
	name = "bike key"
	desc = "A crucifix with a small steel key."
	icon_state = "bobber"
	w_class = 1

/obj/structure/stool/bed/chair/motorcycle/bobber/handle_rotation()
	iconcheck()
	if(dir == SOUTH || dir == NORTH)
		layer = FLY_LAYER
	else
		layer = OBJ_LAYER

	if(buckled_mob)
		if(buckled_mob.loc != loc)
			buckled_mob.buckled = null //Temporary, so Move() succeeds.
			buckled_mob.buckled = src //Restoring

	update_mob()



/obj/structure/stool/bed/chair/motorcycle/bobber/

	proc/TakeDamage(var/damage = 0)
		if(src.health > 0)
			var/tempdamage = (damage-armor)
			if(tempdamage > 0)
				src.health -= tempdamage
			else
				src.health--
			if(src.health <= 0)
				src.Die()
		else
			return


	proc/Die()
		if(broken == 0)
			src.icon_state += "-broken"
			src.visible_message("<b>[src]</b> broke down")
			broken = 1
			desc += " Broken."
		if(broken == 1)
			return

	bullet_act(var/obj/item/projectile/Proj)
		TakeDamage(Proj.damage)
		if(prob(80 - cruise * 6))
			buckled_mob.adjustBruteLoss(Proj.damage)
		if(prob(20))
			src.visible_message("Fuel system is damaged!")
			hole +=1
			leak()
			if(prob(40)&&(fuel > 20))
				explosion(src, -1, 0, 2)
				broken = 1
		if(prob(10))
			src.visible_message("Engine is damaged!")
			broken = 1
		if(istype(Proj ,/obj/item/projectile/bullet/gyro))
			explosion(src, -1, 0, 2)
			broken = 1
		else
			return
		..()


	ex_act(severity)
		switch(severity)
			if(1.0)
				src.Die()
				return
			if(2.0)
				TakeDamage(20)
				return
		return


	emp_act(serverity)
		switch(serverity)
			if(1.0)
				src.Die()
				return
			if(2.0)
				TakeDamage(20)
				return
		return


	meteorhit()
		src.Die()
		return
