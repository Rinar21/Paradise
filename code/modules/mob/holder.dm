//Helper object for picking dionaea (and other creatures) up.
var/list/holder_mob_icon_cache = list()

/obj/item/holder
	name = "holder"
	desc = "You shouldn't ever see this."
	icon = 'icons/obj/objects.dmi'
	lefthand_file = 'icons/mob/inhands/mobs_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/mobs_righthand.dmi'
	slot_flags = SLOT_HEAD
	var/last_holder
	origin_tech = "biotech=2"


/obj/item/holder/New()
	..()
	START_PROCESSING(SSobj, src)

/obj/item/holder/Destroy()
	for(var/atom/movable/AM in src)
		AM.forceMove(get_turf(src))
	last_holder = null
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/holder/process()

	if(istype(loc,/turf) || !(contents.len))

		for(var/mob/M in contents)

			var/atom/movable/mob_container
			mob_container = M
			mob_container.forceMove(get_turf(src))

		qdel(src)

	last_holder = loc

/obj/item/holder/attackby(obj/item/W as obj, mob/user as mob, params)
	for(var/mob/M in src.contents)
		M.attackby(W,user, params)

/obj/item/holder/attack(mob/living/target, mob/living/user, def_zone)
	if(ishuman(user))	//eating holder
		if(target == user)
			for(var/mob/M in src.contents)
				if(devoured(M, user))
					return TRUE
	. = ..()

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
		M.drop_item_ground(src)
		to_chat(M, "[src.name] вырывается из вашей хватки!")
		to_chat(L, "Вы вырываетесь из хвата [M.name]!")
	else if(istype(loc,/obj/item))
		to_chat(L, "Вы выбираетесь из [loc].")
		forceMove(get_turf(src))
	L.resting = FALSE

	if(istype(M))
		for(var/atom/A in M.contents)
			if(istype(A,/mob/living/simple_animal/borer) || istype(A,/obj/item/holder))
				return
		M.status_flags &= ~PASSEMOTES

	return

//Mob procs and vars for scooping up
/mob/living
	var/holder_type = null

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
		if(!grabber.equip_to_slot_if_possible(H, slot_back, qdel_on_fail=0, disable_warning=1))
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
	H.name = name
	H.icon = icon
	H.icon_state = icon_state
	if(desc)
		H.desc = desc
	H.attack_hand(grabber)

	to_chat(grabber, "<span class='notice'>Вы подняли [src.name].")
	to_chat(src, "<span class='notice'>[grabber.name] поднял[genderize_ru(grabber.gender,"","а","о","и")] вас.</span>")
	grabber.status_flags |= PASSEMOTES
	H.sync(src)

	switch(mob_size)
		if(MOB_SIZE_TINY)
			H.w_class = WEIGHT_CLASS_TINY
		if(MOB_SIZE_SMALL)
			H.w_class = WEIGHT_CLASS_SMALL
		if(MOB_SIZE_HUMAN)
			H.w_class = WEIGHT_CLASS_NORMAL
		if(MOB_SIZE_LARGE)
			H.w_class = WEIGHT_CLASS_HUGE

	return H

//Mob specific holders.

/obj/item/holder/diona
	name = "diona nymph"
	desc = "It's a tiny plant critter."
	icon_state = "nymph"
	origin_tech = "biotech=5"

/obj/item/holder/drone
	name = "maintenance drone"
	desc = "It's a small maintenance robot."
	icon_state = "drone"
	origin_tech = "materials=3;programming=4;powerstorage=3;engineering=4"

/obj/item/holder/drone/emagged
	name = "maintenance drone"
	icon_state = "drone-emagged"
	origin_tech = "materials=3;programming=4;powerstorage=3;engineering=4;syndicate=3"

/obj/item/holder/cogscarab
	name = "cogscarab"
	desc = "A strange, drone-like machine. It constantly emits the hum of gears."
	icon_state = "cogscarab"
	origin_tech = "materials=3;magnets=4;powerstorage=9;bluespace=4"

/obj/item/holder/pai
	name = "pAI"
	desc = "It's a little robot."
	icon_state = "pai"
	origin_tech = "materials=3;programming=4;engineering=4"

