/obj/item/weapon/gun/projectile/automatic //Hopefully someone will find a way to make these fire in bursts or something. --Superxpdude
	name = "\improper Submachine Gun"
	desc = "A lightweight, fast firing gun. Uses 9mm rounds."
	icon_state = "saber"
	w_class = 3.0
	max_shells = 18
	caliber = "9mm"
	origin_tech = "combat=4;materials=2"
	ammo_type = "/obj/item/ammo_casing/c9mm"
	automatic = 1



/obj/item/weapon/gun/projectile/automatic/mini_uzi
	name = "\improper Mini-Uzi"
	desc = "A lightweight, fast firing gun, for when you want someone dead. Uses .45 rounds."
	icon_state = "mini-uzi"
	w_class = 3.0
	max_shells = 20
	caliber = ".45"
	origin_tech = "combat=5;materials=2;syndicate=8"
	ammo_type = "/obj/item/ammo_casing/c45"



/obj/item/weapon/gun/projectile/automatic/c20r
	name = "\improper C-20r SMG"
	desc = "A lightweight, fast firing gun, for when you REALLY need someone dead. Uses 12mm rounds. Has a 'Scarborough Arms - Per falcis, per pravitas' buttstamp"
	icon_state = "c20r"
	item_state = "c20r"
	w_class = 3.0
	max_shells = 20
	caliber = "12mm"
	origin_tech = "combat=5;materials=2;syndicate=8"
	ammo_type = "/obj/item/ammo_casing/a12mm"
	fire_sound = 'Gunshot_smg.ogg'
	load_method = 2


	New()
		..()
		empty_mag = new /obj/item/ammo_magazine/a12mm/empty(src)
		update_icon()
		return


	afterattack(atom/target as mob|obj|turf|area, mob/living/user as mob|obj, flag)
		..()
		if(!loaded.len && empty_mag)
			empty_mag.loc = get_turf(src.loc)
			empty_mag = null
			playsound(user, 'smg_empty_alarm.ogg', 40, 1)
			update_icon()
		return


	update_icon()
		..()
		overlays = null
		if(empty_mag)
			overlays += "c20r-[round(loaded.len,4)]"
		return

//phleg
/obj/item/weapon/gun/projectile/automatic/hamlet
	name = "Hamlet SMG"
	desc = "A lightweight SMG by Triss Arms. Time tested. Uses .45s rounds."
	icon_state = "hamlet"
	w_class = 3.0
	max_shells = 27
	caliber = "c45s"
	origin_tech = "combat=5;materials=2;syndicate=8"
	ammo_type = "/obj/item/ammo_casing/c45s"
	load_method = 2
	fire_sound = 'hamlet.ogg'
	condition = 1
	blowback = 2
	magtype = /obj/item/ammo_magazine/c45s_hamlet_mag
	emptymag = /obj/item/ammo_magazine/c45s_hamlet_mag/empty
	acc = 50

	upg_sup = 1
	upg_bar = 1
	upg_rap = 1
	upg_stb = 1

