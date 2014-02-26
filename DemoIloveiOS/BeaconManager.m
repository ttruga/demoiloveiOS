//
//  BeaconManager.m
//  DemoIloveiOS
//
//  Created by Pablo Castro on 1/7/14.
//  Copyright (c) 2014 witty. All rights reserved.
//

#import "BeaconManager.h"

//Aqui implementar el protocolo para recibir las notificaciones locales



@interface BeaconManager (){
    
    CLLocationManager *_locationManager;
    
}
@end


@implementation BeaconManager

+ (BeaconManager *)sharedInstance
{
    static BeaconManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[BeaconManager alloc] init];
    });
    return sharedInstance;
}

#pragma mark - Initializacion

-(void)initialize{

    NSLog(@"Beacon Manager start...");
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;

}


-(void) useRegionForBeacon:(NSDictionary*)beacon{

    NSLog(@"useRegionForBeacon...%@", beacon);
    
    NSString * UUID       = [beacon objectForKey:@"uuid"];
    NSString * identifier = [beacon objectForKey:@"identifier"];
    
    CLBeaconRegion * region;
    
    /* These are the info for 3 different beacons with same UUID, differing from major and minor number
     "CLBeacon (uuid:<__NSConcreteUUID 0x17d492f0> B9407F30-F5F8-466E-AFF9-25556B57FE6D, major:35483, minor:12080, proximity:2 +/- 0.56m, rssi:-68)",
     "CLBeacon (uuid:<__NSConcreteUUID 0x17d65c80> B9407F30-F5F8-466E-AFF9-25556B57FE6D, major:34923, minor:36339, proximity:2 +/- 0.76m, rssi:-74)",
     "CLBeacon (uuid:<__NSConcreteUUID 0x17d49dc0> B9407F30-F5F8-466E-AFF9-25556B57FE6D, major:39620, minor:34124, proximity:2 +/- 0.89m, rssi:-77)"
     */
    
    region = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:UUID]
                                                identifier:identifier];
    /* You can also use this method*/
//    region = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:UUID]
//                                                     major:35483
//                                                     minor:12080
//                                                identifier:identifier];
    
    region.notifyEntryStateOnDisplay = YES;
    
    /*
     Check on this code that ranging a region and monitoring a region is quite different.
     */
    
    //Assuring that we are monitoring only one region at a time
    NSLog(@"Removing %d regions",[[_locationManager monitoredRegions] count] );
    for (CLBeaconRegion * reg in [_locationManager monitoredRegions])
    {
        //CHECK THIS OUT!!! monitoring a region
        [_locationManager stopMonitoringForRegion:reg];
    }
    NSLog(@"Monitoring %d regions",[[_locationManager monitoredRegions] count] );
    
    
    
    //Assuring that we are ranging only one region at a time
    NSLog(@"Removing %d regions",[[_locationManager rangedRegions] count] );
    for (CLBeaconRegion * reg in [_locationManager rangedRegions])
    {
        //CHECK THIS OUT!!! ranging a region
        [_locationManager stopRangingBeaconsInRegion:reg];
    }
    NSLog(@"Ranging %d regions",[[_locationManager monitoredRegions] count] );
    
    
    [_locationManager    startMonitoringForRegion:region];
    [_locationManager  stopRangingBeaconsInRegion:region];
    [_locationManager startRangingBeaconsInRegion:region];

}

#pragma mark - Location Manager

- (void)locationManager:(CLLocationManager *)manager
      didDetermineState:(CLRegionState)state
              forRegion:(CLRegion *)region
{
    
    if(state == CLRegionStateInside)
    {
        NSLog(@"locationManager didDetermineState INSIDE for %@", region.identifier);
    }
    else if(state == CLRegionStateOutside)
    {
        NSLog(@"locationManager didDetermineState OUTSIDE for %@", region.identifier);
    }
    else
    {
        NSLog(@"locationManager didDetermineState OTHER for %@", region.identifier);
    }
    
}


- (void)locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons
               inRegion:(CLBeaconRegion *)region
{
    
    NSLog(@"Detected beacons: %@", beacons);
    NSLog(@"in region: %@", region);
    
    
    if ([beacons count] > 0) {
        
        CLBeacon * beacon = [[CLBeacon alloc] init];
    
        beacon = [beacons objectAtIndex:0];
    
        NSString * proximity;
    
    
        switch (beacon.proximity) {
            
            case CLProximityUnknown:
            
                proximity = @"Unknown Proximity";
                [self.delegate BMLocationIsUnknown:beacon];
            
                break;
            
            case CLProximityImmediate:
            
                proximity = @"Immediate";
                [self.delegate BMLocationIsInmediate:beacon];
            
                break;
            
            case CLProximityNear:
            
                proximity = @"Near";
                [self.delegate BMLocationIsNear:beacon];
            
                break;
            
            case CLProximityFar:
            
                proximity = @"Far";
                [self.delegate BMLocationIsFar:beacon];
            
                break;
            
            default:
                break;
        }
    
        NSLog(@"The beacon is %@", proximity);
    }
}

@end
