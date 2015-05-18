//
//  TripsTableViewController.m
//  TravelPlanner
//
//  Created by Yakov on 5/16/15.
//  Copyright (c) 2015 yakov. All rights reserved.
//

#import "TripsTableViewController.h"
#import "TripViewController.h"
#import <Parse/Parse.h>

@interface TripsTableViewController ()

@property (strong, nonatomic) NSArray *tripsData;
@property (weak, nonatomic) PFObject *tripData;
@property (strong, nonatomic) NSString *filterKey;
@property (strong, nonatomic) id filterData;

@end

@implementation TripsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.filterData = nil;
    self.filterKey = nil;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filters"
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(filterPush)];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) viewWillAppear:(BOOL)animated {
    PFQuery *query = [PFQuery queryWithClassName:@"Trips"];
    [query fromLocalDatastore];
    
    if([self.filterKey isEqualToString:@"destination"]) {
        [query whereKey:@"destination" equalTo:self.filterData];
    } else {
        [query whereKeyExists:@"destination"];
    }
    
    self.filterData = nil;
    self.filterKey = nil;
    
    self.tripsData = [query findObjects];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tripsData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *tableIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier forIndexPath:indexPath];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    
    NSString *text = [self.tripsData[indexPath.row] objectForKey:@"destination"];
    NSDate *startDate = [self.tripsData[indexPath.row] objectForKey:@"start_date"];
    NSTimeInterval count = [startDate timeIntervalSinceNow];
    if(count <= 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@: trip already was!", text];
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"%@: %f", text, count];
    }
    
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"tripDataSegue"]) {
        TripViewController *trip = (TripViewController*)segue.destinationViewController;
        trip.tripData = self.tripData;
    }
}

- (NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.tripData = self.tripsData[indexPath.row];
    [self performSegueWithIdentifier:@"tripDataSegue" sender:self];
    
    return indexPath;
}

- (void)filterPush {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Filters"
                                                    message:@"Filter by:"
                                                   delegate:self
                                          cancelButtonTitle:@"cancel"
                                          otherButtonTitles:@"destination", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if([alertView.title isEqualToString:@"Filters"]) {
        if(buttonIndex == 1) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Destination filter"
                                                            message:@"Enter destination"
                                                           delegate:self
                                                  cancelButtonTitle:@"cancel"
                                                  otherButtonTitles:@"ok", nil];
            alert.alertViewStyle = UIAlertViewStylePlainTextInput;
            [alert show];
        }
    } else if([alertView.title isEqualToString:@"Destination filter"]) {
        self.filterKey = @"destination";
        self.filterData = [alertView textFieldAtIndex:0].text;
        [self viewWillAppear:YES];
    }
}


@end
