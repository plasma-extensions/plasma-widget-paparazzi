import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.3
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

import org.kde.private.spectacle 1.0


ColumnLayout {
  id: root
  spacing : 30.0
  
  DbusAdaptor {
    id: spectacleDbusAdaptor
  }
    
  Label {
      text: "Take a screenshot!"; 
      font.weight: Font.Light;
      font.pointSize: 12
  }

  RowLayout {
      spacing : 20.0

      id: actio1nsBox
      ColumnLayout {
	  Layout.alignment: Qt.AlignHCenter
	  Label {
	      text: "Full screen"
	      Layout.alignment: Qt.AlignHCenter

	  }
	  Button {
	      iconName: "view-fullscreen"
	      Layout.alignment: Qt.AlignHCenter
	      tooltip : "Full screen capture."

	      onClicked: delayCall( plasmoid.configuration.delayTime, 
				    function () {
				      spectacleDbusAdaptor.captureScreen(plasmoid.configuration.showPointer)
				    });
	  }
      }
      ColumnLayout {

	  Label {
	      text: "Window"
	      Layout.alignment: Qt.AlignHCenter
	  }
	  Button {
	      iconName: "window"
	      Layout.alignment: Qt.AlignHCenter
	      tooltip : "Only the active window."

	      onClicked: delayCall( plasmoid.configuration.delayTime, 
				    function () {
				      spectacleDbusAdaptor.captureWindow(plasmoid.configuration.showPointer)
				    });
	  }
      }
      ColumnLayout {

	  Label {
	      text: "Rectangular"
	      Layout.alignment: Qt.AlignHCenter
	  }
	  Button {
	      iconName: "select-rectangular"
	      Layout.alignment: Qt.AlignHCenter
	      tooltip : "From a rectangular area."

	      onClicked: delayCall( plasmoid.configuration.delayTime, 
				    function () {
				      spectacleDbusAdaptor.captureArea(plasmoid.configuration.showPointer)
				    });
	  }
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