/*

"WHAT THE HECK IS THIS SPAGHETTI DOING IN MY CODE?!

I'd fix that, but I'm lazybones.

Best wishes doing that, you other coder."

Silentium

*/

	Fire(atom/target as mob|obj|turf|area, mob/living/user as mob|obj, params, reflex = 0)//TODO: go over this
		if(istype(user, /mob/living))
			var/mob/living/M = user
			if ((CLUMSY in M.mutations) && prob(50)) ///Who ever came up with this...
				M << "\red \the [src] blows up in your face."
				M.take_organ_damage(0,20)
				M.drop_item()
				del(src)
				return

		if (!user.IsAdvancedToolUser())
			user << "\red You don't have the dexterity to do this!"
			return

		add_fingerprint(user)

		var/turf/curloc = user.loc
		var/turf/targloc = get_turf(target)
		if (!istype(targloc) || !istype(curloc))
			return

		if(!special_check(user))
			return
		if(!load_into_chamber())
			user.visible_message("*click click*", "\red <b>*click*</b>")
			for(var/mob/K in viewers(usr))
				K << 'empty.ogg'
			return

		if(!in_chamber)
			return

		if(condition > 0) //phleg
			if(in_chamber)
				if (prob((100 - src.condition)/2))
					user.visible_message("*click click*", "\red <b>*click*</b>")
					for(var/mob/K in viewers(usr))
						K << 'empty.ogg'
					in_chamber = null
					return
			if(condition <= 30)
				if(prob(30))
					user.visible_message("[src] blowout!", "\red <b>[src] blowout!</b>")
					for(var/mob/K in viewers(usr))
						K << 'bang.ogg'
					del(src)
					new /obj/item/weapon/metalparts(user.loc)
					new /obj/item/weapon/metalparts(user.loc)
					new /obj/item/weapon/metalparts(user.loc)


		in_chamber.firer = user
		in_chamber.def_zone = user.zone_sel.selecting

		sleep(src.blowback)

		if(targloc == curloc)
			user.bullet_act(in_chamber)
			del(in_chamber)
			update_icon()
			return

		if(recoil)
			spawn()
				shake_camera(user, recoil + 1, recoil)

		if(silenced)
			playsound(user, 'silencedgun.ogg', 30, 1)
		else
			playsound(loc, fire_sound, 100)
			if(reflex)
				user.visible_message("\red \The [user] fires \the [src] by reflex!", "\red You reflex fire \the [src]!", "\blue You hear a [istype(in_chamber, /obj/item/projectile/beam) ? "laser blast" : "gunshot"]!")
			else
				user.visible_message("\red \The [user] fires \the [src]!", "\red You fire \the [src]!", "\blue You hear a [istype(in_chamber, /obj/item/projectile/beam) ? "laser blast" : "gunshot"]!")

		in_chamber.original = targloc
		in_chamber.loc = get_turf(user)
		in_chamber.starting = get_turf(user)
		user.next_move = world.time + 4
		in_chamber.silenced = silenced
		in_chamber.current = curloc
		if(acc > 0)
			if(prob(acc))
				in_chamber.yo = (targloc.y + pick(-1,1)) - curloc.y
				in_chamber.xo = (targloc.x + pick(-1,1)) - curloc.x
			else
				in_chamber.yo = targloc.y - curloc.y
				in_chamber.xo = targloc.x - curloc.x
		else
			in_chamber.yo = targloc.y - curloc.y
			in_chamber.xo = targloc.x - curloc.x

		if(params)
			var/list/mouse_control = params2list(params)
			if(mouse_control["icon-x"])
				in_chamber.p_x = text2num(mouse_control["icon-x"])
			if(mouse_control["icon-y"])
				in_chamber.p_y = text2num(mouse_control["icon-y"])

		spawn()
			if(in_chamber)
				in_chamber.fired()
		sleep(1)
		in_chamber = null
///

		if(istype(user, /mob/living))
			var/mob/living/M = user
			if ((CLUMSY in M.mutations) && prob(50)) ///Who ever came up with this...
				M << "\red \the [src] blows up in your face."
				M.take_organ_damage(0,20)
				M.drop_item()
				del(src)
				return

		add_fingerprint(user)


		if (!istype(targloc) || !istype(curloc))
			return

		if(!special_check(user))
			return
		if(!load_into_chamber())
			user.visible_message("*click click*", "\red <b>*click*</b>")
			for(var/mob/K in viewers(usr))
				K << 'empty.ogg'
			return

		if(!in_chamber)
			return

		in_chamber.firer = user
		in_chamber.def_zone = user.zone_sel.selecting

		sleep(src.blowback)

		if(targloc == curloc)
			user.bullet_act(in_chamber)
			del(in_chamber)
			update_icon()
			return

		in_chamber.original = targloc
		in_chamber.loc = get_turf(user)
		in_chamber.starting = get_turf(user)
		user.next_move = world.time + 4
		in_chamber.silenced = silenced
		in_chamber.current = curloc
		if(acc > 0)
			if(prob(acc+10))
				in_chamber.yo = (targloc.y + pick(-1,1)) - curloc.y
				in_chamber.xo = (targloc.x + pick(-1,1)) - curloc.x
			else
				in_chamber.yo = targloc.y - curloc.y
				in_chamber.xo = targloc.x - curloc.x
		else
			in_chamber.yo = targloc.y - curloc.y
			in_chamber.xo = targloc.x - curloc.x

		if(params)
			var/list/mouse_control = params2list(params)
			if(mouse_control["icon-x"])
				in_chamber.p_x = text2num(mouse_control["icon-x"])
			if(mouse_control["icon-y"])
				in_chamber.p_y = text2num(mouse_control["icon-y"])

		spawn()
			if(in_chamber)
				in_chamber.fired()
		sleep(1)
		in_chamber = null

