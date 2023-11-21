include <../common/constants.scad>
use <../common/utils.scad>

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
on_arc() children();
\param count     Number of copies
\param spacing   Distance between each child
\param rotation  Angle between each child
\param offset    Angle offset of the whole distribution
\param clockwise True --> Positive rotation is clockwise
\param spin      True --> Each child is rotated toward the circle center
\param center    True --> Distribution will be centered
*/
module on_arc(count, spacing, rotation, offset = 0, clockwise = false,
              spin = false, center = false) {
  // Center and two points on circle circumference forms an isosceles triangle
  // https://math.stackexchange.com/a/827517
  r = is_undef(r) ? spacing / (2.0 * sin(rotation / 2.0)) : r;
  on_arc_r(count = count, r = r, rotation = rotation, offset = offset,
           clockwise = clockwise, spin = spin, center = center) children();
}

/** Align and distribute child tree \count number of times along a circular path
on_arc_r() children();
\param count     Number of copies
\param r         Circle radius
\param rotation  Angle between each child
\param offset    Angle offset of the whole distribution
\param clockwise True --> Positive rotation is clockwise
\param spin      True --> Each child is rotated toward the circle center
\param center    True --> Distribution will be centered
*/
module on_arc_r(count, r, rotation, offset = 0, clockwise = false, spin = false,
                center = false) {
  centerShift = center ? 0.0 : -r;
  direction = clockwise ? -1.0 : 1.0;

  for (i = [0:1:count - 1]) {
    angle = (i * rotation + offset) * direction;
    cosAngle = cos(angle);
    sinAngle = sin(angle);
    if (spin) {
      multmatrix(m = [[cosAngle, -sinAngle, 0, centerShift + r * cosAngle],
                      [sinAngle, cosAngle, 0, r * sinAngle], [0, 0, 1, 0],
                      [0, 0, 0, 1]]) children();
    } else {
      translate([ centerShift + r * cosAngle, r * sinAngle, 0 ]) children();
    }
  }
}

/** Get transform of the element at index \i from a circular path
as defined by on_arc module.
place_on_arc() children();
\param i         Index of the element for which transform is computed
\param spacing   Distance between each child
\param rotation  Angle between each child
\param offset    Angle offset of the whole distribution
\param clockwise True --> Positive rotation is clockwise
\param spin      True --> Each child is rotated toward the circle center
\param center    True --> Distribution will be centered
*/
module place_on_arc(i, spacing, r, rotation, offset = 0, clockwise = false,
                    spin = false, center = false) {
  // Center and two points on circle circumference forms an isosceles triangle
  // https://math.stackexchange.com/a/827517
  r = spacing / (2 * sin(rotation / 2.0));
  place_on_arc_r(i, r = r, rotation = rotation, offset = offset,
                 clockwise = clockwise, spin = spin, center = center)
      children();
}

/** Get transform of the element at index \i from a circular path
as defined by on_arc module.
place_on_arc_r() children();
\param i         Index of the element for which transform is computed
\param r         Circle radius
\param rotation  Angle between each child
\param offset    Angle offset of the whole distribution
\param clockwise True --> Positive rotation is clockwise
\param spin      True --> Each child is rotated toward the circle center
\param center    True --> Distribution will be centered
*/
module place_on_arc_r(i, r, rotation, offset = 0, clockwise = false,
                      spin = false, center = false) {
  centerShift = center ? 0.0 : -r;
  direction = clockwise ? -1.0 : 1.0;

  angle = (i * rotation + offset) * direction;
  cosAngle = cos(angle);
  sinAngle = sin(angle);
  if (spin) {
    multmatrix(m = [[cosAngle, -sinAngle, 0, centerShift + r * cosAngle],
                    [sinAngle, cosAngle, 0, r * sinAngle], [0, 0, 1, 0],
                    [0, 0, 0, 1]]) children();
  } else {
    translate([ centerShift + r * cosAngle, r * sinAngle, 0 ]) children();
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
    r = lerp(radiusStart, radiusEnd, t);
    angle = (i * rotation + offset) * direction;
    cosAngle = cos(angle);
    sinAngle = sin(angle);
    multmatrix(m = [[cosAngle, -sinAngle, 0, r * cosAngle],
                    [sinAngle, cosAngle, 0, r * sinAngle], [0, 0, 1, 0],
                    [0, 0, 0, 1]]) children();
  }
}

module spin(count, angle = 360, axis = up, strict = false) {
  divisor = (strict || angle == 360) ? count : count - 1;
  for (i = [0:count - 1])
    rotate(axis * angle * i / divisor) children();
}
