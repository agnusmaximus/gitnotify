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
    }
}

-(void)viewDidLoad {
    [super viewDidLoad];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