///
		if(istype(user, /mob/living))
			var/mob/living/M = user
			if ((CLUMSY in M.mutations) && prob(50)) ///Who ever came up with this...
				M << "\red \the [src] blows up in your face."
				M.take_organ_damage(0,20)
				M.drop_item()
				del(src)
				return

		add_fingerprint(user)

		if (!istype(targloc) || !istype(curloc))
			return

		if(!special_check(user))
			return
		if(!load_into_chamber())
			user.visible_message("*click click*", "\red <b>*click*</b>")
			for(var/mob/K in viewers(usr))
				K << 'empty.ogg'
			return

		if(!in_chamber)
			return

		in_chamber.firer = user
		in_chamber.def_zone = user.zone_sel.selecting

		sleep(src.blowback)

		if(targloc == curloc)
			user.bullet_act(in_chamber)
			del(in_chamber)
			update_icon()
			return

		in_chamber.original = targloc
		in_chamber.loc = get_turf(user)
		in_chamber.starting = get_turf(user)
		user.next_move = world.time + 4
		in_chamber.silenced = silenced
		in_chamber.current = curloc
		if(acc > 0)
			if(prob(acc+20))
				in_chamber.yo = (targloc.y + pick(-1,1)) - curloc.y
				in_chamber.xo = (targloc.x + pick(-1,1)) - curloc.x
			else
				in_chamber.yo = targloc.y - curloc.y
				in_chamber.xo = targloc.x - curloc.x
		else
			in_chamber.yo = targloc.y - curloc.y
			in_chamber.xo = targloc.x - curloc.x

		if(params)
			var/list/mouse_control = params2list(params)
			if(mouse_control["icon-x"])
				in_chamber.p_x = text2num(mouse_control["icon-x"])
			if(mouse_control["icon-y"])
				in_chamber.p_y = text2num(mouse_control["icon-y"])

		spawn()
			if(in_chamber)
				in_chamber.fired()
		sleep(1)
		in_chamber = null


		update_icon()
		return

/obj/item/weapon/gun/projectile/automatic/tommy //gemini
	name = "\improper Tomcat SMG"
	desc = "Good ol' chap Tommygun, you can never get bored shooting it. Not even after hundreds of years. Uses c22 rounds."
	icon_state = "tommy"
	w_class = 3.0
	max_shells = 30
	caliber = "c22"
	origin_tech = "combat=5;materials=2;syndicate=8"
	ammo_type = "/obj/item/ammo_casing/c22"
	load_method = 2
	fire_sound = 'tommyburst.ogg'
	automatic = 1
	condition = 1
	blowback = 1
	magtype = /obj/item/ammo_magazine/c22_tommy_mag
	emptymag = /obj/item/ammo_magazine/c22_tommy_mag/empty
	acc = 20

	upg_sup = 1
	upg_bar = 1
	upg_rap = 1
	upg_stb = 1

