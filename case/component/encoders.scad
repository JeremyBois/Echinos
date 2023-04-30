include <../common/constants.scad>;
use <../common/distributions.scad>;
use <../component/shapes3D.scad>;

module encoder_EVQWGD001_footprint(reversible = false) {
  encoder_EVQWGD001(footprint = true, reversible = reversible,
                    baseColor = "Red");
}

module encoder_EVQWGD001_3D(draw_pins = false, reversible = false) {
  encoder_EVQWGD001(footprint = false, reversible = reversible,
                    draw_pins = draw_pins, baseColor = "DarkSlateGray",
                    rollerColor = "Silver");
}

module encoder_EVQWGD001_cutout(plateThickness, plateHeight) {
  translate([ 0, 0, plateHeight - TOL / 2.0 ])
      // Add ~ 1mm margin
      cube_XY([ 16.6 + 1.0, 13.8 + 1.0, plateThickness + TOL ], center = false,
              $fn = 10);
}

module encoder_EVQWGD001_cutout_position() { children(); }

module encoder_EVQWGD001(footprint, reversible, draw_pins, baseColor,
                         rollerColor) {
  width = 16.6;
  depth = 13.8;
  height = 1.2;

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

  translate([ -width / 2.0, -depth / 2.0, 0.0 ]) {
    if (footprint) {
      color(baseColor, 0.5) front_side(positive = false);
      color(baseColor, 0.5) electrical_pins_holes();
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
    mounting = [ 1.0, depth, 1.7 ];
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
    cube([ width, depth, height ], false);

    // Top front
    frontHead = [ 0.7, 3.0, 2.5 ];
    for (shift = [ 0.5, 0.5 + 7 + frontHead[1] ]) {
      translate([ 0.0, shift, height ]) {
        cube(frontHead, false);
        translate([ 0.0, frontHead[1] / 2.0, frontHead[2] ])
            rotate([ 90, 0, 90 ])
                cylinder(r = frontHead[1] / 2.0, h = frontHead[0], $fn = 10);
      }
    }

    // Top back
    backHead = [ 0.8, depth, 4.0 ];
    translate([ width - backHead[0], 0.0, height ]) { cube(backHead, false); }
  }

  module roller() {
    rDiameter = 11.3;
    rWidth = 12.4;
    rHeight = 8.9 - height;
    translate([ 2.05 + rWidth / 2.0, 2.5 + rDiameter / 2.0, rHeight ])
        rotate([ 0, 90, 0 ]) {
      union() {
        cylinder(h = rWidth, d = rDiameter, center = true, $fn = 40);
        bHeight = 0.25;
        bWidth = 0.3;
        bDepth = rWidth - 2.0;
        count = 50;
        on_arc_r(count = count, r = rDiameter / 2.0, rotation = 360 / count,
                 center = true, spin = true) {
          translate([ 0.0, 0.0, -bDepth ] / 2.0)
              cube([ bHeight, bWidth, bDepth ]);
        }
      }
    }
  }

  module electrical_pins() {
    // Horizontal
    translate([ width - hPinShift[0] - hShift[0], 0.0, -hPin[2] ]) {
      for (i = [0:1:3]) {
        translate([ 0, depth - hPitch * i - hPinShift[1] - hShift[1], 0.0 ])
            cube_XY(hPin);
        if (reversible)
          translate([ 0.0, hPitch * (3 - i) + hPinShift[1] + hShift[1], 0.0 ])
              cube_XY(hPin);
      }
    }

    // Vertical
    for (i = [0:1:1]) {
      translate(
          [ width - vPinShift[0] - vShift[0] - i * vPitch, 0.0, -vPin[2] ]) {
        translate([ 0, vPinShift[1] + vShift[1], 0.0 ]) color("Gold")
            cube_XY(vPin);
        if (reversible) {
          translate([ 0, depth - vPinShift[1] - vShift[1], 0.0 ]) cube_XY(vPin);
        }
      }
    }
  }

  module electrical_pins_holes() {
    // Horizontal
    translate([ width - hPinShift[0] - hShift[0], 0.0, -hPin[2] - TOL / 2.0 ]) {
      for (i = [0:1:3])
        // Merge both holes in a large enough hole
        hull() {
          translate([ 0, depth - hPitch * i - hPinShift[1] - hShift[1], 0.0 ])
              cylinder(r = hPinHole[1], h = hPinHole[2] + TOL, $fn = 10);
          if (reversible)
            translate([ 0.0, hPitch * (3 - i) + hPinShift[1] + hShift[1], 0.0 ])
                cylinder(r = hPinHole[1], h = hPinHole[2] + TOL, $fn = 10);
        }
    }

    // Vertical
    for (i = [0:1:1]) {
      translate(
          [ width - vPinShift[0] - vShift[0] - i * vPitch, 0.0, -vPin[2] ]) {
        translate([ 0, vPinShift[1] + vShift[1], -TOL / 2.0 ]) {
          cylinder(r = vPinHole[0], h = vPin[2] + TOL, $fn = 10);
        }
        if (reversible) {
          translate([ 0, depth - vPinShift[1] - vShift[1], -TOL / 2.0 ]) {
            cylinder(r = vPinHole[0], h = vPin[2] + TOL, $fn = 10);
          }
        }
      }
    }
  }
}

//
// Tests
//
encoder_EVQWGD001_3D(draw_pins = true, reversible = true);

// Non reversible
translate([ 25, 0, 0 ]) {
  difference() {
    translate([ -0, -0, -1.6 - TOL ]) cube_XY([ 20, 20, 1.6 ]);
    encoder_EVQWGD001_footprint(reversible = false);
  }
}
translate([ 50, 0, 0 ]) {
  encoder_EVQWGD001_3D(draw_pins = true, reversible = false);
  difference() {
    translate([ -0, -0, -1.6 - TOL ]) cube_XY([ 20, 20, 1.6 ]);
    encoder_EVQWGD001_footprint(reversible = false);
  }
}
translate([ 75, 0, 0 ]) {
  encoder_EVQWGD001_3D(draw_pins = true, reversible = false);
  encoder_EVQWGD001_footprint(reversible = false);
}

translate([ 25, 25, 0 ]) {
  difference() {
    plateThickness = 1.3;
    plateHeight = 2.2 - 1.3;
    translate([ 0, 0, plateHeight ]) // Height required to clip a switch
        cube_XY([ 20, 20, plateThickness ], center = false);
    encoder_EVQWGD001_cutout(plateThickness, plateHeight);
  }
}

translate([ 50, 25, 0 ]) {
  difference() {
    plateThickness = 1.3;
    plateHeight = 2.2 - 1.3;
    translate([ 0, 0, plateHeight ]) // Height required to clip a switch
        cube_XY([ 20, 20, plateThickness ], center = false);
    encoder_EVQWGD001_cutout(plateThickness, plateHeight);
  }
  encoder_EVQWGD001_3D(draw_pins = false, reversible = false);
}

// Reversible
translate([ -25, 0, 0 ]) {
  difference() {
    translate([ -0, -0, -1.6 - TOL ]) cube_XY([ 20, 20, 1.6 ]);
    encoder_EVQWGD001_footprint(reversible = true);
  }
}

translate([ -50, 0, 0 ]) {
  encoder_EVQWGD001_3D(draw_pins = true, reversible = true);
  difference() {
    translate([ -0, -0, -1.6 - TOL ]) cube_XY([ 20, 20, 1.6 ]);
    encoder_EVQWGD001_footprint(reversible = true);
  }
}
translate([ -75, 0, 0 ]) {
  encoder_EVQWGD001_3D(draw_pins = true, reversible = true);
  encoder_EVQWGD001_footprint(reversible = true);
}
