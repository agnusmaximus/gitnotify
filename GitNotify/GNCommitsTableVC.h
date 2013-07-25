//
//  GNCommitsTableVC.h
//  GitNotify
//
//  Created by Max Lam on 7/24/13.
//  Copyright (c) 2013 Max Lam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "GNCommitsTableHeader.h"
#import "GNCommitsVC.h"
#import "GNCommitsTableCell.h"

@class GNCommitsVC;

@interface GNCommitsTableVC : UITableViewController

@property (nonatomic, strong) NSArray *commits;
@property (nonatomic, weak) GNCommitsVC *delegate;
@property (nonatomic, strong) NSString *repoName;

-(void)back;

@end
