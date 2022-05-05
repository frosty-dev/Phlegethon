//This file was auto-corrected by findeclaration.exe on 29/05/2012 15:03:04

/datum/game_mode/var/list/zombies = list()

/datum/game_mode/zombie
	name = "Zombie"
	config_tag = "zombie"
	required_players = 6
	restricted_jobs = list("AI", "Cyborg")
	recommended_enemies = 2 // need at least a meme and a host
	votable = 0 // temporarily disable this mode for voting



	var/var/list/datum/mind/first_hosts = list()
	var/var/list/assigned_hosts = list()

	var/const/prob_int_murder_target = 50 // intercept names the assassination target half the time
	var/const/prob_right_murder_target_l = 25 // lower bound on probability of naming right assassination target
	var/const/prob_right_murder_target_h = 50 // upper bound on probability of naimg the right assassination target

	var/const/prob_int_item = 50 // intercept names the theft target half the time
	var/const/prob_right_item_l = 25 // lower bound on probability of naming right theft target
	var/const/prob_right_item_h = 50 // upper bound on probability of naming the right theft target

	var/const/prob_int_sab_target = 50 // intercept names the sabotage target half the time
	var/const/prob_right_sab_target_l = 25 // lower bound on probability of naming right sabotage target
	var/const/prob_right_sab_target_h = 50 // upper bound on probability of naming right sabotage target

	var/const/prob_right_killer_l = 25 //lower bound on probability of naming the right operative
	var/const/prob_right_killer_h = 50 //upper bound on probability of naming the right operative
	var/const/prob_right_objective_l = 25 //lower bound on probability of determining the objective correctly
	var/const/prob_right_objective_h = 50 //upper bound on probability of determining the objective correctly

	var/const/waittime_l = 600 //lower bound on time before intercept arrives (in tenths of seconds)
	var/const/waittime_h = 1800 //upper bound on time before intercept arrives (in tenths of seconds)

/datum/game_mode/zombie/announce()
	world << "<B>The current game mode is - Zombie!</B>"
	world << "<B>An unknown virus has infested the bloodstream of a crew member. Find and destroy it by any means necessary.</B>"

/datum/game_mode/zombie/can_start()
	if(!..())
		return 0

	// for every 10 players, get 1 meme, and for each meme, get a host
	// also make sure that there's at least one meme and one host
	recommended_enemies = max(src.num_players() / 10 * 2, 2)

	var/list/datum/mind/possible_zombies = get_players_for_role(BE_ZOMBIE)

	if(possible_zombies.len < 2)
		log_admin("MODE FAILURE: ZOMBIE. NOT ENOUGH ZOMBIE CANDIDATES.")
		return 0 // not enough candidates for meme

	// for each 2 possible memes, add one meme and one host
	while(possible_zombies.len >= 2)
		var/datum/mind/zombie = pick(possible_zombies)
		possible_zombies.Remove(zombie)

		var/datum/mind/first_host = pick(possible_zombies)
		possible_zombies.Remove(first_host)

		modePlayer += zombie
		modePlayer += first_host
		zombies += zombie
		first_hosts += first_host

		// so that we can later know which host belongs to which meme
		assigned_hosts[zombie.key] = first_host

		zombie.assigned_role = "MODE" //So they aren't chosen for other jobs.
		zombie.special_role = "Zombie"

	return 1

/datum/game_mode/zombie/pre_setup()
	return 1


/datum/game_mode/zombie/post_setup()
	// create a meme and enter it
	for(var/datum/mind/zombie in zombies)
		var/mob/living/parasite/zombie/M = new
		var/mob/original = zombie.current
		zombie.transfer_to(M)
		M.clearHUD()

		// get the host for this meme
		var/datum/mind/first_host = assigned_hosts[zombie.key]
		// this is a redundant check, but I don't think the above works..
		// if picking hosts works with this method, remove the method above
		if(!first_host)
			first_host = pick(first_hosts)
			first_hosts.Remove(first_host)
		M.enter_host(first_host.current)
		forge_zombie_objectives(zombie, first_host)

		del original

	log_admin("Created [zombies.len] zombies.")

	spawn (rand(waittime_l, waittime_h))
		send_intercept()
	..()
	return


/datum/game_mode/proc/forge_zombie_objectives(var/datum/mind/zombie, var/datum/mind/first_host)
	// meme always needs to attune X hosts
	var/datum/objective/zombie_attune/attune_objective = new
	attune_objective.owner = zombie
	attune_objective.gen_amount_goal(3,6)
	zombie.objectives += attune_objective

	// generate some random objectives, use standard traitor objectives
	var/job = first_host.assigned_role

	for(var/datum/objective/o in SelectObjectives(job, zombie))
		o.owner = zombie
		zombie.objectives += o

	greet_zombie(zombie)

	return

/datum/game_mode/proc/greet_zombie(var/datum/mind/zombie, var/you_are=1)
	if (you_are)
		zombie.current << "<B>\red You are a zombie!</B>"

	var/obj_count = 1
	for(var/datum/objective/objective in zombie.objectives)
		zombie.current << "<B>Objective #[obj_count]</B>: [objective.explanation_text]"
		obj_count++
	return

/datum/game_mode/zombie/check_finished()
	var/zombies_alive = 0
	for(var/datum/mind/zombie in zombies)
		if(!istype(zombie.current,/mob/living))
			continue
		if(zombie.current.stat==2)
			continue
		zombies_alive++

	if (zombies_alive)
		return ..()
	else
		return 1

/datum/game_mode/proc/auto_declare_completion_zombie()
	for(var/datum/mind/zombie in zombies)
		var/zombiewin = 1
		var/attuned = 0
		if((zombie.current) && istype(zombie.current,/mob/living/parasite/zombie))
			world << "<B>The zombie was [zombie.current.key].</B>"
			world << "<B>The last host was [zombie.current:host.key].</B>"
			world << "<B>Hosts infected: [attuned]</B>"

			var/count = 1
			for(var/datum/objective/objective in zombie.objectives)
				if(objective.check_completion())
					world << "<B>Objective #[count]</B>: [objective.explanation_text] \green <B>Success</B>"
					feedback_add_details("zombie_objective","[objective.type]|SUCCESS")
				else
					world << "<B>Objective #[count]</B>: [objective.explanation_text] \red Failed"
					feedback_add_details("zombie_objective","[objective.type]|FAIL")
					zombiewin = 0
				count++

		else
			zombiewin = 0

		if(zombiewin)
			world << "<B>The zombie was successful!<B>"
			feedback_add_details("zombie_success","SUCCESS")
		else
			world << "<B>The zombie has failed!<B>"
			feedback_add_details("zombie_success","FAIL")
	return 1
