//
//  VSVisybl.h
//  VisyblSDK
//
//  Created by GeghamHarutyunyan on 2/16/16.
//  Copyright © 2016 WAY4APP. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CBPeripheral;

//Asset Blink Colors
typedef enum : NSInteger {BLINK_RED = 1, BLINK_GREEN = 2, BLINK_BOTH = 3} BlinkColors;

@interface VSVisybl : NSObject

// Transmission power level(in dB).
@property (strong,nonatomic) NSNumber       *mTxPowerLevel;

// Raw bytes of scan record.
@property (strong,nonatomic) NSData         *mBytes;

// Adv count
@property (nonatomic) NSInteger             mRcdAdvCount;

@property (strong,nonatomic) NSNumber       *advCompanyId;
@property (strong,nonatomic) NSNumber       *RSSI;
@property (strong,nonatomic) NSNumber       *mAdvertiseFlags;
@property (strong,nonatomic) NSString       *mDeviceName;
@property (strong,nonatomic) NSString       *mDeviceAddress;
@property (strong,nonatomic) CBPeripheral   *perfipheral;
@property (nonatomic)        NSTimeInterval mLastAdvTime;
@property (strong,nonatomic) NSData         *mManufacturerDataBytes;
@property (nonatomic)        BOOL           isShortPacket;
@property (nonatomic)        BOOL           isLongPacketAvailable;

@property (strong,nonatomic) NSNumber       *maxTemperature;
@property (strong,nonatomic) NSNumber       *minTemperature;
@property (strong,nonatomic) NSNumber       *currentTemperature;
@property (strong,nonatomic) NSNumber       *transmittedAdvCount;
@property (nonatomic)        BOOL           blinkOnAdv;
@property (nonatomic)        float          batteryVoltage;
@property (strong,nonatomic) NSNumber       *hwVersion;
@property (strong,nonatomic) NSNumber       *fwVersion;
@property (nonatomic)        BOOL           state;
@property (nonatomic)        BOOL           stateChange;
@property (strong,nonatomic) NSNumber       *channel;
@property (strong,nonatomic) NSNumber       *advPeriod;
@property (strong,nonatomic) NSNumber       *advRatio;
@property (strong,nonatomic) NSNumber       *blinkPeriod;
@property (strong,nonatomic) NSNumber       *bootCount;

//Colors that can be blink on the Visybl
@property (nonatomic)        BlinkColors    blinkColor;

//Last significant changes time with Timeinterval
@property (nonatomic)        NSTimeInterval mlastSignificantChangeAt;

//TRUE if some Significant Change happened
@property (nonatomic)        BOOL           mSignificantChange;

+ (VSVisybl *)beaconWithAdvertismentDataDictionary:(NSDictionary *)dictionary
                                    withPeripheral:(CBPeripheral*)peripheral
                                          withRSSI:(NSNumber*)rssi;
- (void)newAdvert:(VSVisybl*)vis;

//Get
- (NSInteger)getTxPowerDbm;
- (NSInteger)getAdvPeriodMillis;
- (NSInteger)getBatteryPercent;
- (NSData*)getLastLongPacketBytes;
- (NSString*)getRawData;

//Helpers
- (BOOL)isBeacon;

@end
