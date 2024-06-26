/obj/item/ammo_casing/caseless
	desc = "A caseless bullet casing."
	firing_effect_type = null
	heavy_metal = FALSE

/obj/item/ammo_casing/caseless/fire_casing(atom/target, mob/living/user, params, distro, quiet, zone_override, spread, atom/fired_from)
	. = ..()
	if(.)
		qdel(src)

// Overridden; caseless ammo does not distinguish between "live" and "empty"/"spent" icon states (because it has no casing).
/obj/item/ammo_casing/caseless/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)]"
