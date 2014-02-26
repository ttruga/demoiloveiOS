//
//  ViewController.h
//  DemoIloveiOS
//
//  Created by Pablo Castro on 2/26/14.
//  Copyright (c) 2014 witty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BeaconManager.h"


#define UUID_BEACON_1 @"B9407F30-F5F8-466E-AFF9-25556B57FE6D" //GREEN GECKO
#define UUID_BEACON_2 @"74278BDA-B644-4520-8F0C-720EAF059935" //RASPBERRY PI

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UISegmentedControl *beaconSelector;
@property (strong, nonatomic) IBOutlet UILabel *beaconName;
@property (strong, nonatomic) IBOutlet UILabel *beaconRange;

- (IBAction)justSelectedBeacon:(id)sender;

@end
