import QtQuick 1.0
import "Components.js" as Util

Loader {
    property bool keepLoaded : true
    property url viewSource

    anchors.top: parent.top
    anchors.bottom: parent.bottom
    width: parent.width
    opacity: 0

    function activationComplete() {
        Util.log("activationComplete");
        if (item.activationComplete != undefined) item.activationComplete();
    }

    function deactivationComplete() {
        Util.log("deactivationComplete");
        if (item.deactivationComplete != undefined) item.deactivationComplete();
        if (!keepLoaded)
            source = "";
    }

    function loadView() {
        Util.log("loadView");
        if (status != Loader.Ready)
            source = viewSource;
    }
}
