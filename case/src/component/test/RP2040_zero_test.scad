use <../RP2040_zero.scad>;

include <../../common/constants.scad>;
include <../../component/pins_database.scad>;

use <../../common/dictionnary.scad>;
use <../../primitive/shapes3D.scad>;
use <../../common/test_utils.scad>


$fn = 20;

female_low_254 = dataLookup(header_data, ["header254_femaleLow"]);

__xSpacing(0) {
  RP2040_zero_model(centerXY = true, socket = undef);
  RP2040_zero_model(centerXY = false, socket = undef);

  __ySpacing(1) {
    RP2040_zero_model(centerXY = true, socket = female_low_254);
    RP2040_zero_model(centerXY = false, socket = female_low_254);
  }
}

//
// On surface
//
__xSpacing(1) {
  difference() {
    translate([ -0, -0, -1.6 - TOL ]) cube_XY([ 30, 30, 1.6 ]);
    RP2040_zero_footprint(centerXY = true, socket = undef);
  }
}

__xSpacing(2) {
  RP2040_zero_model(centerXY = true, socket = undef);
  difference() {
    translate([ -0, -0, -1.6 - TOL ]) cube_XY([ 30, 30, 1.6 ]);
    RP2040_zero_footprint(centerXY = true, socket = undef);
  }
}

__xSpacing(3) {
  RP2040_zero_model(centerXY = true, socket = undef);
  RP2040_zero_footprint(centerXY = true, socket = undef);
}

__xSpacing(4) {
  RP2040_zero_model(centerXY = true, socket = undef, drawPins = false);
}

__xSpacing(2) __ySpacing(1) {
  difference() {
    plateThickness = 1.3;
    plateHeight = 2.2 - 1.3;
    translate([ 0, 0, plateHeight ])
        cube_XY([ 30, 30, plateThickness ], centerZ = false);
#RP2040_zero_clearance(centerXY = true, socket = undef);
  }
}

__xSpacing(3) __ySpacing(1) {
  difference() {
    plateThickness = 1.3;
    plateHeight = 2.2 - 1.3;
    translate([ 0, 0, plateHeight ])
        cube_XY([ 30, 30, plateThickness ], centerZ = false);
#RP2040_zero_clearance(centerXY = true, socket = undef);
  }
  RP2040_zero_model(centerXY = true, socket = undef);
}

//
// Socketed board
//

__xSpacing(-1) {
  difference() {
    translate([ -0, -0, -1.6 - TOL ]) cube_XY([ 30, 30, 1.6 ]);
    RP2040_zero_footprint(centerXY = true, socket = female_low_254);
  }
}

__xSpacing(-2) {
  RP2040_zero_model(centerXY = true, socket = female_low_254);
  difference() {
    translate([ -0, -0, -1.6 - TOL ]) cube_XY([ 30, 30, 1.6 ]);
    RP2040_zero_footprint(centerXY = true, socket = female_low_254);
  }
}

__xSpacing(-3) {
  RP2040_zero_model(centerXY = true, socket = female_low_254);
  RP2040_zero_footprint(centerXY = true, socket = female_low_254);
}

__xSpacing(-4) {
  RP2040_zero_model(centerXY = true, socket = female_low_254, drawPins = false);
}

__xSpacing(-2) __ySpacing(1) {
  difference() {
    plateThickness = 1.3;
    plateHeight = 2.2 - 1.3;
    translate([ 0, 0, plateHeight ])
        cube_XY([ 30, 30, plateThickness ], centerZ = false);
#RP2040_zero_clearance(socket = female_low_254);
  }
}

__xSpacing(-3) __ySpacing(1) {
  difference() {
    plateThickness = 1.3;
    plateHeight = 2.2 - 1.3;
    translate([ 0, 0, plateHeight ])
        cube_XY([ 30, 30, plateThickness ], centerZ = false);
#RP2040_zero_clearance(socket = female_low_254);
  }
  RP2040_zero_model(centerXY = true, socket = female_low_254);
}
