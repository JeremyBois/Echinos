include <config.scad>;

include <common/constants.scad>;
use <common/distributions.scad>;
use <common/transformations.scad>;
use <common/utils.scad>;
use <common/dictionnary.scad>;

use <component/encoders.scad>;
use <component/shapes2D.scad>;
use <component/shapes3D.scad>;
use <component/switches.scad>;

//
// Data / Description
//

// Layout (excluding thumbs)
layout = [
  [
    [ "name", "outer" ], [ "splay", 8 ], [ "offset", choc_spacing[1] / 2.0 ],
    [ "count", 1 ], [ "spacing", choc_spacing ],
    [ "spread", -3 * choc_spacing[0] ]
  ],
  [
    [ "name", "pinky" ], [ "splay", 6 ], [ "offset", -0.6 * choc_spacing[1] ],
    [ "count", 2 ], [ "spacing", choc_spacing ],
    [ "spread", -2 * choc_spacing[0] ]
  ],
  [
    [ "name", "ring" ], [ "splay", 2 ], [ "offset", -0.2 * choc_spacing[1] ],
    [ "count", 3 ], [ "spacing", choc_spacing ],
    [ "spread", -1 * choc_spacing[0] ]
  ],
  [
    [ "name", "middle" ], [ "splay", 0 ], [ "offset", 0 ], [ "count", 3 ],
    [ "spacing", choc_spacing ], [ "spread", 0.0 ]
  ],
  [
    [ "name", "index" ], [ "splay", -4 ], [ "offset", -0.3 * choc_spacing[1] ],
    [ "count", 3 ], [ "spacing", choc_spacing ],
    [ "spread", 1 * choc_spacing[0] ]
  ],
  [
    [ "name", "inner" ], [ "splay", -4 ], [ "offset", -0.3 * choc_spacing[1] ],
    [ "count", 3 ], [ "spacing", choc_spacing ],
    [ "spread", 2 * choc_spacing[0] ]
  ],
];

// Thumb cluster
layout_thumb = [[
  [ "splay_initial", 85 ], [ "offset", 0 ], [ "rotation", 15 ],
  [ "offset_initial", [ 0.3 * choc_spacing[0], 0.4 * choc_spacing[1] ] ],
  [ "count", 3 ], [ "spacing", choc_spacing * 1.33 ]
]];

// PCB
pcbPlateThickness = 1.6;
pcbPlateBaseHeight = -1.6;

// Top / switch plate
topPlateThickness = 1.3;
topPlateBaseHeight = 2.2 - topPlateThickness;

// Main case
caseThickness = 3;
caseHeight = 10.6;
caseBaseHeight = pcbPlateBaseHeight - 3.8 - caseThickness;

pcb_points = [
  [ -71.187, 4.617000000000001 ],
  [ -55.938, 18.982 ],
  [ -57.454, 29.768 ],
  [ -42.21, 31.915 ],
  [ -31.024, 42.454 ],
  [ -11.00, 43.497 ],
  [ -11.00, 45.5 ],
  [ 11.00, 45.5 ],
  [ 11.00, 43.448 ],
  [ 31.511, 42.013999999999996 ],
  [ 31.543, 39.620000000000005 ],
  [ 50.79, 38.257999999999996 ],
  [ 50.734, 37.452 ],
  [ 88.81, 37.446 ],
  [ 74.961, -26.083 ],
  [ 84.045, -52.293000000000006 ],
  [ 74.417, -66.303 ],
  [ 28.371, -44.65 ],
  [ -44.004, -30.006999999999998 ],
  [ -64.99, -13.901 ]
];

//
// Components
//

module keycap1U() {
  translate([ 0, 0, (5.0 + 2.2 + 0.8) - 3.7 / 2.0 ]) {
    color("Salmon", 0.5) linear_extrude(3)
        square(choc_keycap_size, center = true);
  }
}
module keycap15U() {
  translate([ 0, 0, (5.0 + 2.2 + 0.8) - 3.7 / 2.0 ]) {
    color("Salmon", 0.5) linear_extrude(3) square(
        [ choc_keycap_size[1] * 1.5, choc_keycap_size[0] ], center = true);
  }
}

module switch_3D() { switch_choc_3D(draw_pins = true); }
module switch_footprint() { switch_choc_footprint(); }

module encoder_3D() {
  rotate([ 180, 180, 0 ]) encoder_EVQWGD001_3D(draw_pins = true);
}
module encoder_footprint() {
  rotate([ 180, 180, 0 ]) encoder_EVQWGD001_footprint(reversible = true);
}

module plates() {
  color(rgb(75, 75, 75, 1.0)) pcb();
  color(rgb(175, 175, 175, 1.0)) top();
}

