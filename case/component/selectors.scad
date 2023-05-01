use <../common/dictionnary.scad>;

//
// Enum like implementation
//

SHAPE_KIND = [ [ "Model", 0 ], [ "Footprint", 1 ], [ "Cutout", 2 ] ];

///
/// @brief      Check if user provide name is valid.
///
function is_draw_kind(name) = keyLookup(SHAPE_KIND, [name]) != [];

///
/// @brief      Retrieve kind index from kind name.
///
function draw_kind_index(name) = dataLookup(SHAPE_KIND, [name]);

///
/// @brief      Retrieve kind name from kind index.
///
function draw_kind_name(index) = retrieveKey(SHAPE_KIND, [index]);

//
// Tests
//

// is_draw_kind
echo(is_draw_kind("Model"));
echo(is_draw_kind("Footprint"));
echo(is_draw_kind("Cutout"));
echo(is_draw_kind("Oups") != true);

// draw_kind_index
echo(draw_kind_index("Model") == 0);
echo(draw_kind_index("Footprint") == 1);
echo(draw_kind_index("Cutout") == 2);

// draw_kind_name
echo(draw_kind_name(0) == "Model");
echo(draw_kind_name(1) == "Footprint");
echo(draw_kind_name(2) == "Cutout");
