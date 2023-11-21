use <../shapes3D.scad>
use <../../common/test_utils.scad>

$fn = 20;

// Cubes
__xSpacing(0) {
  cube_XY(10.0, centerZ = true);
  color("Orange", 0.25) cube(10.0, center = true);
  color("Green", 0.5) cube_XY(10.0, centerZ = false);
  color("Orange", 0.25) cube(10.0, center = false);

  __ySpacing(1) {
    cube_XY_rounded(10.0, r = 3.0, centerXY = true);
    color("Orange", 0.25) cube(10.0, center = true);
    color("Green", 0.5) cube_XY_rounded(10.0, r = 3.0, centerXY = false);
    color("Orange", 0.25) cube(10.0, center = false);
  }

  __ySpacing(2) {
    cube_XY_rounded(10.0, r = 3.0, centerXY = false, centerZ = true);
    color("Orange", 0.25) cube(10.0, center = true);
    color("Green", 0.5)
        cube_XY_rounded(10.0, r = 3.0, centerXY = false, centerZ = false);
    color("Orange", 0.25) cube(10.0, center = false);
  }
}

// Hexagons
__xSpacing(1) {
  hexagon(10.0, 20.0, centerZ = true);
  color("Orange", 0.25) cylinder(r = 10.0, h = 20.0, center = true);

  __ySpacing(1) {
    hexagon(10.0, 20.0, centerZ = false);
    color("Orange", 0.25) cylinder(r = 10.0, h = 20.0, center = false);
  }
}

// Octagons
__xSpacing(2) {
  octagon(10.0, 20.0, centerZ = true);
  color("Orange", 0.25) cylinder(r = 10.0, h = 20.0, center = true);

  __ySpacing(1) {
    octagon(10.0, 20.0, centerZ = false);
    color("Orange", 0.25) cylinder(r = 10.0, h = 20.0, center = false);
  }
}

// Ovals
__xSpacing(3) {
  oval(20.0, 10.0, 15.0, centerZ = true);
  color("Orange", 0.25) cylinder(h = 20.0, r = 15.0, center = true);

  __ySpacing(1) {
    oval(20.0, 10.0, 15.0, centerZ = false);
    color("Orange", 0.25) cylinder(h = 20.0, r = 15.0, center = false);
  }
}

// Cylinders rounded
__xSpacing(4) {
  cylinder_rounded([ 5.0, 20.0 ], r1 = 2.0, r2 = 15.0, centerZ = true);
  color("Orange", 0.25) cylinder(h = 20.0, r1 = 2.0, r2 = 15.0, center = true);

  __ySpacing(1) {
    cylinder_rounded([ 5.0, 20.0 ], r1 = 10.0, r2 = 5.0, centerZ = false);
    color("Orange", 0.25)
        cylinder(h = 20.0, r1 = 10.0, r2 = 5.0, center = false);
  }
}

__xSpacing(5) {
  cylinder_semirounded([ 5.0, 20.0 ], r = 5.0, centerZ = true);
  color("Orange", 0.25) cylinder(h = 20.0, r = 5.0, center = true);

  __ySpacing(1) {
    cylinder_semirounded([ 5.0, 20.0 ], r = 5.0, centerZ = false);
    color("Orange", 0.25) cylinder(h = 20.0, r = 5.0, center = false);
  }
}

// Capsules
__xSpacing(6) {
  capsule(50.0, 10.0, centerZ = true);
  color("Orange", 0.25) cylinder(h = 50.0, r = 10.0, center = true);

  __ySpacing(1) {
    capsule(50.0, 10.0, centerZ = false);
    color("Orange", 0.25) cylinder(h = 50.0, r = 10.0, center = false);
  }
}

__xSpacing(7) {
  capsule_semirounded(50.0, 10.0, centerZ = true);
  color("Orange", 0.25) cylinder(h = 50.0, r = 10.0, center = true);

  __ySpacing(1) {
    capsule_semirounded(50.0, 10.0, centerZ = false);
    color("Orange", 0.25) cylinder(h = 50.0, r = 10.0, center = false);
  }
}
