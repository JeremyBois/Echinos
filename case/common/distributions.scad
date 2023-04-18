include <constants.scad>
use <utils.scad>

/** Align and distribute child tree \count number of times along a straight path
on_line() children();
\param count   Number of copies
\param spacing Distance between each child
\param axis    Normalized line direction
\param offset  Distance offset of the whole distribution (follow line direction)
\param center  True --> Distribution will be centered
*/
module on_line(count, spacing, axis = forward, offset = 0, center = false) {

  // Compute shift required to center the whole column
  centerShift = center ? spacing * (count - 1) / 2.0 - offset : -offset;

  for (i = [0:1:count - 1]) {
    translate((-centerShift + i * spacing) * axis) children();
  }
}

/** Get transform of the element at index \i from a straight path
as defined by on_line module.
place_on_line() children();
\param i       Index of the element for which transform is computed
\param count   Number of copies
\param spacing Distance between each child
\param axis    Normalized line direction
\param offset  Distance offset of the whole distribution (follow line direction)
\param center  True --> Distribution will be centered
*/
module place_on_line(i, count, spacing, axis = forward, offset = 0,
                     center = false) {

  // Compute shift required to center the whole column
  centerShift = center ? spacing * (count - 1) / 2.0 - offset : -offset;

  translate((-centerShift + i * spacing) * axis) children();
}

/** Align and distribute child tree \count number of times along a circular path
on_circle() children();
\param count     Number of copies
\param spacing   Distance between each child
\param rotation  Angle between each child
\param offset    Angle offset of the whole distribution
\param clockwise True --> Positive rotation is clockwise
\param spin      True --> Each child is rotated toward the circle center
\param center    True --> Distribution will be centered
*/
module on_circle(count, spacing, rotation, offset = 0, clockwise = false,
                 spin = false, center = false) {
  // Center and two points on circle circumference forms an isosceles triangle
  // https://math.stackexchange.com/a/827517
  radius = spacing / (2.0 * sin(rotation / 2.0));
  on_circle_r(count = count, radius = radius, rotation = rotation,
              offset = offset, clockwise = clockwise, spin = spin,
              center = center) children();
}

/** Align and distribute child tree \count number of times along a circular path
on_circle_r() children();
\param count     Number of copies
\param radius    Circle radius
\param rotation  Angle between each child
\param offset    Angle offset of the whole distribution
\param clockwise True --> Positive rotation is clockwise
\param spin      True --> Each child is rotated toward the circle center
\param center    True --> Distribution will be centered
*/
module on_circle_r(count, radius, rotation, offset = 0, clockwise = false,
                   spin = false, center = false) {
  centerShift = center ? 0.0 : -radius;
  direction = clockwise ? -1.0 : 1.0;

  for (i = [0:1:count - 1]) {
    angle = (i * rotation + offset) * direction;
    cosAngle = cos(angle);
    sinAngle = sin(angle);
    if (spin) {
      multmatrix(m = [[cosAngle, -sinAngle, 0, centerShift + radius * cosAngle],
                      [sinAngle, cosAngle, 0, radius * sinAngle], [0, 0, 1, 0],
                      [0, 0, 0, 1]]) children();
    } else {
      translate([ centerShift + radius * cosAngle, radius * sinAngle, 0 ])
          children();
    }
  }
}

/** Get transform of the element at index \i from a circular path
as defined by on_circle module.
place_on_circle() children();
\param i         Index of the element for which transform is computed
\param spacing   Distance between each child
\param rotation  Angle between each child
\param offset    Angle offset of the whole distribution
\param clockwise True --> Positive rotation is clockwise
\param spin      True --> Each child is rotated toward the circle center
\param center    True --> Distribution will be centered
*/
module place_on_circle(i, spacing, radius, rotation, offset = 0,
                       clockwise = false, spin = false, center = false) {
  // Center and two points on circle circumference forms an isosceles triangle
  // https://math.stackexchange.com/a/827517
  radius = spacing / (2 * sin(rotation / 2.0));
  place_on_circle_r(i, radius = radius, rotation = rotation, offset = offset,
                    clockwise = clockwise, spin = spin, center = center)
      children();
}

