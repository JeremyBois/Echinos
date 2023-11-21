use <../pins.scad>;

include <../../common/constants.scad>;
include <../../component/pins_database.scad>;

use <../../common/distributions.scad>
use <../../primitive/shapes2D.scad>;
use <../../primitive/shapes3D.scad>;
use <../../common/test_utils.scad>

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
