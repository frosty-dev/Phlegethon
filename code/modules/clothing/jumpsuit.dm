// UNDERS AND BY THAT, NATURALLY I MEAN UNIFORMS/JUMPSUITS

/obj/item/clothing/under
	icon = 'uniforms.dmi'
	name = "under"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	protective_temperature = T0C + 50
	heat_transfer_coefficient = 0.30
	permeability_coefficient = 0.90
	flags = FPRINT | TABLEPASS
	slot_flags = SLOT_ICLOTHING
	var/has_sensor = 1//For the crew computer 2 = unable to change mode
	var/sensor_mode = 0
		/*
		1 = Report living/dead
		2 = Report detailed damages
		3 = Report location
		*/

	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)

// Colors

/obj/item/clothing/under/color/alc
	icon_state = "alc"
	item_state = "alc"
	name = "old tanktop shirt"
	fbyond_color = "alc"

/obj/item/clothing/under/chameleon
//starts off as black
	name = "black jumpsuit"
	icon_state = "black"
	item_state = "bl_suit"
	fbyond_color = "black"
	desc = "It's a plain jumpsuit. It seems to have a small dial on the wrist."
	origin_tech = "syndicate=3"
	var/list/clothing_choices = list()
	armor = list(melee = 10, bullet = 0, laser = 50,energy = 0, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/under/chameleon/psyche
	item_state = "bl_suit"
	name = "groovy jumpsuit"
	desc = "A groovy jumpsuit! It seems to have a small dial on the wrist that won't stop spinning."
	icon_state = "psyche"
	fbyond_color = "psyche"

/obj/item/clothing/under/chameleon/all

/obj/item/clothing/under/color/black
	name = "black jumpsuit"
	icon_state = "black"
	item_state = "bl_suit"
	fbyond_color = "black"

/obj/item/clothing/under/internalsecurity
	name = "internal security jumpsuit"
	icon_state = "internalsecurity"
	item_state = "internalsecurity"
	fbyond_color = "internalsecurity"

/obj/item/clothing/under/internalsecurity2
	name = "internal security jumpsuit"
	icon_state = "secelite2"
	item_state = "secelite2"
	fbyond_color = "internalsecurity"

/obj/item/clothing/under/internalsecurity3
	name = "internal security jumpsuit"
	icon_state = "secelite3"
	item_state = "secelite3"
	fbyond_color = "internalsecurity"

/obj/item/clothing/under/color/blackf
	name = "feminine black jumpsuit"
	desc = "It's very smart and in a ladies size!"
	icon_state = "black"
	item_state = "bl_suit"
	fbyond_color = "blackf"

/obj/item/clothing/under/color/blue
	name = "blue jumpsuit"
	icon_state = "blue"
	item_state = "b_suit"
	fbyond_color = "blue"

/obj/item/clothing/under/color/green
	name = "green jumpsuit"
	icon_state = "green"
	item_state = "g_suit"
	fbyond_color = "green"

/obj/item/clothing/under/color/grey
	name = "grey jumpsuit"
	icon_state = "grey"
	item_state = "gy_suit"
	fbyond_color = "grey"

/obj/item/clothing/under/color/orange
	name = "orange jumpsuit"
	desc = "It's standardised prisoner wear. Its suit sensors are stuck in the \"Fully On\" position."
	icon_state = "orange"
	item_state = "o_suit"
	fbyond_color = "orange"
	has_sensor = 2
	sensor_mode = 3

/obj/item/clothing/under/color/orange/verb/adjust(mode as anything in list("default","sleeveless","shirtless","topless"))
	set name = "Adjust"
	set category = "Object"
	set src in usr
	if(mode == "default")
		src.fbyond_color = initial(fbyond_color)
	else
		src.fbyond_color = "[initial(fbyond_color)]_[mode]"
	usr.update_clothing()

/obj/item/clothing/under/color/pink
	name = "pink jumpsuit"
	icon_state = "pink"
	item_state = "p_suit"
	fbyond_color = "pink"

/obj/item/clothing/under/color/red
	name = "red jumpsuit"
	icon_state = "red"
	item_state = "r_suit"
	fbyond_color = "red"

/obj/item/clothing/under/color/white
	desc = "It's made of a special fiber which gives special protection against biohazards."
	name = "white jumpsuit"
	icon_state = "white"
	item_state = "w_suit"
	fbyond_color = "white"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)