/*

Same as the above. Looks like Catratcat didn't give a single schtick about things like "optimisation"...

Welp, same as the above, not any of my concern.

*/

	Fire(atom/target as mob|obj|turf|area, mob/living/user as mob|obj, params, reflex = 0)//TODO: go over this
		if(istype(user, /mob/living))
			var/mob/living/M = user
			if ((CLUMSY in M.mutations) && prob(50)) ///Who ever came up with this...
				M << "\red \the [src] blows up in your face."
				M.take_organ_damage(0,20)
				M.drop_item()
				del(src)
				return

		if (!user.IsAdvancedToolUser())
			user << "\red You don't have the dexterity to do this!"
			return

		add_fingerprint(user)

		var/turf/curloc = user.loc
		var/turf/targloc = get_turf(target)
		if (!istype(targloc) || !istype(curloc))
			return

		if(!special_check(user))
			return
		if(!load_into_chamber())
			user.visible_message("*click click*", "\red <b>*click*</b>")
			for(var/mob/K in viewers(usr))
				K << 'empty.ogg'
			return

		if(!in_chamber)
			return

		if(condition > 0) //phleg
			if(in_chamber)
				if (prob((100 - src.condition)/2))
					user.visible_message("*click click*", "\red <b>*click*</b>")
					for(var/mob/K in viewers(usr))
						K << 'empty.ogg'
					in_chamber = null
					return
			if(condition <=5)
				user.visible_message("[src] blowout!", "\red <b>[src] blowout!</b>")
				for(var/mob/K in viewers(usr))
					K << 'bang.ogg'
				del(src)
				new /obj/item/weapon/metalparts(user.loc)
				new /obj/item/weapon/metalparts(user.loc)
				new /obj/item/weapon/metalparts(user.loc)

		in_chamber.firer = user
		in_chamber.def_zone = user.zone_sel.selecting

		sleep(src.blowback)

		if(targloc == curloc)
			user.bullet_act(in_chamber)
			del(in_chamber)
			update_icon()
			return

		if(recoil)
			spawn()
				shake_camera(user, recoil + 1, recoil)

		if(silenced)
			playsound(user, 'silencedgun.ogg', 30, 1)
		else
			playsound(loc, fire_sound, 100)
			if(reflex)
				user.visible_message("\red \The [user] fires \the [src] by reflex!", "\red You reflex fire \the [src]!", "\blue You hear a [istype(in_chamber, /obj/item/projectile/beam) ? "laser blast" : "gunshot"]!")
			else
				user.visible_message("\red \The [user] fires \the [src]!", "\red You fire \the [src]!", "\blue You hear a [istype(in_chamber, /obj/item/projectile/beam) ? "laser blast" : "gunshot"]!")

		in_chamber.original = targloc
		in_chamber.loc = get_turf(user)
		in_chamber.starting = get_turf(user)
		user.next_move = world.time + 4
		in_chamber.silenced = silenced
		in_chamber.current = curloc
		if(acc > 0)
			if(prob(acc))
				in_chamber.yo = (targloc.y + pick(-1,1)) - curloc.y
				in_chamber.xo = (targloc.x + pick(-1,1)) - curloc.x
			else
				in_chamber.yo = targloc.y - curloc.y
				in_chamber.xo = targloc.x - curloc.x
		else
			in_chamber.yo = targloc.y - curloc.y
			in_chamber.xo = targloc.x - curloc.x

		if(params)
			var/list/mouse_control = params2list(params)
			if(mouse_control["icon-x"])
				in_chamber.p_x = text2num(mouse_control["icon-x"])
			if(mouse_control["icon-y"])
				in_chamber.p_y = text2num(mouse_control["icon-y"])

		spawn()
			if(in_chamber)
				in_chamber.fired()
		sleep(1)
		in_chamber = null
