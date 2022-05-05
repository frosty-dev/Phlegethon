/obj/item/projectile/bullet
	name = "\improper Bullet"
	icon_state = "bullet"
	damage_type = BRUTE
	nodamage = 0
	flag = "bullet"
	New()
		damage = roll("20d6")

//phlegballistic
/obj/item/bullet
	name = "piece of metal"
	icon = 'ammo.dmi'
	icon_state = "balbullet"
	desc = "Just a shrapnel or bullet"

	New()
		pixel_x = rand(-10, 10)
		pixel_y = rand(-10, 10)


/obj/item/projectile/bullet/weakbullet
	damage = 15
	stun = 5
	weaken = 5


/obj/item/projectile/bullet/midbullet
	New()
		damage = roll("7d10")
	weaken = 3
	eyeblur = 3
	stun = 3

/obj/item/projectile/bolt
	New()
		damage = roll("10d6")
	stun = 3
	weaken = 1
	eyeblur = 5
	stutter = 5
	icon_state = "SpearFlight"

	on_hit(var/atom/target)//, var/blocked = 0)
		new	/obj/item/ammo_magazine/bolt(target.loc)

/obj/item/projectile/bullet/suffocationbullet//How does this even work?
//	name = "\improper ullet"
	damage = 20
	damage_type = OXY


/obj/item/projectile/bullet/cyanideround
	name = "\improper Poison Bullet"
	damage = 40
	damage_type = TOX


/obj/item/projectile/bullet/burstbullet//I think this one needs something for the on hit
	name = "\improper Exploding Bullet"
	damage = 20


/obj/item/projectile/bullet/stunshot
	name = "\improper Stunshot"
	damage = 15
	stun = 10
	weaken = 10
	stutter = 10

/obj/item/projectile/firebullet
	name = "\improper Fire Bullet"
	icon_state = "stinger"
	damage_type = BURN
	nodamage = 0
	flag = "bullet"
	New()
		damage = roll("20d6")
		ul_SetLuminosity(5,2,0)

/obj/item/projectile/bullet/suffocationbullet//How does this even work?
//	name = "\improper ullet"
	damage = 20
	damage_type = OXY


/obj/item/projectile/bullet/cyanideround
	name = "\improper Poison Bullet"
	damage = 40
	damage_type = TOX


/obj/item/projectile/bullet/burstbullet//I think this one needs something for the on hit
	name = "\improper Exploding Bullet"
	damage = 20

/obj/item/projectile/bullet/toxicshell
	name = "toxic shell"
	damage = 25
	damage_type = TOX

/obj/item/projectile/bullet/stunshot
	name = "\improper Stunshot"
	damage = 15
	stun = 10
	weaken = 10
	stutter = 10

//gemini

/obj/item/projectile/bullet/smbullet
	weaken = 3
	stun = 3
	eyeblur = 3
	name = "\improper Bullet"
	icon_state = "bullet"
	damage_type = BRUTE
	nodamage = 0
	flag = "bullet"
	New()
		damage = roll("6d6")

/obj/item/projectile/bullet/sprbullet
	weaken = 2
	stun = 5
	eyeblur = 2
	name = "\improper Bullet"
	icon_state = "bullet"
	damage_type = BRUTE
	nodamage = 0
	flag = "bullet"
	pntr = 1
	pntr_force = 3
	bumped = 0

	New()
		damage = roll("11d6")

/obj/item/projectile/bullet/ninemmbullet
	stun = 2
	weaken = 4
	eyeblur = 4
	name = "\improper Bullet"
	icon_state = "bullet"
	damage_type = BRUTE
	nodamage = 0
	flag = "bullet"

	New()
		damage = roll("9d6")

/obj/item/projectile/bullet/mdbullet
	stun = 3
	weaken = 8
	eyeblur = 5
	name = "\improper Bullet"
	icon_state = "bullet"
	damage_type = BRUTE
	nodamage = 0
	flag = "bullet"
	New()
		damage = roll("12d6")

/obj/item/projectile/bullet/exmdbullet
	stun = 5
	paralyze = 7
	weaken = 15
	eyeblur = 15
	stutter = 15
	name = "\improper Bullet"
	icon_state = "bullet"
	damage_type = BRUTE
	nodamage = 0
	flag = "bullet"
	New()
		damage = roll("18d6")

/obj/item/projectile/bullet/bgbullet
	stun = 5
	weaken = 15
	stutter = 7
	eyeblur = 7
	drowsy = 4
	name = "\improper Bullet"
	icon_state = "bullet"
	damage_type = BRUTE
	nodamage = 0
	flag = "bullet"
	New()
		damage = roll("14d6")

/*
/obj/item/projectile/bullet/lead
	name ="lead"
	icon_state= "lead"
	damage_type = BRUTE
	nodamage = 0
	flag = "bullet"
//	New()
//		damage = roll("4d10")
	on_hit(var/atom/target, var/blocked = 0)//These two could likely check temp protection on the mob
		if(istype(target, /mob/living))
			var/mob/M = target
			var/damage = rand(5,10)
				M.apply_damage(damage, BRUTE, pick("head", "chest", "l_leg", "r_leg", "l_arm", "r_arm"))
				M.apply_damage(damage, BRUTE, pick("head", "chest", "l_leg", "r_leg", "l_arm", "r_arm"))
				M.apply_damage(damage, BRUTE, pick("head", "chest", "l_leg", "r_leg", "l_arm", "r_arm"))
				M.apply_damage(damage, BRUTE, pick("head", "chest", "l_leg", "r_leg", "l_arm", "r_arm"))
				M.apply_damage(damage, BRUTE, pick("head", "chest", "l_leg", "r_leg", "l_arm", "r_arm"))
				M.apply_damage(damage, BRUTE, pick("head", "chest", "l_leg", "r_leg", "l_arm", "r_arm"))
		return 1
*/

/obj/item/projectile/bullet/gaussbullet
	stun = 5
	weaken = 5
	stutter = 20
	eyeblur = 20
	drowsy = 8
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE
	name = "\improper Bullet"
	icon_state = "bullet"
	damage_type = BRUTE
	flag = "bullet"
	bumped = 0
	pntr = 1
	pntr_force = 6

	New()
		damage = roll("20d6")