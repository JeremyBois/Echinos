include <../common/constants.scad>;

use <../common/constants.scad>;
use <../common/transformations.scad>;
use <../common/utils.scad>;
use <../primitive/shapes2D.scad>;
use <../primitive/shapes3D.scad>

$fn = $preview ? 64 : 128;

//
// Trackball
//
BALL_DIAMETER = 34;
BALL_RADIUS = BALL_DIAMETER * 0.5;
BALL_Z = BALL_RADIUS;
BALL_BOTTOM_HOLE_DIAMETER = BALL_RADIUS * 0.3;
// Size of holes in the trackball top mount to be able to grab the ball out
BALL_GRAB_HOLE_HEIGHT = BALL_RADIUS * 0.7;
BALL_GRAB_HOLE_START_ANGLE = 80;
BALL_GRAB_HOLE_ANGLES =
    add([ 0, 1, 2 ] * (360 / 3), BALL_GRAB_HOLE_START_ANGLE);
// Position and dimensions of the small claw used to avoid the ball to go away
BALL_CLAW_Z = BALL_DIAMETER * 0.65;
BALL_CLAW_WIDTH = BALL_RADIUS * 0.1;
BALL_CLAW_HEIGHT = BALL_CLAW_WIDTH * 3;
BALL_TOL = 0.2;

//
// Bearings
//
BEARING_DIAMETER = 3; // White = 2.5mm | Black = 2.5mm
BEARING_RADIUS = BEARING_DIAMETER * 0.5;
BEARING_MOUNT_TOP_CURVE_RADIUS = 1;
BEARING_INCLINATION_ANGLE = 90 + 20;
BEARING_HOLE_ANGLES =
    BALL_GRAB_HOLE_ANGLES - [for (i = [0:len(BALL_GRAB_HOLE_ANGLES) - 1]) 180 /
                                len(BALL_GRAB_HOLE_ANGLES)];
BEARING_TOL = 0.1;

//
// Bolt (M2)
//
BOLT_M2_HOLE_DIAMETER = 2;
BOLT_M2_HEAD_DIAMETER = 3.8; // max = 4mm | min = 3.6mm
BOLT_M2_HEAD_HEIGHT = 2;
BOLT_M2_HEAD_Z = 1;
BOLT_M2_HOLE_ANGLES = [ 0, 180 ];
TOP_BOTTOM_HOLE_OFFSET = 22; // @TEMP
BOLT_M2_TOL = 0.1;

//
// PCB
//
PCB_THICKNESS = 1.6;
PCB_HEIGHT = 25;             // @TEMP
PCB_WIDTH = 42;              // @TEMP
PCB_MOUNT_HOLES_OFFSET = 37; // @TEMP
// Extracted from datasheet of PMW3360
PCB_Z = -7.4;
PCB_BALL_OFFSET = abs(PCB_Z) - PCB_THICKNESS;

//
// Sensor (extracted from datasheet of PMW3360)
//
// Distance from lens to surface to navigation surface (ball)
SENSOR_LENS_BALL_OFFSET = 2.4;
// Recommended cutout width is 21.35
SENSOR_LENS_WIDTH = 21.15;
// Recommend cutout height is 19
SENSOR_LENS_HEIGHT = 18.85;
// Sensor specific tolerance
// Height of sensor lens above the PCB
SENSOR_LENS_HEIGHT_ABOVE_PCB = PCB_BALL_OFFSET - SENSOR_LENS_BALL_OFFSET;
// Small protrusion to make it easier to extract
SENSOR_LENS_PROTRUSION = [ 0.3, 3 ];
// Optical center != Geometrical center
SENSOR_LENS_CENTER_OFFSET = [ -0.6, 0 ];
SENSOR_LENS_TOL = 0.1;

//
// TODO
//
//   - Find correct tolerences for each parts
//   - Extract PCB dimensions from Kicad model
//   - Use M2 dimensions based on what I have in stock
//
// TODO
//

//
// Modules
//
module trackball_mount() {
  union() {
    trackball_top_mount();
    trackball_bottom_mount(true, false);
  }
}

module trackball_top_mount() {
  difference() {
    // Mount without any holes
    trackball_base();

    // Add holes to grab the ball out
    trackball_grab_holes();

    // Add holes for bearings
    trackball_bearing_holes(side_holes = true);

    // Add holes for bolts
    trackball_bolt_holes();
  }
}

