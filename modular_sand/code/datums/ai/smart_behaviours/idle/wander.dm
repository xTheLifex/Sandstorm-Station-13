/* -------------------------------------------------------------------------- */
/*                              Wander Behaviour                              */
/* -------------------------------------------------------------------------- */

/// Wander around aimlessly. Like a simple mob i guess.
/datum/smart_behaviours/wander

/datum/smart_behaviours/wander/can_execute(var/mob/living/simple_animal/smart/M, delta_time, times_fired)
	return !M.buckled

/datum/smart_behaviours/wander/execute(var/mob/living/simple_animal/smart/M, delta_time, times_fired)

