include <config.scad>;

include <common/constants.scad>;
use <common/distributions.scad>;
use <common/utils.scad>;

use <component/encoders.scad>;
use <component/shapes.scad>;
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

// Plates
pcbThickness = 1.6;
pcbHeight = -1.6;
topPlateThickness = 1.3;
topPlateHeight = 2.2 - 1.3;

//
// Components
//

module keycap1U() {
  translate([ 0, 0, (5.0 + 3.0 + 3.0) / 2.0 ]) {
    color("Gray", 0.3) square(choc_keycap_size, center = true);
  }
}
module keycap15U() {
  translate([ 0, 0, (5.0 + 3.0 + 3.0) / 2.0 ]) {
    color("Gray", 0.3) square(
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
  color(rgb(131, 148, 150, 1.0)) pcb();
  color(rgb(238, 232, 213, 1.0)) top();
}

module pcb() {
  translate([ 0, choc_spacing[1], pcbHeight - overlap_tol / 2.0 ])
      linear_extrude(pcbThickness - overlap_tol) {
    polygon([
      [ -71.187, -12.883 ], [ -55.938, 1.482 ],  [ -57.454, 12.268 ],
      [ -42.21, 14.415 ],   [ -31.024, 24.954 ], [ -11.00, 25.997 ],
      [ -11.00, 28.00 ],    [ 11.00, 28.00 ],    [ 11.00, 25.948 ],
      [ 31.511, 24.514 ],   [ 31.543, 22.12 ],   [ 50.79, 20.758 ],
      [ 50.734, 19.952 ],   [ 88.81, 19.946 ],   [ 74.961, -43.583 ],
      [ 84.045, -69.793 ],  [ 74.417, -83.803 ], [ 28.371, -62.15 ],
      [ -44.004, -47.507 ], [ -64.99, -31.401 ]
    ]);
  }
  // cube_XY([ 170, 170, pcbThickness - overlap_tol ]);
}

module top() {
  translate([ 0, choc_spacing[1], topPlateHeight - overlap_tol / 2.0 ])
      // cube_XY([ 170, 170, topPlateThickness - overlap_tol ]);
      linear_extrude(topPlateThickness - overlap_tol) {
    polygon([
      [ -71.187, -12.883 ], [ -55.938, 1.482 ],  [ -57.454, 12.268 ],
      [ -42.21, 14.415 ],   [ -31.024, 24.954 ], [ -11.00, 25.997 ],
      [ -11.00, 28.00 ],    [ 11.00, 28.00 ],    [ 11.00, 25.948 ],
      [ 31.511, 24.514 ],   [ 31.543, 22.12 ],   [ 50.79, 20.758 ],
      [ 50.734, 19.952 ],   [ 88.81, 19.946 ],   [ 74.961, -43.583 ],
      [ 84.045, -69.793 ],  [ 74.417, -83.803 ], [ 28.371, -62.15 ],
      [ -44.004, -47.507 ], [ -64.99, -31.401 ]
    ]);
  }
}

module bottom() {
  // translate([ 0, 0, -1.6 - overlap_tol ]) cube_XY([ 200, 200, 1.6 ]);
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
          switch_choc_cutout(topPlateThickness, topPlateHeight);
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
            encoder_EVQWGD001_cutout(topPlateThickness, topPlateHeight);
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
      place_on_circle(i = j, spacing = ts[1], rotation = tr, offset = to,
                      clockwise = true, center = false, spin = true) {
        // Handle 1.5U and 1U keycaps
        if (mod(j, 2)) {
          rotate([ 0, 0, 90 ]) {
            if (footprint) {
              switch_footprint();
              switch_choc_cutout(topPlateThickness, topPlateHeight);
            } else {
              switch_3D();
              keycap1U();
            }
          }
        } else {
          if (footprint) {
            switch_footprint();
            switch_choc_cutout(topPlateThickness, topPlateHeight);
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
difference() {
  // Plates
  plates();
  // Footprints
  layout_distribution(footprint = true);
}

// Thumbs Ptechinos ()
translate([ 28.829, -50.217 + choc_spacing[1], 5 ]) rotate([ 0, 0, -10 ])
#switch_choc_cutout(1.6, 1.6);
    translate([ 50.874, -58.143 + choc_spacing[1], 5 ]) rotate([ 0, 0, -25 ])
#switch_choc_cutout(1.6, 1.6);
        translate([ 70.034, -70.477 + choc_spacing[1], 5 ])
            rotate([ 0, 0, -40 ])
#switch_choc_cutout(1.6, 1.6);
