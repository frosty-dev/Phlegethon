#if 0

/* *********************************************************************

 .__    .__                       ____    _______.__       .__     __
 |  |   |__| ___   ____     _____/ ___\  /   ___/|__| ____ |  |___/  |_
 |  |   |  |/   \_/ __ \   /  _ \   _\   \___  \ |  |/ ___\|  |  \   __\
 |  |___|  |  |  \  ___/  (  <_> )  |    /      \|  / /_/  >   Y  \  |
 |_____ \__|__|  /\___  >  \____/|__|   /_____  /|__\___  /|___|  /__|
       \/      \/     \/                      \/   /_____/      \/

                Created by David "DarkCampainger" Braun

            Released under the Unlicense (see _Unlicense.dm)

                   Version 1.3 - September 25, 2012

            Please see 'Demo/Demo.dm' for the example usage

*///////////////////////////////////////////////////////////////////////


## Summary
#######################

"'  This library includes a InLineOfSight() process which allows you to
"'      to determine if two atoms have a clear line of sight between one
"'      another. It works by casting a line between the objects and
"'      searching along it for opaque tiles.
"'
"'  It's important to note that although the start and end points of the
"'      line consider the pixel-based center of each object, the actual
"'      search for opaque objects only considers full tiles.
"'
"'  The library also integrates range and field-of-view limitations to
"'      create more realistic sight lines.
"'

## Reference
#######################

/LineOfSight (/datum)

"'   This is the container type for the library. All global procs and
"'     vars are defined under it. You can access an instance of it via
"'     the global variable [LOS], for example: [LOS.InLineOfSight(...)]
"'
//   Variables:
"'
::      iconSizeWidth (number)
::      iconSizeHeight (number)
"'         The width and height of each tile as parsed from the
"'           world's icon_size variable
"'
//   Procedures:
"'
::      inLineOfSight(atom/source, atom/target, \
::                    sourceCenterX=null, sourceCenterY=null, \
::                    targetCenterX=null, targetCenterY=null, \
::                    parameter="opacity", checkContents=FALSE, \
::                    range=null, fov=null, fovX=null, fovY=null, \
::                    fovCos=null)
"'
"[         source:        atom to calculate sight-line for (required)
"[         target:        atom to test against (required)
"'
"[         sourceCenterX, Manually specify centers of atoms in pixels,
"[         sourceCenterY, as offsets from the bottom-left corner.
"[         targetCenterX, Do NOT include step_x/y in this value.
"[         targetCenterY: Example values for 32x32 icons:
"[                            Bottom-left: (0,0)
"[                            Top-right: (32,32)
"[                            Center: (16,16)
"[
"[                        If not specified, the centers will be
"[                        determined from the bounding boxes.
"'
"[         parameter:     Manually specify variable to test if line of
"[                        sight penetrates a tile. Default is "opacity".
"[                        Must be a variable that all turfs have. If
"[                        'checkContents' is true, must also be a
"[                        variable that all atoms have.
"'
"[         checkContents: Set to true value to also check the contents
"[                        of each turf along the line for atoms that
"[                        may block it. Defaults to false, which means
"[                        only the turfs parameter is checked. Note
"[                        that even if this is true, contents are
"[                        treated as affecting the whole tile and their
"[                        step offsets and bounds are not considered.
"'
"[         range:         Restrict the sight to a max range in pixels.
"'
"[         fov:           Limits the distance that the target can
"[                        be from the source sight vector, as it is
"[                        specified by the fovX and fovY arguments.
"[                        Note that this is half the size of the total
"[                        viewing arc, so to be able to see in 180
"[                        degrees, fov should be set to 90.
"'
"[         fovCos:        As an optimization, you can precompute the
"[                        cosine of the desired FOV and pass it via
"[                        this argument instead of the 'fov' argument.
"'
"[         fovX / fovY:   Specifies the direction of the source atom
"[                        sight vector for FOV. If both fovX and
"[                        fovY are null, it defaults to the source
"[                        dir. If fovX is set and fovY is null, fovX
"[                        is expected to be a directional flag
"[                        (NORTH, SOUTH, ect). If both fovX and fovY
"[                        are set, they are expected to define a
"[                        vector (does not need to be normalized)
"'
"[         Returns:       True if there is a clear line of sight from
"[                        the source to the target. False otherwise.
"'
"'         This process returns whether or not one atom has a clear
"'           line of sight to another, optionally taking into account
"'           the atom's field-of-view and vision range.
"'
::      getCenterPixelX(atom/A, includeStep=FALSE)
::      getCenterPixelY(atom/A, includeStep=FALSE)
"'
"[         A:             The atom to calculate the center of
"'
"[         includeStep:   Whether to include step_x/y in the result
"'
"[         Returns:       The relative pixel offset of the center of
"[                        the atom. For a 32x32 icon_size, the center
"[                        will be (16,16) for a full bounding box.
"'
"'         This utility process determines the relative pixel center
"'           of an atom, taking into account its bounding box.
"'
::      getAbsoluteTileX(atom/A, customCenterX=null)
::      getAbsoluteTileY(atom/A, customCenterY=null)
"'
"[         A:             The atom to calculate the absolute center of
"'
"[         customCenterX, Pass the center of the atom, instead of
"[         customCenterY: calculating it based on the bounding box
"'
"[         Returns:       The relative pixel offset of the center of
"[                        the atom. For a 32x32 icon_size, the center
"[                        will be (16,16) for a full bounding box.
"'
"'         This utility process determines the absolute tile position of
"'           of an atom's center, taking into account its bounding box.
"'

## Version History
#######################

Version 1.3 / September 25, 2012

    Library is now released under the Unlicense
    Library data organized under /LineOfSight parent type
    Added getCenterPixelX/Y() and getAbsoluteTileX/Y() utilities
    InLineOfSight() has been renamed inLineOfSight()
    inLineOfSight() now has fovCos argument
    Fixed bug with fovY argument
    Fixed bug with targetCenterX/Y arguments
    Optimized FOV calculation (Thanks Lummox JR!)
    Shortened and reformatted documentation
    Improved demo

Version 1.2 / September 20, 2012

    Added field of view and range constraints
    Improved accuracy and handling of floating-point error
    Adjusted demo so that the intended usage is more clear

Version 1.1 / August 13, 2012

    Improved handling of opaque source and target tiles

Version 1.0 / August 13, 2012

    Initial Release

#endif