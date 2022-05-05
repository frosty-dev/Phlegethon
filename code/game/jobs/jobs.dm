var/const


	TH =(1<<0)

	OVERSEER		=(1<<1)
	RD				=(1<<2)
	CHIEF			=(1<<3)
	CHEF			=(1<<4)
	CONVICT			=(1<<5)



var/list/assistant_occupations = list(
	"Convict"
)


var/list/command_positions = list(
//	"Shift Supervisor",
	"Overseer",
//	"Head of Security",
	"Chief Engineer",
	"Research Director",
//	"Chief Medical Officer",
//	"Head of Nutrition",
//	"Chief Psychiatrist"
	"Chef"

)


var/list/engineering_positions = list(
	//"Chief Engineer",
//	"Engineer",
//	"Atmospheric Technician",
//	"Machinist",
//	"Cargo Unit",
//	"Unit",
//	"Roboticist"
)


var/list/medical_positions = list(
	//"Chief Medical Officer",
	//"Chief Psychiatrist",
//	"Psychiatrist",
//	"Medical Doctor",
//	"Geneticist"
)


var/list/science_positions = list(
	//"Research Director",
//	"Scientist",
//	"Chemist"
)


var/list/civilian_positions = list(
	//"Transhumanist overseer",
//	"Detective",
//	"Bartender",
//	"Botanist",
//	"Chef",
//	"Medical janitor",
	"Convict"
)


var/list/security_positions = list(
	//"Head of Security",
//	"Chief Security Officer",
	//"Detective",
//	"Security Officer"
)


var/list/nonhuman_positions = list(
	//"AI",
//	"Cyborg",
//	"pAI"
)



/proc/guest_jobbans(var/job)
	return ((job in command_positions) || (job in nonhuman_positions) || (job in security_positions))

/proc/GetRank(var/job)
	switch(job)
		if("Convict","Unassigned")
			return 0
		if("Research Director","Chef","Chief Engineer")
			return 1
		if("Overseer","Wizard","MODE")
			return 2
		else
			message_admins("\"[job]\" NOT GIVEN RANK, REPORT JOBS.DM ERROR TO A CODER")
			return 2
