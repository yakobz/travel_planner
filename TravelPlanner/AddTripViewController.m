//
//  AddTripViewController.m
//  TravelPlanner
//
//  Created by Yakov on 5/16/15.
//  Copyright (c) 2015 yakov. All rights reserved.
//

#import "AddTripViewController.h"
#import <Parse/Parse.h>

@interface AddTripViewController ()

@property (weak, nonatomic) IBOutlet UITextField *destinationTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *startDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDatePicker;
@property (weak, nonatomic) IBOutlet UITextField *commentTextField;

@end

@implementation AddTripViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if([identifier isEqualToString:@"addNewTripSegue"]) {
        return [self canGoToNextScreen];
    }
    return YES;
}

- (BOOL)canGoToNextScreen {
    if([self.destinationTextField.text isEqualToString:@""]) {
        return NO;
    }
    
    PFUser *currentUser = [PFUser currentUser];
    NSLog(@"%@", currentUser.username);
    
    PFObject *trips = [PFObject objectWithClassName:@"Trips"];
    trips[@"destination"] = self.destinationTextField.text;
    trips[@"start_date"] = self.startDatePicker.date;
    trips[@"end_date"] = self.endDatePicker.date;
    trips[@"comment"] = self.commentTextField.text;
    
    [trips pin];
    [trips saveEventually];
    
    return YES;
}

@end
