/obj/mecha/combat/gygax
	desc = "A tiny recon lightweight buggy."
	name = "Rat Hunter"
	icon_state = "gygax"
	step_in = 1
	opacity = 0
	dir_in = 2 //Facing North.
	health = 300
	deflect_chance = 15
	damage_absorption = list("brute"=0.75,"fire"=1,"bullet"=0.8,"laser"=0.7,"energy"=0.85,"bomb"=1)
	max_temperature = 3500
	infra_luminosity = 6
	var/overload = 0
	var/overload_coeff = 2
	wreckage = /obj/effect/decal/mecha_wreckage/gygax
	internal_damage_threshold = 35
	max_equip = 2

/obj/mecha/combat/gygax/dark
	desc = "A lightweight exosuit used by Nanotrasen Death Squads. A significantly upgraded Gygax security mech."
	name = "Dark Gygax"
	icon_state = "darkgygax"
	health = 400
	deflect_chance = 25
	damage_absorption = list("brute"=0.6,"fire"=0.8,"bullet"=0.6,"laser"=0.5,"energy"=0.65,"bomb"=0.8)
	max_temperature = 4500
	overload_coeff = 1
	wreckage = /obj/effect/decal/mecha_wreckage/gygax/dark
	max_equip = 4
	step_energy_drain = 5

/obj/mecha/combat/gygax/dark/New()
	..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/scattershot
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/missile_rack/flashbang/clusterbang
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/teleporter
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/tesla_energy_relay
	ME.attach(src)
	return

/obj/mecha/combat/gygax/dark/add_cell(var/obj/item/weapon/cell/C=null)
	if(C)
		C.forceMove(src)
		cell = C
		return
	cell = new(src)
	cell.charge = 30000
	cell.maxcharge = 30000


/obj/mecha/combat/gygax/verb/overload()
	set category = "Vehicle Interface"
	set name = "Toggle wheels overload"
	set src = usr.loc
	set popup_menu = 0
	if(usr!=src.occupant)
		return
	if(overload)
		overload = 0
		step_in = initial(step_in)
		step_energy_drain = initial(step_energy_drain)
		src.occupant_message("<font color='blue'>You disable wheels overload.</font>")
	else
		overload = 1
		step_in = min(1, round(step_in/2))
		step_energy_drain = step_energy_drain*overload_coeff
		src.occupant_message("<font color='red'>You enable wheels overload.</font>")
	src.log_message("Toggled wheels overload.")
	return

/obj/mecha/combat/gygax/dyndomove(direction)
	if(!..()) return
	if(overload)
		health--
		if(health < initial(health) - initial(health)/3)
			overload = 0
			step_in = initial(step_in)
			step_energy_drain = initial(step_energy_drain)
			src.occupant_message("<font color='red'>Wheels damage threshold exceded. Disabling overload.</font>")
	return


/obj/mecha/combat/gygax/get_stats_part()
	var/output = ..()
	output += "<b>Wheels overload: [overload?"on":"off"]</b>"
	return output

/obj/mecha/combat/gygax/get_commands()
	var/output = {"<div class='wr'>
						<div class='header'>Special</div>
						<div class='links'>
						<a href='?src=\ref[src];toggle_leg_overload=1'>Toggle wheels overload</a>
						</div>
						</div>
						"}
	output += ..()
	return output

/obj/mecha/combat/gygax/Topic(href, href_list)
	..()
	if (href_list["toggle_leg_overload"])
		src.overload()
	return


/obj/mecha/Bump(atom/movable/A as mob|obj) //wrapper
//	src.log_message("Hit by [A].",1)
	call((proc_res["dynhitby"]||src), "dynhitby")(A)
	return


/*
GOTO
	Bump(atom/A)
		A.bullet_act(src, def_zone)
		src.life -= 10
		if(life <= 0)
			del(src)
		return
*/
/*


/mob/living/carbon/human/HasEntered(var/atom/movable/AM)
	var/obj/mecha/combat/gygax/MH = AM
	if(istype(MH))
		MH.RunOver(src)

/obj/mecha/combat/gygax/proc/RunOver(var/mob/living/carbon/human/H)
	src.visible_message("\red [src] drives over [H]!")
	playsound(src.loc, 'splat.ogg', 50, 1)

	var/damage = rand(5,15)
	H.apply_damage(2*damage, BRUTE, "head")
	H.apply_damage(2*damage, BRUTE, "chest")
	H.apply_damage(0.5*damage, BRUTE, "l_leg")
	H.apply_damage(0.5*damage, BRUTE, "r_leg")
	H.apply_damage(0.5*damage, BRUTE, "l_arm")
	H.apply_damage(0.5*damage, BRUTE, "r_arm")

	var/obj/effect/decal/cleanable/blood/B = new(src.loc)
	B.blood_DNA = list()
	B.blood_DNA[H.dna.unique_enzymes] = H.dna.b_type


*/


/*
/mob/living/carbon/human/HasEntered(var/atom/movable/AM)
	var/obj/mecha/combat/gygax/MH = AM
	if(istype(MH))
		MH.RunOver(src)

/obj/mecha/combat/gygax/proc/RunOver(var/mob/living/carbon/human/H)
	src.visible_message("\red [src] drives over [H]!")
	playsound(src.loc, 'splat.ogg', 50, 1)

	var/damage = rand(5,15)
	H.apply_damage(2*damage, BRUTE, "head")
	H.apply_damage(2*damage, BRUTE, "chest")
	H.apply_damage(0.5*damage, BRUTE, "l_leg")
	H.apply_damage(0.5*damage, BRUTE, "r_leg")
	H.apply_damage(0.5*damage, BRUTE, "l_arm")
	H.apply_damage(0.5*damage, BRUTE, "r_arm")

	var/obj/effect/decal/cleanable/blood/B = new(src.loc)
	B.blood_DNA = list()
	B.blood_DNA[H.dna.unique_enzymes] = H.dna.b_type

	*/