/obj/item/holder/mouse
	name = "mouse"
	desc = "It's a small, disease-ridden rodent."
	icon = 'icons/mob/animal.dmi'
	icon_state = "mouse_gray"

/obj/item/holder/monkey
	name = "monkey"
	desc = "It's a monkey"
	icon_state = "monkey"
	origin_tech = "biotech=3"

/obj/item/holder/farwa
	name = "farwa"
	desc = "It's a farwa"
	icon_state = "farwa"
	origin_tech = "biotech=3"

/obj/item/holder/stok
	name = "stok"
	desc = "It's a stok"
	icon_state = "stok"
	origin_tech = "biotech=3"

/obj/item/holder/neara
	name = "neara"
	desc = "It's a neara"
	icon_state = "neara"
	origin_tech = "biotech=3"

/obj/item/holder/corgi
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/pets.dmi'
	icon_state = "corgi"

/obj/item/holder/lisa
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/pets.dmi'
	icon_state = "lisa"

/obj/item/holder/old_corgi
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/pets.dmi'
	icon_state = "old_corgi"

/obj/item/holder/borgi
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/pets.dmi'
	icon_state = "borgi"

/obj/item/holder/void_puppy
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/pets.dmi'
	icon_state = "void_puppy"
	origin_tech = "biotech=4;bluespace=5"

/obj/item/holder/slime_puppy
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/pets.dmi'
	icon_state = "slime_puppy"
	origin_tech = "biotech=6"

/obj/item/holder/narsian
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/pets.dmi'
	icon_state = "narsian"
	slot_flags = null
	origin_tech = "bluespace=10"

/obj/item/holder/pug
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/pets.dmi'
	icon_state = "pug"

/obj/item/holder/fox
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/pets.dmi'
	icon_state = "fox"

/obj/item/holder/sloth
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/pets.dmi'
	icon_state = "sloth"
	slot_flags = null

/obj/item/holder/cat
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/pets.dmi'
	icon_state = "cat"

/obj/item/holder/crusher
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/pets.dmi'
	icon_state = "crusher"

/obj/item/holder/cat2
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/pets.dmi'
	icon_state = "cat2"

/obj/item/holder/cak
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/pets.dmi'
	icon_state = "cak"
	origin_tech = "biotech=5"

/obj/item/holder/original
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/pets.dmi'
	icon_state = "original"

/obj/item/holder/spacecat
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/pets.dmi'
	icon_state = "spacecat"

/obj/item/holder/fatcat
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/iriska.dmi'
	icon_state = "iriska"
	slot_flags = null

/obj/item/holder/bullterrier
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/pets.dmi'
	icon_state = "bullterrier"
	slot_flags = null

/obj/item/holder/crab
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/animal.dmi'
	icon_state = "crab"

/obj/item/holder/evilcrab
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/animal.dmi'
	icon_state = "evilcrab"

/obj/item/holder/snake
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/animal.dmi'
	icon_state = "snake"
	slot_flags = SLOT_HEAD | SLOT_NECK

/obj/item/holder/parrot
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/animal.dmi'
	icon_state = "parrot_fly"

/obj/item/holder/axolotl
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/animal.dmi'
	icon_state = "axolotl"

/obj/item/holder/lizard
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/animal.dmi'
	icon_state = "lizard"

/obj/item/holder/chick
	name = "pet"
	desc = "It's a small chicken"
	icon = 'icons/mob/animal.dmi'
	icon_state = "chick"

/obj/item/holder/chicken
	name = "pet"
	desc = "It's a chicken"
	icon = 'icons/mob/animal.dmi'
	icon_state = "chicken_brown"
	slot_flags = null

/obj/item/holder/cock
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/animal.dmi'
	icon_state = "cock"
	slot_flags = null

/obj/item/holder/hamster
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/animal.dmi'
	icon_state = "hamster"

/obj/item/holder/hamster_rep
	name = "Представитель Алексей"
	desc = "Уважаемый хомяк"
	icon = 'icons/mob/animal.dmi'
	icon_state = "hamster_rep"

