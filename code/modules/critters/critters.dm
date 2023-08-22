/obj/effect/critter/creature
	name = "creature"
	desc = "A sanity-destroying otherthing."
	icon = 'otherthing.dmi'
	icon_state = "otherthing"
	health = 80
	max_health = 80
	aggressive = 1
	defensive = 1
	wanderer = 1
	opensdoors = 1
	atkcarbon = 1
	atksilicon = 1
	atkcritter = 1
	atkmech = 1
	atksame = 1
	firevuln = 1
	brutevuln = 1
	melee_damage_lower = 25
	melee_damage_upper = 50
	angertext = "runs"
	attacktext = "chomps"
	attack_sound = 'bite.ogg'


/obj/effect/critter/roach
	name = "cockroach"
	desc = "An unpleasant insect that lives in filthy places."
	icon_state = "roach"
	health = 5
	max_health = 5
	aggressive = 0
	defensive = 1
	wanderer = 1
	atkcarbon = 1
	atksilicon = 0
	attacktext = "bites"

	Die()
		..()
		del(src)


/obj/effect/critter/killertomato
	name = "killer tomato"
	desc = "Oh shit, you're really fucked now."
	icon_state = "killertomato"
	health = 15
	max_health = 15
	aggressive = 1
	defensive = 0
	wanderer = 1
	atkcarbon = 1
	atksilicon = 1
	firevuln = 2
	brutevuln = 2


	Harvest(var/obj/item/weapon/W, var/mob/living/user)
		if(..())
			var/success = 0
			if(istype(W, /obj/item/weapon/butch))
				new /obj/item/weapon/reagent_containers/food/snacks/tomatomeat(src)
				success = 1
			if(istype(W, /obj/item/weapon/kitchenknife))
				new /obj/item/weapon/reagent_containers/food/snacks/tomatomeat(src)
				new /obj/item/weapon/reagent_containers/food/snacks/tomatomeat(src)
				success = 1
			if(success)
				for(var/mob/O in viewers(src, null))
					O.show_message("\red [user.name] cuts apart the [src.name]!", 1)
				del(src)
				return 1
			return 0



/obj/effect/critter/spore
	name = "plasma spore"
	desc = "A barely intelligent colony of organisms. Very volatile."
	icon_state = "spore"
	density = 1
	health = 1
	max_health = 1
	aggressive = 0
	defensive = 0
	wanderer = 1
	atkcarbon = 0
	atksilicon = 0
	firevuln = 2
	brutevuln = 2


	Die()
		src.visible_message("<b>[src]</b> ruptures and explodes!")
		src.alive = 0
		var/turf/T = get_turf(src.loc)
		if(T)
			T.hotspot_expose(700,125)
			explosion(T, -1, -1, 2, 3)
		del src


	ex_act(severity)
		src.Die()


/obj/effect/critter/blob
	name = "blob"
	desc = "Some blob thing."
	icon_state = "blob"
	pass_flags = PASSBLOB
	health = 20
	max_health = 20
	aggressive = 1
	defensive = 0
	wanderer = 1
	atkcarbon = 1
	atksilicon = 1
	firevuln = 2
	brutevuln = 0.5
	melee_damage_lower = 2
	melee_damage_upper = 8
	angertext = "charges"
	attacktext = "hits"
	attack_sound = 'genhit1.ogg'

	Die()
		..()
		del(src)



/obj/effect/critter/spesscarp
	name = "Spess Carp"
	desc = "A ferocious, fang-bearing creature that resembles a fish."
	icon_state = "spesscarp"
	health = 100
	max_health = 100
	aggressive = 1
	aggression = 20
	defensive = 1
	wanderer = 1
	atkcarbon = 1
	atksilicon = 1
	atkcritter = 1
	atkmech = 1
	firevuln = 2
	brutevuln = 1
	melee_damage_lower = 5
	melee_damage_upper = 15
	angertext = "lunges"
	attacktext = "bites"
	attack_sound = 'bite.ogg'
	attack_speed = 10
	speed = 8
	chasespeed = 8
	var/stunchance = 10 // chance to tackle things down


