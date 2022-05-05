/*
 .____    .__                        _____    _________.__       .__     __
 |    |   |__| ____   ____     _____/ ____\  /   _____/|__| ____ |  |___/  |_
 |    |   |  |/    \_/ __ \   /  _ \   __\   \_____  \ |  |/ ___\|  |  \   __\
 |    |___|  |   |  \  ___/  (  <_> )  |     /        \|  / /_/  >   Y  \  |
 |_______ \__|___|  /\___  >  \____/|__|    /_______  /|__\___  /|___|  /__|
         \/       \/     \/                         \/   /_____/      \/

  Created by David "DarkCampainger" Braun

  Released under the Unlicense (see _Unlicense.dm)

  Version 1.3 - September 25, 2012

  Please see '_Documentation.dm' for the library reference

  ---------------------------------------------------------------------------
    -      -      -      -      -      -      -      -      -      -      -

*/

/**************************************
//      Demo Grid Configuration      //
//   (Not required to use library)   //
// (Feel free to play with settings) //
**************************************/

#define MARKER_SIZE 8 // MARKER_SIZE must divide evenly into world.icon_size!
#define WORLD_ICON_WIDTH 32 // Keep synced with world/icon_size
#define WORLD_ICON_HEIGHT 32 // Keep synced with world/icon_size

world/icon_size = "32x32" // Keep synced with WORLD_ICON_WIDTH/HEIGHT

/**********************************
//     Demo Implementation       //
**********************************/

mob/Guard
	var
		sightFov = 30          // Half of our full FOV arc
		sightFovCos            // We can precalculate and store the FOV cosine
		sightRange = 96        // How many pixels out we can see
		sightRangeTiles        // We can precalculate how many tiles to search

		sightX=null            // When we spot a player, we want to look right at 'em.
		sightY=null            // We also store the value here so the markers can use it

		mob/Thief/target       // Our target, if we've spotted one
		turf/targetLoc         // The last known location of our target
		lookAround = 0         // Whether a look-around has been triggered

	New()
		// Select a random FOV
		src.sightFov = pick(30;180, 70;rand(25, 90))
		// Precalculate the FOV cosine
		src.sightFovCos = cos(src.sightFov)

		// Select a random sight range
		src.sightRange = rand(84, 196)
		// Precalculate the sight range in tiles
		src.sightRangeTiles = ceiling(src.sightRange / min(WORLD_ICON_WIDTH,WORLD_ICON_HEIGHT))

		// Start the AI loop
		AI()

		// Call the parent type's New()
		..()

	proc
		// Shortcut to test if atom is within our sight
		InSight(atom/A)
			// Test if there's a clear line of sight from us to the target
			// Don't loop through the turf contents for opaque objects
			// Limit our field-of-view to 'sightFov' in the direction 'sightX', 'sightY'
			// Limit our sight range to 'sightRange'
			return LOS.inLineOfSight(src, A, checkContents=FALSE, fov=sightFov, fovX=sightX, fovY=sightY, range=sightRange)

		AI()
			spawn()
				while(src)
					if(!target)
						// If we don't have a target, try to find one
						for(target in range(sightRangeTiles, src)) // First, only include mobs within our tile-based range
							if(src.InSight(target))           // Then do the more-intensive LOS calculation
								break                              // Found one, target is now set!

					if(target)
						// Look directly at the target
						sightX = LOS.getAbsoluteTileX(target) - LOS.getAbsoluteTileX(src)
						sightY = LOS.getAbsoluteTileY(target) - LOS.getAbsoluteTileY(src)
						// If they're still within our sight
						if(src.InSight(target))
							// Chase the target
							step_to(src, target)
							// Update the last known location
							targetLoc = target.loc
						else
							// Lost the target
							target = null

					if(!target)
						// Default back to looking in the direction we're moving
						sightX = null
						sightY = null

						if(targetLoc)
							// Move to the last place you saw the target
							step_to(src, targetLoc)
							// When we get there, set the lookAround count
							if(targetLoc in locs)
								targetLoc = null
								lookAround = 8
						else
							if(lookAround > 0)
								// If we're looking around, turn
								dir = turn(dir, 45)
								lookAround--
								if(!lookAround)
									dir = (dir & 3) || (dir & 12)
							else
								// Otherwise, take a step forward
								if(!step(src,src.dir))
									// Turn if we hit something
									src.dir = turn(src.dir, -90)
					sleep(1)

