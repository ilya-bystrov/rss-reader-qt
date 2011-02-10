import QtQuick 1.0

import "Util.js" as Util
import "Store.js" as Store


//<!-- news, entertainment, sports, tech -->

// ListModel for the accordion list
// Initial data is hardcoded by hand. Model data is stored during onDestruction and
// restored during onComplete. If saved data is found the default data is overwritten.
ListModel {
    id: model

    ListElement {
        categoryTitle: "News"
        iconUrl: 'gfx/news_icon.png'
        attributes: [
            ListElement { categoryTitle: "Reuters Top News" ; type: "rss"; url: "http://feeds.reuters.com/reuters/topNews" },
            ListElement { categoryTitle: "Manage"; type: "discover"; url: "discovery.xml"}
        ]
    }
    ListElement {
        categoryTitle: "Entertainment"
        iconUrl: 'gfx/entertainment_icon.png'
        attributes: [
            ListElement { categoryTitle: "Reuters Entertainment"; type: "rss"; url: "http://feeds.reuters.com/reuters/entertainment" },
            ListElement { categoryTitle: "Manage"; type: "discover"; url: "discovery.xml"}
        ]
    }
    ListElement {
        categoryTitle: "Sports"
        iconUrl: 'gfx/sports_icon.png'
        attributes: [
            ListElement { categoryTitle: "Reuters Sports"; type: "rss"; url: "http://feeds.reuters.com/reuters/sportsNews" },
            ListElement { categoryTitle: "Manage"; type: "discover"; url: "discovery.xml"}
        ]
    }
    ListElement {
        categoryTitle: "Tech"
        iconUrl: 'gfx/tech_icon.png'
        attributes: [
            ListElement { categoryTitle: "Reuters Technology News"; type: "rss"; url: "http://feeds.reuters.com/reuters/technologyNews" },
            ListElement { categoryTitle: "Manage"; type: "discover"; url: "discovery.xml"}
        ]
    }

    Component.onCompleted: {
        // Comment the following line and run once to restore the initial state with predefined content.
        Store.restore(model);
    }

    Component.onDestruction: {
        Store.store(model)
    }

    // Adds a feed to category.
    function addToCategory(category, name, url) {
        Util.log("addToCategory: "+category+" "+name+" "+" "+url)
        try {
            var category = findCategory(category)
            category.attributes.insert(0, {"categoryTitle": name,
                                       "type": "rss",
                                       "url": url })
        }
        catch(error) {
            Util.log(error)
        }
    }

    // Removes a feed from category.
    function removeFromCategory(categoryName, url) {
        Util.log("removeFromCategory: "+categoryName+" "+url)
        try {
            var category = findCategory(categoryName)
            for(var a = 0; a < category.attributes.count; a++) {
                if(url == category.attributes.get(a).url) {
                    category.attributes.remove(a)
                    break;
                }
            }
        }
        catch(error) {
            Util.log(error)
        }
    }

    function findCategory(categoryName) {
        for(var i = 0; i < model.count; i++ ) {
            var category = model.get(i)
            if(category.categoryTitle == categoryName) {
                return category
            }
        }
        throw("Category "+categoryName+" not found")
    }

    // Check whether a feed exists in any category in the model.
    function feedExists(feedUrl) {
        var found = false
        for(var i = 0; i < model.count; i++ ) {
            var category = model.get(i)
            if(category.attributes === undefined) {
                continue;
            }
            for(var a = 0; a < category.attributes.count; a++) {
                var url = category.attributes.get(a).url
                if(url == feedUrl) {
                    found = true
                    break
                }
            }
        }
        return found
    }

}

