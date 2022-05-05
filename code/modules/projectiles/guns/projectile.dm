//This file was auto-corrected by findeclaration.exe on 29/05/2012 15:03:05

/obj/item/weapon/gun/projectile
	desc = "A classic revolver. Uses 357 ammo"
	name = "revolver"
	icon_state = "revolver"
	caliber = "357"
	origin_tech = "combat=2;materials=2"
	w_class = 3.0
	m_amt = 1000
	force = 10 //Pistol whipp'n good.  (It was frigging SIXTY on pre-goon code)

	var/ammo_type = "/obj/item/ammo_casing/a357"
	var/list/loaded = list()
	var/max_shells = 7
	var/load_method = 0 //0 = Single shells or quick loader, 1 = box, 2 = magazine
	var/obj/item/ammo_magazine/empty_mag = null

	var/recentpump = 0 // to prevent spammage
	var/pumped = 0
	var/obj/item/ammo_casing/current_shell = null

	var/magtype = null
	var/emptymag = null
	var/hasmag = 1

	New()
		..()
		for(var/i = 1, i <= max_shells, i++)
			loaded += new ammo_type(src)
		update_icon()

		if(condition >= 1)
			condition = rand (80, 100) //phleg

		return


	load_into_chamber()
		if(in_chamber)
			return 1

		if(!loaded.len)
			return 0

		var/obj/item/ammo_casing/AC = loaded[1] //load next casing.
		loaded -= AC //Remove casing from loaded list.

		AC.icon_state = "s-casing" //phleg

		AC.loc = get_turf(src) //Eject casing onto ground.
		AC.desc += " This one is spent."	//descriptions are magic

		if(AC.BB)
			in_chamber = AC.BB //Load projectile into chamber.
			AC.BB.loc = src //Set projectile loc to gun.
			return 1
		return 0

	MouseDrop(obj/over_object as obj, src_location, over_location, var/obj/item/A as obj)
		if(ishuman(usr))
			var/mob/living/carbon/human/M = usr
			if(emptymag!= null && hasmag ==1)
				if(src.loaded.len == 0)
					if (!( istype(over_object, /obj/screen) ))
						return ..()
					playsound("magout.ogg", 100,0,1)
					if (!( M.restrained() ) && !( M.stat ))
						if (over_object.name == "r_hand")
							if (!( M.r_hand ))
								M.equip_if_possible(new emptymag(M), M.slot_r_hand)
								src.hasmag = 0
								icon_state = "[initial(icon_state)]_empty"
								M.update_clothing()

						else
							if (over_object.name == "l_hand")
								if (!( M.l_hand ))
									M.equip_if_possible(new emptymag(M), M.slot_l_hand)
									src.hasmag = 0
									M.update_clothing()

						return
				else
					usr << "\blue magazine locked inside and contains rounds."
			else
				usr << "\blue [src] has no magazine."
//			if(over_object == usr && in_range(src, usr) || usr.contents.Find(src))
//				usr.s_active.close(usr)
//			src.show_to(usr)
		return

	attackby(var/obj/item/A as obj, mob/user as mob)
		var/num_loaded = 0
		if(istype(A, /obj/item/ammo_magazine))
		//	if((load_method == 2) && loaded.len)	return
			var/obj/item/ammo_magazine/AM = A
			for(var/obj/item/ammo_casing/AC in AM.contents)
				if(loaded.len >= max_shells)
					break
				if(AC.caliber == caliber && src.loaded.len < src.max_shells)
					if(load_method == 2)
						if((magtype == AM.type || emptymag == AM.type) && src.loaded.len == 0 && hasmag == 0)
							src.loaded = AM.contents
							user.remove_from_mob(AM)
							src.hasmag = 1
							icon_state = "[initial(icon_state)]"
							user.update_clothing()
							playsound("magout.ogg", 100,0,1)
							break
						else
							user << "\blue This is wrong!"
							break
					else
						AC.loc = src
						AM.contents -= AC
						loaded += AC
						num_loaded++

/*
			if(load_method == 2)
				user.remove_from_mob(AM)
				empty_mag = AM
				empty_mag.loc = src
*/
		if(istype(A, /obj/item/ammo_magazine/bolt))
			if((load_method == 2) && loaded.len)	return
			var/obj/item/ammo_magazine/AM = A
			for(var/obj/item/ammo_casing/AC in AM.contents)
				if(loaded.len >= max_shells)
					user << "\blue You already load ammo into [src]!"
					return
				if(AC.caliber == caliber && loaded.len < max_shells)
					AC.loc = src
					AM.contents -= AC
					loaded += AC
					num_loaded++
			if(load_method == 2)
				user.remove_from_mob(AM)
				empty_mag = AM
	//			empty_mag.loc = src
				del(A)
