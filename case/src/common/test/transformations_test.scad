use <../transformations.scad>
use <../../common/test_utils.scad>

// @TODO
// @TODO Use a shape with concave and convex corners
// @TODO


__xSpacing(1) {
  color("Green", 0.5) square([ 15, 10 ], center = true);

  __ySpacing(0.5) {
    color("Blue", 0.25) square([ 15, 10 ], center = true);
    color("Green", 0.5) inset(4) square([ 15, 10 ], center = true);
  }
  __ySpacing(1) {
    color("Blue", 0.25) square([ 15, 10 ], center = true);
    color("Green", 0.5) outset(4) square([ 15, 10 ], center = true);
  }
  __ySpacing(1.5) {
    color("Blue", 0.25) square([ 15, 10 ], center = true);
    color("Green", 0.5) chamfer(4) square([ 15, 10 ], center = true);
  }

  __ySpacing(2) {
    color("Blue", 0.25) square([ 15, 10 ], center = true);
    color("Green", 0.5) inset(4) outset(4) square([ 15, 10 ], center = true);
  }
}
