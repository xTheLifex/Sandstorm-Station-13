/datum/interaction/lewd/frotting
	description = "Rub your penis against theirs"
	required_from_user_exposed = INTERACTION_REQUIRE_PENIS
	required_from_target_exposed = INTERACTION_REQUIRE_PENIS
	write_log_user = "frotted"
	write_log_target = "was frotted by"
	interaction_sound = null

/datum/interaction/lewd/frotting/display_interaction(mob/living/user, mob/living/partner)
	var/message
	var/t_His = user.p_their()

	message = "[pick("rubs [t_His] penis against [partner]'s.",
				"pushes [t_His] cock against [partner]'s.",
				"[t_His] works themselves against [partner].",
				"[t_His] meets their hip with [partner]'s as their rods meet together.")]"
	user.set_is_fucking(partner, CUM_TARGET_PENIS, user.getorganslot(ORGAN_SLOT_PENIS))
	user.visible_message(span_lewd("<b>\The [user]</b> [message]"), ignored_mobs = user.get_unconsenting())
	user.handle_post_sex(NORMAL_LUST, CUM_TARGET_PENIS, partner)
	partner.handle_post_sex(NORMAL_LUST, CUM_TARGET_PENIS, user)

/datum/interaction/lewd/tribadism
	description = "Grind your pussy against theirs."
	interaction_sound = null
	required_from_user_exposed = INTERACTION_REQUIRE_VAGINA
	required_from_target_exposed = INTERACTION_REQUIRE_VAGINA

/datum/interaction/lewd/tribadism/display_interaction(mob/living/user, mob/living/partner)
	var/message

	var/u_His = user.p_their()

	if(partner.is_fucking(user, CUM_TARGET_VAGINA))
		message = "[pick("grinds [u_His] pussy against \the <b>[partner]</b>'s cunt.",
			"rubs [u_His] cunt against \the <b>[partner]</b>'s pussy.",
			"thrusts against \the <b>[partner]</b>'s pussy.",
			"humps \the <b>[partner]</b>, [u_His] pussies grinding against each other.")]"
	else
		message = "presses [u_His] pussy into \the <b>[partner]</b>'s own."
		partner.set_is_fucking(user, CUM_TARGET_VAGINA, partner.getorganslot(ORGAN_SLOT_VAGINA))
	playlewdinteractionsound(get_turf(user), pick('modular_sand/sound/interactions/squelch1.ogg',
						'modular_sand/sound/interactions/squelch2.ogg',
						'modular_sand/sound/interactions/squelch3.ogg'), 70, 1, -1)
	user.visible_message(span_lewd("<b>\The [user]</b> [message]"), ignored_mobs = user.get_unconsenting())
	partner.handle_post_sex(NORMAL_LUST, CUM_TARGET_VAGINA, user)
	user.handle_post_sex(NORMAL_LUST, CUM_TARGET_VAGINA, partner)
