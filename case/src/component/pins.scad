include <../common/constants.scad>;
include <../component/draw_modes.scad>;
include <../component/pins_database.scad>;
use <../common/dictionnary.scad>;
use <../common/utils.scad>;
use <../primitive/shapes3D.scad>;

//
// Female Header
//

module header_female_clearance(data, centerXY = true) {
  header_female(data, mode = CLEARANCE, centerXY = centerXY);
}

module header_female_model(data, centerXY = true, drawPins = true,
                           bodyColor = "DarkSlateGray") {
  header_female(data, mode = MODEL, centerXY = centerXY, drawPins = drawPins,
                bodyColor = bodyColor);
}

module header_female_footprint(data, centerXY = true, bodyColor = "Red") {
  header_female(data, mode = FOOTPRINT, centerXY = centerXY,
                bodyColor = bodyColor);
}

module header_female(data, mode, centerXY, drawPins, bodyColor) {
  pin = dataLookup(data, ["pin_bottom"]);
  anchor = dataLookup(data, ["anchor_bottom"]);
  body = dataLookup(data, ["body"]);
  shiftCenter = centerXY ? [ 0, 0, 0 ] : [ body[0], -body[1], 0.0 ] / 2.0;
  translate(shiftCenter) {
    if (mode == FOOTPRINT) {
      color(bodyColor) translate([ 0, 0, -Y(pin) ]) {
        pinHole = [ 1.355 * X(pin), Y(pin) ];
        draw_electrical_pin(pinHole);
      }
    } else if (mode == CLEARANCE) {
      cube_XY(XXY(body) + __Z(Y(anchor)));
    } else {
      color(bodyColor) {
        translate([ 0, 0, anchor[1] ]) draw_body(body);
        draw_anchor(anchor);
      }
      if (drawPins) {
        color("Gold") translate([ 0, 0, -pin[1] ]) draw_electrical_pin(pin);
      }
    }
  }

  module draw_body(body) {
    // Select an appropriate radius based on body size
    cube_XY_rounded(XXY(body), r = 0.3 * X(body), use_chamfer = true);
  }

  module draw_anchor(size) { cylinder(d = X(size), h = Y(size)); }
  module draw_electrical_pin(size) { cylinder(d = X(size), h = Y(size)); }
}

//
// Male Header
//

module header_male_clearance(data, centerXY = true) {
  header_male(data, mode = CLEARANCE, centerXY = centerXY);
}

module header_male_model(data, centerXY = true, drawPins = true,
                         bodyColor = "DarkSlateGray") {
  header_male(data, mode = MODEL, centerXY = centerXY, drawPins = drawPins,
              bodyColor = bodyColor);
}

module header_male_footprint(data, centerXY = true, bodyColor = "Red") {
  header_male(data, mode = FOOTPRINT, centerXY = centerXY,
              bodyColor = bodyColor);
}

module header_male(data, mode, centerXY, drawPins, bodyColor) {
  data = dataLookup(header_data, ["header254_maleLow"]);
  pin1 = dataLookup(data, ["pin_bottom"]);
  pin2 = dataLookup(data, ["pin_top"]);
  anchor1 = dataLookup(data, ["anchor_bottom"]);
  anchor2 = dataLookup(data, ["anchor_top"]);
  body = dataLookup(data, ["body"]);
  shiftCenter = centerXY ? [ 0, 0, 0 ] : [ body[0], -body[1], 0.0 ] / 2.0;
  translate(shiftCenter) {
    if (mode == FOOTPRINT) {
      color(bodyColor) {
        translate([ 0, 0, -Y(pin1) ]) {
          pinHole = [ 1.355 * X(pin1), Y(pin1) ];
          draw_electrical_pin(pinHole);
        }
        translate([ 0, 0, Y(body) + Y(anchor1) + Y(anchor2) ]) {
          pinHole = [ 1.355 * X(pin2), Y(pin2) ];
          draw_electrical_pin(pinHole);
        }
      }
    } else if (mode == CLEARANCE) {
      cube_XY(XXY(body) + __Z(Y(anchor1) + Y(anchor2)));
    } else {
      color(bodyColor) draw_anchor(anchor1);
      translate([ 0, 0, anchor1[1] ]) {
        color(bodyColor) draw_body(body);
        translate([ 0, 0, body[1] ]) {
          color(bodyColor) draw_anchor(anchor2);
          if (drawPins) {
            color("Gold") translate([ 0, 0, anchor2[1] ])
                draw_electrical_pin(pin2);
          }
        }
      }
      if (drawPins) {
        color("Gold") translate([ 0, 0, -pin1[1] ]) draw_electrical_pin(pin1);
      }
    }
  }

