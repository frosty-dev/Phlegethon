/obj/item/weapon/gun/projectile/silenced
	name = "\improper Silenced Pistol"
	desc = "A small, quiet,  easily concealable gun. Uses .45 rounds."
	icon_state = "silenced_pistol"
	w_class = 3.0
	max_shells = 12
	caliber = ".45"
	silenced = 1
	origin_tech = "combat=2;materials=2;syndicate=8"
	ammo_type = "/obj/item/ammo_casing/c45"



/obj/item/weapon/gun/projectile/deagle
	name = "\improper Desert Eagle"
	desc = "A robust handgun that uses .50 AE ammo"
	icon_state = "deagle"
	force = 14.0
	max_shells = 7
	caliber = ".50"
	ammo_type ="/obj/item/ammo_casing/a50"
	load_method = 2
	New()
		..()
		empty_mag = new /obj/item/ammo_magazine/a50/empty(src)
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
		return

/obj/item/weapon/gun/projectile/deagle/gold
	name = "\improper Desert Eagle"
	desc = "A gold plated gun folded over a million times by superior martian gunsmiths. Uses .50 AE ammo."
	icon_state = "deagleg"
	item_state = "deagleg"



/obj/item/weapon/gun/projectile/deagle/camo
	name = "\improper Desert Eagle"
	desc = "A Deagle brand Deagle for operators operating operationally. Uses .50 AE ammo."
	icon_state = "deaglecamo"
	item_state = "deagleg"

/obj/item/weapon/gun/projectile/gyropistol
	name = "\improper Gyrojet Pistol"
	desc = "A bulky pistol designed to fire self propelled rounds"
	icon_state = "gyropistol"
	max_shells = 8
	caliber = "a75"
	fire_sound = 'Explosion1.ogg'
	origin_tech = "combat=3"
	ammo_type = "/obj/item/ammo_casing/a75"
//==================================================


/obj/item/weapon/gun/projectile/zipgun
	name = "Zipgun"
	desc = "A spawn of someone's wild imagination and lots of spare time. Not much of a handgun, it will probably just backfire right into your face the very first time you try to shoot it."
	icon_state = "zipgun"
	caliber = "c22"
	ammo_type = "/obj/item/ammo_casing/c22"
	load_method = 0
	max_shells = 1
	acc = 80
	var/zip_mod_count = 1
	blowout_chance = 5

/obj/item/weapon/gun/projectile/zipgun/attackby(obj/item/weapon/W as obj, mob/user as mob)
	..()
	if(istype(W, /obj/item/weapon/screwdriver))
		if(zip_mod_count == 1)
			user << "<span class='notice'>You begin to expand the barrel of [src]...</span>"
			if(loaded.len)
				afterattack(user, user)	//you know the drill
				playsound(user, fire_sound, 50, 1)
				user.visible_message("<span class='danger'>[src] goes off!</span>", "<span class='danger'>[src] goes off in your face!</span>")
				return
			else
				sleep(100)
				caliber = "c9mm"
				user << "<span class='notice'>You reinforce the barrel of [src]. Now it will fire 9mm rounds.</span>"
				zip_mod_count = 2
				blowout_chance = 10
				return
		else if(zip_mod_count == 2)
			user << "<span class='notice'>You begin to expand the barrel of [src]...</span>"
			if(loaded.len)
				afterattack(user, user)	//and again
				playsound(user, fire_sound, 50, 1)
				user.visible_message("<span class='danger'>[src] goes off!</span>", "<span class='danger'>[src] goes off in your face!</span>")
				return
			else
				sleep(100)
				caliber = "c38s"
				user << "<span class='notice'>You reinforce the barrel of [src]. Now it will fire .38 Special rounds.</span>"
				zip_mod_count = 3
				blowout_chance = 15
				return
		else if(zip_mod_count == 3)
			user << "<span class='notice'>You begin to expand the barrel of [src]...</span>"
			if(loaded.len)
				afterattack(user, user)	//and again
				playsound(user, fire_sound, 50, 1)
				user.visible_message("<span class='danger'>[src] goes off!</span>", "<span class='danger'>[src] goes off in your face!</span>")
				return
			else
				sleep(100)
				caliber = ".45b"
				user << "<span class='notice'>You reinforce the barrel of [src]. Now it will fire .45-70 rounds.</span>"
				zip_mod_count = 4
				blowout_chance = 20
				return
		else if(zip_mod_count == 4)
			user << "<span class='notice'>You begin to expand the barrel of [src]...</span>"
			if(loaded.len)
				afterattack(user, user)	//and again
				playsound(user, fire_sound, 50, 1)
				user.visible_message("<span class='danger'>[src] goes off!</span>", "<span class='danger'>[src] goes off in your face!</span>")
				return
			else
				sleep(100)
				caliber = ".50"
				user << "<span class='notice'>You reinforce the barrel of [src]. Now it will fire .50 rounds.</span>"
				zip_mod_count = 5
				blowout_chance = 25
				return
		else if(zip_mod_count == 5)
			user << "<span class='notice'>You begin to expand the barrel of [src]...</span>"
			if(loaded.len)
				afterattack(user, user)	//and again
				playsound(user, fire_sound, 50, 1)
				user.visible_message("<span class='danger'>[src] goes off!</span>", "<span class='danger'>[src] goes off in your face!</span>")
				return
			else
				sleep(100)
				caliber = "shotgun"
				user << "<span class='notice'>You reinforce the barrel of [src]. Now it will fire shotgun shells.</span>"
				zip_mod_count = 6
				blowout_chance = 30
				return
		else
			user << "<span class='notice'>You can't expand the barrel any further."