/obj/item/clothing/under/color/yellow
	name = "yellow jumpsuit"
	icon_state = "yellow"
	item_state = "y_suit"
	fbyond_color = "yellow"

// RANKS
/obj/item/clothing/under/rank

/obj/item/clothing/under/rank/atmospheric_technician
	desc = "It's a jumpsuit worn by atmospheric technicians."
	name = "atmospheric technician's jumpsuit"
	icon_state = "atmos"
	item_state = "atmos_suit"
	fbyond_color = "atmos"

/obj/item/clothing/under/rank/captain
	desc = "It's a blue jumpsuit with some gold markings denoting the rank of \"Captain\"."
	name = "captain's jumpsuit"
	icon_state = "captain"
	item_state = "caparmor"
	fbyond_color = "captain"

/obj/item/clothing/under/rank/chaplain
	desc = "It's a black jumpsuit, often worn by religious folk."
	name = "chaplain's jumpsuit"
	icon_state = "chaplain"
	item_state = "bl_suit"
	fbyond_color = "chapblack"

/obj/item/clothing/under/rank/engineer
	desc = "It's an orange high visibility jumpsuit worn by engineers. It has minor radiation shielding."
	name = "engineer's jumpsuit"
	icon_state = "engine"
	item_state = "engi_suit"
	fbyond_color = "engine"
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 10)

/obj/item/clothing/under/rank/forensic_technician
	desc = "It has a forensics rank stripe on it."
	name = "forensic technician's jumpsuit"
	icon_state = "darkred"
	item_state = "r_suit"
	fbyond_color = "forensicsred"

/obj/item/clothing/under/rank/vice
	name = "vice officer's jumpsuit"
	desc = "It's the standard issue pretty-boy outfit, as seen on Holo-Vision."
	icon_state = "vice"
	item_state = "gy_suit"
	fbyond_color = "vice"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/under/rank/security
	name = "red officer's jumpsuit."
	desc = "It's the standard uniform of security from famous virtual game."
	icon_state = "red"
	item_state = "r_suit"
	fbyond_color = "red"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)


/obj/item/clothing/under/rank/geneticist
	desc = "It's made of a special fiber that gives special protection against biohazards. It has a genetics rank stripe on it."
	name = "geneticist's jumpsuit"
	icon_state = "genetics"
	item_state = "w_suit"
	fbyond_color = "geneticswhite"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)

/obj/item/clothing/under/rank/chemist
	desc = "It's made of a special fiber that gives special protection against biohazards. It has a chemist rank stripe on it."
	name = "chemist's jumpsuit"
	icon_state = "chemistry"
	item_state = "w_suit"
	fbyond_color = "chemistrywhite"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)

/obj/item/clothing/under/rank/virologist
	desc = "It's made of a special fiber that gives special protection against biohazards. It has a virologist rank stripe on it."
	name = "virologist's jumpsuit"
	icon_state = "virology"
	item_state = "w_suit"
	fbyond_color = "virologywhite"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)

/obj/item/clothing/under/rank/head_of_personnel
	desc = "It's a jumpsuit worn by someone who works in the position of \"Head of Personnel\"."
	name = "head of personnel's jumpsuit"
	icon_state = "hop"
	item_state = "b_suit"
	fbyond_color = "hop"

/obj/item/clothing/under/rank/centcom_officer
	desc = "It's a jumpsuit worn by CentCom Officers."
	name = "\improper CentCom officer's jumpsuit"
	icon_state = "centcom"
	item_state = "dg_suit"
	fbyond_color = "centcom"