//TEMPORARY
	New()
		..()
		spawn(0)
			del(src)
//TEMPORARY


	Harvest(var/obj/item/weapon/W, var/mob/living/user)
		if(..())
			var/success = 0
			if(istype(W, /obj/item/weapon/butch))
				new/obj/item/weapon/reagent_containers/food/snacks/carpmeat(src.loc)
				new/obj/item/weapon/reagent_containers/food/snacks/carpmeat(src.loc)
				success = 1
			if(istype(W, /obj/item/weapon/kitchenknife))
				new/obj/item/weapon/reagent_containers/food/snacks/carpmeat(src.loc)
				success = 1
			if(success)
				for(var/mob/O in viewers(src, null))
					O.show_message("\red [user.name] cuts apart the [src.name]!", 1)
				del(src)
				return 1
			return 0

	AfterAttack(var/mob/living/target)
		if(prob(stunchance))
			if(target.weakened <= 0)
				target.Weaken(rand(10, 15))
				for(var/mob/O in viewers(src, null))
					O.show_message("\red <B>[src]</B> knocks down [target]!", 1)
				playsound(loc, 'pierce.ogg', 25, 1, -1)



/obj/effect/critter/spesscarp/elite
	desc = "Oh shit, you're really fucked now. It has an evil gleam in its eye."
	health = 200
	max_health = 200
	melee_damage_lower = 20
	melee_damage_upper = 35
	stunchance = 15
	attack_speed = 7
//	opensdoors = 1 would give all access dono if want



/obj/effect/critter/walkingmushroom
	name = "Walking Mushroom"
	desc = "A...huge...mushroom...with legs!?"
	icon_state = "walkingmushroom"
	health = 15
	max_health = 15
	aggressive = 0
	defensive = 0
	wanderer = 1
	atkcarbon = 0
	atksilicon = 0
	firevuln = 2
	brutevuln = 1
	wanderspeed = 1


	Harvest(var/obj/item/weapon/W, var/mob/living/user)
		if(..())
			var/success = 0
			if(istype(W, /obj/item/weapon/butch))
				new /obj/item/weapon/reagent_containers/food/snacks/hugemushroomslice(src.loc)
				new /obj/item/weapon/reagent_containers/food/snacks/hugemushroomslice(src.loc)
				success = 1
			if(istype(W, /obj/item/weapon/kitchenknife))
				new /obj/item/weapon/reagent_containers/food/snacks/hugemushroomslice(src.loc)
				success = 1
			if(success)
				for(var/mob/O in viewers(src, null))
					O.show_message("\red [user.name] cuts apart the [src.name]!", 1)
				del(src)
				return 1
			return 0



/obj/effect/critter/lizard
	name = "Lizard"
	desc = "A cute tiny lizard."
	icon_state = "lizard"
	health = 5
	max_health = 5
	aggressive = 0
	defensive = 1
	wanderer = 1
	opensdoors = 0
	atkcarbon = 1
	atksilicon = 1
	attacktext = "bites"



// We can maybe make these controllable via some console or something
/obj/effect/critter/manhack
	name = "viscerator"
	desc = "A small, twin-bladed machine capable of inflicting very deadly lacerations."
	icon_state = "viscerator"
	pass_flags = PASSTABLE
	health = 15
	max_health = 15
	aggressive = 1
	opensdoors = 1
	defensive = 1
	wanderer = 1
	atkcarbon = 1
	atksilicon = 1
	atkmech = 1
	firevuln = 0 // immune to fire
	brutevuln = 1
	ventcrawl = 1
	melee_damage_lower = 10
	melee_damage_upper = 15
	attacktext = "cuts"
	attack_sound = 'bladeslice.ogg'
	chasestate = "viscerator_attack"
	deathtext = "is smashed into pieces!"


