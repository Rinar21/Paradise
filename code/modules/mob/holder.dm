//Helper object for picking dionaea (and other creatures) up.
var/list/holder_mob_icon_cache = list()

/obj/item/holder
	name = "holder"
	desc = "You shouldn't ever see this."
	icon = 'icons/obj/objects.dmi'
	slot_flags = SLOT_HEAD
	var/last_holder

/obj/item/holder/New()
	..()
	START_PROCESSING(SSobj, src)

/obj/item/holder/Destroy()
	for(var/atom/movable/AM in src)
		AM.forceMove(get_turf(src))
	last_holder = null
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/holder/proc/update_state()
//inf	if(last_holder != loc)
//inf		for(var/mob/M in contents)
//inf			unregister_all_movement(last_holder, M)

	if(istype(loc,/turf) || !(contents.len))
		for(var/mob/M in contents)
			var/atom/movable/mob_container = M
			mob_container.forceMove(loc)
		qdel(src)
//inf	else if(last_holder != loc)
//inf		for(var/mob/M in contents)
//inf			register_all_movement(loc, M)

	last_holder = loc

/obj/item/holder/attackby(obj/item/W as obj, mob/user as mob, params)
	for(var/mob/M in src.contents)
		M.attackby(W,user, params)

/obj/item/holder/proc/show_message(var/message, var/m_type)
	for(var/mob/living/M in contents)
		M.show_message(message,m_type)

/obj/item/holder/emp_act(var/intensity)
	for(var/mob/living/M in contents)
		M.emp_act(intensity)

/obj/item/holder/ex_act(var/intensity)
	for(var/mob/living/M in contents)
		M.ex_act(intensity)

/obj/item/holder/container_resist(var/mob/living/L)
	var/mob/M = src.loc                      //Get our mob holder (if any).

	if(istype(M))
		M.unEquip(src)
		to_chat(M, "[src] wriggles out of your grip!")
		to_chat(L, "You wriggle out of [M]'s grip!")
	else if(istype(loc,/obj/item))
		to_chat(L, "You struggle free of [loc].")
		forceMove(get_turf(src))

	if(istype(M))
		for(var/atom/A in M.contents)
			if(istype(A,/mob/living/simple_animal/borer) || istype(A,/obj/item/holder))
				return
		M.status_flags &= ~PASSEMOTES

	return

//Mob procs and vars for scooping up
/mob/living/var/holder_type

/obj/item/holder/proc/sync(var/mob/living/M)
	dir = 2
	overlays.Cut()
	icon = M.icon
	icon_state = M.icon_state
	color = M.color
	name = M.name
	desc = M.desc
	overlays |= M.overlays
	var/mob/living/carbon/human/H = loc
	last_holder = H
	update_held_icon()

/mob/living/proc/get_scooped(var/mob/living/carbon/human/grabber, var/self_grab)
	if(!holder_type || buckled)
		return
	if(self_grab)
		if(src.incapacitated()) return
	else
		if(grabber.incapacitated()) return

	var/obj/item/holder/H = new holder_type(get_turf(src))

	if(self_grab)
		if(!grabber.equip_to_slot_if_possible(H, slot_back, del_on_fail=0, disable_warning=1))
			to_chat(src, "<span class='warning'>You can't climb onto [grabber]!</span>")
			return

		to_chat(grabber, "<span class='notice'>\The [src] clambers onto you!</span>")
		to_chat(src, "<span class='notice'>You climb up onto \the [grabber]!</span>")
	else
		if(!grabber.put_in_hands(H))
			to_chat(grabber, "<span class='warning'>Your hands are full!</span>")
			return

	to_chat(grabber, "<span class='notice'>You scoop up \the [src]!</span>")
	to_chat(src, "<span class='notice'>\The [grabber] scoops you up!</span>")

	src.forceMove(H)

	grabber.status_flags |= PASSEMOTES
	H.sync(src)
	return H

//Mob specific holders.