/obj/item/weapon/gun/projectile/crossbow
	name = "makeshift crossbow"
	desc = "Let your inner huntsman go wild. Packs a better punch than bow, but you'll definitely have a hard time reloading this."
	icon_state = "hc_crossbow"
	item_state = "gun"
	caliber = "bolt"
	max_shells = 1
	load_method = 0
	origin_tech = "combat=5;materials=2"
	ammo_type = "/obj/item/ammo_casing/bolt"
	silenced = 1
	fire_sound = 'crossbow.ogg'

/obj/item/weapon/gun/projectile/lferus
	name = "L-Ferus .50"
	desc = "Ignites the cold-blooded."
	icon_state = "lferus"
	caliber = ".50"
	ammo_type = "/obj/item/ammo_casing/fbullet"
	origin_tech = "combat=2;materials=2"
	fire_sound = 'lferus.ogg'
	load_method = 0
	max_shells = 5
	blowback = 8
	acc = 30

	upg_bar = 1
	upg_rap = 1
	upg_aut = 1
	upg_stb = 1

/obj/item/weapon/gun/projectile/bazooka
	name = "\improper Rocket Launcher M1A1"
	desc = "Or simply, Bazooka. Nuff said. This girl doesn't need a famous name to blast your arse into million pieces."
	icon_state = "bazooka"
	item_state = "bazooka"
	max_shells = 1
	w_class = 4
	caliber = "rocket"
	fire_sound = 'Explosion1.ogg'
	origin_tech = "combat=4"
	ammo_type = "/obj/item/ammo_casing/rocket"

/obj/item/weapon/gun/projectile/doubly //gemini
	name = "\improper Doubly"
	desc = "A weak and miniature gun of the last chance."
	icon_state = "doubly"
	item_state = "nothing"
	max_shells = 2
	caliber = "c22"
	w_class = 1.0
	origin_tech = "combat=2"
	ammo_type = "/obj/item/ammo_casing/c22"
	ejectshell = 0
	load_method = 0
	fire_sound = 'doublyshot.ogg'
	acc = 80

/obj/item/weapon/gun/projectile/handy
	name = "\improper Handy MK2"
	desc = "A standard Metropolis Military pistol. Uses .45 rounds."
	icon_state = "handy"
	max_shells = 9
	caliber = "c45s"
	origin_tech = "combat=2;materials=2;syndicate=8"
	ammo_type = "/obj/item/ammo_casing/c45s"
	load_method = 2
	fire_sound = 'handyshot.ogg'
	blowback = 4
	condition = 1
	magtype = /obj/item/ammo_magazine/c45s_handy_mag
	emptymag = /obj/item/ammo_magazine/c45s_handy_mag/empty
	acc = 30

	upg_sup = 1
	upg_bar = 1
	upg_rap = 1
	upg_aut = 1
	upg_stb = 1

