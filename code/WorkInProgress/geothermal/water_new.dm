#define BREATHING_TICKS 5
#define WAVING_TICKS 3

/datum/controller/liquid
	var
		list
			obj/structure/liquid/water/border   = list()
			obj/structure/liquid/water/inner    = list()
			datum/controller/liquid/connections = list()
		turf/source = null
		level       = 1
		mass        = 0
		total       = 0
		marked      = 0

	New()
		spawn(BREATHING_TICKS) process()

	proc/process()
		if(isemptylist(border) && isemptylist(inner) && !source)
			del(src)
		if(mass > total)
			WaterExpand()
		else if(mass < total)
			WaterDepand()
		UpdateLevel()
		spawn(BREATHING_TICKS) process()


/datum/controller/liquid/proc/NewWater(turf/T)
	if(!T)
		return
	var/obj/structure/liquid/water/W =  new /obj/structure/liquid/water(T)
	W.master = src
	UpdateStatus(W)
//	for(var/d in cardinal)
//		var/turf/TT = get_step(T,d)
//		var/obj/structure/liquid/water/WT = T.getWater()
//		if(WT)
//			UpdateStatus(WT)
	total++
	return


/datum/controller/liquid/proc/DelWater(var/obj/structure/liquid/water/W)
	if(!W)
		return
	UpdateStatusDel(W)
	W.master = null
	del(W)
	total--
	return


/datum/controller/liquid/proc/NewConnect(var/datum/controller/liquid/LC)
	if(!LC)
		return
	if(!(LC in connections))
		connections += LC
	if(!(src in LC.connections))
		LC.connections += src

/datum/controller/liquid/proc/DelConnect(var/datum/controller/liquid/LC)
	if(!LC)
		return
	if(LC in connections)
		connections -= LC
	if(src in LC.connections)
		LC.connections -= src

/datum/controller/liquid/proc/WaterExpand()
	var/list/obj/structure/liquid/water/WL = border
	var/list/turf/T = list()
	for(var/obj/structure/liquid/water/W in WL)
		T |= W.getAvailible()
	var/delta = mass - total
	while(delta >= 1)
		if(isemptylist(T))
			while(delta >= 1)
				if(isemptylist(connections))
					break
				var/datum/controller/liquid/LC = pick(connections)
				if(!isemptylist(LC.border))
					LC.mass++
					mass--
				delta--
			break
		delta--
		var/turf/K = pick(T)
		T -= K
		NewWater(K)
	return

/datum/controller/liquid/proc/WaterDepand()
	var/list/obj/structure/liquid/water/WL = border
	var/list/obj/structure/liquid/water/WDL = list()
	var/delta = min(total - mass,WL.len)
	var/check = 0
	for(var/i = 0, i <= 3, i++)
		if(check)
			break
		for(var/obj/structure/liquid/water/W in WL)
			if(W.getConnNumber() == i && !W.isSource())
				WL -= W
				WDL += W
				delta--
				if(delta <= 0)
					check = 1
					break
	for(var/obj/structure/liquid/water/W in WDL)
		DelWater(W)
	for(var/datum/controller/liquid/LC in connections)
		if(!FindWayTo(LC))
			DelConnect(LC)
	return


/datum/controller/liquid/proc/UpdateStatus(var/obj/structure/liquid/water/W)
	if(!W)
		return
	if(W.CheckObstacleAround())
//		W.master.inner |= W
//		W.master.border &= ~W
		if(!(W in W.master.inner))
			W.master.inner += W
		if(W in W.master.border)
			W.master.border -= W
	else
//		W.master.inner &= ~W
//		W.master.border |= W
		if(W in W.master.inner)
			W.master.inner -= W
		if(!(W in W.master.border))
			W.master.border += W

	for(var/d in cardinal)
		var/turf/T = get_step(W,d)
		var/obj/structure/liquid/water/WT = T.getWater()
		if(WT)
			if(WT.CheckObstacleAround())
				if(!(WT in WT.master.inner))
					WT.master.inner += WT
				if(WT in WT.master.border)
					WT.master.border -= WT
			else
				if(WT in WT.master.inner)
					WT.master.inner -= WT
				if(!(WT in WT.master.border))
					WT.master.border += WT
			if(WT.master != src)
				var/turf/TC = W.loc
				if(!TC.getDoor(T) && !T.getDoor(TC))
					NewConnect(WT.master)
				//Merge(WT.master)
	return


/datum/controller/liquid/proc/UpdateStatusDel(var/obj/structure/liquid/water/W)
	if(W in W.master.inner)
		W.master.inner -= W
	if(W in W.master.border)
		W.master.border -= W
	for(var/d in cardinal)
		var/turf/T = get_step(W,d)
		var/obj/structure/liquid/water/WT = T.getWater()
		if(WT)
			if(WT in WT.master.inner)
				WT.master.inner -= WT
			if(!(WT in WT.master.border))
				WT.master.border += WT
		return

