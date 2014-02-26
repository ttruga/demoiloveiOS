//
//  BeaconManager.h
//  DemoIloveiOS
//
//  Created by Pablo Castro on 1/7/14.
//  Copyright (c) 2014 witty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@protocol BeaconManagerDelegate <NSObject>

@optional
-(void)BMLocationUnknown:(NSString *)proximity;
-(void)BMLocationFar:(NSString *)proximity;
-(void)BMLocationNear:(NSString *)proximity;
-(void)BMLocationInmediate:(NSString *)proximity;
@end


@interface BeaconManager : NSObject <CLLocationManagerDelegate>

+ (BeaconManager *)sharedInstance;

@property(weak) id<BeaconManagerDelegate> delegate;

-(void) initialize;
-(void) useRegionForBeacon:(NSDictionary*)beacon;

@end
