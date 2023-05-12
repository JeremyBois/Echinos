include <../common/constants.scad>;
include <../component/draw_modes.scad>;
use <../component/shapes2D.scad>;
use <../component/shapes3D.scad>;

//
// Kailh Choc V1 model PG1350 (switch)
// More at
// http://www.kailh.com/en/Products/Ks/CS/319.html
//

// Case
bottomTopWidth = 13.8;
bottomBottomWidth = 11 + 1.8;
bottomHeight = 2.2;
bottomTopHeight = 1.3;
bottomBottomHeight = bottomHeight - bottomTopHeight;
ringWidth = 15.0;
ringHeight = 0.8;
topBottomWidth = bottomTopWidth;
topTopWidth = 11;
topHeight = 5.0 - bottomHeight - ringHeight;

// Stem
sDepth = 3.0;
sHeight = 3.0;
sWidth = 1.2;

// Mounting pins
mPinHeight = 2.65;
mPinPitch = 5.0;
mSidePinDiameter = 1.8;
mCenterPinDiameter = 3.2;
mSidePinHoleDiameter = 1.8; // < 1.9 (datasheet) to get a snug fit
mCenterPinHoleDiameter = 3.4;

// Electrical pins
ePinWidth = 0.75;
ePinDepth = 0.25;
ePinheight = 2.65;
ePinHoleDiameter = 1.2;

// Choc V1 switch 3D model
module PG1350_model(draw_pins = false, bodyColor = "WhiteSmoke",
                    stemColor = "FireBrick") {
  __PG1350(MODEL, draw_pins = draw_pins, bodyColor = bodyColor,
           stemColor = stemColor);
}

// Choc V1 switch PCB footprint
module PG1350_footprint(color = "Red") {
  __PG1350(FOOTPRINT, bodyColor = color);
}

module PG1350_clearance() { __PG1350(CLEARANCE); }

// // Choc V1 switch position where a plate can be added to clip them
// module PG1350_clearance_position() {
//   translate([ 0.0, 0.0, bottomBottomHeight ]) children();
// }

module __PG1350(mode, draw_pins, bodyColor, stemColor) {
  // Top to bottom
  if (mode == FOOTPRINT) {
    color(bodyColor, 0.5) mounting_pins_holes();
    color(bodyColor, 0.5) electrical_pins_holes();
  } else if (mode == CLEARANCE) {
    clearance();
  } else {
    color(stemColor) switch_stems();
    color(bodyColor) {
      switch_top();
      switch_ring();
      switch_bottom();
    }
    if (draw_pins) {
      color(bodyColor) mounting_pins();
      color("Gold") electrical_pins();
    }
  }

  module switch_stems() {
    // Two stems
    sPitch = 5.7 / 2.0;
    sRounding = 0.1;

    // One holder
    holderDepth = 3.0 + 1.2 * 2.0; // 1.2 * 2.0 is an approximation
    holderWidth = 11.0;
    holderHeight = sHeight;

    translate([ 0, 0, ringHeight + topHeight + bottomHeight ]) {
      difference() {
        cube_XY_rounded([ holderWidth, holderDepth, holderHeight ], sRounding);

        translate([ sPitch, 0.0, -TOL / 2.0 ])
            cube_XY_rounded([ sWidth, sDepth, sHeight + TOL ], sRounding);
        translate([ -sPitch, 0.0, -TOL / 2.0 ])
            cube_XY_rounded([ sWidth, sDepth, sHeight + TOL ], sRounding);
      }
      // Switch orientation indicator
      translate([ 0, -holderDepth / 2.0, 0 ])
          cube_XY_rounded([ sDepth, sWidth, sHeight ], sRounding);
    }
  }

  module switch_top() {
    translate([ 0, 0, ringHeight + bottomHeight ]) {
      linear_extrude(topHeight, scale = topTopWidth / topBottomWidth)
          square_rounded([ topBottomWidth, topBottomWidth ], 0.5, true);
    }
  }