proc
	// This function updates a bunch of markers on the screen to showcase
	//  how InLineOfSight() divides areas
	UpdateMarkers()
		spawn()

			// Create marker icons
			var/obj/Marker/N = new()
			markerIcons = list()
			for(var/color in list(rgb(210,0,0), rgb(0,0,210), rgb(0,210,0)))
				N.iconColor = color
				markerIcons += GetDemoIcon(N)
			del(N)

			// Update markers each tick
			while(TRUE)
				for(var/obj/Marker/M in world)
					M.level = 0
					for(var/mob/Guard/G in world)
						// Because we're calling this so often, we precalculated the cosine to make it faster
						// We pass this value as 'fovCos' instead of 'fov'
						if(LOS.inLineOfSight(G, M, checkContents=FALSE, fovCos=G.sightFovCos, fovX=G.sightX, fovY=G.sightY, range=G.sightRange))
							// If there's a clear line of sight, we increase the marker's color level
							M.level++

					for(var/mob/Thief/G in world)
						if(G.enableLos && LOS.inLineOfSight(G, M, fov=30, range=128))
							// If there's a clear line of sight, we increase the marker's color level
							M.level++

					// Set icon based on how many guards have sight to this marker
					M.icon = (M.level>0 && M.level<=markerIcons.len) ? markerIcons[M.level] : null

				sleep(1)


/********************
//  Extra demo foo //
********************/

var/list/IconCache
var/list/markerIcons

world
	mob = /mob/Thief
	turf = /turf/Floor
	New()
		UpdateMarkers()
		..()

client/show_popup_menus = 0

atom/var/iconColor = rgb(0,0,0)

turf
	iconColor = rgb(200,200,200)

	New()
		// We draw the demo icons dynamically to support any icon_size
		src.icon = GetDemoIcon(src)

	Floor
		iconColor = rgb(200,200,200)
		density=0
		opacity=0

		New()
			..()
			// Create markers
			for(var/sy = 0 to (WORLD_ICON_HEIGHT-MARKER_SIZE) step MARKER_SIZE)
				for(var/sx = 0 to (WORLD_ICON_WIDTH-MARKER_SIZE) step MARKER_SIZE)
					new/obj/Marker(src, sx, sy)

		Click(l,c,p)
			var/list/params = params2list(p)
			if(params["right"])
				var/mob/M = locate() in src
				if(M && !M.client)
					del(M)
				else
					new /mob/Guard(src)
			else
				new/turf/Wall(src)
			..()

	Wall
		iconColor = rgb(50,50,50)
		density=1
		opacity=1

		New()
			..()
			// Remove markers
			for(var/obj/Marker/M in contents)
				M.loc = null

		Click()
			new/turf/Floor(src)
			..()

obj
	Marker
		mouse_opacity = 0
		var/level = 0

		bound_x = 0
		bound_y = 0
		bound_width = MARKER_SIZE
		bound_height = MARKER_SIZE

		New(L, sx, sy)
			if(sx) step_x = sx
			if(sy) step_y = sy


mob
	iconColor = rgb(0, 0, 0)
	bound_x = 0.25*WORLD_ICON_WIDTH
	bound_y = 0.25*WORLD_ICON_HEIGHT
	bound_width = 0.5*WORLD_ICON_WIDTH
	bound_height = 0.5*WORLD_ICON_HEIGHT

	step_size = 0.125*WORLD_ICON_WIDTH

	sight = SEE_MOBS|SEE_TURFS|SEE_OBJS

	New()
		src.icon = GetDemoIcon(src)
		..()

	Guard
		Click()
			del(src)

	Thief
		iconColor = rgb(250, 200, 0)
		step_size = 0.25*WORLD_ICON_WIDTH

		var/enableLos = FALSE

		Click()
			enableLos = !enableLos

		Login()
			src<<"<hr>Welcome to the demo!\n" \
			   + "<b>Left-click</b> to add/remove walls.\n" \
			   + "<b>Right-click</b> to add/remove mobs.\n" \
			   + "<b>Left-click</b> yourself to toggle line of sight.<hr>"
			..()

proc
	GetDemoIcon(atom/A)
		if(!IconCache)
			IconCache = list()

		var
			x1;y1
			x2;y2

		if(istype(A,/atom/movable))
			var/atom/movable/M = A
			x1 = 1 + M.bound_x
			y1 = 1 + M.bound_y
			x2 = M.bound_x + M.bound_width
			y2 = M.bound_y + M.bound_height
		else
			x1 = 1
			y1 = 1
			x2 = WORLD_ICON_WIDTH
			y2 = WORLD_ICON_HEIGHT

		var/id = "[x1],[y1]:[x2],[y2]:[A.iconColor]"
		var/icon/I = IconCache[id]

		if(!I)
			I = new('LOS_Demo_Icons.dmi')
			I.Crop(1,1, WORLD_ICON_WIDTH,WORLD_ICON_HEIGHT)
			I.DrawBox(A.iconColor, x1, y1, x2, y2)
			IconCache[id] = I

		return I

	ceiling(x)
		return -round(-x)