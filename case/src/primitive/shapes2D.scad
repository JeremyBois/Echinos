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

// A square with rounded corners (offset version)
module square_rounded(size = [ 1.0, 1.0 ], r = 0, center = false,
                      use_chamfer = false) {
  x = is_list(size) ? size[0] : size;
  y = is_list(size) ? size[1] : size;

  if (r <= min(x, y)) {
    // square_rounded will produce an empty shape so use alternative implementation
    square_rounded_alt(size, r, center);
  } else {

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
}

// A square with rounded corners (hull version)
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
