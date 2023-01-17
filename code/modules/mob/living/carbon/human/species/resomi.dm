/datum/species/resomi
	name = "Resomi"
	name_plural = "Resomi"
	icobase = 'icons/mob/human_races/r_resomi.dmi'
	deform = 'icons/mob/human_races/r_def_resomi.dmi'
	language = "Scheshi"
	tail = "resomitail"
	unarmed_type = /datum/unarmed_attack/claws
	eyes = "resomi_eyes_s"
	species_traits = list(IS_WHITELISTED, SMALL_BODY, SMALL_FINGERS)
	blurb = "A race of feathered raptors who developed on a cold world, almost \
	outside of the Goldilocks zone. Extremely fragile, they developed hunting skills \
	that emphasized taking out their prey without themselves getting hit. They are an \
	advanced culture on good terms with Skrellian and Human interests."

	damage_overlays = 'icons/mob/human_races/masks/dam_mask_resomi.dmi'
	blood_mask = 'icons/mob/human_races/masks/blood_resomi.dmi'
	damage_overlays = 'icons/mob/human_races/masks/dam_resomi.dmi'

	tox_mod = 1.35
	brute_mod = 1.35
	burn_mod =  1.35
	speed_mod = -0.83
	holder_type = /obj/item/holder/human
	scream_verb = "Чирикает!"
	female_giggle_sound = 'sound/voice/resomi_giggle.ogg'
	male_giggle_sound = 'sound/voice/resomi_giggle.ogg'
	male_scream_sound = 'sound/voice/resomi_scream.ogg'
	female_scream_sound = 'sound/voice/resomi_scream.ogg'
	female_laugh_sound = 'sound/voice/resomi_laugh.ogg'
	male_laugh_sound = 'sound/voice/resomi_laugh.ogg'
	female_cough_sounds = 'sound/voice/resomi_cough.ogg'
	male_cough_sounds = 'sound/voice/resomi_cough.ogg'
	blood_color = "#d514f7"
	base_color = "#001144"

	cold_level_1 = 180
	cold_level_2 = 130
	cold_level_3 = 70

	heat_level_1 = 320
	heat_level_2 = 370
	heat_level_3 = 600

	body_temperature = 314.15

	reagent_tag = PROCESS_ORG
	bodyflags = HAS_TAIL | HAS_SKIN_COLOR | HAS_BODY_MARKINGS | TAIL_WAGGING

	disliked_food = FRUIT | VEGETABLES | GRAIN

	suicide_messages = list(
		"пытается откусить себе язык!",
		"выдергивает свои перья!",
		"задерживает дыхание!",
		"сворачивает себе шею!"
		)

	has_organ = list(
		"heart" =    /obj/item/organ/internal/heart/resomi,
		"lungs" =    /obj/item/organ/internal/lungs/resomi,
		"liver" =    /obj/item/organ/internal/liver/resomi,
		"kidneys" =  /obj/item/organ/internal/kidneys/resomi,
		"brain" =    /obj/item/organ/internal/brain/resomi,
		"appendix" = /obj/item/organ/internal/appendix,
		"eyes" =     /obj/item/organ/internal/eyes/resomi
	)

	has_limbs = list(
		"chest" =  list("path" = /obj/item/organ/external/chest),
		"groin" =  list("path" = /obj/item/organ/external/groin),
		"head" =   list("path" = /obj/item/organ/external/head),
		"l_arm" =  list("path" = /obj/item/organ/external/arm),
		"r_arm" =  list("path" = /obj/item/organ/external/arm/right),
		"l_leg" =  list("path" = /obj/item/organ/external/leg),
		"r_leg" =  list("path" = /obj/item/organ/external/leg/right),
		"l_hand" = list("path" = /obj/item/organ/external/hand),
		"r_hand" = list("path" = /obj/item/organ/external/hand/right),
		"l_foot" = list("path" = /obj/item/organ/external/foot),
		"r_foot" = list("path" = /obj/item/organ/external/foot/right),
		"tail" =   list("path" = /obj/item/organ/external/tail/resomi))

/datum/species/resomi/on_species_gain(mob/living/carbon/human/H)
	..()	
	H.verbs |= /mob/living/carbon/human/proc/emote_wag
	H.verbs |= /mob/living/carbon/human/proc/emote_swag

	var/datum/action/innate/running/run = locate() in H.actions
	if(!run)
		run = new
		run.Grant(H)

/datum/species/resomi/on_species_loss(mob/living/carbon/human/H)
	..()
	H.verbs -= /mob/living/carbon/human/proc/emote_wag
	H.verbs -= /mob/living/carbon/human/proc/emote_swag

	var/datum/action/innate/running/run = locate() in H.actions
	if(run)
		run.Remove(H)

/datum/species/resomi/handle_death(gibbed, mob/living/carbon/human/H)
	H.stop_tail_wagging()

/datum/species/resomi/get_species_runechat_color(mob/living/carbon/human/H)
	return H.m_colours["body"]

/datum/action/innate/running
	name = "Running"
	desc = "Run on the tables"
	check_flags = AB_CHECK_RESTRAINED|AB_CHECK_STUNNED
	icon_icon = 'icons/obj/structures.dmi'
	button_icon_state = "glass_table"

/datum/action/innate/running/Activate()
	var/mob/living/carbon/human/resomi/H = owner
	add_game_logs("Turns running on the tables mod ON at [AREACOORD(H)].", H)
	background_icon_state = "bg_spell"
	H.pass_flags |= PASSTABLE
	active = TRUE
	UpdateButtonIcon()

/datum/action/innate/running/Deactivate()
	var/mob/living/carbon/human/resomi/H = owner
	add_game_logs("Disables running on the tables mod at [AREACOORD(H)].", H)
	H.pass_flags &= ~PASSTABLE
	active = FALSE
	background_icon_state = "bg_default"
	UpdateButtonIcon()
