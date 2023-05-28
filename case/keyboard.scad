include <config.scad>;

include <common/constants.scad>;
include <component/pins_database.scad>;
use <common/dictionnary.scad>;
use <common/distributions.scad>;
use <common/extrusions.scad>;
use <common/transformations.scad>;
use <common/utils.scad>;

use <component/EVQWGD001.scad>;
use <component/PG1350.scad>;
use <component/PJ230.scad>;
use <component/RP2040_zero.scad>;
use <component/shapes2D.scad>;
use <component/shapes3D.scad>;

//
// Data
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
  [ "splay_initial", 85 ], [ "offset", 0 ], [ "rotation", 16 ],
  [ "offset_initial", [ 0.32 * choc_spacing[0], 0.45 * choc_spacing[1] ] ],
  [ "count", 3 ], [ "spacing", choc_spacing * 1.33 ]
]];

// PCB
pcbPlateThickness = 1.6;
pcbPlateBaseHeight = -1.6;
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

// Top / switch plate
topPlateThickness = 1.3;
topPlateBaseHeight = 2.2 - topPlateThickness;

// Main case
caseThickness = 3;
caseHeight = 10.6;
caseBaseHeight = pcbPlateBaseHeight - 3.8 - caseThickness;

mcu = [
  [ "name", "RP2040_zero" ], [ "position", [ 52.2, 13 ] ],
  [ "centerXY", false ],
  [ "socket", dataLookup(header_data, ["header254_femaleLow"]) ],
  // [ "socket", undef ]
];

trackball = [
  [ "name", "Trackball_25" ], [ "position", [ 70, 0 ] ], [ "radius", 25 / 2.0 ],
  [ "centerXY", true ]
];

trrs =
    [ [ "name", "TRRS" ], [ "position", [ 80, 25 ] ], [ "centerXY", false ] ];

//
// Components
//

// MCU
module mcuBoard_model(drawPins) {
  position = dataLookup(mcu, ["position"]);
  centerXY = dataLookup(mcu, ["centerXY"]);
  socket = dataLookup(mcu, ["socket"]);
  translate(position) RP2040_zero_model(centerXY = centerXY,
                                        drawPins = drawPins, socket = socket);
}
module mcuBoard_footprint() {
  position = dataLookup(mcu, ["position"]);
  centerXY = dataLookup(mcu, ["centerXY"]);
  socket = dataLookup(mcu, ["socket"]);
  translate(position)
      RP2040_zero_footprint(centerXY = centerXY, socket = socket);
}
module mcuBoard_clearance() {
  position = dataLookup(mcu, ["position"]);
  centerXY = dataLookup(mcu, ["centerXY"]);
  socket = dataLookup(mcu, ["socket"]);
  translate(position)
      RP2040_zero_clearance(centerXY = centerXY, socket = socket);
}

// Trackball
module trackball_model(drawPins) {
  position = dataLookup(trackball, ["position"]);
  centerXY = dataLookup(trackball, ["centerXY"]);
  radius = dataLookup(trackball, ["radius"]);
  translate(__Z(radius) + XY_(position)) sphere(radius);
}
module trackball_footprint() {
  // position = dataLookup(trackball, ["position"]);
  // centerXY = dataLookup(trackball, ["centerXY"]);
  // radius = dataLookup(trackball, ["radius"]);
  // translate(position)
}
module trackball_clearance() {
  // position = dataLookup(trackball, ["position"]);
  // centerXY = dataLookup(trackball, ["centerXY"]);
  // radius = dataLookup(trackball, ["radius"]);
  // translate(position)
}

// TRRS
module trrs_model(drawPins) {
  position = dataLookup(trrs, ["position"]);
  centerXY = dataLookup(trrs, ["centerXY"]);
  translate(position) PJ320A_model(centerXY = centerXY, drawPins = drawPins);
}
module trrs_footprint() {
  position = dataLookup(trrs, ["position"]);
  centerXY = dataLookup(trrs, ["centerXY"]);
  translate(position) PJ320A_footprint(centerXY = centerXY);
}
module trrs_clearance() {
  position = dataLookup(trrs, ["position"]);
  centerXY = dataLookup(trrs, ["centerXY"]);
  translate(position) PJ320A_clearance(centerXY = centerXY);
}

// Switch
module switch_model(drawPins) {
  PG1350_model(centerXY = true, drawPins = drawPins);
}
module switch_footprint() { PG1350_footprint(centerXY = true); }
module switch_clearance() { PG1350_clearance(centerXY = true); }

// Encoder
module encoder_model(drawPins) {
  rotate([ 180, 180, 0 ])
      EVQWGD001_model(drawPins = drawPins, reversible = false);
}
module encoder_footprint() {
  rotate([ 180, 180, 0 ]) EVQWGD001_footprint(reversible = false);
}
module encoder_clearance() { rotate([ 180, 180, 0 ]) EVQWGD001_clearance(); }

