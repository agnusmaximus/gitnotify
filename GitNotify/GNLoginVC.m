//
//  GNLoginVC.m
//  GitNotify
//
//  Created by Max Lam on 7/24/13.
//  Copyright (c) 2013 Max Lam. All rights reserved.
//

#import "GNLoginVC.h"

@interface GNLoginVC ()

@end

@implementation GNLoginVC

/* Method initWithNibName
 * ----------------------------
 * Custom init here
 */
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

/* Method textFieldShouldReturn
 * ---------------------------------
 * Delegate method for ui text fields.
 * Removes keyboard from view
 */
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

/* Method performLogin
 * ----------------------------
 * Performs login -- when login
 * button is pressed.
 */
-(IBAction)performLogin:(id)sender {
    
    //Make sure neither fields are empty
    if (![self.login.text isEqualToString:@""] &&
        ![self.password.text isEqualToString:@""]) {

        //Login
        [self.delegate login:self.login.text andPassword:self.password.text];
        [self.delegate transitionToRepositories];
        
        //Save data
        [[NSUserDefaults standardUserDefaults] setObject:self.login.text forKey:@"uname"];
        [[NSUserDefaults standardUserDefaults] setObject:self.password.text forKey:@"pword"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    //Set text field to password field
    self.password.secureTextEntry = YES;
    
    //check if logged in
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"uname"] != nil &&
        [[NSUserDefaults standardUserDefaults] stringForKey:@"pword"] != nil) {
        self.login.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"uname"];
        self.password.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"pword"];
        [self performLogin:nil];
    }
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
