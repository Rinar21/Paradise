/datum/species/resomi
	name = "Resomi"
	name_plural = "Resomi"
	icobase = 'icons/mob/human_races/r_resomi.dmi'
	language = "Scheshi"
	tail = "resomitail"
	unarmed_type = /datum/unarmed_attack/claws
	eyes = "resomi_eyes_s"
	species_traits = list(IS_WHITELISTED, SMALL_BODY)
	blurb = "A race of feathered raptors who developed on a cold world, almost \
	outside of the Goldilocks zone. Extremely fragile, they developed hunting skills \
	that emphasized taking out their prey without themselves getting hit. They are an \
	advanced culture on good terms with Skrellian and Human interests."

	tox_mod = 1.35
	brute_mod = 1.35
	burn_mod =  1.35
	speed_mod = -0.83

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
	bodyflags = HAS_TAIL | HAS_SKIN_COLOR

	has_organ = list(
		"heart" =    /obj/item/organ/internal/heart,
		"lungs" =    /obj/item/organ/internal/lungs,
		"liver" =    /obj/item/organ/internal/liver/resomi,
		"kidneys" =  /obj/item/organ/internal/kidneys/resomi,
		"brain" =    /obj/item/organ/internal/brain,
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
