//
//  VSVisyblScanner.h
//  VisyblSDK
//
//  Created by GeghamHarutyunyan on 2/16/16.
//  Copyright © 2016 WAY4APP. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VSVisybl;

/**
 *  State unknown, update imminent.
 */
extern NSString *const VSVisyblScannerBluetoothStateUnknown;

/**
 *  The connection with the system service was momentarily lost, update imminent.
 */
extern NSString *const VSVisyblScannerBluetoothStateResetting;

/**
 *  The platform doesn't support Bluetooth Low Energy.
 */
extern NSString *const VSVisyblScannerBluetoothStateUnsupported;

/**
 *  The app is not authorized to use Bluetooth Low Energy.
 */
extern NSString *const VSVisyblScannerBluetoothStateUnauthorized;

/**
 *  Bluetooth is powered off
 */
extern NSString *const VSVisyblScannerBluetoothStatePoweredOff;

/**
 *  Bluetooth is currently powered on and available to use.
 */
extern NSString *const VSVisyblScannerBluetoothStatePoweredOn;

@interface VSVisyblScanner : NSObject


/**
 *  Value will be one of the HGBeconScannerBluetoothState prefexed consts
 *  defined above when bluetooth state changes
 */
@property (nonatomic, readonly) NSString *const bluetoothState;




/*!
 @property didDiscoverVisybl
 @abstract
 Optional callback block that's called when the scanner discovered Visybl.
 
 @discussion
 Optional callback that will be called when the scanner is discovered a new Visibl
 This is useful for connecting to the discovered Visybl.
 */
@property (nonatomic, copy) void (^didDiscoverVisybl)(VSVisybl *visybl);



@property (nonatomic, copy) void (^didWriteOnPeripheral)(NSString *peripheral);



@property (nonatomic, readonly) BOOL scanning;
/**
 *  Starts scanning for beacons
 */
-(void)startScanning;
/**
 *  Stops scanning for beacons
 */
-(void)stopScanning;

/**
 *  Restart scanner, will erease all stored data
 */
-(void)restartScanner;

/**
 *  Restart scanner, will not erease all stored data
 */
-(void)resumeScanner;

+(VSVisyblScanner *)runVisyblScanner;

/*!
 *  Connect to Visybl
 */
-(void)connectVisybl:(VSVisybl*)visybl;

/*!
 *  Register Device
 */
-(void)registerDeviceWithName:(NSString*)deviceName withKey:(NSString*)key;

/*!
 *  Unregister Device
 */
-(void)unregisterDevice;

/*!
 *  Register Network Name and Password
 */
-(void)registerNetworkName:(NSString*)name withPassword:(NSString*)password;

/*!
 *  Update Activities to the Cloud
 */
-(void)updateActivities;

@end
