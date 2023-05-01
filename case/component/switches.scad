include <../common/constants.scad>;
use <../component/shapes2D.scad>;
use <../component/shapes3D.scad>;

//
// Kailh Choc V1 (PG1350)
//

// Choc V1 switch 3D model
module switch_choc_3D(draw_pins = false) {
  switch_choc(footprint = false, draw_pins = draw_pins, stemColor = "FireBrick",
              bodyColor = "WhiteSmoke");
}

// Choc V1 switch PCB footprint
module switch_choc_footprint() {
  switch_choc(footprint = true, bodyColor = "Red");
}

// Choc V1 switch cutout (space that should be available on top)
module switch_choc_cutout(plateThickness, plateHeight) {
  translate([ 0, 0, plateHeight - (TOL / 2.0) ])
      cube_XY([ 14.0, 14.0, plateThickness + TOL ], center = false, $fn = 10);
}

// Choc V1 switch position where a plate can be added to clip them
module switch_choc_cutout_position() {
  bottomHeight = 2.2;
  bottomTopHeight = 1.3;
  bottomBottomHeight = bottomHeight - bottomTopHeight;
  translate([ -0, -0, bottomBottomHeight ]) children();
}

// Choc V1 switch
module switch_choc(footprint, draw_pins, bodyColor, stemColor) {
  // Based on http://www.kailh.com/en/Products/Ks/CS/319.html
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

  module switch_stems() {
    // Two stems
    sDepth = 3.0;
    sHeight = 3.0;
    sWidth = 1.2;
    sPitch = 5.7 / 2.0;
    sRounding = 0.1;

    // One holder
    holderDepth = 3.0 + 1.2 * 2.0; // 1.2 * 2.0 is an approximation
    holderWidth = 11.0;
    holderHeight = sHeight;

    color(stemColor)
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
    color(bodyColor) translate([ 0, 0, ringHeight + bottomHeight ]) {
      linear_extrude(topHeight, scale = topTopWidth / topBottomWidth)
          square_rounded([ topBottomWidth, topBottomWidth ], 0.5, true);
    }
  }

  module switch_ring() {
    color(bodyColor) translate([ 0, 0, bottomHeight ])
        cube_XY_rounded([ ringWidth, ringWidth, ringHeight ], 0.5);
  }

  module switch_bottom() {
    color(bodyColor) {
      linear_extrude(bottomBottomHeight,
                     scale = bottomTopWidth / bottomBottomWidth)
          square_rounded([ bottomBottomWidth, bottomBottomWidth ], 0.5, true);

      translate([ 0, 0, bottomBottomHeight ]) cube_XY_rounded(
          [ bottomTopWidth, bottomTopWidth, bottomTopHeight ], 0.5);
    }
  }

  module mounting_pins() {
    color(bodyColor) translate([ 0.0, 0.0, -mPinHeight ]) {
      cylinder(d = mCenterPinDiameter, h = mPinHeight, $fn = 20);
      translate([ -mPinPitch, 0, 0 ])
          cylinder(d = mSidePinDiameter, h = mPinHeight, $fn = 20);
      translate([ mPinPitch, 0, 0 ])
          cylinder(d = mSidePinDiameter, h = mPinHeight, $fn = 20);
    }
  }

  module electrical_pins() {
    color("Gold") translate([ 0.0, 0.0, -ePinheight ]) {
      translate([ 0, -5.9, 0 ]) cube_XY([ ePinWidth, ePinDepth, ePinheight ]);
      translate([ -5.0, -3.8, 0 ])
          cube_XY([ ePinWidth, ePinDepth, ePinheight ]);
    }
  }

  module mounting_pins_holes() {
    color(bodyColor, 0.5) translate([ 0.0, 0.0, -mPinHeight - TOL / 2.0 ]) {
      cylinder(d = mCenterPinHoleDiameter, h = mPinHeight + TOL, $fn = 20);
      translate([ -mPinPitch, 0, 0 ])
          cylinder(d = mSidePinHoleDiameter, h = mPinHeight + TOL, $fn = 20);
      translate([ mPinPitch, 0, 0 ])
          cylinder(d = mSidePinHoleDiameter, h = mPinHeight + TOL, $fn = 20);
    }
  }
  module electrical_pins_holes() {
    color(bodyColor, 0.5) translate([ 0.0, 0.0, -ePinheight - TOL / 2.0 ]) {
      translate([ 0, -5.9, 0 ])
          cylinder(d = ePinHoleDiameter, h = ePinheight + TOL, $fn = 20);
      translate([ -5.0, -3.8, 0 ])
          cylinder(d = ePinHoleDiameter, h = ePinheight + TOL, $fn = 20);
    }
  }

