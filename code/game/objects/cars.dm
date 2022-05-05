/obj/structure/car
	icon = 'cars.dmi'
	icon_state = ""
	anchored = 1
	name = "Vehicle"
	desc = "Just a forgotten car"
	density = 1
	layer = 5

	var/canopen = 0
	var/closed = 1
	var/locked = 1

	var/state = 0

	attackby(obj/item/weapon/W as obj, mob/user as mob)
		..()
		if(canopen == 1 && locked == 1)
			if ((is_cut(W)) && (!istype(W, /obj/item/weapon/pen || /obj/item/weapon/lighter/zippo || /obj/item/clothing/mask/cigarette || /obj/item/weapon/match || /obj/item/weapon/wirecutters || /obj/item/weapon/butch)|| /obj/item/weapon/nbat || /obj/item/weapon/broken_bottle ||  /obj/item/weapon/shard || /obj/item/weapon/reagent_containers/syringe))
				user << "You're trying to pick a lock."
				sleep(50)
				if(prob(20))
					user << "Unlocked!"
					locked = 0
				else
					user << "Failed."
			else if (istype(W, /obj/item/weapon/crowbar))
				user << "You're trying to break a lock."
				sleep(30)
				if(prob(80))
					user << "Unlocked!"
					locked = 0
				else
					user << "Failed."
			else
				user << "Won't budge."
		else if(canopen == 1 && locked == 0)
			src.attack_hand(user)
		else
			return

	attack_hand(mob/user as mob)
		if(canopen == 1 && locked == 1)
			user << "Won't budge."
		if(canopen == 1 && locked == 0)
			if(closed == 1)
				icon_state = "[initial(icon_state)]"
				src.closed = 0
			if(closed == 0)
				icon_state = "[initial(icon_state)]_o"
				src.closed = 1
		else
			return
/*
	proc/updateicon()
		if(canopen == 1)
			if(closed == 1)
				icon_state = "[initial(icon_state)]"
			if(closed == 0)
				icon_state = "[initial(icon_state)]_o"
*/

/obj/structure/car/front
//	icon_state = "f_green"

	New()
		..()
		sleep(rand(1,10))
		if(canopen == 1)
			locked = pick(1,0)
		if(dir == NORTH)
			density = 0

/obj/structure/car/middle
//	icon_state = "m_green"

	New()
		..()
		sleep(rand(1,10))
		if(canopen == 1)
			locked = pick(1,0)

/obj/structure/car/back
//	icon_state = "b_green"

	New()
		..()
		sleep(rand(1,10))
		if(canopen == 1)
			locked = pick(1,0)
		if(dir == SOUTH)
			density = 0

/obj/structure/car/front
	icon_state = ""

/obj/structure/car/middle
	icon_state = ""

/obj/structure/car/back
	icon_state = ""


/obj/structure/car/front/broken
	icon_state = "broken_f"

/obj/structure/car/middle/broken
	icon_state = "broken_m"

/obj/structure/car/back/broken
	icon_state = "broken_b"

/obj/structure/car/front/green
	icon_state = "green_f"

/obj/structure/car/middle/green
	icon_state = "green_m"

/obj/structure/car/back/green
	icon_state = "green_b"

/obj/structure/car/front/brown
	icon_state = "brown_f"

/obj/structure/car/middle/brown
	icon_state = "brown_m"

/obj/structure/car/back/brown
	icon_state = "brown_b"

/obj/structure/car/front/blue
	icon_state = "blue_f"

/obj/structure/car/middle/blue
	icon_state = "blue_m"

/obj/structure/car/back/blue
	icon_state = "blue_b"

/obj/structure/car/front/cargo
	icon_state = "cargo_f"

/obj/structure/car/middle/cargo
	icon_state = "cargo_m"

/obj/structure/car/back/cargo
	icon_state = "cargo_b"

/obj/structure/car/front/ht_blue
	icon_state = "ht_blue_f"

/obj/structure/car/middle/ht_blue
	icon_state = "ht_blue_m"

/obj/structure/car/back/ht_blue
	icon_state = "ht_blue_b"

/obj/structure/car/front/ht_gray
	icon_state = "ht_gray_f"

