//
// Dict like accessor
//

/** Dict like accessor
Returns the index in \data where \key matches first
dict = [["name", "Yoshi"], ["size", 2]];
echo(keyLookup(dict, ["name"]) == 0);
\param data Array storing data using a [key, value] syntax
\param key Data assigned key
*/
function keyLookup(data, key) = search(key, data, num_returns_per_match = 1)[0];

/** Dict like getter allowing to retrieve data associated with a
specific key
dict = [["name", "Yoshi"], ["size", 2]];
echo(dataLookup(dict, ["name"]) == "Yoshi");
\param data Array storing data using a [key, value] syntax
\param key Data assigned key
*/
function dataLookup(data, key) =
    data[search(key, data, num_returns_per_match = 1)[0]][1];

// Tests
dict = [ [ "name", "Yoshi" ], [ "size", 2 ] ];
echo(keyLookup(dict, ["name"]) == 0);
echo(dataLookup(dict, ["name"]) == "Yoshi");