/obj/effect/critter/bear
	name = "bear"
	desc = "Space bear."
	icon_state = "bear"
	health = 100
	max_health = 100
	aggressive = 0
	opensdoors = 1
	defensive = 1
	wanderer = 1
	atkcarbon = 1
	atksilicon = 1
	atkmech = 1
	firevuln = 0 // immune to fire
	brutevuln = 1
	ventcrawl = 0
	melee_damage_lower = 15
	melee_damage_upper = 20
	attacktext = "tear"
	attack_sound = 'bite.ogg'
	attack_speed = 10
	speed = 8
	chasespeed = 8
	var/stunchance = 10 // chance to tackle things down
	deathtext = "bear is dead."


	Harvest(var/obj/item/weapon/W, var/mob/living/user)
		if(..())
			var/success = 0
			if(istype(W, /obj/item/weapon/butch))
				new/obj/item/weapon/reagent_containers/food/snacks/bearmeat(src.loc)
				new/obj/item/weapon/reagent_containers/food/snacks/bearmeat(src.loc)
				success = 1
			if(istype(W, /obj/item/weapon/kitchenknife))
				new/obj/item/weapon/reagent_containers/food/snacks/bearmeat(src.loc)
				success = 1
			if(success)
				for(var/mob/O in viewers(src, null))
					O.show_message("\red [user.name] cuts apart the [src.name]!", 1)
				del(src)
				return 1
			return 0


	AfterAttack(var/mob/living/target)
		if(prob(stunchance))
			if(target.weakened <= 0)
				target.Weaken(rand(10, 15))
				for(var/mob/O in viewers(src, null))
					O.show_message("\red <B>[src]</B> knocks down [target]!", 1)
				playsound(loc, 'pierce.ogg', 25, 1, -1)


	Die()
		..()
		for(var/mob/O in viewers(src, null))
			O.show_message("\red <b>[src]</b> is smashed into pieces!", 1)
		del(src)

/obj/effect/critter/wolf
	name = "Hound"
	desc = "A big and powerful dog."
	icon_state = "wolf"
	health = 60
	max_health = 60
	aggressive = 1
	wanderer = 1
	opensdoors = 0
	atkcarbon = 1
	atksilicon = 1
	atkcritter = 1
	atkmech = 1
	atksame = 0
	firevuln = 1
	brutevuln = 1
	melee_damage_lower = 10
	melee_damage_upper = 15
	attacktext = "charges"
	attack_sound = 'doggrowl.ogg'

	Harvest(var/obj/item/weapon/W, var/mob/living/user)
		if(..())
			var/success = 0
			if(istype(W, /obj/item/weapon/butch))
				new/obj/item/weapon/reagent_containers/food/snacks/bearmeat(src.loc)
				new/obj/item/weapon/reagent_containers/food/snacks/bearmeat(src.loc)
				success = 1
			if(istype(W, /obj/item/weapon/kitchenknife))
				new/obj/item/weapon/reagent_containers/food/snacks/bearmeat(src.loc)
				success = 1
			if(success)
				for(var/mob/O in viewers(src, null))
					O.show_message("\red [user.name] cuts apart the [src.name]!", 1)
				del(src)
				return 1
			return 0
/*
	Die()
		..()
		icon_state = "wolf-dead"
		aggressive = 0
		wanderer = 0
*/

/obj/effect/critter/insane
	name = "Insane"
	desc = "A man without a life in terrible dim eyes."
	icon_state = "insane"
	health = 150
	max_health = 150
	aggressive = 1
	opensdoors = 1
	defensive = 1
	wanderer = 1
	atkcarbon = 1
	atksilicon = 1
	atkmech = 1
	firevuln = 1 // immune to fire
	brutevuln = 1
	ventcrawl = 0
	melee_damage_lower = 10
	melee_damage_upper = 15
	attacktext = "charges"
	attack_sound = 'bite.ogg'

	Die()
		..()
		icon_state = "insane-dead"
		aggressive = 0
		wanderer = 0
		defensive = 0
		atkcarbon = 0
		atksilicon = 0

