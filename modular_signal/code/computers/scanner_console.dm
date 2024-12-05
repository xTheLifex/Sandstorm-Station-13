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
