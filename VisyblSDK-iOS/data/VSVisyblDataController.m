//
//  VSVisyblDataController.m
//  VisyblSDK
//


#import "VSVisyblDataController.h"
#import <VisyblSDK/VisyblSDK.h>

/* utils */
#import "VSConstants.h"

@implementation VSVisyblDataController
{
    VSVisyblScanner *visyblScanner;
    NSMutableDictionary *visyblDictionary;
}

+(VSVisyblDataController *)sharedVisyblData
{
    static VSVisyblDataController *sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[VSVisyblDataController alloc] init];
    });
    return sharedManager;
}

-(id)init
{
    self = [super init];
    if (self)
    {
        _visyblArray = [NSMutableArray array];
        visyblDictionary = [NSMutableDictionary dictionary];
        
        visyblScanner = [VSVisyblScanner runVisyblScanner];
        [self setupScannerHandlers];
    }
    
    return self;
}

#pragma mark - Scanner -

- (void)setupScannerHandlers
{
    __weak typeof(self.visyblArray) weakVisyblArray = self.visyblArray;
    __weak typeof(visyblDictionary) weakVisyblDictionary = visyblDictionary;
    [visyblScanner setDidDiscoverVisybl:^(VSVisybl *visybl) {
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            VSVisybl *scannedVisybl = [weakVisyblDictionary valueForKey:visybl.mDeviceName];
            if (scannedVisybl)
            {
                [scannedVisybl newAdvert:visybl];
            }
            else
            {
                [weakVisyblDictionary setObject:visybl forKey:visybl.mDeviceName];
                scannedVisybl = visybl;
            }
            
            if (![weakVisyblArray containsObject:scannedVisybl])
            {
                [weakVisyblArray addObject:scannedVisybl];
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:SCANNER_DID_DISCOVER_VISYBL_NOTIFICATION object:nil userInfo:@{@"visybl":scannedVisybl}];
        }];
    }];
}

- (void)connectToVisyblAtIndex:(NSInteger)index
{
    VSVisybl *vis = self.visyblArray[index];
    if (vis.blinkOnAdv)
    {
        [visyblScanner connectVisybl:self.visyblArray[index]];
    }
}

-(void)resetViyblsList
{
    [_visyblArray removeAllObjects];
    [visyblDictionary removeAllObjects];
}

@end