/** Get transform of the element at index \i from a circular path
as defined by on_circle module.
place_on_circle_r() children();
\param i         Index of the element for which transform is computed
\param radius    Circle radius
\param rotation  Angle between each child
\param offset    Angle offset of the whole distribution
\param clockwise True --> Positive rotation is clockwise
\param spin      True --> Each child is rotated toward the circle center
\param center    True --> Distribution will be centered
*/
module place_on_circle_r(i, radius, rotation, offset = 0, clockwise = false,
                         spin = false, center = false) {
  centerShift = center ? 0.0 : -radius;
  direction = clockwise ? -1.0 : 1.0;

  angle = (i * rotation + offset) * direction;
  cosAngle = cos(angle);
  sinAngle = sin(angle);
  if (spin) {
    multmatrix(m = [[cosAngle, -sinAngle, 0, centerShift + radius * cosAngle],
                    [sinAngle, cosAngle, 0, radius * sinAngle], [0, 0, 1, 0],
                    [0, 0, 0, 1]]) children();
  } else {
    translate([ centerShift + radius * cosAngle, radius * sinAngle, 0 ])
        children();
  }
}

/** Align and distribute child tree \count number of times along a snail like
path on_snail() children();
\param count        Number of copies
\param spacingStart Distance between two first children
\param spacingEnd   Distance between two last children
\param rotation     Angle between each child
\param offset       Angle offset of the whole distribution
\param clockwise    True --> Positive rotation is clockwise
\param center       True --> Distribution will be centered */
module on_snail(count, spacingStart, spacingEnd, rotation, offset = 0,
                clockwise = false, center = false) {
  // Center and two points on its circumference forms an isosceles triangle
  // https://math.stackexchange.com/a/827517
  invSin = 1 / (2 * sin(rotation / 2.0));
  radiusStart = spacingStart * invSin;
  radiusEnd = spacingEnd * invSin;
  centerShift = center ? 0.0 : -radiusStart;
  direction = clockwise ? -1.0 : 1.0;

  for (i = [0:1:count - 1]) {
    t = i / count;
    radius = lerp(radiusStart, radiusEnd, t);
    angle = (i * rotation + offset) * direction;
    cosAngle = cos(angle);
    sinAngle = sin(angle);
    multmatrix(m = [[cosAngle, -sinAngle, 0, radius * cosAngle],
                    [sinAngle, cosAngle, 0, radius * sinAngle], [0, 0, 1, 0],
                    [0, 0, 0, 1]]) children();
  }
}

module spin(count, angle = 360, axis = up, strict = false) {
  divisor = (strict || angle == 360) ? count : count - 1;
  for (i = [0:count - 1])
    rotate(axis * angle * i / divisor) children();
}

//
// Tests
//

rotate([ 0, 0, -8 ]) {
  on_line(count = 22, spacing = 25, offset = 0, center = false) {
    square(14, center = true);
  }
  place_on_line(i = 2, count = 22, spacing = 25, offset = 0, center = false) {
    translate([ 25, 0, 0 ]) color("FireBrick", 1) circle(15);
  }
}

translate([ 500, 0, 0 ]) {
  on_circle(count = 10, spacing = 30, rotation = 25, offset = 0,
            clockwise = false, center = false, spin = true) {
    square(14, center = true);
  }

  place_on_circle(i = 4, spacing = 30, rotation = 25, offset = 0,
                  clockwise = false, center = false, spin = false) {
    translate([ 0, 30, 0 ]) color("FireBrick", 1) circle(15);
  }
}

translate([ -500, 0, 0 ]) {
  on_snail(count = 300, spacingStart = 5, spacingEnd = 40, rotation = 5,
           clockwise = false, center = false) {
    linear_extrude(height = 40, scale = 0.1) square(14, center = true);
  }
}

translate([ 250, 0, 0 ]) spin(4, 45, up) { square(14, center = true); }
