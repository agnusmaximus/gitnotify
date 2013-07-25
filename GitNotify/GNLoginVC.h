//
//  GNLoginVC.h
//  GitNotify
//
//  Created by Max Lam on 7/24/13.
//  Copyright (c) 2013 Max Lam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@class AppDelegate;

@interface GNLoginVC : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITextField *login;
@property (nonatomic, strong) IBOutlet UITextField *password;
@property (nonatomic, strong) IBOutlet UIButton *loginButton;
@property (nonatomic, weak) AppDelegate *delegate;

-(IBAction)performLogin:(id)sender;

@end