/obj/effect/critter/poltergeist
	name = "Ghost"
	desc = "Terrible, bloodstained and blurred figure of human."
	icon_state = "polt"
	health = 300
	max_health = 300
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE
	aggressive = 1
	opensdoors = 1
	defensive = 1
	wanderer = 1
	atkcarbon = 1
	atksilicon = 1
	atkmech = 1
	firevuln = 0 // immune to fire
	brutevuln = 1
	ventcrawl = 1
	melee_damage_lower = 15
	melee_damage_upper = 20
	attacktext = "charges"
	attack_sound = list('polt1.ogg', 'polt2.ogg', 'polt3.ogg')

	Die()
		..()
		icon_state = "polt-dead"
		del(src)

/obj/effect/critter/shrimp
	name = "Dusty Shrimp"
	desc = "Arthropodical creature"
	icon_state = "shrimp"
	health = 120
	max_health = 120
	aggressive = 1
	opensdoors = 0
	defensive = 1
	wanderer = 1
	atkcarbon = 1
	atksilicon = 1
	atkmech = 1
	firevuln = 1 // immune to fire
	brutevuln = 1
	ventcrawl = 1
	melee_damage_lower = 5
	melee_damage_upper = 10
	attacktext = "charges"
	attack_sound = 'bite.ogg'

	Harvest(var/obj/item/weapon/W, var/mob/living/user)
		if(..())
			var/success = 0
			if(istype(W, /obj/item/weapon/butch))
				new /obj/item/weapon/reagent_containers/food/snacks/shrimpmeat(src.loc)
				new /obj/item/weapon/reagent_containers/food/snacks/shrimpmeat(src.loc)
				success = 1
			if(istype(W, /obj/item/weapon/kitchenknife))
				new /obj/item/weapon/reagent_containers/food/snacks/shrimpmeat(src.loc)
				success = 1
			if(success)
				for(var/mob/O in viewers(src, null))
					O.show_message("\red [user.name] cuts apart the [src.name]!", 1)
				del(src)
				return 1
			return 0

	Die()
		..()
		icon_state = "shrimp-dead"
		aggressive = 0
		wanderer = 0

/obj/effect/critter/banditm
	name = "Bandit"
	desc = "just a bandit."
	icon = 'critter.dmi'
	icon_state = "banditm"
	health = 70
	max_health = 70
	aggressive = 1
	task = "thinking"
	speed = 7
	chasespeed  = 5
	defensive = 1
	wanderer = 1
	opensdoors = 1
	atkcarbon = 1
	atksilicon = 1
	atkcritter = 1
	atkmech = 1
	atksame = 0
	firevuln = 1
	brutevuln = 1
	melee_damage_lower = 4
	melee_damage_upper = 12
	angertext = "leaps at"
	attacktext = "strikes"
	attack_sound = 'punch1.ogg'

	Die()
		..()
		icon_state = "banditm-dead"
		aggressive = 0
		defensive = 0
		wanderer = 0
		opensdoors = 0
		atkcarbon = 0
		atksilicon = 0
		atkcritter = 0
		atkmech = 0
		seekrange = 0