/*
		if(istype(A, /obj/item/ammo_magazine/c45b))
			if((load_method == 2) && loaded.len)	return
			var/obj/item/ammo_magazine/AM = A
			for(var/obj/item/ammo_casing/AC in AM.stored_ammo)
				if(loaded.len >= max_shells)
					user << "\blue You already load ammo into [src]!"
					return
				if(AC.caliber == caliber && loaded.len < max_shells)
					AC.loc = src
					AM.stored_ammo -= AC
					loaded += AC
					num_loaded++
			if(load_method == 0)
				user.remove_from_mob(AM)
				empty_mag = AM
	//			empty_mag.loc = src
				del(A)
*/
		if(istype(A, /obj/item/ammo_magazine/rocket))
			if((load_method == 2) && loaded.len)	return
			var/obj/item/ammo_magazine/AM = A
			for(var/obj/item/ammo_casing/AC in AM.contents)
				if(loaded.len >= max_shells)
					user << "\blue You already load ammo into [src]!"
					return
				if(AC.caliber == caliber && loaded.len < max_shells)
					AC.loc = src
					AM.contents -= AC
					loaded += AC
					num_loaded++
			if(load_method == 0)
				user.remove_from_mob(AM)
				empty_mag = AM
		//		empty_mag.loc = src
				del(A)

		if(istype(A, /obj/item/ammo_casing) && !load_method)
			var/obj/item/ammo_casing/AC = A
			if(AC.caliber == caliber && loaded.len < max_shells)
				user.drop_item()
				AC.loc = src
				loaded += AC
				num_loaded++
		if(num_loaded)
			user << "\blue You load [num_loaded] shell\s into the gun!"
		A.update_icon()


		if(istype(A, /obj/item/weapon/rasp))
			if (src.condition < 100 && src.condition != 0)
				user << "\blue You start repair the [src] with tool"
				sleep(50)
				user << "\blue You fix the [src]"
				src.condition += 5
				if (prob(100 - src.condition))
					del(A)

		if(istype(A, /obj/item/weapon/gunsmith/upgrade))
			if(istype(A, /obj/item/weapon/gunsmith/upgrade/suppressor) && src.upg_sup == 1)
				user << "\blue You began installing upgrade."
				sleep(80)
				src.silenced = 1
				src.acc += 10
				if(src.blowback >= 1)
					src.blowback -= 1
				user << "\blue Success!"
				src.upg_sup = 2
				src.desc += " [A.name]."
				if(src.condition <= 90 && src.condition != 0)
					src.condition += 10
				del(A)
				return
			if(istype(A, /obj/item/weapon/gunsmith/upgrade/barrelarm) && src.upg_bar == 1)
				user << "\blue You began installing upgrade."
				sleep(80)
				src.blowback += 2
				if(src.acc >= 10)
					src.acc -= 10
				user << "\blue Success!"
				src.upg_bar = 2
				src.desc += " [A.name]."
				if(src.condition <= 90 && src.condition != 0)
					src.condition += 10
				del(A)
				return
			if(istype(A, /obj/item/weapon/gunsmith/upgrade/rapidblowback) && src.upg_rap == 1)
				user << "\blue You began installing upgrade."
				sleep(80)
				src.acc += 20
				if(src.blowback >= 3)
					src.blowback -= 3
				else
					src.blowback = 0
				user << "\blue Success!"
				src.upg_rap = 2
				src.desc += " [A.name]."
				if(src.condition <= 90 && src.condition != 0)
					src.condition += 10
				del(A)
				return
			if(istype(A, /obj/item/weapon/gunsmith/upgrade/autofire) && src.upg_aut == 1)
				user << "\blue You began installing upgrade."
				sleep(80)
				user << "\blue Success!"
				src.upg_aut = 2
				src.desc += " [A.name]."
				src.acc += 20
				if(src.condition <= 90 && src.condition != 0)
					src.condition += 10
				del(A)
				return
			if(istype(A, /obj/item/weapon/gunsmith/upgrade/stabilizer) && src.upg_stb == 1)
				user << "\blue You began installing upgrade."
				sleep(80)
				src.blowback += 3
				if(src.acc >= 30)
					src.acc -= 30
				else
					src.acc = 0
				user << "\blue Success!"
				upg_stb = 2
				src.desc += " [A.name]."
				if(src.condition <= 90 && src.condition != 0)
					src.condition += 10
				del(A)
				return
			else
				user << "\blue You can not install upgrade on [src]!"
		return




	examine()
		..()
		usr << "Has [loaded.len] round\s remaining."
		if(in_chamber && !loaded.len)
			usr << "However, it has a chambered round."
		if(in_chamber && loaded.len)
			usr << "It also has a chambered round."

		if(condition > 0)
			usr << "Condition is [condition] %."

		return

	proc/pump(mob/M as mob)
		playsound(M, 'shotgunpump.ogg', 60, 1)
		pumped = 0
		if(current_shell)//We have a shell in the chamber
			current_shell.loc = get_turf(src)//Eject casing
			current_shell = null
			if(in_chamber)
				in_chamber = null
		if(!loaded.len)	return 0
		var/obj/item/ammo_casing/AC = loaded[1] //load next casing.
		loaded -= AC //Remove casing from loaded list.
		current_shell = AC
		if(AC.BB)
			in_chamber = AC.BB //Load projectile into chamber.
		update_icon()	//I.E. fix the desc
		return 1

	attack_self(mob/living/carbon/human/M as mob)
//phleg
		if(istype(src, /obj/item/weapon/gun/projectile/shotgun/pump))
			if(..())
				if(recentpump)	return
				pump()
				recentpump = 1
				spawn(10)
					recentpump = 0
			return

		if(istype(src, /obj/item/weapon/gun/projectile/shotgun))
			if(..())
				if(!(locate(/obj/item/ammo_casing/shotgun) in src) && !loaded.len)
					usr << "<span class='notice'>\The [src] is empty.</span>"
					return

				for(var/obj/item/ammo_casing/shotgun/shell in src)	//This feels like a hack.	//don't code at 3:30am kids!!
					if(shell in loaded)
						loaded -= shell
					shell.loc = get_turf(src.loc)

				usr << "<span class='notice'>You break \the [src].</span>"
				update_icon()
			return
//phleg
		if(armed ==0)
			armed = 1
			usr << "\blue [src] is loaded"
			for(var/mob/K in viewers(usr))
				M << 'arming.ogg'
			return
		if(armed ==1)
			usr << "\blue [src] is loaded"
			for(var/mob/K in viewers(usr))
				K << 'arming.ogg'
//			spawn()
//			if(in_chamber)
//				M.bullet_act(in_chamber)
//				del(in_chamber)
//				update_icon()

			return