//
// 3D Shapes
//

/** A cube centered on the XY plane by default but not on the Z axis.
Same behavior as cylinder(center=false).
\param size Cube dimensions
\param center True --> cube_XY and cube behave the same
*/
module cube_XY(size, center = false) {
  if (is_list(size)) {
    translate([ -size[0], -size[1], center ? -size[2] : 0.0 ] / 2.0) cube(size);
  } else {
    translate([ -size, -size, center ? -size : 0.0 ] / 2.0) cube(size);
  }
}

/** A cylinder with only 6 sides
\param size Size on the XY plane
\param height Extrusion size on the Z axis
*/
module hexagon(size, height) { cylinder(r = size, h = height, $fn = 6); }

// Oval shape
module oval(height, rx, ry, center = false) {
  scale([ 1, rx / ry, 1 ]) cylinder(h = height, r = ry, center = center);
}

// A cube built by extrusion of square_rounded centered on the XY plane
module cube_XY_rounded(size, radius = 1.0, center = false) {
  sizeVec = is_list(size) ? size : [ size, size, size ];
  translate([ 0, 0, center ? -sizeVec[2] / 2.0 : 0.0 ])
      linear_extrude(height = sizeVec[2])
          square_rounded(size = sizeVec, radius = radius, center = true);
}

// A cube built by extrusion of square_rounded
module cube_rounded(size, radius = 1.0, center = false) {
  sizeVec = is_list(size) ? size : [ size, size, size ];
  translate([ 0, 0, center ? -sizeVec[2] / 2.0 : 0.0 ])
      linear_extrude(height = sizeVec[2])
          square_rounded(size = sizeVec, radius = radius, center = center);
}

//
// 2D Shapes
//

// Irregular circle (Y axis scaled)
module ellipse(width, depth) {
  scale([ 1, depth / width, 1 ]) circle(r = width / 2);
}

// A square with rounded corners
module square_rounded(size = [ 1.0, 1.0 ], radius = 1.0, center = false) {
  x = is_list(size) ? size[0] : size;
  y = is_list(size) ? size[1] : size;

  // If center is false, we need to translate
  if (center) {
    body();
  } else {
    translate([ x / 2, y / 2, 0 ]) body();
  }

  module body() {
    hull() {
      // Put circle on each corner
      translate([ (-x / 2) + (radius), (-y / 2) + (radius), 0 ]) {
        circle(r = radius);
      }

      translate([ (x / 2) - (radius), (-y / 2) + (radius), 0 ]) {
        circle(r = radius);
      }

      translate([ (-x / 2) + (radius), (y / 2) - (radius), 0 ]) {
        circle(r = radius);
      }

      translate([ (x / 2) - (radius), (y / 2) - (radius), 0 ]) {
        circle(r = radius);
      }
    }
  }
}

// Tests
// 3D
translate([ 0, 100, 0 ]) {
  cube_XY(10);
  color("Red", 0.5) cube(10, center = false);
  color("Orange", 0.5) cube(10, center = true);
  color("Green", 0.5) translate([ 0, 0, 5 ]) cube(10, center = true);
}
translate([ 25, 100, 0 ]) translate([ 0, 0, 5 ]) {
  cube_rounded(10, radius = 3.0, center = true);
  color("Green", 0.5) cube(10, center = true);
}
translate([ 50, 100, 0 ]) {
  cube_XY_rounded(10, radius = 3.0);
  color("Green", 0.5) cube_XY(10);
}

translate([ 100, 100, 0 ]) hexagon(10, 20);
translate([ 125, 100, 0 ]) oval(10, 2, 4, center = true);

// 2D
translate([ 0, 0, 0 ]) ellipse(10, 50);
translate([ 25, 0, 0 ]) {
  square_rounded([ 15, 10 ], 4.0, center = true);
  color("Green", 0.5) square([ 15, 10 ], center = true);
}
