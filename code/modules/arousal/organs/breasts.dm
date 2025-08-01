#define BREASTS_ICON_MIN_SIZE 1
#define BREASTS_ICON_MAX_SIZE 17

/obj/item/organ/genital/breasts
	name = "breasts"
	desc = "Female milk producing organs."
	icon_state = "breasts"
	icon = 'icons/obj/genitals/breasts.dmi'
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_BREASTS
	size = BREASTS_SIZE_DEF // "c". Refer to the breast_values static list below for the cups associated number values
	fluid_id = /datum/reagent/consumable/milk
	fluid_rate = MILK_RATE
	shape = DEF_BREASTS_SHAPE
	genital_flags = CAN_MASTURBATE_WITH|CAN_CLIMAX_WITH|GENITAL_FUID_PRODUCTION|GENITAL_CAN_AROUSE|UPDATE_OWNER_APPEARANCE|GENITAL_UNDIES_HIDDEN
	masturbation_verb = "massage"
	arousal_verb = "Your breasts start feeling sensitive"
	unarousal_verb = "Your breasts no longer feel sensitive"
	orgasm_verb = "leaking"
	fluid_transfer_factor = 0.5
	var/static/list/breast_values = list("a" =  1, "b" = 2, "c" = 3, "d" = 4, "e" = 5, "f" = 6, "g" = 7, "h" = 8, "i" = 9, "j" = 10, "k" = 11, "l" = 12, "m" = 13, "n" = 14, "o" = 15, "p" = 16, "huge" = 17, "flat" = 0)
	var/cached_size //these two vars pertain size modifications and so should be expressed in NUMBERS.
	var/prev_size //former cached_size value, to allow update_size() to early return should be there no significant changes.

/obj/item/organ/genital/breasts/Initialize(mapload, do_update = TRUE)
	if(do_update)
		cached_size = breast_values[size]
		prev_size = cached_size
	return ..()

/obj/item/organ/genital/breasts/update_appearance()
	. = ..()
	var/lowershape = lowertext(shape)
	switch(lowershape)
		if("pair")
			desc = "You see a pair of breasts."
		if("quad")
			desc = "You see two pairs of breast, one just under the other."
		if("sextuple")
			desc = "You see three sets of breasts, running from their chest to their belly."
		else
			desc = "You see some breasts, they seem to be quite exotic."
	if(size == "huge")
		desc = "You see [pick("some serious honkers", "a real set of badonkers", "some dobonhonkeros", "massive dohoonkabhankoloos", "two big old tonhongerekoogers", "a couple of giant bonkhonagahoogs", "a pair of humongous hungolomghnonoloughongous")]. Their volume is way beyond cupsize now, measuring in about [round(cached_size)]cm in diameter."
	else
		if (size == "flat")
			desc += " They're very small and flatchested, however."
		else
			desc += " You estimate that they're [uppertext(size)]-cups."

	if((genital_flags & GENITAL_FUID_PRODUCTION) && aroused_state)
		var/datum/reagent/R = GLOB.chemical_reagents_list[fluid_id]
		if(R)
			desc += " They're leaking [lowertext(R.name)]."
	var/datum/sprite_accessory/S = GLOB.breasts_shapes_list[shape]
	var/icon_shape = S ? S.icon_state : "pair"
	var/icon_size = clamp(breast_values[size], BREASTS_ICON_MIN_SIZE, BREASTS_ICON_MAX_SIZE)
	icon_state = "breasts_[icon_shape]_[icon_size]"
	if(owner)
		if(owner.dna.species.use_skintones && owner.dna.features["genitals_use_skintone"])
			if(ishuman(owner)) // Check before recasting type, although someone fucked up if you're not human AND have use_skintones somehow...
				var/mob/living/carbon/human/H = owner // only human mobs have skin_tone, which we need.
				color = SKINTONE2HEX(H.skin_tone)
				if(!H.dna.skin_tone_override)
					icon_state += "_s"
		else
			color = "#[owner.dna.features["breasts_color"]]"

//Allows breasts to grow and change size, with sprite changes too.
//maximum wah
//Comical sizes slow you down in movement and actions.
//Ridiculous sizes makes you more cumbersome.
//this is far too lewd wah

/obj/item/organ/genital/breasts/modify_size(modifier, min = -INFINITY, max = INFINITY)
	var/new_value = clamp(cached_size + modifier, min, max)
	if(new_value == cached_size)
		return
	prev_size = cached_size
	cached_size = new_value
	update()
	..()

/obj/item/organ/genital/breasts/update_size()//wah
	var/rounded_cached = round(cached_size)
	if(cached_size < 0)//I don't actually know what round() does to negative numbers, so to be safe!!fixed
		if(owner)
			to_chat(owner, "<span class='warning'>You feel your breasts shrinking away from your body as your chest flattens out.</span>")
		QDEL_IN(src, 1)
		return
	switch(rounded_cached)
		if(0) //flatchested
			size = "flat"
		if(1 to 8) //modest
			size = breast_values[rounded_cached]
		if(9 to 15) //massive
			size = breast_values[rounded_cached]
		if(16 to INFINITY) //rediculous
			size = "huge"

	if(rounded_cached < 16 && owner)//Because byond doesn't count from 0, I have to do this.
		var/mob/living/carbon/human/H = owner
		var/r_prev_size = round(prev_size)
		if (rounded_cached > r_prev_size)
			to_chat(H, "<span class='warning'>Your breasts [pick("swell up to", "flourish into", "expand into", "burst forth into", "grow eagerly into", "amplify into")] a [uppertext(size)]-cup.</span>")
		else if (rounded_cached < r_prev_size)
			to_chat(H, "<span class='warning'>Your breasts [pick("shrink down to", "decrease into", "diminish into", "deflate into", "shrivel regretfully into", "contracts into")] a [uppertext(size)]-cup.</span>")

/obj/item/organ/genital/breasts/get_features(mob/living/carbon/human/H)
	var/datum/dna/D = H.dna
	if(D.species.use_skintones && D.features["genitals_use_skintone"])
		color = SKINTONE2HEX(H.skin_tone)
	else
		color = "#[D.features["breasts_color"]]"
	size = D.features["breasts_size"]
	shape = D.features["breasts_shape"]
	if(!D.features["breasts_producing"])
		genital_flags &= ~ (GENITAL_FUID_PRODUCTION|CAN_CLIMAX_WITH|CAN_MASTURBATE_WITH)
	if(!isnum(size))
		cached_size = breast_values[size]
	else
		cached_size = size
		size = breast_values[size]
	prev_size = cached_size
	toggle_visibility(D.features["breasts_visibility"], FALSE)
	if(D.features["breasts_accessible"])
		toggle_accessibility(TRUE)

#undef BREASTS_ICON_MIN_SIZE
#undef BREASTS_ICON_MAX_SIZE
