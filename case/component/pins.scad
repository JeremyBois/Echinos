include <../common/constants.scad>;
use <../common/distributions.scad>;
use <../common/transformations.scad>;
use <../common/utils.scad>;
use <../component/shapes3D.scad>;

module female_header_254_footprint() {
}

module female_header_254_3D(draw_pins = false, reversible = false) {

}

module female_header_254_cutout(plateThickness, plateHeight) {
  translate([ 0, 0, plateHeight - TOL / 2.0 ])
      // Add ~ 1mm margin
      cube_XY([ 16.6 + 1.0, 13.8 + 1.0, plateThickness + TOL ], center = false,
              $fn = 10);
}

module female_header_254_cutout_position() { children(); }

///
/// @brief      Female pin header with 2.54mm pitch and a low profile.
///
module female_header_254_low(footprint) {
  // Female header from https://fr.aliexpress.com/item/32848204130.html
  pin1 = [ 0.55, 2.79 ];
  anchor = [ 1.35, 1.64 ];
  body = [ 2.54, 3.0 ];

  female_header(pin = pin1, anchor = anchor, body = body);
}

///
/// @brief      Male pin header with 2.54mm pitch and a low profile.
///
module male_header_254_low() {
  // Female header from https://fr.aliexpress.com/item/32848204130.html
  pin1 = [ 0.5, 4.13 ];
  anchor1 = [ 1.35, 0.73 ];
  pin2 = [ 0.6, 3.0 ];
  anchor2 = [ 1.35, 1.10 ];
  body = [ 2.54, 3.0 ];

  male_header(pin1 = pin1, pin2 = pin2, anchor1 = anchor1, anchor2 = anchor2,
              body = body);
}

module female_header(body, anchor, pin) {
  translate([ 0, 0, anchor[1] ]) __draw_body(body);
  __draw_anchor(anchor);
  translate([ 0, 0, -pin[1] ]) __draw_pin(pin);
}

module male_header(body, anchor1, anchor2, pin1, pin2) {
  __draw_anchor(anchor1);
  translate([ 0, 0, anchor1[1] ]) {
    __draw_body(body);
    translate([ 0, 0, body[1] ]) {
      __draw_anchor(anchor2);
      translate([ 0, 0, anchor2[1] ]) __draw_pin(pin2);
    }
  }
  translate([ 0, 0, -pin1[1] ]) __draw_pin(pin1);
}

module __draw_body(body) {
  // Select an appropriate radius based on body size
  rounding = 0.3 * body[0];
  cube_XY_rounded(XXY(body), r = rounding, use_chamfer = true, centerZ = false);
}

module __draw_anchor(size) { cylinder(d = size[0], h = size[1]); }

module __draw_pin(size) { cylinder(d = size[0], h = size[1]); }

//
// Tests
//

module __xSpacing(i) { translate([ 25.0 * i, 0.0, 0.0 ]) children(); }
module __ySpacing(j) { translate([ 0.0, 25.0 * j, 0.0 ]) children(); }

__xSpacing(0) {
  female_header_254_low();
  __ySpacing(1) { on_line(10, 2.54) female_header_254_low(); }
}
__xSpacing(1) {
  male_header_254_low();
  __ySpacing(1) { on_line(10, 2.54) male_header_254_low(); }
}
