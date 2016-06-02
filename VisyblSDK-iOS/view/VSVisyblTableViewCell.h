//
//  VSVisyblTableViewCell.h
//  VisyblSDK
//
//  Created by GeghamHarutyunyan on 2/22/16.
//  Copyright © 2016 WAY4APP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VSVisyblTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *deviceName;
@property (weak, nonatomic) IBOutlet UILabel *temperature;
@property (weak, nonatomic) IBOutlet UIImageView *rssiIcon;
@property (weak, nonatomic) IBOutlet UILabel *rssi;
@property (weak, nonatomic) IBOutlet UIImageView *batteryIcon;
@property (weak, nonatomic) IBOutlet UILabel *battery;
@property (weak, nonatomic) IBOutlet UILabel *received;

@end
