//
//  StartViewController.m
//  ParseStarterProject
//
//  Created by Yakov on 5/12/15.
//
//

#import "StartViewController.h"
#import <Parse/Parse.h>

@interface StartViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    NSError *error;
    
    [PFUser logInWithUsername:self.usernameTextField.text
                     password:self.passwordTextField.text
                        error:&error];
    
    
    if([[error userInfo][@"code"] isEqual:@101]) {
        self.usernameTextField.text = @"";
        self.passwordTextField.text = @"";
        self.usernameTextField.placeholder = @"User not exist!";
        self.passwordTextField.placeholder = @"or password is incorrect!";
    }
    
    if([self.usernameTextField.text isEqualToString:@""] ||
       [self.passwordTextField.text isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

- (IBAction)endEditingUsername:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)endEditingPassword:(id)sender {
    [self.view endEditing:YES];
}

@end
