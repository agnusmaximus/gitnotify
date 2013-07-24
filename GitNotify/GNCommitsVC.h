//
//  GNCommitsVC.h
//  GitNotify
//
//  Created by Max Lam on 7/23/13.
//  Copyright (c) 2013 Max Lam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GNDatabaseAPI.h"

@interface GNCommitsVC : UIViewController

@property (nonatomic, strong) NSString *repositoryId;
@property (nonatomic, strong) NSDictionary *commits;

-(void)setRepoId:(NSString *)repoId;

@end
