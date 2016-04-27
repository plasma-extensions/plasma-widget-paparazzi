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
    // onSreenshotTaken: {console.log("The chart has been cleared")}
    
    
    Component.onCompleted: {
      console.log("Test !!! ")
      console.log(JSON.stringify(spectacleDbusAdaptor))
      for (var p in spectacleDbusAdaptor)
	console.log(p + ": " + spectacleDbusAdaptor[p]);
      
      screenshotTaken.connect(handleScrennshotTaken)
    }
  
    function handleScrennshotTaken(file) {
      if (plasmoid.configuration.copyToClipboard) {
	spectacleDbusAdaptor.copyCaptureToClipboard(file);
	spectacleDbusAdaptor.eraseCapture(file);
      }
    }
    
  }
  
  
  
    
  Label {
      text: i18n("Take a screenshot!"); 
      font.weight: Font.Light;
      font.pointSize: 12
  }

  RowLayout {
      spacing : 20.0

      id: actio1nsBox
      ColumnLayout {
	  Layout.alignment: Qt.AlignHCenter
	  Label {
	      text: i18n("Full screen")
	      Layout.alignment: Qt.AlignHCenter

	  }
	  Button {
	      iconName: "view-fullscreen"
	      Layout.alignment: Qt.AlignHCenter
	      tooltip : i18n("Full screen capture.")

	      onClicked: delayCall( plasmoid.configuration.delayTime, 
				    function () {
				      spectacleDbusAdaptor.captureScreen(plasmoid.configuration.showPointer)
				    });
	  }
      }
      ColumnLayout {

	  Label {
	      text: i18n("Window")
	      Layout.alignment: Qt.AlignHCenter
	  }
	  Button {
	      iconName: "window"
	      Layout.alignment: Qt.AlignHCenter
	      tooltip : i18n("Only the active window.")

	      onClicked: delayCall( plasmoid.configuration.delayTime, 
				    function () {
				      spectacleDbusAdaptor.captureWindow(plasmoid.configuration.showPointer)
				    });
	  }
      }
      ColumnLayout {

	  Label {
	      text: i18n("Rectangular")
	      Layout.alignment: Qt.AlignHCenter
	  }
	  Button {
	      iconName: "select-rectangular"
	      Layout.alignment: Qt.AlignHCenter
	      tooltip : i18n("From a rectangular area.")

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