  module switch_ring() {
    translate([ 0, 0, bottomHeight ])
        cube_XY_rounded([ ringWidth, ringWidth, ringHeight ], 0.5);
  }

  module switch_bottom() {
    linear_extrude(bottomBottomHeight,
                   scale = bottomTopWidth / bottomBottomWidth)
        square_rounded([ bottomBottomWidth, bottomBottomWidth ], 0.5, true);

    translate([ 0, 0, bottomBottomHeight ]) cube_XY_rounded(
        [ bottomTopWidth, bottomTopWidth, bottomTopHeight ], 0.5);
  }

  module mounting_pins() {
    translate([ 0.0, 0.0, -mPinHeight ]) {
      cylinder(d = mCenterPinDiameter, h = mPinHeight, $fn = 20);
      translate([ -mPinPitch, 0, 0 ])
          cylinder(d = mSidePinDiameter, h = mPinHeight, $fn = 20);
      translate([ mPinPitch, 0, 0 ])
          cylinder(d = mSidePinDiameter, h = mPinHeight, $fn = 20);
    }
  }

  module electrical_pins() {
    translate([ 0.0, 0.0, -ePinheight ]) {
      translate([ 0, -5.9, 0 ]) cube_XY([ ePinWidth, ePinDepth, ePinheight ]);
      translate([ -5.0, -3.8, 0 ])
          cube_XY([ ePinWidth, ePinDepth, ePinheight ]);
    }
  }

  module mounting_pins_holes() {
    translate([ 0.0, 0.0, -mPinHeight - TOL / 2.0 ]) {
      cylinder(d = mCenterPinHoleDiameter, h = mPinHeight + TOL, $fn = 20);
      translate([ -mPinPitch, 0, 0 ])
          cylinder(d = mSidePinHoleDiameter, h = mPinHeight + TOL, $fn = 20);
      translate([ mPinPitch, 0, 0 ])
          cylinder(d = mSidePinHoleDiameter, h = mPinHeight + TOL, $fn = 20);
    }
  }
  module electrical_pins_holes() {
    translate([ 0.0, 0.0, -ePinheight - TOL / 2.0 ]) {
      translate([ 0, -5.9, 0 ])
          cylinder(d = ePinHoleDiameter, h = ePinheight + TOL, $fn = 20);
      translate([ -5.0, -3.8, 0 ])
          cylinder(d = ePinHoleDiameter, h = ePinheight + TOL, $fn = 20);
    }
  }

  module clearance() {
    // Add some tolerance to avoid cutting PCB plate
    translate([ 0, 0.0, TOL / 2.0 ]) cube_XY(
        [
          14.0, 14.0,
          ringHeight + topHeight + sHeight + bottomHeight + TOL / 2.0
        ],
        centerZ = false, $fn = 10);
  }
}

//
// Tests
//

$fn = 20;

PG1350_model(draw_pins = true);

translate([ 25, 0, 0 ]) {
  difference() {
    translate([ -0, -0, -1.6 - TOL ]) cube_XY([ 15, 15, 1.6 ]);
    PG1350_footprint();
  }
}

translate([ 50, 0, 0 ]) {
  PG1350_model(draw_pins = true);
  difference() {
    translate([ -0, -0, -1.6 - TOL ]) cube_XY([ 15, 15, 1.6 ]);
    PG1350_footprint();
  }
}

translate([ 75, 0, 0 ]) {
  PG1350_model(draw_pins = true);
  PG1350_footprint();
}

translate([ 25, 25, 0 ]) {
  difference() {
    plateThickness = 1.3;
    plateHeight = 2.2 - 1.3;
    translate([ 0, 0, plateHeight ])
        cube_XY([ 15, 15, plateThickness ], centerZ = false);
#PG1350_clearance();
  }
}

translate([ 50, 25, 0 ]) {
  difference() {
    plateThickness = 1.3;
    plateHeight = 2.2 - 1.3;
    translate([ 0, 0, plateHeight ])
        cube_XY([ 15, 15, plateThickness ], centerZ = false);
#PG1350_clearance();
  }
  PG1350_model(draw_pins = false);
}