/obj/effect/critter/dog
	name = "Dog"
	desc = "A feral dog."
	icon_state = "dog"
	health = 50
	max_health = 50
	aggressive = 1
	wanderer = 1
	opensdoors = 0
	atkcarbon = 1
	atksilicon = 1
	atkcritter = 1
	atkmech = 1
	atksame = 0
	firevuln = 1
	brutevuln = 1
	melee_damage_lower = 10
	melee_damage_upper = 15
	attacktext = "charges"
	attack_sound = 'doggrowl.ogg'

	RunAttack()
		src.attacking = 1
		if(ismob(src.target))

			for(var/mob/O in viewers(src, null))
				O.show_message("\red <B>[src]</B> [src.attacktext] [src.target]!", 1)

			var/damage = rand(melee_damage_lower, melee_damage_upper)

			if(istype(target, /mob/living/carbon/human))
				var/mob/living/carbon/human/H = target
				var/dam_zone = pick("chest", "l_hand", "r_hand", "l_leg", "r_leg")
				var/datum/organ/external/affecting = H.get_organ(ran_zone(dam_zone))
				H.apply_damage(damage, BRUTE, affecting, H.run_armor_check(affecting, "melee"))
			else
				target:adjustBruteLoss(damage)

			if(attack_sound)
				playsound(loc, attack_sound, 50, 1, -1)

			AfterAttack(target)


		if(isobj(src.target))
			if(istype(target, /obj/mecha))
				//src.target:take_damage(rand(melee_damage_lower,melee_damage_upper))
				src.target:attack_critter(src)
			else
				src.target:TakeDamage(rand(melee_damage_lower,melee_damage_upper))
		spawn(attack_speed)
			src.attacking = 0
		return


	RunAttack()
		icon_state = "dog-attack"
		src.attacking = 1
		if(ismob(src.target))

			for(var/mob/O in viewers(src, null))
				O.show_message("\red <B>[src]</B> [src.attacktext] [src.target]!", 1)

			var/damage = rand(melee_damage_lower, melee_damage_upper)

			if(istype(target, /mob/living/carbon/human))
				var/mob/living/carbon/human/H = target
				var/dam_zone = pick("chest", "l_hand", "r_hand", "l_leg", "r_leg")
				var/datum/organ/external/affecting = H.get_organ(ran_zone(dam_zone))
				H.apply_damage(damage, BRUTE, affecting, H.run_armor_check(affecting, "melee"))
			else
				target:adjustBruteLoss(damage)

			if(attack_sound)
				playsound(loc, attack_sound, 50, 1, -1)

			AfterAttack(target)


		if(isobj(src.target))
			if(istype(target, /obj/mecha))
				//src.target:take_damage(rand(melee_damage_lower,melee_damage_upper))
				src.target:attack_critter(src)
			else
				src.target:TakeDamage(rand(melee_damage_lower,melee_damage_upper))
		spawn(attack_speed)
			src.attacking = 0
		icon_state = "dog"
		return



