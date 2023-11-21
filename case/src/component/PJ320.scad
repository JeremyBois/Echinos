include <../common/constants.scad>;
include <../component/draw_modes.scad>;
use <../primitive/shapes3D.scad>;

//
// TRRS female connector model PJ-320A (3.5 phone jack)
// More at
// https://www.lcsc.com/product-detail/Audio-Connectors_XKB-Connectivity-PJ-320A_C2884926.html
//

// Case
width = 6.1;
depth = 14.2;
height = 5.0;

// Connector hole
connOuterD = 5.0;
connInnerD = 3.6;
connShift = 2.0;
connDepth = depth - connShift;

// Base
caseSize = [ width, depth - connShift, height ];

// Mounting pins
mPinD = 0.75;
mPinHoleD = 1.2;
mPinHeight = 0.5;
mPinHoleHeight = 1.8; // Same as electrical pins
mPinCoords = [[width / 2.0, 3.6], [width / 2.0, 3.6 + 7.0]];

// Electrical pins
// datasheet --> height == 1.6 (3 pins), height == 1.8 (1 pin)
ePinSize = [ 0.25, 0.75, 1.8 ];
ePinHoleSize = [ 1.0, 1.5, 1.8 ];
ePinCoords = [
  [ 0.9, 5.2 ], [ 0.9, 5.2 + 3.0 ], [ 0.9, 5.2 + 3 + 4 ], [ 6.1 - 1.0, 13.2 ]
];

module PJ320A_model(centerXY = true, drawPins = true,
                    bodyColor = "DarkSlateGray") {
  __PJ320A(MODEL, centerXY = centerXY, drawPins = drawPins,
           bodyColor = bodyColor);
}

module PJ320A_footprint(centerXY = true, color = "Red") {
  __PJ320A(FOOTPRINT, centerXY = centerXY, bodyColor = color);
}

module PJ320A_clearance(centerXY = true) {
  __PJ320A(CLEARANCE, centerXY = centerXY);
}

module __PJ320A(mode, centerXY, drawPins, bodyColor) {
  x = centerXY ? -width / 2.0 : 0.0;
  y = centerXY ? -depth / 2.0 : 0.0;
  translate([ x, y, 0.0 ]) {
    if (mode == FOOTPRINT) {
      color(bodyColor, 0.5) electrical_pins_holes();
      color(bodyColor, 0.5) mounting_pins_holes();
    } else if (mode == CLEARANCE) {
      clearance();
    } else {
      color(bodyColor) difference() {
        base();
        connector_hole();
      }
      color(bodyColor) mounting_pins();
      if (drawPins) {
        color("Gold") electrical_pins();
      }
    }
  }

  module base() {
    union() {
      cube(caseSize);
      translate([ width / 2.0, connShift, height / 2.0 ]) rotate([ -90, 0, 0 ])
          cylinder(d = connOuterD, h = connDepth);
    }
  }

  module connector_hole() {
    translate([ width / 2.0, connShift, height / 2.0 ]) rotate([ -90, 0, 0 ])
        cylinder(d = connInnerD, h = connDepth + TOL);
  }

  module clearance() {
    translate([ 0, -TOL / 2.0, 0.0 ])
        cube([ width, 3.0 * depth + TOL, height ]);
  }

  module electrical_pins() {
    translate([ width, depth, -ePinSize[2] ]) {
      for (coord = ePinCoords) {
        translate(-coord) cube_XY(ePinSize);
      }
    }
  }

  module electrical_pins_holes() {
    translate([ width, depth, -ePinSize[2] ]) {
      for (coord = ePinCoords) {
        translate(-coord)
            oval(height = ePinHoleSize[2], rx = 0.5 * ePinHoleSize[0],
                 ry = 0.5 * ePinHoleSize[1]);
      }
    }
  }

  module mounting_pins() {
    translate([ width, depth, -mPinHeight ]) {
      for (coord = mPinCoords) {
        translate(-coord) cylinder(d = mPinD, h = mPinHeight);
      }
    }
  }

  module mounting_pins_holes() {
    translate([ width, depth, -mPinHoleHeight - TOL / 2.0 ]) {
      for (coord = mPinCoords) {
        translate(-coord) cylinder(d = mPinHoleD, h = mPinHoleHeight + TOL);
      }
    }
  }
}
