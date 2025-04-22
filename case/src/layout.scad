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
use <component/PJ320.scad>;
use <component/RP2040_zero.scad>;
use <primitive/shapes2D.scad>;
use <primitive/shapes3D.scad>;

//
// Data
//

key_spacing = mx_spacing;
key_size = mx_keycap_size;

//
// LAYOUTS CHOC
//
columns_data_layouts_CHOC = [
// V0 (From MX_V1)
[
  [
    [ "name", "pinky" ], [ "rotation", 0 ], [ "offset", -13 - 6 ],
    [ "count", 4 ], [ "spacing", choc_spacing],
    [ "spread", -2 * choc_spacing[0] - 3 ]
  ],
  [
    [ "name", "ring" ], [ "rotation", 0 ], [ "offset", -6 ], [ "count", 4 ],
    [ "spacing", choc_spacing ], [ "spread", -1.0 * choc_spacing[0] ]
  ],
  [
    [ "name", "middle" ], [ "rotation", 0 ], [ "offset", 0 ], [ "count", 4 ],
    [ "spacing", choc_spacing ], [ "spread", 0.0 ]
  ],
  [
    [ "name", "index" ], [ "rotation", -0 ], [ "offset", -7 ], [ "count", 4 ],
    [ "spacing", choc_spacing ], [ "spread", 1.0 * choc_spacing[0] ]
  ],
  [
    [ "name", "inner" ], [ "rotation", -0 ], [ "offset", -7 ], [ "count", 4 ],
    [ "spacing", choc_spacing ], [ "spread", 2.0 * choc_spacing[0] ]
  ]
],
// V1 Add outer pinky
[
[
    [ "name", "pinky" ], [ "rotation", 0 ], [ "offset", -19 ],
    [ "count", 2 ], [ "spacing", choc_spacing],
    [ "spread", -3 * choc_spacing[0] ]
  ],
  [
    [ "name", "pinky" ], [ "rotation", 0 ], [ "offset", -19 ],
    [ "count", 3 ], [ "spacing", choc_spacing],
    [ "spread", -2 * choc_spacing[0] ]
  ],
  [
    [ "name", "ring" ], [ "rotation", 0 ], [ "offset", -6 ], [ "count", 3 ],
    [ "spacing", choc_spacing ], [ "spread", -1.0 * choc_spacing[0] ]
  ],
  [
    [ "name", "middle" ], [ "rotation", 0 ], [ "offset", 0 ], [ "count", 3 ],
    [ "spacing", choc_spacing ], [ "spread", 0.0 ]
  ],
  [
    [ "name", "index" ], [ "rotation", -0 ], [ "offset", -7 ], [ "count", 3 ],
    [ "spacing", choc_spacing ], [ "spread", 1.0 * choc_spacing[0] ]
  ],
  [
    [ "name", "inner" ], [ "rotation", -0 ], [ "offset", -7 ], [ "count", 3 ],
    [ "spacing", choc_spacing ], [ "spread", 2.0 * choc_spacing[0] ]
  ]
],
// V2 (From MX_V5)
[
  [
    [ "name", "pinky" ], [ "rotation", 3+2], [ "offset", -8-13 ],
    [ "count", 2 ], [ "spacing", choc_spacing],
    [ "spread", -3 * mx_spacing[0] - 2 - 0.2]
  ],
  [
    [ "name", "pinky" ], [ "rotation", 3+2], [ "offset", -8-13 ],
    [ "count", 3 ], [ "spacing", choc_spacing],
    [ "spread", -2 * mx_spacing[0] - 2 - 0.2]
  ],
  [
    [ "name", "ring" ], [ "rotation", 2.0 ], [ "offset", -8 ], [ "count", 3 ],
    [ "spacing", choc_spacing ], [ "spread", -1.0 * mx_spacing[0] - 0.2 ]
  ],
  [
    [ "name", "middle" ], [ "rotation", -4.5 ], [ "offset", 0 ], [ "count", 3 ],
    [ "spacing", choc_spacing ], [ "spread", 0.2 ]
  ],
  [
    [ "name", "index" ], [ "rotation", -6-4.5 ], [ "offset", -8.5 ], [ "count", 3 ],
    [ "spacing", choc_spacing ], [ "spread", 1.0 * mx_spacing[0] + 0.5 + 0.2]
  ],
  [
    [ "name", "inner" ], [ "rotation", -6-4.5 ], [ "offset", -8.5 ], [ "count", 3 ],
    [ "spacing", choc_spacing ], [ "spread", 2.0 * mx_spacing[0] + 0.5 + 0.2]
  ]
]
];