/obj/item/holder/fennec
	name = "fennec"
	desc = "It's a fennec. Yiff!"
	icon_state = "fennec"
	origin_tech = "biotech=4"

/obj/item/holder/mothroach
	name = "mothroach"
	desc = "Bzzzz"
	icon = 'icons/mob/pets.dmi'
	icon_state = "mothroach"
	origin_tech = "biotech=4"

/obj/item/holder/moth
	name = "moth"
	desc = "Bzzzz"
	icon = 'icons/mob/animal.dmi'
	icon_state = "moth"
	origin_tech = "biotech=4"

/obj/item/holder/headslug
	name = "headslug"
	desc = "It's a headslug. Ewwww..."
	icon = 'icons/mob/mob.dmi'
	icon_state = "headslug"
	origin_tech = "biotech=6"

/obj/item/holder/possum
	name = "possum"
	desc = "It's a possum. Ewwww..."
	icon = 'icons/mob/pets.dmi'
	icon_state = "possum"
	origin_tech = "biotech=3"

/obj/item/holder/possum/poppy
	name = "poppy"
	desc = "It's a possum Poppy. Ewwww..."
	icon = 'icons/mob/pets.dmi'
	icon_state = "possum_poppy"

/obj/item/holder/frog
	name = "frog"
	desc = "It's a wednesday, my dudes."
	icon = 'icons/mob/animal.dmi'
	icon_state = "frog"

/obj/item/holder/frog/toxic
	name = "rare frog"
	desc = "It's a toxic wednesday, my dudes."
	icon_state = "rare_frog"

/obj/item/holder/snail
	name = "snail"
	desc = "Slooooow"
	icon = 'icons/mob/animal.dmi'
	icon_state = "snail"
	slot_flags = null

/obj/item/holder/turtle
	name = "yeeslow"
	desc = "Slooooow"
	icon = 'icons/mob/animal.dmi'
	icon_state = "yeeslow"
	slot_flags = null

/obj/item/holder/clowngoblin
	name = "clowngoblin"
	desc = "Honk honk"
	icon = 'icons/mob/animal.dmi'
	icon_state = "clowngoblin"

/obj/item/holder/monkey
	name = "monkey"
	desc = "It's a monkey"
	icon_state = "monkey"
	origin_tech = "biotech=3"

/obj/item/holder/farwa
	name = "farwa"
	desc = "It's a farwa"
	icon_state = "farwa"
	origin_tech = "biotech=3"

/obj/item/holder/stok
	name = "stok"
	desc = "It's a stok"
	icon_state = "stok"
	origin_tech = "biotech=3"

/obj/item/holder/neara
	name = "neara"
	desc = "It's a neara"
	icon_state = "neara"
	origin_tech = "biotech=3"

/obj/item/holder/corgi
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/pets.dmi'
	icon_state = "corgi"

/obj/item/holder/lisa
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/pets.dmi'
	icon_state = "lisa"

/obj/item/holder/old_corgi
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/pets.dmi'
	icon_state = "old_corgi"

/obj/item/holder/borgi
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/pets.dmi'
	icon_state = "borgi"

/obj/item/holder/void_puppy
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/pets.dmi'
	icon_state = "void_puppy"
	origin_tech = "biotech=4;bluespace=5"

/obj/item/holder/slime_puppy
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/pets.dmi'
	icon_state = "slime_puppy"
	origin_tech = "biotech=6"

/obj/item/holder/narsian
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/pets.dmi'
	icon_state = "narsian"
	slot_flags = null
	origin_tech = "bluespace=10"

/obj/item/holder/pug
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/pets.dmi'
	icon_state = "pug"

/obj/item/holder/fox
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/pets.dmi'
	icon_state = "fox"

/obj/item/holder/sloth
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/pets.dmi'
	icon_state = "sloth"
	slot_flags = null

/obj/item/holder/cat
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/pets.dmi'
	icon_state = "cat"

/obj/item/holder/crusher
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/pets.dmi'
	icon_state = "crusher"

/obj/item/holder/cat2
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/pets.dmi'
	icon_state = "cat2"

