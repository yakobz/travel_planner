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

@end

@implementation TripsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) viewWillAppear:(BOOL)animated {
    PFQuery *query = [PFQuery queryWithClassName:@"Trips"];
    [query fromLocalDatastore];
    [query whereKeyExists:@"destination"];
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

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