// Thumb clusters
thumbs_data_layouts_CHOC = [
// V0 (From MX_V1)
[
  [ "ref_rotation", 88 ],
  [ "offset", 0 ],
  [ "rotation", 22 ],
  [ "ref_offset", [ 42 - 19 / 2, -28 + 19 / 2 - (mx_spacing[1]-choc_spacing[1])] ],
  [ "count", 3 ],
  [ "spacing", mx_spacing * 1.15 ],
  [ "translation_shifts", [ [ 0, 0, 0 ], [ -1.5, -0.5, 0 ], [ -3, 0, 0 ] ] ],
  [ "rotation_shifts", [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 9 ] ] ],
  [ "origin", "middle" ],
],
// V1 (From MX_V1)
[
  [ "ref_rotation", 88 ],
  [ "offset", 0 ],
  [ "rotation", 22 ],
  [ "ref_offset", [ 42 - 19 / 2, -28 + 19 / 2 - (mx_spacing[1]-choc_spacing[1])] ],
  [ "count", 3 ],
  [ "spacing", mx_spacing * 1.15 ],
  [ "translation_shifts", [ [ 0, 0, 0 ], [ -1.5, -0.5, 0 ], [ -3, 0, 0 ] ] ],
  [ "rotation_shifts", [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 9 ] ] ],
  [ "origin", "middle" ],
],
// V2 (From MX_V5)
[
  [ "ref_rotation", 90-3], // Follow orientation in between middle and index
  [ "offset", 0 ],
  [ "rotation", 17 ],
  [ "ref_offset", [ 52 - 19 , -40 + 19/2 - (mx_spacing[1]-choc_spacing[1])*2] ],
  [ "count", 3 ],
  [ "spacing", mx_spacing * 1.15],
  [ "translation_shifts", [ [ 0, 0, 0 ], [ 0, 0.0, 0 ], [ -5, 0, 0 ] ] ],
  [ "rotation_shifts", [ [ 0, 0, 0 ], [ 0, 0, 2 ], [ 0, 0, 4 ] ] ],
  [ "origin", "middle" ],
],
];