module trackball_bottom_mount(show_sensor, show_pcb) {
  thickness = SENSOR_LENS_HEIGHT_ABOVE_PCB + SENSOR_LENS_BALL_OFFSET;
  translate([ 0, 0, -thickness ]) difference() {
    // Enclosure
    cube_XY_rounded(size = [ PCB_WIDTH, BALL_DIAMETER * 1.5, thickness ], r = 2,
                    centerXY = true, centerZ = false, use_chamfer = false);
    translate([ 0, 0, -TOL ]) sensor_lens_cutout(thickness + TOL * 2);

    // Holes
    M2_holes(thickness - 1);

    // Lens
    if (show_sensor) {
      % sensor_lens();
    }

    // PCB
    if (show_pcb) {
      % sensor_pcb();
    }
  }

  module sensor_pcb() {
    // PCB
    translate([ 0, 0, PCB_Z ]) difference() {
      cube_XY_rounded(size = [ PCB_WIDTH, PCB_HEIGHT, PCB_THICKNESS ], r = 2,
                      centerXY = true, centerZ = false, use_chamfer = false);

      M2_holes(PCB_THICKNESS);
    }
  }

  module sensor_lens() {
    translate(SENSOR_LENS_CENTER_OFFSET) {
      cube_XY_rounded(size =
                          [
                            SENSOR_LENS_WIDTH, SENSOR_LENS_HEIGHT,
                            SENSOR_LENS_HEIGHT_ABOVE_PCB
                          ],
                      r = 2.0, centerXY = true, centerZ = false,
                      use_chamfer = false);
    }
  }
  module sensor_lens_cutout(thickness) {
    translate(SENSOR_LENS_CENTER_OFFSET) {
      linear_extrude(thickness) {
        // Small protrusions on each side
        translate([
          (SENSOR_LENS_WIDTH + SENSOR_LENS_TOL * 2) * 0.5 - TOL * 2, -TOL * 2
        ]) square(size = add(SENSOR_LENS_PROTRUSION, TOL * 2), center = true);
        translate([
          -((SENSOR_LENS_WIDTH + SENSOR_LENS_TOL * 2) * 0.5 - TOL * 2), -TOL * 2
        ]) square(size = add(SENSOR_LENS_PROTRUSION, TOL * 2), center = true);

        // Main surface
        square_rounded(size =
                           [
                             SENSOR_LENS_WIDTH + SENSOR_LENS_TOL * 2,
                             SENSOR_LENS_HEIGHT + SENSOR_LENS_TOL * 2
                           ],
                       r = 2, center = true, use_chamfer = false);
      }
    }
  }

  module M2_holes(thickness) {
    translate([ -PCB_MOUNT_HOLES_OFFSET * 0.5, 0, -BOLT_M2_TOL ])
        cylinder(h = thickness + BOLT_M2_TOL * 2, r = BOLT_M2_HOLE_DIAMETER,
                 center = false);

    translate([ PCB_MOUNT_HOLES_OFFSET * 0.5, 0, -BOLT_M2_TOL ])
        cylinder(h = thickness + BOLT_M2_TOL * 2, r = BOLT_M2_HOLE_DIAMETER,
                 center = false);
  }
}

module trackball_base() {
  rotate_extrude(convexity = 10) {
    outset(0.05) difference() {
      // Ball mount
      trackball_base_2D();
      // Ball clearance hole
      trackball_cutout_2D();
    }
  }
}
/** Ball cutout 2D shape used to substract ball area before rotate extrusion.
 */
module trackball_cutout_2D() {
  ballCutoutRadius = BALL_RADIUS + BEARING_RADIUS + BALL_TOL;
  intersection() {
    // Account for bearings only on sides and top
    union() {
      difference() {
        translate([ 0, BALL_Z ]) circle(r = ballCutoutRadius);
        square(size = [ BALL_DIAMETER, BEARING_RADIUS ], center = true);
      }
      // Use only the ball real dimensions as bottom cutout
      translate([ 0, BALL_Z ]) circle(r = BALL_RADIUS + BALL_TOL);
    }
    hull() {
      square([ ballCutoutRadius, BALL_CLAW_Z - BALL_CLAW_HEIGHT ]);
      square([ ballCutoutRadius - BALL_CLAW_WIDTH, BALL_CLAW_Z ]);
    }
  }
}

/** Ball mount base shape. Control center hole size and outside side curve.
 */
module trackball_base_2D() {
  // Merge curve and slant side to create a curving right side only at the top
  // Gives more control on the curve than using a circle on the top corner
  hull() {
    // Add a curve following the right side (no slant)
    translate([ BALL_RADIUS + BEARING_RADIUS, BALL_CLAW_Z * 0.5 ])
        ellipse(BALL_RADIUS * 0.2, BALL_CLAW_Z);

    // Rectangle with the slant right side
    polygon([
      [ BALL_BOTTOM_HOLE_DIAMETER, 0 ],
      [ (BALL_RADIUS + BEARING_RADIUS) * 1.1, 0 ],
      [ BALL_RADIUS + BEARING_RADIUS, BALL_CLAW_Z ],
      [ BALL_BOTTOM_HOLE_DIAMETER, BALL_CLAW_Z ],
    ]);
  }
}

