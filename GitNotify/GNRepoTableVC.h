//
//  GNRepoTableVC.h
//  GitNotify
//
//  Created by Max Lam on 7/22/13.
//  Copyright (c) 2013 Max Lam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GNGithubApi.h"
#import "GNRepoTableCell.h"

@interface GNRepoTableVC : UITableViewController

@property (nonatomic, strong) NSDictionary *repos;
@property (nonatomic, strong) NSMutableArray *repoNames;

@end
