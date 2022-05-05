#define MERGE_DEL  1
#define FULL_DEL   2

#define IS_LINE     1
#define IS_TRIANGLE 2

#define SIMPLE 5
#define BORDER 6
#define SPLIT  7

#define BREATHING_TICKS 3

var/global/liquid_controllers_number = 0

/datum/controller/liquid
	///MAIN
	var/list/obj/structure/liquid/water/inner      = list()
	var/list/obj/structure/liquid/water/border     = list()
	var/list/turf/simulated/floor/availible        = list()
	var/list/turf/simulated/floor/source           = list()
	///UPDATE
	var/list/turf/simulated/floor/new_availible    = list()
	var/list/turf/simulated/floor/new_border       = list()
	///ARCHIVE
	var/list/obj/structure/liquid/water/border_del = list()
	var/list/obj/structure/liquid/water/inner_del  = list()
	var/list/obj/structure/liquid/water/checked    = list()
	var/total       = 0
	var/mass        = 1
	var/id          = null
	var/iteration   = 1
	var/mass_adding = 0
	var/deleting    = 0
	var/debug       = 1
	New()
		liquid_controllers_number++
		id = liquid_controllers_number
		world << "New liquid contorller initialized. Id: [id]."
		spawn(10) process()

	Del()
		world << "Del liquid controller. Id: [id]."
		..()

	proc/process()
		if(deleting)
			if(deleting == FULL_DEL)
				for(var/i in inner)
					del(i)
				for(var/i in border)
					del(i)
			del(src)
			return
		if(!isemptylist(new_availible))
			availible += new_availible
			new_availible = list()
		if(!isemptylist(new_border))
			border += new_border
			new_border = list()
		else if (isemptylist(availible) && isemptylist(border) && isemptylist(inner))
			del(src)
		iteration++
		if(mass_adding)
			mass++
		if(mass > total)
			while(mass > total && !isemptylist(availible))
				NewWater()
		else if(mass < total)
			DelWaterBorder()

		spawn(BREATHING_TICKS) process()


/datum/controller/liquid/proc/NewWater()
	if(isemptylist(availible))
		return
	if(mass <= total)
		return
	var/turf/simulated/floor/F = pick(availible)
	if(F.getWater())
		availible -= F
		NewWater()
	var/obj/structure/liquid/water/W = new /obj/structure/liquid/water(F)
	availible -= F
	AddWater(W)
	return


/datum/controller/liquid/proc/AddWater(obj/structure/liquid/water/W as obj)
	if(!W)
		return
	UpdateStatus(W)
	total++


/datum/controller/liquid/proc/DelWater(obj/structure/liquid/water/W as obj)
	var/list/arch = list()
	for(var/d in cardinal)
		var/turf/T = get_step(W,d)
		var/obj/structure/liquid/water/WT = T.getWater()
		if(WT)
			arch += WT

	RemoveAvailible(W)
	W.deleting = BORDER
	del(W)
	total--

	if(isemptylist(inner) && isemptylist(border))
		deleting = FULL_DEL
		return

	for(var/obj/structure/liquid/water/d in arch)
		UpdateStatus(d)

	return


/datum/controller/liquid/proc/DelWaterBorder()
	if(isemptylist(border))
		if(!isemptylist(inner))
			DelWaterInner()
		else
			deleting = FULL_DEL
		return
	var/delta = min(total - mass, border.len)
	if(delta <= 0)
		world << "Crit Failure delta"
		return
	var/list/obj/structure/liquid/water/priority_del = list()
	var/list/obj/structure/liquid/water/border_del2 = border
	for(var/obj/structure/liquid/water/W in border)
		if(isDeadEnd(W))
			priority_del += W

	while(delta >= 1)
		var/obj/structure/liquid/water/W
		if(!isemptylist(priority_del))
			W = pick(priority_del)
			priority_del -= W
		else if(!isemptylist(border_del2))
			W = pick(border_del2)
			border_del2 -= W
		else
			break
		delta--
		if(!W)
			continue
		if(isOneway(W) == IS_LINE)
			continue
		if(CheckSource(W))
			continue
		if(!(W in border_del))
			border_del += W

	if(isemptylist(border_del))

		while(delta >= 1)
			var/obj/structure/liquid/water/W
			if(!isemptylist(priority_del))
				W = pick(priority_del)
				priority_del -= W
			else if(!isemptylist(border_del2))
				W = pick(border_del2)
				border_del2 -= W
			else
				break
			delta--
			if(!W)
				continue
			if(isOneway(W) == IS_LINE)
				continue
			if(!(W in border_del))
				border_del += W

	if(isemptylist(border_del))
		DelWaterInner()
		return
	for(var/obj/structure/liquid/water/W in border_del)
		DelWater(W)
		border -= W

	border_del = list()
	return

