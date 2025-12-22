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
  ],
  ["version", 0]
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
  ],
  ["version", 1]
],
// V2 (From MX_V5)
[
  [
    [ "name", "pinky" ], [ "rotation", 3+2], [ "offset", -8-13 ],
    [ "count", 2 ], [ "spacing", choc_spacing],
    [ "spread", -3 * choc_spacing[0] - 2 - 0.2]
  ],
  [
    [ "name", "pinky" ], [ "rotation", 3+2], [ "offset", -8-13 ],
    [ "count", 3 ], [ "spacing", choc_spacing],
    [ "spread", -2 * choc_spacing[0] - 2 - 0.2]
  ],
  [
    [ "name", "ring" ], [ "rotation", 2.0 ], [ "offset", -8 ], [ "count", 3 ],
    [ "spacing", choc_spacing ], [ "spread", -1.0 * choc_spacing[0] - 0.2 ]
  ],
  [
    [ "name", "middle" ], [ "rotation", -4.5 ], [ "offset", 0 ], [ "count", 3 ],
    [ "spacing", choc_spacing ], [ "spread", 0.2 ]
  ],
  [
    [ "name", "index" ], [ "rotation", -6-4.5 ], [ "offset", -8.5 ], [ "count", 3 ],
    [ "spacing", choc_spacing ], [ "spread", 1.0 * choc_spacing[0] + 0.5 + 0.2]
  ],
  [
    [ "name", "inner" ], [ "rotation", -6-4.5 ], [ "offset", -8.5 ], [ "count", 3 ],
    [ "spacing", choc_spacing ], [ "spread", 2.0 * choc_spacing[0] + 0.5 + 0.2]
  ],
  ["version", 2]
],
[
  [
    [ "name", "pinky" ], [ "rotation", 2+3], [ "offset", -7-16+3+mx_choc_delta_spacing[1] ],
    [ "count", 3 ], [ "spacing", choc_spacing],
    [ "spread", -3 * choc_spacing[0] - 2 - 0.2]
  ],
  [
    [ "name", "pinky_ring" ], [ "rotation", 2+3], [ "offset", -7-16+2*choc_spacing[1]+4.5+mx_choc_delta_spacing[1]*2 ],
    [ "count", 2 ], [ "spacing", choc_spacing],
    [ "spread", -2 * choc_spacing[0] - 2 - 0.2]
  ],
  [
    [ "name", "pinky" ], [ "rotation", 2+3], [ "offset", -7-16+mx_choc_delta_spacing[1] ],
    [ "count", 2 ], [ "spacing", choc_spacing],
    [ "spread", -2 * choc_spacing[0] - 2 - 0.2]
  ],
  [
    [ "name", "ring" ], [ "rotation", 3 ], [ "offset", -7+mx_choc_delta_spacing[1] ], [ "count", 4 ],
    [ "spacing", choc_spacing ], [ "spread", -1.0 * choc_spacing[0] - 0.2 ]
  ],
  [
    [ "name", "middle" ], [ "rotation", 0.0 ], [ "offset", -4+mx_choc_delta_spacing[1] ], [ "count", 4 ],
    [ "spacing", choc_spacing ], [ "spread", 0.2 ]
  ],
  [
    [ "name", "index" ], [ "rotation", 0.0 ], [ "offset", -10.5+mx_choc_delta_spacing[1] ], [ "count", 4 ],
    [ "spacing", choc_spacing ], [ "spread", 1.0 * choc_spacing[0]]
  ],
  [
    [ "name", "inner" ], [ "rotation", 0.0 ], [ "offset", -10.5+mx_choc_delta_spacing[1] ], [ "count", 4 ],
    [ "spacing", choc_spacing ], [ "spread", 2.0 * choc_spacing[0]]
  ],
  ["version", 14]  // Choc version of MX 14
],
[
  [
    [ "name", "pinky" ], [ "rotation", 2+3], [ "offset", -7-16+3+mx_choc_delta_spacing[1] ],
    [ "count", 3 ], [ "spacing", mx_choc_spacing],
    [ "spread", -3 * mx_spacing[0] - 2 - 0.2]
  ],
  [
    [ "name", "pinky_ring" ], [ "rotation", 2+3], [ "offset", -7-16+2*choc_spacing[1]+4.5+mx_choc_delta_spacing[1]*2 ],
    [ "count", 2 ], [ "spacing", mx_choc_spacing],
    [ "spread", -2 * mx_spacing[0] - 2 - 0.2]
  ],
  [
    [ "name", "pinky" ], [ "rotation", 2+3], [ "offset", -7-16+mx_choc_delta_spacing[1] ],
    [ "count", 2 ], [ "spacing", mx_choc_spacing],
    [ "spread", -2 * mx_spacing[0] - 2 - 0.2]
  ],
  [
    [ "name", "ring" ], [ "rotation", 3 ], [ "offset", -7+mx_choc_delta_spacing[1] ], [ "count", 4 ],
    [ "spacing", mx_choc_spacing ], [ "spread", -1.0 * mx_spacing[0] - 0.2 ]
  ],
  [
    [ "name", "middle" ], [ "rotation", 0.0 ], [ "offset", -4+mx_choc_delta_spacing[1] ], [ "count", 4 ],
    [ "spacing", mx_choc_spacing ], [ "spread", 0.2 ]
  ],
  [
    [ "name", "index" ], [ "rotation", 0.0 ], [ "offset", -10.5+mx_choc_delta_spacing[1] ], [ "count", 4 ],
    [ "spacing", mx_choc_spacing ], [ "spread", 1.0 * mx_spacing[0]]
  ],
  [
    [ "name", "inner" ], [ "rotation", 0.0 ], [ "offset", -10.5+mx_choc_delta_spacing[1] ], [ "count", 4 ],
    [ "spacing", mx_choc_spacing ], [ "spread", 2.0 * mx_spacing[0]]
  ],
  ["version", 15]  // Horizontal MX spacing and vertical Choc spacing
],
];

