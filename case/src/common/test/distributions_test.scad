use <../distributions.scad>

include <../../common/constants.scad>;
use <../../common/test_utils.scad>

__xSpacing(0, 500) {
  rotate([ 0, 0, -8 ]) {
    on_line(count = 22, spacing = 25, offset = 0, center = false) {
      square(14, center = true);
    }
    place_on_line(i = 2, count = 22, spacing = 25, offset = 0, center = false) {
      translate([ 25, 0, 0 ]) color("FireBrick", 1) circle(15);
    }
  }
}

__xSpacing(1, 500) {
  on_arc(count = 10, spacing = 30, rotation = 25, offset = 0, clockwise = false,
         center = false, spin = true) {
    square(14, center = true);
  }

  place_on_arc(i = 4, spacing = 30, rotation = 25, offset = 0,
               clockwise = false, center = false, spin = false) {
    translate([ 0, 30, 0 ]) color("FireBrick", 1) circle(15);
  }
}

__xSpacing(0.5, 500) {
  spin(4, 45, up) { square(14, center = true); }
}

__xSpacing(-1, 500) {
  {
    on_snail(count = 300, spacingStart = 5, spacingEnd = 40, rotation = 5,
             clockwise = false, center = false) {
      linear_extrude(height = 40, scale = 0.1) square(14, center = true);
    }
  }
}
