//predominantly positive traits
//this file is named weirdly so that positive traits are listed above negative ones

/datum/quirk/alcohol_tolerance
	name = "Alcohol Tolerance"
	desc = "You become drunk more slowly and suffer fewer drawbacks from alcohol."
	value = 1
	mob_traits = list(TRAIT_ALCOHOL_TOLERANCE)
	gain_text = "<span class='notice'>You feel like you could drink a whole keg!</span>"
	lose_text = "<span class='danger'>You don't feel as resistant to alcohol anymore. Somehow.</span>"
	medical_record_text = "Patient demonstrates a high tolerance for alcohol."

/datum/quirk/apathetic
	name = "Apathetic"
	desc = "You just don't care as much as other people. That's nice to have in a place like this, I guess."
	value = 1
	mood_quirk = TRUE
	medical_record_text = "Patient was administered the Apathy Evaluation Scale but did not bother to complete it."

/datum/quirk/apathetic/add()
	var/datum/component/mood/mood = quirk_holder.GetComponent(/datum/component/mood)
	if(mood)
		mood.mood_modifier -= 0.2

/datum/quirk/apathetic/remove()
	if(quirk_holder)
		var/datum/component/mood/mood = quirk_holder.GetComponent(/datum/component/mood)
		if(mood)
			mood.mood_modifier += 0.2

/datum/quirk/drunkhealing
	name = "Drunken Resilience"
	desc = "Nothing like a good drink to make you feel on top of the world. Whenever you're drunk, you slowly recover from injuries."
	value = 2
	mob_traits = list(TRAIT_DRUNK_HEALING)
	gain_text = "<span class='notice'>You feel like a drink would do you good.</span>"
	lose_text = "<span class='danger'>You no longer feel like drinking would ease your pain.</span>"
	medical_record_text = "Patient has unusually efficient liver metabolism and can slowly regenerate wounds by drinking alcoholic beverages."

/datum/quirk/drunkhealing/on_process(seconds_per_tick)
	var/mob/living/carbon/C = quirk_holder
	// Whitesands Start - Prevent Prosthetic healing from liquor
	switch(C.drunkenness)
		if (6 to 40)
			C.adjustBruteLoss(-0.1*seconds_per_tick, FALSE, FALSE, BODYTYPE_ORGANIC)
			C.adjustFireLoss(-0.05*seconds_per_tick, FALSE, FALSE, BODYTYPE_ORGANIC)
		if (41 to 60)
			C.adjustBruteLoss(-0.4*seconds_per_tick, FALSE, FALSE, BODYTYPE_ORGANIC)
			C.adjustFireLoss(-0.2*seconds_per_tick, FALSE, FALSE, BODYTYPE_ORGANIC)
		if (61 to INFINITY)
			C.adjustBruteLoss(-0.8*seconds_per_tick, FALSE, FALSE, BODYTYPE_ORGANIC)
			C.adjustFireLoss(-0.4*seconds_per_tick, FALSE, FALSE, BODYTYPE_ORGANIC)
	// Whitesands End - Prevent Prosthetic healing from liquor

/datum/quirk/empath
	name = "Empath"
	desc = "Whether it's a sixth sense or careful study of body language, it only takes you a quick glance at someone to understand how they feel."
	value = 2
	mood_quirk = TRUE
	mob_traits = list(TRAIT_EMPATH)
	gain_text = "<span class='notice'>You feel in tune with those around you.</span>"
	lose_text = "<span class='danger'>You feel isolated from others.</span>"
	medical_record_text = "Patient is highly perceptive of and sensitive to social cues, or may possibly have ESP. Further testing needed."