// Thumb clusters
thumbs_data_layouts_CHOC = [
// V0 (From MX_V1)
[
  [ "ref_rotation", 88 ],
  [ "offset", 0 ],
  [ "rotation", 22 ],
  [ "ref_offset", [ 42 - 19 / 2, -28 + 19 / 2 - mx_choc_delta_spacing[1]] ],
  [ "count", 3 ],
  [ "spacing", mx_spacing * 1.15 ],
  [ "translation_shifts", [ [ 0, 0, 0 ], [ -1.5, -0.5, 0 ], [ -3, 0, 0 ] ] ],
  [ "rotation_shifts", [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 9 ] ] ],
  [ "origin", "middle" ],
  [ "origin_index", 0 ],
  ["version", 0]
],
// V1 (From MX_V1)
[
  [ "ref_rotation", 88 ],
  [ "offset", 0 ],
  [ "rotation", 22 ],
  [ "ref_offset", [ 42 - 19 / 2, -28 + 19 / 2 - mx_choc_delta_spacing[1]] ],
  [ "count", 3 ],
  [ "spacing", mx_spacing * 1.15 ],
  [ "translation_shifts", [ [ 0, 0, 0 ], [ -1.5, -0.5, 0 ], [ -3, 0, 0 ] ] ],
  [ "rotation_shifts", [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 9 ] ] ],
  [ "origin", "middle" ],
  [ "origin_index", 0 ],
  [ "origin_index", 0 ],
  ["version", 1]
],
// V2 (From MX_V5)
[
  [ "ref_rotation", 90-3], // Follow orientation in between middle and index
  [ "offset", 0 ],
  [ "rotation", 17 ],
  [ "ref_offset", [ 52 - 19 , -40 + 19/2 - mx_choc_delta_spacing[1]*2] ],
  [ "count", 3 ],
  [ "spacing", mx_spacing * 1.15],
  [ "translation_shifts", [ [ 0, 0, 0 ], [ 0, 0.0, 0 ], [ -5, 0, 0 ] ] ],
  [ "rotation_shifts", [ [ 0, 0, 0 ], [ 0, 0, 2 ], [ 0, 0, 4 ] ] ],
  [ "origin", "middle" ],
  [ "origin_index", 0 ],
  ["version", 2]
],
// V3 (From MX_V6) Make sure thumbs keys are spaced using home row as reference and not bottom
[
  [ "ref_rotation", 90-3], // Follow orientation in between middle and index
  [ "offset", 0 ],
  [ "rotation", 17 ],
  [ "ref_offset", [ 52 - 19 , -40 + 19/2 - mx_choc_delta_spacing[1]*2 - 19] ],
  [ "count", 3 ],
  [ "spacing", mx_spacing * 1.15],
  [ "translation_shifts", [ [ 0, 0, 0 ], [ 0, 0.0, 0 ], [ -5, 0, 0 ] ] ],
  [ "rotation_shifts", [ [ 0, 0, 0 ], [ 0, 0, 2 ], [ 0, 0, 4 ] ] ],
  [ "origin", "middle" ],
  [ "origin_index", 1 ],
  ["version", 3]
],
[
  [ "ref_rotation", 90-3], // Follow orientation in between middle and index
  [ "offset", 0 ],
  [ "rotation", 18 ],
  [ "ref_offset", [ 52 - 19 - 3, -40 - mx_spacing[1]*1.5 + 6.5 ] ],
  [ "count", 3 ],
  [ "spacing", mx_spacing * 1.15],
  [ "translation_shifts", [ [ 0, 0, 0 ], [ 0, 0.0, 0 ], [ -5, 0, 0 ] ] ],
  [ "rotation_shifts", [ [ 0, 0, 0 ], [ 0, 0, 2 ], [ 0, 0, 4 ] ] ],
  [ "origin", "middle" ],
  [ "origin_index", 2 ],
  ["version", 12]  // Choc version of MX 12
]
];


