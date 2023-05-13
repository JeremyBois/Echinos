
module __xSpacing(i, step=50.0) { translate([ 50.0 * i, 0.0, 0.0 ]) children(); }
module __ySpacing(j, step=50.0) { translate([ 0.0, 50.0 * j, 0.0 ]) children(); }
module __zSpacing(k, step=50.0) { translate([ 0.0, 0.0, 50.0 * k ]) children(); }
