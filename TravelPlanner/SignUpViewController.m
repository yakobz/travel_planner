//
//  SignUpViewController.m
//  TravelPlanner
//
//  Created by Yakov on 5/15/15.
//  Copyright (c) 2015 yakov. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>

@interface SignUpViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if([identifier isEqualToString:@"logInSegue"]) {
        return [self canGoToNextScreen];
    }
    return YES;
}

- (BOOL)canGoToNextScreen {
    if([self.usernameTextField.text isEqualToString:@""] ||
       [self.passwordTextField.text isEqualToString:@""]) {
        return NO;
    }
    
    //check if user already exists
    PFQuery *query = [PFUser query];
    [query whereKey:@"username" equalTo:self.usernameTextField.text];
    
    if([query countObjects] != 0) {
        self.usernameTextField.text = @"";
        self.passwordTextField.text = @"";
        self.usernameTextField.placeholder = @"User exists!";
        return NO;
    }
    
    PFUser *user = [PFUser user];
    
    user.username = self.usernameTextField.text;
    user.password = self.passwordTextField.text;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(!succeeded) {
            //create pop-up window: mistake
        }
    }];

    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)endEditingUsername:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)endEditingPassword:(id)sender {
    [self.view endEditing:YES];
}


@end