///

		if(istype(user, /mob/living))
			var/mob/living/M = user
			if ((CLUMSY in M.mutations) && prob(50)) ///Who ever came up with this...
				M << "\red \the [src] blows up in your face."
				M.take_organ_damage(0,20)
				M.drop_item()
				del(src)
				return

		add_fingerprint(user)


		if (!istype(targloc) || !istype(curloc))
			return

		if(!special_check(user))
			return
		if(!load_into_chamber())
			user.visible_message("*click click*", "\red <b>*click*</b>")
			for(var/mob/K in viewers(usr))
				K << 'empty.ogg'
			return

		if(!in_chamber)
			return

		in_chamber.firer = user
		in_chamber.def_zone = user.zone_sel.selecting

		sleep(src.blowback)

		if(targloc == curloc)
			user.bullet_act(in_chamber)
			del(in_chamber)
			update_icon()
			return

		in_chamber.original = targloc
		in_chamber.loc = get_turf(user)
		in_chamber.starting = get_turf(user)
		user.next_move = world.time + 4
		in_chamber.silenced = silenced
		in_chamber.current = curloc
		if(acc > 0)
			if(prob(acc+5))
				in_chamber.yo = (targloc.y + pick(-1,1)) - curloc.y
				in_chamber.xo = (targloc.x + pick(-1,1)) - curloc.x
			else
				in_chamber.yo = targloc.y - curloc.y
				in_chamber.xo = targloc.x - curloc.x
		else
			in_chamber.yo = targloc.y - curloc.y
			in_chamber.xo = targloc.x - curloc.x

		if(params)
			var/list/mouse_control = params2list(params)
			if(mouse_control["icon-x"])
				in_chamber.p_x = text2num(mouse_control["icon-x"])
			if(mouse_control["icon-y"])
				in_chamber.p_y = text2num(mouse_control["icon-y"])

		spawn()
			if(in_chamber)
				in_chamber.fired()
		sleep(1)
		in_chamber = null

///
		if(istype(user, /mob/living))
			var/mob/living/M = user
			if ((CLUMSY in M.mutations) && prob(50)) ///Who ever came up with this...
				M << "\red \the [src] blows up in your face."
				M.take_organ_damage(0,20)
				M.drop_item()
				del(src)
				return

		add_fingerprint(user)

		if (!istype(targloc) || !istype(curloc))
			return

		if(!special_check(user))
			return
		if(!load_into_chamber())
			user.visible_message("*click click*", "\red <b>*click*</b>")
			for(var/mob/K in viewers(usr))
				K << 'empty.ogg'
			return

		if(!in_chamber)
			return

		in_chamber.firer = user
		in_chamber.def_zone = user.zone_sel.selecting

		sleep(src.blowback)

		if(targloc == curloc)
			user.bullet_act(in_chamber)
			del(in_chamber)
			update_icon()
			return

		in_chamber.original = targloc
		in_chamber.loc = get_turf(user)
		in_chamber.starting = get_turf(user)
		user.next_move = world.time + 4
		in_chamber.silenced = silenced
		in_chamber.current = curloc
		if(acc > 0)
			if(prob(acc+10))
				in_chamber.yo = (targloc.y + pick(-1,1)) - curloc.y
				in_chamber.xo = (targloc.x + pick(-1,1)) - curloc.x
			else
				in_chamber.yo = targloc.y - curloc.y
				in_chamber.xo = targloc.x - curloc.x
		else
			in_chamber.yo = targloc.y - curloc.y
			in_chamber.xo = targloc.x - curloc.x

		if(params)
			var/list/mouse_control = params2list(params)
			if(mouse_control["icon-x"])
				in_chamber.p_x = text2num(mouse_control["icon-x"])
			if(mouse_control["icon-y"])
				in_chamber.p_y = text2num(mouse_control["icon-y"])

		spawn()
			if(in_chamber)
				in_chamber.fired()
		sleep(1)
		in_chamber = null


		update_icon()
		return

/obj/item/weapon/gun/projectile/automatic/mac
	name = "MAC-15"
	desc = "A lightweight and cheap SMG by Triss Arms. Uses 9mm rounds."
	icon_state = "mac"
	w_class = 3.0
	max_shells = 30
	caliber = "c9mm"
	origin_tech = "combat=5;materials=2;syndicate=8"
	ammo_type = "/obj/item/ammo_casing/c9mm"
	load_method = 2
	fire_sound = 'tommyburst.ogg'
	condition = 1
	magtype = /obj/item/ammo_magazine/c9mm_mac_mag
	emptymag = /obj/item/ammo_magazine/c9mm_mac_mag/empty
	acc = 60

	upg_sup = 1
	upg_bar = 1
	upg_rap = 1
	upg_stb = 1

