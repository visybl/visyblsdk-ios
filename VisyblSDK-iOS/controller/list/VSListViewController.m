//
//  VSListViewController.m
//  VisyblSDK
//


#import "VSListViewController.h"
#import <VisyblSDK/VisyblSDK.h>

/* view */
#import "VSVisyblTableViewCell.h"

/* controller */

/* data */
#import "VSVisyblDataController.h"

@interface VSListViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation VSListViewController
{
    __weak IBOutlet UITableView *visyblsTableView;
    
    VSVisyblDataController *visybData;
    NSInteger currentIndex;
    UIRefreshControl *refreshControl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    visybData = [VSVisyblDataController sharedVisyblData];
    
    // Add refresh control
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Refresh", nil)];
    [refreshControl addTarget:self action:@selector(refreshUI) forControlEvents:UIControlEventValueChanged];
    [visyblsTableView addSubview:refreshControl];
    [refreshControl endRefreshing];
    
    //Add observer on near me assets
    [[NSNotificationCenter defaultCenter] addObserver:visyblsTableView selector:@selector(reloadData) name:SCANNER_DID_DISCOVER_VISYBL_NOTIFICATION object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Datasource -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return visybData.visyblArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"visybl";
    
    VSVisyblTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    VSVisybl *visybl = visybData.visyblArray[indexPath.row];
    cell.deviceName.text = visybl.mDeviceName;
    
    cell.rssi.text = visybl.RSSI.stringValue;
    cell.rssiIcon.image = [UIImage imageNamed:[self getRssiIcon:visybl.RSSI.integerValue]];
    cell.received.text = [NSString stringWithFormat:@"%@", @(visybl.mRcdAdvCount)];

    //Arun - Mar 13 - Added to show state in tableview by making it bold
    
    if (visybl.state) {
        cell.deviceName.font = [UIFont boldSystemFontOfSize:22];

    } else {
        cell.deviceName.font = [UIFont systemFontOfSize:22];
    }
    
    cell.temperature.text = [NSString stringWithFormat:@"%@ C", visybl.currentTemperature];
    cell.battery.text = @(visybl.getBatteryPercent).stringValue;
    cell.batteryIcon.image = [UIImage imageNamed:[self getBatteryIcon:visybl.getBatteryPercent]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    currentIndex = indexPath.row;
    [self performSegueWithIdentifier:Storyboard_Seque_Details sender:self];
}

- (NSString *)tableView:(UITableView *)resultTableView titleForHeaderInSection:(NSInteger)section
{
    NSString *str=[NSString stringWithFormat:@"%lu",(unsigned long)[visybData.visyblArray count]];
    [[UILabel appearanceWhenContainedInInstancesOfClasses:@[[UITableViewHeaderFooterView class]]] setTextAlignment:NSTextAlignmentCenter];
    str=[str stringByAppendingString:@" beacons found"];
    return str;
}

#pragma mark - Refresh -

-(void)refreshUI
{
    [visybData resetViyblsList];
    [visyblsTableView reloadData];
    [refreshControl endRefreshing];
}


#pragma mark - Helpers -

-(NSString*)getBatteryIcon:(NSInteger)level
{
    if (level > 75)
    {
        return @"stat_sys_battery_100";
    }
    else if (level > 50)
    {
        return @"stat_sys_battery_71";
    }
    else if (level > 25)
    {
        return @"stat_sys_battery_43";
    }
    else
    {
        return @"stat_sys_battery_10";
    }
}

-(NSString*)getRssiIcon:(NSInteger)level
{
    if (level > -40 )
    {
        return @"stat_sys_signal_4_cdma";
    }
    else if (level > -45)
    {
        return @"stat_sys_signal_3_cdma";
    }
    else if (level > -55)
    {
        return @"stat_sys_signal_2_cdma";
    }
    else if (level > -75)
    {
        return @"stat_sys_signal_1_cdma";
    }
    else
    {
        return @"stat_sys_signal_0_cdma";
    }
}


#pragma mark - Navigation




@end
