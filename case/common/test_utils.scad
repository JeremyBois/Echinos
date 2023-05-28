//
// Test functions to make easier to span part / shape
//

module __xSpacing(i, step=50.0) { translate([ step * i, 0.0, 0.0 ]) children(); }
module __ySpacing(j, step=50.0) { translate([ 0.0, step * j, 0.0 ]) children(); }
module __zSpacing(k, step=50.0) { translate([ 0.0, 0.0, step * k ]) children(); }