// Grab holes
module trackball_grab_holes() {
  for (pitch = BALL_GRAB_HOLE_ANGLES) {
    translate([ 0, 0, BALL_CLAW_Z ]) rotate([ 0, 90, pitch ])
        translate([ 0, 0, BALL_RADIUS * 0.5 ]) cylinder(
            h = BALL_RADIUS, r = BALL_GRAB_HOLE_HEIGHT, center = false);
  }
}

// Bearing holes
module trackball_bearing_holes(side_holes) {
  theta = BEARING_INCLINATION_ANGLE;
  magnitude = BALL_RADIUS + BEARING_RADIUS;
  translate([ 0, 0, BALL_Z ]) {
    for (phi = BEARING_HOLE_ANGLES) {
      // Use spherical coorcinate to place each bearing
      direction = [ sin(theta) * cos(phi), sin(theta) * sin(phi), cos(theta) ];
      translate(magnitude * direction) {
        sphere(d = BEARING_DIAMETER + BEARING_TOL * 2, $fn = $fn / 2);
      }
    }
    if (side_holes) {
      for (phi = add(BEARING_HOLE_ANGLES, -BALL_GRAB_HOLE_START_ANGLE * 0.25)) {
        // Use spherical coorcinate to place each bearing
        direction =
            [ sin(theta) * cos(phi), sin(theta) * sin(phi), cos(theta) ];
        translate(magnitude * direction) {
          sphere(d = BEARING_DIAMETER + BEARING_TOL * 2, $fn = $fn / 2);
        }
      }
      for (phi = add(BEARING_HOLE_ANGLES, +BALL_GRAB_HOLE_START_ANGLE * 0.25)) {
        // Use spherical coorcinate to place each bearing
        direction =
            [ sin(theta) * cos(phi), sin(theta) * sin(phi), cos(theta) ];
        translate(magnitude * direction) {
          sphere(d = BEARING_DIAMETER + BEARING_TOL * 2, $fn = $fn / 2);
        }
      }
    }
  }
}

module trackball_bolt_holes() {
  for (angle = BOLT_M2_HOLE_ANGLES) {
    rotate([ 0, 0, angle ]) translate([ 0, TOP_BOTTOM_HOLE_OFFSET * 0.5 ])
        boltHole();
  }

  module boltHole() {
    length = TOP_BOTTOM_HOLE_OFFSET * 0.5;
    hole_shift = length * 0.5 - BOLT_M2_HOLE_DIAMETER * 0.5 - BOLT_M2_TOL * 2;
    head_shift = length * 0.5 - BOLT_M2_HEAD_DIAMETER * 0.5 - BOLT_M2_TOL * 2;
    head_clearance = BOLT_M2_HEAD_HEIGHT * 2 + BOLT_M2_TOL * 2;

    union() {
      // Make space for the hole
      translate([ 0, -hole_shift, -TOL ])
          linear_extrude(head_clearance + BOLT_M2_HEAD_Z + TOL) {
        {
          square_rounded(
              size = [ BOLT_M2_HOLE_DIAMETER + BOLT_M2_TOL * 2, length ],
              r = BOLT_M2_HOLE_DIAMETER * 0.5, center = true,
              use_chamfer = false);
        }
      }

      // Make space for the head
      translate([ 0, -head_shift, BOLT_M2_HEAD_Z ])
          linear_extrude(head_clearance) {
        {
          square_rounded(
              size = [ BOLT_M2_HEAD_DIAMETER + BOLT_M2_TOL * 2, length ],
              r = BOLT_M2_HEAD_DIAMETER * 0.5, center = true,
              use_chamfer = false);
        }
      }
    }
  }
}

//
// Tests
//

// color("grey") translate([ 0, 0, BALL_RADIUS ]) sphere(r
// =BALL_RADIUS); translate([ 0, 0, BALL_CLAW_Z ]) sphere(r =
// BALL_RADIUS); #translate([ 0, 0, BALL_RADIUS ]) sphere(r =
// BALL_RADIUS + BEARING_RADIUS);

trackball_mount();
// trackball_top_mount();
// trackball_bottom_mount();

// trackball_base();
// trackball_base_2D();
// trackball_cutout_2D();
// trackball_grab_holes();
// trackball_bearing_holes();
// trackball_bolt_holes();
