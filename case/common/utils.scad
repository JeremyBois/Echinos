include <../common/constants.scad>

//
// Misc
//

function print(x) = echo(x) x;
function inch(x) = x * 25.4;
function mm(x) = x;
function cm(x) = x * 10.0;
function m(x) = x * 1000.0;

// A color value where each color is defined in [0, 255]
function rgb(r, g, b, a = 1) = [ r / 255, g / 255, b / 255, a ];

// A random integer value
function randInt(min, max) = round(rands(min, max, 1)[0]);

function clamp(x, min, max) = max(min(x, max), min);

// Linear interpolation between \a and \b
function lerp(a, b, t) = (1 - t) * a + t * b;

// Modulo operator, returns non-negative value range: [0,y)
function mod(x, y) = let(r = x % y) r < 0 ? r + abs(y) : r;

//
// Vector
//

// Convert scalar (x) to 3D vector (x, x, x)
function XXX(x) = [ x, x, x ];

// Convert scalar (y) to 3D vector (0, y, 0)
function _Y_(y) = [ 0.0, y, 0.0 ];

// Convert scalar (z) to 3D vector (0, 0, z)
function __Z(z) = [ 0.0, 0.0, z ];

// Convert scalar (x) to 3D vector (x, 0, 0)
function X__(x) = [ x, 0.0, 0.0 ];

// Convert 2D vector (x, y) to 3D vector (x, x, y)
function XXY(vec2D) = [ vec2D[0], vec2D[0], vec2D[1] ];

// Convert 2D vector (x, y) to 3D vector (x, x, y)
function XY_(vec2D) = [ vec2D[0], vec2D[1], 0.0 ];

// Convert 3D vector (x, y, z) to 2D vector (x, y)
function XY(vec3D) = [ vec3D[0], vec3D[1] ];

// Convert 3D vector (x, y, z) to 2D vector (x, z)
function XZ(vec3D) = [ vec3D[0], vec3D[2] ];

// Convert 3D vector (x, y, z) to 2D vector (y, z)
function YZ(vec3D) = [ vec3D[1], vec3D[2] ];

// Extract X component from 2D/3D vector
function X(vec) = vec[0];

// Extract Y component from 2D/3D vector
function Y(vec) = vec[1];

// Extract Z component from 3D vector
function Z(vec) = vec[2];

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
