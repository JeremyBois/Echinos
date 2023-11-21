include <../common/constants.scad>;
include <../component/draw_modes.scad>;
use <../component/selectors.scad>;
use <../primitive/shapes2D.scad>;
use <../primitive/shapes3D.scad>;

//
// MX
//

// A simple placeholder of an MX switch
module switch_MX(stemColor = "FireBrick", bodyColor = "WhiteSmoke") {

  ringWidth = 15.6;
  ringHeight = 1.0;

  bottomTopWidth = 14.0;
  bottomBottomWidth = 12.0;
  bottomHeight = 5.0;

  topBottomWidth = 14.5;
  topTopWidth = 10;
  topHeight = 11.6 - bottomHeight - ringHeight;

  module switch_stem() {

    width = 3.6;
    height = 3.6;
    depth = 1.2;
    edgeRadius = 0.2;

    color(stemColor, 1) translate([ 0, 0, ringHeight + topHeight ])
        linear_extrude(height = height) {
      square_rounded([ width, depth ], edgeRadius, true);
      rotate([ 0, 0, 90 ]) square_rounded([ width, depth ], edgeRadius, true);
    }
  }

  module switch_top() {
    color(bodyColor, 1) translate([ 0, 0, ringHeight ])
        linear_extrude(topHeight, scale = topTopWidth / topBottomWidth)
            translate([ -topBottomWidth / 2, -topBottomWidth / 2, 0 ])
                square_rounded([ topBottomWidth, topBottomWidth ], 1.0);
  }

  module switch_middle() {
    color(bodyColor, 1) linear_extrude(ringHeight)
        square_rounded([ ringWidth, ringWidth ], 1.0, center = true);
  }

  module switch_bottom() {
    color(bodyColor, 1) translate([ 0, 0, -bottomHeight ])
        linear_extrude(bottomHeight, scale = bottomTopWidth / bottomBottomWidth)
            translate([ -bottomBottomWidth / 2, -bottomBottomWidth / 2, 0 ])
                square_rounded([ bottomBottomWidth, bottomBottomWidth ], 1.0);
  }

  switch_stem();
  switch_top();
  switch_middle();
  switch_bottom();
}

//
// Tests
//

include <../common/test_utils.scad>
$fn = 20;

// // MX
// translate([ 0, 50, 0 ]) { switch_MX(); }
