//
//  GNCommitsVC.h
//  GitNotify
//
//  Created by Max Lam on 7/23/13.
//  Copyright (c) 2013 Max Lam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GNDatabaseAPI.h"
#import "GNGithubApi.h"
#import "GNCommitsTableVC.h"

@class GNCommitsTableVC;

@interface GNCommitsVC : UIViewController

@property (nonatomic, strong) NSString *repositoryId;
@property (nonatomic, strong) NSDictionary *commits;
@property (nonatomic, strong) GNCommitsTableVC *commitsVC;
@property (nonatomic, strong) NSTimer *updateTimer;

-(void)setRepoId:(NSString *)repoId;
-(void)setRepoName:(NSString *)repoName;

@end
