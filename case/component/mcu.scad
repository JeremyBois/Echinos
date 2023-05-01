

///
/// @brief      Import RP2040 zero model with correct alignment and orientation.
///             Z origin is at the bottom of the PCB and is not affected by
///             \centerXY.
///
/// @param      centerXY  If true origin is at the model XY center
module RP2040_zero(centerXY = true) {
  x = centerXY ? -18.0 / 2.0 : 0.0;
  y = centerXY ? -23.5 / 2.0 : 0.0;
  z = 1.1;
  // https://www.waveshare.com/rp2040-zero.htm
  translate([ x, y, z ]) import("../models/RP2040_Zero.stl", center = centerXY);
}

//
// Tests
//

module __xSpacing(i) { translate([ 50.0 * i, 0.0, 0.0 ]) children(); }
module __ySpacing(j) { translate([ 0.0, 50.0 * j, 0.0 ]) children(); }

__xSpacing(0) {
  RP2040_zero(centerXY = true);
  __ySpacing(1) { RP2040_zero(centerXY = false); }
}
