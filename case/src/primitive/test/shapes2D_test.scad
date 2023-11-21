use <../shapes2D.scad>
use <../../common/test_utils.scad>

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
