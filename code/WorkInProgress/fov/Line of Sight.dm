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
  Please see 'Demo/Demo.dm' for the example usage

  ---------------------------------------------------------------------------
    -      -      -      -      -      -      -      -      -      -      -

*/

#define _LOS_MOVABLE_CENTER_PX(_m_) (0.5*(_m_.bound_width) + _m_.bound_x)
#define _LOS_MOVABLE_CENTER_PY(_m_) (0.5*(_m_.bound_height) + _m_.bound_y)

#define _LOS_ABSOLUTE_TILE(_x_, _px_, _winv_) ((_x_) + (_px_)*(_winv_))

#define _LOS_SQRT_TWO 1.41421356
#define _LOS_FLOAT_TOLERANCE 0.0001

// Coordinate systems:
//
//     Pixels:   Offsets from tile origin. 0-based numbering.
//               (0,0) is bottom-left edge
//               (0.5, 0.5) is center of bottom-left pixel
//               (16,16) is center of a 32x32 tile
//
//     Tiles:    1-based numbering. Centered on bottom-left of tile.
//               (1,1) is bottom-left edge of map
//               (1.5,1.5) is center of bottom-left tile

var/LineOfSight/LOS = new()

LineOfSight

	var/global
		iconSizeWidth
		iconSizeHeight
		iconSizeWidthInv
		iconSizeHeightInv
		tileCenterPX
		tileCenterPY

	New()
		// Determine the world's icon_size (because it can be a number or text)
		if(isnum(world.icon_size))
			iconSizeWidth = world.icon_size
			iconSizeHeight = world.icon_size
		else
			var/index = findtext(world.icon_size, "x")
			iconSizeWidth = text2num(copytext(world.icon_size, 1, index))
			iconSizeHeight = text2num(copytext(world.icon_size, index+1))

		// Unless someone does something really strange, both values should be valid now
		ASSERT(iconSizeWidth && iconSizeHeight)

		// Precalculate tile center
		tileCenterPX = 0.5*iconSizeWidth
		tileCenterPY = 0.5*iconSizeHeight

		// Precalculate division
		iconSizeWidthInv = 1.0 / iconSizeWidth
		iconSizeHeightInv = 1.0 / iconSizeHeight

	proc
		getCenterPixelX(atom/A, includeStep=FALSE)
			if(istype(A,/atom/movable))
				var/atom/movable/M = A
				var/center = _LOS_MOVABLE_CENTER_PX(M)
				if(includeStep) center += M.step_x
				return center
			else return tileCenterPX
		getCenterPixelY(atom/A, includeStep=FALSE)
			if(istype(A,/atom/movable))
				var/atom/movable/M = A
				var/center = _LOS_MOVABLE_CENTER_PY(M)
				if(includeStep) center += M.step_y
				return center
			else return tileCenterPY

		getAbsoluteTileX(atom/A, customCenterX=null)
			if(istype(A,/atom/movable))
				var/atom/movable/M = A
				if(customCenterX == null) customCenterX = _LOS_MOVABLE_CENTER_PX(M)
				return _LOS_ABSOLUTE_TILE(M.x, (customCenterX + M.step_x), iconSizeWidthInv)
			else
				if(customCenterX == null) return A.x + 0.5
				else return A.x + iconSizeWidthInv*customCenterX
		getAbsoluteTileY(atom/A, customCenterY=null)
			if(istype(A,/atom/movable))
				var/atom/movable/M = A
				if(customCenterY == null) customCenterY = _LOS_MOVABLE_CENTER_PY(M)
				return _LOS_ABSOLUTE_TILE(M.y, (customCenterY + M.step_y), iconSizeHeightInv)
			else
				if(customCenterY == null) return A.y + 0.5
				else return A.y + iconSizeHeightInv*customCenterY

		inLineOfSight(atom/source, atom/target, \
		              sourceCenterX=null, sourceCenterY=null, \
		              targetCenterX=null, targetCenterY=null, \
		              parameter="opacity", checkContents=FALSE, \
		              range=null, fov=null, fovX=null, fovY=null, fovCos=null)

			///////////////////////
			// Argument Checking //
			///////////////////////

			// Auto-fail if z's don't match or we weren't passed two atoms
			if(!source || !target || source.z != target.z)
				return FALSE

			// You can pass the precomputed cosine of the FOV or an angle
			if(fovCos == null && fov != null && fov < 180)
				fovCos = cos(fov)

			if(fovCos <= -1.0 + _LOS_FLOAT_TOLERANCE)
				fovCos = null

			//////////////////////////////////////
			// Determining Absolute Coordinates //
			//////////////////////////////////////

			var
				// Determine two absolute tile locations to create a line segment
				absX1;absY1
				absX2;absY2

			// If not specified, default center to bounds center (if movable) or tile center (if turf)
			// Also apply step_x/y if movable atom
			if(istype(source,/atom/movable))
				var/atom/movable/M = source
				if(sourceCenterX == null) sourceCenterX = _LOS_MOVABLE_CENTER_PX(M)
				if(sourceCenterY == null) sourceCenterY = _LOS_MOVABLE_CENTER_PY(M)
				absX1 = _LOS_ABSOLUTE_TILE(M.x, (sourceCenterX + M.step_x), iconSizeWidthInv)
				absY1 = _LOS_ABSOLUTE_TILE(M.y, (sourceCenterY + M.step_y), iconSizeHeightInv)
			else
				if(sourceCenterX == null) absX1 = source.x + 0.5
				else absX1 = _LOS_ABSOLUTE_TILE(source.x, sourceCenterX, iconSizeWidthInv)
				if(sourceCenterY == null) absY1 = source.y + 0.5
				else absY1 = _LOS_ABSOLUTE_TILE(source.y, sourceCenterY, iconSizeHeightInv)

			if(istype(target,/atom/movable))
				var/atom/movable/M = target
				if(targetCenterX == null) targetCenterX = _LOS_MOVABLE_CENTER_PX(M)
				if(targetCenterY == null) targetCenterY = _LOS_MOVABLE_CENTER_PY(M)
				absX2 = _LOS_ABSOLUTE_TILE(M.x, (targetCenterX + M.step_x), iconSizeWidthInv)
				absY2 = _LOS_ABSOLUTE_TILE(M.y, (targetCenterY + M.step_y), iconSizeHeightInv)
			else
				if(targetCenterX == null) absX2 = target.x + 0.5
				else absX2 = _LOS_ABSOLUTE_TILE(target.x, targetCenterX, iconSizeWidthInv)
				if(targetCenterY == null) absY2 = target.y + 0.5
				else absY2 = _LOS_ABSOLUTE_TILE(target.y, targetCenterY, iconSizeHeightInv)

			////////////////////////////////
			// FOV and range restrictions //
			////////////////////////////////

			if(range || fovCos != null)
				var
					dx = (absX2-absX1)*iconSizeWidth
					dy = (absY2-absY1)*iconSizeHeight
					distSqr = dx*dx + dy*dy
					comp
					magSqr

				if(range && (distSqr > range*range))
					return 0

				if(fovCos != null && distSqr)
					if(fovY == null)
						// If fovY isn't set, treat fovX as direction instead of a vector

						// Default to source's direction
						if(!fovX) fovX = source.dir

						// Convert direction to unit vector
						comp = (fovX & (fovX-1)) ? _LOS_SQRT_TWO : 1
						fovY = ((fovX & NORTH) && comp) || ((fovX & SOUTH) && -comp)
						fovX = ((fovX & EAST) && comp) || ((fovX & WEST) && -comp)
						magSqr = 1.0
					else
						// Calculate the FOV vector's magnitude squared
						magSqr = fovX*fovX + fovY*fovY

					// Multiply-in the distance vector's magnitude squared
					magSqr *= distSqr

					// Dot product returns the cosine of the angle between the vectors
					// Instead of normalizing the vectors directly, we multiply the cosine by the combined length.
					// This saves us one call to sqrt(). Thanks to Lummox JR for this trick.
					if((dx*fovX + dy*fovY) <= (fovCos * sqrt(magSqr)) + _LOS_FLOAT_TOLERANCE)
						return 0 // Outside field of view

			//////////////////
			// Line Casting //
			//////////////////

			var
				x1 = round(absX1)
				y1 = round(absY1)

				x2 = round(absX2)
				y2 = round(absY2)

				z = source.z
				turf/T

			// Special case for traveling straight up/down
			if(x1 == x2)
				if(y1 == y2)
					return TRUE // Sight cannot be blocked on same tile
				else
					var/dy = (y2 > y1) ? 1 : -1

					for(y1 += dy, y1 != y2, y1 += dy)
						T = locate(x1, y1, z)
						// Check if turf blocks our view
						if(!T || T.vars[parameter])
							return FALSE
						// Optionally check if contents blocks our view
						if(checkContents)
							for(var/atom/A in T.contents)
								if(A!=target && A!=source && A.vars[parameter])
									return FALSE
			else
				var
					m = (absY2 - absY1)/(absX2 - absX1)
					b = (absY1) - m*(absX1) // In tiles
					signX = (absX2>absX1) ? 1 : -1
					signY = (absY2>absY1) ? 1 : -1
					deltaY

				if(signX==1) b+=m

				while(TRUE)
					// If moving to the next x increases the y coord by 1 or more
					deltaY = m*x1+b-y1
					if(deltaY < -_LOS_FLOAT_TOLERANCE || deltaY >= 1.0)
						y1+=signY //Line exits tile vertically
					else
						x1+=signX //Line exits tile horizontally

					// If we've reached the target tile, it was successful
					if(x1==x2 && y1==y2) break

					// Check if turf blocks our view
					T=locate(x1,y1,z)
					if(!T || T.vars[parameter]) return FALSE
					// Optionally check if contents blocks our view
					if(checkContents)
						for(var/atom/A in T.contents)
							if(A!=target && A!=source && A.vars[parameter])
								return FALSE

			return TRUE