/*

Catratcat should be burning in coder hell for this.

*/

	Fire(atom/target as mob|obj|turf|area, mob/living/user as mob|obj, params, reflex = 0)//TODO: go over this
		if(istype(user, /mob/living))
			var/mob/living/M = user
			if ((CLUMSY in M.mutations) && prob(50)) ///Who ever came up with this...
				M << "\red \the [src] blows up in your face."
				M.take_organ_damage(0,20)
				M.drop_item()
				del(src)
				return

		if (!user.IsAdvancedToolUser())
			user << "\red You don't have the dexterity to do this!"
			return

		add_fingerprint(user)

		var/turf/curloc = user.loc
		var/turf/targloc = get_turf(target)
		if (!istype(targloc) || !istype(curloc))
			return

		if(!special_check(user))
			return
		if(!load_into_chamber())
			user.visible_message("*click click*", "\red <b>*click*</b>")
			for(var/mob/K in viewers(usr))
				K << 'empty.ogg'
			return

		if(!in_chamber)
			return

		if(condition > 0) //phleg
			if(in_chamber)
				if (prob((100 - src.condition)/2))
					user.visible_message("*click click*", "\red <b>*click*</b>")
					for(var/mob/K in viewers(usr))
						K << 'empty.ogg'
					in_chamber = null
					return
			if(condition <= 30)
				if(prob(30))
					user.visible_message("[src] blowout!", "\red <b>[src] blowout!</b>")
					for(var/mob/K in viewers(usr))
						K << 'bang.ogg'
					del(src)
					new /obj/item/weapon/metalparts(user.loc)
					new /obj/item/weapon/metalparts(user.loc)
					new /obj/item/weapon/metalparts(user.loc)


		in_chamber.firer = user
		in_chamber.def_zone = user.zone_sel.selecting

		sleep(src.blowback)

		if(targloc == curloc)
			user.bullet_act(in_chamber)
			del(in_chamber)
			update_icon()
			return

		if(recoil)
			spawn()
				shake_camera(user, recoil + 1, recoil)

		if(silenced)
			playsound(user, 'silencedgun.ogg', 30, 1)
		else
			playsound(loc, fire_sound, 100)
			if(reflex)
				user.visible_message("\red \The [user] fires \the [src] by reflex!", "\red You reflex fire \the [src]!", "\blue You hear a [istype(in_chamber, /obj/item/projectile/beam) ? "laser blast" : "gunshot"]!")
			else
				user.visible_message("\red \The [user] fires \the [src]!", "\red You fire \the [src]!", "\blue You hear a [istype(in_chamber, /obj/item/projectile/beam) ? "laser blast" : "gunshot"]!")

		in_chamber.original = targloc
		in_chamber.loc = get_turf(user)
		in_chamber.starting = get_turf(user)
		user.next_move = world.time + 4
		in_chamber.silenced = silenced
		in_chamber.current = curloc
		if(acc > 0)
			if(prob(acc))
				in_chamber.yo = (targloc.y + pick(-1,1)) - curloc.y
				in_chamber.xo = (targloc.x + pick(-1,1)) - curloc.x
			else
				in_chamber.yo = targloc.y - curloc.y
				in_chamber.xo = targloc.x - curloc.x
		else
			in_chamber.yo = targloc.y - curloc.y
			in_chamber.xo = targloc.x - curloc.x

		if(params)
			var/list/mouse_control = params2list(params)
			if(mouse_control["icon-x"])
				in_chamber.p_x = text2num(mouse_control["icon-x"])
			if(mouse_control["icon-y"])
				in_chamber.p_y = text2num(mouse_control["icon-y"])

		spawn()
			if(in_chamber)
				in_chamber.fired()
		sleep(1)
		in_chamber = null
