/obj/machinery/club/lightmusic
	name = "Light music"
	desc = "."
	icon = 'device.dmi'
	icon_state = "locator"
	var/on = 0
	var/error = 0
	var/speed = 0
	New()
		sleep(30)
		for(var/obj/effect/overlay/bluelight/T in world)
			T.icon_state = "invi"
		for(var/obj/effect/overlay/bluelight/T in world)
			if(T.icon_state == "lightblue")
				T.icon_state = "invi"
				if(!error)
					sleep(900)
					message_admins("ERROR: Bluelight overlays have bug, please, report to coders.")
					error = 1

/obj/machinery/club/lightmusic/attack_hand()
	var/dat = {"<B> Valve properties: </B>
	<BR> <B> Speed:</B>[speed != 0 ? "<A href='?src=\ref[src];speed_0=1'>0</A>" : "0"]
	<B> </B> [speed != 1 ? "<A href='?src=\ref[src];speed_1=1'>1</A>" : "1"]
	<B> </B> [speed != 2 ? "<A href='?src=\ref[src];speed_2=1'>2</A>" : "2"]
	<B> </B> [speed != 3 ? "<A href='?src=\ref[src];speed_3=1'>3</A>" : "3"]"}

	usr << browse(dat, "window=light_music;size=600x300")
	onclose(usr, "light_music")
	return

/obj/machinery/club/lightmusic/Topic(href, href_list)
	..()
	if ( usr.stat || usr.restrained() )
		return
	if(href_list["speed_0"])
		sleep(10)
		for(var/obj/effect/overlay/bluelight/T in world)
			T.icon_state = "invi"
		sleep(3)
		for(var/obj/effect/overlay/bluelight/T in world)
			if(T.icon_state == "blinkblue")
				T.icon_state = "invi"
				if(error != 2)
					message_admins("ERROR: Bluelight overlays have bug, please, report to coders.")
					error = 2
		speed = 0
		return
	else if(href_list["speed_1"])
		usr << "Function is not allowed for now."
		return
	else if(href_list["speed_2"])
		sleep(10)
		for(var/obj/effect/overlay/bluelight/T in world)
			T.icon_state = "blinkblue"
		sleep(3)
		for(var/obj/effect/overlay/bluelight/T in world)
			if(T.icon_state == "invi")
				T.icon_state = "blinkblue"
				if(error != 2)
					message_admins("ERROR: Bluelight overlays have bug, please, report to coders.")
					error = 2
		speed = 2
		return
	else if(href_list["speed_3"])
		usr << "Function is not alliwed for now."
		return
	return

/turf/simulated/floor/clubfloor
	icon_state = "bcircuitoff"
	New()
		if(prob(10))
			overlays << image (icon = 'icons/obj/structures.dmi', icon_state = "latticefull")
/*
/obj/machinery/club/player
	name = "Player"
	desc = "."
	icon = 'device.dmi'
	icon_state = "locator"
	var
		playing_track = "Space Assgole.wma"
		list
			hearer = list()
			new_hearer = list()
//			playing = new


	New()
		world << "New."
		spawn()
			world << "Start."
			while(src)
				world << "Now."
				sleep(50)
				for(var/mob/M in oviewers())
					world << "First cycle."
					if(M.hear_music != 1)
						world << "Find."
						M << sound(playing_track)
						hearer += M
				for(var/mob/M in hearer)
					world << "Second cycle."
					for(M in hearers())
						world << "Check."
						new_hearer += M
						hearer -= M
						world << "Exclude."
				for(var/mob/M in hearer)
					world << "Third cycle."
					M << playsound (null)
				new_hearer = hearer

/obj/machinery/club/player/attack_hand()
	usr << sound("Space Assgole.wma")
*/
/*	New()
		spawn()
			while(src)
				sleep(50)
				include_mob()
				exclude_mob()
				play_sound()

	proc/include_mob()
		for(var/mob/M in hearers())
			for(M in new_hearer)
				world << "Include."
				return
			new_hearer += M

	proc/exclude_mob()
		for(var/mob/M in hearer)
			for(M in new_hearer)
				world << "Exclude."
				return
			new_hearer -= M

	proc/play_sound()
		playing = new_hearer - hearer
		for(var/mob/M in playing)
			world << "Playing."
			M << playsound(playing_track)
		playing = hearer - new_hearer
		for(var/mob/M in playing)
			world << "Stop playing."
			M << playsound(null)

	proc/switch_music()
		hearer = null
		new_hearer = null
*/
/*	New()
		Play()
	proc/Play()
		spawn()
			while(src)
				sleep(50)
				while(!playing_track)
					sleep(50)
				for(var/obj/effect/overlay/bluelight/BL)
					for(var/mob/M in BL.contents)
						for(M in new_hearers)
							return
						new_hearers += M
				playing = hearers - new_hearers
				for(var/mob/M in playing)
					M << playsound(null)
				if(playing_track)
					playing = new_hearers - hearers
					for(var/mob/M in playing)
						M << playsound(playing_track)
				else
					for(var/mob/C in new_hearers)
						C << playsound(null)
				hearers = new_hearers
*/


/obj/effect/overlay/bluelight
	icon = 'icons/effects/alert.dmi'
	icon_state = "lightblue"
	mouse_opacity = 0
	layer = 10
	anchored = 1
	var/turf
	New()
		turf = src.loc
/*
/sound/jukebox/test
	file = 'TestLoop1.ogg'
	falloff = 2
	repeat = 1
*/
// /mob/var/music = 0


/*
/obj/machinery/club/jukebox
	name = "Old Jukebox"
	desc = "vintage music machine adopted for broadcast music radio wave"
	icon = 'device.dmi'
	icon_state = "jukebox"
	var/playing = 0
	density = 1
	anchored = 1

/obj/machinery/club/jukebox/New()
	..()
	sleep(2)
	new /sound/jukebox/test(src)
	return

/obj/machinery/club/jukebox/attack_hand(mob/user as mob)

	var/t = "<B>Turntable Interface</B><br><br>"
	//t += "<A href='?src=\ref[src];on=1'>On</A><br>"
	t += "<A href='?src=\ref[src];off=1'>Off</A><br><br>"
	t += "<A href='?src=\ref[src];on1=Testloop1'>Old Jazz Wave</A><br>"
	t += "<A href='?src=\ref[src];on2=Testloop2'>Zion Cluster Dub</A><br>"
	t += "<A href='?src=\ref[src];on3=Testloop3'>Transcendence Heritage</A><br>"
	t += "<A href='?src=\ref[src];on4=Testloop4'>Space Rebels Wave</A><br>"
	t += "<A href='?src=\ref[src];on5=Testloop5'>Abandoned Straylight Wave</A><br>"
	t += "<A href='?src=\ref[src];on6=Testloop6'>Retromood Wave</A><br>"
	t += "<A href='?src=\ref[src];on7=Testloop7'>Sprawl Wave</A><br>"

	user << browse(t, "window=turntable;size=420x700")


/obj/machinery/club/jukebox/Topic(href, href_list)
	..()
	var/area/A = src.loc.loc
	if( href_list["on1"] )
		if(src.playing == 0)
			//world << "Should be working..."
			var/sound/S = sound('TestLoop1.ogg')
			S.repeat = 1
			S.channel = 10
			S.falloff = 2
			S.wait = 1
			S.environment = 0
			//for(var/mob/M in world)
			//	if(M.loc.loc == src.loc.loc && M.music == 0)
			//		world << "Found the song..."
			//		M << S
			//		M.music = 1

			playing = 1
			while(playing == 1)
				for(var/mob/M in world)
					if((M.loc.loc in A.related) && M.music == 0)
						//world << "Found the song..."
						M << S
						M.music = 1
				sleep(10)
			return
	if( href_list["on2"] )
		if(src.playing == 0)
			//world << "Should be working..."
			var/sound/S = sound('TestLoop2.ogg')
			S.repeat = 1
			S.channel = 10
			S.falloff = 2
			S.wait = 1
			S.environment = 0
			//for(var/mob/M in world)
			//	if(M.loc.loc == src.loc.loc && M.music == 0)
			//		world << "Found the song..."
			//		M << S
			//		M.music = 1

			playing = 1
			while(playing == 1)
				for(var/mob/M in world)
					if(M.loc.loc == src.loc.loc && M.music == 0)
						//world << "Found the song..."
						M << S
						M.music = 1
				sleep(10)
			return
	if( href_list["on3"] )
		if(src.playing == 0)
			//world << "Should be working..."
			var/sound/S = sound('TestLoop3.ogg')
			S.repeat = 1
			S.channel = 10
			S.falloff = 2
			S.wait = 1
			S.environment = 0
			//for(var/mob/M in world)
			//	if(M.loc.loc == src.loc.loc && M.music == 0)
			//		world << "Found the song..."
			//		M << S
			//		M.music = 1

			playing = 1
			while(playing == 1)
				for(var/mob/M in world)
					if(M.loc.loc == src.loc.loc && M.music == 0)
						//world << "Found the song..."
						M << S
						M.music = 1
				sleep(10)
			return
	if( href_list["on4"] )
		if(src.playing == 0)
			//world << "Should be working..."
			var/sound/S = sound('TestLoop4.ogg')
			S.repeat = 1
			S.channel = 10
			S.falloff = 2
			S.wait = 1
			S.environment = 0
			//for(var/mob/M in world)
			//	if(M.loc.loc == src.loc.loc && M.music == 0)
			//		world << "Found the song..."
			//		M << S
			//		M.music = 1

			playing = 1
			while(playing == 1)
				for(var/mob/M in world)
					if(M.loc.loc == src.loc.loc && M.music == 0)
						//world << "Found the song..."
						M << S
						M.music = 1
				sleep(10)
			return
	if( href_list["on5"] )
		if(src.playing == 0)
			//world << "Should be working..."
			var/sound/S = sound('TestLoop5.ogg')
			S.repeat = 1
			S.channel = 10
			S.falloff = 2
			S.wait = 1
			S.environment = 0
			//for(var/mob/M in world)
			//	if(M.loc.loc == src.loc.loc && M.music == 0)
			//		world << "Found the song..."
			//		M << S
			//		M.music = 1

			playing = 1
			while(playing == 1)
				for(var/mob/M in world)
					if(M.loc.loc == src.loc.loc && M.music == 0)
						//world << "Found the song..."
						M << S
						M.music = 1
				sleep(10)
			return
	if( href_list["on6"] )
		if(src.playing == 0)
			//world << "Should be working..."
			var/sound/S = sound('TestLoop6.ogg')
			S.repeat = 1
			S.channel = 10
			S.falloff = 2
			S.wait = 1
			S.environment = 0
			//for(var/mob/M in world)
			//	if(M.loc.loc == src.loc.loc && M.music == 0)
			//		world << "Found the song..."
			//		M << S
			//		M.music = 1

			playing = 1
			while(playing == 1)
				for(var/mob/M in world)
					if(M.loc.loc == src.loc.loc && M.music == 0)
						//world << "Found the song..."
						M << S
						M.music = 1
				sleep(10)
			return
	if( href_list["on7"] )
		if(src.playing == 0)
			//world << "Should be working..."
			var/sound/S = sound('TestLoop7.ogg')
			S.repeat = 1
			S.channel = 10
			S.falloff = 2
			S.wait = 1
			S.environment = 0
			//for(var/mob/M in world)
			//	if(M.loc.loc == src.loc.loc && M.music == 0)
			//		world << "Found the song..."
			//		M << S
			//		M.music = 1

			playing = 1
			while(playing == 1)
				for(var/mob/M in world)
					if(M.loc.loc == src.loc.loc && M.music == 0)
						//world << "Found the song..."
						M << S
						M.music = 1
				sleep(10)
			return


	if( href_list["off"] )
		if(src.playing == 1)
			var/sound/S = sound(null)
			S.channel = 10
			S.wait = 1
			for(var/mob/M in world)
				M << S
				M.music = 0
			playing = 0
			for(var/area/RA in A.related)
*/

/mob/var/jukemusic = 0

/area/crew_quarters/bar
	Exited(atom/movable/Obj)
		..()
		if(ismob(Obj))
			if(Obj:client)
				var/mob/M = Obj
				var/sound/S = sound(null)
				S.channel = 10
				S.wait = 0
				M << S
				M.jukemusic = 0

/*
/sound/jukebox/test
	file = 'astley.ogg'
	falloff = 2
	repeat = 1
*/

/obj/machinery/club/jukebox
	name = "Old Jukebox"
	desc = "Vintage music machine adopted for broadcast radio wave"
	icon = 'device.dmi'
	icon_state = "jukebox"
	//icon_state_on = "jukeboxon"
	density = 1
	anchored = 1
	var/playing = 0
	var/sound/current_track
	var/list/tracks = list(loop1=sound('Testloop1.ogg'), loop2=sound('Testloop2.ogg'), loop3=sound('Testloop3.ogg'), loop4=sound('Testloop4.ogg'), loop5=sound('Testloop5.ogg'), loop6=sound('Testloop6.ogg'), loop7=sound('Testloop7.ogg') )

/*
/obj/machinery/club/jukebox/New()
	..()
	sleep(2)
	new /sound/jukebox/test(src)
	return
*/

/obj/machinery/club/jukebox/process()
	set background = 1
	..()
	if(playing)
		var/area/A = get_area(src)
		for(var/mob/living/M in A)
			if((get_area(M) in A.related) && M.jukemusic == 0 && !(M.sdisabilities & M.ear_deaf))
				//world << "DEBUG: Found the song..."
				M << current_track
				M.jukemusic = 1
		sleep(10)

/obj/machinery/club/jukebox/proc/song_refresh() //Refresh current playing song on when it changes
	if(playing)
		var/area/A = get_area(src)
		for(var/mob/living/M in A)
			if((get_area(M) in A.related) && M.jukemusic)
				var/sound/S = sound(null)
				S.channel = 10
				S.wait = 0
				M << S
				spawn(10)
					M << current_track

/obj/machinery/club/jukebox/attack_hand(mob/user as mob)

	var/t = "<B>Turntable Interface</B><br><br>"
	t += "<A href='?src=\ref[src];music_off=1'>Off</A><br><br>"
	t += "<A href='?src=\ref[src];music_on=Testloop1'>Old Jazz Wave</A><br>"
	t += "<A href='?src=\ref[src];music_on=Testloop2'>Zion Cluster Dub</A><br>"
	t += "<A href='?src=\ref[src];music_on=Testloop3'>Transcendence Heritage</A><br>"
	t += "<A href='?src=\ref[src];music_on=Testloop4'>Space Rebels Wave</A><br>"
	t += "<A href='?src=\ref[src];music_on=Testloop5'>Abandoned Straylight Wave</A><br>"
	t += "<A href='?src=\ref[src];music_on=Testloop6'>Retromood Wave</A><br>"
	t += "<A href='?src=\ref[src];music_on=Testloop7'>Sprawl Wave</A><br>"

	user << browse(sanitize(t), "window=turntable;size=420x700")
	onclose(user, "turntable")


/obj/machinery/club/jukebox/Topic(href, href_list)
	..()
	if(href_list["music_off"])
		if(playing)
			var/sound/S = sound(null)
			S.channel = 10
			S.wait = 0
			for(var/mob/living/M in world)
				if(M.jukemusic)
					M << S
					M.jukemusic = 0
			current_track = sound(null)
			playing = 0
			//for(var/area/RA in A.related)  //WTF?
		return
	if(href_list["music_on"])
		var/track = href_list["music_on"]
		//usr << "Playing [track]"
		if(track in tracks)
			current_track = tracks[track]
		else
			usr << "\red No such track!"
			current_track = sound(null)
			return
		current_track.repeat = 1
		current_track.channel = 10
		current_track.falloff = 2
		current_track.wait = 0
		current_track.environment = 0
		if(playing)
			song_refresh()
		playing = 1
	updateUsrDialog()
