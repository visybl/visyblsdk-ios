visyblsdk-iOS

iOS App with VisyblSDK.Framework to read and display Visybl beacons parameters.

VisyblSDK.Framework is used to read BLE packet coming from Visybl Beacons and provides an easier way to access all the parameters with few lines of code inside any Android App.

This example iOS project provides a fully working App using VisyblSDK Framework. Find the below 3 steps to use VisyblSDK Framework in any iOS App.

Step 1: #import VisyblSDK/VisyblSDK.h

Step 2: Visybl vis = Visybl.beaconsLinkedHashMap.get(name);

Step 3: Read all parameters from vis.

e.g.

 cell.rssi.text = visybl.RSSI.stringValue;
 
 cell.rssiIcon.image = [UIImage imageNamed:[self getRssiIcon:visybl.RSSI.integerValue]];
 
 cell.received.text = [NSString stringWithFormat:@"%@", @(visybl.mRcdAdvCount)];
 
 cell.temperature.text = [NSString stringWithFormat:@"%@ C", visybl.currentTemperature];
 
 cell.battery.text = @(visybl.getBatteryPercent).stringValue;
 
 cell.batteryIcon.image = [UIImage imageNamed:[self getBatteryIcon:visybl.getBatteryPercent]];
