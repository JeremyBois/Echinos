// https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Transformations#offset

/**
Rounds all inside (concave) corners but leaves flat walls unchanged.
Holes less than 2 * \r in diameter vanish.
Think of this transformation as a circle sliding around the exterior of the
shape.
*/
module fillet(r) { offset(r = -r) offset(delta = r) children(); }

/**
Rounds all outside (convex) corners but leaves flat walls unchanged.
Walls less than 2 * \r thick vanish.
Think of this transformation as a circle sliding around the interior of the
shape.
*/
module round(r) { offset(r = r) offset(delta = -r) children(); }

/**
Apply both round then fillet.
Walls less than 2 * \r thick vanish. Holes less than 2 * \r in diameter vanish.
Think of this transformation as a circle sliding around the interior and then
around the exterior of the shape.
*/
module round_fillet(r, r1 = undef, r2 = undef) {
  r2 = is_undef(r2) ? r : r2;
  r1 = is_undef(r1) ? r : r1;
  round(r1) fillet(r2) children();
}

/**
Add a chamfer to convex and/or concave corners.
Same operation as round (convex) and/or fillet (concave) but edges are cut off
with a straight line.
*/
module chamfer(r, convex = true, concave = true) {
  offset(delta = r, chamfer = convex) offset(delta = -r, chamfer = concave) {
    children();
  }
}

// UNTESTED
// /**
// Rounds (\out_r) all outside (convex) corners but leaves flat walls unchanged.
// Rounds (\in_r) all inside (concave) corners but leaves flat walls unchanged.
// However, walls less than 2 * \r thick vanish.
// Thing of this transformation as a circle sliding around the exterior of the
// shape.
// */
// module round(in_r = 3, out_r = 1) {
//   offset(out_r) {
//     offset(-in_r - out_r) {
//       offset(in_r) { children(); }
//     }
//   }
// }
// UNTESTED

/** Extrudes 2D object to 3D when `h` is
 *  nonzero, otherwise leaves it 2D
 */
module extrude_if(h = undef, center = true) {
  if (h)
    // 3D
    linear_extrude(h, center = center, convexity = 5) children();
  else
    // 2D
    children();
}


//
// Tests
//

module __xSpacing(i) { translate([ 50.0 * i, 0.0, 0.0 ]) children(); }
module __ySpacing(j) { translate([ 0.0, 50.0 * j, 0.0 ]) children(); }


__xSpacing(1) {
  color("Green", 0.5) square([ 15, 10 ], center = true);

  __ySpacing(0.5) {
    color("Blue", 0.25) square([ 15, 10 ], center = true);
    color("Green", 0.5) fillet(4) square([ 15, 10 ], center = true);
  }
  __ySpacing(1) {
    color("Blue", 0.25) square([ 15, 10 ], center = true);
    color("Green", 0.5) round(4) square([ 15, 10 ], center = true);
  }
  __ySpacing(1.5) {
    color("Blue", 0.25) square([ 15, 10 ], center = true);
    color("Green", 0.5) chamfer(4) square([ 15, 10 ], center = true);
  }

  __ySpacing(2) {
    color("Blue", 0.25) square([ 15, 10 ], center = true);
    color("Green", 0.5) round_fillet(4) square([ 15, 10 ], center = true);
  }
}
