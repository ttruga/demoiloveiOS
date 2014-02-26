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
-(void)BMLocationIsUnknown:(CLBeacon *)beacon;
-(void)BMLocationIsFar:(CLBeacon *)beacon;
-(void)BMLocationIsNear:(CLBeacon *)beacon;
-(void)BMLocationIsInmediate:(CLBeacon *)beacon;
@end


@interface BeaconManager : NSObject <CLLocationManagerDelegate>

+ (BeaconManager *)sharedInstance;

@property(weak) id<BeaconManagerDelegate> delegate;

-(void) initialize;
-(void) useRegionForBeacon:(NSDictionary*)beacon;

@end