/obj/item/clothing/under/rank/centcom_commander
	desc = "It's a jumpsuit worn by CentCom's highest-tier Commanders."
	name = "\improper CentCom officer's jumpsuit"
	icon_state = "ccofficer"
	item_state = "ccofficer"
	fbyond_color = "officer"

/obj/item/clothing/under/rank/miner
	desc = "It's a snappy jumpsuit with a sturdy set of overalls. It is very dirty."
	name = "shaft miner's jumpsuit"
	icon_state = "miner"
	item_state = "miner"
	fbyond_color = "miner"

/obj/item/clothing/under/rank/roboticist
	desc = "It's a slimming black with reinforced seams; great for industrial work."
	name = "roboticist's jumpsuit"
	icon_state = "robotics"
	item_state = "robotics"
	fbyond_color = "robotics"

/obj/item/clothing/under/rank/chief_engineer
	desc = "It's a high visibility jumpsuit given to those engineers insane enough to achieve the rank of \"Chief Engineer\". It has minor radiation shielding."
	name = "chief engineer's jumpsuit"
	icon_state = "chiefengineer"
	item_state = "g_suit"
	fbyond_color = "chief"
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 10)

/obj/item/clothing/under/rank/research_director
	desc = "It's a jumpsuit worn by those with the know-how to achieve the position of \"Research Director\". Its fabric provides minor protection from biological contaminants."
	name = "research director's jumpsuit"
	icon_state = "director"
	item_state = "g_suit"
	fbyond_color = "director"
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)

/obj/item/clothing/under/rank/janitor
	desc = "It's the official uniform of the station's janitor. It has minor protection from biohazards."
	name = "janitor's jumpsuit"
	icon_state = "janitor"
	fbyond_color = "janitor"
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)

/obj/item/clothing/under/rank/scientist
	desc = "An usual uniform, that represents a man not by it's exterior, but by it's internal markings."
	name = "scientist's formal suit"
	icon_state = "toxins"
	item_state = "toxins"
	fbyond_color = "toxins"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/under/rank/medical
	desc = "It's made of a special fiber that provides minor protection against biohazards. It has a cross on the chest denoting that the wearer is trained medical personnel."
	name = "medical doctor's jumpsuit"
	icon_state = "medical"
	item_state = "w_suit"
	fbyond_color = "medical"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)

//SKRUBS

/obj/item/clothing/under/rank/medical/blue
	name = "medical scrubs"
	desc = "It's made of a special fiber that provides minor protection against biohazards. This one is in baby blue."
	icon_state = "scrubsblue"
	fbyond_color = "scrubsblue"

/obj/item/clothing/under/rank/medical/green
	name = "medical scrubs"
	desc = "It's made of a special fiber that provides minor protection against biohazards. This one is in dark green."
	icon_state = "scrubsgreen"
	fbyond_color = "scrubsgreen"

/obj/item/clothing/under/rank/medical/purple
	name = "medical scrubs"
	desc = "It's made of a special fiber that provides minor protection against biohazards. This one is in deep purple."
	icon_state = "scrubspurple"
	fbyond_color = "scrubspurple"

/obj/item/clothing/under/rank/chief_medical_officer
	desc = "It's a jumpsuit worn by those with the experience to be \"Chief Medical Officer\". It provides minor biological protection."
	name = "chief medical officer's jumpsuit"
	icon_state = "cmo"
	item_state = "w_suit"
	fbyond_color = "cmo"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 2,energy = 2, bomb = 0, bio = 10, rad = 0)

/obj/item/clothing/under/rank/hydroponics
	desc = "It's a jumpsuit designed to protect against minor plant-related hazards."
	name = "botanist's jumpsuit"
	icon_state = "hydroponics"
	item_state = "g_suit"
	fbyond_color = "hydroponics"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)

/obj/item/clothing/under/rank/cargo
	name = "quartermaster's jumpsuit"
	desc = "It's a jumpsuit worn by the quartermaster. It's specially designed to prevent back injuries caused by pushing paper."
	icon_state = "qm"
	item_state = "lb_suit"
	fbyond_color = "qm"

