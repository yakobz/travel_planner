//
//  TripViewController.m
//  TravelPlanner
//
//  Created by Yakov on 5/17/15.
//  Copyright (c) 2015 yakov. All rights reserved.
//

#import "TripViewController.h"

@interface TripViewController ()

@property (weak, nonatomic) IBOutlet UITextField *destinationTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *startDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDatePicker;
@property (weak, nonatomic) IBOutlet UITextField *commentTextField;


@end

@implementation TripViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.destinationTextField.text = [self.tripData objectForKey:@"destination"];
    self.startDatePicker.date = [self.tripData objectForKey:@"start_date"];
    self.endDatePicker.date = [self.tripData objectForKey:@"end_date"];
    self.commentTextField.text = [self.tripData objectForKey:@"comment"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editingEnd:(id)sender {
    [self.tripData setObject:self.destinationTextField.text forKey:@"destination"];
    [self.tripData setObject:self.startDatePicker.date forKey:@"start_date"];
    [self.tripData setObject:self.endDatePicker.date forKey:@"end_date"];
    [self.tripData setObject:self.commentTextField.text forKey:@"comment"];

    [self.tripData pin];
    [self.tripData saveEventually];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)delete:(id)sender {
    [self.tripData unpin];
    [self.tripData deleteEventually];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