//
// LAYOUTS MX
//
columns_data_layouts_MX = [
[
  [
    [ "name", "pinky" ], [ "rotation", 2+3], [ "offset", -7-16+3 ],
    [ "count", 3 ], [ "spacing", mx_spacing],
    [ "spread", -3 * mx_spacing[0] - 2 - 0.2]
  ],
  [
    [ "name", "pinky_ring" ], [ "rotation", 2+3], [ "offset", -7-16+2*mx_spacing[1]+4.5 ],
    [ "count", 2 ], [ "spacing", mx_spacing],
    [ "spread", -2 * mx_spacing[0] - 2 - 0.2]
  ],
  [
    [ "name", "pinky" ], [ "rotation", 2+3], [ "offset", -7-16 ],
    [ "count", 2 ], [ "spacing", mx_spacing],
    [ "spread", -2 * mx_spacing[0] - 2 - 0.2]
  ],
  [
    [ "name", "ring" ], [ "rotation", 3 ], [ "offset", -7 ], [ "count", 4 ],
    [ "spacing", mx_spacing ], [ "spread", -1.0 * mx_spacing[0] - 0.2 ]
  ],
  [
    [ "name", "middle" ], [ "rotation", 0.0 ], [ "offset", -4 ], [ "count", 4 ],
    [ "spacing", mx_spacing ], [ "spread", 0.2 ]
  ],
  [
    [ "name", "index" ], [ "rotation", 0.0 ], [ "offset", -10.5 ], [ "count", 4 ],
    [ "spacing", mx_spacing ], [ "spread", 1.0 * mx_spacing[0]]
  ],
  [
    [ "name", "inner" ], [ "rotation", 0.0 ], [ "offset", -10.5 ], [ "count", 4 ],
    [ "spacing", mx_spacing ], [ "spread", 2.0 * mx_spacing[0]]
  ],
  ["version", 14]  // Add number row
],
[
  [
    [ "name", "pinky" ], [ "rotation", 3], [ "offset", -7-16+3 ],
    [ "count", 3 ], [ "spacing", mx_spacing],
    [ "spread", -3 * mx_spacing[0] - 2 - 0.2]
  ],
  [
    [ "name", "pinky_ring" ], [ "rotation", 3], [ "offset", -7-16+2*mx_spacing[1]+4.5 ],
    [ "count", 2 ], [ "spacing", mx_spacing],
    [ "spread", -2 * mx_spacing[0] - 2 - 0.2]
  ],
  [
    [ "name", "pinky" ], [ "rotation", 3], [ "offset", -7-16 ],
    [ "count", 2 ], [ "spacing", mx_spacing],
    [ "spread", -2 * mx_spacing[0] - 2 - 0.2]
  ],
  [
    [ "name", "ring" ], [ "rotation", 3 ], [ "offset", -7 ], [ "count", 4 ],
    [ "spacing", mx_spacing ], [ "spread", -1.0 * mx_spacing[0] - 0.2 ]
  ],
  [
    [ "name", "middle" ], [ "rotation", 0.0 ], [ "offset", -2 ], [ "count", 4 ],
    [ "spacing", mx_spacing ], [ "spread", 0.2 ]
  ],
  [
    [ "name", "index" ], [ "rotation", 0.0 ], [ "offset", -10.5 ], [ "count", 4 ],
    [ "spacing", mx_spacing ], [ "spread", 1.0 * mx_spacing[0]]
  ],
  [
    [ "name", "inner" ], [ "rotation", 0.0 ], [ "offset", -10.5 ], [ "count", 4 ],
    [ "spacing", mx_spacing ], [ "spread", 2.0 * mx_spacing[0]]
  ],
  ["version", 15]  // Higher middle stagger, remove added pinky splay
],
[
  [
    [ "name", "pinky" ], [ "rotation", 3], [ "offset", -7-16+3+mx_spacing[1] ],
    [ "count", 2 ], [ "spacing", mx_spacing],
    [ "spread", -3 * mx_spacing[0] - 2 - 0.2]
  ],
  [
    [ "name", "pinky_ring" ], [ "rotation", 3], [ "offset", -7-16+2*mx_spacing[1]+4.5 ],
    [ "count", 1 ], [ "spacing", mx_spacing],
    [ "spread", -2 * mx_spacing[0] - 2 - 0.2]
  ],
  [
    [ "name", "pinky" ], [ "rotation", 3], [ "offset", -7-16 ],
    [ "count", 2 ], [ "spacing", mx_spacing],
    [ "spread", -2 * mx_spacing[0] - 2 - 0.2]
  ],
  [
    [ "name", "ring" ], [ "rotation", 3 ], [ "offset", -7 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", -1.0 * mx_spacing[0] - 0.2 ]
  ],
  [
    [ "name", "middle" ], [ "rotation", 0.0 ], [ "offset", -2 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 0.2 ]
  ],
  [
    [ "name", "index" ], [ "rotation", 0.0 ], [ "offset", -10.5 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 1.0 * mx_spacing[0]]
  ],
  [
    [ "name", "inner" ], [ "rotation", 0.0 ], [ "offset", -10.5 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 2.0 * mx_spacing[0]]
  ],
  ["version", 16]  // Higher middle stagger, remove added pinky splay
],
[
  [
    [ "name", "pinky" ], [ "rotation", 3], [ "offset", -6-15+3+mx_spacing[1] ],
    [ "count", 2 ], [ "spacing", mx_spacing],
    [ "spread", -3 * mx_spacing[0] - 2 - 0.2]
  ],
  [
    [ "name", "pinky_ring" ], [ "rotation", 3], [ "offset", -6-15+2*mx_spacing[1]+4.5 ],
    [ "count", 1 ], [ "spacing", mx_spacing],
    [ "spread", -2 * mx_spacing[0] - 2 - 0.2]
  ],
  [
    [ "name", "pinky" ], [ "rotation", 3], [ "offset", -6-15 ],
    [ "count", 2 ], [ "spacing", mx_spacing],
    [ "spread", -2 * mx_spacing[0] - 2 - 0.2]
  ],
  [
    [ "name", "ring" ], [ "rotation", 3 ], [ "offset", -6 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", -1.0 * mx_spacing[0] - 0.2 ]
  ],
  [
    [ "name", "middle" ], [ "rotation", 0.0 ], [ "offset", -2 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 0.2 ]
  ],
  [
    [ "name", "index" ], [ "rotation", 0.0 ], [ "offset", -10.5 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 1.0 * mx_spacing[0]]
  ],
  [
    [ "name", "inner" ], [ "rotation", 0.0 ], [ "offset", -10.5 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 2.0 * mx_spacing[0]]
  ],
  ["version", 17]  // Upper ring and pinky
],
[
  [
    [ "name", "pinky" ], [ "rotation", 3], [ "offset", -6-13+3+mx_spacing[1] ],
    [ "count", 2 ], [ "spacing", mx_spacing],
    [ "spread", -3 * mx_spacing[0] - 2 - 0.2]
  ],
  [
    [ "name", "pinky_ring" ], [ "rotation", 3], [ "offset", -6-13+2*mx_spacing[1]+4.5 ],
    [ "count", 1 ], [ "spacing", mx_spacing],
    [ "spread", -2 * mx_spacing[0] - 2 - 0.2]
  ],
  [
    [ "name", "pinky" ], [ "rotation", 3], [ "offset", -6-13 ],
    [ "count", 2 ], [ "spacing", mx_spacing],
    [ "spread", -2 * mx_spacing[0] - 2 - 0.2]
  ],
  [
    [ "name", "ring" ], [ "rotation", 3 ], [ "offset", -6 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", -1.0 * mx_spacing[0] - 0.2 ]
  ],
  [
    [ "name", "middle" ], [ "rotation", 0.0 ], [ "offset", -2 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 0.2 ]
  ],
  [
    [ "name", "index" ], [ "rotation", 0.0 ], [ "offset", -10.5 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 1.0 * mx_spacing[0]]
  ],
  [
    [ "name", "inner" ], [ "rotation", 0.0 ], [ "offset", -10.5 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 2.0 * mx_spacing[0]]
  ],
  ["version", 18]  // Upper pinky
],
[
  [
    [ "name", "pinky" ], [ "rotation", 3], [ "offset", -6-14+3+mx_spacing[1] ],
    [ "count", 2 ], [ "spacing", mx_spacing],
    [ "spread", -3 * mx_spacing[0] - 2 - 0.2]
  ],
  [
    [ "name", "pinky_ring" ], [ "rotation", 3], [ "offset", -6-14+2*mx_spacing[1]+4.5 ],
    [ "count", 1 ], [ "spacing", mx_spacing],
    [ "spread", -2 * mx_spacing[0] - 2 - 0.2]
  ],
  [
    [ "name", "pinky" ], [ "rotation", 3], [ "offset", -6-14 ],
    [ "count", 2 ], [ "spacing", mx_spacing],
    [ "spread", -2 * mx_spacing[0] - 2 - 0.2]
  ],
  [
    [ "name", "ring" ], [ "rotation", 3 ], [ "offset", -6 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", -1.0 * mx_spacing[0] - 0.2 ]
  ],
  [
    [ "name", "middle" ], [ "rotation", 0.0 ], [ "offset", -2 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 0.2 ]
  ],
  [
    [ "name", "index" ], [ "rotation", 0.0 ], [ "offset", -10.5 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 1.0 * mx_spacing[0]]
  ],
  [
    [ "name", "inner" ], [ "rotation", 0.0 ], [ "offset", -10.5 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 2.0 * mx_spacing[0]]
  ],
  ["version", 19]  // Lower pinky
],
[
[
    [ "name", "ringOuter" ], [ "rotation", 3], [ "offset", -6-14+1.8*mx_spacing[1]+4.5 ],
    [ "count", 1 ], [ "spacing", mx_spacing],
    [ "spread", -3 * mx_spacing[0] - 0.2]
  ],
  [
    [ "name", "pinkyOuter" ], [ "rotation", 3], [ "offset", -6-14+mx_spacing[1]*0.7 ],
    [ "count", 1 ], [ "spacing", mx_spacing],
    [ "spread", -3 * mx_spacing[0] - 0.2]
  ],
  [
    [ "name", "pinky_ring" ], [ "rotation", 3], [ "offset", -6-14+2*mx_spacing[1]+4.5 ],
    [ "count", 1 ], [ "spacing", mx_spacing],
    [ "spread", -2 * mx_spacing[0] - 0.2]
  ],
  [
    [ "name", "pinky" ], [ "rotation", 3], [ "offset", -6-14 ],
    [ "count", 2 ], [ "spacing", mx_spacing],
    [ "spread", -2 * mx_spacing[0] - 0.2]
  ],
  [
    [ "name", "ring" ], [ "rotation", 3 ], [ "offset", -6 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", -1.0 * mx_spacing[0] - 0.2 ]
  ],
  [
    [ "name", "middle" ], [ "rotation", 0.0 ], [ "offset", -2 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 0.2 ]
  ],
  [
    [ "name", "index" ], [ "rotation", 0.0 ], [ "offset", -6 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 1.0 * mx_spacing[0]]
  ],
  [
    [ "name", "inner" ], [ "rotation", 0.0 ], [ "offset", -6 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 2.0 * mx_spacing[0]]
  ],
  ["version", 20]  // Remove splay use when pinky was oriented, upper index
],
[
  [
    [ "name", "outer_ring" ], [ "rotation", 5], [ "offset", -5-13+2*mx_spacing[1]+3 ],
    [ "count", 1 ], [ "spacing", mx_spacing],
    [ "spread", -3 * mx_spacing[0] - 0.5]
  ],
  [
    [ "name", "outer_pinky" ], [ "rotation", 5], [ "offset", -5-13+mx_spacing[1] ],
    [ "count", 1 ], [ "spacing", mx_spacing],
    [ "spread", -3 * mx_spacing[0] - 0.5]
  ],
  [
    [ "name", "pinky_ring" ], [ "rotation", 5], [ "offset", -5-13+2*mx_spacing[1]+5 ],
    [ "count", 1 ], [ "spacing", mx_spacing],
    [ "spread", -2 * mx_spacing[0] - 0.5]
  ],
  [
    [ "name", "pinky" ], [ "rotation", 5], [ "offset", -5-13 ],
    [ "count", 2 ], [ "spacing", mx_spacing],
    [ "spread", -2 * mx_spacing[0] - 0.5]
  ],
  [
    [ "name", "ring" ], [ "rotation", 5 ], [ "offset", -5 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", -1.0 * mx_spacing[0] - 0.5 ]
  ],
  [
    [ "name", "middle" ], [ "rotation", 0.0 ], [ "offset", -2 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 0.2 ]
  ],
  [
    [ "name", "index" ], [ "rotation", 0.0 ], [ "offset", -6 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 1.0 * mx_spacing[0]]
  ],
  [
    [ "name", "inner" ], [ "rotation", 0.0 ], [ "offset", -6 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 2.0 * mx_spacing[0]]
  ],
  ["version", 21]  // Higher ring splay
],
[
  [
    [ "name", "outer_ring" ], [ "rotation", 5], [ "offset", -6-14+2*mx_spacing[1]+3 ],
    [ "count", 1 ], [ "spacing", mx_spacing],
    [ "spread", -3 * mx_spacing[0] - 0.5]
  ],
  [
    [ "name", "outer_pinky" ], [ "rotation", 5], [ "offset", -6-14+mx_spacing[1] ],
    [ "count", 1 ], [ "spacing", mx_spacing],
    [ "spread", -3 * mx_spacing[0] - 0.5]
  ],
  [
    [ "name", "pinky_ring" ], [ "rotation", 5], [ "offset", -6-14+2*mx_spacing[1]+5 ],
    [ "count", 1 ], [ "spacing", mx_spacing],
    [ "spread", -2 * mx_spacing[0] - 0.5]
  ],
  [
    [ "name", "pinky" ], [ "rotation", 5], [ "offset", -6-14 ],
    [ "count", 2 ], [ "spacing", mx_spacing],
    [ "spread", -2 * mx_spacing[0] - 0.5]
  ],
  [
    [ "name", "ring" ], [ "rotation", 5 ], [ "offset", -6 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", -1.0 * mx_spacing[0] - 0.5 ]
  ],
  [
    [ "name", "middle" ], [ "rotation", 0.0 ], [ "offset", -2 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 0.2 ]
  ],
  [
    [ "name", "index" ], [ "rotation", 0.0 ], [ "offset", -6 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 1.0 * mx_spacing[0]]
  ],
  [
    [ "name", "inner" ], [ "rotation", 0.0 ], [ "offset", -6 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 2.0 * mx_spacing[0]]
  ],
  ["version", 22]  // Lower pinky and ring
],
[
  [
    [ "name", "outer_pinky" ], [ "rotation", 5], [ "offset", -3-14+mx_spacing[1] ],
    [ "count", 2 ], [ "spacing", mx_spacing],
    [ "spread", -3 * mx_spacing[0] - 0.5]
  ],
  [
    [ "name", "pinky" ], [ "rotation", 5], [ "offset", -1-14 ],
    [ "count", 3 ], [ "spacing", mx_spacing],
    [ "spread", -2 * mx_spacing[0] - 0.5]
  ],
  [
    [ "name", "ring" ], [ "rotation", 5 ], [ "offset", -6 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", -1.0 * mx_spacing[0] - 0.5 ]
  ],
  [
    [ "name", "middle" ], [ "rotation", 0.0 ], [ "offset", -2 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 0.2 ]
  ],
  [
    [ "name", "index" ], [ "rotation", 0.0 ], [ "offset", -6 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 1.0 * mx_spacing[0]]
  ],
  [
    [ "name", "inner" ], [ "rotation", 0.0 ], [ "offset", -6 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 2.0 * mx_spacing[0]]
  ],
  ["version", 23]  // Higher pinky and ring + Reduce spread --> Open more the hand
],
[
  [
    [ "name", "outer_pinky" ], [ "rotation", 5], [ "offset", 2+-3-14+mx_spacing[1] ],
    [ "count", 2 ], [ "spacing", mx_spacing],
    [ "spread", -3 * mx_spacing[0] - 0.5]
  ],
  [
    [ "name", "pinky_ring" ], [ "rotation", 5], [ "offset", -3-14+2*mx_spacing[1]+3 ],
    [ "count", 1 ], [ "spacing", mx_spacing],
    [ "spread", -2 * mx_spacing[0] - 0.5]
  ],
  [
    [ "name", "pinky" ], [ "rotation", 5], [ "offset", -3-14 ],
    [ "count", 2 ], [ "spacing", mx_spacing],
    [ "spread", -2 * mx_spacing[0] - 0.5]
  ],
  [
    [ "name", "ring" ], [ "rotation", 5 ], [ "offset", -6 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", -1.0 * mx_spacing[0] - 0.5 ]
  ],
  [
    [ "name", "middle" ], [ "rotation", 0.0 ], [ "offset", -2 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 0.2 ]
  ],
  [
    [ "name", "index" ], [ "rotation", 0.0 ], [ "offset", -6 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 1.0 * mx_spacing[0]]
  ],
  [
    [ "name", "inner" ], [ "rotation", 0.0 ], [ "offset", -6 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 2.0 * mx_spacing[0]]
  ],
  ["version", 24]  // Higher pinky and ring + Reduce spread --> Open more the hand
],
[
  [
    [ "name", "outer_pinky" ], [ "rotation", 0], [ "offset", -6-14+mx_spacing[1] ],
    [ "count", 2 ], [ "spacing", mx_spacing],
    [ "spread", -3 * mx_spacing[0] - 0.0]
  ],
  [
    [ "name", "pinky_ring" ], [ "rotation", 0], [ "offset", -3-14+2*mx_spacing[1] ],
    [ "count", 1 ], [ "spacing", mx_spacing],
    [ "spread", -2 * mx_spacing[0] - 0.0]
  ],
  [
    [ "name", "pinky" ], [ "rotation", 0], [ "offset", -6-14 ],
    [ "count", 2 ], [ "spacing", mx_spacing],
    [ "spread", -2 * mx_spacing[0] - 0.0]
  ],
  [
    [ "name", "ring" ], [ "rotation", 0], [ "offset", -6 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", -1.0 * mx_spacing[0] - 0.0 ]
  ],
  [
    [ "name", "middle" ], [ "rotation", 0.0 ], [ "offset", -2 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 0.0 ]
  ],
  [
    [ "name", "index" ], [ "rotation", 0.0 ], [ "offset", -6 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 1.0 * mx_spacing[0]]
  ],
  [
    [ "name", "inner" ], [ "rotation", 0.0 ], [ "offset", -6 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 2.0 * mx_spacing[0]]
  ],
  ["version", 25]  // Higher pinky and ring + Reduce spread --> Open more the hand
],
[
  [
    [ "name", "outer_pinky" ], [ "rotation", 0], [ "offset", -3-14+mx_spacing[1] ],
    [ "count", 2 ], [ "spacing", mx_spacing],
    [ "spread", -3 * mx_spacing[0] - 0.0]
  ],
  [
    [ "name", "pinky_ring" ], [ "rotation", 0], [ "offset", 1-3-14+2*mx_spacing[1] ],
    [ "count", 1 ], [ "spacing", mx_spacing],
    [ "spread", -2 * mx_spacing[0] - 0.0]
  ],
  [
    [ "name", "pinky" ], [ "rotation", 0], [ "offset", -3-14 ],
    [ "count", 2 ], [ "spacing", mx_spacing],
    [ "spread", -2 * mx_spacing[0] - 0.0]
  ],
  [
    [ "name", "ring" ], [ "rotation", 0], [ "offset", -6 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", -1.0 * mx_spacing[0] - 0.0 ]
  ],
  [
    [ "name", "middle" ], [ "rotation", 0.0 ], [ "offset", -2 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 0.0 ]
  ],
  [
    [ "name", "index" ], [ "rotation", 0.0 ], [ "offset", -6 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 1.0 * mx_spacing[0]]
  ],
  [
    [ "name", "inner" ], [ "rotation", 0.0 ], [ "offset", -6 ], [ "count", 3 ],
    [ "spacing", mx_spacing ], [ "spread", 2.0 * mx_spacing[0]]
  ],
  ["version", 26]  // Higher pinky and ring + Reduce spread --> Open more the hand
],
[
  [
    [ "name", "outer_pinky" ], [ "rotation", 0], [ "offset", -6+3-14+mx_spacing[1] ],
    [ "count", 2 ], [ "spacing", mx_spacing],
    [ "spread", -3 * mx_spacing[0]]
  ],
  [
    [ "name", "pinky" ], [ "rotation", 0], [ "offset", -6+3-14 ],
    [ "count", 4 ], [ "spacing", mx_spacing],
    [ "spread", -2 * mx_spacing[0]]
  ],
  [
    [ "name", "ring" ], [ "rotation", 0], [ "offset", -6 ], [ "count", 4 ],
    [ "spacing", mx_spacing ], [ "spread", -1.0 * mx_spacing[0] - 0.0 ]
  ],
  [
    [ "name", "middle" ], [ "rotation", 0.0 ], [ "offset", -2 ], [ "count", 4 ],
    [ "spacing", mx_spacing ], [ "spread", 0.0 ]
  ],
  [
    [ "name", "index" ], [ "rotation", 0.0 ], [ "offset", -6 ], [ "count", 4 ],
    [ "spacing", mx_spacing ], [ "spread", 1.0 * mx_spacing[0]]
  ],
  [
    [ "name", "inner" ], [ "rotation", 0.0 ], [ "offset", -6 ], [ "count", 4 ],
    [ "spacing", mx_spacing ], [ "spread", 2.0 * mx_spacing[0]]
  ],
  ["version", 27]  // Higher pinky and ring + Reduce spread --> Open more the hand
],
];

// Thumb clusters
thumbs_data_layouts_MX = [
[
  [ "ref_rotation", 90-1], // Follow orientation in between middle and index
  [ "offset", 0 ],
  [ "rotation", 18 ],
  [ "ref_offset", [ 52 - 19 - 4, -40 + 19/2 - 19 + 4.5 ] ],
  [ "count", 3 ],
  [ "spacing", mx_spacing * 1.15],
  [ "translation_shifts", [ [ 0, 0, 0 ], [ 0, 0.0, 0 ], [ -5, 0, 0 ] ] ],
  [ "rotation_shifts", [ [ 0, 0, 0 ], [ 0, 0, 2 ], [ 0, 0, 4 ] ] ],
  [ "origin", "middle" ],
  [ "origin_index", 1 ],
  ["version", 13]  // Adjust offset change in colums 15, thumbs shift inner (rotation + translationH)
],
[
  [ "ref_rotation", 90], // Follow orientation in between middle and index
  [ "offset", 0 ],
  [ "rotation", 18 ],
  [ "ref_offset", [ 52 - 19 - 6, -40 + 19/2 - 19 + 6.5 ] ],
  [ "count", 3 ],
  [ "spacing", mx_spacing * 1.15],
  [ "translation_shifts", [ [ 0, 0, 0 ], [ 0, 0.0, 0 ], [ -5, 0, 0 ] ] ],
  [ "rotation_shifts", [ [ 0, 0, 0 ], [ 0, 0, 2 ], [ 0, 0, 4 ] ] ],
  [ "origin", "middle" ],
  [ "origin_index", 1 ],
  ["version", 14]  // thumbs shift inner again (rotation + translationHV )
],
[
  [ "ref_rotation", 90], // Follow orientation in between middle and index
  [ "offset", 0 ],
  [ "rotation", 18 ],
  [ "ref_offset", [ 52 - 19 - 5, -40 + 19/2 - 19 + 5.5 ] ],
  [ "count", 3 ],
  [ "spacing", mx_spacing * 1.15],
  [ "translation_shifts", [ [ 0, 0, 0 ], [ 0, 0.0, 0 ], [ -5, 0, 0 ] ] ],
  [ "rotation_shifts", [ [ 0, 0, 0 ], [ 0, 0, 2 ], [ 0, 0, 4 ] ] ],
  [ "origin", "middle" ],
  [ "origin_index", 1 ],
  ["version", 15]  // thumbs shift inner again (rotation + translationHV )
],
[
  [ "ref_rotation", 90+4],
  [ "offset", 0 ],
  [ "rotation", 18 ],
  [ "ref_offset", [ 52 - 19 - 4, -40 + 19/2 - 19 + 14.5 ] ],
  [ "count", 3 ],
  [ "spacing", mx_spacing * 1.15],
  [ "translation_shifts", [ [ 0, 0, 0 ], [ 0, 0.0, 0 ], [ -5, 0, 0 ] ] ],
  [ "rotation_shifts", [ [ 0, 0, 0 ], [ 0, 0, 2 ], [ 0, 0, 4 ] ] ],
  [ "origin", "middle" ],
  [ "origin_index", 1 ],
  ["version", 16]  // Same as 13 but shift up to use tip of thumb (+10) + increase ref rotation (+5)
],
[
  [ "ref_rotation", 90+2],
  [ "offset", 0 ],
  [ "rotation", 17 ],
  [ "ref_offset", [ 52 - 19 - 3, -40 + 19/2 - 19 + 12.5 ] ],
  [ "count", 3 ],
  [ "spacing", mx_spacing * 1.15],
  [ "translation_shifts", [ [ 0, 0, 0 ], [ 0, 0.0, 0 ], [ -5, 0, 0 ] ] ],
  [ "rotation_shifts", [ [ 0, 0, 0 ], [ 0, 0, 2 ], [ 0, 0, 4 ] ] ],
  [ "origin", "middle" ],
  [ "origin_index", 1 ],
  ["version", 17]  // Thumb shift outer, less rotation, shift down
],
[
  [ "ref_rotation", 90+12],
  [ "offset", 0 ],
  [ "rotation", 18 ],
  [ "ref_offset", [ 52 - 19 - 5, -40 + 19/2 - 19 + 14.5 ] ],
  [ "count", 3 ],
  [ "spacing", mx_spacing * 1.15],
  [ "translation_shifts", [ [ 0, 0, 0 ], [ 0, 0.0, 0 ], [ -5, 0, 0 ] ] ],
  [ "rotation_shifts", [ [ 0, 0, 0 ], [ 0, 0, 2 ], [ 0, 0, 4 ] ] ],
  [ "origin", "middle" ],
  [ "origin_index", 1 ],
  ["version", 18]  // Rotated and move inward, shift up a little
],
[
  [ "ref_rotation", 90+10],
  [ "offset", 0 ],
  [ "rotation", 17 ],
  [ "ref_offset", [ 52 - 19 - 5, -40 + 19/2 - 19 + 14.5 ] ],
  [ "count", 3 ],
  [ "spacing", mx_spacing * 1.1],
  [ "translation_shifts", [ [ 0, 0, 0 ], [ 2, 0.0, 0 ], [ -3, 0, 0 ] ] ],
  [ "rotation_shifts", [ [ 0, 0, 0 ], [ 0, 0, 4 ], [ 0, 0, 7 ] ] ],
  [ "origin", "middle" ],
  [ "origin_index", 1 ],
  ["version", 19]  // Decrease inner rotation and step, Upper middle and outer translation
],
[
  [ "ref_rotation", 90+10],
  [ "offset", 0 ],
  [ "rotation", 17 ],
  [ "ref_offset", [ 52 - 19 - 4, -40 + 19/2 - 19 + 14.5 ] ],
  [ "count", 3 ],
  [ "spacing", mx_spacing * 1.1],
  [ "translation_shifts", [ [ 0, 0, 0 ], [ 2, 0.0, 0 ], [ -2, 1, 0 ] ] ],
  [ "rotation_shifts", [ [ 0, 0, 0 ], [ 0, 0, 2 ], [ 0, 0, 6 ] ] ],
  [ "origin", "middle" ],
  [ "origin_index", 1 ],
  ["version", 20]  // Upper middle and outer, move outward a little, Middle more rotated outward
],
[
  [ "ref_rotation", 90+10],
  [ "offset", 0 ],
  [ "rotation", 17 ],
  [ "ref_offset", [ 52 - 19 - 4, -40 + 19/2 - 19 + 13.5 ] ],
  [ "count", 3 ],
  [ "spacing", mx_spacing * 1.1],
  [ "translation_shifts", [ [ 0, 0, 0 ], [ 1, 0.0, 0 ], [ -4, 1, 0 ] ] ],
  [ "rotation_shifts", [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 6 ] ] ],
  [ "origin", "middle" ],
  [ "origin_index", 1 ],
  ["version", 21]  // Mix 18 (inner middle relation) and 19 (middle outer relation), Lower cluster
],
[
  [ "ref_rotation", 90+10],
  [ "offset", 0 ],
  [ "rotation", 17 ],
  [ "ref_offset", [ 52 - 19 - 3, -40 + 19/2 - 19 + 10.5 ] ],
  [ "count", 3 ],
  [ "spacing", mx_spacing * 1.1],
  [ "translation_shifts", [ [ 0, 0, 0 ], [ 1, 0.0, 0 ], [ -4, 0, 0 ] ] ],
  [ "rotation_shifts", [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 6 ] ] ],
  [ "origin", "middle" ],
  [ "origin_index", 1 ],
  ["version", 22]  // Lower and outer, remove inner shift for outer key
],
[
  [ "ref_rotation", 90+10],
  [ "offset", 0 ],
  [ "rotation", 17 ],
  [ "ref_offset", [ 52 - 19 - 3, -40 + 19/2 - 19 + 10 ] ],
  [ "count", 3 ],
  [ "spacing", mx_spacing * 1.1],
  [ "translation_shifts", [ [ 0, 0, 0 ], [ 1, 0.0, 0 ], [ -3, 0, 0 ] ] ],
  [ "rotation_shifts", [ [ 0, 0, -3 ], [ 0, 0, 0 ], [ 0, 0, 6 ] ] ],
  [ "origin", "middle" ],
  [ "origin_index", 1 ],
  ["version", 23]  // Reduce inner rotation, outer upper
],
[
  [ "ref_rotation", 90+10],
  [ "offset", 0 ],
  [ "rotation", 18 ],
  [ "ref_offset", [ 52 - 19 - 3, -40 + 19/2 - 19 + 12 ] ],
  [ "count", 3 ],
  [ "spacing", mx_spacing * 1.1],
  [ "translation_shifts", [ [ 1, 0, 0 ], [ 0, 0.0, 0 ], [ -3, 0, 0 ] ] ],
  [ "rotation_shifts", [ [ 0, 0, -4 ], [ 0, 0, 0 ], [ 0, 0, 8 ] ] ],
  [ "origin", "middle" ],
  [ "origin_index", 1 ],
  ["version", 24]  // Upper, more outward rotation
],
[
  [ "ref_rotation", 90+10],
  [ "offset", 0 ],
  [ "rotation", 18 ],
  [ "ref_offset", [ 52 - 19 - 4, -40 + 19/2 - 19 + 12 ] ],
  [ "count", 3 ],
  [ "spacing", mx_spacing * 1.1],
  [ "translation_shifts", [ [ 1, 0, 0 ], [ 0, 0.0, 0 ], [ -4, 0, 0 ] ] ],
  [ "rotation_shifts", [ [ 0, 0, -4 ], [ 0, 0, 0 ], [ 0, 0, 6 ] ] ],
  [ "origin", "middle" ],
  [ "origin_index", 1 ],
  ["version", 25]  // move inner, outer lower and outward
],
[
  [ "ref_rotation", 90+10],
  [ "offset", 0 ],
  [ "rotation", 18 ],
  [ "ref_offset", [ 52 - 19 - 3, -40 + 19/2 - 19 + 15 ] ],
  [ "count", 3 ],
  [ "spacing", mx_spacing * 1.1],
  [ "translation_shifts", [ [ 0, 0, 0 ], [ 0, 0.0, 0 ], [ -4, 0, 0 ] ] ],
  [ "rotation_shifts", [ [ 0, 0, -6 ], [ 0, 0, 0 ], [ 0, 0, 6 ] ] ],
  [ "origin", "middle" ],
  [ "origin_index", 1 ],
  ["version", 26]  // Move all up and outer, move middle up more, reduce inward rotation of inner
],
[
  [ "ref_rotation", 90+5],
  [ "offset", 0 ],
  [ "rotation", 18 ],
  [ "ref_offset", [ 52 - 19 - 2, -40 + 19/2 - 19 + 15 ] ],
  [ "count", 3 ],
  [ "spacing", mx_spacing * 1.1],
  [ "translation_shifts", [ [ 0, 0, 0 ], [ 0, 0.0, 0 ], [ -4, 0, 0 ] ] ],
  [ "rotation_shifts", [ [ 0, 0, -6 ], [ 0, 0, 0 ], [ 0, 0, 6 ] ] ],
  [ "origin", "middle" ],
  [ "origin_index", 1 ],
  ["version", 27]  // Outer (rotation and translation)
],
[
  [ "ref_rotation", 90+8],
  [ "offset", 0 ],
  [ "rotation", 18 ],
  [ "ref_offset", [ 52 - 19 - 4, -40 + 19/2 - 19 + 15 ] ],
  [ "count", 3 ],
  [ "spacing", mx_spacing * 1.1],
  [ "translation_shifts", [ [ 0, 0, 0 ], [ 0, 0.0, 0 ], [ -4, 0, 0 ] ] ],
  [ "rotation_shifts", [ [ 0, 0, -6 ], [ 0, 0, 0 ], [ 0, 0, 6 ] ] ],
  [ "origin", "middle" ],
  [ "origin_index", 1 ],
  ["version", 28]  // Inner (rotation and translation)
],
[
  [ "ref_rotation", 90+5],
  [ "offset", 0 ],
  [ "rotation", 19 ],
  [ "ref_offset", [ 52 - 19 - 2, -40 + 19/2 - 19 + 13 ] ],
  [ "count", 3 ],
  [ "spacing", mx_spacing * 1.1],
  [ "translation_shifts", [ [ 0, 0, 0 ], [ 0, 0.0, 0 ], [ -4, 0, 0 ] ] ],
  [ "rotation_shifts", [ [ 0, 0, -6 ], [ 0, 0, 0 ], [ 0, 0, 6 ] ] ],
  [ "origin", "middle" ],
  [ "origin_index", 1 ],
  ["version", 29]  // Back to 27 but lower and more rotation
],
[
  [ "ref_rotation", 91],
  [ "offset", 0 ],
  [ "rotation", 18 ],
  [ "ref_offset", [ 52 - 19 - 2, -40 + 19/2 - 19 + 16 ] ],
  [ "count", 3 ],
  [ "spacing", mx_spacing * 1.1],
  [ "translation_shifts", [ [ 0, 0, 0 ], [ -1, 0.0, 0 ], [ -4, -1, 0 ] ] ],
  [ "rotation_shifts", [ [ 0, 0, -6 ], [ 0, 0, 0 ], [ 0, 0, 2 ] ] ],
  [ "origin", "middle" ],
  [ "origin_index", 1 ],
  ["version", 30]  // Inner is now higher with increased outer rotation
],
[
  [ "ref_rotation", 91],
  [ "offset", 0 ],
  [ "rotation", 19 ],
  [ "ref_offset", [ 52 - 19 -4 , -40 + 19/2 - 19 + 16 ] ],
  [ "count", 3 ],
  [ "spacing", mx_spacing * 1.1],
  [ "translation_shifts", [ [ 0, 0, 0 ], [ -1, 0.0, 0 ], [ -4, -1, 0 ] ] ],
  [ "rotation_shifts", [ [ 0, 0, -6 ], [ 0, 0, 0 ], [ 0, 0, 2 ] ] ],
  [ "origin", "middle" ],
  [ "origin_index", 1 ],
  ["version", 31]  // Inner translation, outer rotation
],
[
  [ "ref_rotation", 90],
  [ "offset", 0 ],
  [ "rotation", 18 ],
  [ "ref_offset", [ 52 - 19 -4 , -40 + 19/2 - 19 + 16 ] ],
  [ "count", 3 ],
  [ "spacing", mx_spacing * 1.1],
  [ "translation_shifts", [ [ 2, 0, 0 ], [ 0, 0, 0 ], [ -2, -1, 0 ] ] ],
  [ "rotation_shifts", [ [ 0, 0, -6 ], [ 0, 0, 2 ], [ 0, 0, 2 ] ] ],
  [ "origin", "middle" ],
  [ "origin_index", 1 ],
  ["version", 32]  //
],
[
  [ "ref_rotation", 92],
  [ "offset", 0 ],
  [ "rotation", 19 ],
  [ "ref_offset", [ 52 - 19 -5 , -40 + 19/2 - 19 + 16 ] ],
  [ "count", 3 ],
  [ "spacing", mx_spacing * 1.1],
  [ "translation_shifts", [ [ 4, 0, 0 ], [ 0, 0, 0 ], [ -3, -1, 0 ] ] ],
  [ "rotation_shifts", [ [ 0, 0, -6 ], [ 0, 0, 0 ], [ 0, 0, 2 ] ] ],
  [ "origin", "middle" ],
  [ "origin_index", 1 ],
  ["version", 33]  //
],
[
  [ "ref_rotation", 92],
  [ "offset", 0 ],
  [ "rotation", 20 ],
  [ "ref_offset", [ 52 - 19 - 3 , -40 + 19/2 - 19 + 16 ] ],
  [ "count", 3 ],
  [ "spacing", mx_spacing * 1.1],
  [ "translation_shifts", [ [ 4, 0, 0 ], [ -1, 0, 0 ], [ -4, -1, 0 ] ] ],
  [ "rotation_shifts", [ [ 0, 0, -6 ], [ 0, 0, 0 ], [ 0, 0, 2 ] ] ],
  [ "origin", "middle" ],
  [ "origin_index", 1 ],
  ["version", 34]  //
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
  [ maxPerRow * 15, -11 * max(maxPerRow, maxPerColumn) ],
  [ maxPerRow * 5, -10 * max(maxPerRow, maxPerColumn) ],
  [ -10, -5.5 * max(maxPerRow, maxPerColumn) ],
  [ -70, -5.5 * max(maxPerRow, maxPerColumn) ],
];
caseHeight = 10; // Pins + bottom shell of switch (3 + 2.2)
caseSidesThickness = 3;
bottomSpace = caseHeight - topPlateThickness;

trackball = [
  [ "name", "Trackball_25" ], [ "position", [ 70, 0 ] ], [ "radius", 25 / 2.0 ],
  [ "centerXY", true ]
];


// Helper function that find the column index to be used as reference for thumb position
function findIndex(collection, key, value, index = 0) =
    (index < len(collection)) ?
        (dataLookup(collection[index], [key]) == value ? index :
        findIndex(collection, key, value, index + 1)) :
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


module from_column(columnData, index=0) {
  rc = dataLookup(columnData, ["count"]);
  rs = dataLookup(columnData, ["spacing"]);
  ro = dataLookup(columnData, ["offset"]);
  rr = dataLookup(columnData, ["rotation"]);
  rspread = dataLookup(columnData, ["spread"]);
  rotate([ 0, 0, rr ]) translate([ rspread, 0, 0 ]) {
    place_on_line(i = index-1, count = rc, spacing = rs[1], offset = ro,
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
  for (i = [0:1:len(columnsData) - 2]) {
    foreach_row(columnData = columnsData[i]) {
      switch(cutout = cutout, drawPins = drawPins, draw_keycaps = draw_keycaps, size = 1);
    }
  }

  // Thumbs
  thumbColumnReference = dataLookup(thumbData, ["origin"]);
  thumbRowIndexReference = dataLookup(thumbData, ["origin_index"]);
  columnIndex = findIndex(columnsData, "name", thumbColumnReference);
  from_column(columnsData[columnIndex], thumbRowIndexReference) foreach_thumb(thumbData = thumbData) {
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
// for (i = [0:1:len(columns_data_layouts_MX[2]) - 2]) {
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

//
// Echinos layout projection
//
columnIndexRef = findIndex(columns_data_layouts_MX, "version", 27);
thumbIndexRef = findIndex(thumbs_data_layouts_MX, "version", 34);
columns_data_used = columns_data_layouts_MX[columnIndexRef];
thumb_data_used = thumbs_data_layouts_MX[thumbIndexRef];
projection(cut=false)
{
  difference(){
    // Case PCB / Top plates
    // top();
    // color(rgb(147, 161, 161, 0.5)) pcb();
    // color(rgb(253, 246, 227, 0.5)) top();
    // Footprints
    draw_layout(columns_data_used, thumb_data_used, cutout = true);
  }
}


// //
// // Echinos layout tester with case
// //
// layoutType = "MX";
// columnVersion = 27;
// thumbVersion = 34;
// columnIndex = findIndex(columns_data_layouts_MX, "version", columnVersion);
// thumbIndex = findIndex(thumbs_data_layouts_MX, "version", thumbVersion);
// echo(str("CURRENT (index) --> (", columnIndex, ", ", thumbIndex, ")"));
// columns_data_used = columns_data_layouts_MX[columnIndex];
// thumb_data_used = thumbs_data_layouts_MX[thumbIndex];

// union() {
//   // // Holders for columns
//   // for (i = [0:1:len(columns_data_used) - 2]) {
//   //   draw_column_holders(columns_data_used[i], caseHeight / 2 + topPlateThickness);
//   // }

//   // // Holders for thumb
//   // thumbReference = dataLookup(thumb_data_used, ["origin"]);
//   // columnIndex = findIndex(columns_data_used, "name", thumbReference);
//   // from_column(columns_data_used[columnIndex]) {
//   //   draw_thumb_holders(thumb_data_used, caseHeight / 2 + topPlateThickness);
//   // }

//   // Case
//   difference() {
//     shell(offset=0);
//     translate(__Z(caseHeight / 2 + topPlateThickness)){
//       draw_layout(columns_data_used, thumb_data_used, cutout = true);
//     }

//     textHeight = 1;
//     #translate([-0.2 * mx_spacing[0], -1.5 * mx_spacing[1], caseHeight-topPlateThickness]){
//       mirror([180, 0, 0]) linear_extrude(height = textHeight+0.01)
//         text( text = str(layoutType, "_C", columnVersion, "T", thumbVersion),
//           font = "Constantia:style=Bold", size = 5, valign = "center", halign = "center" );
//     }
//   }

//   // // Switches
//   // %translate(__Z(caseHeight / 2 + topPlateThickness)){
//   //   draw_layout(columns_data_used, thumb_data_used, cutout = false, draw_keycaps=true);
//   // }
// }


// //
// // Differences
// //
// // References
// columnIndexRef = findIndex(columns_data_layouts_MX, "version", 26);
// thumbIndexRef = findIndex(thumbs_data_layouts_MX, "version", 34);
// echo(str("REFERENCE (index) --> (", columnIndexRef, ", ", thumbIndexRef, ")"));
// color([ 0.8, 0.8, 0.8, 0.5, 1]){
//   // Switches
//   translate(__Z(caseHeight / 2 + topPlateThickness) + [0, 0, 0]) {
//     draw_layout(columns_data_layouts_MX[columnIndexRef], thumbs_data_layouts_MX[thumbIndexRef], cutout = false, draw_keycaps=false);
//   }
// }

// // New
// columnIndexNew = findIndex(columns_data_layouts_MX, "version", 27);
// thumbIndexNew = findIndex(thumbs_data_layouts_MX, "version", 34);
// echo(str("NEW (index) --> (", columnIndexNew, ", ", thumbIndexNew, ")"));
// color([0.0, 1.0, 0.0, 0.5])union(){
//   // Switches
//   translate(__Z(caseHeight / 2 + topPlateThickness) + [0, 0, 0])
//   // translate(X__(7))
//   {
//     draw_layout(columns_data_layouts_MX[columnIndexNew], thumbs_data_layouts_MX[thumbIndexNew], cutout = false, draw_keycaps=false);
//   }
// }

// // // Alternate
// // columnIndexOther = findIndex(columns_data_layouts_MX, "version", 22);
// // thumbIndexOther = findIndex(thumbs_data_layouts_MX, "version", 31);
// // echo(str("Other (index) --> (", columnIndexOther, ", ", thumbIndexOther, ")"));
// // color([1.0, 0.0, 0.0, 0.25])union(){
// //   // Switches
// //   translate(__Z(caseHeight / 2 + topPlateThickness) + [0, 0, 0])
// //   // translate(X__(7))
// //   {
// //     draw_layout(columns_data_layouts_MX[columnIndexOther], thumbs_data_layouts_MX[thumbIndexOther], cutout = false, draw_keycaps=false);
// //   }
// // }
