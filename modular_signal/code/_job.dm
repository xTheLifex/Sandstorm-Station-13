/datum/job/scientist
	title = "Researcher"
	paycheck = 0 // Sell drives instead, moron.
	always_can_respawn_as = TRUE

/datum/outfit/job/scientist
	belt = null
	ears = null
	box = null

/datum/job/New()
	if(!istype(src, /datum/job/scientist))
		total_positions = 0
		spawn_positions = 0
	return ..()