/obj/item/weapon/gun/projectile/gauss
	name = "\improper Gauss Rifle MK6"
	desc = "High-tech rifle, powered by the magnets inside. Despite having a low caliber, physical laws allow it to shoot right through anything, including walls, doors and, doubtlessly, your brain."
	silenced = 1
	icon_state = "gauss"
	item_state = "OLDshotgun"
	max_shells = 6
	w_class = 4.0
	caliber = "gauss"
	ammo_type = "/obj/item/ammo_casing/gauss"
	origin_tech = "combat=5;materials=4;syndicate=6"
	load_method = 2
	fire_sound = 'pierce.ogg'
	magtype = /obj/item/ammo_magazine/mgauss
	emptymag = /obj/item/ammo_magazine/mgauss/empty

	afterattack(atom/target as mob|obj|turf|area, mob/living/user as mob|obj, flag)
		..()
		if(!loaded.len && hasmag == 1)
			new emptymag(user.loc)
			hasmag = 0
			playsound(user, 'pierce.ogg', 40, 1)
			update_icon()
		return

/obj/item/weapon/gun/projectile/garand
	name = "Garand M1"
	desc = "Vintage semi-automatic rifle. No, it's not a replica, the previous owner of this thing has to be at least the survivor of the Omaha beach, no less."
	icon_state = "garand"
	item_state = "OLDshotgun"
	caliber = "30-06"
	origin_tech = "combat=3;materials=2"
	w_class = 4.0
	fire_sound = 'garandshot.ogg'
	ammo_type = "/obj/item/ammo_casing/c30"
	condition = 1
	max_shells = 8
	blowback = 3
	load_method = 2 //0 = Single shells or quick loader, 1 = box, 2 = magazine
	magtype = /obj/item/ammo_magazine/c30
	emptymag = /obj/item/ammo_magazine/c30/empty

	upg_sup = 1
	upg_bar = 1
	upg_rap = 1
	upg_aut = 1
	upg_stb = 1

	afterattack(atom/target as mob|obj|turf|area, mob/living/user as mob|obj, flag)
		..()
		if(!loaded.len && hasmag == 1)
			new emptymag(user.loc)
			hasmag = 0
			playsound(user, 'garandclip.ogg', 40, 1)
			update_icon()
		return

/obj/item/weapon/gun/projectile/springfield
	name = "Springfield A7"
	desc = "Vintage bolt-action rifle. Just shoot those damn nazis, Johnny."
	icon_state = "springfield"
	item_state = "OLDshotgun"
	caliber = "30-06"
	origin_tech = "combat=3;materials=2"
	w_class = 4.0
	fire_sound = 'garandshot.ogg'
	ammo_type = "/obj/item/ammo_casing/c30"
	condition = 1
	max_shells = 5
	blowback = 2
	load_method = 0 //0 = Single shells or quick loader, 1 = box, 2 = magazine
	singleaction = 1

	upg_sup = 1
	upg_bar = 1
	upg_rap = 1
	upg_stb = 1

/obj/item/weapon/gun/projectile/craftrifle
	name = "Boomstick"
	desc = "A makeshift bolt-action rifle. The only thing you probably can't buy at S-Mart."
	icon_state = "boomstick"
	item_state = "OLDshotgun"
	caliber = ".45b"
	origin_tech = "combat=3;materials=2"
	w_class = 4.0
	fire_sound = 'garandshot.ogg'
	ammo_type = "/obj/item/ammo_casing/c45b"
	condition = 1
	max_shells = 1
	blowback = 2
	load_method = 0 //0 = Single shells or quick loader, 1 = box, 2 = magazine
	singleaction = 1
	var/boom_mod_count = 1
	blowout_chance = 5