//
// LAYOUTS MX
//
columns_data_layouts_MX = [
// V0
[
  [
    [ "name", "pinky" ], [ "rotation", 0 ],
    [ "offset", -0.85 * mx_spacing[1] ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", -2.0 * mx_spacing[0] ]
  ],
  [
    [ "name", "ring" ], [ "rotation", 0 ],
    [ "offset", -0.2 * mx_spacing[1] ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", -1.0 * mx_spacing[0] ]
  ],
  [
    [ "name", "middle" ], [ "rotation", 0 ], [ "offset", 0 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 0.0 ]
  ],
  [
    [ "name", "index" ], [ "rotation", -0 ],
    [ "offset", -0.2 * mx_spacing[1] ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 1.0 * mx_spacing[0] ]
  ],
  [
    [ "name", "inner" ], [ "rotation", -0 ],
    [ "offset", -0.3 * mx_spacing[1] ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 2.0 * mx_spacing[0] ]
  ],
],
// V1
[
  [
    [ "name", "pinky" ], [ "rotation", 0 ], [ "offset", -13 - 6 ],
    [ "count", 4 ], [ "spacing", mx_spacing],
    [ "spread", -2 * mx_spacing[0] - 3 ]
  ],
  [
    [ "name", "ring" ], [ "rotation", 0 ], [ "offset", -6 ], [ "count", 4 ],
    [ "spacing", mx_spacing ], [ "spread", -1.0 * mx_spacing[0] ]
  ],
  [
    [ "name", "middle" ], [ "rotation", 0 ], [ "offset", 0 ], [ "count", 4 ],
    [ "spacing", mx_spacing ], [ "spread", 0.0 ]
  ],
  [
    [ "name", "index" ], [ "rotation", -0 ], [ "offset", -7 ], [ "count", 4 ],
    [ "spacing", mx_spacing ], [ "spread", 1.0 * mx_spacing[0] ]
  ],
  [
    [ "name", "inner" ], [ "rotation", -0 ], [ "offset", -7 ], [ "count", 4 ],
    [ "spacing", mx_spacing ], [ "spread", 2.0 * mx_spacing[0] ]
  ]
],
// V2 (Add splay and account for hand orientation)
[
  [
    [ "name", "pinky" ], [ "rotation", 7 ], [ "offset", -9-5.5 ],
    [ "count", 2 ], [ "spacing", mx_spacing],
    [ "spread", -3 * mx_spacing[0] - 1.5]
  ],
  [
    [ "name", "pinky" ], [ "rotation", 7 ], [ "offset", -9-5.5 ],
    [ "count", 3 ], [ "spacing", mx_spacing],
    [ "spread", -2 * mx_spacing[0] - 1.5]
  ],
  [
    [ "name", "ring" ], [ "rotation", 0.5 ], [ "offset", -9 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", -1.0 * mx_spacing[0] - 0.2 ]
  ],
  [
    [ "name", "middle" ], [ "rotation", -4.5 ], [ "offset", 0 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 0.2 ]
  ],
  [
    [ "name", "index" ], [ "rotation", -6-4.5 ], [ "offset", -8.5 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 1.0 * mx_spacing[0] + 0.5 + 0.2]
  ],
  [
    [ "name", "inner" ], [ "rotation", -6-4.5 ], [ "offset", -8.5 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 2.0 * mx_spacing[0] + 0.5 + 0.2]
  ]
],
// V3 (Twice the splay on pinky)
[
  [
    [ "name", "pinky" ], [ "rotation", 7 ], [ "offset", -9-11 ],
    [ "count", 2 ], [ "spacing", mx_spacing],
    [ "spread", -3 * mx_spacing[0] - 2]
  ],
  [
    [ "name", "pinky" ], [ "rotation", 7 ], [ "offset", -9-11 ],
    [ "count", 3 ], [ "spacing", mx_spacing],
    [ "spread", -2 * mx_spacing[0] - 2]
  ],
  [
    [ "name", "ring" ], [ "rotation", 0.5 ], [ "offset", -9 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", -1.0 * mx_spacing[0] - 0.2 ]
  ],
  [
    [ "name", "middle" ], [ "rotation", -4.5 ], [ "offset", 0 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 0.2 ]
  ],
  [
    [ "name", "index" ], [ "rotation", -6-4.5 ], [ "offset", -8.5 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 1.0 * mx_spacing[0] + 0.5 + 0.2]
  ],
  [
    [ "name", "inner" ], [ "rotation", -6-4.5 ], [ "offset", -8.5 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 2.0 * mx_spacing[0] + 0.5 + 0.2]
  ]
],
// V4 (Reduce pinky splay a little, Increase ring splay a little, Increase pinky stagger)
[
  [
    [ "name", "pinky" ], [ "rotation", 3+2], [ "offset", -8-13 ],
    [ "count", 2 ], [ "spacing", mx_spacing],
    [ "spread", -3 * mx_spacing[0] - 2 - 0.2]
  ],
  [
    [ "name", "pinky" ], [ "rotation", 3+2], [ "offset", -8-13 ],
    [ "count", 3 ], [ "spacing", mx_spacing],
    [ "spread", -2 * mx_spacing[0] - 2 - 0.2]
  ],
  [
    [ "name", "ring" ], [ "rotation", 2.0 ], [ "offset", -8 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", -1.0 * mx_spacing[0] - 0.2 ]
  ],
  [
    [ "name", "middle" ], [ "rotation", -4.5 ], [ "offset", 0 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 0.2 ]
  ],
  [
    [ "name", "index" ], [ "rotation", -6-4.5 ], [ "offset", -8.5 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 1.0 * mx_spacing[0] + 0.5 + 0.2]
  ],
  [
    [ "name", "inner" ], [ "rotation", -6-4.5 ], [ "offset", -8.5 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 2.0 * mx_spacing[0] + 0.5 + 0.2]
  ]
],
// V5 (perfect)
[
  [
    [ "name", "pinky" ], [ "rotation", 3+2], [ "offset", -8-13 ],
    [ "count", 2 ], [ "spacing", mx_spacing],
    [ "spread", -3 * mx_spacing[0] - 2 - 0.2]
  ],
  [
    [ "name", "pinky" ], [ "rotation", 3+2], [ "offset", -8-13 ],
    [ "count", 3 ], [ "spacing", mx_spacing],
    [ "spread", -2 * mx_spacing[0] - 2 - 0.2]
  ],
  [
    [ "name", "ring" ], [ "rotation", 2.0 ], [ "offset", -8 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", -1.0 * mx_spacing[0] - 0.2 ]
  ],
  [
    [ "name", "middle" ], [ "rotation", -4.5 ], [ "offset", 0 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 0.2 ]
  ],
  [
    [ "name", "index" ], [ "rotation", -6-4.5 ], [ "offset", -8.5 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 1.0 * mx_spacing[0] + 0.5 + 0.2]
  ],
  [
    [ "name", "inner" ], [ "rotation", -6-4.5 ], [ "offset", -8.5 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 2.0 * mx_spacing[0] + 0.5 + 0.2]
  ]
]
];

// Thumb clusters
thumbs_data_layouts_MX = [
// V0
[
  [ "ref_rotation", 82 ],
  [ "offset", 0 ],
  [ "rotation", 15 ],
  [ "ref_offset", [ -0.5 * mx_spacing[0], -0.4 * mx_spacing[1] ] ],
  [ "count", 3 ],
  [ "spacing", mx_spacing * 1.25 ],
  [ "translation_shifts", [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ] ],
  [ "rotation_shifts", [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ] ],
  [ "origin", "inner" ],
],
// V1
[
  [ "ref_rotation", 88 ],
  [ "offset", 0 ],
  [ "rotation", 22 ],
  [ "ref_offset", [ 42 - 19 / 2, -28 + 19 / 2 ] ],
  [ "count", 3 ],
  [ "spacing", mx_spacing * 1.15 ],
  [ "translation_shifts", [ [ 0, 0, 0 ], [ -1.5, -0.5, 0 ], [ -3, 0, 0 ] ] ],
  [ "rotation_shifts", [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 9 ] ] ],
  [ "origin", "middle" ],
],
// V2
[
  [ "ref_rotation", 88],
  [ "offset", 0 ],
  [ "rotation", 19 ],
  [ "ref_offset", [ 44 - 19, -37 + 19/2 ] ],
  [ "count", 3 ],
  [ "spacing", mx_spacing * 1.15 ],
  [ "translation_shifts", [ [ 0, 0, 0 ], [ 0.0, 0.0, 0 ], [ 0, 0, 0 ] ] ],
  [ "rotation_shifts", [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ] ],
  [ "origin", "middle" ],
],
// V3
[
  [ "ref_rotation", 90],
  [ "offset", 0 ],
  [ "rotation", 20 ],
  [ "ref_offset", [ 48 - 19, -38 + 19/2 ] ],
  [ "count", 3 ],
  [ "spacing", mx_spacing * 1.15],
  [ "translation_shifts", [ [ 0, 0, 0 ], [ 0.0, 0.0, 0 ], [ 0, 0, 0 ] ] ],
  [ "rotation_shifts", [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ] ],
  [ "origin", "middle" ],
],
// V4 (Follow orientation of middle, Shift home up and right down, Increase spacing)
[
  [ "ref_rotation", 90-4.5+2],
  [ "offset", 0 ],
  [ "rotation", 16 ],
  [ "ref_offset", [ 48 - 19 , -40 + 19/2 ] ],
  [ "count", 3 ],
  [ "spacing", mx_spacing * 1.25],
  [ "translation_shifts", [ [ 0, 0, 0 ], [ 2.25, 0.0, 0 ], [ -3.5, 0, 0 ] ] ],
  [ "rotation_shifts", [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ] ],
  [ "origin", "middle" ],
],
// V5 (perfect)
[
  [ "ref_rotation", 90-3], // Follow orientation in between middle and index
  [ "offset", 0 ],
  [ "rotation", 17 ],
  [ "ref_offset", [ 52 - 19 , -40 + 19/2 ] ],
  [ "count", 3 ],
  [ "spacing", mx_spacing * 1.15],
  [ "translation_shifts", [ [ 0, 0, 0 ], [ 0, 0.0, 0 ], [ -5, 0, 0 ] ] ],
  [ "rotation_shifts", [ [ 0, 0, 0 ], [ 0, 0, 2 ], [ 0, 0, 4 ] ] ],
  [ "origin", "middle" ],
],
];

// Border line
case_points = [
  [ -80, 4.617000000000001 ], [ -70, 29.768 ], [ -11.00, 60.0 ], [ 50.734, 50 ],
  [ 100, -50 ], [ 90, -80 ], [ -44.004, -30.006999999999998 ],
  [ -64.99, -13.901 ]
];

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
topPlateThickness = 1.2;
borderWidth = 4;

// Main case (shell)
maxPerColumn = 3;
maxPerRow = 6;
thumbsCount = 3;
shell_points = [
  [ -70, 16 * maxPerColumn ],
  [ -31.024, 16 * maxPerColumn ],
  [ -11.00, 16 * maxPerColumn ],
  [ 50.79, 16 * maxPerColumn ],
  [ 50.734, 16 * maxPerColumn ],
  [ maxPerRow * 14, -29 * maxPerColumn ],
  [ maxPerRow * 5, -29 * maxPerColumn ],
  [ -10, -16 * maxPerColumn ],
  [ -70, -16 * maxPerColumn ],
];
caseHeight = 10; // Pins + bottom shell of switch (3 + 2.2)
caseSidesThickness = 3;
bottomSpace = caseHeight - topPlateThickness;

trackball = [
  [ "name", "Trackball_25" ], [ "position", [ 70, 0 ] ], [ "radius", 25 / 2.0 ],
  [ "centerXY", true ]
];


// Helper function that find the column index to be used as reference for thumb position
function find_columnIndex(columnsData, thumbReferenceName, index = 0) =
    (index < len(columnsData)) ?
        (dataLookup(columnsData[index], ["name"]) == thumbReferenceName ? index :
        find_columnIndex(columnsData, thumbReferenceName, index + 1)) :
        -1;

//
// Components
//

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

// Switch
module switch_model(drawPins) {
  PG1350_model(centerXY = true, drawPins = drawPins);
}
module switch_footprint() { PG1350_footprint(centerXY = true); }
module switch_clearance() { PG1350_clearance(centerXY = true); }

// Keycaps
module keycap1U(size) {
  translate([ 0, 0, (5.0 + 2.2 + 0.8) - 3.7 / 2.0 ]) {
    color("White", 0.75) linear_extrude(3) square(size, center = true);
  }
}
module keycap15U(size) {
  translate([ 0, 0, (5.0 + 2.2 + 0.8) - 3.7 / 2.0 ]) {
    color("White", 0.75) linear_extrude(3)
        square([ size[1] * 1.5, size[0] ], center = true);
  }
}

// Case
module pcb(thickness = pcbPlateThickness) {
  translate([ 0, 0, pcbPlateBaseHeight ]) linear_extrude(thickness)
      polygon(pcb_points);
}

module top(thickness = topPlateThickness) {
  translate([ 0, 0, topPlateBaseHeight ]) linear_extrude(thickness)
      offset(delta = 0.55, chamfer = false) polygon(pcb_points);
}

module shell(offset) {
  module __shell(points, thickness, delta) {
    linear_extrude(thickness) offset(delta, chamfer = false) polygon(points);
  }

  // Translate must be called on a 3D shape to have effect
  color(rgb(238, 232, 213, 1.0)) render() difference() {
    __shell(shell_points, caseHeight, offset + caseSidesThickness);
    __shell(shell_points, caseHeight - topPlateThickness, offset);
  }
}

module switch_holder(spacing) {
  difference() {
    cube_XY(size = [ spacing[0], spacing[1], caseHeight ], centerZ = false);
    cube_XY(
        size =
            [
              spacing[0] - borderWidth, spacing[1] - borderWidth, caseHeight -
              topPlateThickness
            ],
        centerZ = false);
  }
}

module switch (cutout, drawPins = false, draw_keycaps = false, size = 1) {
  if (cutout) {
    switch_footprint();
    switch_clearance();
  } else {
    switch_model(drawPins = drawPins);
    if (draw_keycaps) {
      if (size == 1.5) {
        keycap15U(key_size);
      } else {
        keycap1U(key_size);
      }
    }
  }
}

//
// Distribution
//


module from_column(columnData) {
  rc = dataLookup(columnData, ["count"]);
  rs = dataLookup(columnData, ["spacing"]);
  ro = dataLookup(columnData, ["offset"]);
  rr = dataLookup(columnData, ["rotation"]);
  rspread = dataLookup(columnData, ["spread"]);
  rotate([ 0, 0, rr ]) translate([ rspread, 0, 0 ]) {
    place_on_line(i = -1, count = rc, spacing = rs[1], offset = ro,
                  axis = forward, center = false) {
      children();
    }
  }
}

module foreach_row(columnData) {
  cc = dataLookup(columnData, ["count"]);
  cs = dataLookup(columnData, ["spacing"]);
  cr = dataLookup(columnData, ["rotation"]);
  co = dataLookup(columnData, ["offset"]);
  cspread = dataLookup(columnData, ["spread"]);
  rotate([ 0, 0, cr ]) translate([ cspread, 0, 0 ]) {
    on_line(count = cc, spacing = cs[1], offset = co, axis = forward,
            center = false) {
      children();
    }
  }
}

module foreach_thumb(thumbData) {
  tc = dataLookup(thumbData, ["count"]);
  ts = dataLookup(thumbData, ["spacing"]);
  to = dataLookup(thumbData, ["offset"]);
  tr = dataLookup(thumbData, ["rotation"]);
  tro = dataLookup(thumbData, ["ref_offset"]);
  trr = dataLookup(thumbData, ["ref_rotation"]);
  translation_shifts = dataLookup(thumbData, ["translation_shifts"]);
  rotation_shifts = dataLookup(thumbData, ["rotation_shifts"]);

  translate([ tro[0], tro[1], 0 ]) {
    rotate([ 0, 0, trr ]) {
      for (j = [0:1:tc - 1]) {
        place_on_arc(i = j, spacing = ts[1], rotation = tr, offset = to,
                     clockwise = true, center = false, spin = true) {
          translate(v = translation_shifts[j]) rotate(a = rotation_shifts[j]){
            $foreach_thumb_child_id = j;
            {children();}
          }
        }
      }
    }
  }
}

module draw_column_holders(columnData, switchOffset = 0) {
  cs = dataLookup(columnData, ["spacing"]);
  foreach_row(columnData = columnData) {
    difference() {
      // Holders
      color(rgb(238, 232, 213, 1.0)) render() switch_holder(cs);

      // Switches
      translate(__Z(switchOffset)) switch (cutout = true, drawPins = false,
                                           draw_keycaps = false, size = 1);
    }
  }
}


module draw_thumb_holders(thumbData, switchOffset = 0) {
  ts = dataLookup(thumbData, ["spacing"]);
  foreach_thumb(thumbData = thumbData) {
    difference() {
      // Holders
      color(rgb(238, 232, 213, 1.0)) render() switch_holder(ts);

      // Switches
      translate(__Z(switchOffset)) switch (cutout = true, drawPins = false,
                                           draw_keycaps = false, size = 1);
    }
  }
}


module draw_layout(columnsData, thumbData, cutout = false, drawPins = false, draw_keycaps = false) {
  // Columns
  for (i = [0:1:len(columnsData) - 1]) {
    foreach_row(columnData = columnsData[i]) {
      switch(cutout = cutout, drawPins = drawPins, draw_keycaps = draw_keycaps, size = 1);
    }
  }

  // Thumbs
  thumbReference = dataLookup(thumbData, ["origin"]);
  columnIndex = find_columnIndex(columnsData, thumbReference);
  from_column(columnsData[columnIndex]) foreach_thumb(thumbData = thumbData) {
    // Handle 1.5U and 1U keycaps
    if (mod($foreach_thumb_child_id, 2)) {
      rotate([ 0, 0, 90 ]) {
        switch (cutout = cutout, drawPins = drawPins, draw_keycaps = draw_keycaps, size = 1);
      }
    } else {
      switch (cutout = cutout, drawPins = drawPins, draw_keycaps = draw_keycaps, size = 1.5);
    }
  }

  // Other components
  draw_components(cutout = cutout, drawPins = drawPins);
}


module draw_components(cutout = false, drawPins = false) {
  // Other components
  if (cutout) {
    // // Trackball
    // trackball_footprint();
    // trackball_clearance();
  } else {
    // trackball_model(drawPins = drawPins);
  }
}

///
/// @brief      Helper that can be used to visualize thumbs keys as defined
/// in Ptechinos
///             keyboard
///
/// @return     Nothing
///
module thumb_layout_ptechinos() {
  translate([ 28.829, -50.217 + key_spacing[1], 5 ]) rotate([ 0, 0, -10 ])
      color("yellow") switch_model();
  translate([ 50.874, -58.143 + key_spacing[1], 5 ]) rotate([ 0, 0, -25 ])
      color("yellow") switch_model();
  translate([ 70.034, -70.477 + key_spacing[1], 5 ]) rotate([ 0, 0, -40 ])
      color("yellow") switch_model();
}

//
// Assembly
//

// //
// // Column of holders
// //
// column_data = [
//   [ "name", "dd" ], [ "rotation", 0 ], [ "offset", 0 ], [ "count", 4 ],
//   [ "spacing", key_spacing ], [ "spread", 0.0 ]
// ];
// draw_column_holders(column_data, caseHeight / 2 + topPlateThickness);
// from_column(column_data) {
//   draw_thumb_holders(thumbs_data_layouts_MX[2], caseHeight / 2 + topPlateThickness);
// }

// //
// // Echinos layout of holders
// //
// for (i = [0:1:len(columns_data_layouts_MX[2]) - 1]) {
//   draw_column_holders(columns_data_layouts_MX[2][i]);
// }

// //
// // Show Ptechinos thumb cluster on top of echinos layout
// //
// translate(__Z(bottomSpace))
// {
//   draw_layout(columns_data_layouts_MX[2], thumbs_data_layouts_MX[2], cutout = false, drawPins = true, draw_keycaps = true);
//   thumb_layout_ptechinos();
// }

// //
// // Echinos layout projection
// //
// projection(cut=false)
// {
//   difference(){
//     // Case PCB / Top plates
//     // top();
//     // color(rgb(147, 161, 161, 0.5)) pcb();
//     // color(rgb(253, 246, 227, 0.5)) top();
//     // Footprints
//     draw_layout(columns_data_layouts_MX[2], thumbs_data_layouts_MX[2], cutout = true);
//   }
// }


// //
// // Echinos layout tester with case
// //
// columns_data_used = columns_data_layouts_MX[5];
// thumb_data_used = thumbs_data_layouts_MX[5];

// union() {
//   // // Holders for columns
//   // for (i = [0:1:len(columns_data_used) - 1]) {
//   //   draw_column_holders(columns_data_used[i], caseHeight / 2 + topPlateThickness);
//   // }

//   // // Holders for thumb
//   // thumbReference = dataLookup(thumb_data_used, ["origin"]);
//   // columnIndex = find_columnIndex(columns_data_used, thumbReference);
//   // from_column(columns_data_used[columnIndex]) {
//   //   draw_thumb_holders(thumb_data_used, caseHeight / 2 + topPlateThickness);
//   // }

//   // Case
//   difference() {
//     shell(offset=0);
//     translate(__Z(caseHeight / 2 + topPlateThickness)){
//       draw_layout(columns_data_used, thumb_data_used, cutout = true);
//     }
//   }

//   // // Switches
//   // %translate(__Z(caseHeight / 2 + topPlateThickness)){
//   //   draw_layout(columns_data_used, thumb_data_used, cutout = false, draw_keycaps=true);
//   // }
// }


//
// Differences
//
// References
color([0, 0.3, 1, 0.5, 1]){
  // Switches
  translate(__Z(caseHeight / 2 + topPlateThickness)){
    draw_layout(columns_data_layouts_MX[5], thumbs_data_layouts_MX[5], cutout = false, draw_keycaps=false);
  }
}

// color([1, 0.8, 0, 0.5])union(){
//   // Switches
//   translate(__Z(caseHeight / 2 + topPlateThickness)){
//     draw_layout(columns_data_layouts_MX[4], thumbs_data_layouts_MX[4], cutout = false, draw_keycaps=false);
//   }
// }


// Current
color([0.4, 0.4, 0.4])union(){
  // Switches
  translate(__Z(caseHeight / 2 + topPlateThickness))
  // translate(X__(7))
  {
    draw_layout(columns_data_layouts_CHOC[2], thumbs_data_layouts_CHOC[2], cutout = false, draw_keycaps=false);
  }
}
