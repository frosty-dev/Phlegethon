// the power monitoring computer
// for the moment, just report the status of all APCs in the same powernet

//Now Supports remote access -- Newt


/obj/machinery/power/monitor/attack_ai(mob/user)
	add_fingerprint(user)

	if(stat & (BROKEN|NOPOWER))
		return
	interact(user)

/obj/machinery/power/monitor/attack_hand(mob/user)
	add_fingerprint(user)

	if(stat & (BROKEN|NOPOWER))
		return
	interact(user)

/obj/machinery/power/monitor/attackby(I as obj, user as mob)
	if(istype(I, /obj/item/weapon/screwdriver))
		playsound(src.loc, 'sound/items/Screwdriver.ogg', 50, 1)
		if(do_after(user, 20))
			if (src.stat & BROKEN)
				user << "\blue The broken glass falls out."
				var/obj/structure/computerframe/A = new /obj/structure/computerframe( src.loc )
				new /obj/item/weapon/shard( src.loc )
				var/obj/item/weapon/circuitboard/powermonitor/M = new /obj/item/weapon/circuitboard/powermonitor( A )
				for (var/obj/C in src)
					C.loc = src.loc
				A.circuit = M
				A.state = 3
				A.icon_state = "3"
				A.anchored = 1
				del(src)
			else
				user << "\blue You disconnect the monitor."
				var/obj/structure/computerframe/A = new /obj/structure/computerframe( src.loc )
				var/obj/item/weapon/circuitboard/powermonitor/M = new /obj/item/weapon/circuitboard/powermonitor( A )
				for (var/obj/C in src)
					C.loc = src.loc
				A.circuit = M
				A.state = 4
				A.icon_state = "4"
				A.anchored = 1
				del(src)
	if(istype(I, /obj/item/weapon/card/id)||istype(I, /obj/item/device/pda))
		//var/obj/item/weapon/card/id/W = I
		if(src.allowed(user))
			src.control = !src.control
			user << "You [ control ? "enable" : "disable"] remote APC control."
		else
			user << "\red Access denied."


	else
		src.attack_hand(user)
	return

/obj/machinery/power/monitor/proc/interact(mob/user)

	if ( (get_dist(src, user) > 1 ) || (stat & (BROKEN|NOPOWER)) )
		if (!istype(user, /mob/living/silicon))
			user.machine = null
			user << browse(null, "window=powcomp")
			return


	user.machine = src
	var/t = "<TT><B>Power Monitoring: Swipe ID for remote access</B><HR>"

	t += "<BR><HR><A href='?src=\ref[src];update=1'>Refresh</A>"
	t += "<BR><HR><A href='?src=\ref[src];close=1'>Close</A>"

	if(!powernet)
		t += "\red No connection"
	else

		var/list/L = list()
		for(var/obj/machinery/power/terminal/term in powernet.nodes)
			if(istype(term.master, /obj/machinery/power/apc))
				var/obj/machinery/power/apc/A = term.master
				L += A

		t += "<PRE>Total power: [powernet.avail] W<BR>Total load:  [num2text(powernet.viewload,10)] W<BR>"

		t += "<FONT SIZE=-1>"

		if(L.len > 0)

			t += "Area                           Eqp./Lgt./Env.  Load   Cell<HR>"

			var/list/S = list(" Off","AOff","  On", " AOn")
			var/list/chg = list("N","C","F")

			for(var/obj/machinery/power/apc/A in L)

				t += copytext(add_tspace("\The [A.area]", 30), 1, 30)
				if(control)
					t += " (<A href='?src=\ref[src];apc=\ref[A];breaker=1'>[A.operating? " On" : "Off"]</A>)"
				else
					t += " ([A.operating? "On " : "Off"])"
				t += " [S[A.equipment+1]] [S[A.lighting+1]] [S[A.environ+1]] [add_lspace(A.lastused_total, 6)]  [A.cell ? "[add_lspace(round(A.cell.percent()), 3)]% [chg[A.charging+1]]" : "  N/C"]<BR>"

		t += "</FONT></PRE></TT>"

	user << browse(t, "window=powcomp;size=420x900")
	onclose(user, "powcomp")


/obj/machinery/power/monitor/Topic(href, href_list)
	..()
	if( href_list["close"] )
		usr << browse(null, "window=powcomp")
		usr.machine = null
		return
	if( href_list["update"] )
		src.updateDialog()
		return
	if( href_list["breaker"])
		var/obj/machinery/power/apc/APC = locate(href_list["apc"])
		APC.operating = !APC.operating
		APC.update()
		APC.updateicon()
		src.updateDialog()
		return


/obj/machinery/power/monitor/process()
	if(!(stat & (NOPOWER|BROKEN)) )
		use_power(250)

/obj/machinery/power/monitor/power_change()

	if(stat & BROKEN)
		icon_state = "broken"
	else
		if( powered() )
			icon_state = initial(icon_state)
			stat &= ~NOPOWER
		else
			spawn(rand(0, 15))
				src.icon_state = "c_unpowered"
				stat |= NOPOWER