/obj/structure/car/middle/ht_gray
	icon_state = "ht_gray_m"

/obj/structure/car/back/ht_gray
	icon_state = "ht_gray_b"

/obj/structure/car/front/ht_red
	icon_state = "ht_red_f"

/obj/structure/car/middle/ht_red
	icon_state = "ht_red_m"

/obj/structure/car/back/ht_red
	icon_state = "ht_red_b"

/obj/structure/car/front/ht_sage
	icon_state = "ht_sage_f"

/obj/structure/car/middle/ht_sage
	icon_state = "ht_sage_m"

/obj/structure/car/back/ht_sage
	icon_state = "ht_sage_b"

/obj/structure/car/front/ht_yellow
	icon_state = "ht_yellow_f"

/obj/structure/car/middle/ht_yellow
	icon_state = "ht_yellow_m"

/obj/structure/car/back/ht_yellow
	icon_state = "ht_yellow_b"

/obj/structure/car/front/scout
	icon_state = "scout_f"

/obj/structure/car/middle/scout
	icon_state = "scout_m"

/obj/structure/car/back/scout
	icon_state = "scout_b"

/obj/structure/car/front/wreckage
	icon_state = "wreckage_f"

/obj/structure/car/middle/wreckage
	icon_state = "wreckage_m"

/obj/structure/car/back/wreckage
	icon_state = "wreckage_b"


/obj/structure/car/front/canopen
	icon_state = ""

/obj/structure/car/middle/canopen
	icon_state = ""

/obj/structure/car/back/canopen
	icon_state = ""

/obj/structure/car/front/canopen/armored
	icon_state = "armored_f"

/obj/structure/car/middle/canopen/armored
	icon_state = "armored_m"

/obj/structure/car/back/canopen/armored
	icon_state = "armored_b"

/obj/structure/car/front/canopen/desarm1
	icon_state = "desarm1_f"

/obj/structure/car/middle/canopen/desarm1
	icon_state = "desarm1_m"

/obj/structure/car/back/canopen/desarm1
	icon_state = "desarm1_b"

/obj/structure/car/front/canopen/desarm2
	icon_state = "desarm2_f"

/obj/structure/car/middle/canopen/desarm2
	icon_state = "desarm2_m"

/obj/structure/car/back/canopen/desarm2
	icon_state = "desarm2_b"

/obj/structure/car/front/canopen/ht_grayw
	icon_state = "ht_grayw_f"

/obj/structure/car/middle/canopen/ht_grayw
	icon_state = "ht_grayw_m"

/obj/structure/car/back/canopen/ht_grayw
	icon_state = "ht_grayw_b"

/obj/structure/car/front/canopen/ht_police
	icon_state = "ht_police_f"

/obj/structure/car/middle/canopen/ht_police
	icon_state = "ht_police_m"

/obj/structure/car/back/canopen/ht_police
	icon_state = "ht_police_b"

/obj/structure/car/front/canopen/ht_redw
	icon_state = "ht_redw_f"

/obj/structure/car/middle/canopen/ht_redw
	icon_state = "ht_redw_m"

/obj/structure/car/back/canopen/ht_redw
	icon_state = "ht_redw_b"

/obj/structure/car/front/canopen/ht_sagew
	icon_state = "ht_sagew_f"

/obj/structure/car/middle/canopen/ht_sagew
	icon_state = "ht_sagew_m"

/obj/structure/car/back/canopen/ht_sagew
	icon_state = "ht_sagew_b"

/obj/structure/car/front/canopen/ht_white
	icon_state = "ht_white_f"

/obj/structure/car/middle/canopen/ht_white
	icon_state = "ht_white_m"

/obj/structure/car/back/canopen/ht_white
	icon_state = "ht_white_b"

/obj/structure/car/front/canopen/old
	icon_state = "old_f"

/obj/structure/car/middle/canopen/old
	icon_state = "old_m"

/obj/structure/car/back/canopen/old
	icon_state = "old_b"

/obj/structure/car/front/canopen/truck
	icon_state = "truck_f"

/obj/structure/car/middle/canopen/truck
	icon_state = "truck_m"

/obj/structure/car/back/canopen/truck
	icon_state = "truck_b"