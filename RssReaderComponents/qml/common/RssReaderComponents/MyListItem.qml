import QtQuick 1.0

Item {
    id: container

    property string fontName: "Helvetica"
    property int fontSize: 10
    property color fontColor: "black"
    property bool fontBold: false
    property string text: "NOT SET"
    property string bgImage: './gfx/list_item.png'
    property string bgImageSelected: './gfx/list_item_selected.png'
    property string bgImagePressed: './gfx/list_item_pressed.png'
    property string bgImageActive: './gfx/list_item_active.png'
    property bool selected: false
    property bool selectable: false
    property int textIndent: 0
    property int iconIndent: 0
    property string icon: ""
    property double iconOpacity: 1
    property int margin: 4
    property bool alignBottom: false
    property bool hide: false

    signal clicked
    signal pressAndHold(int mouseX, int mouseY)

    width: 360
    // Check, if the item needs to be hidden. If not, then the item will be
    // at least 54px height, but if the wrapped text makes it higher, so be it.
    height: hide ? 0 : Math.max(54, itemText.itemTextHeight)
    clip: true

    onSelectedChanged: selected ?  state = 'selected' : state = ''

    BorderImage {
        id: background
        border { top: 9; bottom: 36; left: 35; right: 35; }
        source: bgImage
        anchors.fill: parent
    }

    Image {
        id: iconId
        visible: icon.length > 0
        source: icon
        width: visible ? height: 0
        smooth: true
        opacity: container.iconOpacity
        anchors {
            left: parent.left
            top: parent.top
            margins: 0.2*parent.height
            verticalCenter: parent.verticalCenter
            leftMargin: 8 + iconIndent
        }

    }

    Text {
        id: itemText

        property int itemTextHeight: height + anchors.topMargin + anchors.bottomMargin
        anchors {
            left: iconId.right
            top: iconId.visible ? iconId.top : parent.top
            bottom: container.alignBottom ? parent.bottom : undefined
            right: parent.right
            topMargin: container.margin
            bottomMargin: container.margin
            leftMargin: container.margin*2 + textIndent
            rightMargin: container.margin*2
        }
        font {
            family: container.fontName
            pointSize: container.fontSize
            bold: container.fontBold
        }
        color: container.fontColor
        text: container.text
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WordWrap
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: container.clicked();
        onReleased: selectable && !selected ? selected = true : selected = false
        onPressAndHold: container.pressAndHold(mouseX,mouseY)
    }

    states: [
        State {
            name: 'pressed'; when: mouseArea.pressed
            PropertyChanges { target: background; source: bgImagePressed; border { left: 35; top: 35; right: 35; bottom: 10 } }
        },
        State {
            name: 'selected'
            PropertyChanges { target: background; source: bgImageSelected; border { left: 35; top: 35; right: 35; bottom: 10 } }
        },
        State {
            name: 'active';
            PropertyChanges { target: background; source: bgImageActive; }
        }
    ]
}
