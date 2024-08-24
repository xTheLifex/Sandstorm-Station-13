/* -------------------------------------------------------------------------- */
/*                               Smart Behaviour                              */
/* -------------------------------------------------------------------------- */
/*
	The smart behaviour datums here are part of an attempt to have improved
	AI without needlessly increasing complexity of the code. Instead of making
	behaviour trees, we're making simple state machines with a modular approach.
*/
/* -------------------------------------------------------------------------- */

/datum/smart_behaviours
	var/priority = 0

/datum/smart_behaviours/proc/can_execute(var/mob/living/simple_animal/smart/M, delta_time, times_fired)
	return TRUE

/datum/smart_behaviours/proc/execute(var/mob/living/simple_animal/smart/M, delta_time, times_fired)
	return
