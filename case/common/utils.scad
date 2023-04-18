include <constants.scad>

//
// Misc
//

// A color value where each color is defined in [0, 255]
function rgb(r, g, b, a = 1) = [ r / 255, g / 255, b / 255, a ];

// A random integer value
function randInt(min, max) = round(rands(min, max, 1)[0]);

//
// Math
//

// Distance between two 3D vectors
function distance(a, b) = sqrt((a[0] - b[0]) * (a[0] - b[0]) +
                               (a[1] - b[1]) * (a[1] - b[1]) +
                               (a[2] - b[2]) * (a[2] - b[2]));

// Squared length (avoid use of computional intensive sqrt)
function length2(a) = sqrt(a[0] * a[0] + a[1] * a[1]);

// Rotate \angle amount all children around the \pivot point
module rotate_around(angle, pivot) {
  translate(pivot) rotate(angle) translate(-pivot) children();
}

// Normalized version of \a parameter
function normalized(a) = a / (max(distance([ 0, 0, 0 ], a), epsilon));

// Linear interpolation between \a and \b
function lerp(a, b, t) = (1 - t) * a + t * b;

// Modulo operator, returns non-negative value range: [0,y)
function mod(x, y) = let(r = x % y) r < 0 ? r + abs(y) : r;

//
// Dict like accessor
//

/** Dict like accessor
Returns the index in \data where \key matches first
dict = [["name", "Yoshi"], ["size", 2]];
echo(keyLookup(dict, ["name"]) == 0);
\param data Array storing data using a [key, value] syntax
\param key Data assigned key
*/
function keyLookup(data, key) = search(key, data, num_returns_per_match = 1)[0];

/** Dict like getter allowing to retrieve data associated with a
specific key
dict = [["name", "Yoshi"], ["size", 2]];
echo(dataLookup(dict, ["name"]) == "Yoshi");
\param data Array storing data using a [key, value] syntax
\param key Data assigned key
*/
function dataLookup(data, key) =
    data[search(key, data, num_returns_per_match = 1)[0]][1];

// Tests
dict = [ [ "name", "Yoshi" ], [ "size", 2 ] ];
echo(keyLookup(dict, ["name"]) == 0);
echo(dataLookup(dict, ["name"]) == "Yoshi");
