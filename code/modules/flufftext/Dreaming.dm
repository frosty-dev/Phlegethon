mob/living/carbon/proc/dream()
	dreaming = 1
	//phleg dreams
	var/list/dreams = list(
		"an ID card","a bottle","a familiar face","a convict","a toolbox","a overseer","pill",
		"voices from all around","wasteland","a medic","the reactor","a traitor","an ally","darkness",
		"light","a cop","a prowler","a catastrophe","a loved one","a gun","warmth","freezing","the sun",
		"a hat","the Suburbs","a ruined city","a borough","bullets","air","the pharmacology","the computers","blinking lights",
		"a blue light","an abandoned building","Metropolis","The Arcology 17","blood","healing","power","respect",
		"riches","dust","a crash","happiness","pride","a fall","water","flames","ice","snacks","flying"
		)

/*	var/list/dreams = list(
		"an ID card","a bottle","a familiar face","a crewmember","a toolbox","a security officer","the captain",
		"voices from all around","deep space","a doctor","the engine","a traitor","an ally","darkness",
		"light","a scientist","a monkey","a catastrophe","a loved one","a gun","warmth","freezing","the sun",
		"a hat","the Luna","a ruined station","a planet","plasma","air","the medical bay","the bridge","blinking lights",
		"a blue light","an abandoned laboratory","Nanotrasen","The Syndicate","blood","healing","power","respect",
		"riches","space","a crash","happiness","pride","a fall","water","flames","ice","melons","flying"
		)*/
	spawn(0)
		for(var/i = rand(1,4),i > 0, i--)
			var/dream_image = pick(dreams)
			dreams -= dream_image
			src << "\blue <i>... [dream_image] ...</i>"
			sleep(rand(40,70))
			if(paralysis <= 0)
				dreaming = 0
				return 0
		dreaming = 0
		return 1

mob/living/carbon/proc/handle_dreams()
	if(prob(5) && !dreaming) dream()

mob/living/carbon/var/dreaming = 0