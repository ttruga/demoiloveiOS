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
    
    UISegmentedControl * scontrol = (UISegmentedControl *) sender;
    
    switch (scontrol.selectedSegmentIndex) {
        
        case 0:
            
            NSLog(@"Green Gecko");
            [BM useRegionForBeacon:greengecko];
            
            break;
            
        case 1:
            
            NSLog(@"Rasp-PI");
            [BM useRegionForBeacon:rasppi];
            
            break;
            
        default:
            break;
    }
    
}

@end