/obj/item/clothing/under/rank/cargotech
	name = "cargo technician's jumpsuit"
	desc = "Shooooorts! They're comfy and easy to wear!"
	icon_state = "cargotech"
	item_state = "lb_suit"
	fbyond_color = "cargo"

/obj/item/clothing/under/rank/mailman
	name = "mailman's jumpsuit"
	desc = "<i>'Special delivery!'</i>"
	icon_state = "mailman"
	item_state = "b_suit"
	fbyond_color = "mailman"

/obj/item/clothing/under/sexyclown
	name = "sexy-clown suit"
	desc = "It makes you look HONKable!"
	icon_state = "sexyclown"
	item_state = "sexyclown"
	fbyond_color = "sexyclown"

/obj/item/clothing/under/rank/bartender
	desc = "It looks like it could use some more flair."
	name = "bartender's uniform"
	icon_state = "ba_suit"
	item_state = "ba_suit"
	fbyond_color = "ba_suit"

/obj/item/clothing/under/rank/clown
	name = "clown suit"
	desc = "<i>'HONK!'</i>"
	icon_state = "clown"
	item_state = "clown"
	fbyond_color = "clown"

/obj/item/clothing/under/rank/chef
	desc = "It's an apron which is given only to the most <b>hardcore</b> chefs in space."
	name = "chef's uniform"
	icon_state = "chef"
	fbyond_color = "chef"

/obj/item/clothing/under/rank/geneticist_new
	desc = "It's made of a special fiber which provides minor protection against biohazards."
	name = "geneticist's jumpsuit"
	icon_state = "genetics_new"
	item_state = "w_suit"
	fbyond_color = "genetics_new"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)

/obj/item/clothing/under/rank/chemist_new
	desc = "It's made of a special fiber which provides minor protection against biohazards."
	name = "chemist's jumpsuit"
	icon_state = "chemist_new"
	item_state = "w_suit"
	fbyond_color = "chemist_new"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)

/obj/item/clothing/under/rank/scientist_new
	desc = "Made of a special fiber that gives special protection against biohazards and small explosions."
	name = "scientist's jumpsuit"
	icon_state = "scientist_new"
	item_state = "w_suit"
	fbyond_color = "scientist_new"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 10, bio = 0, rad = 0)

/obj/item/clothing/under/rank/virologist_new
	desc = "Made of a special fiber that gives increased protection against biohazards."
	name = "virologist's jumpsuit"
	icon_state = "virologist_new"
	item_state = "w_suit"
	fbyond_color = "virologist_new"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)


// OTHER NONRANKED STATION JOBS
/obj/item/clothing/under/det
	name = "hard-worn suit"
	desc = "Someone who wears this means business."
	icon_state = "detective"
	item_state = "det"
	fbyond_color = "detective"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	var/obj/item/weapon/gun

/obj/item/clothing/under/scratch
	name = "white suit"
	desc = "A white suit, suitable for an excellent host"
	flags = FPRINT | TABLEPASS
	icon_state = "scratch"
	item_state = "scratch"
	fbyond_color = "scratch"


/obj/item/clothing/under/jensen
	desc = "You never asked for anything this stylish."
	name = "head of security's jumpsuit"
	icon_state = "jensen"
	item_state = "jensen"
	fbyond_color = "jensen"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/under/sl_suit
	desc = "It's a very amish looking suit."
	name = "amish suit"
	icon_state = "sl_suit"
	fbyond_color = "sl_suit"

/obj/item/clothing/under/syndicate
	name = "tactical turtleneck"
	desc = "It's some non-descript, slightly suspicious looking, civilian clothing."
	icon_state = "syndicate"
	item_state = "bl_suit"
	fbyond_color = "syndicate"
	has_sensor = 0
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/under/syndicate/tacticool
	name = "\improper tacticool turtleneck"
	desc = "Just looking at it makes you want to buy an SKS, go into the woods, and -operate-."
	icon_state = "tactifool"
	item_state = "bl_suit"
	fbyond_color = "tactifool"
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/under/syndicate/combat
	name = "combat turtleneck"

