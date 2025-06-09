/datum/interaction/lewd/kiss
	description = "Kiss them deeply."
	required_from_user = INTERACTION_REQUIRE_MOUTH
	required_from_target = INTERACTION_REQUIRE_MOUTH
	write_log_user = "kissed"
	write_log_target = "was kissed by"
	interaction_sound = null
	additional_details = list(
		list(
			"info" = "Sets lust of both to 5 if less than 5",
			"icon" = "heart",
			"color" = "red"
		)
	)

/datum/interaction/lewd/kiss/post_interaction(mob/living/user, mob/living/partner)
	. = ..()
	if(user.get_lust() < 5)
		user.set_lust(5)
	if(partner.get_lust() < 5)
		partner.set_lust(5)

/datum/interaction/lewd/kiss/display_interaction(mob/living/user, mob/living/partner)
	if(user.get_lust() >= 3)
		user.visible_message(span_lewd("\The <b>[user]</b> gives an intense, lingering kiss to \the <b>[partner]</b>."))
	else
		user.visible_message(span_lewd("\The <b>[user]</b> kisses \the <b>[partner]</b> deeply."))
	playlewdinteractionsound(user.loc, pick(GLOB.lewd_kiss_sounds), 90, 0, 0)
