//
//  ViewController.m
//  DemoIloveiOS
//
//  Created by Pablo Castro on 2/26/14.
//  Copyright (c) 2014 witty. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    BeaconManager * BM = [BeaconManager sharedInstance];
    BM.delegate = self; 
    [BM initialize];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)justSelectedBeacon:(id)sender {
    
    
    BeaconManager * BM = [BeaconManager sharedInstance];
    
    NSDictionary * greengecko = @{ @"uuid" : UUID_BEACON_1, @"identifier" : @"Green Gecko"};
    NSDictionary * rasppi     = @{ @"uuid" : UUID_BEACON_2, @"identifier" : @"Rasp Pi"};
    
    NSString * beaconName;
    
    UISegmentedControl * scontrol = (UISegmentedControl *) sender;
    
    switch (scontrol.selectedSegmentIndex) {
        
        case 0:
            
            beaconName = [greengecko objectForKey:@"identifier"];
            NSLog(@"%@", beaconName);
            self.beaconName.text = beaconName;
            [BM useRegionForBeacon:greengecko];
            
            break;
            
        case 1:
            
            beaconName = [rasppi objectForKey:@"identifier"];
            NSLog(@"%@", beaconName);
            self.beaconName.text = beaconName;
            [BM useRegionForBeacon:rasppi];
            
            break;
            
        default:
            break;
    }
    
}


#pragma mark - BeaconDelegate

-(void)BMLocationIsFar:(CLBeacon *)beacon{
   
    self.beaconStatus.text = @"FAR";
    self.beaconRange.text = [NSString stringWithFormat:@"%d", beacon.rssi];

}

-(void) BMLocationIsNear:(CLBeacon *)beacon{

    self.beaconStatus.text = @"NEAR";
    self.beaconRange.text = [NSString stringWithFormat:@"%d", beacon.rssi];
    
}

-(void) BMLocationIsInmediate:(CLBeacon *)beacon {

    self.beaconStatus.text = @"INMEDIATE";
    self.beaconRange.text = [NSString stringWithFormat:@"%d", beacon.rssi];

}

-(void) BMLocationIsUnknown:(CLBeacon *)beacon{

    self.beaconStatus.text = @"UNKNOWN";
    self.beaconRange.text = [NSString stringWithFormat:@"%d", beacon.rssi];

}



@end