/*
// p much straight up copied from secbot code =I

/obj/zombietype/
	name = "zombie"
	desc = "moldy"
	icon = 'critter.dmi'
	layer = 5.0
	density = 1
	anchored = 0
	var/alive = 1
	var/health = 10
	var/task = "thinking"
	var/aggressive = 0
	var/defensive = 0
	var/wanderer = 1
	var/opensdoors = 0
	var/frustration = 0
	var/last_found = null
	var/target = null
	var/oldtarget_name = null
	var/target_lastloc = null
	var/atkcarbon = 0
	var/atksilicon = 0
	var/atcritter = 0
	var/attack = 0
	var/attacking = 0
	var/steps = 0
	var/firevuln = 1
	var/brutevuln = 1
	var/seekrange = 7 // how many tiles away it will look for a target
	var/friend = null // used for tracking hydro-grown monsters's creator
	var/attacker = null // used for defensive tracking
	var/angertext = "charges at" // comes between critter name and target name

	attackby(obj/item/weapon/W as obj, mob/living/user as mob)
		..()
		if (!src.alive)
			..()
			return
		switch(W.damtype)
			if("fire")
				src.health -= W.force * src.firevuln
			if("brute")
				src.health -= W.force * src.brutevuln
			else
		if (src.alive && src.health <= 0) src.CritterDeath()
		if (src.defensive)
			src.target = user
			src.oldtarget_name = user.name
			for(var/mob/O in viewers(src, null))
				O.show_message("\red <b>[src]</b> [src.angertext] [user.name]!", 1)
			src.task = "chasing"

	attack_hand(var/mob/user as mob)
		..()
		if (!src.alive)
			..()
			return
		if (user.a_intent == "hurt")
			src.health -= rand(1,2) * src.brutevuln
			for(var/mob/O in viewers(src, null))
				O.show_message("\red <b>[user]</b> punches [src]!", 1)
			playsound(src.loc, "punch", 50, 1)
			if (src.alive && src.health <= 0) src.CritterDeath()
			if (src.defensive)
				src.target = user
				src.oldtarget_name = user.name
				for(var/mob/O in viewers(src, null))
					O.show_message("\red <b>[src]</b> [src.angertext] [user.name]!", 1)
				src.task = "chasing"
		else
			for(var/mob/O in viewers(src, null))
				O.show_message("\red <b>[user]</b> pets [src]!", 1)

	proc/patrol_step()
		var/moveto = locate(src.x + rand(-1,1),src.y + rand(-1, 1),src.z)
		if (istype(moveto, /turf/simulated/floor) || istype(moveto, /turf/simulated/shuttle/floor) || istype(moveto, /turf/unsimulated/floor)) step_towards(src, moveto)
		if(src.aggressive) seek_target()
		steps += 1
		if (steps == rand(5,20)) src.task = "thinking"

	Bump(M as mob|obj)
		spawn(0)
			if ((istype(M, /obj/machinery/door)))
				var/obj/machinery/door/D = M
				if (src.opensdoors)
					D.open()
					src.frustration = 0
				else src.frustration ++
			else if ((istype(M, /mob/living/)) && (!src.anchored))
				src.loc = M:loc
				src.frustration = 0
			return
		return

	Bumped(M as mob|obj)
		spawn(0)
			var/turf/T = get_turf(src)
			M:loc = T
/*	Strumpetplaya - Not supported
	bullet_act(var/datum/projectile/P)
		var/damage = 0
		damage = round((P.power*P.ks_ratio), 1.0)

		if((P.damage_type == D_KINETIC)||(P.damage_type == D_PIERCING)||(P.damage_type == D_SLASHING))
			src.health -= (damage*brutevuln)
		else if(P.damage_type == D_ENERGY)
			src.health -= damage
		else if(P.damage_type == D_BURNING)
			src.health -= (damage*firevuln)
		else if(P.damage_type == D_RADIOACTIVE)
			src.health -= 1
		else if(P.damage_type == D_TOXIC)
			src.health -= 1

		if (src.health <= 0)
			src.CritterDeath()
*/
	ex_act(severity)
		switch(severity)
			if(1.0)
				src.CritterDeath()
				return
			if(2.0)
				src.health -= 15
				if (src.health <= 0)
					src.CritterDeath()
				return
			else
				src.health -= 5
				if (src.health <= 0)
					src.CritterDeath()
				return
		return

	meteorhit()
		src.CritterDeath()
		return

	proc/check_health()
		if (src.health <= 0)
			src.CritterDeath()

	blob_act()
		if(prob(25))
			src.CritterDeath()
		return

	proc/process()
		set background = 1
		if (!src.alive) return
		check_health()
		switch(task)
			if("thinking")
				src.attack = 0
				src.target = null
				sleep(15)
				walk_to(src,0)
				if (src.aggressive) seek_target()
				if (src.wanderer && !src.target) src.task = "wandering"
			if("chasing")
				if (src.frustration >= 8)
					src.target = null
					src.last_found = world.time
					src.frustration = 0
					src.task = "thinking"
					walk_to(src,0)
				if (target)
					if (get_dist(src, src.target) <= 1)
						var/mob/living/carbon/M = src.target
						ChaseAttack(M)
						src.task = "attacking"
						src.anchored = 1
						src.target_lastloc = M.loc
					else
						var/turf/olddist = get_dist(src, src.target)
						walk_to(src, src.target,1,4)
						if ((get_dist(src, src.target)) >= (olddist))
							src.frustration++
						else
							src.frustration = 0
						sleep(5)
				else src.task = "thinking"
			if("attacking")
				// see if he got away
				if ((get_dist(src, src.target) > 1) || ((src.target:loc != src.target_lastloc)))
					src.anchored = 0
					src.task = "chasing"
				else
					if (get_dist(src, src.target) <= 1)
						var/mob/living/carbon/M = src.target
						if (!src.attacking) CritterAttack(src.target)
						if (!src.aggressive)
							src.task = "thinking"
							src.target = null
							src.anchored = 0
							src.last_found = world.time
							src.frustration = 0
							src.attacking = 0
						else
							if(M!=null)
								if (M.health < 0)
									src.task = "thinking"
									src.target = null
									src.anchored = 0
									src.last_found = world.time
									src.frustration = 0
									src.attacking = 0
					else
						src.anchored = 0
						src.attacking = 0
						src.task = "chasing"
			if("wandering")
				patrol_step()
				sleep(10)
		spawn(8)
			process()
		return


	New()
		spawn(0) process()
		..()

