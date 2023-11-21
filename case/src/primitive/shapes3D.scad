use <../common/utils.scad>;
use <../primitive/shapes2D.scad>

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
