include <../common/constants.scad>;
include <../component/draw_modes.scad>;
include <../component/pins_database.scad>;
use <../common/distributions.scad>
use <../common/utils.scad>;
use <../component/pins.scad>;
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

module RP2040_zero_model(centerXY = true, socket, drawPins = true,
                         bodyColor = "Silver") {
  RP2040_zero(MODEL, centerXY = centerXY, socket = socket, drawPins = drawPins,
              bodyColor = bodyColor);
}

module RP2040_zero_footprint(centerXY = true, socket, color = "Red") {
  RP2040_zero(FOOTPRINT, centerXY = centerXY, socket = socket,
              bodyColor = color);
}

module RP2040_zero_clearance(centerXY = true, socket) {
  RP2040_zero(CLEARANCE, centerXY = centerXY, socket = socket);
}

module RP2040_zero_pins_layout(centerXY) {
  x = centerXY ? -bWidth / 2.0 : 0.0;
  y = centerXY ? -bDepth / 2.0 : 0.0;
  translate([ x, y, 0.0 ]) {
    translate(pinShiftDepth) on_line(9, pitch, axis = forward) children();
    translate([ bWidth - X(pinShiftDepth), Y(pinShiftDepth) ])
        on_line(9, pitch, axis = forward) children();
    translate(pinShiftWidth) on_line(5, pitch, axis = right) children();
  }
}

module RP2040_zero(mode, centerXY, socket, drawPins, bodyColor) {
  x = centerXY ? -bWidth / 2.0 : 0.0;
  y = centerXY ? -bDepth / 2.0 : 0.0;
  socketHeight = is_undef(socket) ? -1.0 : dataLookup(socket, ["height"]);
  translate([ x, y, 0.0 ]) {
    if (socketHeight > 0.0) {
      // Socketed MCU board
      if (mode == FOOTPRINT) {
        RP2040_zero_pins_layout(centerXY = false) {
          header_female_footprint(socket);
        }
      } else if (mode == CLEARANCE) {
        clearance(socketHeight);
      } else {
        RP2040_zero_pins_layout(centerXY = false) {
          header_female_model(socket, drawPins = drawPins);
        }
        translate([ 0, 0, socketHeight ]) color(bodyColor) base();
      }
    } else {
      // Raw MCU board
      if (mode == FOOTPRINT) {
      } else if (mode == CLEARANCE) {
        clearance(0.0);
      } else {
        color(bodyColor) base();
      }
    }
  }

  module base() {
    translate([ 0.0, 0.0, bHeight ])
        import("../models/RP2040_Zero.stl", center = false);
  }

  module clearance(socketHeight) {
    translate([ 0.0, 0.0, -TOL / 2.0 ]) {
      // PCB
      cube([ bWidth, bDepth, socketHeight + bHeight + TOL ]);

      // USB
      // translate(_Y_(Y(usbCoord))) cube([ bWidth, usbDepth, socketHeight +
      // usbHeight + TOL ]);
      translate(usbCoord)
          cube([ usbWidth, usbDepth, socketHeight + usbHeight + TOL ]);

      translate([ 0.0, 0.0, socketHeight ]) {
        // USB Connector
        translate(usbCoord) cube([ usbWidth, usbDepth * 3, usbHeight + TOL ]);

        // Switches
        translate(switchCoord)
            cube([ switchWidth, switchDepth, switchHeight + TOL ]);
      }
    }
  }
}

//
// Tests
//

$fn = 20;
include<../common/test_utils.scad>

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
