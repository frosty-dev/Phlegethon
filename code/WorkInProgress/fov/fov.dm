//FOV

/proc/GFoV(var/atom/center = usr, range = world.view, keep = 0)
	var/atom/tlist = list()
	var/image/I
	for(var/atom/M in view(range,center))
		if(center.dir==SOUTH)
			if(M.y<=center.y && abs(center.x-M.x) - 1 <= abs(center.y - M.y))
            //	tlist += M
		else if(center.dir==NORTH)
			if(M.y>=center.y && abs(center.x-M.x) - 1 <= abs(center.y - M.y))
				tlist += M
				I = image("icon" = 'icons/mob/screen_full.dmi', "icon_state" = "fovs")
		else if(center.dir==EAST)
			if(M.x>=center.x && abs(center.x-M.x) + 1 >= abs(center.y - M.y))
				tlist += M
		else if(center.dir==WEST)
			if(M.x<=center.x && abs(center.x-M.x) + 1>= abs(center.y - M.y))
				tlist += M
	if(keep)
		tlist += center
	else
		tlist -= center
	return tlist