/* -------------------------------------------------------------------------- */
/*                                   Defines                                  */
/* -------------------------------------------------------------------------- */

/* ------------- Classification for Polarity and Signal Quality ------------- */

#define SIGNAL_VERY_LOW "very_low"
#define SIGNAL_LOW "low"
#define SIGNAL_MEDIUM "medium"
#define SIGNAL_HIGH "high"
#define SIGNAL_UNKNOWN "unknown"

/* ---------------------------- Signal Processing --------------------------- */

/// Signal Processing Level 0
#define SIGNAL_PRICE_UNPROCESSED 5
/// Signal Processing Level 1
#define SIGNAL_PRICE_PROCESSED_1 10
/// Signal Processing Level 2
#define SIGNAL_PRICE_PROCESSED_2 15
/// Signal Processing Level 3
#define SIGNAL_PRICE_PROCESSED_3 30

#define SIGNAL_DIRECTION_LEFT 0
#define SIGNAL_DIRECTION_RIGHT 1
#define SIGNAL_DIRECTION_MIDDLE 2

/* ------------------------ Signal Object Definition ------------------------ */

#define SIGNAL_OBJECT_TYPE_UNKNOWN "unknown"
#define SIGNAL_OBJECT_TYPE_OBJECT "object"
#define SIGNAL_OBJECT_TYPE_GAS_GIANT "gas_giant"
#define SIGNAL_OBJECT_TYPE_RED_GIANT "red_giant"
#define SIGNAL_OBJECT_TYPE_PLANET "planet"
#define SIGNAL_OBJECT_TYPE_ASTEROID "asteroid"
#define SIGNAL_OBJECT_TYPE_BLACK_HOLE "black_hole"
#define SIGNAL_OBJECT_TYPE_COMET "comet"
#define SIGNAL_OBJECT_TYPE_EXOPLANET "exoplanet"
#define SIGNAL_OBJECT_TYPE_BROWN_DWARF "brown_dwarf"
#define SIGNAL_OBJECT_TYPE_WHITE_DWARF "white_dwarf"


/* -------------------------------------------------------------------------- */
/*                                  Basetype                                  */
/* -------------------------------------------------------------------------- */

/datum/votv_signal
	/* ----------------------------- Signal Identity ---------------------------- */
	/// Internal ID of this signal. Should be unique.
	var/id
	/// The image of the object / planet that transmits the signal
	var/image/object_image
	/// The images contained in the signal transmitted from the object for each processing level (0-3)
	var/list/signal_images
	/// The audio that plays for each processing level (0-3)
	var/list/signal_audios
	/// The text data, if any.
	var/text = "\[NO_TEXT_DATA_DETECTED\]"
	/// Size in MB.
	var/size = 1
	/// The type of object. (e.g: gas_giant, planet, dwarf_planet, asteroid, unknown)
	var/object_type = SIGNAL_OBJECT_TYPE_UNKNOWN
	/// The signal quality displayed. This doesnt affect the real download speed. For that, change the internal parameter instead.
	var/display_quality = SIGNAL_UNKNOWN
	/// Similar to signal_quality, it's a display string only.
	var/display_frequency = SIGNAL_UNKNOWN
	/// The % chance of this signal to show up. Should be very low. (e.g: 0.012%)
	var/signal_chance = 0

	/* --------------------------- Internal Parameters -------------------------- */
	/// Should this signal only show up once?
	var/unique = FALSE
	/// How fast this signal should download, in %
	var/download_speed = 1
	/// Contains the values for each level of processing when sold.
	var/values = list(SIGNAL_PRICE_UNPROCESSED, SIGNAL_PRICE_PROCESSED_1, SIGNAL_PRICE_PROCESSED_2, SIGNAL_PRICE_PROCESSED_3)

	/// Signal polarity to be matched together with direction, in order to download.
	var/polarity
	/// Signal frequency to be matched in order to download
	var/frequency
	/// Polarity's direction (left, right, middle)
	var/direction


/datum/votv_signal/New()
	. = ..()
	if (!direction)
		direction = pick(SIGNAL_DIRECTION_LEFT, SIGNAL_DIRECTION_RIGHT, SIGNAL_DIRECTION_MIDDLE)
	if (!polarity)
		polarity = rand(0, 359)
	if (!frequency)
		switch(display_frequency)
			if (SIGNAL_VERY_LOW)
				frequency = rand(0, 100)
			if (SIGNAL_LOW)
				frequency = rand(101, 300)
			if (SIGNAL_MEDIUM)
				frequency = rand(301, 500)
			if (SIGNAL_HIGH)
				frequency = rand(501, 800)
			if (SIGNAL_UNKNOWN)
				frequency = rand(0, 1000)