// Keycaps
module keycap1U() {
  translate([ 0, 0, (5.0 + 2.2 + 0.8) - 3.7 / 2.0 ]) {
    color("White", 0.75) linear_extrude(3)
        square(choc_keycap_size, center = true);
  }
}
module keycap15U() {
  translate([ 0, 0, (5.0 + 2.2 + 0.8) - 3.7 / 2.0 ]) {
    color("White", 0.75) linear_extrude(3) square(
        [ choc_keycap_size[1] * 1.5, choc_keycap_size[0] ], center = true);
  }
}

// Case
module plates() {
  color(rgb(147, 161, 161, 0.5)) pcb();
  color(rgb(253, 246, 227, 0.5)) top();
}

module pcb(thickness = pcbPlateThickness) {
  translate([ 0, 0, pcbPlateBaseHeight ]) linear_extrude(thickness)
      polygon(pcb_points);
}

module top(thickness = topPlateThickness) {
  translate([ 0, 0, topPlateBaseHeight ]) linear_extrude(thickness)
      offset(delta = 0.55, chamfer = false) polygon(pcb_points);
}

module shell() {
  // Translate must be called on a 3D shape to have effect
  color(rgb(238, 232, 213, 1.0)) render() difference() {
    // Outer border
    round_r = 5.0;
    translate([ 0, 0, caseBaseHeight ])
        round_extrude_B(caseHeight, r = round_r) {
      inset(round_r) offset(r = 0.55 + 2.4 - round_r, chamfer = false)
          polygon(pcb_points);
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

module draw_layout(cutout = false, drawPins = false, draw_keycaps = false) {
  // Draw keys layout
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
        if (cutout) {
          switch_footprint();
          switch_clearance();
        } else {
          switch_model(drawPins = drawPins);
          if (draw_keycaps) {
            keycap1U();
          }
        }
      }
      if (name == "pinky") {
        // Encoder on pinky top
        place_on_line(i = c, count = c, spacing = s[1], offset = o,
                      axis = forward, center = false) {
          if (cutout) {
            encoder_footprint();
            encoder_clearance();
          } else {
            encoder_model(drawPins = drawPins);
          }
        }
      } else if (name == "inner") {
        // Draw thumb cluster
        thumb_layout(layout_thumb[0], c, s, o, cutout = cutout,
                     draw_keycaps = draw_keycaps);
      }
    }
  }

  // Other components
  draw_components(cutout = cutout, drawPins = drawPins);
}

module thumb_layout(thumbData, count, spacing, offset, cutout = false,
                    drawPins = false, draw_keycaps = false) {
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
            if (cutout) {
              switch_footprint();
              switch_clearance();
            } else {
              switch_model(drawPins = drawPins);
              if (draw_keycaps) {
                keycap1U();
              }
            }
          }
        } else {
          if (cutout) {
            switch_footprint();
            switch_clearance();
          } else {
            switch_model(drawPins = drawPins);
            if (draw_keycaps) {
              keycap15U();
            }
          }
        }
      }
    }
  }
}

module draw_components(cutout = false, drawPins = false) {
  // Other components
  if (cutout) {
    // MCU
    mcuBoard_footprint();
    mcuBoard_clearance();
    // Trackball
    trackball_footprint();
    trackball_clearance();
    // TRRS
    trrs_footprint();
    trrs_clearance();
  } else {
    mcuBoard_model(drawPins = drawPins);
    trackball_model(drawPins = drawPins);
    trrs_model(drawPins = drawPins);
  }
}

// ///
// /// @brief      Helper that can be used to visualize thumbs keys as defined
// in
// /// Ptechinos
// ///             keyboard
// ///
// /// @return     Nothing
// ///
// module thumb_layout_ptechinos() {
//   translate([ 28.829, -50.217 + choc_spacing[1], 5 ]) rotate([ 0, 0, -10 ])
//       color("yellow") switch_clearance();
//   translate([ 50.874, -58.143 + choc_spacing[1], 5 ]) rotate([ 0, 0, -25 ])
//       color("yellow") switch_clearance();
//   translate([ 70.034, -70.477 + choc_spacing[1], 5 ]) rotate([ 0, 0, -40 ])
//       color("yellow") switch_clearance();
// }

//
// Assembly
//

// 3D elements
draw_layout(cutout = false, drawPins = true);
difference() {
  // Case shell
  shell();
  // Footprints
  draw_layout(cutout = true);
}
difference() {
  // Case PCB / Top plates
  plates();
  // Footprints
  draw_layout(cutout = true);
}
