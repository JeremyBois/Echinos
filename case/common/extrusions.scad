include <../common/constants.scad>

// Ideas
// https://openhome.cc/eGossip/OpenSCAD/lib3x-bend_extrude.html
// https://github.com/JustinSDK/dotSCAD/blob/master/src/box_extrude.scad
// https://openhome.cc/eGossip/OpenSCAD/lib3x-rounded_extrude.html

module chamfer_extrude(height = 2, angle = 10, center = false,
                       reverse = false) {
  // 2D to 3D to make minkowski happy
  translate(
      [ 0, 0, (center == false) ? (height - TOL) : (height - 2 * TOL) / 2 ]) {
    render() minkowski() {
      // Convert 2D path to very thin 3D extrusion
      linear_extrude(height = TOL) { children(); }
      rotate(270) rotate_extrude() {
        if (reverse) {
          // Apex at height
          polygon([
            [ 0, -TOL + height ], [ height * tan(angle), -TOL + height ],
            [ 0, 0 ]
          ]);
        } else {
          // Apex at origin
          polygon([
            [ 0, TOL - height ], [ height * tan(angle), TOL - height ], [ 0, 0 ]
          ]);
        }
      }
    }
  }
}

module round_extrude_B(height = 2, r = 10, center = false) {
  render() minkowski() {
    // Convert 2D path to very thin 3D extrusion
    linear_extrude(height = TOL) { children(0); }
    cylinder_semirounded(size = [ r, height - TOL ], r = r, center = center);
  }
}

module round_extrude_BT(height = 2, r1 = 10, r2 = 10, center = false) {
  render() minkowski() {
    // Convert 2D path to very thin 3D extrusion
    linear_extrude(height = TOL) { children(0); }
    cylinder_rounded(size = [ r1, height - TOL ], center = center, r1 = r1,
                     r2 = r2);
  }
}

//
// Tests
//

use <../component/shapes3D.scad>

module __xSpacing(i) { translate([ 200.0 * i, 0.0, 0.0 ]) children(); }
module __ySpacing(j) { translate([ 0.0, 150.0 * j, 0.0 ]) children(); }
module __zSpacing(k) { translate([ 0.0, 0.0, 25.0 * k ]) children(); }

height = 12.0;
shape = [
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

r1 = 5.0;
r2 = 2.0;

__xSpacing(0) { polygon(shape); }

__xSpacing(1) {
  __ySpacing(0) {
    __zSpacing(1) {
      color("Blue", 0.5)
          cylinder_semirounded([ height, height ], r = r1, center = true);
    }
    color("Green", 0.75) round_extrude_B(height, r = r1, center = true)
        offset(delta = -r1) polygon(shape);

    color("Orange", 0.25) translate([ 0, 0, -height / 2.0 ])
        linear_extrude(height) polygon(shape);
  }

  __ySpacing(1) {
    __zSpacing(1) {
      color("Blue", 0.5)
          cylinder_semirounded([ height, height ], r = r1, center = false);
    }
    color("Green", 0.75) round_extrude_B(height, r = r1, center = false)
        offset(delta = -r1) polygon(shape);

    color("Orange", 0.25) linear_extrude(height) polygon(shape);
  }
}

__xSpacing(2) {
  __ySpacing(0) {
    __zSpacing(1) {
      color("Blue", 0.5)
          cylinder_rounded([ height, height ], r1 = r1, r2 = r2, center = true);
    }
    color("Green", 0.75)
        round_extrude_BT(height, r1 = r1, r2 = r2, center = true)
            offset(delta = -r1) polygon(shape);

    color("Orange", 0.25) translate([ 0, 0, -height / 2.0 ])
        linear_extrude(height) polygon(shape);
  }

  __ySpacing(1) {
    __zSpacing(1) {
      color("Blue", 0.5) cylinder_rounded([ height, height ], r1 = r1, r2 = r2,
                                          center = false);
    }
    color("Green", 0.75)
        round_extrude_BT(height, r1 = r1, r2 = r2, center = false)
            offset(delta = -r1) polygon(shape);

    color("Orange", 0.25) linear_extrude(height) polygon(shape);
  }
}
