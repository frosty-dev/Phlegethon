/mob/verb/check_harpy()
	set name = "Check Harpyness"
	set category = "Special Verbs"
	set desc = "Reports how much inhumanity you have"

	if(config.sql_enabled)
		var/DBConnection/dbcon = new()
		dbcon.Connect("dbi:mysql:[sqldb]:[sqladdress]:[sqlport]","[sqllogin]","[sqlpass]")
		if(!dbcon.IsConnected())
			usr << "\red Unable to connect to harpyness database. This error can occur if your host has failed to set up an SQL database or improperly configured its login credentials.<br>"
			return
		else
			usr.verbs -= /mob/verb/check_harpy
			spawn(300)
				usr.verbs += /mob/verb/check_harpy
			var/DBQuery/query = dbcon.NewQuery("SELECT harpyness FROM harpytotals WHERE byondkey='[src.key]'")
			query.Execute()

			var/currentharpy
			while(query.NextRow())
				currentharpy = query.item[1]
			if(currentharpy)
				usr << "<b>Your current harpyness is:</b> [currentharpy]<br>"
			else
				usr << "<b>Your current harpyness is:</b> 0<br>"
		dbcon.Disconnect()
	else
		usr << "<b>SQL is off, harpyness is not usable<b>"


/*
mob/Logout()
   var/savefile/F = new(ckey)
   Write(F)
   del(src)

mob/Login()
   var/savefile/F = new(ckey)
   Read(F)
   return ..()




var/savefile/SaveFile = new("players.sav")

mob/Login()
   SaveFile.cd = "/"  //make sure we are at the root
   if(ckey in SaveFile.dir)
      SaveFile.cd = ckey
      Read(SaveFile)
      usr << "Welcome back, [name]!"
   else
      usr << "Welcome, [name]!"
   ..()




mob/Write(savefile/F)
   //store coordinates
   F << x
   F << y
   F << z
   //store variables
   ..()
mob/Read(savefile/F)
   var {saved_x; saved_y; saved_z}
   //load coordinates
   F >> saved_x
   F >> saved_y
   F >> saved_z
   //restore variables
   ..()
   //restore coordinates
   Move(locate(saved_x,saved_y,saved_z))



mob/Write(savefile/F)
   F["name"]   << name
   F["gender"] << gender
   F["icon"]   << icon
mob/Read(savefile/F)
   F["name"]   >> name
   F["gender"] >> gender
   F["icon"]   >> icon




*/