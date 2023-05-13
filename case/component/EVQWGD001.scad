include <../common/constants.scad>;
include <../component/draw_modes.scad>;
use <../common/distributions.scad>;
use <../component/shapes3D.scad>;

//
// Panasonic encoder model EVQWGD001 (horizontal roller encoder)
//

// Base
bWidth = 16.6;
bDepth = 13.8;
bHeight = 1.2;

// Roller
rDiameter = 11.3;
rWidth = 12.4;
rHeight = 8.9 - bHeight;

// Horizontal pins
hShift = [ 2.79, 2.5, 0.0 ];
hPin = [ 0.2, 0.8, 3.7 ];
hPinShift = hPin / 2.0;
hPinHole = [ 1.6, 0.9, 3.7 ];
hPitch = 2.54;

// Vertical pins
vShift = [ 0.2, 0.02, 0.0 ];
vPin = [ 0.5, 0.18, 3.7 ];
vPinShift = vPin / 2.0;
vPinHole = [ 0.9, 0.9, 3.7 ];
vPitch = 2.25;

module EVQWGD001_model(centerY = true, draw_pins = true, reversible = false,
                       baseColor = "DarkSlateGray", rollerColor = "Silver") {
  __EVQWGD001(MODEL, centerY = centerY, draw_pins = draw_pins,
              reversible = reversible, baseColor = baseColor,
              rollerColor = rollerColor);
}

module EVQWGD001_footprint(centerY = true, reversible = false, color = "Red") {
  __EVQWGD001(FOOTPRINT, centerY = centerY, reversible = reversible,
              baseColor = color);
}

module EVQWGD001_clearance(centerY = true, ) {
  __EVQWGD001(CLEARANCE, centerY = centerY);
}

// module EVQWGD001_clearance_position() { children(); }

module __EVQWGD001(mode, centerY, reversible, draw_pins, baseColor,
                   rollerColor) {
  translate([ -bWidth / 2.0, centerY ? -bDepth / 2.0 : 0.0, 0.0 ]) {
    if (mode == FOOTPRINT) {
      color(baseColor, 0.5) front_side(positive = false);
      color(baseColor, 0.5) electrical_pins_holes();
    } else if (mode == CLEARANCE) {
      clearance();
    } else {
      color(rollerColor) roller();
      color(baseColor) base();
      color(baseColor) front_side(true);
      if (draw_pins) {
        color("Gold") electrical_pins();
      }
    }
  }

  module front_side(positive = true) {
    // Bottom front
    mounting = [ 1.0, bDepth, 1.7 ];
    // Add ~1mm margin
    mountingHole = mounting + [ 1.0, 1.0, TOL ];
    cutShift = positive ? 0.0 : TOL / 2.0;
    leg = [ 2.2, 2.0, 0.5 ];
    legHole = leg + [ 0.5, 0.5, 0.0 ];

    translate([ 0.0, 0.0, -mounting[2] - cutShift ]) {
      // Mounting
      translate([ mounting[0] / 2.0, mounting[1] / 2.0, 0.0 ])
          cube_XY(positive ? mounting : mountingHole);

      // Legs
      for (shift = [ 1.8, 1.8 + leg[1] + 5 ]) {
        translate([ leg[0] / 2.0, leg[1] / 2.0 + shift, -leg[2] ])
            cube_XY(positive ? leg : legHole);
      }
    }
  }

  module base() {
    // Plan
    cube([ bWidth, bDepth, bHeight ], false);

    // Top front
    frontHead = [ 0.7, 3.0, 2.5 ];
    for (shift = [ 0.5, 0.5 + 7 + frontHead[1] ]) {
      translate([ 0.0, shift, bHeight ]) {
        cube(frontHead, false);
        translate([ 0.0, frontHead[1] / 2.0, frontHead[2] ])
            rotate([ 90, 0, 90 ])
                cylinder(r = frontHead[1] / 2.0, h = frontHead[0], $fn = 10);
      }
    }

    // Top back
    backHead = [ 0.8, bDepth, 4.0 ];
    translate([ bWidth - backHead[0], 0.0, bHeight ]) { cube(backHead, false); }
  }

  module roller() {
    translate([ 2.05 + rWidth / 2.0, 2.5 + rDiameter / 2.0, rHeight ])
        rotate([ 0, 90, 0 ]) {
      union() {
        cylinder(h = rWidth, d = rDiameter, center = true, $fn = 40);
        crankSize = [ 0.25, 0.3, rWidth - 2.0 ];
        count = 50;
        on_arc_r(count = count, r = rDiameter / 2.0, rotation = 360 / count,
                 center = true, spin = true) {
          translate([ 0.0, 0.0, -crankSize[2] ] / 2.0) cube(crankSize);
        }
      }
    }
  }

  module electrical_pins() {
    // Horizontal
    translate([ bWidth - hPinShift[0] - hShift[0], 0.0, -hPin[2] ]) {
      for (i = [0:1:3]) {
        translate([ 0, bDepth - hPitch * i - hPinShift[1] - hShift[1], 0.0 ])
            cube_XY(hPin);
        if (reversible)
          translate([ 0.0, hPitch * (3 - i) + hPinShift[1] + hShift[1], 0.0 ])
              cube_XY(hPin);
      }
    }

    // Vertical
    for (i = [0:1:1]) {
      translate(
          [ bWidth - vPinShift[0] - vShift[0] - i * vPitch, 0.0, -vPin[2] ]) {
        translate([ 0, vPinShift[1] + vShift[1], 0.0 ]) color("Gold")
            cube_XY(vPin);
        if (reversible) {
          translate([ 0, bDepth - vPinShift[1] - vShift[1], 0.0 ])
              cube_XY(vPin);
        }
      }
    }
  }

  module electrical_pins_holes() {
    // Horizontal
    translate(
        [ bWidth - hPinShift[0] - hShift[0], 0.0, -hPin[2] - TOL / 2.0 ]) {
      for (i = [0:1:3])
        // Merge both holes in a large enough hole
        hull() {
          translate([ 0, bDepth - hPitch * i - hPinShift[1] - hShift[1], 0.0 ])
              cylinder(r = hPinHole[1], h = hPinHole[2] + TOL, $fn = 10);
          if (reversible)
            translate([ 0.0, hPitch * (3 - i) + hPinShift[1] + hShift[1], 0.0 ])
                cylinder(r = hPinHole[1], h = hPinHole[2] + TOL, $fn = 10);
        }
    }

    // Vertical
    for (i = [0:1:1]) {
      translate(
          [ bWidth - vPinShift[0] - vShift[0] - i * vPitch, 0.0, -vPin[2] ]) {
        translate([ 0, vPinShift[1] + vShift[1], -TOL / 2.0 ]) {
          cylinder(r = vPinHole[0], h = vPin[2] + TOL, $fn = 10);
        }
        if (reversible) {
          translate([ 0, bDepth - vPinShift[1] - vShift[1], -TOL / 2.0 ]) {
            cylinder(r = vPinHole[0], h = vPin[2] + TOL, $fn = 10);
          }
        }
      }
    }
  }

  module clearance() {
    // Add some tolerance to avoid cutting PCB plate
    translate([ bWidth / 2.0, bDepth / 2.0, -TOL / 2.0 ]) {
      // Add ~ 1mm margin
      cube_XY(
          [ 16.6 + 1.0, 13.8 + 1.0, bHeight + rDiameter / 2.0 + rHeight + TOL ],
          centerZ = false, $fn = 10);
    }
  }
}

