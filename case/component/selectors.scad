use <../common/dictionnary.scad>;
use <../component/draw_modes.scad>;

//
// Enum like implementation
//

DRAWER = [[MODEL, 0], [FOOTPRINT, 1], [CUTOUT, 2]];

///
/// @brief      Check if user provide draw mode name is valid.
///
function is_draw_mode(name) = keyLookup(DRAWER, [name]) != [];

///
/// @brief      Retrieve draw mode index from draw mode name.
///
function draw_mode_index(name) = dataLookup(DRAWER, [name]);

///
/// @brief      Retrieve draw mode name from draw mode index.
///
function draw_mode_name(index) = retrieveKey(DRAWER, [index]);

//
// Tests
//

// is_draw_mode
echo(is_draw_mode(MODEL));
echo(is_draw_mode(FOOTPRINT));
echo(is_draw_mode(CUTOUT));
echo(is_draw_mode("Oups") != true);

// draw_mode_index
echo(draw_mode_index(MODEL) == 0);
echo(draw_mode_index(FOOTPRINT) == 1);
echo(draw_mode_index(CUTOUT) == 2);

// draw_mode_name
echo(draw_mode_name(0) == MODEL);
echo(draw_mode_name(1) == FOOTPRINT);
echo(draw_mode_name(2) == CUTOUT);
