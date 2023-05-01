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
function dataLookup(data, key) = data[keyLookup(data, key)][1];

function retrieveKey(data, value) =
    data[search(value, data, num_returns_per_match = 1, index_col_num = 1)[0]][0];

//
// Tests
//
dict = [ [ "name", "Yoshi" ], [ "size", 2 ] ];
echo(keyLookup(dict, ["not found"]) == []);
echo(keyLookup(dict, ["name"]) == 0);
echo(dataLookup(dict, ["name"]) == "Yoshi");