/obj/item/clothing/under/librarian
	name = "sensible suit"
	desc = "It's very... sensible."
	icon_state = "red_suit"
	item_state = "red_suit"
	fbyond_color = "red_suit"

/obj/item/clothing/under/mime
	name = "mime's outfit"
	desc = "It's not very colourful."
	icon_state = "mime"
	item_state = "mime"
	fbyond_color = "mime"

/obj/item/clothing/under/waiter
	name = "waiter's outfit"
	desc = "It's a very smart uniform with a special pocket for tip."
	icon_state = "waiter"
	item_state = "waiter"
	fbyond_color = "waiter"


// Athletic shorts.. heh
/obj/item/clothing/under/shorts
	name = "athletic shorts"
	desc = "95% polyester, 5% spandex!"
	gender = PLURAL
	flags = FPRINT | TABLEPASS
	body_parts_covered = LOWER_TORSO

/obj/item/clothing/under/shorts/red
	icon_state = "redshorts"
	fbyond_color = "redshorts"

/obj/item/clothing/under/shorts/green
	icon_state = "greenshorts"
	fbyond_color = "greenshorts"

/obj/item/clothing/under/shorts/blue
	icon_state = "blueshorts"
	fbyond_color = "blueshorts"

/obj/item/clothing/under/shorts/black
	icon_state = "blackshorts"
	fbyond_color = "blackshorts"

/obj/item/clothing/under/shorts/grey
	icon_state = "greyshorts"
	fbyond_color = "greyshorts"

/obj/item/clothing/under/space
	name = "\improper NASA jumpsuit"
	desc = "It has a NASA logo on it and is made of space-proofed materials."
	icon_state = "black"
	item_state = "bl_suit"
	fbyond_color = "black"
	w_class = 4//bulky item
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.02
	heat_transfer_coefficient = 0.02
	protective_temperature = 1000
	flags = FPRINT | TABLEPASS | SUITSPACE
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS

/obj/item/clothing/under/spiderman
	name = "\improper Deadpool suit"
	desc = "It's the suit of Deadpool!"
	icon_state = "spiderman"
	item_state = "spiderman"
	fbyond_color = "spiderman"

/obj/item/clothing/under/rank/nursesuit
	desc = "It's a jumpsuit commonly worn by nursing staff in the medical department."
	name = "nurse's suit"
	icon_state = "nursesuit"
	item_state = "nursesuit"
	fbyond_color = "nursesuit"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)

/obj/item/clothing/under/acj
	name = "administrative cybernetic jumpsuit"
	icon_state = "syndicate"
	item_state = "bl_suit"
	fbyond_color = "syndicate"
	desc = "it's a cybernetically enhanced jumpsuit used for administrative duties."
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.01
	heat_transfer_coefficient = 0.01
	protective_temperature = 100000
	flags = FPRINT | TABLEPASS | SUITSPACE
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	armor = list(melee = 100, bullet = 100, laser = 100,energy = 100, bomb = 100, bio = 100, rad = 100)

// Cheerleader outfits or something

/obj/item/clothing/under/cheerleader
	name = "cheerleader uniform"
	desc = "Looks breezy."
	icon = 'uniforms.dmi'
	icon_state = "purple_cheer"
	fbyond_color = "purple_cheer"
	flags = FPRINT | TABLEPASS
	body_parts_covered = UPPER_TORSO|LOWER_TORSO

/obj/item/clothing/under/cheerleader/purple
	icon_state = "purple_cheer"
	fbyond_color = "purple_cheer"

/obj/item/clothing/under/cheerleader/yellow
	icon_state = "yellow_cheer"
	fbyond_color = "yellow_cheer"

/obj/item/clothing/under/cheerleader/white
	icon_state = "white_cheer"
	fbyond_color = "white_cheer"

//End of cheerleaders

