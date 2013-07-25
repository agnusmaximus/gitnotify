//
//  GNRepoTableCell.h
//  GitNotify
//
//  Created by Max Lam on 7/22/13.
//  Copyright (c) 2013 Max Lam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GNRepoTableCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *repoName;
@property (nonatomic, strong) IBOutlet UILabel *unseen;

@end