/obj/zombietype/proc/seek_target()
	src.anchored = 0
	for (var/mob/living/C in view(src.seekrange,src))
		if (src.target)
			src.task = "chasing"
			break
		if ((C.name == src.oldtarget_name) && (world.time < src.last_found + 100)) continue
		if (istype(C, /mob/living/carbon/) && !src.atkcarbon) continue
		if (istype(C, /mob/living/silicon/) && !src.atksilicon) continue
		if (C.health < 0) continue
		if (C.name == src.friend) continue
		if (C.name == src.attacker) src.attack = 1
		if (istype(C, /mob/living/carbon/) && src.atkcarbon) src.attack = 1
		if (istype(C, /mob/living/silicon/) && src.atksilicon) src.attack = 1

		if (src.attack)
			src.target = C
			src.oldtarget_name = C.name
			for(var/mob/O in viewers(src, null))
				O.show_message("\red <b>[src]</b> [src.angertext] [C.name]!", 1)
			src.task = "chasing"
			break
		else
			continue




/obj/zombietype/proc/CritterDeath()
	if (!src.alive) return
	src.icon_state += "-dead"
	src.alive = 0
	src.anchored = 0
	src.density = 0
	walk_to(src,0)
	src.visible_message("<b>[src]</b> dies!")

/obj/zombietype/proc/ChaseAttack(mob/M)
	for(var/mob/O in viewers(src, null))
		O.show_message("\red <B>[src]</B> leaps at [src.target]!", 1)
	//playsound(src.loc, 'genhit1.ogg', 50, 1, -1)

/obj/zombietype/proc/CritterAttack(mob/M)
	src.attacking = 1
	for(var/mob/O in viewers(src, null))
		O.show_message("\red <B>[src]</B> bites [src.target]!", 1)
	src.target:bruteloss += 1
	spawn(25)
		src.attacking = 0

/obj/zombietype/proc/CritterTeleport(var/telerange, var/dospark, var/dosmoke)
	if (!src.alive) return
	var/list/randomturfs = new/list()
	for(var/turf/T in orange(src, telerange))
		if(istype(T, /turf/space) || T.density) continue
		randomturfs.Add(T)
	src.loc = pick(randomturfs)
	if (dospark)
		var/datum/effects/system/spark_spread/s = new /datum/effects/system/spark_spread
		s.set_up(5, 1, src)
		s.start()
	if (dosmoke)
		var/datum/effects/system/harmless_smoke_spread/smoke = new /datum/effects/system/harmless_smoke_spread()
		smoke.set_up(10, 0, src.loc)
		smoke.start()
	src.task = "thinking"






