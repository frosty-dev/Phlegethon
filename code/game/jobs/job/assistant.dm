/datum/job/assistant
	title = "Convict"
	flag = CONVICT
	department_flag = TH
	faction = "Station"
	total_positions = -1
	spawn_positions = -1
	supervisors = "absolutely everyone"
	selection_color = "#dddddd"

	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		H.equip_if_possible(new /obj/item/clothing/under/color/orange(H), H.slot_w_uniform)
		H.equip_if_possible(new /obj/item/clothing/shoes/orange(H), H.slot_shoes)
		H.equip_if_possible(new /obj/item/weapon/vending_charge/vitacoin(H), H.slot_l_store)
		return 1