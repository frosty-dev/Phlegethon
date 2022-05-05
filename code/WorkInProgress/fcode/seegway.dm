/obj/structure/stool/bed/chair/seegway
	name = "Military Seegway"
	desc = "Military seegway SS-12"
	icon = 'code/WorkInProgress/fcode/forFix.dmi'
	icon_state = "seegway"
	anchored = 1
	density = 1

/obj/structure/stool/bed/chair/seegway/New()
//	handle_rotation()



/obj/structure/stool/bed/chair/seegway/relaymove(mob/user, direction)
	if(user.stat || user.stunned || user.weakened || user.paralysis)
		unbuckle()
	else
		step(src, direction)
		icon_state = "seegway"
		update_mob()
//		handle_rotation()

/obj/structure/stool/bed/chair/seegway/Move()
	..()
	if(buckled_mob)
		if(buckled_mob.buckled == src)
			buckled_mob.loc = loc

/obj/structure/stool/bed/chair/seegway/buckle_mob(mob/M, mob/user)
	if(M != user || !ismob(M) || get_dist(src, user) > 1 || user.restrained() || user.lying || user.stat || M.buckled || istype(user, /mob/living/silicon))
		return

	unbuckle()

	M.visible_message(\
		"<span class='notice'>[M] climbs onto the seegway!</span>",\
		"<span class='notice'>You climb onto the seegway!</span>")
	M.buckled = src
	M.loc = loc
	M.dir = dir
//	M.update_canmove()
	buckled_mob = M
	update_mob()
	add_fingerprint(user)
	return

/obj/structure/stool/bed/chair/seegway/unbuckle()
	if(buckled_mob)
		buckled_mob.pixel_x = 0
		buckled_mob.pixel_y = 0
	..()
/*
/obj/structure/stool/bed/chair/seegway/handle_rotation()
	if(dir == SOUTH)
		layer = FLY_LAYER
	else
		layer = OBJ_LAYER

	if(buckled_mob)
		if(buckled_mob.loc != loc)
			buckled_mob.buckled = null //Temporary, so Move() succeeds.
			buckled_mob.buckled = src //Restoring

	update_mob()
*/
/obj/structure/stool/bed/chair/seegway/proc/update_mob()
	if(buckled_mob)
		buckled_mob.dir = dir
		switch(dir)
			if(SOUTH)
				buckled_mob.pixel_x = 0
				buckled_mob.pixel_y = 5
			if(WEST)
				buckled_mob.pixel_x = 0
				buckled_mob.pixel_y = 5
			if(NORTH)
				buckled_mob.pixel_x = 0
				buckled_mob.pixel_y = 5
			if(EAST)
				buckled_mob.pixel_x = 0
				buckled_mob.pixel_y = 5

/obj/structure/stool/bed/chair/seegway/bullet_act(var/obj/item/projectile/Proj)
	if(buckled_mob)
		if(prob(65))
			return buckled_mob.bullet_act(Proj)
	visible_message("<span class='warning'>[Proj] ricochets off the seegway!</span>")