  // Top to bottom
  if (footprint) {
    mounting_pins_holes();
    electrical_pins_holes();
  } else {
    switch_stems();
    switch_top();
    switch_ring();
    switch_bottom();
    if (draw_pins) {
      mounting_pins();
      electrical_pins();
    }
  }
}

//
// MX
//

// A simple placeholder of an MX switch
module switch_MX(stemColor = "FireBrick", bodyColor = "WhiteSmoke") {

  ringWidth = 15.6;
  ringHeight = 1.0;

  bottomTopWidth = 14.0;
  bottomBottomWidth = 12.0;
  bottomHeight = 5.0;

  topBottomWidth = 14.5;
  topTopWidth = 10;
  topHeight = 11.6 - bottomHeight - ringHeight;

  module switch_stem() {

    width = 3.6;
    height = 3.6;
    depth = 1.2;
    edgeRadius = 0.2;

    color(stemColor, 1) translate([ 0, 0, ringHeight + topHeight ])
        linear_extrude(height = height) {
      square_rounded([ width, depth ], edgeRadius, true);
      rotate([ 0, 0, 90 ]) square_rounded([ width, depth ], edgeRadius, true);
    }
  }

  module switch_top() {
    color(bodyColor, 1) translate([ 0, 0, ringHeight ])
        linear_extrude(topHeight, scale = topTopWidth / topBottomWidth)
            translate([ -topBottomWidth / 2, -topBottomWidth / 2, 0 ])
                square_rounded([ topBottomWidth, topBottomWidth ], 1.0);
  }

  module switch_middle() {
    color(bodyColor, 1) linear_extrude(ringHeight)
        square_rounded([ ringWidth, ringWidth ], 1.0, center = true);
  }

  module switch_bottom() {
    color(bodyColor, 1) translate([ 0, 0, -bottomHeight ])
        linear_extrude(bottomHeight, scale = bottomTopWidth / bottomBottomWidth)
            translate([ -bottomBottomWidth / 2, -bottomBottomWidth / 2, 0 ])
                square_rounded([ bottomBottomWidth, bottomBottomWidth ], 1.0);
  }

  switch_stem();
  switch_top();
  switch_middle();
  switch_bottom();
}

//
// Tests
//

// Choc
switch_choc_3D(draw_pins = true);

translate([ 25, 0, 0 ]) {
  difference() {
    translate([ -0, -0, -1.6 - TOL ]) cube_XY([ 15, 15, 1.6 ]);
    switch_choc_footprint();
  }
}

translate([ 50, 0, 0 ]) {
  switch_choc_3D(draw_pins = true);
  difference() {
    translate([ -0, -0, -1.6 - TOL ]) cube_XY([ 15, 15, 1.6 ]);
    switch_choc_footprint();
  }
}

translate([ 75, 0, 0 ]) {
  switch_choc_3D(draw_pins = true);
  switch_choc_footprint();
}

translate([ 25, 25, 0 ]) {
  difference() {
    plateThickness = 1.3;
    plateHeight = 2.2 - 1.3;
    translate([ 0, 0, plateHeight ])
        cube_XY([ 15, 15, plateThickness ], center = false);
    switch_choc_cutout(plateThickness, plateHeight);
  }
}

translate([ 50, 25, 0 ]) {
  difference() {
    plateThickness = 1.3;
    plateHeight = 2.2 - 1.3;
    translate([ 0, 0, plateHeight ])
        cube_XY([ 15, 15, plateThickness ], center = false);
    switch_choc_cutout(plateThickness, plateHeight);
  }
  switch_choc_3D(draw_pins = false);
}

// // MX
// translate([ 0, 50, 0 ]) { switch_MX(); }
