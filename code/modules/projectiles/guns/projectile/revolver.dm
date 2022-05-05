/obj/item/weapon/gun/projectile/detective
	desc = "A cheap Martian knock-off of a Smith & Wesson Model 10. Uses .38-Special rounds."
	name = "revolver"
	icon_state = "detective"
	caliber = "357"
	origin_tech = "combat=2;materials=2"
	ammo_type = "/obj/item/ammo_casing/c38"

	special_check(var/mob/living/carbon/human/M)
		if(ishuman(M))
			if(istype(M.w_uniform, /obj/item/clothing/under/det) && istype(M.head, /obj/item/clothing/head/det_hat) && istype(M.wear_suit, /obj/item/clothing/suit/storage/det_suit))
				return 1
			M << "\red You just don't feel cool enough to use this gun looking like that."
		return 0
		return 1

	verb/rename_gun()
		set name = "Name Gun"
		set category = "Object"
		set desc = "Click to rename your gun. If you're the detective."

		var/mob/M = usr
		if(!M.mind)	return 0
		if(!M.mind.assigned_role == "Detective")
			M << "\red You don't feel cool enough to name this gun, chump."
			return 0

		var/input = copytext(sanitize(input("What do you want to name the gun?",,"")),1,MAX_NAME_LEN)

		if(src && input && !M.stat && in_range(M,src))
			name = input
			M << "You name the gun [input]. Say hello to your new friend."
			return 1




/obj/item/weapon/gun/projectile/mateba
	name = "mateba"
	desc = "When you absolutely, positively need a 10mm hole in the other guy. Uses .357 ammo."
	icon_state = "mateba"
	origin_tech = "combat=2;materials=2"

/obj/item/weapon/gun/projectile/canis
	name = "Canis .45-70"
	desc = "Made men equal."
	icon_state = "canis"
	caliber = "45b"
	ammo_type = "/obj/item/ammo_casing/c45b"
	origin_tech = "combat=2;materials=2"
	fire_sound = 'canis.ogg'
	blowback = 5
	max_shells = 6
	condition = 1
	revolver = 1
	acc = 30

	upg_sup = 1
	upg_bar = 1
	upg_rap = 1
	upg_aut = 1
	upg_stb = 1

/obj/item/weapon/gun/projectile/sleuthds
	desc = "A compact revolver. Uses 38 Special rounds."
	name = "Sleuth DS"
	icon_state = "sleuthds"
	max_shells = 6
	w_class = 2.0
	caliber = "c38s"
	origin_tech = "combat=2;materials=2"
	ammo_type = "/obj/item/ammo_casing/c38s/ex"
	fire_sound = 'nippershot.ogg'
	blowback = 6
	revolver = 1
	acc = 50

	upg_sup = 1
	upg_bar = 1
	upg_rap = 1
	upg_aut = 1
	upg_stb = 1

/obj/item/weapon/gun/projectile/nipper	//gemini
	desc = "A very reliable heavy revolver. Uses 38 Special rounds."
	name = "Nipper MK1"
	flags =  FPRINT | TABLEPASS | USEDELAY
	icon_state = "nipper"
	max_shells = 6
	caliber = "c38s"
	origin_tech = "combat=2;materials=2"
	ammo_type = "/obj/item/ammo_casing/c38s"
	ejectshell = 0
	fire_sound = 'nippershot.ogg'
	blowback = 6
	revolver = 1
	acc = 20

	upg_sup = 1
	upg_bar = 1
	upg_rap = 1
	upg_aut = 1
	upg_stb = 1

/obj/item/weapon/gun/projectile/swamper	//gemini
	desc = "A heavy hunting revolver. Uses shotgun shells."
	name = "Swamper 12g"
	flags =  FPRINT | TABLEPASS | USEDELAY
	icon_state = "swamper"
	max_shells = 5
	caliber = "shotgun"
	origin_tech = "combat=2;materials=2"
	ammo_type = "/obj/item/ammo_casing/shotgun/lead"
	ejectshell = 0
	fire_sound = 'nippershot.ogg'
	blowback = 6
	revolver = 1
	acc = 20

	upg_sup = 1
	upg_bar = 1
	upg_rap = 1
	upg_stb = 1