/obj/item/holder/diona
	name = "diona nymph"
	desc = "It's a tiny plant critter."
	icon_state = "nymph"

/obj/item/holder/drone
	name = "maintenance drone"
	desc = "It's a small maintenance robot."
	icon_state = "drone"

/obj/item/holder/drone/emagged
	name = "maintenance drone"
	icon_state = "drone-emagged"

/obj/item/holder/cogscarab
	name = "cogscarab"
	desc = "A strange, drone-like machine. It constantly emits the hum of gears."
	icon_state = "cogscarab"

/obj/item/holder/pai
	name = "pAI"
	desc = "It's a little robot."
	icon_state = "pai"

/obj/item/holder/mouse
	name = "mouse"
	desc = "It's a small, disease-ridden rodent."
	icon = 'icons/mob/animal.dmi'
	icon_state = "mouse_gray"

/obj/item/holder/human
	name = "resomi"
	icon = 'icons/mob/holder_complex.dmi'	
	var/list/generate_for_slots = list(slot_l_hand, slot_r_hand, slot_back)
	w_class = WEIGHT_CLASS_TINY
	slot_flags = SLOT_BACK

/obj/item/holder/human/sync(mob/living/carbon/human/M)
	// Generate appropriate on-mob icons.
	var/mob/living/carbon/human/owner = M
	var/obj/item/organ/external/head/H = M.get_organ("head")
	var/obj/item/organ/internal/eyes/E = M.get_int_organ(/obj/item/organ/internal/eyes)

	if(istype(owner) && owner.dna.species)
		to_chat(M, "Прошёл проверку в sync")
		var/species_name = lowertext(owner.dna.species.name)

		for(var/cache_entry in generate_for_slots)
			var/cache_key = "[owner.dna.species]-[cache_entry]-[M.skin_colour]-[H.hair_colour]"
			if(!holder_mob_icon_cache[cache_key])
				// Generate individual icons.
				var/icon/mob_icon = icon(icon, "[species_name]_holder_[cache_entry]_base")
				mob_icon.Blend(M.skin_colour, ICON_ADD)
				var/icon/hair_icon = icon(icon, "[species_name]_holder_[cache_entry]_hair")
				hair_icon.Blend(H.hair_colour, ICON_ADD)
				var/icon/eyes_icon = icon(icon, "[species_name]_holder_[cache_entry]_eyes")
				eyes_icon.Blend(E.eye_colour, ICON_ADD)
				// Blend them together.
				mob_icon.Blend(eyes_icon, ICON_OVERLAY)
				mob_icon.Blend(hair_icon, ICON_OVERLAY)
				// Add to the cache.
				holder_mob_icon_cache[cache_key] = mob_icon
		// Handle the rest of sync().
		..(M)

/mob/living/MouseDrop(var/mob/living/carbon/human/over_object)
	if(istype(over_object) && Adjacent(over_object) && (usr == src || usr == over_object) && over_object.a_intent == INTENT_HELP)
		if(scoop_check(over_object))
			get_scooped(over_object, (usr == src))
			log_admin("[key_name(over_object)] scooped [key_name(src)] at [loc]")
			over_object.regenerate_icons()
			return
	return ..()

/mob/living/proc/scoop_check(var/mob/living/scooper)
	if(scoop_check(scooper))
		return 1
	else
		return 0

/mob/living/carbon/human/scoop_check(var/mob/living/scooper)
	if(SMALL_BODY in scooper.dna.species.species_traits)
		to_chat(scooper, "SMALL_BODY in scooper")
		return 0
	if(!(SMALL_BODY in src.dna.species.species_traits))
		to_chat(scooper, "SMALL_BODY in src")
		return 0
	if((scooper.a_intent != INTENT_HELP))
		to_chat(scooper, "scooper intent check")
		return 0
	if((src.a_intent != INTENT_HELP))
		to_chat(scooper, "src intent check")
		return 0
	else
		to_chat(scooper, "success")
		return 1