/datum/controller/liquid/proc/UpdateLevel()
	if(total == 0 || mass == 0)
		return
	var/K = round(mass/total,1)
	var/obj/structure/liquid/water/WT
	if(source)
		WT = source.getWater()
	else if(!isemptylist(inner))
		WT = pick(inner)
	else if(!isemptylist(border))
		WT = pick(border)
	else
		return
	if(level < K - 0.5)
		level++
	else if(level > K + 0.5)
		level--
	else
		return
	UpdateLevelFlood(WT)
	return


/datum/controller/liquid/proc/UpdateLevelFlood(var/obj/structure/liquid/water/W,var/list/obj/structure/liquid/water/checked = list())
	if(!W)
		return checked
	checked |= W
	var/templevel = level //% 2
	W.layer = round(level/3, 0.1) + 2.1
	W.icon_state = "water[templevel]"
	if(templevel > 10)
		W.icon_state = "water10"
	W.level = templevel
	spawn(WAVING_TICKS)
		for(var/d in cardinal)
			var/turf/T = get_step(W,d)
			var/obj/structure/liquid/water/WT = T.getWater()
			if(WT && !(WT in checked))
				UpdateLevelFlood(WT,checked)
	return checked


/datum/controller/liquid/proc/FindWayTo(var/datum/controller/liquid/LC)
	if(!LC)
		return
	if(!LC.source)
		return
	if(!source)
		return
	var/turf/target  = LC.source
	var/turf/current = source
	var/list/turf/check = FloodCheck(current)
	if(target in check)
		return 1
	return 0

/datum/controller/liquid/proc/FloodCheck(var/turf/TC,var/list/turf/checked = list())
	if(!TC)
		return checked
	checked |= TC
	for(var/d in cardinal)
		var/turf/T = get_step(TC,d)
		if(T.getWater() && !(T in checked) && !TC.getDoor(T) && !T.getDoor(TC))
			FloodCheck(T,checked)
	return checked


/datum/controller/liquid/proc/Merge(var/datum/controller/liquid/LC)
	if(!LC)
		return
	if(LC.source && source)
		return
	var/datum/controller/liquid/choose    = null
	var/datum/controller/liquid/notchoose = null
	if(LC.source)
		choose = LC
		notchoose = src
	else
		choose = src
		notchoose = LC
	if(!choose)
		return
	var/list/obj/structure/liquid/water/WL = border + inner + LC.border + LC.inner
	for(var/obj/structure/liquid/water/W in WL)
		W.master = choose
	for(var/obj/structure/liquid/water/W in WL)
		UpdateStatus(W)
	choose.total += notchoose.total
	choose.mass  += notchoose.mass
	del(notchoose)
	return

/datum/controller/liquid/proc/Split(var/obj/structure/liquid/water/W)
	if(!W)
		return
//	world << "Split:"
	var/list/turf/TL = FloodCheck(source)
//	var/arch_mass = mass
//	var/arch_total = total
	var/list/datum/controller/liquid/LCL = list()
	var/list/obj/structure/liquid/water/lastcheck = list()
	for(var/d in cardinal)
//		world << "Direction: [d]"
		var/turf/T = get_step(W,d)
		var/obj/structure/liquid/water/WT = T.getWater()
		if(!(T in TL) && WT && !(WT.master in LCL))
			var/datum/controller/liquid/LC = new/datum/controller/liquid
			LC.source = T
			lastcheck += WT
			var/list/turf/TLtemp = FloodCheck(T)
//			arch_total -= TLtemp.len
//			arch_mass -= TLtemp.len * level
			LC.total = TLtemp.len
			LC.mass = TLtemp.len * level
			total -= TLtemp.len
			mass -= TLtemp.len * level
			var/list/obj/structure/liquid/water/WL = list()
			for(var/turf/TW in TLtemp)
				var/obj/structure/liquid/water/WTR = TW.getWater()
				WL |= WTR
				if(WTR in inner)
					inner -= WTR
				if(WTR in border)
					border -= WTR
			for(var/obj/structure/liquid/water/WTR in WL)
				WTR.master = LC
			for(var/obj/structure/liquid/water/WTR in WL)
				UpdateStatus(WTR)

//			world << "WL len:[WL.len]. TLtemp len:[TLtemp.len]."
			LCL += LC
	DelWater(W)
	for(var/datum/controller/liquid/LC in LCL)
		DelConnect(LC)
	for(var/obj/structure/liquid/water/WTR in lastcheck)
		UpdateStatus(WTR)
//	for(var/datum/controller/liquid/LC in LCL)
//		for(var/obj/structure/liquid/water/WT in LC.border)
//			border &= ~WT
//			inner &= ~WT
//		for(var/obj/structure/liquid/water/WT in LC.inner)
//			border &= ~WT
//			inner &= ~WT

/datum/controller/liquid/proc/SetInput(var/input)
	return

/datum/controller/liquid/proc/SetSource(var/turf/T)
	if(source)
		//Split()
		return
	if(T.issource)
		//Split()?
		return
	source = T
	T.issource = 1


/obj/structure/liquid/water
	name = "Water"
	desc = "Just water. More when need."
	icon = 'thermal.dmi'
	icon_state = "water1"
	var/datum/controller/liquid/master = null
	mouse_opacity = 0
	level = 0

	New()
		spawn(2)
			if(!master)
				var/datum/controller/liquid/LC = new/datum/controller/liquid
				master = LC
				LC.UpdateStatus(src)
				LC.SetSource(src.loc)
				LC.mass++
				LC.total++

	Del()
		if(master)
			master.DelWater(src)
			return
		..()

