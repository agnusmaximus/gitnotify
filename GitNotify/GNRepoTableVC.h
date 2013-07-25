//
//  GNRepoTableVC.h
//  GitNotify
//
//  Created by Max Lam on 7/22/13.
//  Copyright (c) 2013 Max Lam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "GNGithubApi.h"
#import "GNRepoTableCell.h"
#import "GNRepoTableHeader.h"
#import "GNCommitsVC.h"
#import "GNRepoVC.h"

@class GNRepoVC;

@interface GNRepoTableVC : UITableViewController

@property (nonatomic, strong) NSMutableArray *watched;
@property (nonatomic, strong) NSMutableArray *repoNames;
@property (nonatomic, strong) NSMutableArray *repoIds;
@property (nonatomic, strong) NSMutableArray *unseenRepoIds;
@property (nonatomic, weak) GNRepoVC *delegate;

-(void)back;

@end