///

		if(istype(user, /mob/living))
			var/mob/living/M = user
			if ((CLUMSY in M.mutations) && prob(50)) ///Who ever came up with this...
				M << "\red \the [src] blows up in your face."
				M.take_organ_damage(0,20)
				M.drop_item()
				del(src)
				return

		add_fingerprint(user)


		if (!istype(targloc) || !istype(curloc))
			return

		if(!special_check(user))
			return
		if(!load_into_chamber())
			user.visible_message("*click click*", "\red <b>*click*</b>")
			for(var/mob/K in viewers(usr))
				K << 'empty.ogg'
			return

		if(!in_chamber)
			return

		in_chamber.firer = user
		in_chamber.def_zone = user.zone_sel.selecting

		sleep(src.blowback)

		if(targloc == curloc)
			user.bullet_act(in_chamber)
			del(in_chamber)
			update_icon()
			return

		in_chamber.original = targloc
		in_chamber.loc = get_turf(user)
		in_chamber.starting = get_turf(user)
		user.next_move = world.time + 4
		in_chamber.silenced = silenced
		in_chamber.current = curloc
		if(acc > 0)
			if(prob(acc+10))
				in_chamber.yo = (targloc.y + pick(-1,1)) - curloc.y
				in_chamber.xo = (targloc.x + pick(-1,1)) - curloc.x
			else
				in_chamber.yo = targloc.y - curloc.y
				in_chamber.xo = targloc.x - curloc.x
		else
			in_chamber.yo = targloc.y - curloc.y
			in_chamber.xo = targloc.x - curloc.x

		if(params)
			var/list/mouse_control = params2list(params)
			if(mouse_control["icon-x"])
				in_chamber.p_x = text2num(mouse_control["icon-x"])
			if(mouse_control["icon-y"])
				in_chamber.p_y = text2num(mouse_control["icon-y"])

		spawn()
			if(in_chamber)
				in_chamber.fired()
		sleep(1)
		in_chamber = null

///
		if(istype(user, /mob/living))
			var/mob/living/M = user
			if ((CLUMSY in M.mutations) && prob(50)) ///Who ever came up with this...
				M << "\red \the [src] blows up in your face."
				M.take_organ_damage(0,20)
				M.drop_item()
				del(src)
				return

		add_fingerprint(user)

		if (!istype(targloc) || !istype(curloc))
			return

		if(!special_check(user))
			return
		if(!load_into_chamber())
			user.visible_message("*click click*", "\red <b>*click*</b>")
			for(var/mob/K in viewers(usr))
				K << 'empty.ogg'
			return

		if(!in_chamber)
			return

		in_chamber.firer = user
		in_chamber.def_zone = user.zone_sel.selecting

		sleep(src.blowback)

		if(targloc == curloc)
			user.bullet_act(in_chamber)
			del(in_chamber)
			update_icon()
			return

		in_chamber.original = targloc
		in_chamber.loc = get_turf(user)
		in_chamber.starting = get_turf(user)
		user.next_move = world.time + 4
		in_chamber.silenced = silenced
		in_chamber.current = curloc
		if(acc > 0)
			if(prob(acc+10))
				in_chamber.yo = (targloc.y + pick(-1,1)) - curloc.y
				in_chamber.xo = (targloc.x + pick(-1,1)) - curloc.x
			else
				in_chamber.yo = targloc.y - curloc.y
				in_chamber.xo = targloc.x - curloc.x
		else
			in_chamber.yo = targloc.y - curloc.y
			in_chamber.xo = targloc.x - curloc.x

		if(params)
			var/list/mouse_control = params2list(params)
			if(mouse_control["icon-x"])
				in_chamber.p_x = text2num(mouse_control["icon-x"])
			if(mouse_control["icon-y"])
				in_chamber.p_y = text2num(mouse_control["icon-y"])

		spawn()
			if(in_chamber)
				in_chamber.fired()
		sleep(1)
		in_chamber = null


		update_icon()
		return