/datum/quirk/fan_rilena
	name = "RILENA Super Fan"
	desc = "You are a major fan of the popular webseries RILENA: LMR. You get a mood boost from plushies of your favorite characters, and wearing your Xader pin."
	value = 1
	mob_traits = list(TRAIT_FAN_RILENA)
	gain_text = "<span class='notice'>You are a huge fan of a certain combination webcomic and bullet hell game.</span>"
	gain_text = "<span class='danger'>Suddenly, bullet hell games and webcomics don't seem all that interesting anymore...</span>"
	medical_record_text = "Patient reports being a huge fan of RILENA."

/datum/quirk/fan_rilena/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/clothing/accessory/rilena_pin/B = new(get_turf(H))
	var/list/slots = list (
		"backpack" = ITEM_SLOT_BACKPACK,
		"hands" = ITEM_SLOT_HANDS,
	)
	H.equip_in_one_of_slots(B, slots , qdel_on_fail = TRUE)
	var/datum/atom_hud/fan = GLOB.huds[DATA_HUD_FAN]
	fan.add_hud_to(H)

/datum/quirk/freerunning
	name = "Freerunning"
	desc = "You're great at quick moves! You can climb tables more quickly."
	value = 2
	mob_traits = list(TRAIT_FREERUNNING)
	gain_text = "<span class='notice'>You feel lithe on your feet!</span>"
	lose_text = "<span class='danger'>You feel clumsy again.</span>"
	medical_record_text = "Patient scored highly on cardio tests."

/datum/quirk/friendly
	name = "Friendly"
	desc = "You give the best hugs, especially when you're in the right mood."
	value = 1
	mob_traits = list(TRAIT_FRIENDLY)
	gain_text = "<span class='notice'>You want to hug someone.</span>"
	lose_text = "<span class='danger'>You no longer feel compelled to hug others.</span>"
	mood_quirk = TRUE
	medical_record_text = "Patient demonstrates low-inhibitions for physical contact and well-developed arms. Requesting another doctor take over this case."

/datum/quirk/jolly
	name = "Jolly"
	desc = "You sometimes just feel happy, for no reason at all."
	value = 1
	mob_traits = list(TRAIT_JOLLY)
	mood_quirk = TRUE
	medical_record_text = "Patient demonstrates constant euthymia irregular for environment. It's a bit much, to be honest."

/datum/quirk/jolly/on_process(seconds_per_tick)
	if(SPT_PROB(0.05, seconds_per_tick))
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "jolly", /datum/mood_event/jolly)

/datum/quirk/light_step
	name = "Light Step"
	desc = "You walk with a gentle step; footsteps and stepping on sharp objects is quieter and less painful. Also, your hands and clothes will not get messed in case of stepping in blood."
	value = 1
	mob_traits = list(TRAIT_LIGHT_STEP)
	gain_text = "<span class='notice'>You walk with a little more litheness.</span>"
	lose_text = "<span class='danger'>You start tromping around like a barbarian.</span>"
	medical_record_text = "Patient's dexterity belies a strong capacity for stealth."

/datum/quirk/light_step/on_spawn()
	var/datum/component/footstep/C = quirk_holder.GetComponent(/datum/component/footstep)
	if(C)
		C.volume *= 0.6
		C.e_range -= 2

/datum/quirk/musician
	name = "Musician"
	desc = "You can tune handheld musical instruments to play melodies that clear certain negative effects and soothe the soul."
	value = 1
	mob_traits = list(TRAIT_MUSICIAN)
	gain_text = "<span class='notice'>You know everything about musical instruments.</span>"
	lose_text = "<span class='danger'>You forget how musical instruments work.</span>"
	medical_record_text = "Patient brain scans show a highly-developed auditory pathway."

/datum/quirk/musician/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/choice_beacon/music/B = new(get_turf(H))
	var/list/slots = list (
		"backpack" = ITEM_SLOT_BACKPACK,
		"hands" = ITEM_SLOT_HANDS,
	)
	H.equip_in_one_of_slots(B, slots , qdel_on_fail = TRUE)