/obj/item/weapon/gun/projectile/craftrifle/attackby(obj/item/weapon/W as obj, mob/user as mob)
	..()
	if(istype(W, /obj/item/weapon/screwdriver))
		if(boom_mod_count == 1)
			user << "<span class='notice'>You begin to expand the barrel of [src]...</span>"
			if(loaded.len)
				afterattack(user, user)	//you know the drill
				playsound(user, fire_sound, 50, 1)
				user.visible_message("<span class='danger'>[src] goes off!</span>", "<span class='danger'>[src] goes off in your face!</span>")
				return
			else
				sleep(100)
				caliber = "c9mm"
				user << "<span class='notice'>You reinforce the barrel of [src]. Now it will fire 9mm rounds.</span>"
				boom_mod_count = 2
				blowout_chance = 10
				return
		else if(boom_mod_count == 2)
			user << "<span class='notice'>You begin to expand the barrel of [src]...</span>"
			if(loaded.len)
				afterattack(user, user)	//and again
				playsound(user, fire_sound, 50, 1)
				user.visible_message("<span class='danger'>[src] goes off!</span>", "<span class='danger'>[src] goes off in your face!</span>")
				return
			else
				sleep(100)
				caliber = "c38s"
				user << "<span class='notice'>You reinforce the barrel of [src]. Now it will fire .38 Special rounds.</span>"
				boom_mod_count = 3
				blowout_chance = 15
				return
		else if(boom_mod_count == 3)
			user << "<span class='notice'>You begin to expand the barrel of [src]...</span>"
			if(loaded.len)
				afterattack(user, user)	//and again
				playsound(user, fire_sound, 50, 1)
				user.visible_message("<span class='danger'>[src] goes off!</span>", "<span class='danger'>[src] goes off in your face!</span>")
				return
			else
				sleep(100)
				caliber = ".45b"
				user << "<span class='notice'>You reinforce the barrel of [src]. Now it will fire .45-70 rounds.</span>"
				boom_mod_count = 4
				blowout_chance = 20
				return
		else if(boom_mod_count == 4)
			user << "<span class='notice'>You begin to expand the barrel of [src]...</span>"
			if(loaded.len)
				afterattack(user, user)	//and again
				playsound(user, fire_sound, 50, 1)
				user.visible_message("<span class='danger'>[src] goes off!</span>", "<span class='danger'>[src] goes off in your face!</span>")
				return
			else
				sleep(100)
				caliber = ".50"
				user << "<span class='notice'>You reinforce the barrel of [src]. Now it will fire .50 rounds.</span>"
				boom_mod_count = 5
				blowout_chance = 25
				return
		else if(boom_mod_count == 5)
			user << "<span class='notice'>You begin to expand the barrel of [src]...</span>"
			if(loaded.len)
				afterattack(user, user)	//and again
				playsound(user, fire_sound, 50, 1)
				user.visible_message("<span class='danger'>[src] goes off!</span>", "<span class='danger'>[src] goes off in your face!</span>")
				return
			else
				sleep(100)
				caliber = "shotgun"
				user << "<span class='notice'>You reinforce the barrel of [src]. Now it will fire shotgun shells.</span>"
				boom_mod_count = 6
				blowout_chance = 30
				return
		else
			user << "<span class='notice'>You can't expand the barrel any further."

/obj/item/weapon/gun/projectile/winch
	name = "Winchester M1887"
	desc = "Vintage lever-action rifle. Just shoot those damn indians, Johnny. Retooled for .45-70."
	icon_state = "winch"
	item_state = "OLDshotgun"
	caliber = "45b"
	origin_tech = "combat=3;materials=2"
	fire_sound = 'garandshot.ogg'
	ammo_type = "/obj/item/ammo_casing/c45b"
	max_shells = 8
	load_method = 0 //0 = Single shells or quick loader, 1 = box, 2 = magazine
	singleaction = 1
	acc = 10

	upg_sup = 1
	upg_bar = 1
	upg_rap = 1
	upg_stb = 1

/obj/item/weapon/gun/projectile/smithw
	name = "\improper Smith-W"
	desc = "A standard Law Enforcement pistol. Uses 9mm rounds."
	icon_state = "smithw"
	max_shells = 12
	caliber = "c9mm"
	origin_tech = "combat=2;materials=2;syndicate=8"
	ammo_type = "/obj/item/ammo_casing/c9mm"
	load_method = 2
	fire_sound = 'doublyshot.ogg'
	blowback = 2
	condition = 1
	magtype = /obj/item/ammo_magazine/c9mm_smithw_mag
	emptymag = /obj/item/ammo_magazine/c9mm_smithw_mag/empty
	acc = 20

	upg_sup = 1
	upg_bar = 1
	upg_rap = 1
	upg_aut = 1
	upg_stb = 1