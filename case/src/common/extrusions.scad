include <../common/constants.scad>
use <../primitive/shapes3D.scad>

// Ideas
// https://openhome.cc/eGossip/OpenSCAD/lib3x-bend_extrude.html
// https://openhome.cc/eGossip/OpenSCAD/lib3x-rounded_extrude.html
// https://github.com/JustinSDK/dotSCAD/blob/master/src/box_extrude.scad

module chamfer_extrude(height = 2, angle = 10, centerZ = false,
                       reverse = false) {
  // 2D to 3D to make minkowski happy
  translate(
      [ 0, 0, (centerZ == false) ? (height - TOL) : (height - 2 * TOL) / 2 ]) {
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

module round_extrude_B(height = 2, r = 10, centerZ = false) {
  render() minkowski() {
    // Convert 2D path to very thin 3D extrusion
    linear_extrude(height = TOL) { children(0); }
    cylinder_semirounded(size = [ r, height - TOL ], r = r, centerZ = centerZ);
  }
}

module round_extrude_BT(height = 2, r1 = 10, r2 = 10, centerZ = false) {
  render() minkowski() {
    // Convert 2D path to very thin 3D extrusion
    linear_extrude(height = TOL) { children(0); }
    cylinder_rounded(size = [ r1, height - TOL ], centerZ = centerZ, r1 = r1,
                     r2 = r2);
  }
}
