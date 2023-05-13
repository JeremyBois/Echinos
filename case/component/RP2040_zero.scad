include <../common/constants.scad>;
include <../component/draw_modes.scad>;
use <../component/shapes3D.scad>;

//
// Waveshare MCU Board RP2040 zero (Pico-like MCU Board)
// More at
// https://www.waveshare.com/rp2040-zero.htm
//

// PCB
bWidth = 18;
bDepth = 23.5;
bHeight = 1.1;
// Pins holes
pitch = 2.54;
pinShiftDepth = [ 1.38, 1.59 ];
pinShiftWidth = [ 3.92, 1.59 ];

// USB
usbCoord = [ 4.67, bDepth - 6.25, bHeight ];
usbWidth = bWidth - 2 * usbCoord[0];
usbDepth = 7.6;
usbHeight = 3.2;

// Switches
switchCoord = [ 0.0, pitch * 2, bHeight ];
switchWidth = bWidth;
switchDepth = pitch * 2;
switchHeight = 3;

module RP2040_zero_model(centerY = true, bodyColor = "SteelBlue") {
  __RP2040_zero(MODEL, centerY = centerY, bodyColor = bodyColor);
}

module RP2040_zero_footprint(centerY = true, color = "Red") {
  __RP2040_zero(FOOTPRINT, centerY = centerY, bodyColor = color);
}

module RP2040_zero_clearance(centerY = true) {
  __RP2040_zero(CLEARANCE, centerY = centerY);
}

module __RP2040_zero(mode, centerY, bodyColor) {
  x = -bWidth / 2.0;
  y = centerY ? -bDepth / 2.0 : 0.0;
  translate([ x, y, 0.0 ]) {
    if (mode == FOOTPRINT) {
    } else if (mode == CLEARANCE) {
      clearance();
    } else {
      color(bodyColor) base();
    }
  }

  module base() {
    translate([ 0.0, 0.0, bHeight ])
        import("../models/RP2040_Zero.stl", center = false);
  }

  module clearance() {
    translate([ 0.0, 0.0, -TOL / 2.0 ]) {
      // PCB
      cube([ bWidth, bDepth, bHeight + TOL ]);

      // USB
      translate(usbCoord) cube([ usbWidth, usbDepth * 3, usbHeight + TOL ]);

      // Switches
      translate(switchCoord)
          cube([ switchWidth, switchDepth, switchHeight + TOL ]);
    }
  }
}

//
// Tests
//

include <../common/test_utils.scad>
$fn = 20;

RP2040_zero_model();

__xSpacing(0) {
  difference() {
    translate([ -0, -0, -1.6 - TOL ]) cube_XY([ 30, 30, 1.6 ]);
    RP2040_zero_footprint();
  }
}

__xSpacing(1) {
  RP2040_zero_model();
  difference() {
    translate([ -0, -0, -1.6 - TOL ]) cube_XY([ 30, 30, 1.6 ]);
    RP2040_zero_footprint();
  }
}

__xSpacing(2) {
  RP2040_zero_model();
  RP2040_zero_footprint();
}

__xSpacing(1) __ySpacing(1) {
  difference() {
    plateThickness = 1.3;
    plateHeight = 2.2 - 1.3;
    translate([ 0, 0, plateHeight ])
        cube_XY([ 30, 30, plateThickness ], centerZ = false);
#RP2040_zero_clearance();
  }
}

__xSpacing(2) __ySpacing(1) {
  difference() {
    plateThickness = 1.3;
    plateHeight = 2.2 - 1.3;
    translate([ 0, 0, plateHeight ])
        cube_XY([ 30, 30, plateThickness ], centerZ = false);
#RP2040_zero_clearance();
  }
  RP2040_zero_model();
}
