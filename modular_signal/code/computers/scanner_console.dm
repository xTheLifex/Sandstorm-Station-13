/obj/machinery/computer/signal_scanner
	name = "Signal Scanner Console"

/obj/machinery/computer/signal_scanner/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "SignalScanner")
		ui.open()

/obj/machinery/computer/signal_scanner/ui_data(mob/user)
	var/list/data = list()
	data["name"] = name
	return data

/obj/machinery/computer/signal_scanner/ui_act(action, params)
	if(..())
		return
	switch(action)
		if("the_funny")
			to_chat(world, params["var"]) // for debugging reasons, obviously don't let this go anywhere
			. = TRUE

/obj/machinery/computer/signal_scanner/ui_assets(mob/user)
	. = ..()
	. += get_asset_datum(/datum/asset/simple/signal_scanner_assets)

/datum/asset/simple/signal_scanner_assets
	assets = list(
		"grid_background.png" = 'icons/ui_icons/tgui/grid_background.png'
		"ntosradar_pointer_S.png" = 'icons/ui_icons/tgui/ntosradar_point_S.png'
	)

