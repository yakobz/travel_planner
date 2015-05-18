//
//  TripViewController.h
//  TravelPlanner
//
//  Created by Yakov on 5/17/15.
//  Copyright (c) 2015 yakov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface TripViewController : UIViewController

@property (strong, nonatomic) PFObject *tripData;

@end
