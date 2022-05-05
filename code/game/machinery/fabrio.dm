
/obj/structure/fabricator
	icon = 'fabrio.dmi'
	name = "Fabricator"
	icon_state = "fabrio"
	density = 0
	anchored = 1
	icon = 'fabrio.dmi'
	var/ftype = null

	New()
		..()
		sleep(rand(0,20))
		if (ftype == null)
			ftype = pick ("guns", "meds", "food", "suit")
			if(ftype == "guns")
				name = "Gun fabricator"
			if(ftype == "meds")
				name = "Medical fabricator"
			if(ftype == "food")
				name = "Food fabricator"
			if(ftype == "suit")
				name = "Clothing fabricator"


		for()

			var/guns1 = pick(/obj/item/weapon/gunsmith/upgrade/suppressor, /obj/item/weapon/gunsmith/upgrade/barrelarm, /obj/item/weapon/gunsmith/upgrade/rapidblowback, /obj/item/weapon/gunsmith/upgrade/autofire, /obj/item/weapon/gunsmith/upgrade/stabilizer)
			var/guns2 = pick(/obj/item/weapon/gunsmith/frame/frame_p, /obj/item/weapon/gunsmith/frame/frame_r, /obj/item/weapon/gunsmith/trigger, /obj/item/weapon/gunsmith/barrel)
			var/guns3 = pick(/obj/item/weapon/gunsmith/acc/acc_s/crossbow, /obj/item/weapon/gunsmith/acc/acc_s/lferus, /obj/item/weapon/gunsmith/acc/acc_s/doubly, /obj/item/weapon/gunsmith/acc/acc_s/handy, /obj/item/weapon/gunsmith/acc/acc_s/hamlet, /obj/item/weapon/gunsmith/acc/acc_s/canis, /obj/item/weapon/gunsmith/acc/acc_s/sleuthds, /obj/item/weapon/gunsmith/acc/acc_s/nipper, /obj/item/weapon/gunsmith/acc/acc_s/swamper, /obj/item/weapon/gunsmith/acc/acc_s/smithw, /obj/item/weapon/gunsmith/acc/acc_s/mac, /obj/item/weapon/gunsmith/acc/acc_l/bazooka, /obj/item/weapon/gunsmith/acc/acc_l/gauss, /obj/item/weapon/gunsmith/acc/acc_l/garand, /obj/item/weapon/gunsmith/acc/acc_l/springfield, /obj/item/weapon/gunsmith/acc/acc_l/tommy, /obj/item/weapon/gunsmith/acc/acc_l/trencher, /obj/item/weapon/gunsmith/acc/acc_l/doublebarrel, /obj/item/weapon/gunsmith/acc/acc_l/cerber, /obj/item/weapon/gunsmith/acc/acc_l/winch)
			var/guns4 = pick(/obj/item/ammo_magazine/ammobox/c45s, /obj/item/ammo_magazine/ammobox/c45b, /obj/item/ammo_magazine/ammobox/c9mm, /obj/item/ammo_magazine/ammobox/c22, /obj/item/ammo_magazine/ammobox/c38s, /obj/item/ammo_magazine/ammobox/c38s/ex, /obj/item/ammo_magazine/ammobox/c30, /obj/item/ammo_magazine/ammobox/fbullet)
			var/meds1 = pick(/obj/item/weapon/reagent_containers/glass/bottle/antitoxin,/obj/item/weapon/reagent_containers/glass/bottle/inaprovaline,/obj/item/weapon/reagent_containers/glass/bottle/stoxin,/obj/item/weapon/reagent_containers/glass/bottle/toxin,/obj/item/weapon/reagent_containers/syringe/antiviral, /obj/item/stack/medical/bruise_pack,/obj/item/stack/medical/ointment,/obj/item/stack/medical/splint,/obj/item/stack/medical/advanced/bruise_pack,/obj/item/stack/medical/advanced/ointment)
			var/meds2 = pick(/obj/item/stack/medical/bruise_pack,/obj/item/stack/medical/ointment,/obj/item/stack/medical/splint,/obj/item/stack/medical/advanced/bruise_pack,/obj/item/stack/medical/advanced/ointment)
			var/food1 = pick(/obj/item/weapon/reagent_containers/food/snacks/cansoup,/obj/item/weapon/reagent_containers/food/snacks/canbeans,/obj/item/weapon/reagent_containers/food/snacks/canfruit,/obj/item/weapon/reagent_containers/food/snacks/cangator,/obj/item/weapon/reagent_containers/food/snacks/canmre)
			var/food2 = pick(/obj/item/weapon/reagent_containers/food/drinks/bottle/gin,/obj/item/weapon/reagent_containers/food/drinks/bottle/whiskey,/obj/item/weapon/reagent_containers/food/drinks/bottle/tequilla,/obj/item/weapon/reagent_containers/food/drinks/bottle/vodka,/obj/item/weapon/reagent_containers/food/drinks/bottle/vermouth,/obj/item/weapon/reagent_containers/food/drinks/bottle/rum,/obj/item/weapon/reagent_containers/food/drinks/bottle/wine,/obj/item/weapon/reagent_containers/food/drinks/bottle/cognac,/obj/item/weapon/reagent_containers/food/drinks/bottle/kahlua)
			var/food3 = pick(/obj/item/weapon/reagent_containers/food/snacks/candy,/obj/item/weapon/reagent_containers/food/drinks/dry_ramen,/obj/item/weapon/reagent_containers/food/snacks/chips,/obj/item/weapon/reagent_containers/food/snacks/sosjerky,/obj/item/weapon/reagent_containers/food/snacks/no_raisin,/obj/item/weapon/reagent_containers/food/snacks/spacetwinkie,/obj/item/weapon/reagent_containers/food/snacks/cheesiehonkers)
			var/suit1 = pick(/obj/item/clothing/under/rank/vice,/obj/item/clothing/under/lawyer/purpsuit,/obj/item/clothing/under/madmax,/obj/item/clothing/under/patrol,/obj/item/clothing/under/acu,/obj/item/clothing/under/marw,/obj/item/clothing/under/mard,/obj/item/clothing/under/rank/unit_d,/obj/item/clothing/under/tac)
			var/suit2 = pick(/obj/item/clothing/suit/storage/fieldjacket,/obj/item/clothing/suit/armor/knight_suit,/obj/item/clothing/suit/storage/madmaxs,/obj/item/clothing/suit/storage/patrols,/obj/item/clothing/suit/fjacketg,/obj/item/clothing/suit/fjacketb,/obj/item/clothing/suit/armor/vestw,/obj/item/clothing/suit/armor/vestd)
			var/suit3 = pick(/obj/item/clothing/shoes/cowboy,/obj/item/clothing/shoes/combat,/obj/item/clothing/shoes/db,/obj/item/clothing/shoes/jackboots,/obj/item/clothing/shoes/wshoes)
			var/suit4 = pick(/obj/item/clothing/head/helmet/mone,/obj/item/clothing/head/helmet/pasgt,/obj/item/clothing/head/helmet/motohelm,/obj/item/clothing/head/helmet/swat,/obj/item/clothing/head/helmet/riot,/obj/item/clothing/head/knight_helmet)

			//600
			sleep(900)
			icon_state = "fabrio_1"
			sleep(900)
			icon_state = "fabrio_2"
			sleep(900)
			icon_state = "fabrio_3"
			sleep(900)
			icon_state = "fabrio_4"
			sleep(900)
			icon_state = "fabrio_5"
			sleep(900)
			icon_state = "fabrio_6"
			sleep(900)
			icon_state = "fabrio_7"
			sleep(900)
			icon_state = "fabrio_8"
			sleep(900)
			icon_state = "fabrio_9"
			sleep(900)
			icon_state = "fabrio_open"
			switch(ftype)
				if("guns")
					new guns2 (loc)
					new guns3 (loc)
					if(prob(30))
						new guns1 (loc)
						new guns4 (loc)
				if("meds")
					new meds1 (loc)
					new meds2 (loc)
				if("food")
					new food1 (loc)
					new food3 (loc)
					if(prob(30))
						new food2 (loc)
				if("suit")
					new suit1 (loc)
					new suit3 (loc)
					if(prob(30))
						new suit2 (loc)
						new suit4 (loc)

/obj/structure/fabricator/guns
	name = "Gun fabricator"
	ftype = "guns"

/obj/structure/fabricator/meds
	name = "Medical fabricator"
	ftype = "meds"

/obj/structure/fabricator/food
	name = "Food fabricator"
	ftype = "food"

/obj/structure/fabricator/suit
	name = "Clothing fabricator"
	ftype = "suit"