/datum/controller/liquid/proc/DelWaterInner()
	if(isemptylist(inner))
		return
	var/delta = min(total - mass, inner.len)
	if(delta <= 0)
		world << "Crit Failure delta"
		return

	while(delta >= 1)
		var/obj/structure/liquid/water/W = pick(inner)
		delta--
		if(!W.CheckWallAround())
			continue
		if(CheckSource(W))
			continue
		if(!(W in inner_del))
			inner_del += W

	for(var/obj/structure/liquid/water/W in inner_del)
		DelWater(W)
		inner -= W

	inner_del = list()
	return

/datum/controller/liquid/proc/UpdateStatus(obj/structure/liquid/water/W as obj, var/flood = 0, var/isnew = 0)
	if(W.CheckObstacleAround())
		if(!(W in inner))
			inner += W
		if(W in border)
			border -= W
//		if(W in new_border)
//			new_border -= W
	else
		if(!(W in border) && !(W in new_border))
			new_border += W
		if(W in inner)
			inner -= W

	if(flood)
		checked += W

	for(var/d in cardinal)
		var/turf/T = get_step(W,d)
		var/obj/structure/liquid/water/WT = T.getWater()
		if(WT)
			if(flood)
				if(!(WT in checked))
					UpdateStatus(WT,flood,isnew)
			else if(WT.CheckObstacleAround() && !(WT in border_del))
				if((WT in border))
					border -= WT
				if((WT in new_border))
					new_border -= WT
				if(!(WT in inner))
					inner  += WT
				AddAvailible(WT)


	W.master = src
	if(!flood)
		AddAvailible(W)
	if(isnew)
		total++
		mass++


/datum/controller/liquid/proc/UpdateStatusFlood(obj/structure/liquid/water/W as obj, var/isnew = 0)
	UpdateStatus(W,1,isnew)
	W.master = src
	checked = list()

/datum/controller/liquid/proc/AddAvailible(obj/structure/liquid/water/W as obj, var/flood = 0)
	for(var/d in cardinal)
		var/turf/T = get_step(W,d)
		if(istype(T,/turf/simulated/floor))
			if(!T.getWater())
				if(!(T in availible) && !(T in new_availible))
					new_availible += T
			else if(!flood)
				var/obj/structure/liquid/water/WT = locate(/obj/structure/liquid/water) in T
				if(WT.master && WT.master != src)
					if(WT.CheckObstacleAround())
						SoftMerge(WT)
					else
						Merge(WT)
					break

/datum/controller/liquid/proc/RemoveAvailible(obj/structure/liquid/water/W as obj)
	var/i
	for(var/d in cardinal)
		i = 0
		var/turf/vector = get_step(W,d)
		for(var/t in cardinal)
			var/turf/T = get_step(vector,t)
			var/obj/structure/liquid/water/WT = T.getWater()
			if(WT)
				if(WT == src || WT in border_del)
					continue
				i++
		if(i == 0)
			availible -= vector

	return


/datum/controller/liquid/proc/RemoveAvailibleFull(obj/structure/liquid/water/W as obj)
	for(var/d in cardinal)
		var/turf/T = get_step(W,d)
		if(T in availible)
			availible -= T
	return
/*
/datum/controller/liquid/proc/AddInner(obj/structure/liquid/water/W as obj)
	if(W.CheckObstacleAround())
		if(src in border)
			border -= src
		if(!(src in inner))
			inner += src
	return
*/
/datum/controller/liquid/proc/isDeadEnd(obj/structure/liquid/water/W)
	var/i = 0
	for(var/d in cardinal)
		var/turf/T = get_step(W,d)
		if(T.getWater())
			i++
	if(i == 1)
		return 1
	return 0


/datum/controller/liquid/proc/isOneway(obj/structure/liquid/water/W)
	var/i = 0
	for(var/d in cardinal)
		var/turf/T = get_step(W,d)
		if(T.getWater())
			i |= d
	if(i == 1 || i == 2|| i == 4 || i == 8)
		return 0
	if(i == 3 || i == 12 )
		return IS_LINE
	var/turf/T = get_step(W,i)
	if(T.getWater())
		return IS_TRIANGLE
	return 0


/datum/controller/liquid/proc/isConnected(obj/structure/liquid/water/Wo,obj/structure/liquid/water/Wt)
	//world << "IsConnected Check Start -----------------------------------"
	if(Wo == Wt)
		//world << "Wo == Wt"
		return 0
	var/delta_x = abs(Wo.x - Wt.x)
	var/delta_y = abs(Wo.y - Wt.y)
	if((delta_x == 1 && delta_y == 0) || (delta_x == 0 && delta_y == 1))
		//world << "+Connected"
		return 1
	//world << "-NotConnected"
	return 0


