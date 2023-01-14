/obj/item/holder
	var/prepared_type // Может быть кому-нибудь понадобится животное сразу? ~bear1ake

/obj/item/holder/New()
	..()

	if(prepared_type)
		var/mob/living/S = new prepared_type(loc)
		contents |= S



/obj/item/holder/diona/prepared
	name = "diona nymph"
	desc = "It's a tiny plant critter."

/obj/item/holder/drone/prepared
	name = "maintenance drone"
	desc = "It's a small maintenance robot."

/obj/item/holder/drone/emagged/prepared
	name = "maintenance drone"

/obj/item/holder/cogscarab/prepared
	name = "cogscarab"
	desc = "A strange, drone-like machine. It constantly emits the hum of gears."

/obj/item/holder/pai/prepared
	name = "pAI"
	desc = "It's a little robot."

/obj/item/holder/mouse/prepared
	name = "mouse"
	desc = "It's a small, disease-ridden rodent."

