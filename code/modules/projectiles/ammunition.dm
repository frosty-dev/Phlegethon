//This file was auto-corrected by findeclaration.exe on 29/05/2012 15:03:05

/obj/item/ammo_casing
	name = "bullet casing"
	desc = "A bullet casing."
	icon = 'ammo.dmi'
	icon_state = "s-casing_f"
	flags = FPRINT | TABLEPASS | CONDUCT
	slot_flags = SLOT_BELT
	throwforce = 1
	w_class = 1.0
	var/caliber = ""							//Which kind of guns it can be loaded into
	var/projectile_type = ""//The bullet type to create when New() is called
	var/obj/item/projectile/BB = null 			//The loaded bullet
	//phleg ballistic
//	var/stack = 1
//	multiple_sprites = 1


	New()
		..()
		if(projectile_type)
			BB = new projectile_type(src)
		pixel_x = rand(-10.0, 10)
		pixel_y = rand(-10.0, 10)
		dir = pick(cardinal)

//		if(obj/item/projectile/BB)
//			icon_state = "s-casing"
//			desc += "Empty."
/*
	attackby(var/obj/item/ammo_casing/A as obj, mob/user as mob)
		if(stack = 10)
			user << "\blue [src] Cant hold more."
			return
		if(A.type == src.type)
			stack += 1
			icon_state = "handful_bullets"
			update_icon()
			del(A)
		else
			user << "\blue No need to mix things up."
		return

	HasEntered(AM as mob|obj|turf)
		for(var/obj/item/ammo_casing/AC in src.contents)
			if(contents.len > 1)
				contents -= AC
				new src.ammo_type(src.loc)
			if(contents.len <= 1)
				del(src)
				new src.ammo_type(src.loc)
				break

	update_icon()
		if(stack == 1)
			icon_state = "s-casing_f"
		if(multiple_sprites)
			icon_state = "[initial(icon_state)]-[contents.len]"
		desc = "There are [contents.len] shell\s left!"
*/





//Boxes of ammo
/obj/item/ammo_magazine
	name = "ammo box (.357)"
	desc = "A box of ammo"
	icon_state = "357"
	icon = 'ammo.dmi'
	flags = FPRINT | TABLEPASS | CONDUCT
	slot_flags = SLOT_BELT
	item_state = "syringe_kit"
	m_amt = 50000
	throwforce = 2
	w_class = 1.0
	throw_speed = 4
	throw_range = 10
//	var/list/stored_ammo = list() phleg. do not need copy of contents
	var/ammo_type = "/obj/item/ammo_casing"
	var/max_ammo = 7
	var/multiple_sprites = 0
//	contents = null

	New()
		for(var/i = 1, i <= max_ammo, i++)
			contents += new ammo_type(src)
		update_icon()
		pixel_x = rand(-5.0, 5)
		pixel_y = rand(-5.0, 5)

	update_icon()
		if(multiple_sprites)
			icon_state = "[initial(icon_state)]-[contents.len]"
		desc = "There are [contents.len] shell\s left!"

	attackby(var/obj/item/ammo_casing/A as obj, mob/user as mob)
		for(var/obj/item/projectile/BB in A.contents)
			var/Atype = "[A.type]"
			if(Atype != src.ammo_type)
				user << "\blue This is a different type of ammunition."
				break
			else
				if(contents.len < max_ammo)
					contents += new A.type//.ammo_type
					del(A)
					update_icon()
					break
				else
					user << "\blue [src] is already filled."
					break

	//	user << "\blue [src] can not contain empty casing."

	attack_self(mob/living/carbon/human/M as mob)
		for(var/obj/item/ammo_casing/AC in src.contents)
		//	del(AC)
			contents -= AC
			new src.ammo_type(M.loc)
			update_icon()
			break
/*
/obj/item/ammo_magazine/handful
	name = "handful"
	desc = "handful of things"
	icon = 'ammo.dmi'

/obj/item/ammo_magazine/handful/bullets
	desc = "handful of bullets"
	icon_state = "handful_bullets"
	ammo_type = "/obj/item/ammo_casing"
	max_ammo = 10
	multiple_sprites = 1



	attackby(var/obj/item/ammo_casing/A as obj, mob/user as mob)
		for(var/obj/item/projectile/BB in A.contents)
			var/Atype = "[A.type]"
			if(Atype != src.ammo_type)
				user << "\blue This is a different type of ammunition."
				break
			else
				if(contents.len < max_ammo)
					if(A.stack > 1)
						A.stack -= 1
						contents += new A.type
						update_icon()
						break
					else
						contents += new A.type//.ammo_type
						del(A)
						update_icon()
						break
				else
					user << "\blue [src] is already filled."
					break

*/