  module draw_body(body) {
    // Select an appropriate radius based on body size
    cube_XY_rounded(XXY(body), r = 0.3 * X(body), use_chamfer = true);
  }
  module draw_anchor(size) { cylinder(d = X(size), h = Y(size)); }
  module draw_electrical_pin(size) { cylinder(d = X(size), h = Y(size)); }
}

//
// Tests
//

include <../common/test_utils.scad>
use <../common/distributions.scad>

$fn = 20;

female_low_254 = dataLookup(header_data, ["header254_femaleLow"]);
male_low_254 = dataLookup(header_data, ["header254_maleLow"]);

picth = dataLookup(female_low_254, ["pitch"]);
__xSpacing(-1, picth) {
  header_male_model(data = male_low_254, centerXY = true);
  __ySpacing(1, picth) {
    header_male_model(data = male_low_254, centerXY = false);
  }
}
__xSpacing(1, picth) {
  header_female_model(data = female_low_254, centerXY = true);
  __ySpacing(1, picth) {
    header_female_model(data = female_low_254, centerXY = false);
  }
}

//
// Female
//
__xSpacing(1, 10) {
  header_female_model(female_low_254);
  __ySpacing(1, 25) { on_line(10, 2.54) header_female_model(female_low_254); }
}

__xSpacing(2, 10) {
  difference() {
    translate([ -0, -0, -1.6 - TOL ]) cube_XY([ 5, 5, 1.6 ]);
    header_female_footprint(female_low_254);
  }
}

__xSpacing(3, 10) {
  header_female_model(female_low_254);
  difference() {
    translate([ -0, -0, -1.6 - TOL ]) cube_XY([ 5, 5, 1.6 ]);
    header_female_footprint(female_low_254);
  }
}

__xSpacing(4, 10) {
  header_female_model(female_low_254);
  header_female_footprint(female_low_254);
}

__xSpacing(5, 10) { header_female_model(female_low_254, drawPins = false); }

__xSpacing(3, 10) __ySpacing(1, 25) {
  difference() {
    plateThickness = 1.3;
    plateHeight = 2.2 - 1.3;
    translate([ 0, 0, plateHeight ])
        cube_XY([ 5, 5, plateThickness ], centerZ = false);
#header_female_clearance(female_low_254);
  }
}

__xSpacing(4, 10) __ySpacing(1, 25) {
  difference() {
    plateThickness = 1.3;
    plateHeight = 2.2 - 1.3;
    translate([ 0, 0, plateHeight ])
        cube_XY([ 5, 5, plateThickness ], centerZ = false);
#header_female_clearance(female_low_254);
  }
  header_female_model(female_low_254);
}

//
// Male
//
__xSpacing(-1, 10) {
  header_male_model(male_low_254);
  __ySpacing(1, 25) { on_line(10, 2.54) header_male_model(male_low_254); }
}
__xSpacing(-2, 10) {
  difference() {
    translate([ -0, -0, -1.6 - TOL ]) cube_XY([ 5, 5, 1.6 ]);
    header_male_footprint(male_low_254);
  }
}

__xSpacing(-3, 10) {
  header_male_model(male_low_254);
  difference() {
    translate([ -0, -0, -1.6 - TOL ]) cube_XY([ 5, 5, 1.6 ]);
    header_male_footprint(male_low_254);
  }
}

__xSpacing(-4, 10) {
  header_male_model(male_low_254);
  header_male_footprint(male_low_254);
}

__xSpacing(-5, 10) { header_male_model(male_low_254, drawPins = false); }

__xSpacing(-3, 10) __ySpacing(1, 25) {
  difference() {
    plateThickness = 1.3;
    plateHeight = 2.2 - 1.3;
    translate([ 0, 0, plateHeight ])
        cube_XY([ 5, 5, plateThickness ], centerZ = false);
#header_male_clearance(male_low_254);
  }
}

__xSpacing(-4, 10) __ySpacing(1, 25) {
  difference() {
    plateThickness = 1.3;
    plateHeight = 2.2 - 1.3;
    translate([ 0, 0, plateHeight ])
        cube_XY([ 5, 5, plateThickness ], centerZ = false);
#header_male_clearance(male_low_254);
  }
  header_male_model(male_low_254);
}
