use <../common/dictionnary.scad>;

//
// Lookup table to make easier to select a specific header model
//
header_data = [
  [
    "header254_femaleLow",
    [
      [ "name", "header254_femaleLow" ],
      [ "reference", "https://fr.aliexpress.com/item/4001122376295.html" ],
      [ "pin_bottom", [ 0.55, 2.79 ] ], [ "anchor_bottom", [ 1.35, 1.64 ] ],
      [ "body", [ 2.54, 3.0 ] ], [ "height", 3.0 + 1.64 ], [ "pitch", 2.54 ]
    ]
  ],
  [
    "header254_maleLow",
    [
      [ "name", "header254_maleLow" ],
      [ "reference", "https://fr.aliexpress.com/item/4001122376295.html" ],
      [ "pin_bottom", [ 0.5, 4.13 ] ], [ "anchor_bottom", [ 1.35, 0.73 ] ],
      [ "body", [ 2.54, 3.0 ] ], [ "anchor_top", [ 1.35, 1.10 ] ],
      [ "pin_top", [ 0.6, 3.0 ] ], [ "height", 0.73 + 3.0 + 1.10 ],
      [ "pitch", 2.54 ]
    ]
  ]
];
