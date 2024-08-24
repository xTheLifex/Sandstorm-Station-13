/mob/living/simple_animal/smart
	name = "smart animal"
	var/behaviours = list() // Fill with a COPY of behaviours on mob definition.
	var/smartmem = list() // Associative array/list shared between behaviours.

/mob/living/simple_animal/smart/handle_automated_action()
	return

/mob/living/simple_animal/smart/handle_automated_movement()
	return

/mob/living/simple_animal/smart/handle_automated_speech(override)
	return

/mob/living/simple_animal/smart/BiologicalLife(delta_time, times_fired)
	. = ..()


/// Adds a smart behaviour to this mob
/mob/living/simple_animal/smart/proc/add_behaviour(/datum/smart_behaviours/B)
	if (LAZYFIND(behaviours,B) > 0)
		return
	behaviours += new B()

/// Removes a smart behaviour from this mob's processing.
/mob/living/simple_animal/smart/proc/remove_behaviour(/datum/smart_behaviours/B)
	var/datum/smart_behaviours/found = LAZYACCESS(behaviours, B)
	if (!isnull(found))
		LAZYREMOVE(behaviours, found)
