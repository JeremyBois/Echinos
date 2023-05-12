use <../common/utils.scad>;
use <../component/shapes2D.scad>

//
// 3D Shapes
//

/** A cube centered on the XY plane by default but not on the Z axis.
Same behavior as cylinder(center=false).
\param size Cube dimensions
\param centerZ True --> cube_XY and cube behave the same
*/
module cube_XY(size, centerZ = false) {
  if (is_list(size)) {
    translate([ -size[0], -size[1], centerZ ? -size[2] : 0.0 ] / 2.0)
        cube(size);
  } else {
    translate([ -size, -size, centerZ ? -size : 0.0 ] / 2.0) cube(size);
  }
}

/** A cylinder with only 6 sides
\param size Size on the XY plane
\param height Extrusion size on the Z axis
*/
module hexagon(width, height, centerZ = false) {
  cylinder(d = width, h = height, center = centerZ, $fn = 6);
}

/** A cylinder with only 8 sides
\param size Size on the XY plane
\param height Extrusion size on the Z axis
*/
module octagon(width, height, centerZ = false) {
  rotate([ 0, 0, 360 / 16 ])
      cylinder(d = width, h = height, center = centerZ, $fn = 8);
}

// Oval shape
module oval(height, rx, ry, centerZ = false) {
  scale([ rx / ry, 1, 1 ]) cylinder(h = height, r = ry, center = centerZ);
}

// A cube built by extrusion of square_rounded centered on the XY plane by
// default
module cube_XY_rounded(size, r = 1.0, centerXY = true, centerZ = false,
                       use_chamfer = false) {
  size3D = is_list(size) ? size : XXX(size);
  translate([ 0.0, 0.0, centerZ ? -size3D[2] / 2.0 : 0.0 ])
      linear_extrude(height = size3D[2])
          square_rounded(size = XY(size3D), r = r, center = centerXY,
                         use_chamfer = use_chamfer);
}

module cylinder_rounded(size, r, centerZ = false, r1 = undef, r2 = undef) {
  w = is_list(size) ? size.x : size;
  h = is_list(size) ? size.y : size;
  half_h = h / 2.0;
  r2 = is_undef(r2) ? r : r2;
  r1 = is_undef(r1) ? r : r1;
  translate([ 0.0, 0.0, centerZ ? 0 : half_h ]) {
    render() union() {
      rotate([ 0.0, 180.0, 0 ]) rotate_extrude()
          square_rounded_one([ w, half_h ], r1);
      rotate_extrude() square_rounded_one([ w, half_h ], r2);
    }
  }
}

module cylinder_semirounded(size, r, centerZ = false) {
  w = is_list(size) ? size.x : size;
  h = is_list(size) ? size.y : size;
  translate([ 0.0, 0.0, centerZ ? h / 2 : h ]) {
    render() rotate([ 0.0, 180.0, 0 ]) rotate_extrude()
        square_rounded_one([ w, h ], r);
  }
}

module capsule(height, r, centerZ = false) {
  translate([ 0.0, 0.0, centerZ ? 0 : height / 2.0 ]) {
    delta = height / 2.0 - r;
    hull() {
      translate([ 0.0, 0.0, delta ]) sphere(r = r);
      translate([ 0.0, 0.0, -delta ]) sphere(r = r);
    }
  }
}

module capsule_semirounded(height, r, centerZ = false) {
  cylinder_semirounded([ r, height ], r, centerZ = centerZ);
}

//
// Tests
//

module __xSpacing(i) { translate([ 50.0 * i, 0.0, 0.0 ]) children(); }
module __ySpacing(j) { translate([ 0.0, 50.0 * j, 0.0 ]) children(); }

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
