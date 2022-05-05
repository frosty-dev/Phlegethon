/datum/disease/insanity
	name = "Insanity"
	max_stages = 5
	spread = "Airborne"
	cure = "Lithium"
	cure_id = "lithium"
	cure_chance = 10
	agent = "Rabies A82.11"
	affected_species = list("Human")
	curable = 1
	permeability_mod = 0.5
	stage_prob = 5
	severity = "Serious"
	longevity = 300

/datum/disease/insanity/stage_act()
	..()
	switch(stage)
		if(1)
			if(prob(2))
				affected_mob.emote("sneeze")
		if(2)
			if(prob(30))
				affected_mob.adjustToxLoss(0,5)
				affected_mob.updatehealth()
			if(prob(5))
				affected_mob.emote("sneeze")
		if(3)
		//	affected_mob.mutantrace = "zombie"
			if(prob(15))
				affected_mob.emote("cough")
			else if(prob(20))
				affected_mob.emote("gasp")
			if(prob(10))
				affected_mob << "\red You're starting to feel very weak and hunger..."
				affected_mob.nutrition -= 20
		if(4)
			if(prob(20))
				affected_mob.emote("cough")
			if(prob(10))
				if (affected_mob.nutrition > 100)
					affected_mob.Stun(rand(4,6))
					for(var/mob/O in viewers(world.view, affected_mob))
						O.show_message(text("<b>\red [] throws up!</b>", affected_mob), 1)
					playsound(affected_mob.loc, 'splat.ogg', 50, 1)
					var/turf/location = affected_mob.loc
					if (istype(location, /turf/simulated))
						location.add_vomit_floor(affected_mob)
					affected_mob.nutrition -= 95
			if(prob(15))
				affected_mob.adjustOxyLoss(0.5)
				affected_mob.adjustToxLoss(1)
				affected_mob.Weaken(2)
				affected_mob.updatehealth()
		if(5)
			if(prob(30))
				affected_mob <<"\red You dont feel self..."
				affected_mob.adjustToxLoss(2)
				affected_mob.updatehealth()
			if(prob(10))
				affected_mob.emote("scream")
				for(var/obj/item/W in affected_mob)
					affected_mob.drop_from_slot(W)
				new /obj/effect/critter/insane(affected_mob.loc)
				affected_mob.gib()

	return