//
// Tests
//

include <../common/test_utils.scad>
$fn = 20;

EVQWGD001_model(draw_pins = true, reversible = true);

// Non reversible
__xSpacing(0) {
  difference() {
    translate([ -0, -0, -1.6 - TOL ]) cube_XY([ 20, 20, 1.6 ]);
    EVQWGD001_footprint(reversible = false);
  }
}
__xSpacing(1) {
  EVQWGD001_model(draw_pins = true, reversible = false);
  difference() {
    translate([ -0, -0, -1.6 - TOL ]) cube_XY([ 20, 20, 1.6 ]);
    EVQWGD001_footprint(reversible = false);
  }
}
__xSpacing(2) {
  EVQWGD001_model(draw_pins = true, reversible = false);
  EVQWGD001_footprint(reversible = false);
}

__xSpacing(1) __ySpacing(1) {
  difference() {
    plateThickness = 1.3;
    plateHeight = 2.2 - 1.3;
    translate([ 0, 0, plateHeight ]) // bHeight required to clip a switch
        cube_XY([ 20, 20, plateThickness ], centerZ = false);
#EVQWGD001_clearance();
  }
}

__xSpacing(2) __ySpacing(1) {
  difference() {
    plateThickness = 1.3;
    plateHeight = 2.2 - 1.3;
    translate([ 0, 0, plateHeight ]) // bHeight required to clip a switch
        cube_XY([ 20, 20, plateThickness ], centerZ = false);
#EVQWGD001_clearance();
  }
  EVQWGD001_model(draw_pins = false, reversible = false);
}

// Reversible
__xSpacing(-1) {
  difference() {
    translate([ -0, -0, -1.6 - TOL ]) cube_XY([ 20, 20, 1.6 ]);
    EVQWGD001_footprint(reversible = true);
  }
}

__xSpacing(-2) {
  EVQWGD001_model(draw_pins = true, reversible = true);
  difference() {
    translate([ -0, -0, -1.6 - TOL ]) cube_XY([ 20, 20, 1.6 ]);
    EVQWGD001_footprint(reversible = true);
  }
}
__xSpacing(-3) {
  EVQWGD001_model(draw_pins = true, reversible = true);
  EVQWGD001_footprint(reversible = true);
}