/obj/zombietype/Zombie
	name = "Zombie"
	desc = "matrix128 was here"
	icon='human.dmi'
	icon_state = "body_m_s"
	density = 1
	health = 75
	aggressive = 1
	defensive = 0
	wanderer = 1
	opensdoors = 0
	atkcarbon = 1
	atksilicon = 1
	firevuln = 3
	brutevuln = 1
	angertext = "starts chasing" // comes between critter name and target name

	New()
		src.seek_target()
		..()

	seek_target()
		src.anchored = 0
		for (var/mob/living/C in view(src.seekrange,src))
			if (src.target)
				src.task = "chasing"
				break
			if ((C.name == src.oldtarget_name) && (world.time < src.last_found + 100)) continue
			if (C.health < 0) continue
			if (C.name == src.attacker) src.attack = 1
			if (istype(C, /mob/living/carbon/)) src.attack = 1
			if (istype(C, /mob/living/silicon/)) src.attack = 1
			if (src.attack)
				src.target = C
				src.oldtarget_name = C.name
				for(var/mob/O in viewers(src, null))
					O.show_message("\red <b>[src]</b> [src.angertext] [C.name]!", 1)
				//playsound(src.loc, pick('YetiGrowl.ogg'), 50, 0)	Strumpetplaya - Not supported
				src.task = "chasing"
				break
			else
				continue

	ChaseAttack(mob/M)
		for(var/mob/O in viewers(src, null))
			O.show_message("\red <B>[src]</B> bites [M]!", 1)
		playsound(src.loc, 'bang.ogg', 50, 1, -1)
		M.stunned = 10
		M.weakened = 10

	CritterAttack(mob/M)
		src.attacking = 1
		for(var/mob/O in viewers(src, null))
			O.show_message("\red <B>[src]</B> devours [M] in one bite!", 1)
		playsound(src.loc, 'eatfood.ogg', 30, 1, -2)
		M.death(1)
		var/atom/movable/overlay/animation = null
		M.monkeyizing = 1
		M.canmove = 0
		M.icon = null
		M.invisibility = 101
		if(ishuman(M))
			animation = new(src.loc)
			animation.icon_state = "blank"
			animation.icon = 'icons/mob/mob.dmi'
			animation.master = src
		if (M.client)
			var/mob/dead/observer/newmob
			newmob = new/mob/dead/observer(M)
			M.client:mob = newmob
			M.mind.transfer_to(newmob)
		del(M)
		src.task = "thinking"
		src.seek_target()
		src.attacking = 0
		sleep(10)
		//playsound(src.loc, pick('burp_alien.ogg'), 50, 0)	Strumpetplaya - Not supported


/obj/zombietype/Predator
	name = "Predator"
	desc = "matrix128 was here."
	icon='human.dmi'
	icon_state = "body_m_s"
	health = 35
	aggressive = 1
	seekrange = 7

	seek_target()
		src.anchored = 0
		for (var/mob/living/C in view(src.seekrange,src))
			if (!src.alive) break
			if (C.health < 0) continue
			if (C.name == src.attacker) src.attack = 1
			if (istype(C, /mob/living/carbon/) && src.atkcarbon) src.attack = 1
			if (istype(C, /mob/living/silicon/) && src.atksilicon) src.attack = 1

			if (src.attack)
				src.target = C
				src.oldtarget_name = C.name
				for(var/mob/O in viewers(src, null))
					O.show_message("\red <b>[src]</b> shoots a blade  at [C.name]s neck!", 1)
				//playsound(src.loc, 'lasermed.ogg', 100, 1)	Strumpetplaya - Not supported
				if (prob(66))
					C.fireloss += rand(99,160)
					var/obj/decal/cleanable/blood/s = new /obj/decal/cleanable/blood
					s.set_up(3, 1, C)
					s.start()
				else target << "\red The blade stabs the wall!"
				src.attack = 0
				sleep(12)
				seek_target()
				src.task = "thinking"
				break
			else continue
*/