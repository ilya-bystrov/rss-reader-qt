.pragma library

Qt.include("Util.js")

function getDb() {
    return openDatabaseSync("RssReaderDB", "1.0", "RssReaderDB SQL", 1000);
}

function clearDb() {
    var db = getDb();
    db.transaction( function(tx) { try {
                           tx.executeSql('DROP TABLE Category;');
                       } catch(error) {/*ignore*/} }
                   );
}

// Converts ListModel entries to JSON and passes to a writer function
function modelToJSON(model,writer) {
    // Loop through model entries and output required parts.
    for (var i=0; i < model.count; i++) {
        var json = "{"
        var obj = model.get(i)
        // Create pairs of "name":"value" from object properties
        // (not including attributes).
        for(var prop in obj) {
            if(!prop.match("^attributes")) {
                json += "\""+prop+"\": \"" + obj[prop] +"\",";
            }
        }
        // Loop through entry attributes
        json += "\"attributes\":["
        for(var y=0; y < obj.attributes.count; y++) {
            if(y > 0) json += ","
            var attr = obj.attributes.get(y)
            // Here the whole attribute can be written as is
            // so JSON.stringify is used
            json += JSON.stringify(attr)
        }
        json += "]}"
        writer(i,json)
        //confirm validity: var parsed = JSON.parse(json)
    }
}

// Stores ListModel in persistent storage
function store(model) {
    // Writes one JSON-formatted ListModel entry to storage.
    function writeEntry(id, json) {
        //log ("WriteEntry "+id+", "+json);
        var db = getDb();
        db.transaction( function(tx) {
                           tx.executeSql('CREATE TABLE IF NOT EXISTS Category(id INT, json TEXT)');
                           tx.executeSql('INSERT INTO Category VALUES(?, ?)', [id, json]);
                       } );
    }

    // First get rid of all old data.
    clearDb()
    modelToJSON(model, writeEntry)
    log("Stored " + model.count + " entries")
}



// Restores ListModel contents from persistent storage
function restore(model)
{
    var db = getDb();
    var cleared = false

    // Appends one JSON-formatted entry to ListModel
    function readEntry(json) {
        //log("Reading->"+json)
        var parsed = JSON.parse(json)
        if(!cleared) {
            // Succesfully read an parsed something.
            // Clear previous data before writing data
            // from storage.
            cleared = true
            model.clear()
        }
        model.append(parsed)
    }

    db.transaction( function(tx) {
                       try {
                           var rs = tx.executeSql('SELECT * FROM Category');
                           for(var i = 0; i < rs.rows.length; i++) {
                               readEntry(rs.rows.item(i).json)
                           }
                       } catch (error) {
                           log ("Error: "+error)
                       }
                   } );
    log("Restored " + model.count + " entries")
}