/datum/controller/liquid/proc/CheckSource(obj/structure/liquid/water/W)
	for(var/d in cardinal)
		var/turf/T = get_step(W,d)
		var/obj/structure/liquid/water/WT = T.getWater()
		if(WT)
			if(WT in source)
				return 1
	return 0


/datum/controller/liquid/proc/getFullTiles(obj/structure/liquid/water/W)
	var/list/turf/i = list()
	for(var/d in alldirs)
		var/turf/T = get_step(W,d)
		if(T.getWater())
			i += T
	return i


/datum/controller/liquid/proc/Initialize(obj/structure/liquid/water/W as obj)
	if(!W)
		del(src)
	AddWater(W)
	source += W
	return


/datum/controller/liquid/proc/Merge(obj/structure/liquid/water/W)
	if(!W)
		world << "No W"
		return
	if(W.master == src)
		world << "W == src in [W.x],[W.y]."
		return
	world << "Merge in [W.x],[W.y]."
	var/datum/controller/liquid/L = W.master
	inner     = list()
	border    = list()
	availible = list()
	UpdateStatusFlood(W)
	total += L.total
	mass  += L.mass
	L.deleting = MERGE_DEL
	for(var/obj/structure/liquid/water/WT in new_border)
		AddAvailible(WT)


/datum/controller/liquid/proc/SoftMerge(obj/structure/liquid/water/W)
	if(!W)
		world << "No W"
		return
	if(W.master == src)
		world << "W == src in [W.x],[W.y]."
		return
	world << "SoftMerge in [W.x],[W.y]."
	var/datum/controller/liquid/L = W.master
	for(var/obj/structure/liquid/water/WT in inner)
		WT.master = src
	inner     += L.inner
	for(var/obj/structure/liquid/water/WT in border)
		WT.master = src
	border    += L.border
	availible += L.availible
	L.deleting = MERGE_DEL
	UpdateStatus(W)

/datum/controller/liquid/proc/Split(obj/structure/liquid/water/W)
	if(!W)
		world << "Can't find Water"
		return
	world << "Split"
	var/list/k = getFullTiles(W)
	var/l = k.len
	world << "Len: [l]"
	if(l <= 1)
		return
	l *= 2
	world << "Len*2: [l]"
	for(var/turf/To in k)
		for(var/turf/Tt in k)
			if(isConnected(To,Tt))
				l--
	world << "Len after check: [l]"
	l = round(l/2,1)
	if(l <= 1)
		return
	var/list/obj/structure/liquid/water/water_around = list()
	for(var/d in alldirs)
		var/turf/T = get_step(W,d)
		var/obj/structure/liquid/water/WT = T.getWater()
		if(WT)
			water_around += WT
	world << "Water Around len: [water_around.len]"
	W.deleting = SIMPLE
	world << "Del water"
	del(W)
	world << "Complete"
	var/arch_total = total - 1
	world << "Arch Total: [arch_total]"
	var/arch_mass  = mass  - 1
	world << "Arch Mass: [arch_mass]"
	var/list/datum/controller/liquid/L
	for(var/obj/structure/liquid/water/WT in water_around)
		if(!(WT.master in L))
			var/datum/controller/liquid/C = new /datum/controller/liquid
			C.Initialize(WT)
			C.UpdateStatusFlood(WT,1)
			L += C
	world <<"L len: [L.len]"
	if(L.len <= 1)
		L.total = arch_total
		L.mass  = arch_mass
	else
		l = L.len
		for(var/datum/controller/liquid/LC in L)
			arch_total -= LC.total
			arch_mass -= LC.mass
		for(var/datum/controller/liquid/LC in L)
			var/arch = round(arch_total/l, 1)
			LC.total += arch
			arch_total -= arch

			arch = round(arch_mass/l, 1)
			LC.total += arch
			arch_mass -= arch
			l--
	return


/obj/structure/liquid/water
	name = "Water"
	desc = "Just water. More when need."
	icon = 'thermal.dmi'
	icon_state = "water"
	var/deleting = SPLIT
	var/datum/controller/liquid/master = null

	New()
		var/turf/place = src.loc
		if(!istype(place,/turf/simulated/floor))
			del(src)
		spawn(2)
			if(!master)
				var/datum/controller/liquid/LC = new /datum/controller/liquid
				LC.Initialize(src)
		..()

	Del()
		if(master)
			if(isemptylist(master.border) && isemptylist(master.inner))
				master.deleting = 1
				del(master)
			if(deleting == SPLIT)
				master.Split(src)
				return
		..()


/obj/structure/liquid/water/proc/CheckObstacleAround()
	var/i
	for(var/d in cardinal)
		var/turf/T = get_step(src.loc,d)
		if(T.getWater() || istype(T,/turf/simulated/wall))
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


/turf/proc/getWater()
	var/obj/structure/liquid/water/M = null
	M = locate(/obj/structure/liquid/water) in src
	return M