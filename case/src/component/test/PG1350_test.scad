use <../PG1350.scad>;
include <../../common/constants.scad>;

use <../../primitive/shapes3D.scad>;
use <../../common/test_utils.scad>

$fn = 20;

PG1350_model(centerXY = true);
PG1350_model(centerXY = false);

__xSpacing(1) {
  difference() {
    translate([ -0, -0, -1.6 - TOL ]) cube_XY([ 15, 15, 1.6 ]);
    PG1350_footprint();
  }
}

__xSpacing(2) {
  PG1350_model(drawPins = true);
  difference() {
    translate([ -0, -0, -1.6 - TOL ]) cube_XY([ 15, 15, 1.6 ]);
    PG1350_footprint();
  }
}

__xSpacing(3) {
  PG1350_model(drawPins = true);
  PG1350_footprint();
}

__xSpacing(4) { PG1350_model(drawPins = false); }

__xSpacing(2) __ySpacing(1) {
  difference() {
    plateThickness = 1.3;
    plateHeight = 2.2 - 1.3;
    translate([ 0, 0, plateHeight ])
        cube_XY([ 15, 15, plateThickness ], centerZ = false);
#PG1350_clearance();
  }
}

__xSpacing(3) __ySpacing(1) {
  difference() {
    plateThickness = 1.3;
    plateHeight = 2.2 - 1.3;
    translate([ 0, 0, plateHeight ])
        cube_XY([ 15, 15, plateThickness ], centerZ = false);
#PG1350_clearance();
  }
  PG1350_model(drawPins = false);
}
