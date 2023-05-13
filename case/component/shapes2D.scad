include <../common/constants.scad>
use <../common/transformations.scad>

//
// 2D Shapes
//

// @TODO
// square_rounded_alt should be used as fallback when radius <= min(x, y)
// because square_rounded will produce an empty shape
// @TODO

// Irregular circle (Y axis scaled)
module ellipse(width, depth) {
  scale([ 1, depth / width, 1 ]) circle(r = width / 2);
}

module square_rounded(size = [ 1.0, 1.0 ], r = 0, center = false,
                      use_chamfer = false) {
  x = is_list(size) ? size[0] : size;
  y = is_list(size) ? size[1] : size;

  if (r != 0) {
    if (use_chamfer) {
      chamfer(r = r) square(size, center = center);
    } else {
      outset(r = r) square(size, center = center);
    }
  } else {
    square(size, center = center);
  }
}
// A square with rounded corners
module square_rounded_alt(size = [ 1.0, 1.0 ], r = 1.0, center = false) {
  x = is_list(size) ? size[0] : size;
  y = is_list(size) ? size[1] : size;

  if (center) {
    body();
  } else {
    translate([ x, y ] / 2) body();
  }

  module body() {
    hull() {
      // Put circle on each corner
      translate([ (-x / 2) + r, (-y / 2) + r ]) { circle(r = r); }
      translate([ (x / 2) - r, (-y / 2) + r ]) { circle(r = r); }
      translate([ (-x / 2) + r, (y / 2) - r ]) { circle(r = r); }
      translate([ (x / 2) - r, (y / 2) - r ]) { circle(r = r); }
    }
  }
}

module square_rounded_one(size, r, center = false) {
  h = is_list(size) ? size.y : size;
  w = is_list(size) ? size.x : size;
  translate(center ? [ -w, -h ] / 2 : [ 0, 0 ]) hull() {
    intersection() {
      translate([ w - r, h - r ]) circle(r = r);
      square([ w, h ]);
    }
    square([ w, EPS ]);
    square([ EPS, h ]);
  }
}

//
// Tests
//

include <../common/test_utils.scad>
$fn = 20;

// Ellipses
__xSpacing(0) { ellipse(10, 50); }

// Squares
__xSpacing(1) {
  color("Green", 0.5) square([ 15, 10 ], center = true);
  square_rounded_one([ 15, 10 ], 4, center = true);

  __ySpacing(1) {
    color("Green", 0.5) square([ 15, 10 ], center = false);
    square_rounded_one([ 15, 10 ], 4, center = false);
  }
}

__xSpacing(2) {
  color("Green", 0.5) square([ 15, 10 ], center = true);
  square_rounded([ 15, 10 ], 4, center = true);

  __ySpacing(1) {
    color("Green", 0.5) square([ 15, 10 ], center = false);
    square_rounded([ 15, 10 ], 4, center = false);
  }

  __ySpacing(2) {
    color("Green", 0.5) square([ 15, 10 ], center = false);
    square_rounded([ 15, 10 ], 4, center = false, use_chamfer = true);
  }
}
