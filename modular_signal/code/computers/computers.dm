/obj/machinery/computer/signal_downloader
    name = "Signal Downloading Console"

/obj/machinery/computer/signal_player
	name = "Signal Player Console"

/obj/machinery/computer/signal_processor
	name = "Signal Processing Console"

/obj/machinery/computer/radar
	name = "Radar Console"

/obj/machinery/modular_computer/console/base_management
	name = "Management Computer"

/obj/machinery/computer/satellite_computer
	name = "Computer Terminal"

GLOBAL_LIST_INIT(satellites, GLOB.phonetic_alphabet.Copy())

/obj/machinery/computer/satellite_server
	name = "Server Rack"
	obj_flags = INDESTRUCTIBLE
	var/server_id
	var/download_factor = 1 // How much this affects download speed

/obj/machinery/computer/satellite_server/Initialize(mapload)
	. = ..()
	if(!server_id)
		for(var/option in GLOB.satellites)
			if(!isnull(GLOB.satellites))
				continue
			server_id = option
			break
	else if(!isnull(GLOB.satellites[server_id]))
		stack_trace("Duplicate id satellite server initialized at [COORD(src)], deleting.")
		return INITIALIZE_HINT_QDEL
	GLOB.satellites[server_id] = src
	name = "[initial(name)] ([server_id])"

/obj/machinery/computer/satellite_server/Destroy()
	GLOB.satellites[server_id] = null
	return ..()

GLOBAL_LIST_EMPTY(transformers)
/obj/machinery/power_transformer
	name = "Power Transformer"
	var/id

/obj/machinery/power_transformer/one
	id = "TR_1"

/obj/machinery/power_transformer/two
	id = "TR_2"

/obj/machinery/power_transformer/three
	id = "TR_3"

/obj/machinery/power_transformer/Initialize(mapload)
	. = ..()
	if(!id)
		stack_trace("ID-less transformer initialized at [COORD(src)], deleting.")
		return INITIALIZE_HINT_QDEL
	if(!isnull(GLOB.transformers[id]))
		stack_trace("Duplicate id transformer initialized at [COORD(src)], deleting.")
		return INITIALIZE_HINT_QDEL
	GLOB.transformers[id] = src
	name = "[initial(name)] ([id])"

/obj/machinery/power_transformer/Destroy()
	GLOB.transformers[id] = null
	return ..()

/obj/item/maxwell
	name = "dingus"
	icon = 'modular_signal/icons/obj/items.dmi'
	state = "maxwell"
