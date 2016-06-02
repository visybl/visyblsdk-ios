//
//  VSVisyblDataController.h
//  VisyblSDK
//


#import <Foundation/Foundation.h>

@interface VSVisyblDataController : NSObject

//Singlton
+(VSVisyblDataController *)sharedVisyblData;

@property (nonatomic, strong) NSMutableArray* visyblArray;

-(void)resetViyblsList;

//Visybl
- (void)connectToVisyblAtIndex:(NSInteger)index;

@end