//2 -tables (2,8)
//5 - no mob (3,8)
//6 - mob (layer4,1)
/
/obj/structure/liquid/water/HasEntered(atom/movable/AM as mob|obj)
	var/mob/living/carbon/human/H = AM
	if(H in get_turf(src))
		switch(level)
			if(3)
				H.m_intent = "walk"

			if(4)
				H.m_intent = "walk"

			if(5)
				H.m_intent = "walk"
		if(level >= 6)
			if(H.internal != null && H.wear_mask && (H.wear_mask.flags & MASKINTERNALS))
				H.holdbreath = 0
				return
			else
				H.m_intent = "walk"
				H.holdbreath = 1
		if(level < 6)
			H.m_intent = "walk"
			H.holdbreath = 0

/obj/structure/liquid/water/proc/CheckObstacleAround()
	var/i
	var/turf/place = src.loc
	for(var/d in cardinal)
		var/turf/T = get_step(src.loc,d)
		if(istype(T,/turf/simulated/wall))
			i++
			continue
		if(!T.getWater())
			if(!T.ZCanPass(place))
				if(place.getDoor(T) || T.getDoor(place))
					return 0
				else
					i++
		else
			if(!place.getDoor(T) && !T.getDoor(place))
				i++
	if(i == 4)
		return 1
	return 0


/obj/structure/liquid/water/proc/CheckWallAround()
	var/i
	for(var/d in cardinal)
		var/turf/T = get_step(src.loc,d)
		if(istype(T,/turf/simulated/wall))
			i++
	return i


/obj/structure/liquid/water/proc/getAvailible()
	var/list/turf/TL = list()
	for(var/d in cardinal)
		var/turf/T = get_step(src,d)
		var/obj/structure/liquid/water/W = T.getWater()
		if(!W && istype(T,/turf/simulated/floor))
			var/turf/L = src.loc
			if(L.ZCanPass(T) && (!L.getDoor(T) && !T.getDoor(T)))
				TL += T
	return TL


/obj/structure/liquid/water/proc/getConnNumber()
	var/i
	for(var/d in cardinal)
		var/turf/T = get_step(src,d)
		if(T.getWater())
			i++
	return i


/obj/structure/liquid/water/proc/isSource()
	if(istype(src.loc,/turf))
		var/turf/T = src.loc
		if(T.issource)
			return 1
	return 0


/turf/proc/getWater()
	var/obj/structure/liquid/water/M = null
	M = locate(/obj/structure/liquid/water) in src
	return M


/turf/proc/CreateSource()
	var/obj/structure/liquid/water/W = getWater()
	if(W)
		W.master.border &= ~src
		W.master.inner  &= ~src
		var/datum/controller/liquid/LC = new/datum/controller/liquid
		W.master = LC
		LC.UpdateStatus(W)
		if(!LC.source)
			LC.source = src
		LC.mass++
		LC.total++
	else
		new/obj/structure/liquid/water(src)
	return


/turf/proc/SplitWater()
	var/obj/structure/liquid/water/W = getWater()
	if(W)
		if(W.master)
			W.master.Split(W)
		else
			del(W)
	return


/turf/proc/giveMass(var/amount)
	var/obj/structure/liquid/water/W = getWater()
	if(W && W.master)
		W.master.mass += amount
	else
		world << "Error. State: source without master or source without water in [x],[y]."


/turf/proc/getDoor(var/turf/T)
	for(var/obj/machinery/door/D in src)
		if(D.density)
			if(istype(D,/obj/machinery/door/window))
				if(!T)
					continue
				if(D.dir != get_dir(D,T))
					continue
			return 1
	return 0


/turf
	var/issource = null


////////DEBUG
/*
	verb
		give_mass()
			set name = "Give Mass"
			set src in view()
			set hidden = 0
			var/amount = input("How many water you needs?","Amount") as num
			if(amount)
				giveMass(amount)

		create_source()
			set name = "Create Source"
			set src in view()
			set hidden = 0
			CreateSource()
*/

/*
/obj/structure/liquid/water
	verb
		split()
			set name = "Split"
			set src in view()
			set hidden = 0
			if(!master)
				return
			master.Split(src)

		flood_check()
			set name = "Flood Check"
			set src in view()
			set hidden = 0
			var/list/turf/T = master.FloodCheck(master.source)
			if(!isemptylist(T))
				world << "FloodCheck: [T.len]"
			else
				world << "FloodCheck: null"
			return

		mark_this()
			set name = "Mark Master"
			set src in view()
			set hidden = 0
			if(!master)
				return
			var/list/obj/structure/liquid/water/WL = list()
			WL += master.border
			WL += master.inner
			for(var/obj/structure/liquid/water/W in WL)
				if(!master.marked)
					W.icon_state = "magma_1"
				else
					W.icon_state = "water[level%2]"
			master.marked = !master.marked
			return
*/