/datum/quirk/night_vision
	name = "Night Vision"
	desc = "You can see slightly more clearly in full darkness than most people."
	value = 1
	mob_traits = list(TRAIT_NIGHT_VISION)
	gain_text = "<span class='notice'>The shadows seem a little less dark.</span>"
	lose_text = "<span class='danger'>Everything seems a little darker.</span>"
	medical_record_text = "Patient's eyes show above-average acclimation to darkness."

/datum/quirk/night_vision/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/organ/eyes/eyes = H.getorgan(/obj/item/organ/eyes)
	if(!eyes || eyes.lighting_alpha)
		return
	eyes.Insert(H) //refresh their eyesight and vision

/datum/quirk/photographer
	name = "Photographer"
	desc = "You carry your camera and personal photo album everywhere you go and can snap photos faster."
	value = 1
	mob_traits = list(TRAIT_PHOTOGRAPHER)
	gain_text = "<span class='notice'>You know everything about photography.</span>"
	lose_text = "<span class='danger'>You forget how photo cameras work.</span>"
	medical_record_text = "Patient mentions photography as a stress-relieving hobby."

/datum/quirk/photographer/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/storage/photo_album/photo_album = new(get_turf(H))
	var/list/album_slots = list (
		"backpack" = ITEM_SLOT_BACKPACK,
		"hands" = ITEM_SLOT_HANDS
	)
	H.equip_in_one_of_slots(photo_album, album_slots , qdel_on_fail = TRUE)
	photo_album.persistence_id = "personal_[H.mind.key]" // this is a persistent album, the ID is tied to the account's key to avoid tampering
	photo_album.persistence_load()
	photo_album.name = "[H.real_name]'s photo album"
	var/obj/item/camera/camera = new(get_turf(H))
	var/list/camera_slots = list (
		"neck" = ITEM_SLOT_NECK,
		"left pocket" = ITEM_SLOT_LPOCKET,
		"right pocket" = ITEM_SLOT_RPOCKET,
		"backpack" = ITEM_SLOT_BACKPACK,
		"hands" = ITEM_SLOT_HANDS
	)
	H.equip_in_one_of_slots(camera, camera_slots , qdel_on_fail = TRUE)
	H.regenerate_icons()

/datum/quirk/selfaware
	name = "Self-Aware"
	desc = "You know your body well, and can accurately assess the extent of your wounds."
	value = 2
	mob_traits = list(TRAIT_SELF_AWARE)
	medical_record_text = "Patient demonstrates an uncanny knack for self-diagnosis."

/datum/quirk/skittish
	name = "Skittish"
	desc = "You can conceal yourself in danger. Ctrl-shift-click a closed locker to jump into it, as long as you have access."
	value = 2
	mob_traits = list(TRAIT_SKITTISH)
	medical_record_text = "Patient demonstrates a high aversion to danger and has described hiding in containers out of fear."


/datum/quirk/tagger
	name = "Tagger"
	desc = "You're an experienced artist. People will actually be impressed by your graffiti, and you can get twice as many uses out of drawing supplies."
	value = 1
	mob_traits = list(TRAIT_TAGGER)
	gain_text = "<span class='notice'>You know how to tag walls efficiently.</span>"
	lose_text = "<span class='danger'>You forget how to tag walls properly.</span>"
	medical_record_text = "Patient was recently seen for possible paint huffing incident."

/datum/quirk/tagger/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/toy/crayon/spraycan/spraycan = new(get_turf(H))
	H.put_in_hands(spraycan)
	H.equip_to_slot(spraycan, ITEM_SLOT_BACKPACK)
	H.regenerate_icons()

/datum/quirk/voracious
	name = "Voracious"
	desc = "Nothing gets between you and your food. You eat faster and can binge on junk food! Being fat suits you just fine."
	value = 1
	mob_traits = list(TRAIT_VORACIOUS)
	gain_text = "<span class='notice'>You feel HONGRY.</span>"
	lose_text = "<span class='danger'>You no longer feel HONGRY.</span>"
