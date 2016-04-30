import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.3
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

import org.kde.private.spectacle 1.0


ColumnLayout {
  id: root
  anchors.fill: parent
  
  property int negative_margin: -7
  anchors.topMargin: negative_margin 
  anchors.bottomMargin: negative_margin
  
  anchors.leftMargin: negative_margin + 1
  anchors.rightMargin: negative_margin + 1
  
  DbusAdaptor {
    id: spectacleDbusAdaptor
    
    // onSreenshotTaken: {console.log("The chart has been cleared")}
    
    
    Component.onCompleted: {     
      screenshotTaken.connect(handleScrennshotTaken);
      
      // Set the same width to the grid columns
      var common_width = Math.max(label1.width, label2.width, label3.width)
      spacer1.width = common_width
      spacer2.width = common_width
      spacer3.width = common_width
    }
  
    function handleScrennshotTaken(file) {
      if (plasmoid.configuration.copyToClipboard) {
	spectacleDbusAdaptor.copyCaptureToClipboard(file);
	spectacleDbusAdaptor.eraseCapture(file);
      }
    }
    
  }
  
  
  
  Rectangle {
  id: header
  
  color: "#3DAEE9"
  height: header_text.height + 8;
  Layout.fillWidth: true
  Text {
    id: header_text	
    
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.leftMargin: 10 
    anchors.topMargin: 4
    
    color: "white"
    
    text: i18n("Take a screenshot!"); 
    font.family: "Noto Sans"; font.pointSize: 11;
    }
  }


  GridLayout {
    id: actio1nsBox
    //columnSpacing: 4
    columns: 5
    rows: 4
    
    Item {
      Layout.column: 1
      Layout.row: 1
      width: 10
    }
    Item {
      Layout.column: 5
      Layout.row: 1
      width: 10
    }

    
    Label {
      id: label1
      Layout.column: 2
      Layout.row: 1
      Layout.alignment: Qt.AlignHCenter
      
      text: i18n("Full screen")
      font.family: "Noto Sans"; font.pointSize: 10;
    }
    Button {
      Layout.column: 2
      Layout.row: 2
      Layout.alignment: Qt.AlignHCenter
      
      iconName: "view-fullscreen"
      tooltip : i18n("Full screen capture.")
      
      onClicked: delayCall( plasmoid.configuration.delayTime, 
			    function () {
			      spectacleDbusAdaptor.captureScreen(plasmoid.configuration.showPointer)
			    });
    }
      

    Label {
      id: label2
      Layout.column: 3
      Layout.row: 1
      Layout.alignment: Qt.AlignHCenter
      
      text: i18n("Window")
      font.family: "Noto Sans"; font.pointSize: 10;	  
    }
    Button {
      Layout.column: 3
      Layout.row: 2
      Layout.alignment: Qt.AlignHCenter
      
      iconName: "window"
      tooltip : i18n("Only the active window.")

      onClicked: delayCall( plasmoid.configuration.delayTime, 
			    function () {
			      spectacleDbusAdaptor.captureWindow(plasmoid.configuration.showPointer)
			    });
    }

      Label {
	id: label3
	Layout.column: 4
	Layout.row: 1
	Layout.alignment: Qt.AlignHCenter
	
	text: i18n("Rectangular")
	font.family: "Noto Sans"; font.pointSize: 10;
      }
      Button {
	Layout.column: 4
	Layout.row: 2
	Layout.alignment: Qt.AlignHCenter
	
	iconName: "select-rectangular"
	tooltip : i18n("From a rectangular area.")

	onClicked: delayCall( plasmoid.configuration.delayTime, 
			      function () {
				spectacleDbusAdaptor.captureArea(plasmoid.configuration.showPointer)
				});
	}
	

      Item {
	id: spacer1
	Layout.column: 2
	Layout.row: 3
      }
      Item {
	id: spacer2
	Layout.column: 3
	Layout.row: 3
      }
      Item {
	id: spacer3
	Layout.column: 4
	Layout.row: 3
      }

      Item {
	Layout.column: 1
	Layout.row: 4
	Layout.rowSpan: 5
	height: 8
      }
	
    }
  
  
    Component {
      id: delayCallerComponent
      Timer {
      }
    }

    function delayCall( interval, callback ) {
      console.debug(interval);
      interval = interval * 1000;
      var delayCaller = delayCallerComponent.createObject( null, { "interval": interval } );
      delayCaller.triggered.connect( function () {
	callback();
	delayCaller.destroy();
      } );
      
      delayCaller.start();
    }
}

