use <../EVQWGD001.scad>;

include <../../common/constants.scad>;

use <../../primitive/shapes3D.scad>;
use <../../common/test_utils.scad>

$fn = 20;

EVQWGD001_model(centerXY = true);
EVQWGD001_model(centerXY = false);

// Non reversible
__xSpacing(1) {
  difference() {
    translate([ -0, -0, -1.6 - TOL ]) cube_XY([ 20, 20, 1.6 ]);
    EVQWGD001_footprint(reversible = false);
  }
}
__xSpacing(2) {
  EVQWGD001_model(drawPins = true, reversible = false);
  difference() {
    translate([ -0, -0, -1.6 - TOL ]) cube_XY([ 20, 20, 1.6 ]);
    EVQWGD001_footprint(reversible = false);
  }
}
__xSpacing(3) {
  EVQWGD001_model(drawPins = true, reversible = false);
  EVQWGD001_footprint(reversible = false);
}

__xSpacing(4) { EVQWGD001_model(drawPins = false, reversible = false); }

__xSpacing(2) __ySpacing(1) {
  difference() {
    plateThickness = 1.3;
    plateHeight = 2.2 - 1.3;
    translate([ 0, 0, plateHeight ]) // bHeight required to clip a switch
        cube_XY([ 20, 20, plateThickness ], centerZ = false);
#EVQWGD001_clearance();
  }
}

__xSpacing(3) __ySpacing(1) {
  difference() {
    plateThickness = 1.3;
    plateHeight = 2.2 - 1.3;
    translate([ 0, 0, plateHeight ]) // bHeight required to clip a switch
        cube_XY([ 20, 20, plateThickness ], centerZ = false);
#EVQWGD001_clearance();
  }
  EVQWGD001_model(drawPins = false, reversible = false);
}

// Reversible
__xSpacing(-1) {
  difference() {
    translate([ -0, -0, -1.6 - TOL ]) cube_XY([ 20, 20, 1.6 ]);
    EVQWGD001_footprint(reversible = true);
  }
}

__xSpacing(-2) {
  EVQWGD001_model(drawPins = true, reversible = true);
  difference() {
    translate([ -0, -0, -1.6 - TOL ]) cube_XY([ 20, 20, 1.6 ]);
    EVQWGD001_footprint(reversible = true);
  }
}
__xSpacing(-3) {
  EVQWGD001_model(drawPins = true, reversible = true);
  EVQWGD001_footprint(reversible = true);
}

__xSpacing(-4) { EVQWGD001_model(drawPins = false, reversible = true); }