/obj/item/holder/cak
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/pets.dmi'
	icon_state = "cak"
	origin_tech = "biotech=5"

/obj/item/holder/original
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/pets.dmi'
	icon_state = "original"

/obj/item/holder/spacecat
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/pets.dmi'
	icon_state = "spacecat"

/obj/item/holder/fatcat
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/iriska.dmi'
	icon_state = "iriska"
	slot_flags = null

/obj/item/holder/bullterrier
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/pets.dmi'
	icon_state = "bullterrier"
	slot_flags = null

/obj/item/holder/crab
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/animal.dmi'
	icon_state = "crab"

/obj/item/holder/evilcrab
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/animal.dmi'
	icon_state = "evilcrab"

/obj/item/holder/snake
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/animal.dmi'
	icon_state = "snake"
	slot_flags = SLOT_HEAD | SLOT_NECK

/obj/item/holder/parrot
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/animal.dmi'
	icon_state = "parrot_fly"

/obj/item/holder/axolotl
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/animal.dmi'
	icon_state = "axolotl"

/obj/item/holder/lizard
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/animal.dmi'
	icon_state = "lizard"

/obj/item/holder/chick
	name = "pet"
	desc = "It's a small chicken"
	icon = 'icons/mob/animal.dmi'
	icon_state = "chick"

/obj/item/holder/chicken
	name = "pet"
	desc = "It's a chicken"
	icon = 'icons/mob/animal.dmi'
	icon_state = "chicken_brown"
	slot_flags = null

/obj/item/holder/cock
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/animal.dmi'
	icon_state = "cock"
	slot_flags = null

/obj/item/holder/hamster
	name = "pet"
	desc = "It's a pet"
	icon = 'icons/mob/animal.dmi'
	icon_state = "hamster"

/obj/item/holder/hamster_rep
	name = "Представитель Алексей"
	desc = "Уважаемый хомяк"
	icon = 'icons/mob/animal.dmi'
	icon_state = "hamster_rep"

/obj/item/holder/fennec
	name = "fennec"
	desc = "It's a fennec. Yiff!"
	icon_state = "fennec"
	origin_tech = "biotech=4"

/obj/item/holder/mothroach
	name = "mothroach"
	desc = "Bzzzz"
	icon = 'icons/mob/pets.dmi'
	icon_state = "mothroach"
	origin_tech = "biotech=4"

/obj/item/holder/moth
	name = "moth"
	desc = "Bzzzz"
	icon = 'icons/mob/animal.dmi'
	icon_state = "moth"
	origin_tech = "biotech=4"

/obj/item/holder/headslug
	name = "headslug"
	desc = "It's a headslug. Ewwww..."
	icon = 'icons/mob/mob.dmi'
	icon_state = "headslug"
	origin_tech = "biotech=6"

/obj/item/holder/possum
	name = "possum"
	desc = "It's a possum. Ewwww..."
	icon = 'icons/mob/pets.dmi'
	icon_state = "possum"
	origin_tech = "biotech=3"

/obj/item/holder/possum/poppy
	name = "poppy"
	desc = "It's a possum Poppy. Ewwww..."
	icon = 'icons/mob/pets.dmi'
	icon_state = "possum_poppy"

/obj/item/holder/frog
	name = "frog"
	desc = "It's a wednesday, my dudes."
	icon = 'icons/mob/animal.dmi'
	icon_state = "frog"

/obj/item/holder/frog/toxic
	name = "rare frog"
	desc = "It's a toxic wednesday, my dudes."
	icon_state = "rare_frog"

/obj/item/holder/snail
	name = "snail"
	desc = "Slooooow"
	icon = 'icons/mob/animal.dmi'
	icon_state = "snail"
	slot_flags = null

/obj/item/holder/turtle
	name = "yeeslow"
	desc = "Slooooow"
	icon = 'icons/mob/animal.dmi'
	icon_state = "yeeslow"
	slot_flags = null

/obj/item/holder/clowngoblin
	name = "clowngoblin"
	desc = "Honk honk"
	icon = 'icons/mob/animal.dmi'
	icon_state = "clowngoblin"

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