module pcb(thickness = pcbPlateThickness) {
  translate([ 0, 0, pcbPlateBaseHeight ]) linear_extrude(thickness)
      polygon(pcb_points);
}

module top(thickness = topPlateThickness) {
  translate([ 0, 0, topPlateBaseHeight ]) linear_extrude(thickness)
      offset(delta = 0.55, chamfer = false) polygon(pcb_points);
}

module case_shell() {
  // Translate must be called on a 3D shape to have effect
  difference() {
    // Outer border
    translate([ 0, 0, caseBaseHeight ]) {
      linear_extrude(caseHeight) round(r = 1)
          offset(r = 0.55 + 2.4, chamfer = false) polygon(pcb_points);
    }

    // Top plate shell
    top(caseHeight);

    // PCB shell
    pcb(caseHeight);

    // Inner shell
    translate([ 0, 0, caseBaseHeight + caseThickness ]) {
      linear_extrude(caseHeight) offset(delta = -2.4, chamfer = false)
          polygon(pcb_points);
    }
  }
}

//
// Distribution
//

module layout_distribution(footprint = false) {
  // Draw layout
  for (i = [0:1:len(layout) - 1]) {
    data = layout[i];
    name = dataLookup(data, ["name"]);
    spread = dataLookup(data, ["spread"]);
    c = dataLookup(data, ["count"]);
    s = dataLookup(data, ["spacing"]);
    o = dataLookup(data, ["offset"]);
    r = dataLookup(data, ["splay"]);
    rotate([ 0, 0, r ]) translate([ spread, 0, 0 ]) {
      on_line(count = c, spacing = s[1], offset = o, axis = forward,
              center = false) {
        if (footprint) {
          switch_footprint();
          switch_choc_cutout(topPlateThickness, topPlateBaseHeight);
        } else {
          switch_3D();
          keycap1U();
        }
      }
      if (name == "pinky") {
        // Encoder on pinky top
        place_on_line(i = c, count = c, spacing = s[1], offset = o,
                      axis = forward, center = false) {
          if (footprint) {
            encoder_footprint();
            encoder_EVQWGD001_cutout(topPlateThickness, topPlateBaseHeight);
          } else {
            encoder_3D();
          }
        }
      } else if (name == "inner") {
        // Draw thumb cluster
        thumb_layout_distribution(layout_thumb[0], c, s, o,
                                  footprint = footprint);
      }
    }
  }
}

module thumb_layout_distribution(thumbData, count, spacing, offset,
                                 footprint = false) {
  tc = dataLookup(thumbData, ["count"]);
  ts = dataLookup(thumbData, ["spacing"]);
  to = dataLookup(thumbData, ["offset"]);
  tr = dataLookup(thumbData, ["rotation"]);
  tio = dataLookup(thumbData, ["offset_initial"]);
  tir = dataLookup(thumbData, ["splay_initial"]);

  // Start thumb cluster based on column bottom
  place_on_line(i = -1, count = count, spacing = spacing[1], offset = offset,
                axis = forward, center = false)
      translate([ -tio[0], -tio[1], 0 ]) rotate([ 0, 0, tir ]) {
    for (j = [0:1:tc - 1]) {
      place_on_arc(i = j, spacing = ts[1], rotation = tr, offset = to,
                   clockwise = true, center = false, spin = true) {
        // Handle 1.5U and 1U keycaps
        if (mod(j, 2)) {
          rotate([ 0, 0, 90 ]) {
            if (footprint) {
              switch_footprint();
              switch_choc_cutout(topPlateThickness, topPlateBaseHeight);
            } else {
              switch_3D();
              keycap1U();
            }
          }
        } else {
          if (footprint) {
            switch_footprint();
            switch_choc_cutout(topPlateThickness, topPlateBaseHeight);
          } else {
            switch_3D();
            keycap15U();
          }
        }
      }
    }
  }
}

//
// Assembly
//

// 3D elements
layout_distribution(footprint = false);
color(rgb(211, 211, 211, 1.0)) case_shell();
difference() {
  // Plates
  plates();
  // Footprints
  layout_distribution(footprint = true);
}

// // Thumbs Ptechinos ()
// // translate([-50, -80, 0 ]) text("ECHINOS");
// translate([ 28.829, -50.217 + choc_spacing[1], 5 ]) rotate([ 0, 0, -10 ])
// #switch_choc_cutout(1.6, 1.6);
//     translate([ 50.874, -58.143 + choc_spacing[1], 5 ]) rotate([ 0, 0, -25
//     ])
// #switch_choc_cutout(1.6, 1.6);
//         translate([ 70.034, -70.477 + choc_spacing[1], 5 ])
//             rotate([ 0, 0, -40 ])
// #switch_choc_cutout(1.6, 1.6);