/obj/item/clothing/under/captainmal
	name = "red captain's jumpsuit"
	desc = "We have done the impossible, and that makes us mighty."
	icon_state = "captainmal"
	item_state = "captainmal"
	fbyond_color = "captainmal"

/obj/item/clothing/under/rank/unit
	desc = "Strong HBT uniform"
	name = "unit uniform"
	icon_state = "unit"
	item_state = "unit"
	fbyond_color = "unit"

/obj/item/clothing/under/rank/unit_d
	desc = "Strong Advanced HBT uniform"
	name = "advanced unit uniform"
	icon_state = "unit_d"
	item_state = "unit_d"
	fbyond_color = "unit_d"
	protective_temperature = 10000
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	armor = list(melee = 10, bullet = 5, laser = 5,energy = 0, bomb = 5, bio = 10, rad = 10)

/obj/item/clothing/under/rank/cso
	desc = "A Navy-blue suit with blue and red insignias."
	name = "chief security officer's jumpsuit"
	icon_state = "cso"
	item_state = "cso"
	fbyond_color = "cso"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/under/rank/officer
	name = "security officer's jumpsuit"
	desc = "A Navy-blue suit with red insignias."
	icon_state = "officer"
	item_state = "officer"
	fbyond_color = "officer"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/under/rank/hos
	desc = "A Navy-blue suit with golden insignias."
	name = "head of security's jumpsuit"
	icon_state = "hos"
	item_state = "hos"
	fbyond_color = "hos"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/under/rank/machina
	desc = "machinist's uniform"
	name = ""
	icon_state = "unit"
	item_state = "unit"
	fbyond_color = "unit"

//phleg

/obj/item/clothing/under/acu
	name = "ACU"
	icon_state = "acu"
	item_state = "gy_suit"
	fbyond_color = "acu"
	desc = "Retro Universal Camo Pattern uniform"
	permeability_coefficient = 0.5
	heat_transfer_coefficient = 0.5
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	armor = list(melee = 10, bullet = 10, laser = 0,energy = 0, bomb = 10, bio = 10, rad = 10)

/obj/item/clothing/under/marw
	name = "ACU Woodland"
	icon_state = "marw"
	item_state = "gy_suit"
	fbyond_color = "marw"
	desc = "Retro MARPAT Woodland camo uniform"
	permeability_coefficient = 0.5
	heat_transfer_coefficient = 0.5
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	armor = list(melee = 10, bullet = 10, laser = 0,energy = 0, bomb = 10, bio = 10, rad = 10)

/obj/item/clothing/under/mard
	name = "ACU Desert"
	icon_state = "mard"
	item_state = "gy_suit"
	fbyond_color = "mard"
	desc = "Retro MARPAT Desert camo uniform"
	permeability_coefficient = 0.5
	heat_transfer_coefficient = 0.5
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	armor = list(melee = 10, bullet = 10, laser = 0,energy = 0, bomb = 10, bio = 10, rad = 10)

/obj/item/clothing/under/tac
	name = "ACU TACOs"
	icon_state = "tac"
	item_state = "gy_suit"
	fbyond_color = "tac"
	desc = "Retro TACOs Desert camo uniform"
	permeability_coefficient = 0.5
	heat_transfer_coefficient = 0.5
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	armor = list(melee = 10, bullet = 10, laser = 0,energy = 0, bomb = 10, bio = 10, rad = 10)

/obj/item/clothing/under/patrol
	name = "patrol uniform"
	icon_state = "patrol"
	item_state = "bl_suit"
	fbyond_color = "patrol"
	desc = "Metropolis patrol uniform. Old fashioned."
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS
	armor = list(melee = 5, bullet = 5, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)

/obj/item/clothing/under/madmax
	name = "Main Force Patrol uniform"
	icon_state = "madmax"
	item_state = "bl_suit"
	fbyond_color = "madmax"
	desc = "Retro and legendary suit of Australian Hero."
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS
	armor = list(melee = 5, bullet = 5, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)