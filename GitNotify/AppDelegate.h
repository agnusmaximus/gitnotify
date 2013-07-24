//
//  AppDelegate.h
//  GitNotify
//
//  Created by Max Lam on 7/22/13.
//  Copyright (c) 2013 Max Lam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GNGithubApi.h"
#import "GNRepoVC.h"
#import "GNDatabaseAPI.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UINavigationControllerDelegate> {
    GNRepoVC *repoVC;
}

@property (strong, nonatomic) UIWindow *window;

-(void)updateDatabase;

@end
