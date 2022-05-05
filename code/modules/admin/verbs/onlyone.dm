/client/proc/only_one()
	set category = "Fun"
	set name = "THERE CAN BE ONLY ONE"
	set desc = "Makes everyone into a traitor and has them fight for the nuke auth. disk."
	if(!ticker)
		alert("The game hasn't started yet!")
		return
	if(alert("BEGIN THE TOURNAMENT?",,"Yes","No")=="No")
		return

	//feedback_add_details("admin_verb","TCBOO") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	for(var/mob/living/carbon/human/H in world)
		if(H.stat == 2 || !(H.client)) continue
		if(is_special_character(H)) continue

		ticker.mode.traitors += H.mind
		H.mind.special_role = "traitor"

		var/datum/objective/steal/nuke_disk/steal_objective = new
		steal_objective.owner = H.mind
		H.mind.objectives += steal_objective

		var/datum/objective/hijack/hijack_objective = new
		hijack_objective.owner = H.mind
		H.mind.objectives += hijack_objective

		H << "<B>You are the traitor.</B>"
		var/obj_count = 1
		for(var/datum/objective/OBJ in H.mind.objectives)
			H << "<B>Objective #[obj_count]</B>: [OBJ.explanation_text]"
			obj_count++

		for (var/obj/item/I in H)
			if (istype(I, /obj/item/weapon/implant))
				continue
			del(I)

		H.equip_if_possible(new /obj/item/clothing/under/kilt(H), H.slot_w_uniform)
		H.equip_if_possible(new /obj/item/device/radio/headset/heads/captain(H), H.slot_ears)
		H.equip_if_possible(new /obj/item/clothing/head/beret(H), H.slot_head)
		H.equip_if_possible(new /obj/item/weapon/claymore(H), H.slot_l_hand)
		H.equip_if_possible(new /obj/item/clothing/shoes/combat(H), H.slot_shoes)
		H.equip_if_possible(new /obj/item/weapon/pinpointer(H.loc), H.slot_l_store)

		var/obj/item/weapon/card/id/W = new(H)
		W.name = "[H.real_name]'s ID Card"
		W.icon_state = "centcom"
		W.access = get_all_accesses()
		W.access += get_all_centcom_access()
		W.assignment = "Highlander"
		W.registered_name = H.real_name
		H.equip_if_possible(W, H.slot_wear_id)

	message_admins("\blue [key_name_admin(usr)] used THERE CAN BE ONLY ONE!", 1)
	log_admin("[key_name(usr)] used there can be only one.")


//phleg western

/client/proc/gunfight()
	set category = "Fun"
	set name = "Gunfight"
	set desc = "Makes everyone into a gunslinger."
	if(!ticker)
		alert("The game hasn't started yet!")
		return
	if(alert("BEGIN THE TOURNAMENT?",,"Yes","No")=="No")
		return

	//feedback_add_details("admin_verb","TCBOO") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	for(var/mob/living/carbon/human/H in world)
		if(H.stat == 2 || !(H.client)) continue
		if(is_special_character(H)) continue

		ticker.mode.traitors += H.mind
		H.mind.special_role = "traitor"

//		var/datum/objective/steal/nuke_disk/steal_objective = new
//		steal_objective.owner = H.mind
//		H.mind.objectives += steal_objective

		var/datum/objective/hijack/hijack_objective = new
		hijack_objective.owner = H.mind
		H.mind.objectives += hijack_objective

		H << "<B>You are the traitor.</B>"
		var/obj_count = 1
		for(var/datum/objective/OBJ in H.mind.objectives)
			H << "<B>Objective #[obj_count]</B>: [OBJ.explanation_text]"
			obj_count++

		for (var/obj/item/I in H)
			if (istype(I, /obj/item/weapon/implant))
				continue
			del(I)

		var/uniform = pick(/obj/item/clothing/under/suit_jacket,/obj/item/clothing/under/rank/bartender,/obj/item/clothing/under/det,/obj/item/clothing/under/librarian,/obj/item/clothing/under/waiter,/obj/item/clothing/under/color/alc,/obj/item/clothing/under/rank/chaplain,/obj/item/clothing/under/rank/vice,/obj/item/clothing/under/lawyer/red,/obj/item/clothing/under/lawyer/purpsuit,/obj/item/clothing/under/rank/scientist,/obj/item/clothing/under/rank/machina,/obj/item/clothing/under/rank/unit)
		var/suit = pick(/obj/item/clothing/suit/fjacketb, /obj/item/clothing/suit/fjacketg, /obj/item/clothing/suit/storage/det_suit/fluff/leatherjack, /obj/item/clothing/suit/storage/det_suit/fluff/graycoat, /obj/item/clothing/suit/browncoat, /obj/item/clothing/suit/leathercoat, /obj/item/clothing/suit/storage/det_suit, /obj/item/clothing/suit/storage/gearharness)
		var/shoes = pick(/obj/item/clothing/shoes/cowboy, /obj/item/clothing/shoes/fluff/leatherboots, /obj/item/clothing/shoes/laceups, /obj/item/clothing/shoes/jackboots, /obj/item/clothing/shoes/fullbrown)
		var/hat = pick(/obj/item/clothing/head/feathertrilby, /obj/item/clothing/head/fedora, /obj/item/clothing/head/boaterhat, /obj/item/clothing/head/beaverhat ,/obj/item/clothing/head/bowlerhat, /obj/item/clothing/head/det_hat, /obj/item/clothing/head/that, /obj/item/clothing/head/det_hat_bl)

		H.equip_if_possible(new uniform(H), H.slot_w_uniform)
		H.equip_if_possible(new suit(H), H.slot_wear_suit)
		H.equip_if_possible(new shoes(H), H.slot_shoes)
		H.equip_if_possible(new hat(H), H.slot_head)
		H.equip_if_possible(new /obj/item/weapon/storage/backpack/satchel(H), H.slot_back)
		H.equip_if_possible(new /obj/item/weapon/storage/belt/gunslinger/full(H), H.slot_belt)
		H.equip_if_possible(new /obj/item/weapon/gun/projectile/canis(H), H.slot_s_store)
		H.equip_if_possible(new /obj/item/clothing/gloves/glinger(H), H.slot_gloves)
		H.equip_if_possible(new /obj/item/clothing/mask/bluescarf(H), H.slot_l_store)
		H.equip_if_possible(new /obj/item/weapon/reagent_containers/food/drinks/dflask(H), H.slot_r_store)

	message_admins("\blue [key_name_admin(usr)] used Gunfight!", 1)
	log_admin("[key_name(usr)] used there can be only one.")