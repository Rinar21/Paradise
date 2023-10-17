
//////////////////////
//		Meals		//
//////////////////////

/obj/item/reagent_containers/food/snacks/eggplantparm
	name = "eggplant parmigiana"
	desc = "The only good recipe for eggplant."
	icon_state = "eggplantparm"
	trash = /obj/item/trash/plate
	filling_color = "#4D2F5E"
	list_reagents = list("nutriment" = 6, "vitamin" = 2)
	tastes = list("eggplant" = 2, "cheese" = 2)
	foodtype = VEGETABLES | DAIRY

/obj/item/reagent_containers/food/snacks/soylentgreen
	name = "soylent green"
	desc = "Not made of people. Honest." //Totally people.
	icon_state = "soylent_green"
	trash = /obj/item/trash/waffles
	filling_color = "#B8E6B5"
	list_reagents = list("nutriment" = 10, "vitamin" = 1)
	tastes = list("waffles" = 7, "people" = 1)
	foodtype = GROSS

/obj/item/reagent_containers/food/snacks/soylentviridians
	name = "soylent virdians"
	desc = "Not made of people. Honest." //Actually honest for once.
	icon_state = "soylent_yellow"
	trash = /obj/item/trash/waffles
	filling_color = "#E6FA61"
	list_reagents = list("nutriment" = 10, "vitamin" = 1)
	tastes = list("waffles" = 10)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/monkeysdelight
	name = "monkey's delight"
	desc = "Eeee Eee!"
	icon_state = "monkeysdelight"
	trash = /obj/item/trash/tray
	filling_color = "#5C3C11"
	bitesize = 6
	list_reagents = list("nutriment" = 10, "banana" = 5, "vitamin" = 5)
	tastes = list("banana" = 1, "the jungle" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/dionaroast
	name = "roast diona"
	desc = "It's like an enormous leathery carrot... With an eye."
	icon_state = "dionaroast"
	trash = /obj/item/trash/plate
	filling_color = "#75754B"
	list_reagents = list("plantmatter" = 4, "nutriment" = 2, "radium" = 2, "vitamin" = 4)
	tastes = list("chewy vegetables" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/tofurkey
	name = "tofurkey"
	desc = "A fake turkey made from tofu."
	icon_state = "tofurkey"
	filling_color = "#FFFEE0"
	bitesize = 3
	list_reagents = list("nutriment" = 12, "ether" = 3)
	tastes = list("tofu" = 1)
	foodtype = VEGETABLES


//////////////////////
//		Salads		//
//////////////////////

/obj/item/reagent_containers/food/snacks/aesirsalad
	name = "aesir salad"
	desc = "Probably too incredible for mortal men to fully enjoy."
	icon_state = "aesirsalad"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#468C00"
	bitesize = 3
	list_reagents = list("nutriment" = 8, "omnizine" = 8, "vitamin" = 6)
	tastes = list("divinity" = 1, "lettuce" = 1)
	foodtype = VEGETABLES | FRUIT

/obj/item/reagent_containers/food/snacks/herbsalad
	name = "herb salad"
	desc = "A tasty salad with apples on top."
	icon_state = "herbsalad"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#76B87F"
	bitesize = 3
	list_reagents = list("nutriment" = 8, "vitamin" = 2)
	tastes = list("lettuce" = 1, "apple" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/validsalad
	name = "valid salad"
	desc = "It's just an herb salad with meatballs and fried potato slices. Nothing suspicious about it."
	icon_state = "validsalad"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#76B87F"
	bitesize = 3
	list_reagents = list("nutriment" = 8, "salglu_solution" = 5, "vitamin" = 2)
	tastes = list("fried potato" = 1, "lettuce" = 1, "meat" = 1, "valids" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/oliviersalad
	name = "olivier salad"
	desc = "Don't touch this, its for the New Year!"
	icon_state = "oliviersalad"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#C2CFAB"
	bitesize = 3
	list_reagents = list("nutriment" = 10, "kelotane" = 2, "vitamin" = 3)
	tastes = list("boiled potato" = 1, "pickles" = 1, "carrots" = 1, "egg" = 1, "New Year" = 3)

/obj/item/reagent_containers/food/snacks/vegisalad
	name = "vegetable salad"
	desc = "A perfect combination of tomatoes and cucumbers."
	icon_state = "validsalad"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#C2CFAB"
	bitesize = 3
	list_reagents = list("nutriment" = 4, "kelotane" = 1, "vitamin" = 1)
	tastes = list("tomato" = 2, "cucumber" = 2, "sour cream" = 2)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/weirdoliviersalad
	name = "weird olivier salad"
	desc = "What have you done to this salad, you monster?"
	icon_state = "oliviersalad"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#C2CFAB"
	bitesize = 3
	list_reagents = list("nutriment" = 12, "kelotane" = 2, "vitamin" = 3)
	tastes = list("boiled potato" = 1, "pickles" = 1, "carrots" = 1, "egg" = 1, "weirdness" = 3, "New Year" = 3)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/fruitcup
	name = "Dina's fruit cup"
	desc = "Single salad with edible plate"
	icon_state = "fruitcup"
	filling_color = "#C2CFAB"
	list_reagents = list("nutriment" = 3, "watermelonjuice" = 5, "orangejuice" = 5, "vitamin" = 4)
	tastes = list("apple" = 2, "banana" = 2, "waterlemon" = 2, "lemon" = 1, "ambrosia" = 1)
	bitesize = 4
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/junglesalad
	name = "Jungle salad"
	desc = "From the depths of the jungle."
	icon_state = "junglesalad"
	filling_color = "#C2CFAB"
	list_reagents = list("nutriment" = 6, "watermelonjuice" = 3, "vitamin" = 4)
	tastes = list("apple" = 1, "banana" = 2, "waterlemon" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/delightsalad
	name = "Delight salad"
	desc = "Truly citrus delight."
	icon_state = "delightsalad"
	filling_color = "#C2CFAB"
	trash = /obj/item/trash/snack_bowl
	list_reagents = list("nutriment" = 3, "lemonjuice" = 4, "orangejuice" = 4, "vitamin" = 4, "limejuice" = 4)
	tastes = list("lemon" = 1, "lime" = 2, "orange" = 1)
	bitesize = 4
	foodtype = VEGETABLES

//////////////////////
//	Donk Pockets	//
//////////////////////

/obj/item/reagent_containers/food/snacks/donkpocket
	name = "Donk-pocket"
	desc = "The food of choice for the seasoned traitor."
	icon_state = "donkpocket"
	filling_color = "#DEDEAB"
	list_reagents = list("nutriment" = 4)
	tastes = list("meat" = 2, "dough" = 2, "laziness" = 1)
	foodtype = JUNKFOOD | MEAT | GRAIN

/obj/item/reagent_containers/food/snacks/warmdonkpocket
	name = "warm Donk-pocket"
	desc = "The food of choice for the seasoned traitor."
	icon_state = "donkpocket"
	filling_color = "#DEDEAB"
	list_reagents = list("nutriment" = 4)
	tastes = list("meat" = 2, "dough" = 2, "laziness" = 1)
	foodtype = JUNKFOOD | MEAT | GRAIN

/obj/item/reagent_containers/food/snacks/warmdonkpocket/Post_Consume(mob/living/M)
	M.reagents.add_reagent("omnizine", 15)

/obj/item/reagent_containers/food/snacks/warmdonkpocket_weak
	name = "lukewarm Donk-pocket"
	desc = "The food of choice for the seasoned traitor. This one is lukewarm."
	icon_state = "donkpocket"
	filling_color = "#DEDEAB"
	list_reagents = list("nutriment" = 4, "weak_omnizine" = 3)
	foodtype = JUNKFOOD | MEAT | GRAIN

/obj/item/reagent_containers/food/snacks/syndidonkpocket
	name = "Donk-pocket"
	desc = "This donk-pocket is emitting a small amount of heat."
	icon_state = "donkpocket"
	filling_color = "#DEDEAB"
	bitesize = 100 //nom the whole thing at once.
	list_reagents = list("nutriment" = 1)
	foodtype = JUNKFOOD | MEAT | GRAIN

/obj/item/reagent_containers/food/snacks/syndidonkpocket/Post_Consume(mob/living/M)
	M.reagents.add_reagent("omnizine", 15)
	M.reagents.add_reagent("teporone", 15)
	M.reagents.add_reagent("synaptizine", 15)
	M.reagents.add_reagent("salglu_solution", 15)
	M.reagents.add_reagent("salbutamol", 15)
	M.reagents.add_reagent("methamphetamine", 15)

//////////////////////
//  Buckwheat       //
//////////////////////

/obj/item/reagent_containers/food/snacks/boiledbuckwheat
	name = "boiled buckwheat"
	desc = "'Grechka', or boiled buckwheat. Motherland would be proud of you."
	icon_state = "boiledbuckwheat"
	trash = /obj/item/trash/plate
	filling_color = "#8E633C"
	list_reagents = list("nutriment" = 5, "vitamin" = 1)
	tastes = list("buckwheat" = 1, "motherland" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/buckwheat_merchant
	name = "merchant's buckwheat porridge"
	desc = "Hot and steamy, soviet spies are involved. No doubt."
	icon_state = "buckwheat_merchant"
	trash = /obj/item/trash/plate
	filling_color = "#8E633C"
	list_reagents = list("nutriment" = 5, "protein" = 2, "vitamin" = 3)
	tastes = list("buckwheat" = 2, "meat" = 2, "tomato sause" = 1)
	foodtype = GRAIN | MEAT

//////////////////////
//		Misc		//
//////////////////////

/obj/item/reagent_containers/food/snacks/boiledslimecore
	name = "boiled slime core"
	desc = "A boiled red thing."
	icon_state = "boiledrorocore"
	bitesize = 3
	list_reagents = list("slimejelly" = 5)
	tastes = list("jelly" = 3)
	foodtype = MEAT | TOXIC

/obj/item/reagent_containers/food/snacks/pickles
	name = "pickles"
	desc = "Damn, that's a lot of brined cucumbers."
	icon_state = "pickles"
	trash = /obj/item/reagent_containers/food/snacks/brine
	filling_color = "#C2CFAB"
	bitesize = 8
	list_reagents = list("nutriment" = 2, "vitamin" = 1)
	tastes = list("pickles" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/brine
	name = "brine"
	desc = "For the night after."
	consume_sound = 'sound/items/drink.ogg'
	icon_state = "brine"
	filling_color = "#C2CFAB"
	bitesize = 4
	list_reagents = list("nutriment" = 1, "antihol" = 2)
	tastes = list("brine" = 3)

/obj/item/reagent_containers/food/snacks/popcorn
	name = "popcorn"
	desc = "Now let's find some cinema."
	icon_state = "popcorn"
	trash = /obj/item/trash/popcorn
	var/unpopped = 0
	filling_color = "#FFFAD4"
	bitesize = 0.1 //this snack is supposed to be eating during looooong time. And this it not dinner food! --rastaf0
	list_reagents = list("nutriment" = 2)
	tastes = list("popcorn" = 3, "butter" = 1)
	foodtype = JUNKFOOD | FRIED

/obj/item/reagent_containers/food/snacks/popcorn/New()
	..()
	unpopped = rand(1,10)

/obj/item/reagent_containers/food/snacks/popcorn/On_Consume(mob/M, mob/user)
	if(prob(unpopped))	//lol ...what's the point?
		to_chat(user, "<span class='userdanger'>You bite down on an un-popped kernel!</span>")
		unpopped = max(0, unpopped-1)
	..()

/obj/item/reagent_containers/food/snacks/liquidfood
	name = "\improper LiquidFood ration"
	desc = "A prepackaged grey slurry of all the essential nutrients for a spacefarer on the go. Should this be crunchy?"
	icon_state = "liquidfood"
	trash = /obj/item/trash/liquidfood
	filling_color = "#A8A8A8"
	bitesize = 4
	list_reagents = list("nutriment" = 20, "iron" = 3, "vitamin" = 2)
	foodtype = GROSS
