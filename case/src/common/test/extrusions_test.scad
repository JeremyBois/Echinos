use <../extrusions.scad>

use <../../primitive/shapes3D.scad>
use <../../common/test_utils.scad>

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

__xSpacing(0, 200.0) { polygon(shape); }

__xSpacing(1, 200.0) {
  __ySpacing(0, 150.0) {
    __zSpacing(1, 25.0) {
      color("Blue", 0.5)
          cylinder_semirounded([ height, height ], r = r1, centerZ = true);
    }
    color("Green", 0.75) round_extrude_B(height, r = r1, centerZ = true)
        offset(delta = -r1) polygon(shape);

    color("Orange", 0.25) translate([ 0, 0, -height / 2.0 ])
        linear_extrude(height) polygon(shape);
  }

  __ySpacing(1, 150.0) {
    __zSpacing(1, 25.0) {
      color("Blue", 0.5)
          cylinder_semirounded([ height, height ], r = r1, centerZ = false);
    }
    color("Green", 0.75) round_extrude_B(height, r = r1, centerZ = false)
        offset(delta = -r1) polygon(shape);

    color("Orange", 0.25) linear_extrude(height) polygon(shape);
  }
}

__xSpacing(2, 200.0) {
  __ySpacing(0, 150.0) {
    __zSpacing(1, 25.0) {
      color("Blue", 0.5) cylinder_rounded([ height, height ], r1 = r1, r2 = r2,
                                          centerZ = true);
    }
    color("Green", 0.75)
        round_extrude_BT(height, r1 = r1, r2 = r2, centerZ = true)
            offset(delta = -r1) polygon(shape);

    color("Orange", 0.25) translate([ 0, 0, -height / 2.0 ])
        linear_extrude(height) polygon(shape);
  }

  __ySpacing(1, 150.0) {
    __zSpacing(1, 25.0) {
      color("Blue", 0.5) cylinder_rounded([ height, height ], r1 = r1, r2 = r2,
                                          centerZ = false);
    }
    color("Green", 0.75)
        round_extrude_BT(height, r1 = r1, r2 = r2, centerZ = false)
            offset(delta = -r1) polygon(shape);

    color("Orange", 0.25) linear_extrude(height) polygon(shape);
  }
}
