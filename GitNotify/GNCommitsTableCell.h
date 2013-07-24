//
//  GNCommitsTableCell.h
//  GitNotify
//
//  Created by Max Lam on 7/24/13.
//  Copyright (c) 2013 Max Lam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GNCommitsTableCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *messageLabel;
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *dateLabel;

@end
