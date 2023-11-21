use <../PJ320.scad>;

include <../../common/constants.scad>;

use <../../primitive/shapes3D.scad>;
use <../../common/test_utils.scad>

$fn = 20;

PJ320A_model(centerXY = true);
PJ320A_model(centerXY = false);

__xSpacing(1) {
  difference() {
    translate([ -0, -0, -1.6 - TOL ]) cube_XY([ 16, 16, 1.6 ]);
    PJ320A_footprint();
  }
}

__xSpacing(2) {
  PJ320A_model(drawPins = true);
  difference() {
    translate([ -0, -0, -1.6 - TOL ]) cube_XY([ 16, 16, 1.6 ]);
    PJ320A_footprint();
  }
}

__xSpacing(3) {
  PJ320A_model(drawPins = true);
  PJ320A_footprint();
}

__xSpacing(4) { PJ320A_model(drawPins = false); }

__xSpacing(2) __ySpacing(1) {
  difference() {
    plateThickness = 1.3;
    plateHeight = 2.2 - 1.3;
    translate([ 0, 0, plateHeight ])
        cube_XY([ 16, 16, plateThickness ], centerZ = false);
#PJ320A_clearance();
  }
}

__xSpacing(3) __ySpacing(1) {
  difference() {
    plateThickness = 1.3;
    plateHeight = 2.2 - 1.3;
    translate([ 0, 0, plateHeight ])
        cube_XY([ 16, 16, plateThickness ], centerZ = false);
#PJ320A_clearance();
  }
  PJ320A_model(drawPins = false);
}
